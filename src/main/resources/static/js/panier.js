// Fonction pour mettre à jour le compteur du panier dans la navbar
function mettreAJourCompteurPanier() {
    let panier = JSON.parse(sessionStorage.getItem('panier')) || [];
    let totalArticles = panier.reduce((sum, item) => sum + item.quantite, 0);

    let compteur = document.getElementById('panier-compteur');
    if (compteur) {
        compteur.textContent = totalArticles;
        if (totalArticles > 0) {
            compteur.classList.add('show');
        } else {
            compteur.classList.remove('show');
        }
    }
}

// Initialiser le compteur au chargement de la page
document.addEventListener('DOMContentLoaded', mettreAJourCompteurPanier);
