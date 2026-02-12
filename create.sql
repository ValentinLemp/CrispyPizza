-- ========================================
-- Création des tables
-- ========================================
create table typeProduit
(
    id serial primary key,
    libelle varchar(20)
);

create table typePate(
    id serial primary key,
    libelle varchar(20) not null
);

create table typePizza(
    id serial primary key,
    libelle varchar(20)
);

create table produit(
    id serial primary key,
    libelle varchar(40),
    description varchar(150),
    quantite integer,
    prix double precision,
    prixLarge double precision,
    centilitre varchar(10),
    urlImage varchar(100),
    idTypePizza integer,
    foreign key (idTypePizza) references typepizza,
    idTypeProduit integer,
    foreign key (idTypeProduit) references typeproduit,
    estSuggestion Boolean
);

create table categorieIngredient
(
    id serial primary key,
    libelle varchar(20)
);

create table ingredient
(
    id serial primary key,
    libelle varchar(40) not null,
    prixMedium double precision not null,
    prixLarge double precision not null,
    forPizza boolean not null,
    forPate boolean not null,
    forSalade boolean not null,
    idCategorieIngredient integer not null ,
    foreign key (idCategorieIngredient) references categorieingredient
);

create table adresse(
    id serial primary key,
    codePostal integer not null,
    nomRue varchar(25) not null,
    numeroRue varchar(10) not null,
    localite varchar(25) not null
);

create table client(
    id serial primary key,
    nom varchar(25) not null,
    prenom varchar(25),
    numero varchar(15) not null,
    idAdresse integer not null,
    foreign key (idAdresse) references adresse
);
create table restaurant(
    id serial primary key,
    nom varchar(20) not null,
    idAdresse integer not null,
    foreign key (idAdresse) references adresse
);

create table statut(
    id serial PRIMARY KEY,
    libelle varchar(15)
);
create table commande(
    id serial PRIMARY KEY,
    nom varchar(25),
    prenom varchar(25),
    estLivraison boolean not null ,
    dateHeure TimeStamp not null ,
    prixTotal double precision not null,
    commetaire varchar(255),
    idRestaurant integer not null,
    foreign key (idrestaurant) references restaurant,
    idStatut integer not null,
    FOREIGN KEY (idstatut) REFERENCES statut,
    idClient integer,
    foreign key (idClient) references client
);

create table ligneCommande(
    id serial primary key,
    prixLigne double precision not null,
    tailleMedium boolean,
    typePate varchar(20),
    note varchar(50),
    idProduit integer,
    foreign key (idProduit) references produit,
    idCommande integer,
    foreign key (idCommande) references commande
);

create table ligneIngrediant
(
    idLigne integer not null ,
    foreign key (idLigne) references  lignecommande,
    idIngredient integer not null ,
    foreign key (idIngredient) references ingredient,
    ingredientEnPlus boolean not null
);

create table utilisateur(
    id serial primary key,
    motdepasse VARCHAR(10),
    idResraurent integer,
    foreign key (idResraurent) references restaurant,
    modeAdmin BOOLEAN not null
);

CREATE TABLE produitIngredient (
    idProduit INTEGER NOT NULL,
    libelle VARCHAR(100) NOT NULL,
    foreign key (idProduit) references produit
);
-- ========================================
-- INSERTION
-- ========================================

INSERT INTO typepizza(libelle) VALUES
('traditionnelle'),
('spécial'),
('blanche'),
('de la mer');

INSERT INTO typePate(libelle) VALUES
('rigatoni'),
('spaghetti'),
('tagliatelle'),
('tortellini');

INSERT INTO typeProduit(libelle) VALUES
('pizza'),
('pâte'),
('salade'),
('pain'),
('snacking'),
('dessert'),
('boisson'),
('dipy');

INSERT INTO produit (libelle, description, quantite, prix, prixLarge, centilitre, urlImage, idTypePizza, idTypeProduit, estSuggestion) VALUES                                                                                                           -- ==================== Dipy ====================
-- ==================== Pizza ====================
('Margherita', 'sauce tomate, mozzarella, origan', null, 8.5, 16, null, '/images/pizzas/margherita.png', 1, 1, false),
('Margherita Deluxe', 'sauce tomate, mozzarella fior di latte, pesto, tomates fraîches, parmesan rapé, origan', null, 10.5, 18.0, null, '/images/pizzas/margherita-deluxe.png', 1, 1, false),
('Funghi', 'sauce tomate, mozzarella, champignons, origan', null, 9.5, 17.0, null, '/images/pizzas/funghi.png', 1, 1, false),
('Salami', 'sauce tomate, mozzarella, salami, origan', null, 11.5, 19.0, null, '/images/pizzas/salami.png', 1, 1, false),
('Prosciutto', 'sauce tomate, mozzarella, jambon, origan', null, 11.5, 19.0, null, '/images/pizzas/prosciutto.png', 1, 1, false),
('Napoli', 'sauce tomate, mozzarella, anchois, câpres, origan', null, 11.5, 19.0,  null, '/images/pizzas/napoli.png', 1, 1, false),
('Chorizo', 'sauce tomate, mozzarella, chorizo, origan', null, 11.5, 19.0,  null, '/images/pizzas/chorizo.png', 1, 1, false),
('Calzone', 'pizza fermée, sauce tomate, mozzarella, jambon, champignons, oeufs durs', null, 12.5, 21.0, null, '/images/pizzas/calzone.png', 1, 1, false),
('Regina', 'sauce tomate, mozzarella, jambon, champignons, origan', null, 12.5, 21.0, null, '/images/pizzas/regina.png', 1, 1, false),
('Sole Mio', 'sauce tomate, mozzarella, jambon, oeuf cru, origan', null, 12.5, 21.0, null, '/images/pizzas/sole-mio.png', 1, 1, false),
('Bolognaise', 'sauce bolognaise pur boeuf, mozzarella, parmesan rapé, origan', null, 13.5, 23.0, null, '/images/pizzas/bolognaise.png', 1, 1, false),
('Parmigiana', 'sauce tomate, mozzarella, aubergines, parmesan, origan', null, 12.5, 21.0, null, '/images/pizzas/parmigiana.png', 1, 1, false),
('Capricciosa', 'sauce tomate, mozzarella, jambon, champignons, oeufs durs, origan', null, 12.5, 21.0, null, '/images/pizzas/capricciosa.png', 1, 1, false),
('Hawai', 'sauce tomate, mozzarella, jambon, ananas, origan', null, 12.5, 21.0, null, '/images/pizzas/hawai.png', 1, 1, false),
('Sicilienne', 'sauce tomate, mozzarella, anchois, olives, câpres, poivrons, origan', null, 12.5, 21.0, null, '/images/pizzas/sicilienne.png', 1, 1, false),
('Pepperoni', 'sauce tomate, mozzarella, chorizo, poivrons, origan', null, 12.5, 21.0, null, '/images/pizzas/pepperoni.png', 1, 1, false),
('4 saisons', 'sauce tomate, mozzarella, artichauts, olives, jambon, champignons, origan', null, 13.5, 23.0, null, '/images/pizzas/4-saisons.png', 1, 1, false),
('4 fromages', 'sauce tomate, mozzarella, taleggio, gorgonzola, parmesan, origan', null, 13.5, 23.0, null, '/images/pizzas/4-fromages.png', 1, 1, false),
('Forestière', 'sauce tomate, mozzarella, lardons, champignons, oignons, ail, origan', null, 13.5, 23.0,  null, '/images/pizzas/forestiere.png', 1, 1, false),
('Mafiosa', 'sauce tomate, mozzarella, jambon, poivrons, oeufs durs, anchois, ail, origan', null, 13.5, 23.0, null, '/images/pizzas/mafiosa.png', 1, 1, false),
('Chèvre', 'sauce tomate, mozzarella, chèvre, noix, miel, origan', null, 12.5, 21.0, null, '/images/pizzas/chevre.png', 1, 1, false),
('Végétarienne', 'sauce tomate, mozzarella, champignons, oignons, poivrons, artichauts, olives, origan', null, 13.5, 23.0, null, '/images/pizzas/vegetarienne.png', 1, 1, false),
('Zucchina', 'sauce tomate, mozzarella, courgettes, reblochon, lardons, oignons, origan', null, 13.5, 23.0, null, '/images/pizzas/zucchina.png', 1, 1, false),
('Ortolona', 'sauce tomate, mozzarella, aubergines, oignons, taleggio, parmesan, origan', null, 13.5, 23.0, null, '/images/pizzas/ortolana.png', 1, 1, false),
('Fresca', 'sauce tomate, mozzarella, ricotta, tomates fraîches, oignons rouge, pesto, origan', null, 12.5, 21.0, null, '/images/pizzas/fresca.png', 1, 1, false),
('Bresaola', 'sauce tomate, mozzarella, 4 fromages, oignons, bresaola, origan', null, 14.5, 25.0, null, '/images/pizzas/bresaola.png', 1, 1, false),
('Carpaccio', 'sauce tomate, mozzarella, carpaccio, roquette, copeaux de parmesan, tomates confites, balsamique, origan', null, 14.5, 25.0,  null, '/images/pizzas/carpaccio.png', 1, 1, false),
('Gorgonzola', 'sauce tomate, mozzarella, gorgonzola, lardons, poires, oignons, origan', null, 14.5, 25.0, null, '/images/pizzas/gorgonzola.png', 1, 1, false),
('Ruccola', 'sauce tomate, mozzarella, parme, roquette,copeaux de  parmesan, tomates confites, balsamique, origan', null, 16.0, 26.50, null, '/images/pizzas/ruccola.png', 1, 1, false),
('Spicy Chicken', 'sauce tomate, mozzarella, chorizo, poulet, oignons rouges, poivrons, pili-pili, origan', null, 14.5, 25.0, null, '/images/pizzas/spicy-chicken.png', 2, 1, false),
('Merguez', 'sauce tomate, mozzarella, merguez, oignons, feta, origan', null, 12.5, 21.0, null, '/images/pizzas/merguez.png', 2, 1, false),
('Crispy pizza', 'sauce tomate, mozzarella, poulet, haché pur boeuf, merguez, tomates fraîches, sauce poivre, origan', null, 14.5, 25.0, null, '/images/pizzas/crispy-pizza.png', 2, 1, false),
('Tartiflette', 'sauce tomate, mozzarella, lardons, pommes de terre, reblochon, oignons, origan', null, 14.5, 25.0, null, '/images/pizzas/tartiflette.png', 2, 1, false),
('Barbecue Chicken', 'sauce tomate, mozzarella, poulet, oignons rouge, parmesan, sauce barbecue, origan', null, 13.5, 23.0, null, '/images/pizzas/barbecue-chicken.png', 2, 1, false),
('Sofia', 'sauce tomate, mozzarella, pesto, roquette, burrata, tomates fraîches, balsamique, origan', null, 14.5, 25.0, null, '/images/pizzas/sofia.png', 2, 1, false),
('Chicken curry', 'sauce tomate, mozzarella, poulet, ananas, tomates fraîches, sauce curry, origan', null, 13.5, 23.0, null, '/images/pizzas/chicken-curry.png', 2, 1, false),
('Kebab', 'sauce tomate, mozzarella, kebab, tomates fraîches, oignons, sauce à l''ail, origan', null, 13.5, 23.0, null, '/images/pizzas/kebab.png', 2, 1, false),
('Cheese Burger', 'sauce tomate, mozzarella, hamburger, cheddar, oignons frits, cornichons, sauce bicky, origan', null, 13.5, 23.0, null, '/images/pizzas/cheese-burger.png', 2, 1, false),
('Pepe verde', 'sauce tomate, mozzarella, émincé de boeuf, oignons rouge, tomates fraîches, sauce poivre, origan', null, 14.5, 25.0, null, '/images/pizzas/pepe-verde.png', 2, 1, false),
('Barbecue', 'sauce tomate, mozzarella, jambon, lardons, oignons, poivrons, sauce barbecue, origan', null, 14.5, 25.0, null, '/images/pizzas/barbecue.png', 2, 1, false),
('Rosso picante', 'sauce tomate, mozzarella, pesto rouge piquant, merguez, chorizo, poivrons, oignons rouges, origan', null, 14.5, 25.0, null, '/images/pizzas/rosso-piccante.png', 2, 1, false),
('Jammie', 'sauce tomate, mozzarella, poulet, lardons, oignons rouge, poivrons, sauce jammie, origan', null, 14.5, 25.0, null, '/images/pizzas/jammie.png', 2, 1, false),
('Cannibale', 'sauce tomate, mozzarella, merguez, jambon, lardons, salami, oignons, champignons, origan', null, 17.0, 27.5, null, '/images/pizzas/cannibale.png', 2, 1, false),
('Margha Bianca', 'crème, mozzarella, parmesan, origan', null, 9.5, 17.0, null, '/images/pizzas/margha-bianca.png', 3, 1, false),
('Regina Bianca', 'crème, mozzarella, jambon, champignons, origan', null, 12.5, 21.0, null, '/images/pizzas/regina-bianca.png', 3, 1, false),
('Spinaci', 'crème, mozzarella, épinards, gorgonzola, lardons, origan', null, 13.5, 21.0, null, '/images/pizzas/spinaci.png', 3, 1, false),
('Campagnarde', 'crème, mozzarella, pommes de terre, lardons, chèvre, origan', null, 14.5, 25.0, null, '/images/pizzas/campagnarde.png', 3, 1, false),
('8 fromages', 'crème, mozzarella, gorgonzola, taleggio, parmesan, emmental, cheddar, reblochon, ricotta, origan', null, 16.0, 26.5, null, '/images/pizzas/8-fromages.png', 3, 1, false),
('Pollo è Peppe', 'crème, mozzarella, poulet, oignons rouge, courgettes, sauce poivre, origan', null, 14.5, 25.0, null, '/images/pizzas/pollo-e-peppe.png', 3, 1, false),
('Tartuffata', 'crème, mozzarella, jambon, champignons, crème de truffes, roquette, origan', null, 14.5, 25.0, null, '/images/pizzas/tartuffata.png', 3, 1, false),
('Pistacchio', 'crème, mozzarella, crème de pistache, jambon, burrata, brisures de pistache, origan', null, 16.0, 27.5, null, '/images/pizzas/pistacchio.png', 3, 1, false),
('Thon', 'sauce tomate, mozzarella, thon, oignons rouge, olives, origan', null, 12.5, 21.0, null, '/images/pizzas/thon.png', 4, 1, false),
('Fruits de mer', 'sauce tomate, mozzarella, fruits de mer marinés, ail, origan', null, 13.5, 23.0, null, '/images/pizzas/fruits-de-mer.png', 4, 1, false),
('Salmone', 'sauce tomate, mozzarella, saumon, oignons frais, citron, origan', null, 14.5, 25.0, null, '/images/pizzas/salmone.png', 4, 1, false),
('Scampis', 'sauce tomate, mozzarella, scampis marinés, tomates fraîches, ail, origan', null, 13.5, 23.0, null, '/images/pizzas/scampis.png', 4, 1, false),
('Pescatore', 'sauce tomate, mozzarella, fruits de mer, saumon, scampis, ail, origan', null, 16.0, 26.5, null, '/images/pizzas/pescatore.png', 4, 1, false),
('Océane', 'sauce tomate, mozzarella, scampis, saumon, ail, origan', null, 13.5, 23.0, null, '/images/pizzas/oceane.png', 4, 1, false),
('Méditéranéenne', 'sauce tomate, mozzarella, thon, olives, oignons, poivrons, câpres, fêta, origan', null, 16.0, 26.5, null, '/images/pizzas/mediterraneenne.png', 4, 1, false),

-- ==================== Pain ====================
('Pains natures', 'pain pizza', null, 2.0, null, null, '/images/pains/pain-nature.png', null, 4, false),
('Pains à l''ail', 'pain pizza, ail', null, 4.5, null, null, '/images/pains/pain-ail.png', null, 4, false),
('Pains aux olives', 'pain, mozzarella, olives', null, 4.5, null, null, '/images/pains/pain-olive.png', null, 4, false),
('Pains aux lardons', 'pain, mozzarella, lardons', null, 5.5, null, null, '/images/pains/pain-lardon.png', null, 4, false),
('Pains campagnards', 'pain, mozzarella, chèvre, lardon', null, 6.5, null, null, '/images/pains/pain-campagnard.png', null, 4, false),
('Pains 4 fromage', 'pain, 4 fromages', null, 5.5, null, null, '/images/pains/pain-4-fromage.png', null, 4, false),

-- ==================== Pâte ====================
('Tomate crème', 'sauce tomate, crème', null, 10.5, null, null, '/images/pates/tomate-crème.png', null, 2, false),
('Jambon crème', 'crème, dés de jambon, muscade', null, 11.5, null, null, '/images/pates/jambon-crème.png', null, 2, false),
('Arrabatia', 'sauce tomate, ail, oignons, olives, pili-pili', null, 10.5, null, null, '/images/pates/arrabatia.png', null, 2, false),
('Carbonara', 'crème, lardons', null, 11.5, null, null, '/images/pates/carbonara.png', null, 2, false),
('Genovese', 'crème, pesto', null, 11.5, null, null, '/images/pates/genovese.png', null, 2, false),
('Bolognaise', 'sauce bolognaise pur boeuf', null, 12.5, null, null, '/images/pates/bolognaise.png', null, 2, false),
('4 fromage', 'sauce 4 fromage', null, 12.5, null, null, '/images/pates/4-fromage.png', null, 2, false),
('Du chef', 'sauce tomate, crème, 4 fromage, jambon', null, 12.5, null, null, '/images/pates/du-chef.png', null, 2, false),
('Archiduc', 'crème, poulet, champignons', null, 12.5, null, null, '/images/pates/archiduc.png', null, 2, false),
('Matriciana', 'sauce tomate, crème, lardons, champignons', null, 12.5, null, null, '/images/pates/matriciana.png', null, 2, false),
('Fuego', 'crème, chorizo, oignons rouge, pili-pili, tomates cerise, ricotta, persil', null, 13.5, null, null, '/images/pates/fuego.png', null, 2, false),
('Alla norma', 'sauce tomate, aubergines, ail, lardons, basilic, oignons', null, 12.5, null, null, '/images/pates/alla-norma.png', null, 2, false),
('Scampis', 'sauce tomate, crème, scampis, ail, basilic', null, 13.5, null, null, '/images/pates/scampis.png', null, 2, false),
('Saumon', 'crème, saumon, ciboulette', null, 13.5, null, null, '/images/pates/saumon.png', null, 2, false),
('Al finicchio', 'sauce tomate, crème, haché, épinards, graines de fenouille', null, 13.5, null, null, '/images/pates/al-finicchio.png', null, 2, false),
('Boscaiola', 'crème, ricotta, champignons, huile de truffles, parmesan', null, 10.5, null, null, '/images/pates/boscaiola.png', null, 2, false),
('Siciliana', 'crème, lardons, pâtes de pistaches, oignons', null, 10.5, null, null, '/images/pates/siciliana.png', null, 2, false),
('canneloni ricota', 'ricotta fraîche, épinards, sauce tomate, crème, mozzarella gratinée', null, 12.5, null, null, '/images/pates/canneloni-ricotta.png', null, 2, false),

-- ==================== Salade ====================
('Caprèse', 'roquette, tomates fraîches, mozzarella fraîches, pesto, balsamique', null, 10.5, null, null, '/images/salades/caprèse.png', null, 3, false),
('Tonnata', 'thon, oignons rouges, olives, feta', null, 11.5, null, null, '/images/salades/tonnata.png', null, 3, false),
('Carpaccio', 'carpaccio, tomates confites, parmesan, roquette, balsamique', null, 11.5, null, null, '/images/salades/carpaccio.png', null, 3, false),
('Saumon', 'saumon, oignons, citron, ciboulette', null, 11.5, null, null, '/images/salades/saumon.png', null, 3, false),
('César', 'poulet, crouton oeufs durs, copeaux de parmesan', null, 11.5, null, null, '/images/salades/cesar.png', null, 3, false),
('Burrata', 'roquette, mozzarella, burrata, bresaola, tomates confites, balsamique', null, 12.5, null, null, '/images/salades/burrata.png', null, 3, false),
('Gourmande', 'chorizo, bresaola, chèvre, olives, saumon, oignons, oeufs durs, poires', null, 13.5, null, null, '/images/salades/gourmade.png', null, 3, false),

-- ==================== Snacking ====================
('Fondue parmesan', 'Fondue servie sur un lit de salade, agrémentée de parmesan, d’un coulis de vinaigrette et d’une fine tranche de citron', 1, 4.5, null, null,'/images/snackings/fondu-parmesan.png', null, 5, false),
('Fondue parmesan', 'Fondue servie sur un lit de salade, agrémentée de parmesan, d’un coulis de vinaigrette et d’une fine tranche de citron', 2, 7.5, null, null,'/images/snackings/fondu-parmesan.png', null, 5, false),
('Scampis fritti', null, 6, 6.5, null, null,'/images/snackings/scampis-fritti.png', null, 5, false),
('Scampis fritti', null, 10, 8.5, null, null,'/images/snackings/scampis-fritti.png', null, 5, false),
('Chicken nuggets', null, 6, 4.5, null, null,'/images/snackings/chicken-nuggets.png', null, 5, false),
('Chicken nuggets', null, 10, 6.5, null, null,'/images/snackings/chicken-nuggets.png', null, 5, false),
('Beignets de fleurs de courgette', null, 3, 5.0, null, null,'/images/snackings/beignets-courgette.png', null, 5, false),
('Beignets de fleurs de courgette', null, 6, 8.5, null, null,'/images/snackings/beignets-courgette.png', null, 5, false),
('Chicken wings', null, 4, 5.0, null, null,'/images/snackings/chicken-wings.png', null, 5, false),
('Chicken wings', null, 8, 8.5, null, null,'/images/snackings/chicken-wings.png', null, 5, false),
('Arancini', 'Boule de riz fourrée aux 4 fromages et panée', 1, 5.0, null, null,'/images/snackings/arancini.png', null, 5, false),
('Arancini', 'Boule de riz fourrée aux 4 fromages et panée', 2, 8.5, null, null,'/images/snackings/arancini.png', null, 5, false),

-- ==================== Boisson ====================
('Eau pétillante', null, null, 1.0, null, '33cl', '/images/boissons/eau-petillante.png', null, 7, false),
('Eau plate', null, null, 1.0, null, '33cl', '/images/boissons/eau-plate.png', null, 7, false),
('Coca cola', null, null, 2.0, null, '33cl', '/images/boissons/coca-cola.png', null, 7, false),
('Coca cola zero', null, null, 2.0, null, '33cl', '/images/boissons/coca-cola-zero.png', null, 7, false),
('Fanta', null, null, 2.0, null, '33cl', '/images/boissons/fanta.png', null, 7, false),
('Fanta citron', null, null, 2.0, null, '33cl', '/images/boissons/fanta-citron.png', null, 7, false),
('Tropico', null, null, 2.0, null, '33cl', '/images/boissons/tropico.png', null, 7, false),
('Sprite', null, null, 2.0, null, '33cl', '/images/boissons/sprite.png', null, 7, false),
('Ice tea', null, null, 2.0, null, '33cl', '/images/boissons/ice-tea.png', null, 7, false),
('Ice tea pêche', null, null, 2.0, null, '33cl', '/images/boissons/ice-tea-pêche.png', null, 7, false),
('Oasis tropical', null, null, 2.0, null, '33cl', '/images/boissons/oasis-tropical.png', null, 7, false),
('Caprisun', null, null, 2.0, null, '33cl', '/images/boissons/caprisun.png', null, 7, false),
('Redbull', null, null, 3.0, null, '25cl', '/images/boissons/redbull.png', null, 7, false),

-- ==================== Dessert ====================
('Mousse au chocolat', null, null, 4.5, null, null, '/images/desserts/mousse-choco.png', null, 6, false),
('Tiramisu', null, null, 4.5, null, null, '/images/desserts/tiramisu.png', null, 6, false),
('Moelleux au chocolat', 'Moelleux chocolat servi avec un coulis de fruits rouges', 1, 4.5, null, null, '/images/desserts/moelleux-choco.png', null, 6, false),
('Moelleux au chocolat', 'Moelleux chocolat servi avec un coulis de fruits rouges', 2, 6.5, null, null, '/images/desserts/moelleux-choco.png', null, 6, false),

-- ==================== Dipy ====================
('Dipy cheddar', null, null, 3.0, null, null, '/images/dipys/dipy-cheddar.png', null, 8, false),
('Dipy blanche', null, null, 3.0, null, null, '/images/dipys/dipy-blanche.png', null, 8, false),
('Dipy hot', null, null, 3.0, null, null, '/images/dipys/dipy-hot.png', null, 8, false),

-- ==================== test ====================
('test', 'test, test1, test2, test3', null, 10.0, 18.0, null, '/images/pizzas/margherita.png', 1, 1, true);

INSERT INTO adresse(codePostal, nomRue, numeroRue, localite) VALUES
(5081, 'Rue du chainia', '62', 'Meux'),
(5081, 'Avenue des Déportés', '45A', 'Ramillies');

INSERT INTO restaurant(nom, idadresse) VALUES
('Meux', 1),
('Ramillies', 2);

INSERT INTO categorieIngredient(libelle) VALUES
('viandes'),
('fromages'),
('legumes'),
('poissons'),
('huiles/crèmes'),
('sauces');

INSERT INTO ingredient(libelle, prixmedium, prixlarge, forPizza, forPate, forSalade, idCategorieIngredient) VALUES
-- ==================== viandes ====================
('jambon', 2.0, 3.00, true, true, true, 1),
('poulet', 2.0, 3.00, true, true, true, 1),
('salami', 2.0, 3.00, true, true, true, 1),
('chorizo', 2.0, 3.00, true, true, true, 1),
('bolognaise', 2.0, 3.00, true, true, true, 1),
('parme', 2.0, 3.00, true, true, true, 1),
('lardon', 2.0, 3.00, true, true, true, 1),
('carpaccio', 2.0, 3.00, true, true, true, 1),
('hamburger', 2.0, 3.00, true, true, true, 1),
('kebab', 2.0, 3.00, true, true, true, 1),
('merguez', 2.0, 3.00, true, true, true, 1),
('lamelle de boeuf', 2.0, 3.00, true, true, true, 1),
('haché', 2.0, 3.00, true, false, false, 1),

-- ==================== fromages ====================
('gratiné', 2.0, 0.0, false, true, false, 2),
('4 fromage', 2.0, 3.00, true, true, true, 2),
('gorgonzola', 2.0, 3.00, true, true, true, 2),
('mozzarella', 2.0, 3.00, true, false, false, 2),
('feta', 2.0, 3.00, true, true, true, 2),
('chèvre', 2.0, 3.00, true, true, true, 2),
('burrata', 4.0, 7.0, true, true, true, 2),
('cheddar', 2.0, 3.00, true, true, true, 2),
('emmental', 2.0, 3.00, true, true, true, 2),
('ricotta', 2.0, 3.00, true, true, true, 2),
('reblochon', 2.0, 3.00, true, true, true, 2),
('copeau de parmesan', 2.0, 3.00, true, true, true, 2),
('parmesan', 2.0, 3.00, true, true, true, 2),
('boule de mozzarella', 2.0, 3.00, true, true, true, 2),

-- ==================== legumes ====================
('oignon', 1.0, 2.0, true, true, true, 3),
('oignon rouge', 1.0, 2.0, true, true, true, 3),
('oignon frit', 0.5, 1.0, true, true, true, 3),
('champignon', 1.0, 2.0, true, true, true, 3),
('poivron', 1.0, 2.0, true, true, true, 3),
('olive', 1.0, 2.0, true, true, true, 3),
('oeuf dur', 1.0, 2.0, true, true, true, 3),
('oeuf cru', 1.0, 2.0, true, true, true, 3),
('ananas', 1.0, 2.0, true, true, true, 3),
('artichaut', 1.0, 2.0, true, true, true, 3),
('roquette', 1.0, 2.0, true, true, true, 3),
('tomate fraîche', 1.0, 2.0, true, true, true, 3),
('tomate confite', 1.0, 2.0, true, true, true, 3),
('tomate cerise', 1.0, 2.0, true, true, true, 3),
('poire', 1.0, 2.0, true, true, true, 3),
('aubergine', 1.0, 2.0, true, true, true, 3),
('noix', 1.0, 2.0, true, true, true, 3),
('epinard', 1.0, 2.0, true, true, true, 3),
('pomme de terre', 1.0, 2.0, true, true, true, 3),
('brisure de pistache', 1.0, 2.0, true, true, true, 3),
('graine de fenouille', 0.5, 1.0, true, true, true, 3),
('courgette', 1.0, 2.0, true, true, true, 3),
('câpres', 1.0, 2.0, true, false, false, 3),

-- ==================== poisson ====================
('scampis', 3.0, 5.0, true, true, true, 4),
('fruit de mer', 3.0, 5.0, true, true, true, 4),
('thon', 3.0, 5.0, true, true, true, 4),
('saumon', 3.0, 5.0, true, true, true, 4),
('anchois', 3.0, 5.0, true, true, true, 4),

-- ==================== huile/crème ====================
('huile à l''ail', 0.5, 1, true, true, true,  5),
('huile d''olive', 0.5, 1, true, true, true, 5),
('huile pesto', 0.5, 1, true, true, true, 5),
('huile truffe', 0.5, 1, true, true, true, 5),
('huile pesto rouge', 0.5, 1, true, true, true, 5),
('crème', 0.5, 1, true, true, true, 5),
('crème balsamique', 0.5, 1, true, true, true, 5),
('crème pistache', 0.5, 1, true, true, true, 5),
('crème truffe', 0.5, 1, true, true, true, 5),
('sauce tomate', 0.5, 1, true, true, true, 5),
('pili-pili', 0.5, 1, true, true, true, 5),

-- ==================== sauce ====================
('sauce ketchup', 1, 2, true, false, false, 6),
('sauce mayonnaise', 1, 2, true, false, false, 6),
('sauce jammie', 1, 2, true, false, false, 6),
('sauce bicky', 1, 2, true, false, false, 6),
('sauce au poivre', 1, 2, true, false, false, 6),
('sauce aïoli', 1, 2, true, false, false, 6),
('sauce barbecue', 1, 2, true, false, false, 6),
('sauce curry', 1, 2, true, false, false, 6);

INSERT INTO statut(libelle) VALUES
('Encours'),
('Cloturé');

INSERT INTO utilisateur(motdepasse, idResraurent, modeAdmin) VALUES
('11111', 1, false),
('22222', 2, false),
('12345', 1, true);

INSERT INTO produitIngredient (idProduit, libelle) VALUES
(1, 'sauce tomate'), (1, 'mozzarella'), (1, 'origan'),
(2, 'sauce tomate'), (2, 'mozzarella fior di latte'), (2, 'pesto'), (2, 'tomates fraîches'), (2, 'parmesan rapé'), (2, 'origan'),
(3, 'sauce tomate'), (3, 'mozzarella'), (3, 'champignons'), (3, 'origan'),
(4, 'sauce tomate'), (4, 'mozzarella'), (4, 'salami'), (4, 'origan'),
(5, 'sauce tomate'), (5, 'mozzarella'), (5, 'jambon'), (5, 'origan'),
(6, 'sauce tomate'), (6, 'mozzarella'), (6, 'anchois'), (6, 'câpres'), (6, 'origan'),
(7, 'sauce tomate'), (7, 'mozzarella'), (7, 'chorizo'), (7, 'origan'),
(8, 'pizza fermée'), (8, 'sauce tomate'), (8, 'mozzarella'), (8, 'jambon'), (8, 'champignons'), (8, 'oeufs durs'),
(9, 'sauce tomate'), (9, 'mozzarella'), (9, 'jambon'), (9, 'champignons'), (9, 'origan'),
(10, 'sauce tomate'), (10, 'mozzarella'), (10, 'jambon'), (10, 'oeuf cru'), (10, 'origan'),
(11, 'sauce bolognaise pur boeuf'), (11, 'mozzarella'), (11, 'parmesan rapé'), (11, 'origan'),
(12, 'sauce tomate'), (12, 'mozzarella'), (12, 'aubergines'), (12, 'parmesan'), (12, 'origan'),
(13, 'sauce tomate'), (13, 'mozzarella'), (13, 'jambon'), (13, 'champignons'), (13, 'oeufs durs'), (13, 'origan'),
(14, 'sauce tomate'), (14, 'mozzarella'), (14, 'jambon'), (14, 'ananas'), (14, 'origan'),
(15, 'sauce tomate'), (15, 'mozzarella'), (15, 'anchois'), (15, 'olives'), (15, 'câpres'), (15, 'poivrons'), (15, 'origan'),
(16, 'sauce tomate'), (16, 'mozzarella'), (16, 'chorizo'), (16, 'poivrons'), (16, 'origan'),
(17, 'sauce tomate'), (17, 'mozzarella'), (17, 'artichauts'), (17, 'olives'), (17, 'jambon'), (17, 'champignons'), (17, 'origan'),
(18, 'sauce tomate'), (18, 'mozzarella'), (18, 'taleggio'), (18, 'gorgonzola'), (18, 'parmesan'), (18, 'origan'),
(19, 'sauce tomate'), (19, 'mozzarella'), (19, 'lardons'), (19, 'champignons'), (19, 'oignons'), (19, 'ail'), (19, 'origan'),
(20, 'sauce tomate'), (20, 'mozzarella'), (20, 'jambon'), (20, 'poivrons'), (20, 'oeufs durs'), (20, 'anchois'), (20, 'ail'), (20, 'origan'),
(21, 'sauce tomate'), (21, 'mozzarella'), (21, 'chèvre'), (21, 'noix'), (21, 'miel'), (21, 'origan'),
(22, 'sauce tomate'), (22, 'mozzarella'), (22, 'champignons'), (22, 'oignons'), (22, 'poivrons'), (22, 'artichauts'), (22, 'olives'), (22, 'origan'),
(23, 'sauce tomate'), (23, 'mozzarella'), (23, 'courgettes'), (23, 'reblochon'), (23, 'lardons'), (23, 'oignons'), (23, 'origan'),
(24, 'sauce tomate'), (24, 'mozzarella'), (24, 'aubergines'), (24, 'oignons'), (24, 'taleggio'), (24, 'parmesan'), (24, 'origan'),
(25, 'sauce tomate'), (25, 'mozzarella'), (25, 'ricotta'), (25, 'tomates fraîches'), (25, 'oignons rouge'), (25, 'pesto'), (25, 'origan'),
(26, 'sauce tomate'), (26, 'mozzarella'), (26, '4 fromages'), (26, 'oignons'), (26, 'bresaola'), (26, 'origan'),
(27, 'sauce tomate'), (27, 'mozzarella'), (27, 'carpaccio'), (27, 'roquette'), (27, 'copeaux de parmesan'), (27, 'tomates confites'), (27, 'balsamique'), (27, 'origan'),
(28, 'sauce tomate'), (28, 'mozzarella'), (28, 'gorgonzola'), (28, 'lardons'), (28, 'poires'), (28, 'oignons'), (28, 'origan'),
(29, 'sauce tomate'), (29, 'mozzarella'), (29, 'parme'), (29, 'roquette'), (29, 'copeaux de parmesan'), (29, 'tomates confites'), (29, 'balsamique'), (29, 'origan'),
(30, 'sauce tomate'), (30, 'mozzarella'), (30, 'chorizo'), (30, 'poulet'), (30, 'oignons rouges'), (30, 'poivrons'), (30, 'pili-pili'), (30, 'origan'),
(31, 'sauce tomate'), (31, 'mozzarella'), (31, 'merguez'), (31, 'oignons'), (31, 'feta'), (31, 'origan'),
(32, 'sauce tomate'), (32, 'mozzarella'), (32, 'poulet'), (32, 'haché pur boeuf'), (32, 'merguez'), (32, 'tomates fraîches'), (32, 'sauce poivre'), (32, 'origan'),
(33, 'sauce tomate'), (33, 'mozzarella'), (33, 'lardons'), (33, 'pommes de terre'), (33, 'reblochon'), (33, 'oignons'), (33, 'origan'),
(34, 'sauce tomate'), (34, 'mozzarella'), (34, 'poulet'), (34, 'oignons rouge'), (34, 'parmesan'), (34, 'sauce barbecue'), (34, 'origan'),
(35, 'sauce tomate'), (35, 'mozzarella'), (35, 'pesto'), (35, 'roquette'), (35, 'burrata'), (35, 'tomates fraîches'), (35, 'balsamique'), (35, 'origan'),
(36, 'sauce tomate'), (36, 'mozzarella'), (36, 'poulet'), (36, 'ananas'), (36, 'tomates fraîches'), (36, 'sauce curry'), (36, 'origan'),
(37, 'sauce tomate'), (37, 'mozzarella'), (37, 'kebab'), (37, 'tomates fraîches'), (37, 'oignons'), (37, 'sauce à l''ail'), (37, 'origan'),
(38, 'sauce tomate'), (38, 'mozzarella'), (38, 'hamburger'), (38, 'cheddar'), (38, 'oignons frits'), (38, 'cornichons'), (38, 'sauce bicky'), (38, 'origan'),
(39, 'sauce tomate'), (39, 'mozzarella'), (39, 'émincé de boeuf'), (39, 'oignons rouge'), (39, 'tomates fraîches'), (39, 'sauce poivre'), (39, 'origan'),
(40, 'sauce tomate'), (40, 'mozzarella'), (40, 'jambon'), (40, 'lardons'), (40, 'oignons'), (40, 'poivrons'), (40, 'sauce barbecue'), (40, 'origan'),
(41, 'sauce tomate'), (41, 'mozzarella'), (41, 'pesto rouge piquant'), (41, 'merguez'), (41, 'chorizo'), (41, 'poivrons'), (41, 'oignons rouges'), (41, 'origan'),
(42, 'sauce tomate'), (42, 'mozzarella'), (42, 'poulet'), (42, 'lardons'), (42, 'oignons rouge'), (42, 'poivrons'), (42, 'sauce jammie'), (42, 'origan'),
(43, 'sauce tomate'), (43, 'mozzarella'), (43, 'merguez'), (43, 'jambon'), (43, 'lardons'), (43, 'salami'), (43, 'oignons'), (43, 'champignons'), (43, 'origan'),
(44, 'crème'), (44, 'mozzarella'), (44, 'parmesan'), (44, 'origan'),
(45, 'crème'), (45, 'mozzarella'), (45, 'jambon'), (45, 'champignons'), (45, 'origan'),
(46, 'crème'), (46, 'mozzarella'), (46, 'épinards'), (46, 'gorgonzola'), (46, 'lardons'), (46, 'origan'),
(47, 'crème'), (47, 'mozzarella'), (47, 'pommes de terre'), (47, 'lardons'), (47, 'chèvre'), (47, 'origan'),
(48, 'crème'), (48, 'mozzarella'), (48, 'gorgonzola'), (48, 'taleggio'), (48, 'parmesan'), (48, 'emmental'), (48, 'cheddar'), (48, 'reblochon'), (48, 'ricotta'), (48, 'origan'),
(49, 'crème'), (49, 'mozzarella'), (49, 'poulet'), (49, 'oignons rouge'), (49, 'courgettes'), (49, 'sauce poivre'), (49, 'origan'),
(50, 'crème'), (50, 'mozzarella'), (50, 'jambon'), (50, 'champignons'), (50, 'crème de truffes'), (50, 'roquette'), (50, 'origan'),
(51, 'crème'), (51, 'mozzarella'), (51, 'crème de pistache'), (51, 'jambon'), (51, 'burrata'), (51, 'brisures de pistache'), (51, 'origan'),
(52, 'sauce tomate'), (52, 'mozzarella'), (52, 'thon'), (52, 'oignons rouge'), (52, 'olives'), (52, 'origan'),
(53, 'sauce tomate'), (53, 'mozzarella'), (53, 'fruits de mer marinés'), (53, 'ail'), (53, 'origan'),
(54, 'sauce tomate'), (54, 'mozzarella'), (54, 'saumon'), (54, 'oignons frais'), (54, 'citron'), (54, 'origan'),
(55, 'sauce tomate'), (55, 'mozzarella'), (55, 'scampis marinés'), (55, 'tomates fraîches'), (55, 'ail'), (55, 'origan'),
(56, 'sauce tomate'), (56, 'mozzarella'), (56, 'fruits de mer'), (56, 'saumon'), (56, 'scampis'), (56, 'ail'), (56, 'origan'),
(57, 'sauce tomate'), (57, 'mozzarella'), (57, 'scampis'), (57, 'saumon'), (57, 'ail'), (57, 'origan'),
(58, 'sauce tomate'), (58, 'mozzarella'), (58, 'thon'), (58, 'olives'), (58, 'oignons'), (58, 'poivrons'), (58, 'câpres'), (58, 'fêta'), (58, 'origan'),
(65, 'sauce tomate'), (65, 'crème'),
(66, 'crème'), (66, 'dés de jambon'), (66, 'muscade'),
(67, 'sauce tomate'), (67, 'ail'), (67, 'oignons'), (67, 'olives'), (67, 'pili-pili'),
(68, 'crème'), (68, 'lardons'),
(69, 'crème'), (69, 'pesto'),
(70, 'sauce bolognaise pur boeuf'),
(71, 'sauce 4 fromage'),
(72, 'sauce tomate'), (72, 'crème'), (72, '4 fromage'), (72, 'jambon'),
(73, 'crème'), (73, 'poulet'), (73, 'champignons'),
(74, 'sauce tomate'), (74, 'crème'), (74, 'lardons'), (74, 'champignons'),
(75, 'crème'), (75, 'chorizo'), (75, 'oignons rouge'), (75, 'pili-pili'), (75, 'tomates cerise'), (75, 'ricotta'), (75, 'persil'),
(76, 'sauce tomate'), (76, 'aubergines'), (76, 'ail'), (76, 'lardons'), (76, 'basilic'), (76, 'oignons'),
(77, 'sauce tomate'), (77, 'crème'), (77, 'scampis'), (77, 'ail'), (77, 'basilic'),
(78, 'crème'), (78, 'saumon'), (78, 'ciboulette'),
(79, 'sauce tomate'), (79, 'crème'), (79, 'haché'), (79, 'épinards'), (79, 'graines de fenouille'),
(80, 'crème'), (80, 'ricotta'), (80, 'champignons'), (80, 'huile de truffles'), (80, 'parmesan'),
(81, 'crème'), (81, 'lardons'), (81, 'pâtes de pistaches'), (81, 'oignons'),
(82, 'ricotta fraîche'), (82, 'épinards'), (82, 'sauce tomate'), (82, 'crème'), (82, 'mozzarella gratinée');