<cftry>
	<cfif isdefined("PDF")>
		<cfpdfform source="#PDF.content#" result="resultStruct" action="read"/>
		<cfset PDFFileName = resultStruct.First_name & '_' & resultStruct.Last_Name & '.pdf' />
		<cffile action="write" output="#PDF.Content#" file="C:/inetpub/wwwroot/CFSummit2015/Listener/ManagerQueue/in/#PDFFileName#"  >
		<h3>Your request submitted, please allow 2-3 days for process</h3>
	</cfif>
<cfcatch type="Any" >
	<cfmail from="cfsummit2015" to="shirakavakian@gmail.com" subject="Error" type="text/html" >
		<cfdump var="#cfcatch#" />
	</cfmail>
</cfcatch>
	
</cftry>
