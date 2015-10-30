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
		activityCollection.config = new Config().GetEnvironment();

		pendingActivity.setActivityCollection(activityCollection); 
		//Run the activity
		pendingActivity.execute();
	}
}