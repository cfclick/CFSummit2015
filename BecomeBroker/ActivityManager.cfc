component  output="false"
{
		
	public void function init()
	{
	}
	
	remote any function executeBecomeBrokerProcess( any clientPDF )
	{	
		var pendingActivity = new Activities.PendingActivity();
		var activityCollection = {};
		activityCollection.clientPDF = clientPDF;
		pendingActivity.setActivityCollection(activityCollection); 
		pendingActivity.execute();
	}
}