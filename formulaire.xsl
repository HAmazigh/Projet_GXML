<?xml version="1.0" encoding="ISO-8859-1" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" encoding="ISO-8859-1" />
  <xsl:template match="/">
    <html>
      <head><title>Page de Formulaire</title></head> 
      <body>
        <form action="relais.php" method="GET"> 
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

<<<<<<< HEAD
<xsl:template match="@*"> 
  <option> <xsl:value-of select="." /> </option>
=======
<xsl:template match="@*[not(preceding::*/@*[.=current()])]"> 
  <option>
        <xsl:value-of select="." /> </option>
>>>>>>> 3c8a095c8f17a609dda3836a0cd9c19daa2c9edf
  </xsl:template> 

<xsl:template match="*"> 
  </xsl:template> 


</xsl:stylesheet>
