<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:x="http://www.tei-c.org/ns/1.0"
                xmlns:my="https://github.com/tst-project"
                exclude-result-prefixes="x my">

<xsl:output method="html" encoding="UTF-8" omit-xml-declaration="yes"/>

<xsl:param name="defRoot" select="document('')"/>

<xsl:template match="my:entry">
    <xsl:apply-templates/>
</xsl:template>

<!-- definitions -->

<my:mstypes>
    <my:entry key="#STM">Single-text manuscript</my:entry>
    <my:entry key="#MTM">Multi-text manuscript</my:entry>
    <my:entry key="#CM">Composite manuscript</my:entry>
    <my:entry key="#MVM">Multi-volume manuscript</my:entry>
</my:mstypes>

<my:materials>
    <my:entry key="paper">Paper</my:entry>
    <my:entry key="paper industrial">Paper (industrial)</my:entry>
    <my:entry key="paper handmade">Paper (handmade)</my:entry>
    <my:entry key="paper laid">Paper (laid)</my:entry>
    <my:entry key="palm-leaf">Palm leaf</my:entry>
    <my:entry key="palm-leaf talipot">Palm leaf (talipot)</my:entry>
    <my:entry key="palm-leaf palmyra">Palm leaf (palmyra)</my:entry>
    <my:entry key="birch-bark">Birch bark</my:entry>
    <my:entry key="copper">Copper</my:entry>
    <my:entry key="leather">Leather</my:entry>
</my:materials>

<my:decotype>
    <my:entry key="decorative">decorative</my:entry>
    <my:entry key="diagram">diagram</my:entry>
    <my:entry key="doodle">doodle</my:entry>
    <my:entry key="drawing">drawing</my:entry>
    <my:entry key="painting">painting</my:entry>
    <my:entry key="table">table</my:entry>
</my:decotype>

<my:subtype>
    <my:entry key="beginning">beginning</my:entry>
    <my:entry key="cover">cover</my:entry>
    <my:entry key="detached">detached</my:entry>
    <my:entry key="end">end</my:entry>
    <my:entry key="flyleaf">flyleaf</my:entry>
    <my:entry key="guard-folio">guard folio</my:entry>
    <my:entry key="inserted">inserted</my:entry>
    <my:entry key="intertextual">intertextual</my:entry>
    <my:entry key="marginal">marginal</my:entry>
    <my:entry key="spine">spine</my:entry>
    <my:entry key="title-page">title page</my:entry>
</my:subtype>

<my:scriptRef>
    <my:entry key="#tamilPulliNone">no <x:emph xml:lang="ta" rend="italic">puḷḷi</x:emph></my:entry>
    <my:entry key="#tamilPulliSporadic">sporadic <x:emph xml:lang="ta" rend="italic">puḷḷi</x:emph></my:entry>
    <my:entry key="#tamilPulliRegular">regular <x:emph xml:lang="ta" rend="italic">puḷḷi</x:emph></my:entry>
    <my:entry key="#tamilRa">closed <x:emph xml:lang="ta" rend="italic">kāl</x:emph></my:entry>
    <my:entry key="#tamilOE">long <x:emph xml:lang="ta">ō/ē</x:emph> (double-curled <x:emph xml:lang="ta" rend="italic">kompu</x:emph>)</my:entry>
    <my:entry key="#tamilRRa">modern <x:emph xml:lang="ta" rend="italic">ṟa</x:emph></my:entry>
    <my:entry key="#prsthamatra"><x:emph xml:lang="sa">pṛṣṭhamātrā</x:emph></my:entry>
    <my:entry key="#vaba"><x:emph xml:lang="sa">ba</x:emph> not distinguished</my:entry>
    <my:entry key="#sthascha"><x:emph xml:lang="sa">stha</x:emph> written as <x:emph xml:lang="sa">scha</x:emph></my:entry>
    <my:entry key="#bengaliRaBarBelow"><x:emph xml:lang="sa">ra</x:emph> with bar below</my:entry>
    <my:entry key="#bengaliRaCrossbar"><x:emph xml:lang="sa">ra</x:emph> with cross-bar</my:entry>
    <my:entry key="#bengaliRa"><x:emph xml:lang="sa">ra</x:emph> with dot below</my:entry>
    <my:entry key="#bengaliYa"><x:emph xml:lang="sa">ya</x:emph> with dot below</my:entry>
    <my:entry key="#valapalagilaka">valapalagilaka</my:entry>
    <my:entry key="#dotreph">dot reph</my:entry>
</my:scriptRef>

<my:media>
    <my:entry key="ink">ink</my:entry>
    <my:entry key="incised">incised</my:entry>
    <my:entry key="pencil">pencil</my:entry>
    <my:entry key="black">black</my:entry>
    <my:entry key="brown">brown</my:entry>
    <my:entry key="blue">blue</my:entry>
    <my:entry key="red">red</my:entry>
</my:media>

<my:scribes>
    <my:entry key="#ArielTitleScribe">Ariel's title scribe</my:entry>
    <my:entry key="#EdouardAriel">Edouard Ariel</my:entry>
    <my:entry key="#UmraosinghShergil">Umraosingh Sher-Gil</my:entry>
</my:scribes>

<my:langs>
    <my:entry key="eng">English</my:entry>
    <my:entry key="fra">French</my:entry>
    <my:entry key="deu">German</my:entry>
    <my:entry key="lat">Latin</my:entry>
    <my:entry key="pal">Pali</my:entry>
    <my:entry key="por">Portuguese</my:entry>
    <my:entry key="pra">Prakrit</my:entry>
    <my:entry key="san">Sanskrit</my:entry>
    <my:entry key="tam">Tamil</my:entry>
</my:langs>

<my:entities>
    <my:entry key="#pcs">&#x0BF3;</my:entry>
    <my:entry key="#pcl">&#x0BF3;</my:entry>
    <my:entry key="#ra_r_kal">&#xB86;</my:entry>
    <my:entry key="#kompu">&#x0B8E;</my:entry>
    <my:entry key="#nna=m">&#xBA3;&#xBAE;&#xBCD;</my:entry>
    <my:entry key="#ya=m">&#xBAF;&#xBAE;&#xBCD;</my:entry>
    <my:entry key="#teti">&#x0BF3;</my:entry>
    <my:entry key="#maatham">௴</my:entry>
    <my:entry key="#varudam">௵</my:entry>
    <my:entry key="#patru">௶</my:entry>
    <my:entry key="#eduppu">௷</my:entry>
    <my:entry key="#merpadi">௸</my:entry>
    <my:entry key="#rupai">௹</my:entry>
    <my:entry key="#niluvai">௺</my:entry>
    <my:entry key="#munthiri">𑿀</my:entry>
    <my:entry key="#araikkaani">𑿁</my:entry>
    <my:entry key="#kaani">𑿂</my:entry>
    <my:entry key="#kaal_viisam">𑿃</my:entry>
    <my:entry key="#arai_maa">𑿄</my:entry>
    <my:entry key="#arai_viisam">𑿅</my:entry>
    <my:entry key="#mukkaani">𑿆</my:entry>
    <my:entry key="#mukkaal_viisam">𑿇</my:entry>
    <my:entry key="#maa">𑿈</my:entry>
    <my:entry key="#viisam">𑿉</my:entry>
    <my:entry key="#viisam_alt">𑿊</my:entry>
    <my:entry key="#irumaa">𑿋</my:entry>
    <my:entry key="#araikkaal">𑿌</my:entry>
    <my:entry key="#mumaa">𑿍</my:entry>
    <my:entry key="#muuviisam">𑿎</my:entry>
    <my:entry key="#naangu_maa">𑿏</my:entry>
    <my:entry key="#kaal">𑿐</my:entry>
    <my:entry key="#arai">𑿑</my:entry>
    <my:entry key="#arai_alt">𑿒</my:entry>
    <my:entry key="#mukkaal">𑿓</my:entry>
    <my:entry key="#kiizh">𑿔</my:entry>
    <my:entry key="#nel">𑿕</my:entry>
    <my:entry key="#cevitu">𑿖</my:entry>
    <my:entry key="#aazhaakku">𑿗</my:entry>
    <my:entry key="#uzhakku">𑿘</my:entry>
    <my:entry key="#muuvuzhakku">𑿙</my:entry>
    <my:entry key="#kuruni">𑿚</my:entry>
    <my:entry key="#pathakku">𑿛</my:entry>
    <my:entry key="#mukkuruni">𑿜</my:entry>
    <my:entry key="#kaacu">𑿝</my:entry>
    <my:entry key="#panam">𑿞</my:entry>
    <my:entry key="#pon">𑿟</my:entry>
    <my:entry key="#varaakan">𑿠</my:entry>
    <my:entry key="#paaram">𑿡</my:entry>
    <my:entry key="#kuzhi">𑿢</my:entry>
    <my:entry key="#veli">𑿣</my:entry>
    <my:entry key="#nansey">𑿤</my:entry>
    <my:entry key="#punsey">𑿥</my:entry>
    <my:entry key="#nilam">𑿦</my:entry>
    <my:entry key="#uppalam">𑿧</my:entry>
    <my:entry key="#varavu">𑿨</my:entry>
    <my:entry key="#enn">𑿩</my:entry>
    <my:entry key="#naalathu">𑿪</my:entry>
    <my:entry key="#silvaanam">𑿫</my:entry>
    <my:entry key="#poga">𑿬</my:entry>
    <my:entry key="#aaga">𑿭</my:entry>
    <my:entry key="#vasam">𑿮</my:entry>
    <my:entry key="#muthal">𑿯</my:entry>
    <my:entry key="#muthaliya">𑿰</my:entry>
    <my:entry key="#vakaiyaraa">𑿱</my:entry>
    <my:entry key="#end_of_text">𑿿</my:entry>
</my:entities>

<my:entityclasses>
    <my:entry key="#pcl">aalt</my:entry>
    <my:entry key="#ra_r_kal">aalt</my:entry>
    <my:entry key="#kompu">aalt</my:entry>
    <my:entry key="#nna=m">alig</my:entry>
    <my:entry key="#ya=m">alig</my:entry>
</my:entityclasses>

<my:entitynames>
    <my:entry key="#pcs">piḷḷaiyār cuḻi (short)</my:entry>
    <my:entry key="#pcl">piḷḷaiyār cuḻi (long)</my:entry>
    <my:entry key="#ra_r_kal">ra, r, or kāl</my:entry>
    <my:entry key="#kompu">kompu</my:entry>
    <my:entry key="#nna=m">ṇam ligature</my:entry>
    <my:entry key="#ya=m">yam ligature</my:entry>
    <my:entry key="#teti">tēti</my:entry>
    <my:entry key="#maatham">mācam</my:entry>
    <my:entry key="#varudam">varuṣam</my:entry>
    <my:entry key="#patru">debit</my:entry>
    <my:entry key="#eduppu">credit</my:entry>
    <my:entry key="#merpadi">as above</my:entry>
    <my:entry key="#rupai">rupee</my:entry>
    <my:entry key="#niluvai">balance</my:entry>
    <my:entry key="#munthiri">1/320</my:entry>
    <my:entry key="araikkaani">1/160</my:entry>
    <my:entry key="#kaani">1/80</my:entry>
    <my:entry key="#kaal_viisam">1/64</my:entry>
    <my:entry key="#arai_maa">1/40</my:entry>
    <my:entry key="#arai_viisam">1/32</my:entry>
    <my:entry key="#mukkaal_viisam">3/64</my:entry>
    <my:entry key="#mukkaani">3/80</my:entry>
    <my:entry key="#maa">1/20</my:entry>
    <my:entry key="#viisam">1/16</my:entry>
    <my:entry key="#viisam_alt">1/16</my:entry>
    <my:entry key="#irumaa">1/10</my:entry>
    <my:entry key="#araikkaal">1/8</my:entry>
    <my:entry key="#mumaa">3/20</my:entry>
    <my:entry key="#muuviisam">3/16</my:entry>
    <my:entry key="#naangu_maa">1/5</my:entry>
    <my:entry key="#kaal">1/4</my:entry>
    <my:entry key="#arai">1/2</my:entry>
    <my:entry key="#arai_alt">1/2</my:entry>
    <my:entry key="#mukkaal">3/4</my:entry>
    <my:entry key="#kiizh">less 1/320</my:entry>
    <my:entry key="#nel">nel</my:entry>
    <my:entry key="#cevitu">cevitu</my:entry>
    <my:entry key="#aazhaakku">āḻākku</my:entry>
    <my:entry key="#uzhakku">uḻakku</my:entry>
    <my:entry key="#muuvuzhakku">mūvuḻakku</my:entry>
    <my:entry key="#kuruni">kuṟuṇi</my:entry>
    <my:entry key="#pathakku">patakku</my:entry>
    <my:entry key="#mukkuruni">mukkuṟuṇi</my:entry>
    <my:entry key="#kaacu">kācu</my:entry>
    <my:entry key="#panam">paṇam</my:entry>
    <my:entry key="#pon">poṉ</my:entry>
    <my:entry key="#varaakan">varākaṉ</my:entry>
    <my:entry key="#paaram">pāram</my:entry>
    <my:entry key="#kuzhi">kuḻi</my:entry>
    <my:entry key="#veli">vēļi</my:entry>
    <my:entry key="#nansey">wet cultivation</my:entry>
    <my:entry key="#nilam">land</my:entry>
    <my:entry key="#uppalam">salt pan</my:entry>
    <my:entry key="#varavu">credit</my:entry>
    <my:entry key="#enn">number</my:entry>
    <my:entry key="#naalathu">current</my:entry>
    <my:entry key="#silvaanam">and odd</my:entry>
    <my:entry key="#poga">spent</my:entry>
    <my:entry key="#aaga">total</my:entry>
    <my:entry key="#vasam">in possession</my:entry>
    <my:entry key="#muthal">starting from</my:entry>
    <my:entry key="#muthaliya">et cetera (in a series)</my:entry>
    <my:entry key="#vakaiyaraa">et cetera (of a kind)</my:entry>
    <my:entry key="#end_of_text">end of text</my:entry>
</my:entitynames>

<my:additiontype>
    <my:entry key="catchword">catchword</my:entry>
    <my:entry key="chapter-heading">chapter heading</my:entry>
    <my:entry key="end-title">end title</my:entry>
    <my:entry key="heading">heading</my:entry>
    <my:entry key="intertitle">intertitle</my:entry>
    <my:entry key="register">register</my:entry>
    <my:entry key="running-title">running title</my:entry>
    <my:entry key="table-of-contents">table of contents</my:entry>
    <my:entry key="title">title</my:entry>
    <my:entry key="verse-beginning">verse beginning</my:entry>
    <my:entry key="correction">correction</my:entry>
    <my:entry key="gloss">gloss/commentary</my:entry>
    <my:entry key="commenting-note">text-related note</my:entry>
    <my:entry key="blessing">blessing/benediction</my:entry>
    <my:entry key="completion-statement">completion statement</my:entry>
    <my:entry key="dedication">dedication</my:entry>
    <my:entry key="invocation">invocation</my:entry>
    <my:entry key="postface">postface</my:entry>
    <my:entry key="preface">preface</my:entry>
    <my:entry key="satellite-stanza">satellite stanza</my:entry>
    <my:entry key="seal">seal</my:entry>
    <my:entry key="shelfmark">shelfmark</my:entry>
    <my:entry key="stamp">stamp</my:entry>
    <my:entry key="documenting-note">user-related note</my:entry>
    <my:entry key="rubric">rubric</my:entry>
    <my:entry key="incipit">incipit</my:entry>
    <my:entry key="explicit">explicit</my:entry>
    <my:entry key="colophon">colophon</my:entry>
</my:additiontype>

</xsl:stylesheet>
