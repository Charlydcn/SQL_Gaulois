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
SELECT nom_potion AS 'Potion', SUM(qte * cout_ingredient) AS 'Coût de fabrication'
FROM potion
INNER JOIN composer ON potion.id_potion = composer.id_potion
INNER JOIN ingredient ON composer.id_ingredient = ingredient.id_ingredient
GROUP BY nom_potion
ORDER BY SUM(qte * cout_ingredient) DESC

-- 7. NOM DES INGRÉDIENTS + COÛT + QUANTITÉ DE CHAQUE INGRÉDIENT QUI COMPOSENT LA POTION 'Santé'
SELECT nom_ingredient AS 'Ingrédient', cout_ingredient AS 'Coût', qte AS "Quantité"
FROM potion
INNER JOIN composer ON potion.id_potion = composer.id_potion
INNER JOIN ingredient ON composer.id_ingredient = ingredient.id_ingredient
WHERE nom_potion = 'Magique'
GROUP BY nom_ingredient, qte, cout_ingredient

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
SELECT nom_personnage AS 'Personnage', dose_boire AS 'Doses bues'
FROM personnage
INNER JOIN boire ON personnage.id_personnage = boire.id_personnage
GROUP BY dose_boire, personnage.id_personnage
ORDER BY dose_boire DESC

-- 10. NOM DE LA BATAILLE OU LE NOMBRE DE CASQUES PRIS A ÉTÉ LE PLUS IMPORTANT
SELECT nom_bataille AS 'Bataille', qte AS 'Nombre de casques volés'
FROM bataille
INNER JOIN prendre_casque ON prendre_casque.id_bataille = bataille.id_bataille
GROUP BY qte, nom_bataille
ORDER BY qte DESC
LIMIT 1

-- 11. COMBIEN DE CASQUES PAR TYPE ET QUEL COÛT TOTAL (classé par nombre décroissant)
SELECT nom_type_casque AS 'Type de casque', COUNT(id_casque) AS 'Nombre de casques', SUM(cout_casque) AS 'Coût total'
FROM type_casque
INNER JOIN casque ON type_casque.id_type_casque = casque.id_type_casque
GROUP BY nom_type_casque
ORDER BY SUM(cout_casque) DESC

-- 12. NOM DES POTIONS DONT UN DES INGRÉDIENTS EST LE POISSON FRAIS
SELECT nom_potion AS 'Potion'
FROM potion
INNER JOIN composer ON potion.id_potion = composer.id_potion
INNER JOIN ingredient ON composer.id_ingredient = ingredient.id_ingredient
WHERE ingredient.id_ingredient = '24'

-- 13. NOM DU/DES LIEU/X POSSÉDANT LE PLUS D'HABITANTS, EN DEHORS DU VILLAGE GAULOIS
SELECT nom_lieu AS 'Lieu', COUNT(lieu.id_lieu) AS "Nombre d'habitant(s)"
FROM lieu
INNER JOIN personnage ON lieu.id_lieu = personnage.id_lieu
WHERE NOT lieu.id_lieu = '1'
GROUP BY nom_lieu
ORDER BY COUNT(lieu.id_lieu) DESC
LIMIT 1

-- 14. NOM DES PERSONNAGES QUI N'ONT JAMAIS BU DE POTION
SELECT nom_personnage AS "Personnages n'ayant jamais bu de potion"
FROM personnage
WHERE id_personnage NOT IN (
	SELECT id_personnage
	FROM boire
	)
GROUP BY nom_personnage

-- 15. NOM DU/DES PERSONNAGE/S QUI N'ONT PAS LE DROIT DE BOIRE DE LA POTION 'Magique'
SELECT nom_personnage AS "Personnes n'ayant pas le droit de boire de la potion 'Magique'"
FROM personnage
WHERE id_personnage NOT IN (
	SELECT id_personnage
	FROM autoriser_boire
	WHERE id_potion = '1' 
	)