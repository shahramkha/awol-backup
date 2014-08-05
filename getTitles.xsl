<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:a='http://www.w3.org/2005/Atom'
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text" indent="no"/>
    <xsl:template match="/">
        <xsl:apply-templates select="//a:entry"/>
    </xsl:template>
    
    <xsl:template match="a:entry[a:category/@term='http://schemas.google.com/blogger/2008/kind#template']"/>
    <xsl:template match="a:entry[a:category/@term='http://schemas.google.com/blogger/2008/kind#settings']"/>
    <xsl:template match="a:entry[a:category/@term='http://schemas.google.com/blogger/2008/kind#comment']"/>
    
    <xsl:template match="a:entry">
        <xsl:text>"</xsl:text>
        <xsl:call-template name="cleantitle"/>
        <xsl:text>","</xsl:text>
        <xsl:value-of select="a:link[@rel='alternate' and @type='text/html']/@href"/>
        <xsl:text>","</xsl:text>
        <xsl:value-of select="a:id"/>
        <xsl:text>"
</xsl:text>
    </xsl:template>
    
    
    <xsl:template match="*"/>
    
    <xsl:template name="cleantitle">
        <xsl:text></xsl:text>
        <xsl:value-of select="replace(normalize-space(normalize-unicode(a:title)),'&quot;', '')"/>
        <xsl:text></xsl:text>
    </xsl:template>
</xsl:stylesheet>