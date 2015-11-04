component  output="false"
{
		
	public void function init()
	{
		variables.activityCollection = {};
		activityCollection.config = {};
		activityCollection.config = new Config().GetEnvironment();
	}
	
	remote any function executeBecomeBrokerProcess( any clientPDF )
	{	
		//Initialize assemble activity (second) activity
		var assembleActivity = new Activities.AssembleActivity();
		//Initialize peding activity (first) activity
		var pendingActivity = new Activities.PendingActivity( assembleActivity );
		
		activityCollection.clientPDF = clientPDF;
		pendingActivity.setActivityCollection(activityCollection); 
		//Run the activity
		pendingActivity.execute();
	}
	
	remote any function executeSweeperProcess()
	{			
		//cfdirectory( action="list",  directory=activityCollection.config.path.app & "documents_process", name="dir", filter="*.pdf", recurse="true"   );
		
		activityCollection.directories = [];
		activityCollection.directories[1] = activityCollection.config.path.app & "documents_process";
		activityCollection.fileType = "*.pdf";	
		var sweeper = new Activities.SweeperActivity().setActivityCollection(activityCollection).execute(); 	
	}
}