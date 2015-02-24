<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform 
		xmlns:c="http://www.w3.org/ns/xproc-step"
		xmlns:cx="http://xmlcalabash.com/ns/extensions"
		xmlns:p="http://www.w3.org/ns/xproc"
		xmlns:xpt="https://github.com/apb2006/xproc-enrich" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		exclude-result-prefixes="cx  xs xsi" 
		version="2.0">
	
	<xsl:output encoding="UTF-8" indent="yes" media-type="application/xproc+xml" method="xml"/>
	
	<xsl:strip-space elements="*"/>
	
	
	<!--  -->
	<xsl:template match="/">
		<xsl:variable name="labelPipeline" as="element()">
			<xsl:apply-templates select="*" mode="p:label-ports"/>
		</xsl:variable>
		
		<xsl:apply-templates select="$labelPipeline" mode="p:connect"/>
	</xsl:template>
	
	
	<!-- Adds IDs to each port. -->
	<xsl:template match="p:input | p:output" mode="p:label-ports">
		<xsl:copy>
			<xsl:attribute name="xml:id" select="generate-id()"/>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates select="* | text()" mode="#current"/>
		</xsl:copy>
	</xsl:template>
	
	
	<!-- Binds the pipeline's input ports to the first steps input port. -->
	<xsl:template match="p:declare-step/p:input" mode="p:connect">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:attribute name="xpt:boundPorts" select="string-join(../*//p:input[p:pipe[@step = current()/../@name][@port = current()/@port]]/@xml:id, ' ')"/>
			<xsl:apply-templates select="* | text()" mode="#current"/>
		</xsl:copy>
	</xsl:template>
	
	
	<!-- Binds the pipeline's output port to the last step's 'primary' output port. -->
	<xsl:template match="p:declare-step/p:output" mode="p:connect" priority="2">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:if test="not(@primary)">
				<xsl:attribute name="primary" select="true()"/>
			</xsl:if>
			<xsl:attribute name="xpt:boundPorts" select="../p:*[@name = current()/p:pipe/@step]
			                                    [p:pipeinfo/p:output[@port = current()/p:pipe/@port]]/
			p:pipeinfo/p:output[@port = current()/p:pipe/@port]/@xml:id"/>
			<xsl:apply-templates select="* | text()" mode="#current"/>
		</xsl:copy>
	</xsl:template>


	
	<!--  -->
	<xsl:template match="p:input[p:pipe]" mode="p:connect">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:attribute name="xpt:boundPorts" select="string-join(xpt:find-bound-output-ports(.., self::*), ' ')"/>
			<xsl:apply-templates select="* | text()" mode="#current"/>
		</xsl:copy>
	</xsl:template>
	<!-- apb -->
    <xsl:template match="p:output[p:pipe]" mode="p:connect">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="xpt:boundPorts" select="string-join(xpt:find-bound-output-ports(.., self::*), ' ')"/>
            <xsl:apply-templates select="* | text()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
	
	<!--  -->
	<xsl:template match="p:output" mode="p:connect">
		<xsl:variable name="parentStep" as="element()" select="if (name(..) = 'p:declare-step') then .. else ../.."/>
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:attribute name="xpt:boundPorts" select="string-join(xpt:find-bound-input-ports($parentStep, self::*), ' ')"/>
			<xsl:apply-templates select="* | text()" mode="#current"/>
		</xsl:copy>
	</xsl:template>
	
	
	<!-- Returns a white-space separated list of port ids. -->
	<xsl:function name="xpt:find-bound-input-ports" as="xs:string*">
		<xsl:param name="contextStep" as="element()"/>
		<xsl:param name="contextPort" as="element()"/>
		<xsl:variable name="position" as="xs:integer" select="xpt:step-position($contextStep)"/>
		<xsl:variable name="isLast" as="xs:boolean" select="$position = xpt:last($contextStep)"/>
		<xsl:variable name="boundPortIds" as="xs:string*" select="root($contextStep)//p:input[p:pipe/@step = $contextStep/@name][p:pipe/@port = $contextPort/@port]/@xml:id"/>
<!-- 		<xsl:message>find-bound-input-ports -->
<!--         <xsl:value-of select="name($contextStep)"/> -->
<!--         Position:<xsl:value-of select="$position"/> -->
<!--         boundPortIds:<xsl:value-of select="$boundPortIds"/> -->
<!--         </xsl:message> -->
		<xsl:sequence select="((if ($isLast and $contextPort/@primary = true() and not(exists($boundPortIds))) then $contextStep/../p:output[@primary = true()]/@xml:id else ()), $boundPortIds)"/>
	</xsl:function>
	
	
	<!-- Returns a white-space separated list of port ids. -->
	<xsl:function name="xpt:find-bound-output-ports" as="xs:string*">
		<xsl:param name="contextStep" as="element()"/>
		<xsl:param name="contextPort" as="element()"/>
		<xsl:variable name="position" as="xs:integer" select="xpt:step-position($contextStep)"/>
		<xsl:variable name="boundPortIds" as="xs:string*" select="root($contextStep)//p:output[../../@name = $contextPort/p:pipe/@step
		 ]/@xml:id"/>
<!-- 		<xsl:message>find-bound-output-ports -->
<!-- 		<xsl:value-of select="name($contextStep)"/> -->
<!-- 		Position:<xsl:value-of select="$contextPort/p:pipe/@step"/> -->
<!-- 		boundPortIds:<xsl:value-of select="$boundPortIds"/> -->
<!-- 		</xsl:message> -->
		<xsl:sequence select="
			(
				(
					if (
						$position = 1 and 
						data($contextPort/p:pipeinfo/p:primary) = true() and 
						not(exists($boundPortIds))
					) then 
						$contextStep/../p:input[@primary = true()]/@xml:id 
					else 
						()
				), 
				$boundPortIds
			)
		"/>
	</xsl:function>
	
	
	<xsl:function name="xpt:last" as="xs:integer">
		<xsl:param name="contextStep" as="element()"/>
		
		<xsl:value-of select="count($contextStep/../child::*) - count($contextStep/../child::*[self::p:import | self::p:input | self::p:output | self::p:serialization | self::p:option | self::p:document | self::p:inline | self::p:data | self::p:empty | self::p:pipe | self::p:pipeinfo | self::p:documentation | p:declare-step])"/>
	</xsl:function>
	
	
	<!-- Returns the position of the step in the sequence of steps. -->
	<xsl:function name="xpt:step-position" as="xs:integer">
		<xsl:param name="contextStep" as="element()"/>
		
		<xsl:value-of select="(count($contextStep/preceding-sibling::*) - count($contextStep/preceding-sibling::*[self::p:import | self::p:input | self::p:output | self::p:serialization | self::p:option | self::p:document | self::p:inline | self::p:data | self::p:empty | self::p:pipe | self::p:pipeinfo | self::p:documentation | p:declare-step])) + 1"/>
	</xsl:function>
	
	
	<!--  -->
	<xsl:template match="*" mode="p:connect p:label-ports">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			
			<xsl:apply-templates select="* | text()" mode="#current"/>
		</xsl:copy>
	</xsl:template>
</xsl:transform>