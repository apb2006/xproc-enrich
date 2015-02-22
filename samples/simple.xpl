<?xml version="1.0"?>
<p:pipeline name="pipeline" version="1.0"
    xmlns:p="http://www.w3.org/ns/xproc" 
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:xpt="https://github.com/apb2006/xproc-enrich" 
    >
    <p:import href="http://xmlcalabash.com/extension/steps/library-1.0.xpl" />
    <p:documentation>
        Test loading of library.
    </p:documentation>
    <p:import href="../xproc-enrich.xpl" />
    <xpt:parse/>
   
  
</p:pipeline>
