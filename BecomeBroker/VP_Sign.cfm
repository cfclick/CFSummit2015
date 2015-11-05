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
			activityCollection.certFile = "CFSummit_VP.pfx";
			activityCollection.signaturePassword = "123456";
			activityCollection.config = {};
			activityCollection.config = new Config().GetEnvironment();
			try
            {
            	signatureActivity = new Activities.SignatureActivity();
				signatureActivity.setActivityCollection( activityCollection );
				signatureActivity.execute();
				message = "Application #activityCollection.pdfFileName# signed by VP successfully";
				type = "success";
				cflocation( url="http://" & activityCollection.config.host.name & ":" & activityCollection.config.host.port & activityCollection.config.path.root & "BecomeBroker/index.cfm?message=#message#&type=#type#");
            }
            catch(Any e)
            {
            	message = e.message;
				type = "danger";
            	continue;
            }finally{
            	message = "Something wrong happen!";
				type = "danger";
            	cflocation( url="http://" & activityCollection.config.host.name & ":" & activityCollection.config.host.port & activityCollection.config.path.root & "BecomeBroker/index.cfm?message=#message#&type=#type#");
            }

			cflocation( url="http://" & config.host.name & ":" & config.host.port & config.path.root & "/BecomeBroker/index.cfm?message=#message#&type=#type#");
			
	    }
	    catch(Any e)
	    {
	    	message = e.message;
			type = "danger";
			cflocation( url="http://" & config.host.name & ":" & config.host.port & config.path.root & "/BecomeBroker/index.cfm?message=#message#&type=#type#");
			
	    }
	
</cfscript>

