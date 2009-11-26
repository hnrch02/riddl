<!DOCTYPE html>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" doctype-public="XSLT-compat"/>
  <xsl:template match="/keys">
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
      <head>
         <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
         <title>List of Keys</title>
      </head>
      <body>
        <ul>
          <xsl:for-each select="key">
            <li>
              <xsl:element name="a">
                <xsl:attribute name="href">
                  <xsl:value-of select="text()"/>
                </xsl:attribute>
                <xsl:value-of select="text()"/>
              </xsl:element>
            </li>  
          </xsl:for-each>
        </ul>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
