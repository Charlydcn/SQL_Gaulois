-- 1. NOM DES LIEUX QUI FINISSENT PAR 'um'
SELECT *
FROM lieu
WHERE nom_lieu LIKE '%um'

-- 2. NOMBRE DE PERSONNAGES PAR LIEU (trié par nombre de personnages décroissant)
SELECT nom_lieu AS 'Nom du Lieu', COUNT(*) AS 'Nombre de villageois'
FROM lieu
INNER JOIN personnage ON lieu.id_lieu = personnage.id_lieu
GROUP BY lieu.id_lieu

-- 3. NOM DES PERSONNAGES + SPÉCIALITÉ + ADRESSE ET LIEU D'HABITATION (triés par lieu puis par nom de personnage)
SELECT nom_personnage AS 'Personnage', specialite.nom_specialite AS 'Spécialité', adresse_personnage AS 'Adresse', lieu.nom_lieu AS "Lieu d'habitation"
FROM personnage
INNER JOIN specialite ON personnage.id_specialite = specialite.id_specialite
INNER JOIN lieu ON personnage.id_lieu = lieu.id_lieu
ORDER BY lieu.nom_lieu ASC, personnage.nom_personnage ASC

-- 4. NOM DES SPÉCIALITÉS AVEC NOMBRE DE PERSONNAGES PAR SPÉCIALITÉ (trié par nombre de personnages décroissant)
SELECT nom_specialite AS 'Spécialité', COUNT(*) AS 'Nombre de spécialiste(s)'
FROM specialite
INNER JOIN personnage ON specialite.id_specialite = personnage.id_specialite
GROUP BY personnage.id_specialite
ORDER BY COUNT(*) DESC

-- 5. NOM, DATE, ET LIEU DES BATAILLES, CLASSÉES DE LA PLUS RÉCENTE A LA PLUS ANCIENNE (format jj/mm/aaaa)
SELECT nom_bataille AS 'Bataille', DATE_FORMAT(date_bataille, "%d %m %Y") AS 'Date', nom_lieu AS 'Lieu'
FROM bataille
INNER JOIN lieu ON bataille.id_lieu = lieu.id_lieu
GROUP BY nom_bataille, date_bataille, nom_lieu
ORDER BY date_bataille ASC

-- 6. NOM DES POTIONS + COÛT DE RÉALISATION DE LA POTION (trié par coût décroissant)


-- 7. NOM DES INGRÉDIENTS + COÛT + QUANTITÉ DE CHAQUE INGRÉDIENT QUI COMPOSENT LA POTION 'Santé'


-- 8. NOM DU/DES PERSONNAGES QUI ONT PRIS LE PLUS DE CASQUES DANS LA BATAILLE 'Bataille du village gaulois'.
SELECT nom_personnage AS 'Personnage', nom_casque AS 'Nom du casque', nom_bataille AS 'Bataille', MAX(prendre_casque.qte) AS 'Nombre de casques'
FROM personnage
INNER JOIN prendre_casque ON personnage.id_personnage = prendre_casque.id_personnage
INNER JOIN casque ON prendre_casque.id_casque = casque.id_casque
INNER JOIN bataille ON prendre_casque.id_bataille = bataille.id_bataille
WHERE bataille.id_bataille = '1'
GROUP BY prendre_casque.qte, nom_personnage, nom_casque, nom_bataille
ORDER BY prendre_casque.qte DESC
LIMIT 1

-- 9. NOM DES PERSONNAGES ET LEUR QUANTITÉ DE POTION BUE (classé du plus grand buveur au plus petit)


-- 10. NOM DE LA BATAILLE OU LE NOMBRE DE CASQUES PRIS A ÉTÉ LE PLUS IMPORTANT


-- 11. COMBIEN DE CASQUES PAR TYPE ET QUEL COÛT TOTAL (classé par nombre décroissant)


-- 12. NOM DES POTIONS DONT UN DES INGRÉDIENTS EST LE POISSON FRAIS


-- 13. NOM DU/DES LIEU/X POSSÉDANT LE PLUS D'HABITANTS, EN DEHORS DU VILLAGE GAULOIS


-- 14. NOM DES PERSONNAGES QUI N'ONT JAMAIS BU DE POTION


-- 15. NOM DU/DES PERSONNAGE/S QUI N'ONT PAS LE DROIT DE BOIRE DE LA POTION 'Magique'

