<cfif isdefined('PDF.Content')>
	<cfpdfform action="read" source="#PDF.Content#" result="myPDF">
	</cfpdfform>
<!---	<cfdump var="#myPDF#">--->
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
	<!---<cfset PDFinfo=StructNew()> 
	<cfset PDFinfo.Title="#agencyName#"> 
	<cfset PDFinfo.Author="Century-National Insurance"> 
	<cfset PDFinfo.Keywords="ReadyToAssemble"> 
	<cfset PDFinfo.Subject="#agencyName# Ready to assemble"> 
	<cfset PDFinfo.FillingForm = "No">
	<cfset PDFinfo.Application = "Demo by Shirak">
	<cfpdf action="setInfo" source="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/pending/temp/#agencyName#.pdf" 
	info="#PDFinfo#" destination="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/pending/toAssemble/#agencyName#.pdf" 
	overwrite="yes">--->
	
	<h3>
		Thank you you have successfully submitted your application to Century-National Insurance
	</h3>
	<p>
		Your request is in approval process. Once approved, we will email your application for your signature.
	</p>
	<cfif fileExists("C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/pending/temp/#agencyName#.pdf")>
	<cffile action="delete" file="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/pending/temp/#agencyName#.pdf" >
</cfif>
	<cfabort>
	<cfpdf action="getinfo" name="myPDF3" source="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/pending/toAssemble/#agencyName#.pdf" >
	<cfdump var="#myPDF3#" >  
	<cfpdf action="getinfo" name="myPDF2" source="c:\ColdFusion11\cfusion\wwwroot\testProjects\PDFStuff\pending\temp\#agencyName#.pdf" >

	<cfdump var="#myPDF2#">
		
			<cfswitch expression="#myPDF2.Keywords#">
				<cfcase value="Assembled">
					<cfpdf action="readsignaturefields" 
					source="c:\ColdFusion11\cfusion\wwwroot\testProjects\PDFStuff\pending\temp\#agencyName#.pdf" 
					name="result" >
					<cfdump var="#result#" >
				</cfcase>
				
				<cfcase value="ReadyToAssemble">
					<!---<cffile action="copy" destination="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/pending/toAssemble/#agencyName#.pdf" 
					source="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/pending/#agencyName#.pdf" >--->
					<cfinclude template="Assemble.cfm" >
				</cfcase>
			
				<cfcase value="VP_Signature">
				</cfcase>
			
				<cfcase value="Applicant_Signature">			
				</cfcase>
				<cfdefaultcase>
					<cfset PDFinfo=StructNew()> 
					<cfset PDFinfo.Title="#agencyName#"> 
					<cfset PDFinfo.Author="Century-National Insurance"> 
					<cfset PDFinfo.Keywords="ReadyToAssemble"> 
					<cfset PDFinfo.Subject="#agencyName# Ready to assemble"> 
					<cfset PDFinfo.FillingForm = "No">
					<cfset PDFinfo.Application = "Demo by Shirak">
					<cfpdf action="setInfo" source="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/pending/temp/#agencyName#.pdf" 
					info="#PDFinfo#" destination="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/pending/toAssemble/#agencyName#.pdf" 
					overwrite="yes">

					<h3>
						Thank you you have successfully submitted your application to Century-National Insurance
					</h3>
					<p>
						Your request is in approval process. Once approved, we will email your application for your signature.
					</p>
					<cfpdf action="getinfo" name="myPDF3" source="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/pending/toAssemble/#agencyName#.pdf" >
					<cfdump var="#myPDF3#" >
				</cfdefaultcase>
			</cfswitch>
			

	
	<cfabort>
	<cfmail from="no-reply@cnico.com" to="#email#" type="text/html" 
	        subject="Agency #agencyName# submitted application">
		<cfmailparam file="c:\ColdFusion11\cfusion\wwwroot\testProjects\PDFStuff\pending\#agencyName#.pdf">
	</cfmail>
	<!---<cfcontent type="application/pdf" variable="#PDF.Content#" ></cfcontent>--->
	
</cfif>