// Smooth scroll pour l'indicateur de défilement
document.querySelector('.scroll-indicator').addEventListener('click', () => {
    document.querySelector('#horaires').scrollIntoView({ behavior: 'smooth' });
});

// Gestion de la navbar active en fonction du scroll
const sections = document.querySelectorAll('section[id]');
const navLinks = document.querySelectorAll('.nav-link');

function updateActiveNav() {
    let current = '';

    sections.forEach(section => {
        const sectionTop = section.offsetTop;
        const sectionHeight = section.clientHeight;

        if (window.pageYOffset >= sectionTop - 100) {
            current = section.getAttribute('id');
        }
    });

    navLinks.forEach(link => {
        link.classList.remove('active');
        if (link.getAttribute('href') === `#${current}`) {
            link.classList.add('active');
        }
    });
}

window.addEventListener('scroll', updateActiveNav);

// Smooth scroll pour tous les liens de navigation sans modifier l'URL
navLinks.forEach(link => {
    link.addEventListener('click', (e) => {
        const href = link.getAttribute('href');
        if (href.startsWith('#')) {
            e.preventDefault();
            const target = document.querySelector(href);
            if (target) {
                target.scrollIntoView({ behavior: 'smooth' });
                // Empêcher l'ajout du # dans l'URL
                history.pushState(null, null, ' ');
            }
        }
    });
});