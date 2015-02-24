<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:c="http://www.w3.org/ns/xproc-step"
	xmlns:cx="http://xmlcalabash.com/ns/extensions"  
	xmlns:p="http://www.w3.org/ns/xproc" 	xmlns:xpt="https://github.com/apb2006/xproc-enrich" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	exclude-result-prefixes="cx  xs xsi" version="2.0">

	<xsl:output encoding="UTF-8" indent="yes" media-type="application/xproc+xml"
		method="xml" />

	<xsl:strip-space elements="*" />


	<!-- -->
	<xsl:template match="/">
	<!-- load libraries for signatures -->
		<xsl:variable name="libs">
		<p:library>
			<xsl:for-each select="(//p:import/@href,'../signatures/xproc-steps-lib.xpl')">
			   <xsl:copy-of select="document(.)/p:library/*"/>
			</xsl:for-each>
	    </p:library>
		</xsl:variable>

		<xsl:apply-templates select="*" mode="p:augment">
			<xsl:with-param name="p:stepDecls" as="element(p:library)"
				select="$libs/p:library"
				tunnel="yes" />
		</xsl:apply-templates>
	</xsl:template>


	<!-- -->
	<xsl:template match="p:declare-step" mode="p:augment">
		<xsl:copy copy-namespaces="yes">
			<xsl:namespace name="c">http://www.w3.org/ns/xproc-step</xsl:namespace>
			<xsl:namespace name="xpt">https://github.com/apb2006/xproc-enrich</xsl:namespace>
			<xsl:copy-of select="@*" />
			<xsl:apply-templates select="* | text()" mode="#current" />
		</xsl:copy>
	</xsl:template>


	<!-- -->
	<xsl:template match="p:input" mode="p:augment">
		<xsl:copy>
			<xsl:copy-of select="@*" />

			<xsl:if test="not(@primary)">
				<xsl:attribute name="primary" select="true()" />
			</xsl:if>
			<xsl:if test="not(@sequence)">
				<xsl:attribute name="sequence" select="false()" />
			</xsl:if>

			<xsl:copy-of select="*" />
		</xsl:copy>
	</xsl:template>


	<!-- Connects a pipeline's implicitly bound output port with the result 
		port of the last step in the pipeline. -->
	<xsl:template match="p:output[not(*)]" mode="p:augment">
		<xsl:copy>
			<xsl:copy-of select="@*" />

			<xsl:if test="not(@primary)">
				<xsl:attribute name="primary" select="true()" />
			</xsl:if>
			<xsl:if test="not(@sequence)">
				<xsl:attribute name="sequence" select="false()" />
			</xsl:if>

			<xsl:variable name="lastStep" as="element()"
				select="parent::p:declare-step/*[last()]" />
			<p:pipe port="result" step="{($lastStep/@name, generate-id($lastStep))[1]}" />
		</xsl:copy>
	</xsl:template>

	<!-- <xsl:template match="p:for-each" mode="p:augment">
	    <xsl:param name="p:stepDecls" as="element(p:library)"
            tunnel="yes" />
        <xsl:variable name="p:contextStepDecl" as="element()?"
            select="$p:stepDecls/p:declare-step[@type = name(current())]" />
	
		<xsl:copy>
			<xsl:copy-of select="@*" />
			<xsl:if test="not(@name)">
                <xsl:attribute name="name" select="generate-id()" />
            </xsl:if>
            <xsl:apply-templates select="p:iteration-source" mode="p:ports" >
            <xsl:with-param name="contextStep" as="element()"
                    select="current()" tunnel="yes" />
            </xsl:apply-templates>
			<xsl:apply-templates select="*" mode="#current" />
		</xsl:copy>
	</xsl:template> -->
	<!-- -->
	<xsl:template match="element()" mode="p:augment">
		<xsl:param name="p:stepDecls" as="element(p:library)"
			tunnel="yes" />
		<xsl:variable name="p:contextStepDecl" as="element()?"
			select="$p:stepDecls/p:declare-step[@type = name(current())]" />

		<xsl:copy>
			<xsl:copy-of select="@*" />
			<xsl:if test="not(@name) and not(self::p:output)">
				<xsl:attribute name="name" select="generate-id()" />
			</xsl:if>
			<xsl:apply-templates select="$p:contextStepDecl/(p:input | p:output)"
				mode="p:ports">
				<xsl:with-param name="contextStep" as="element()"
					select="current()" tunnel="yes" />
			</xsl:apply-templates>
			<xsl:apply-templates select="* except (p:input | p:output) | text()"
				mode="#current" />
		</xsl:copy>
	</xsl:template>

<!-- -->
    <xsl:template match="p:input" mode="p:ports" priority="1">
        <xsl:param name="p:stepDecls" as="element(p:library)"
            tunnel="yes" />
        <xsl:param name="contextStep" as="element()" tunnel="yes" />
        <xsl:variable name="contextPorts" as="element()*"
            select="$contextStep/p:input" />
        <xsl:variable name="contextPort" as="element()?"
            select="$contextPorts[@port = current()/@port]" />

        <xsl:copy copy-namespaces="no">
            <xsl:copy-of select="@* except (@sequence, @primary, @kind)" />
            <xsl:for-each select="$contextPort/@*">
                <xsl:attribute name="{name()}" select="." />
            </xsl:for-each>

            <p:pipeinfo>
                <xsl:element name="p:kind">
                    <xsl:value-of select="(@kind, 'document')[1]" />
                </xsl:element>
                <xsl:element name="p:primary">
                    <xsl:value-of
                        select="(@primary, if (count(../p:input) = 1) then true() else false())[1]" />
                </xsl:element>
                <xsl:element name="p:sequence">
                    <xsl:value-of select="(@sequence, false())[1]" />
                </xsl:element>
            </p:pipeinfo>

            <xsl:choose>
                <xsl:when test="$contextPort/*">
                    <xsl:copy-of select="$contextPort/*" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="nonStepNames" as="xs:string+"
                        select="('p:input', 'p:output', 'p:option', 'p:log', 'p:serialization', 'p:declare-step', 'p:pipeline', 'p:import')" />
                    <xsl:variable name="precedingStep" as="element()?"
                        select="$contextStep/preceding-sibling::*[not(name() = $nonStepNames)][1]" />
                    <xsl:choose>
                        <xsl:when test="@port = 'parameters'">
                            <p:empty />
                        </xsl:when>
                        <xsl:when test="exists($precedingStep)">
                            <p:pipe port="result"
                                step="{($precedingStep/@name, generate-id($precedingStep))[1]}" />
                        </xsl:when>
                        <xsl:otherwise>
                            <p:pipe port="source" step="{$contextStep/parent::p:declare-step/@name}" />
                        </xsl:otherwise>
                    </xsl:choose>

                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>
	<!-- -->
	<xsl:template match="p:iteration-source" mode="p:ports" priority="1">
		<xsl:param name="p:stepDecls" as="element(p:library)"
			tunnel="yes" />
		<xsl:param name="contextStep" as="element()" tunnel="yes" />
		<xsl:variable name="contextPorts" as="element()*"
			select="$contextStep/p:input" />
		<xsl:variable name="contextPort" as="element()?"
			select="$contextPorts[@port = current()/@port]" />

		<xsl:copy copy-namespaces="no">
			<xsl:copy-of select="@* except (@sequence, @primary, @kind)" />
			<xsl:for-each select="$contextPort/@*">
				<xsl:attribute name="{name()}" select="." />
			</xsl:for-each>

			<p:pipeinfo>
				<xsl:element name="p:kind">
					<xsl:value-of select="(@kind, 'document')[1]" />
				</xsl:element>
				<xsl:element name="p:primary">
					<xsl:value-of
						select="(@primary, if (count(../p:input) = 1) then true() else false())[1]" />
				</xsl:element>
				<xsl:element name="p:sequence">
					<xsl:value-of select="(@sequence, false())[1]" />
				</xsl:element>
			</p:pipeinfo>

			<xsl:choose>
				<xsl:when test="$contextPort/*">
					<xsl:copy-of select="$contextPort/*" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="nonStepNames" as="xs:string+"
						select="('p:input', 'p:output', 'p:option', 'p:log', 'p:serialization', 'p:declare-step', 'p:pipeline', 'p:import')" />
					<xsl:variable name="precedingStep" as="element()?"
						select="$contextStep/preceding-sibling::*[not(name() = $nonStepNames)][1]" />
					<xsl:choose>
						<xsl:when test="@port = 'parameters'">
							<p:empty />
						</xsl:when>
						<xsl:when test="exists($precedingStep)">
							<p:pipe port="result"
								step="{($precedingStep/@name, generate-id($precedingStep))[1]}" />
						</xsl:when>
						<xsl:otherwise>
							<p:pipe port="source" step="{$contextStep/parent::p:declare-step/@name}" />
						</xsl:otherwise>
					</xsl:choose>

				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>


	<!-- Embed the declared output ports of a step in a pipeinfo element to 
		ensure the XProc processor cannot see them. -->
	<xsl:template match="p:output" mode="p:ports" priority="1">
		<p:pipeinfo>
			<xsl:copy copy-namespaces="no">
				<xsl:attribute name="port" select="@port" />
				<xsl:attribute name="primary"
					select="(@primary, if (count(../p:output) = 1) then true() else false())[1]" />
				<xsl:attribute name="sequence" select="(@sequence, false())[1]" />
			</xsl:copy>
		</p:pipeinfo>
	</xsl:template>


	<!-- Replicate these nodes. -->
	<xsl:template
		match="p:data | p:document | p:documentation | p:empty | p:import | p:inline |
		 p:log | p:option | p:pipe | p:pipeinfo | p:serialization |p:iteration-source" 
		mode="p:augment">
		<xsl:copy-of select="." />
	</xsl:template>
</xsl:transform>