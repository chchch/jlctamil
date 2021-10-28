<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:exsl="http://exslt.org/common"
                xmlns:x="http://www.tei-c.org/ns/1.0"
                xmlns:tst="https://github.com/tst-project"
                exclude-result-prefixes="x tst">

<xsl:output method="html" encoding="UTF-8" omit-xml-declaration="yes"/>

<xsl:template match="@*|node()">
    <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
</xsl:template>

<!-- functions -->

<xsl:template name="lang">
    <xsl:if test="@xml:lang">
        <xsl:attribute name="lang"><xsl:value-of select="@xml:lang"/></xsl:attribute>
    </xsl:if>
</xsl:template>

<xsl:template name="splitlist">
    <xsl:param name="list"/>
    <xsl:param name="nocapitalize"/>
    <xsl:param name="mss" select="$list"/>
    <xsl:param name="map"/>

    <xsl:if test="string-length($mss)">
        <xsl:if test="not($mss=$list)">, </xsl:if>
        <xsl:variable name="splitted" select="substring-before(
                                    concat($mss,' '),
                                  ' ')"/>
        <xsl:variable name="liststr">
            <xsl:choose>
                <xsl:when test="$map">
                    <xsl:variable name="test" select="$TST/*[name() = $map]/tst:entry[@key=$splitted]"/>
                    <xsl:choose>
                        <xsl:when test="$test"> <xsl:apply-templates select="$test"/> </xsl:when>
                        <xsl:otherwise> <xsl:value-of select="$splitted"/> </xsl:otherwise>
                    </xsl:choose>
               </xsl:when>
                <xsl:otherwise>
                <xsl:value-of select="$splitted"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$nocapitalize = 'true'">
                <xsl:copy-of select="$liststr"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="capitalize">
                    <xsl:with-param name="str" select="$liststr"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="splitlist">
            <xsl:with-param name="mss" select=
                "substring-after($mss, ' ')"/>
            <xsl:with-param name="nocapitalize" select="$nocapitalize"/>
            <xsl:with-param name="map" select="$map"/>
        </xsl:call-template>
    </xsl:if>
</xsl:template>

<xsl:template name="capitalize">
    <xsl:param name="str"/>
    <xsl:variable name="LowerCase" select="'abcdefghijklmnopqrstuvwxyz'"/>
    <xsl:variable name="UpperCase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
    <xsl:value-of select="translate(
      substring($str,1,1),
      $LowerCase,
      $UpperCase
      )"/>
    <xsl:value-of select="substring($str,2,string-length($str)-1)"/>
</xsl:template>

<xsl:template name="repeat">
    <xsl:param name="output" />
    <xsl:param name="count" />
    <xsl:if test="$count &gt; 0">
        <xsl:value-of select="$output" />
        <xsl:call-template name="repeat">
            <xsl:with-param name="output" select="$output" />
            <xsl:with-param name="count" select="$count - 1" />
        </xsl:call-template>
    </xsl:if>
</xsl:template>

<xsl:template name="units">
    <xsl:param name="q" select="@quantity"/>
    <xsl:param name="u" select="@unit"/>
    <xsl:value-of select="$q"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="$u"/>
    <xsl:if test="not($q='1')">
        <xsl:text>s</xsl:text>
    </xsl:if>
</xsl:template>

<xsl:template name="certainty">
    <xsl:if test="@cert='low'"><xsl:text> cert-low</xsl:text></xsl:if>
</xsl:template>

</xsl:stylesheet>
