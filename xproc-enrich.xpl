<p:library 
    xmlns:p="http://www.w3.org/ns/xproc" 
    xmlns:c="http://www.w3.org/ns/xproc-step"
	xmlns:xpt="https://github.com/apb2006/xproc-enrich" 
	xmlns:xpdoc="http://xproc.org/xpdoc"
	version="1.0">

	<p:documentation>Convert xpl to standard format
		taken from Phillip Fennel's xproc-plus-time
		https://code.google.com/p/xproc-plus-time/
	</p:documentation>


	<p:declare-step type="xpt:parse">
		<p:input port="source">
			<p:documentation>
				An xproc document
			</p:documentation>
		</p:input>
		<p:output port="result">
			<p:documentation  xmlns="http://www.w3.org/1999/xhtml"><p>
				Copy of the source in a standard format with
				additional info
				<ol>
				<li>normalize : pipeline elements replaced with declare-step</li>
				<li>augment: add missing (default) ports with @xml:id</li>
				<li>connect: add @xpt:boundPorts showing links</li>
				</ol>
			</p></p:documentation>
		</p:output>

		<p:xslt>
			<p:documentation>
				Normalises XProc pipelines.
			</p:documentation>
			<p:input port="stylesheet">
				<p:document href="etc/normalise-pipeline.xsl" />
			</p:input>
			<p:input port="parameters">
				<p:empty />
			</p:input>
		</p:xslt>

		<p:xslt name="augment-steps">
			<p:documentation>
				Adds missing 'implied' information.
			</p:documentation>
			<p:input port="stylesheet">
				<p:document href="etc/augment-steps.xsl" />
			</p:input>
			<p:input port="parameters">
				<p:empty />
			</p:input>
		</p:xslt>

		<p:xslt name="connect-steps">
			<p:documentation>
				Makes step connections explicit.
			</p:documentation>
			<p:input port="stylesheet">
				<p:document href="etc/connect-steps.xsl" />
			</p:input>
			<p:input port="parameters">
				<p:empty />
			</p:input>
		</p:xslt>
	</p:declare-step>

</p:library>