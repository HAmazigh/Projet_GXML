<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:dyn="http://exslt.org/dynamic">
    <xsl:output method="xml" encoding="UTF-8" /><!-- output c'est XML car nous générons du SVG -->
    <xsl:strip-space elements="*" />
    
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

<xsl:template match="/">
    
        <xsl:variable name="xpath">
            <xsl:call-template name="analyse">
                <xsl:with-param name="criteres" select="concat($criteres,'&amp;')"/>
            </xsl:call-template>
        </xsl:variable>
        
         <svg width="800px" height="540px"
             xmlns="http://www.w3.org/2000/svg" 
             xmlns:xlink="http://www.w3.org/1999/xlink">
                 
            <image xlink:href="assets/img/plan_campus.png" width="500" height="500" />

            <xsl:for-each select="dyn:evaluate($xpath)"> 
                <circle cx="{@x}" cy="{@y}" r="5" fill="red" stroke="black" />
            </xsl:for-each>
        </svg>

</xsl:template>

</xsl:stylesheet>
