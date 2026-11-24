<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="tei">
  
  <xsl:import href="file:///C:/Users/mtrdavlaf/AppData/Local/Programs/Oxygen%20XML%20Editor%2028/frameworks/tei/xml/tei/stylesheet/html/html.xsl"/>
  <xsl:param name="cssFile" select="'my-tei.css'"/>
  
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
  
  <xsl:template match="tei:text/tei:body">
    <xsl:variable name="header" select="ancestor::tei:TEI/tei:teiHeader"/>
    <xsl:variable name="ms" select="$header/tei:fileDesc/tei:sourceDesc/tei:msDesc"/>
    <xsl:variable name="identifier" select="$ms/tei:msIdentifier"/>
    <xsl:variable name="facsimile" select="$identifier/tei:idno[@type='URI'][1]"/>
    
    <div class="reading-layout">
      <div class="transcription">
        <xsl:apply-imports/>
      </div>
      
      <div class="facsimile-column">
        <xsl:if test="normalize-space($identifier/tei:idno[@type='shelfmark'][1]) = 'Pal. lat. 1088'">
          <figure class="manuscript-image">
            <a href="https://digi.vatlib.it/view/MSS_Pal.lat.1088/0020">
              <img
                src="https://digi.vatlib.it/iiifimage/MSS_Pal.lat.1088/Pal.lat.1088_0020_fa_0007v.jp2/full/1000,/0/default.jpg"
                alt="Open folio 7v of Pal. lat. 1088 in the Vatican Library viewer"/>
            </a>
            <figcaption>Pal. lat. 1088, fol. 7v · Biblioteca Apostolica Vaticana</figcaption>
          </figure>
        </xsl:if>
        <xsl:if test="normalize-space($identifier/tei:idno[@type='shelfmark'][1]) = 'Codex 304(514)'">
          <figure class="manuscript-image">
            <a href="{normalize-space($facsimile)}">
              <img src="https://media.e-codices.ch/iip/sbe/sbe-0304/sbe-0304_004.jp2/full/full/0/default.jpg"
                alt="Open Einsiedeln, Codex 304(514), page 4, in e-codices"/>
            </a>
            <figcaption>
              Einsiedeln, Stiftsbibliothek, Codex 304(514) · e-codices, CC BY-NC 4.0
            </figcaption>
          </figure>
        </xsl:if>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template name="preAddressHook">
    <xsl:variable name="header" select="root(.)/tei:TEI/tei:teiHeader"/>
    <xsl:variable name="ms" select="$header/tei:fileDesc/tei:sourceDesc/tei:msDesc"/>
    <xsl:variable name="identifier" select="$ms/tei:msIdentifier"/>
    <xsl:variable name="work" select="$ms/tei:msContents/tei:msItem[1]"/>
    <xsl:variable name="facsimile" select="$identifier/tei:idno[@type='URI'][1]"/>
    <xsl:if test="$ms">
      <section class="manuscript-metadata">
        <h2>Metadata</h2>
        <dl>
          <dt>Work</dt>
          <dd><xsl:value-of select="$work/tei:title[1]"/></dd>
          
          <dt>Original author</dt>
          <dd><xsl:value-of select="$work/tei:author[1]"/></dd>
          
          <dt>Repository</dt>
          <dd>
            <xsl:value-of select="$identifier/tei:repository"/>
            <xsl:if test="$identifier/tei:settlement[normalize-space(.)]">
              <br/>
              <xsl:value-of select="$identifier/tei:settlement"/>
            </xsl:if>
          </dd>          
          
          <dt>Shelfmark</dt>
          <dd><xsl:value-of select="$identifier/tei:idno[@type='shelfmark'][1]"/></dd>
          
          <dt>Date</dt>
          <dd><xsl:value-of select="normalize-space($ms/tei:history/tei:origin/tei:origDate[1])"/></dd>
        </dl>
        
        <xsl:if test="$facsimile">
          <p><a href="{normalize-space($facsimile)}">View digital facsimile</a></p>
        </xsl:if>
      </section>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
