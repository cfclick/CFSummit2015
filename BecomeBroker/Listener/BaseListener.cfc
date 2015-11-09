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
			var message = "ACTION: " & fd.type & " FILE: " & fd.filename & " TIME: " & timeFormat(fd.lastmodified);
			writelog(file="CFWF", application="No" , text=message);
			var dir = getDirectoryFromPath(fd.filename);
			if( fileExists( fd.filename ) )
			{
				writelog(file="CFWF", application="No" , text="file #fd.filename# exist");
				var fileInfo = getFileInfo(fd.filename);
				writelog(file="CFWF", application="No" , text="fd.filename: #fd.filename#");
				writelog(file="CFWF", application="No" , text="fileInfo.name: #fileInfo.name#");
				writelog(file="CFWF", application="No" , text="fd.filename: #fd.filename#");
				data = {};
				data.fileInfo = fileInfo;
				data.message = message;
				data.refresh = false;
				
				wsPublish("BecomeBroker_Channel",data);
				
				activityCollection = {};
				activityCollection.pdfFileName = fileInfo.name;
				activityCollection.printer = "Samsung M2020 Series";
				activityCollection.config = {};
				activityCollection.config = new BecomeBroker.Config().GetEnvironment();
				
				filecopy( fd.filename, activityCollection.config.path.print );
							
		    	emailActivity = new BecomeBroker.Activities.EmailActivity();
		    	emailActivity.setActivityCollection(activityCollection);
		    	emailActivity.execute();
		    	//printActivity = new BecomeBroker.Activities.PrintActivity( emailActivity );		    	    	
				//printActivity.setActivityCollection( activityCollection );
				//printActivity.execute();		
			}
        }
        catch(Any e)
        {
        	data.message ="*Error* " & e.message;
        	wsPublish("BecomeBroker_Channel",data);
        	writelog( text=e.message, application="no", file="CFWFExceptions" );
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
