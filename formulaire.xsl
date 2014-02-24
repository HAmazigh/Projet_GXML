<?xml version="1.0" encoding="ISO-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" encoding="ISO-8859-1" />
  <xsl:template match="/">
    <html>
      <head><title>Page de Formulaire</title></head> 
      <body>
        <h3> Formulaire de Recherche </h3>
        <form action="http://localhost/GalaxieXml/qcm_TP1/relais.php" method="GET"> 
            <xsl:apply-templates select="//*" />
          <br/>
          <input type="submit"  value="Visualiser"/>
        </form>
      </body>
    </html>
  </xsl:template>


  <xsl:template match="*[not(preceding::node()[name()=name(current())])]">
    <xsl:variable name="balise" select="name()" />
    <xsl:for-each select="@*">
      <xsl:variable name="attribut" select="name()"/>
      <xsl:variable name="nomliste" select="concat($balise,'-',$attribut)" />
      <xsl:value-of select="$nomliste" />

      <select name="{$nomliste}" >
        <option> Tous </option>
        <xsl:apply-templates select="//*[name()=$balise]/@*[name()=$attribut]" />
      </select>
      <br/>
  </xsl:for-each>
</xsl:template>

<xsl:template match="@*"> 
  <option> <xsl:value-of select="." /> </option>
  </xsl:template> 

<xsl:template match="*"> 
  </xsl:template> 


</xsl:stylesheet>
