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

create table typePayement
(
    id serial primary key,
    libelle varchar(20) not null
);

create table statut(
    id serial PRIMARY KEY,
    libelle varchar(15)
);
create table commande(
    id serial PRIMARY KEY,
    estLivraison boolean not null ,
    dateHeure varchar(20) not null ,
    estPayer boolean not null ,
    prixTotal double precision not null,
    commetaire varchar(255),
    idrestaurant integer not null,
    foreign key (idrestaurant) references restaurant,
    idstatut integer not null,
    FOREIGN KEY (idstatut) REFERENCES statut,
    idClient integer,
    foreign key (idClient) references client,
    idTypePayement integer,
    foreign key (idTypePayement) references typepayement
);

create table ligneCommande(
    id serial primary key,
    quantiteLigne int not null,
    prixLigne double precision not null,
    estGratiner boolean,
    tailleMedium boolean,
    typePate varchar(20),
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
    foreign key (idResraurent) references restaurant
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
('Fini');

INSERT INTO typePayement(libelle) VALUES
('Cash'),
('Bancontact');

INSERT INTO utilisateur(motdepasse) VALUES
('11111'),
('22222'),
('12345');
