<cfscript>
	
	try
    {
    	if( isdefined( "URL.agencyName" ) && len( URL.agencyName ) )
    	{
    		agencyName = url.agencyName;
    	}else{
    		agencyName = "default.pdf";
    	}
    	
    	activityCollection = {};
		activityCollection.pdfFileName = agencyName;
		activityCollection.config = {};
		activityCollection.config = new Config().GetEnvironment();
		assembleActivity = new Activities.AssembleActivity();
		assembleActivity.setActivityCollection( activityCollection );
		assembleActivity.execute();
		message = "Application #activityCollection.pdfFileName# assembled successfully";
		type = "success";
		cflocation( url= activityCollection.config.host.name & ":" & activityCollection.config.host.port & activityCollection.config.path.root & "index.cfm?message=#message#&type=#type#" ) ;
    }
    catch(Any e)
    {
    	message = e.message;
		type = "danger";
		cflocation( url= activityCollection.config.host.name & ":" & activityCollection.config.host.port & activityCollection.config.path.root & "index.cfm?message=#message#&type=#type#" ) ;
    }

</cfscript>

