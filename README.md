# xproc-enrich
Transform XProc source by adding default and step linking data.

Convert XProc source to standard format based on code from from Phillip Fennel's @philipfennell
xproc-plus-time project https://code.google.com/p/xproc-plus-time/

* normalize : pipeline elements replaced with declare-step
* augment: add missing (default) ports with @xml:id
* connect: add @xpt:boundPorts showing links

xmlns:dot="https://github.com/apb2006/xproc-enrich"

## load from github
````
<p:import href="https://rawgit.com/apb2006/xproc-enrich/master/xproc-enrich.xpl" />
````

calabash samples/simple.xpl 