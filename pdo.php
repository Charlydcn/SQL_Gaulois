<?php

try 
{
    $db = new PDO('mysql:host=localhost;dbname=gaulois_charly;charset=utf8', 'root', '');
}
catch (Exception $e)
{
    die('Erreur : ' . $e->getMessage());
}

// EXEMPLE
$personnageQuery = 'SELECT * FROM personnage WHERE id_personnage = :id AND id_lieu = :idlieu';
$personnageStatement = $db->prepare($personnageQuery);
$personnageStatement->execute(["id"=>4, "idlieu" =>1]);
var_dump($personnageStatement);

$personnages = $personnageStatement->fetchAll();

foreach($personnages as $personnage) {
    echo "<ul>
            <li>".$personnage['nom_personnage']."</li>
        </ul>";
}




?>