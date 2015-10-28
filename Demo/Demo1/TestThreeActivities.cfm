<cfscript>
	//Last Activity execute
	ThirdActivity = new ThirdActivity();
	//Second Activity to execute
	//inject third activity into second
	secondActivity = new SecondActivity( ThirdActivity );
	//First Activity to execute
	//inject second activity to first
	firstActivity = new FirstActivity( secondActivity );
	
	//To inject collection of data use activityCollection property
	ActivityCollection = {};
	ActivityCollection.firstName = "Shirak";
	ActivityCollection.lastName = "Avakian";
	firstActivity.setActivityCollection( ActivityCollection );
	
	//Start the process by running execute method on your first activity
	firstActivity.execute();	
</cfscript>
