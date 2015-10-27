<cfscript>
	ws = new PDFWorkflow.Activities.ApplicantActivity();
	writeDump( ws.execute() );
</cfscript>
