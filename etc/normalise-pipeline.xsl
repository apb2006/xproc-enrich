<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform 
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:cx="http://xmlcalabash.com/ns/extensions"
		xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic" 
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xpt="http://xproc-plus-time.googlecode.com"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		exclude-result-prefixes="cx ml xs xsi" 
		version="2.0">
	
	<xsl:output encoding="UTF-8" indent="yes" media-type="application/xproc+xml" 
			method="xml"/>
	
	<xsl:strip-space elements="*"/>
	
	
	<!--  -->
	<xsl:template match="/">
		<xsl:apply-templates select="*" mode="p:normalise"/>
	</xsl:template>
	
	
	<!-- Where a pipeline element is used, replace it with a declare-step. -->
	<xsl:template match="p:pipeline" mode="p:normalise">
		<p:declare-step>
			<xsl:copy-of select="@*"/>
			<xsl:if test="not(@version)">
				<xsl:attribute name="version" select="'1.0'"/>
			</xsl:if>
			<xsl:variable name="ports" as="element()+">
				<p:input port="source"/>
				<p:output port="result"/>
				<xsl:sequence select="p:input | p:output"/>				
			</xsl:variable>
			<xsl:for-each select="$ports">
				<xsl:sort select="name()"/>
				<xsl:copy-of select="."/>
			</xsl:for-each>
			
			<xsl:apply-templates select="* except (p:input, p:output) | text()" mode="#current"/>
		</p:declare-step>
	</xsl:template>
	
	
	<!--  -->
	<xsl:template match="*" mode="p:normalise">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			
			<xsl:apply-templates select="* | text()" mode="#current"/>
		</xsl:copy>
	</xsl:template>
	
</xsl:transform>