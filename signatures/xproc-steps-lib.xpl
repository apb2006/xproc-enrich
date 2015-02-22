<?xml version="1.0" encoding="UTF-8"?>
<p:library xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:p="http://www.w3.org/ns/xproc"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.0">


	<p:declare-step type="p:add-attribute">
		<p:input port="source" />
		<p:output port="result" />
		<p:option name="match" xsi:type="" required="true" />                      <!-- XSLTMatchPattern -->
		<p:option name="attribute-name" xsi:type="xs:QName" required="true" />             <!-- -->
		<p:option name="attribute-prefix" xsi:type="NCName" />                           <!-- -->
		<p:option name="attribute-namespace" xsi:type="anyURI" />                        <!-- -->
		<p:option name="attribute-value" xsi:type="string" required="true" />            <!-- -->
	</p:declare-step>

	<p:declare-step type="p:add-xml-base">
		<p:input port="source" />
		<p:output port="result" />
		<p:option name="all" xsi:type="boolean" select="'false'" />                       <!-- -->
		<p:option name="relative" xsi:type="boolean" select="'true'" />                   <!-- -->
	</p:declare-step>

	<p:declare-step type="p:compare">
		<p:input port="source" primary="true" />
		<p:input port="alternate" />
		<p:output port="result" xsi:type="" primary="false" />
		<p:option name="fail-if-not-equal" xsi:type="boolean" select="'false'" />         <!-- -->
	</p:declare-step>

	<p:declare-step type="p:count">
		<p:input port="source" sequence="true" />
		<p:output port="result" />
		<p:option name="limit" xsi:type="integer" select="0" />                           <!-- -->
	</p:declare-step>

	<p:declare-step type="p:delete">
		<p:input port="source" />
		<p:output port="result" />
		<p:option name="match" xsi:type="" required="true" />                      <!-- XSLTMatchPattern -->
	</p:declare-step>

	<p:declare-step type="p:directory-list">
		<p:output port="result" />
		<p:option name="path" xsi:type="anyURI" required="true" />                       <!-- -->
		<p:option name="include-filter" xsi:type="" />                             <!-- RegularExpression -->
		<p:option name="exclude-filter" xsi:type="" />                             <!-- RegularExpression -->
	</p:declare-step>

	<p:declare-step type="p:error">
		<p:input port="source" primary="false" />
		<p:output port="result" sequence="true" />
		<p:option name="code" xsi:type="" required="true" />                       <!-- QName -->
		<p:option name="code-prefix" xsi:type="" />                                <!-- NCName -->
		<p:option name="code-namespace" xsi:type="" />                             <!-- anyURI -->
	</p:declare-step>

	<p:declare-step type="p:escape-markup">
		<p:input port="source" />
		<p:output port="result" />
		<p:option name="cdata-section-elements" xsi:type="" select="''" />         <!-- ListOfQNames -->
		<p:option name="doctype-public" xsi:type="" />                             <!-- string -->
		<p:option name="doctype-system" xsi:type="" />                             <!-- anyURI -->
		<p:option name="escape-uri-attributes" xsi:type="" select="'false'" />     <!-- boolean -->
		<p:option name="include-content-type" xsi:type="" select="'true'" />       <!-- boolean -->
		<p:option name="indent" xsi:type="" select="'false'" />                    <!-- boolean -->
		<p:option name="media-type" xsi:type="" />                                 <!-- string -->
		<p:option name="method" xsi:type="" select="'xml'" />                      <!-- QName -->
		<p:option name="omit-xml-declaration" xsi:type="" select="'true'" />       <!-- boolean -->
		<p:option name="standalone" xsi:type="" select="'omit'" />                 <!-- "true" | "false" | "omit" -->
		<p:option name="undeclare-prefixes" xsi:type="" />                         <!-- boolean -->
		<p:option name="version" xsi:type="" select="'1.0'" />                     <!-- string -->
	</p:declare-step>

	<p:declare-step type="p:filter">
		<p:input port="source" />
		<p:output port="result" sequence="true" />
		<p:option name="select" xsi:type="" required="true" />                     <!-- XPathExpression -->
	</p:declare-step>

	<p:declare-step type="p:http-request">
		<p:input port="source" />
		<p:output port="result" />
		<p:option name="byte-order-mark" xsi:type="" />                            <!-- boolean -->
		<p:option name="cdata-section-elements" xsi:type="" select="''" />         <!-- ListOfQNames -->
		<p:option name="doctype-public" xsi:type="" />                             <!-- string -->
		<p:option name="doctype-system" xsi:type="" />                             <!-- anyURI -->
		<p:option name="encoding" xsi:type="" />                                   <!-- string -->
		<p:option name="escape-uri-attributes" xsi:type="" select="'false'" />     <!-- boolean -->
		<p:option name="include-content-type" xsi:type="" select="'true'" />       <!-- boolean -->
		<p:option name="indent" xsi:type="" select="'false'" />                    <!-- boolean -->
		<p:option name="media-type" xsi:type="" />                                 <!-- string -->
		<p:option name="method" xsi:type="" select="'xml'" />                      <!-- QName -->
		<p:option name="normalization-form" xsi:type="" select="'none'" />         <!-- NormalizationForm -->
		<p:option name="omit-xml-declaration" xsi:type="" select="'true'" />       <!-- boolean -->
		<p:option name="standalone" xsi:type="" select="'omit'" />                 <!-- "true" | "false" | "omit" -->
		<p:option name="undeclare-prefixes" xsi:type="" />                         <!-- boolean -->
		<p:option name="version" xsi:type="" select="'1.0'" />                     <!-- string -->
	</p:declare-step>

	<p:declare-step type="p:identity">
		<p:input port="source" sequence="true" />
		<p:output port="result" sequence="true" />
	</p:declare-step>

	<p:declare-step type="p:insert">
		<p:input port="source" primary="true" />
		<p:input port="insertion" sequence="true" />
		<p:output port="result" />
		<p:option name="match" xsi:type="" select="'/*'" />                        <!-- XSLTMatchPattern -->
		<p:option name="position" xsi:type="" required="true" />                   <!-- "first-child" | "last-child" | "before" | "after" -->
	</p:declare-step>

	<p:declare-step type="p:label-elements">
		<p:input port="source" />
		<p:output port="result" />
		<p:option name="attribute" xsi:type="" select="'xml:id'" />                <!-- QName -->
		<p:option name="attribute-prefix" xsi:type="" />                           <!-- NCName -->
		<p:option name="attribute-namespace" xsi:type="" />                        <!-- anyURI -->
		<!--<p:option name="label" select="'concat("_",$p:index)'"/> -->      <!-- XPathExpression -->
		<p:option name="match" select="'*'" xsi:type="" />                         <!-- XSLTMatchPattern -->
		<p:option name="replace" xsi:type="" select="'true'" />                    <!-- boolean -->
	</p:declare-step>

	<p:declare-step type="p:load">
		<p:output port="result" />
		<p:option name="href" xsi:type="" required="true" />                       <!-- anyURI -->
		<p:option name="dtd-validate" xsi:type="" select="'false'" />              <!-- boolean -->
	</p:declare-step>

	<p:declare-step type="p:make-absolute-uris">
		<p:input port="source" />
		<p:output port="result" />
		<p:option name="match" xsi:type="" required="true" />                      <!-- XSLTMatchPattern -->
		<p:option name="base-uri" xsi:type="" />                                   <!-- anyURI -->
	</p:declare-step>

	<p:declare-step type="p:namespace-rename">
		<p:input port="source" />
		<p:output port="result" />
		<p:option name="from" xsi:type="" />                                       <!-- anyURI -->
		<p:option name="to" xsi:type="" />                                         <!-- anyURI -->
		<p:option name="apply-to" xsi:type="" select="'all'" />                    <!-- "all" | "elements" | "attributes" -->
	</p:declare-step>

	<p:declare-step type="p:pack">
		<p:input port="source" sequence="true" primary="true" />
		<p:input port="alternate" sequence="true" />
		<p:output port="result" sequence="true" />
		<p:option name="wrapper" xsi:type="" required="true" />                    <!-- QName -->
		<p:option name="wrapper-prefix" xsi:type="" />                             <!-- NCName -->
		<p:option name="wrapper-namespace" xsi:type="" />                          <!-- anyURI -->
	</p:declare-step>

	<p:declare-step type="p:parameters">
		<p:input port="parameters" kind="parameter" primary="false" />
		<p:output port="result" primary="false" />
	</p:declare-step>

	<p:declare-step type="p:rename">
		<p:input port="source" />
		<p:output port="result" />
		<p:option name="match" required="true" />                      <!-- XSLTMatchPattern -->
		<p:option name="new-name" xsi:type="" required="true" />                   <!-- QName -->
		<p:option name="new-prefix" xsi:type="" />                                 <!-- NCName -->
		<p:option name="new-namespace" xsi:type="" />                              <!-- anyURI -->
	</p:declare-step>

	<p:declare-step type="p:replace">
		<p:input port="source" primary="true" />
		<p:input port="replacement" />
		<p:output port="result" />
		<p:option name="match" xsi:type="" required="true" />                      <!-- XSLTMatchPattern -->
	</p:declare-step>

	<p:declare-step type="p:set-attributes">
		<p:input port="source" primary="true" />
		<p:input port="attributes" />
		<p:output port="result" />
		<p:option name="match" xsi:type="" required="true" />                      <!-- XSLTMatchPattern -->
	</p:declare-step>

	<p:declare-step type="p:sink">
		<p:input port="source" sequence="true" />
	</p:declare-step>

	<p:declare-step type="p:split-sequence">
		<p:input port="source" sequence="true" />
		<p:output port="matched" sequence="true" primary="true" />
		<p:output port="not-matched" sequence="true" />
		<p:option name="initial-only" xsi:type="" select="'false'" />              <!-- boolean -->
		<p:option name="test" xsi:type="" required="true" />                       <!-- XPathExpression -->
	</p:declare-step>

	<p:declare-step type="p:store">
		<p:input port="source" />
		<p:output port="result" primary="false" />
		<p:option name="href" xsi:type="" required="true" />                       <!-- anyURI -->
		<p:option name="byte-order-mark" xsi:type="" />                            <!-- boolean -->
		<p:option name="cdata-section-elements" xsi:type="" select="''" />         <!-- ListOfQNames -->
		<p:option name="doctype-public" xsi:type="" />                             <!-- string -->
		<p:option name="doctype-system" xsi:type="" />                             <!-- anyURI -->
		<p:option name="encoding" xsi:type="" />                                   <!-- string -->
		<p:option name="escape-uri-attributes" xsi:type="" select="'false'" />     <!-- boolean -->
		<p:option name="include-content-type" xsi:type="" select="'true'" />       <!-- boolean -->
		<p:option name="indent" xsi:type="" select="'false'" />                    <!-- boolean -->
		<p:option name="media-type" xsi:type="" />                                 <!-- string -->
		<p:option name="method" xsi:type="" select="'xml'" />                      <!-- QName -->
		<p:option name="normalization-form" xsi:type="" select="'none'" />         <!-- NormalizationForm -->
		<p:option name="omit-xml-declaration" xsi:type="" select="'true'" />       <!-- boolean -->
		<p:option name="standalone" xsi:type="" select="'omit'" />                 <!-- "true" | "false" | "omit" -->
		<p:option name="undeclare-prefixes" xsi:type="" />                         <!-- boolean -->
		<p:option name="version" xsi:type="" select="'1.0'" />                     <!-- string -->
	</p:declare-step>

	<p:declare-step type="p:string-replace">
		<p:input port="source" />
		<p:output port="result" />
		<p:option name="match" xsi:type="" required="true" />                      <!-- XSLTMatchPattern -->
		<p:option name="replace" xsi:type="" required="true" />                    <!-- XPathExpression -->
	</p:declare-step>

	<p:declare-step type="p:unescape-markup">
		<p:input port="source" />
		<p:output port="result" />
		<p:option name="namespace" xsi:type="" />                                  <!-- anyURI -->
		<p:option name="content-type" xsi:type="" select="'application/xml'" />    <!-- string -->
		<p:option name="encoding" xsi:type="" />                                   <!-- string -->
		<p:option name="charset" xsi:type="" />                                    <!-- string -->
	</p:declare-step>

	<p:declare-step type="p:unwrap">
		<p:input port="source" />
		<p:output port="result" xsi:type="" />
		<p:option name="match" xsi:type="" required="true" />                      <!-- XSLTMatchPattern -->
	</p:declare-step>

	<p:declare-step type="p:wrap">
		<p:input port="source" />
		<p:output port="result" />
		<p:option name="wrapper" xsi:type="" required="true" />                    <!-- QName -->
		<p:option name="wrapper-prefix" xsi:type="" />                             <!-- NCName -->
		<p:option name="wrapper-namespace" xsi:type="" />                          <!-- anyURI -->
		<p:option name="match" xsi:type="" required="true" />                      <!-- XSLTMatchPattern -->
		<p:option name="group-adjacent" xsi:type="" />                             <!-- XPathExpression -->
	</p:declare-step>

	<p:declare-step type="p:wrap-sequence">
		<p:input port="source" sequence="true" />
		<p:output port="result" sequence="true" />
		<p:option name="wrapper" xsi:type="" required="true" />                    <!-- QName -->
		<p:option name="wrapper-prefix" xsi:type="" />                             <!-- NCName -->
		<p:option name="wrapper-namespace" xsi:type="" />                          <!-- anyURI -->
		<p:option name="group-adjacent" xsi:type="" />                             <!-- XPathExpression -->
	</p:declare-step>

	<p:declare-step type="p:xinclude">
		<p:input port="source" />
		<p:output port="result" />
		<p:option name="fixup-xml-base" xsi:type="" select="'false'" />            <!-- boolean -->
		<p:option name="fixup-xml-lang" xsi:type="" select="'false'" />            <!-- boolean -->
	</p:declare-step>

	<p:declare-step type="p:xslt">
		<p:input port="source" sequence="true" primary="true" />
		<p:input port="stylesheet" />
		<p:input port="parameters" kind="parameter" />
		<p:output port="result" primary="true" />
		<p:output port="secondary" sequence="true" />
		<p:option name="initial-mode" xsi:type="" />                               <!-- QName -->
		<p:option name="template-name" xsi:type="" />                              <!-- QName -->
		<p:option name="output-base-uri" xsi:type="" />                            <!-- anyURI -->
		<p:option name="version" xsi:type="" />                                    <!-- string -->
	</p:declare-step>



	<p:declare-step type="p:exec">
		<p:input port="source" primary="true" sequence="true" />
		<p:output port="result" primary="true" />
		<p:output port="errors" />
		<p:output port="exit-status" />
		<p:option name="command" xsi:type="" required="true" />                    <!-- string -->
		<p:option name="args" xsi:type="" select="''" />                           <!-- string -->
		<p:option name="cwd" xsi:type="" />                                        <!-- string -->
		<p:option name="source-is-xml" xsi:type="" select="'true'" />              <!-- boolean -->
		<p:option name="result-is-xml" xsi:type="" select="'true'" />              <!-- boolean -->
		<p:option name="wrap-result-lines" xsi:type="" select="'false'" />         <!-- boolean -->
		<p:option name="errors-is-xml" xsi:type="" select="'false'" />             <!-- boolean -->
		<p:option name="wrap-error-lines" xsi:type="" select="'false'" />          <!-- boolean -->
		<p:option name="path-separator" xsi:type="" />                             <!-- string -->
		<p:option name="failure-threshold" xsi:type="" />                          <!-- integer -->
		<p:option name="arg-separator" xsi:type="" select="' '" />                 <!-- string -->
		<p:option name="byte-order-mark" xsi:type="" />                            <!-- boolean -->
		<p:option name="cdata-section-elements" xsi:type="" select="''" />         <!-- ListOfQNames -->
		<p:option name="doctype-public" xsi:type="" />                             <!-- string -->
		<p:option name="doctype-system" xsi:type="" />                             <!-- anyURI -->
		<p:option name="encoding" xsi:type="" />                                   <!-- string -->
		<p:option name="escape-uri-attributes" xsi:type="" select="'false'" />     <!-- boolean -->
		<p:option name="include-content-type" xsi:type="" select="'true'" />       <!-- boolean -->
		<p:option name="indent" xsi:type="" select="'false'" />                    <!-- boolean -->
		<p:option name="media-type" />                                 <!-- string -->
		<p:option name="method" xsi:type="" select="'xml'" />                      <!-- QName -->
		<p:option name="normalization-form" xsi:type="" select="'none'" />         <!-- NormalizationForm -->
		<p:option name="omit-xml-declaration" xsi:type="" select="'true'" />       <!-- boolean -->
		<p:option name="standalone" xsi:type="" select="'omit'" />                 <!-- "true" | "false" | "omit" -->
		<p:option name="undeclare-prefixes" xsi:type="" />                         <!-- boolean -->
		<p:option name="version" xsi:type="" select="'1.0'" />                     <!-- string -->
	</p:declare-step>

	<p:declare-step type="p:hash">
		<p:input port="source" primary="true" />
		<p:output port="result" />
		<p:input port="parameters" kind="parameter" />
		<p:option name="value" xsi:type="" required="true" />                      <!-- string -->
		<p:option name="algorithm" xsi:type="" required="true" />                  <!-- QName -->
		<p:option name="match" xsi:type="" required="true" />                      <!-- XSLTMatchPattern -->
		<p:option name="version" xsi:type="" />                                    <!-- string -->
	</p:declare-step>

	<p:declare-step type="p:uuid">
		<p:input port="source" primary="true" />
		<p:output port="result" />
		<p:option name="match" xsi:type="" required="true" />                      <!-- XSLTMatchPattern -->
		<p:option name="version" xsi:type="" />                                    <!-- integer -->
	</p:declare-step>

	<p:declare-step type="p:validate-with-relax-ng">
		<p:input port="source" primary="true" />
		<p:input port="schema" />
		<p:output port="result" />
		<p:option name="dtd-attribute-values" xsi:type="" select="'false'" />      <!-- boolean -->
		<p:option name="dtd-id-idref-warnings" xsi:type="" select="'false'" />     <!-- boolean -->
		<p:option name="assert-valid" xsi:type="" select="'true'" />               <!-- boolean -->
	</p:declare-step>

	<p:declare-step type="p:validate-with-schematron">
		<p:input port="parameters" kind="parameter" />
		<p:input port="source" primary="true" />
		<p:input port="schema" />
		<p:output port="result" primary="true" />
		<p:output port="report" sequence="true" />
		<p:option name="phase" xsi:type="" select="'#ALL'" />                      <!-- string -->
		<p:option name="assert-valid" xsi:type="" select="'true'" />               <!-- boolean -->
	</p:declare-step>

	<p:declare-step type="p:validate-with-xml-schema">
		<p:input port="source" primary="true" />
		<p:input port="schema" sequence="true" />
		<p:output port="result" />
		<p:option name="use-location-hints" xsi:type="" select="'false'" />        <!-- boolean -->
		<p:option name="try-namespaces" xsi:type="" select="'false'" />            <!-- boolean -->
		<p:option name="assert-valid" xsi:type="" select="'true'" />               <!-- boolean -->
		<p:option name="mode" xsi:type="" select="'strict'" />                     <!-- "strict" | "lax" -->
	</p:declare-step>

	<p:declare-step type="p:www-form-urldecode">
		<p:output port="result" />
		<p:option name="value" xsi:type="" required="true" />                      <!-- string -->
	</p:declare-step>

	<p:declare-step type="p:www-form-urlencode">
		<p:input port="source" primary="true" />
		<p:input port="parameters" kind="parameter" />
		<p:output port="result" />
		<p:option name="match" xsi:type="" required="true" />                      <!-- XSLTMatchPattern -->
	</p:declare-step>

	<p:declare-step type="p:xquery">
		<p:input port="source" sequence="true" primary="true" />
		<p:input port="query" />
		<p:input port="parameters" kind="parameter" />
		<p:output port="result" sequence="true" />
	</p:declare-step>

	<p:declare-step type="p:xsl-formatter">
		<p:input port="source" />
		<p:input port="parameters" kind="parameter" />
		<p:output port="result" primary="false" />
		<p:option name="href" xsi:type="" required="true" />                       <!-- anyURI -->
		<p:option name="content-type" xsi:type="" />                               <!-- string -->
	</p:declare-step>
	
	<!-- APB additions -->
	<p:declare-step type="p:viewport">
		<p:input port="current" />
		<p:output port="result" primary="false" />
	</p:declare-step>

	<p:declare-step type="p:for-each">
		<p:input port="source" />
		<p:output port="result" sequence="true" primary="false" />
	</p:declare-step>
</p:library>