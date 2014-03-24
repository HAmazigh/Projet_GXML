<?xml version="1.0" encoding="ISO-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
<xsl:output method="xml" />

<xsl:template match="/">
    <svg xmlns="http://www.w3.org/2000/svg"
         xmlns:xlink="http://www.w3.org/1999/xlink"
         xmlns:dyn="http://exslt.org/dynamic"
         extension-element-prefixes="dyn"
         width="1000" height="1000">
    
        <xsl:variable name="xpath">
            <xsl:call-template name="analyse">
                <xsl:with-param name="criteres" select="concat($criteres,'&amp;')"/>
            </xsl:call-template>
        </xsl:variable>
        
         <xsl:value-of select="concat('/',$xpath)" />

        <image xlink:href="assets/img/plan_2.png" x="0" y="0" width="100" height="500" />
        <xsl:value-of select="$xpath" />
        
        <xsl:for-each select="dyn:evaluate($xpath)">
			je suis dans la boucle de evaluate
                <rect x="{@x}" y="{@y}" width="10" height="10" style="fill:rgb(0,0,255);stroke-width:3;stroke:rgb(0,0,0)" />
            </xsl:for-each>
            je suis à l'exterieur
        
       <!-- rect x="0" y="0" width="300" height="100" style="fill:rgb(0,0,255);stroke-width:3;stroke:rgb(0,0,0)" / -->
 
    
       
    
    </svg>
    
</xsl:template>



  <xsl:param name="criteres" />

  <xsl:template name="analyse">
    <xsl:param name="criteres"/>
    <xsl:param name="memoireBalise" />

    <xsl:variable name="fragmant" select="substring-before($criteres, '&amp;')" />

    <xsl:variable name="attributValeur" select="substring-after($fragmant, '=')" /> 
    <xsl:variable name="token_l" select="substring-before($fragmant,'=')"/>
    <xsl:variable name="balise" select="substring-before($token_l,'-')" />
    <xsl:variable name="attribut" select="substring-after($token_l,'-')" />

    <xsl:if test="$balise = $memoireBalise" >
      <xsl:variable name="balise_suite" select="concat('[@',$attribut,'=&quot;',$attributValeur,'&quot;]')" />
      <xsl:value-of select="$balise_suite" />

    </xsl:if>

    <xsl:if test="$balise != $memoireBalise" >
      <xsl:variable name="sous_requette" select="concat('/',$balise,'[@',$attribut,'=&quot;',$attributValeur,'&quot;]')" />
      <xsl:value-of select="$sous_requette" />
    </xsl:if>

    <xsl:variable name="cdr_criteres" select="substring-after($criteres,'&amp;')" />
    <xsl:variable name="cdr_length" select="string-length($cdr_criteres)"/>

    <xsl:if test="$cdr_length > 0">

      <xsl:variable name="xpath">
        <xsl:call-template name="analyse">
          <xsl:with-param name="criteres" select="substring-after($criteres,'&amp;')"/>
          <xsl:with-param name="memoireBalise" select="$balise" />
        </xsl:call-template>
      </xsl:variable>

      <xsl:value-of select="$xpath" />
    </xsl:if>    



  </xsl:template>

</xsl:stylesheet>
