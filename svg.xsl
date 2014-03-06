<?xml version="1.0" encoding="ISO-8859-1" ?>

<xsl:output method="xml" />

<xsl:template match="/">
    <svg xmlns=""
    xmlns:xlink=""
         xmlxs:dyn="">
    
        <xsl:variable name="xpath">
            <xsl:call-template name="produitXpath">
                <xsl:with-param name="criteres" select="$criteres"/>
            </xsl:call-template>
        </xsl:variable>
        
        <image xlinkmhref="assets/img/plan.jpg" />
        
        <xsl:for-each select="dyn:evaluate($xpath)">
           <rect x="{@x}" y="{@y}" width="50" height="50"/>
        </xsl:for-each>
    </svg>
</xsl:template>
    

