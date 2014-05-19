<?php

    $param = urldecode($_SERVER['QUERY_STRING']);
    //$param = "secteur-nom=&mur-nom=&oeuvre-type=peinture&oeuvre-artiste=Picasso";

    $doc_xml = new DOMDocument();
    $doc_xml->load('donnee.old.xml');
    
    $doc_xsl = new DOMDocument();
    $doc_xsl->load('planV2.xsl');
    
    $proc = new XSLTProcessor();
    $proc->importStylesheet($doc_xsl);
    
    $proc->setParameter(null, 'criteres', $param);
    echo $proc->transformToXml($doc_xml);
    
    //echo $json;
    
//    echo '<p> liste param QUERY_STRING : '.$param;
?>