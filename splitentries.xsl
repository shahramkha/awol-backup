<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:atom='http://www.w3.org/2005/Atom'
  exclude-result-prefixes="#all"
  version="2.0">
  
  <xsl:output encoding="UTF-8" indent="yes" media-type="application/atom+xml" method="xml" name="atom" exclude-result-prefixes="atom" cdata-section-elements="atom:content"/>
  
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="atom:feed">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="atom:entry[atom:category[@term='http://schemas.google.com/blogger/2008/kind#post' and @scheme='http://schemas.google.com/g/2005#kind']]">
    <xsl:variable name="fn">
      <xsl:text>post-</xsl:text>
      <xsl:value-of select="substring-after(atom:id, '.post-')"/>
    </xsl:variable>
    <xsl:result-document format="atom" href="{$fn}-atom.xml">
      <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates/>
      </xsl:copy>
    </xsl:result-document>
  </xsl:template>
  
  <xsl:template match="atom:content[@type='html']">
    <xsl:copy-of select="."/>
  </xsl:template>
  
  <xsl:template match="atom:*[ancestor::atom:entry]">
    <xsl:copy>
      <xsl:copy-of select="@*"/>      
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="text()">
    <xsl:value-of select="."/>
  </xsl:template>
  
  <!-- suppress all elements not matched by other templates -->
  <xsl:template match="*">
    <xsl:variable name="thisname" select="name()"/>
    <xsl:if test="not(preceding::*[name()=$thisname])">
      <xsl:message>suppressed: <xsl:value-of select="$thisname"/></xsl:message>
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>