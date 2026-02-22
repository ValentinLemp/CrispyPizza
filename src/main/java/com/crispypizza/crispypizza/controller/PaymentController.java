package com.crispypizza.crispypizza.controller;

import com.crispypizza.crispypizza.service.CommandeService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/api/payment")
public class PaymentController {

    @Value("${mollie.api-key}")
    private String mollieApiKey;

    @Autowired
    private CommandeService commandeService;

    private final RestTemplate restTemplate = new RestTemplate();
    private static final String MOLLIE_API_URL = "https://api.mollie.com/v2/payments";

    // Générer l'URL de base dynamiquement
    private String getBaseUrl(HttpServletRequest request) {
        String scheme = request.getScheme();
        String serverName = request.getServerName();
        int serverPort = request.getServerPort();

        if ((scheme.equals("http") && serverPort == 80) || (scheme.equals("https") && serverPort == 443)) {
            return scheme + "://" + serverName;
        }
        return scheme + "://" + serverName + ":" + serverPort;
    }

    @PostMapping("/create")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> createPayment(@RequestBody Map<String, Object> request, HttpServletRequest httpRequest, HttpSession session) {
        try {
            // Récupérer les données de la requête
            String total = request.get("total").toString();

            // Formater le montant (2 décimales)
            if (!total.contains(".")) {
                total = total + ".00";
            } else if (total.split("\\.")[1].length() == 1) {
                total = total + "0";
            }

            // Construire la requête pour Mollie
            Map<String, Object> mollieRequest = new HashMap<>();
            mollieRequest.put("amount", Map.of(
                "currency", "EUR",
                "value", total
            ));
            String baseUrl = getBaseUrl(httpRequest);
            mollieRequest.put("description", "Commande CrispyPizza");
            mollieRequest.put("redirectUrl", baseUrl + "/api/payment/success");
            mollieRequest.put("cancelUrl", baseUrl + "/api/payment/cancel");
            mollieRequest.put("metadata", Map.of("restaurant", request.get("restaurant")));

            // Headers
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.setBearerAuth(mollieApiKey);

            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(mollieRequest, headers);

            // Appeler l'API Mollie
            ResponseEntity<Map> response = restTemplate.exchange(
                MOLLIE_API_URL,
                HttpMethod.POST,
                entity,
                Map.class
            );

            Map<String, Object> mollieResponse = response.getBody();

            // Extraire l'URL de checkout
            Map<String, Object> links = (Map<String, Object>) mollieResponse.get("_links");
            Map<String, Object> checkout = (Map<String, Object>) links.get("checkout");
            String checkoutUrl = (String) checkout.get("href");

            String paymentId = (String) mollieResponse.get("id");

            // Stocker le payment ID et les données de commande dans la session
            session.setAttribute("molliePaymentId", paymentId);
            session.setAttribute("paymentData", request);

            Map<String, Object> result = new HashMap<>();
            result.put("checkoutUrl", checkoutUrl);
            result.put("paymentId", paymentId);

            return ResponseEntity.ok(result);

        } catch (Exception e) {
            e.printStackTrace();
            Map<String, Object> error = new HashMap<>();
            error.put("error", e.getMessage());
            return ResponseEntity.badRequest().body(error);
        }
    }

    @GetMapping("/success")
    public String paymentSuccess(@RequestParam(value = "id", required = false) String paymentId, HttpSession session) {
        System.out.println("=== Payment Success Called ===");

        // Récupérer l'ID depuis la session si pas dans l'URL
        if (paymentId == null || paymentId.isEmpty()) {
            paymentId = (String) session.getAttribute("molliePaymentId");
        }

        System.out.println("Payment ID: " + paymentId);

        // Si pas d'ID de paiement, rediriger vers l'accueil
        if (paymentId == null || paymentId.isEmpty()) {
            System.out.println("Pas d'ID de paiement");
            return "redirect:/home";
        }

        try {
            // Vérifier le statut du paiement avec Mollie
            HttpHeaders headers = new HttpHeaders();
            headers.setBearerAuth(mollieApiKey);

            HttpEntity<Void> entity = new HttpEntity<>(headers);

            ResponseEntity<Map> response = restTemplate.exchange(
                MOLLIE_API_URL + "/" + paymentId,
                HttpMethod.GET,
                entity,
                Map.class
            );

            Map<String, Object> payment = response.getBody();
            String status = (String) payment.get("status");
            System.out.println("Statut du paiement: " + status);

            // Seulement afficher succès si le paiement est confirmé
            if ("paid".equals(status)) {
                // Sauvegarder la commande dans le bon schéma
                Map<String, Object> paymentData = (Map<String, Object>) session.getAttribute("paymentData");
                if (paymentData != null) {
                    commandeService.sauvegarderCommande(paymentData);
                }

                // Nettoyer la session
                session.removeAttribute("molliePaymentId");
                session.removeAttribute("paymentData");
                return "payment-success";
            } else {
                System.out.println("Statut non paid, redirection cancel");
                return "redirect:/api/payment/cancel";
            }
        } catch (Exception e) {
            System.out.println("Erreur: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/home";
        }
    }

    @GetMapping("/cancel")
    public String paymentCancel() {
        return "payment-cancel";
    }

    @PostMapping("/webhook")
    @ResponseBody
    public ResponseEntity<String> webhook(@RequestParam("id") String paymentId) {
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setBearerAuth(mollieApiKey);

            HttpEntity<Void> entity = new HttpEntity<>(headers);

            ResponseEntity<Map> response = restTemplate.exchange(
                MOLLIE_API_URL + "/" + paymentId,
                HttpMethod.GET,
                entity,
                Map.class
            );

            Map<String, Object> payment = response.getBody();
            String status = (String) payment.get("status");

            if ("paid".equals(status)) {
                // Récupérer les metadata de la commande depuis Mollie
                Map<String, Object> metadata = (Map<String, Object>) payment.get("metadata");
                if (metadata != null) {
                    try {
                        commandeService.sauvegarderCommande(metadata);
                    } catch (Exception ex) {
                        System.out.println("Commande déjà enregistrée ou erreur: " + ex.getMessage());
                    }
                }
                System.out.println("Paiement réussi pour: " + paymentId);
            }

            return ResponseEntity.ok("OK");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
