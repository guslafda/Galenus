<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="tei">
  
  <xsl:import href="file:///C:/Users/mtrdavlaf/AppData/Local/Programs/Oxygen%20XML%20Editor%2028/frameworks/tei/xml/tei/stylesheet/html/html.xsl"/>
  
  <xsl:template match="tei:app[@type='alternative']"
    mode="printnotes">
    <div class="app">
      <xsl:call-template name="makeAnchor">
        <xsl:with-param name="name">
          <xsl:text>App</xsl:text>
          <xsl:choose>
            <xsl:when test="@xml:id">
              <xsl:value-of select="@xml:id"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:number count="tei:app" level="any"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:for-each select="tei:rdg">
        <xsl:if test="position() gt 1">
          <xsl:text> / </xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
      </xsl:for-each>
    </div>
  </xsl:template>
  
</xsl:stylesheet>