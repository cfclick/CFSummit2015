<!---<cfoutput>#getDirectoryFromPath( getCurrentTemplatePath() )#</cfoutput><cfabort>--->
<cftry>
	<cfif isdefined('PDF.Content')>
		<!---<cfpdfform action="read" source="#PDF.Content#" result="clientPDF">
		</cfpdfform>--->
		<cfset activityManager = new ActivityManager() />
		<cfset activityManager.executeBecomeBrokerProcess( PDF.Content ) />
		
		<h3>
			You have successfully submitted your application.
		</h3>
		<p>
			Your request is in approval process. Once approved, we will email your application for your signature.
		</p>
	</cfif>
<cfcatch type="Any" >
	<cflog text="#cfcatch.message#" >
</cfcatch>
</cftry>

<!---<cfabort>
	<cfset level1 = myPDF['topmostSubform[0]']/>
	<cfset level2 = level1['Page1[0]']/>
	<cfset agencyName1 = level2['Agency_Name[0]']/>
	<cfset agencyname = Replace(agencyName1,' ','_','All') />
	<cfset email = level2['Primary_Contact_EMail[0]']/>
	<cfif fileExists("c:\ColdFusion11\cfusion\wwwroot\testProjects\PDFStuff\pending\temp\#agencyName#.pdf")>
		<cffile action="delete" file="c:\ColdFusion11\cfusion\wwwroot\testProjects\PDFStuff\pending\temp\#agencyName#.pdf" >
	</cfif>
	<cffile action="write" output="#PDF.Content#" 
	        file="c:\ColdFusion11\cfusion\wwwroot\testProjects\PDFStuff\pending\temp\#agencyName#.pdf" >
	
	<cfpdf action="write"  flatten="yes" saveoption="linear" 
		source="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/pending/temp/#agencyName#.pdf"
		destination="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/pending/toAssemble/#agencyName#.pdf" 
		overwrite="yes">
	
	<h3>
		Thank you you have successfully submitted your application to Century-National Insurance
	</h3>
	<p>
		Your request is in approval process. Once approved, we will email your application for your signature.
	</p>
	<cfif fileExists("C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/pending/temp/#agencyName#.pdf")>
		<cffile action="delete" file="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/pending/temp/#agencyName#.pdf" >
	</cfif>
	
</cfif>--->