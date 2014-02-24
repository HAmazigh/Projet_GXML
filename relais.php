<?php
// echo phpinfo();

//echo 'Vérification de la transmission du formulaire ! <br/>';

$parametres=urldecode(($_SERVER['QUERY_STRING']));
//;echo 'la valeur de criteres est<b>: '.$parametres.'</b><br/><br/><br/>';

$doc_xml= new DOMDocument();
$doc_xml->load('qcm.xml');

$doc_xsl= new DOMDocument();
$doc_xsl->load('planV2.xsl');

$proc = new XsltProcessor();

$proc->importStylesheet($doc_xsl);

$proc->setParameter(null, 'criteres', $parametres);


//il renvoi le resultat de la feuille de style plan.xsl sur le fichier xml 
echo $proc->transformToXML($doc_xml);

?>

