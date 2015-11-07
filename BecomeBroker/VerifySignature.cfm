<cfscript>
	if( isdefined("PDF.Content"))
	{
		cfpdfform(action="read", source=PDF.Content, result="myPDF");
		//extract agency name from pdf form
		level1 = PDFStructure['topmostSubform[0]'];
		level2 = level1['Page1[0]'];
		agencyNameTemp = level2['Agency_Name[0]'];
		//replace any empty space with _
		agencyname = Replace(agencyNameTemp,' ','_','All');
		
		activityCollection.config = {};
		activityCollection.config = new Config().GetEnvironment();
	
		cffile(action="write", output=PDF.Content, 
	        file=activityCollection.config.path.archive & agencyname & ".pdf");
	        
	    cfpdf(name="verify", 
		action="validatesignature", 
		source=activityCollection.config.path.archive & agencyname & ".pdf");
		
		if(comparenocase(verify.Success,"YES") eq 0 )
		{
			writeOutput("Your request complete, welcome to Century-National as broker");
			
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