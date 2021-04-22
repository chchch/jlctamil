<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:x="http://www.tei-c.org/ns/1.0"
                xmlns:my="https://github.com/tst-project"
                exclude-result-prefixes="x my">

<xsl:output method="html" encoding="UTF-8" omit-xml-declaration="yes"/>

<xsl:template match="x:text">
    <xsl:variable name="textid" select="substring-after(@corresp,'#')"/>
    <xsl:element name="hr">
        <xsl:attribute name="id">
            <xsl:text>text-</xsl:text>
            <xsl:value-of select="$textid"/>
        </xsl:attribute>
    </xsl:element>
    <xsl:element name="section">
        <xsl:attribute name="class">teitext</xsl:attribute>
        <xsl:call-template name="lang"/>
        <xsl:element name="table">
            <xsl:attribute name="class">texttitle</xsl:attribute>
            <xsl:element name="tr">
                <xsl:element name="td">
                    <xsl:variable name="title" select="//x:msItem[@xml:id=$textid]/x:title"/>
                    <xsl:attribute name="lang"><xsl:value-of select="$title/@xml:lang"/></xsl:attribute>
                    <span class="line-view-icon" title="diplomatic display">
                        <svg height='25px' width='25px' fill="#000000" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" x="0px" y="0px" viewBox="0 0 512 512"><g id="#hamburger"><g><g><path d="M486,493H26c-3.866,0-7-3.134-7-7V26c0-3.866,3.134-7,7-7h460c3.866,0,7,3.134,7,7v460C493,489.866,489.866,493,486,493z      M33,479h446V33H33V479z"></path></g><g><path d="M436,133H86c-3.866,0-7-3.134-7-7s3.134-7,7-7h350c3.866,0,7,3.134,7,7S439.866,133,436,133z"></path></g><g><path d="M436,263H86c-3.866,0-7-3.134-7-7s3.134-7,7-7h350c3.866,0,7,3.134,7,7S439.866,263,436,263z"></path></g><g><path d="M436,393H86c-3.866,0-7-3.134-7-7s3.134-7,7-7h350c3.866,0,7,3.134,7,7S439.866,393,436,393z"></path></g></g></g></svg>
                    </span>
                    <xsl:apply-templates select="$title"/>
                </xsl:element>
                <xsl:element name="td">
                    <xsl:attribute name="style">text-align: right;</xsl:attribute>
                    <xsl:attribute name="lang">en</xsl:attribute>
                    <xsl:variable name="cu" select="substring-after(@synch,'#')"/>
                    <xsl:value-of select="$cu"/>
                    <xsl:if test="$cu and $textid">
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                    <xsl:value-of select="$textid"/>
                </xsl:element>
            </xsl:element>
        </xsl:element>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<!--xsl:template match="x:text/@n">
    <xsl:element name="h2">
        <xsl:attribute name="lang">en</xsl:attribute>
        <xsl:value-of select="."/>
    </xsl:element>
</xsl:template-->

<xsl:template match="x:text/x:body">
    <xsl:apply-templates/>
</xsl:template>

<!-- transcription styling -->

<xsl:template match="x:del">
    <xsl:variable name="rend" select="@rend"/>
    <xsl:element name="del">
        <xsl:attribute name="data-anno">
            <xsl:text>deleted</xsl:text>
            <xsl:if test="string($rend)">
                <xsl:text> (</xsl:text>
                <xsl:value-of select="$rend"/>
                <xsl:text>)</xsl:text>
           </xsl:if>
        </xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:add">
    <xsl:element name="ins">
        <xsl:attribute name="class">add</xsl:attribute>
        <xsl:attribute name="data-anno">
            <xsl:text>inserted</xsl:text>
            <xsl:if test="@place"> (<xsl:value-of select="@place"/>)</xsl:if>
            <xsl:if test="@rend"> (<xsl:value-of select="@rend"/>)</xsl:if>
        </xsl:attribute>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:subst">
    <xsl:element name="span">
    <xsl:attribute name="class">subst</xsl:attribute>
    <xsl:attribute name="data-anno">
        <xsl:text>substitution</xsl:text>
        <xsl:if test="@rend">
            <xsl:text> (</xsl:text><xsl:value-of select="@rend"/><xsl:text>)</xsl:text>
        </xsl:if>
    </xsl:attribute>
    <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:supplied">
    <xsl:element name="span">
        <xsl:attribute name="class">supplied</xsl:attribute>
        <xsl:attribute name="data-anno">
            <xsl:text>supplied</xsl:text>
            <xsl:if test="@reason">
                <xsl:text> (</xsl:text><xsl:value-of select="@reason"/><xsl:text>)</xsl:text>
            </xsl:if>
        </xsl:attribute>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:pc">
    <xsl:element name="span">
        <xsl:attribute name="class">invisible</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:sic">
    <xsl:element name="span">
        <xsl:attribute name="class">sic</xsl:attribute>
        <xsl:call-template name="lang"/>
        <xsl:attribute name="data-anno">sic</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:gap">
    <xsl:element name="span">
        <xsl:attribute name="lang">en</xsl:attribute>
        <xsl:attribute name="class">gap</xsl:attribute>
        <xsl:attribute name="data-anno">
            <xsl:text>gap</xsl:text>
                <xsl:choose>
                    <xsl:when test="@quantity">
                        <xsl:text> of </xsl:text><xsl:value-of select="@quantity"/>
                        <xsl:choose>
                        <xsl:when test="@unit">
                        <xsl:text> </xsl:text><xsl:value-of select="@unit"/>
                        </xsl:when>
                        <xsl:otherwise>
                        <xsl:text> akṣara</xsl:text>
                        </xsl:otherwise>
                        </xsl:choose>
                            <xsl:if test="@quantity &gt; '1'">
                                <xsl:text>s</xsl:text>
                            </xsl:if>
                    </xsl:when>
                    <xsl:when test="@extent">
                        <xsl:text> of </xsl:text><xsl:value-of select="@extent"/>
                    </xsl:when>
                </xsl:choose>
                <xsl:if test="@reason">
                    <xsl:text> (</xsl:text><xsl:value-of select="@reason"/><xsl:text>)</xsl:text>
                </xsl:if>
        </xsl:attribute>
        <xsl:choose>
            <xsl:when test="count(./*) &gt; 0">
                <xsl:text>[</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>]</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="span">
                <xsl:text>...</xsl:text>
                <xsl:choose>
                    <xsl:when test="@quantity &gt; 1">
                        <xsl:call-template name="repeat">
                            <xsl:with-param name="output"><xsl:text>..</xsl:text></xsl:with-param>
                            <xsl:with-param name="count" select="@quantity"/>
                        </xsl:call-template>

                    </xsl:when>
                    <xsl:when test="@extent">
                        <xsl:variable name="extentnum" select="translate(@extent,translate(@extent,'0123456789',''),'')"/>
                        <xsl:if test="number($extentnum) &gt; 1">
                            <xsl:call-template name="repeat">
                                <xsl:with-param name="output"><xsl:text>..</xsl:text></xsl:with-param>
                                <xsl:with-param name="count" select="$extentnum"/>
                            </xsl:call-template>
                        </xsl:if>
                    </xsl:when>
                </xsl:choose>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:element>
</xsl:template>

<xsl:template match="x:space">
    <xsl:element name="span">
        <xsl:attribute name="lang">en</xsl:attribute>
        <xsl:attribute name="class">space</xsl:attribute>
        <xsl:attribute name="data-anno">
            <xsl:text>space</xsl:text>
            <xsl:if test="@quantity">
                <xsl:text> of </xsl:text><xsl:value-of select="@quantity"/>
                <xsl:choose>
                <xsl:when test="@unit">
                <xsl:text> </xsl:text><xsl:value-of select="@unit"/>
                    <xsl:if test="@quantity &gt; '1'">
                        <xsl:text>s</xsl:text>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                <xsl:text> akṣara</xsl:text>
                    <xsl:if test="@quantity &gt; '1'">
                        <xsl:text>s</xsl:text>
                    </xsl:if>
                </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:if test="@rend">
                <xsl:text> (</xsl:text><xsl:value-of select="@rend"/><xsl:text>)</xsl:text>
            </xsl:if>
        </xsl:attribute>
        <xsl:choose>
            <xsl:when test="count(./*) &gt; 0">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="span">
                <xsl:text>_</xsl:text>
                <xsl:choose>
                    <xsl:when test="@quantity &gt; 1">
                        <xsl:call-template name="repeat">
                            <xsl:with-param name="output"><xsl:text>_&#x200B;</xsl:text></xsl:with-param>
                            <xsl:with-param name="count" select="@quantity"/>
                        </xsl:call-template>

                    </xsl:when>
                    <xsl:when test="@extent">
                        <xsl:variable name="extentnum" select="translate(@extent,translate(@extent,'0123456789',''),'')"/>
                        <xsl:if test="number($extentnum) &gt; 1">
                            <xsl:call-template name="repeat">
                                <xsl:with-param name="output"><xsl:text>_&#x200B;</xsl:text></xsl:with-param>
                                <xsl:with-param name="count" select="$extentnum"/>
                            </xsl:call-template>
                        </xsl:if>
                    </xsl:when>
                </xsl:choose>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:element>
</xsl:template>

<xsl:template match="x:g">
        <xsl:variable name="ref" select="@ref"/>
        <xsl:element name="span">
            <xsl:variable name="cname" select="$defRoot//my:entityclasses/my:entry[@key=$ref]"/>
            <xsl:attribute name="class">
                <xsl:text>gaiji</xsl:text>
                <xsl:if test="$cname">
                    <xsl:text> </xsl:text><xsl:value-of select="$cname"/>
                </xsl:if>
            </xsl:attribute>
            <xsl:variable name="ename" select="$defRoot//my:entitynames/my:entry[@key=$ref]"/>
            <xsl:if test="$ename">
                <xsl:attribute name="data-anno"><xsl:value-of select="$ename"/></xsl:attribute>
            </xsl:if>

            <xsl:variable name="txt" select="$defRoot//my:entities/my:entry[@key=$ref]"/>
            <xsl:if test="not(node()) and $txt">
                <xsl:value-of select="$txt"/>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
</xsl:template>
<xsl:template match="x:milestone">
    <xsl:element name="span">
        <xsl:attribute name="class">milestone</xsl:attribute>
        <xsl:attribute name="lang">en</xsl:attribute>
        <xsl:apply-templates select="@facs"/>
        <xsl:choose>
        <xsl:when test="@unit">
            <xsl:value-of select="@unit"/>
            <xsl:text> </xsl:text>
        </xsl:when>
        <xsl:when test="/x:TEI/x:teiHeader/x:fileDesc/x:sourceDesc/x:msDesc/x:physDesc/x:objectDesc[@form = 'pothi']">
            <xsl:text>folio </xsl:text>
        </xsl:when>
<xsl:when test="/x:TEI/x:teiHeader/x:fileDesc/x:sourceDesc/x:msDesc/x:physDesc/x:objectDesc[@form = 'book']">
            <xsl:text>page </xsl:text>
        </xsl:when>
        </xsl:choose>
<xsl:value-of select="@n"/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:locus">
    <xsl:element name="span">
        <xsl:attribute name="class">
            <xsl:text>locus </xsl:text>
            <xsl:value-of select="@rend"/>
        </xsl:attribute>
        <xsl:apply-templates select="@facs"/>
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="@facs">
    <xsl:attribute name="data-loc">
        <xsl:value-of select="."/>
    </xsl:attribute>
    <xsl:attribute name="data-anno">
        <xsl:text>image </xsl:text>
        <xsl:value-of select="."/>
    </xsl:attribute>
</xsl:template>

<xsl:template match="x:lb">
    <xsl:element name="span">
        <xsl:attribute name="class">lb</xsl:attribute>
        <xsl:attribute name="lang">en</xsl:attribute>
        <xsl:if test="@break = 'no'">
            <xsl:attribute name="data-nobreak">true</xsl:attribute>
        </xsl:if>
        <xsl:apply-templates select="@n"/>
        <xsl:text>&#x2424;</xsl:text>
    </xsl:element>
</xsl:template>

<xsl:template match="x:lb/@n">
    <xsl:attribute name="data-anno">
        <xsl:text>line </xsl:text>
        <xsl:value-of select="."/>
    </xsl:attribute>
    <xsl:attribute name="data-n">
        <xsl:value-of select="."/>
    </xsl:attribute>
</xsl:template>

<xsl:template match="x:pb/@n">
</xsl:template>

<xsl:template match="x:pb">
<xsl:element name="span">
    <xsl:attribute name="class">pb</xsl:attribute>
    <xsl:attribute name="lang">en</xsl:attribute>
    <xsl:variable name="facs" select="@facs"/>
    <xsl:if test="$facs">
    <xsl:attribute name="data-loc">
        <xsl:value-of select="$facs"/>
    </xsl:attribute>
    </xsl:if>
    <xsl:if test="@n">
        <xsl:attribute name="data-n"><xsl:value-of select="@n"/></xsl:attribute>
    </xsl:if>
    <xsl:attribute name="data-anno">
        <xsl:if test="@n">
            <xsl:variable name="unit" select="//x:extent/x:measure/@unit"/>
            <xsl:choose>
                <xsl:when test="$unit">
                    <xsl:value-of select="$unit"/><xsl:text> </xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>page </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select="@n"/>
        </xsl:if>
        <xsl:if test="$facs">
            <xsl:text> image </xsl:text>
            <xsl:value-of select="$facs"/>
        </xsl:if>
    </xsl:attribute>
    <xsl:text>&#x2424;</xsl:text>
</xsl:element>
</xsl:template>

<xsl:template match="x:sup">
    <xsl:element name="sup">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:sub">
    <xsl:element name="sub">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:quote | x:q">
    <xsl:element name="span">
        <xsl:call-template name="lang"/>
        <xsl:attribute name="class">quote</xsl:attribute>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:quote[@rend='block']">
    <xsl:element name="blockquote">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:foreign">
    <xsl:element name="em">
        <xsl:call-template name="lang"/>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:term">
    <xsl:element name="span">
        <xsl:call-template name="lang"/>
        <xsl:attribute name="class">
            <xsl:text>term </xsl:text>
            <xsl:value-of select="@rend"/>
        </xsl:attribute>
        <xsl:apply-templates />
    </xsl:element>
</xsl:template>

<xsl:template match="x:unclear">
    <xsl:element name="span">
        <xsl:attribute name="class">unclear</xsl:attribute>
        <xsl:attribute name="data-anno">
            <xsl:text>unclear</xsl:text>
            <xsl:if test="@reason">
                <xsl:text> (</xsl:text>
                <xsl:value-of select="@reason"/>
                <xsl:text>)</xsl:text>
            </xsl:if>
        </xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:caesura">
<xsl:variable name="pretext" select="preceding::text()[1]"/>
<xsl:if test="normalize-space(substring($pretext,string-length($pretext))) != ''">
    <span class="caesura">-</span>
</xsl:if>
    <xsl:element name="br">
    <xsl:attribute name="class">caesura</xsl:attribute>
    </xsl:element>
</xsl:template>

<xsl:template match="x:expan">
    <xsl:element name="span">
        <xsl:call-template name="lang"/>
        <xsl:attribute name="class">expan</xsl:attribute>
        <xsl:attribute name="data-anno">abbreviation</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:ex">
    <xsl:element name="span">
        <xsl:call-template name="lang"/>
        <xsl:attribute name="class">ex</xsl:attribute>
        <xsl:attribute name="data-anno">editorial expansion</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:note">
<xsl:element name="span">
    <xsl:call-template name="lang"/>
    <xsl:attribute name="class">note
        <xsl:choose>
            <xsl:when test="@place='above' or @place='top-margin' or @place='left-margin'"> super</xsl:when>
            <xsl:when test="@place='below' or @place='bottom-margin' or @place='right-margin'"> sub</xsl:when>
            <xsl:otherwise> inline</xsl:otherwise>
        </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="data-anno">note
        <xsl:if test="@place"> (<xsl:value-of select="@place"/>)</xsl:if>
        <xsl:if test="@resp"> (by <xsl:value-of select="@resp"/>)</xsl:if>
    </xsl:attribute>
    <xsl:apply-templates />
</xsl:element>
</xsl:template>

<xsl:template match="x:seg">
    <xsl:element name="span">
        <xsl:variable name="func" select="@function"/>
        <xsl:if test="$func">
            <xsl:attribute name="data-anno">
                <xsl:variable name="funcname" select="$defRoot//my:additiontype/my:entry[@key=$func]"/>
                <xsl:choose>
                    <xsl:when test="$funcname">
                        <xsl:value-of select="$funcname"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$func"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>
</xsl:stylesheet>
