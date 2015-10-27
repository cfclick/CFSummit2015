<cfif isdefined('PDF.Content')>
	<cfpdfform action="read" source="#PDF.Content#" result="myPDF">
	</cfpdfform>
<!---	<cfdump var="#myPDF#">--->
	
	
<cffile action="write" output="#PDF.Content#" 
	        file="c:\ColdFusion11\cfusion\wwwroot\testProjects\PDFStuff\archive\temp\archived.pdf" >
<cfpdf name="verify" 
action="validatesignature" 
source="c:\ColdFusion11\cfusion\wwwroot\testProjects\PDFStuff\archive\temp\archived.pdf" >

<cfdump var="#verify#">
<cfif comparenocase(verify.Success,"YES") eq 0 >
	<p>Your request complete, welcome to Century-National as broker</p>
	<cfpdf action="archive" 
	source="c:\ColdFusion11\cfusion\wwwroot\testProjects\PDFStuff\archive\temp\archived.pdf"
	destination="c:\ColdFusion11\cfusion\wwwroot\testProjects\PDFStuff\archive\final.pdf"
	overwrite="yes" >
<cfelse>
	<h3>Sorry, Invalid signature</h3>
</cfif>
<cfelse>
	<h3>Sorry, final signature is required</h3>
</cfif>
