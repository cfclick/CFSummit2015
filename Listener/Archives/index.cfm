<script>
	$(document).onReady(function(){
		var onMessageHandler = function(event, token){
				alert(JSON.stringify(event.data));
				$('#StatusUpdate').Html(event.data.STATUS);
			}
	})
	
</script>

<cftry>
	<cfif isdefined("PDF")>
		<cfpdfform source="#PDF.content#" result="resultStruct" action="read"/>
		<cfset PDFFileName = resultStruct.First_name & '_' & resultStruct.Last_Name & '.pdf' />
		<cffile action="write" output="#PDF.Content#" file="C:/inetpub/wwwroot/CFSummit2015/Listener/Archives/#PDFFileName#"  >
		<h3 id="StatusUpdate"></h3>
		
	</cfif>
<cfcatch type="Any" >
	<cfmail from="cfsummit2015" to="shirakavakian@gmail.com" subject="Error" type="text/html" >
		<cfdump var="#cfcatch#" />
	</cfmail>
</cfcatch>
	
</cftry>
<cfwebsocket name="WS_PDF_Approval_Workflow" onmessage="onMessageHandler" onopen="onOpenHandler" subscribeto="CFSummit2015_PDFWorkflow_Approval" />  