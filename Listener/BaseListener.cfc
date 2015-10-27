component  output="false"
{
	
	public function init()
	{
		return this;
	}
	
	public function onAdd(struct cfEvent)
	{
		//define PDF File Info
		try
        {
        	var fd = {};
			fd = arguments.cfEvent.data;
			writelog(file="PDFWorkflowDirWatcher", application="No" , text="ACTION: #fd.type#;FILE: #fd.filename#; TIME: #timeFormat(fd.lastmodified)#");
			var dir = getDirectoryFromPath(fd.filename);
			if( fileExists( fd.filename ) ){
				writelog(file="PDFWorkflowDirWatcher", application="No" , text="The file exist");
				var fileInfo = getFileInfo(fd.filename);
				if(compareNocase( dir,'C:\inetpub\wwwroot\CFSummit2015\Listener\ManagerQueue\in\') == 0 )
				{
					var pdfData = {};
					pdfData.actionName = "ManagerActivity";
					pdfData.destination = "C:\inetpub\wwwroot\CFSummit2015\Listener\ManagerQueue\out\";
					pdfData.source = fd.filename;
					pdfData.name = fileInfo.name;
					pdfData.Token = createUUID();
					var applicantActivity = new PDFWorkflow.Activities.ApplicantActivity();
					applicantActivity.setActivityCollection( pdfData );	
					applicantActivity.execute();
				}
				else if(compareNocase( dir,'C:\inetpub\wwwroot\CFSummit2015\Listener\ManagerQueue\out\') == 0 )
				{				
					var pdfData = {};
					pdfData.actionName = "ManagerActivity";
					pdfData.destination = "C:\inetpub\wwwroot\CFSummit2015\Listener\Approvals\";
					pdfData.reject = "C:\inetpub\wwwroot\CFSummit2015\Listener\ManagerQueue\Reject\";
					pdfData.source = fd.filename;
					pdfData.PathAndName = "/Listener/ManagerQueue/out/#fileInfo.name#";
					pdfData.name = fileInfo.name;
					pdfData.Token = createUUID();
					
					wsPublish("CFSummit2015_PDFWorkflow",pdfData);
				}
				else if(compareNocase( dir,'C:\inetpub\wwwroot\CFSummit2015\Listener\ManagerQueue\reject\') == 0 )
				{				
					var pdfData = {};
					pdfData.actionName = "RejectedActivity";
					pdfData.destination = "";
					pdfData.source = fd.filename;
					pdfData.PathAndName = "/Listener/ManagerQueue/reject/#fileInfo.name#";
					pdfData.name = fileInfo.name;
					pdfData.Token = createUUID();
					var rejectedActivity = new PDFWorkflow.Activities.RejectedActivity();
					rejectedActivity.setActivityCollection( pdfData );	
					rejectedActivity.execute();
					wsPublish("CFSummit2015_PDFWorkflow",pdfData);
				}
				else if(compareNocase( dir,'C:\inetpub\wwwroot\CFSummit2015\Listener\Approvals\') == 0 )
				{
					var pdfData = {};
					pdfData.actionName = "ApprovalActivity";
					pdfData.destination = "";
					pdfData.source = fd.filename;
					pdfData.PathAndName = "/Listener/Approvals/#fileInfo.name#";
					pdfData.name = fileInfo.name;
					pdfData.Token = createUUID();
					pdfData.status = "Approval Process Started";
					wsPublish("CFSummit2015_PDFWorkflow_Approval",pdfData);
					var approvalActivity = new PDFWorkflow.Activities.ApprovalActivity();
					approvalActivity.setActivityCollection( pdfData );	
					approvalActivity.execute();
				}
				else if(compareNocase( dir,'C:\inetpub\wwwroot\CFSummit2015\Listener\Archives\') == 0 )
				{
					var pdfData = {};
					pdfData.actionName = "ArchiveActivity";
					pdfData.destination = "";
					pdfData.source = fd.filename;
					pdfData.PathAndName = "/Listener/Archives/#fileInfo.name#";
					pdfData.name = fileInfo.name;
					pdfData.Token = createUUID();
					wsPublish("CFSummit2015_PDFWorkflow",pdfData);
				}
				else
				{
					writelog(file="PDFWorkflowDirWatcher", application="No" , text="#dir# not defined");	
				}
			
			}
        }
        catch(Any e)
        {
        	writelog(file="PDFWorkflowDirWatcher", application="No" , text="Error: directory watcher onAdd() #e.message#");
        	throw(object=e);
        }

			
	}
	
	public function onDelete( struct cfEvent )
	{
		//var data = arguments.cfEvent.data;
		return cfEvent;
	}
	
	public function onChange( struct cfEvent )
	{
		//var data = arguments.cfEvent.data;
		return cfEvent;
	}
}
