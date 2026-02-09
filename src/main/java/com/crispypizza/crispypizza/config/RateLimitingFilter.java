package com.crispypizza.crispypizza.config;

import io.github.bucket4j.Bandwidth;
import io.github.bucket4j.Bucket;
import io.github.bucket4j.Refill;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.time.Duration;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Component
public class RateLimitingFilter extends OncePerRequestFilter
{
    // Stockage des buckets par adresse IP
    private final Map<String, Bucket> buckets = new ConcurrentHashMap<>();

    // Configuration : 100 requêtes par minute par IP
    private static final int REQUESTS_PER_MINUTE = 50;

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException
    {
        // Exclure les ressources statiques du rate limiting
        String path = request.getRequestURI();
        if (isStaticResource(path))
        {
            filterChain.doFilter(request, response);
            return;
        }

        String clientIp = getClientIP(request);
        Bucket bucket = buckets.computeIfAbsent(clientIp, this::createNewBucket);

        if (bucket.tryConsume(1))
        {
            // Requête autorisée
            filterChain.doFilter(request, response);
        }
        else
        {
            // Trop de requêtes - erreur 429
            response.setStatus(HttpStatus.TOO_MANY_REQUESTS.value());

            // Réponse JSON pour les API, HTML sinon
            if (path.startsWith("/api/"))
            {
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write("{\"error\": \"Trop de requêtes. Réessayez plus tard.\"}");
            }
            else
            {
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().write("<h1>Trop de requêtes</h1><p>Veuillez réessayer dans quelques instants.</p>");
            }
        }
    }

    private boolean isStaticResource(String path)
    {
        return path.startsWith("/css/") ||
               path.startsWith("/js/") ||
               path.startsWith("/images/") ||
               path.startsWith("/fonts/") ||
               path.endsWith(".css") ||
               path.endsWith(".js") ||
               path.endsWith(".png") ||
               path.endsWith(".jpg") ||
               path.endsWith(".jpeg") ||
               path.endsWith(".gif") ||
               path.endsWith(".ico") ||
               path.endsWith(".woff") ||
               path.endsWith(".woff2");
    }

    private Bucket createNewBucket(String ip)
    {
        // 100 requêtes par minute, rechargement progressif
        Bandwidth limit = Bandwidth.classic(REQUESTS_PER_MINUTE,
                Refill.greedy(REQUESTS_PER_MINUTE, Duration.ofMinutes(1)));

        return Bucket.builder()
                .addLimit(limit)
                .build();
    }

    private String getClientIP(HttpServletRequest request)
    {
        // Vérifie les headers de proxy (si derrière Nginx, etc.)
        String xForwardedFor = request.getHeader("X-Forwarded-For");
        if (xForwardedFor != null && !xForwardedFor.isEmpty())
        {
            return xForwardedFor.split(",")[0].trim();
        }
        return request.getRemoteAddr();
    }
}
