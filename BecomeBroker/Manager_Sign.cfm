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
			activityCollection.signaturePDFFile = "BecomeBrokerSignaturePage.pdf";
			activityCollection.certFile = "CFSummit_Manager.pfx";
			activityCollection.signaturePassword = "123456";
			activityCollection.config = {};
			activityCollection.config = new Config().GetEnvironment();
			sweeperActivity = new Activities.SweeperActivity(); 
			signatureActivity = new Activities.SignatureActivity(sweeperActivity);
			signatureActivity.setActivityCollection( activityCollection );
			signatureActivity.execute();
			message = "Application #activityCollection.pdfFileName# signed by Manager successfully";
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


