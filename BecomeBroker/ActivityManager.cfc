component  output="false"
{
		
	public void function init()
	{
	}
	
	remote any function executeBecomeBrokerProcess( any clientPDF )
	{	
		//Initialize assemble activity (second) activity
		var assembleActivity = new Activities.AssembleActivity();
		//Initialize peding activity (first) activity
		var pendingActivity = new Activities.PendingActivity( assembleActivity );
		
		var activityCollection = {};
		activityCollection.clientPDF = clientPDF;
		activityCollection.config = {};
		activityCollection.config.path = {};
		activityCollection.config.path.pending = "C:\inetpub\wwwroot\CFSummit2015\BecomeBroker\documents_process\pending\";
		activityCollection.config.path.assemble = "C:\inetpub\wwwroot\CFSummit2015\BecomeBroker\documents_process\assemble\";
		activityCollection.config.path.approved = "C:\inetpub\wwwroot\CFSummit2015\BecomeBroker\documents_process\approved\";
		activityCollection.config.path.archive = "C:\inetpub\wwwroot\CFSummit2015\BecomeBroker\documents_process\archive\";
		activityCollection.config.path.print = "C:\inetpub\wwwroot\CFSummit2015\BecomeBroker\documents_process\print\";
		activityCollection.config.path.assets = "C:\inetpub\wwwroot\CFSummit2015\BecomeBroker\assets\";
		
		pendingActivity.setActivityCollection(activityCollection); 
		//Run the activity
		pendingActivity.execute();
	}
}