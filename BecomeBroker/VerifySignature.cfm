<cfscript>
	if( isdefined("PDF.Content"))
	{
		
		activityCollection.config = {};
		activityCollection.config = new Config().GetEnvironment();
	
		cffile(action="write", output=PDF.Content, 
	        file=activityCollection.config.path.archive & "Archived.pdf");
	        
	    cfpdf(name="verify", 
		action="validatesignature", 
		source=activityCollection.config.path.archive & "Archived.pdf");
		
		if(comparenocase(verify.Success,"YES") eq 0 )
		{
			writeOutput("Your request completed, welcome to Global Insurance as broker");
			
			cfpdf( action="archive", 
					source=activityCollection.config.path.archive & agencyname & ".pdf",
					destination=activityCollection.config.path.archive & agencyname & "_archived.pdf",
					overwrite="yes");
		}else{
			writeOutput("Sorry, Invalid signature");
		}
	
	}	
</cfscript>
<!---

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
--->