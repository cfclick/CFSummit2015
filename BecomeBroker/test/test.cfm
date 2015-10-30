<cfscript>
	sweeper = new BecomeBroker.Activities.SweeperActivity();
	activityCollection = {};
	activityCollection.config = {};
	activityCollection.config = new BecomeBroker.Config().GetEnvironment();
	activityCollection.directories = [];
	activityCollection.directories[1] = activityCollection.config.path.pending;
	activityCollection.directories[2] = activityCollection.config.path.approved;
	activityCollection.directories[3] = activityCollection.config.path.assemble;
	sweeper.setActivityCollection(ActivityCollection);
	sweeper.execute(); 	
</cfscript>
