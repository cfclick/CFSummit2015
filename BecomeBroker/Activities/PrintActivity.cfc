component  implements="IActivity" extends="BaseActivity" output="false" accessors="true"   
{
	property type="struct" name="ActivityCollection";
	 
	public void function init(IActivity successor, IActivity Predecessor)
	{
		super.init(this);		
		if( !isNull( arguments.successor ) && isInstanceOf( arguments.successor, "IActivity" ) )
			variables.successorActivity = arguments.successor;
		
		if( !isNull( arguments.Predecessor ) && isInstanceOf( arguments.Predecessor, "IActivity" ) )
			variables.predecessorActivity = arguments.Predecessor;
	}
	
	public void function onActivityStart()
	{
		
		super.onActivityStart(this.getActivityCollection());
	}
	
	public void function predecessor()
	{
		
		super.predecessor();
		if( !isNull(predecessorActivity)  && isInstanceOf( predecessorActivity, "IActivity" ) )	
			predecessorActivity.process();			
	}
	
	public boolean function execute()
	{
		
		return super.execute(this);
	}
	
	public void function process()
	{
		try
        {
        	//Dependencies
        	//pdfFileName
        	//printer

        	//Get the data and assign it to local var
			var data = this.getActivityCollection();
			
			//check data has physical file name pdfFileName
			if( !isNull(data) || structKeyExists(data,"pdfFileName"))
			{
				//make sure you have configuration data				
				if( structKeyExists(data,"config") )
				{					
					var print_path = data.config.path.print;
					
					if( fileExists( print_path & data.pdfFileName ) )
					{
						cfprint( type = "pdf",
					 			 source = print_path & data.pdfFileName,
					 			 printer = data.printer,
					 			 password = "owner" );
					}else{
						writelog( text="No data to print. File #print_path & data.pdfFileName# does not exist", file=super.getLogFileName() );
					}

		        	this.setActivityCollection(data);		 	
		        		        
				}
				else
				{
					writelog( text="No config defined", file=super.getLogFileName() );
				}
			}
			else
			{
				writelog( text="#data.pdfFileName# does not exists.", file=super.getLogFileName() );	
			}
        }
        catch(Any e)
        {
        	data.message ="*Error* " & e.message;
        	wsPublish("BecomeBroker_Channel",data);
        	writelog( text=e.message, application=super.isApplication(), file=super.getExceptionLogFileName() );
        	continue;
        	//onActivityEnd();
        }

	}
	
	public void function successor()
	{		
		super.successor();
		
		try
        {      	
			if( !isNull(successorActivity)  && isInstanceOf( successorActivity, "IActivity" ) )
			{
				successorActivity.setActivityCollection( this.getActivityCollection() );
				successorActivity.execute();
			}
				
        }
        catch(Any e)
        {
        	writelog( text=e.message, application=super.isApplication(), file=super.getExceptionLogFileName() );
        	continue;
        }

	}
	
	public void function onActivityEnd()
	{
		
		super.onActivityEnd();
		var data = this.getActivityCollection();
		data.refresh = true;//refresh the webpage
		data.message = "******** Printing job completed ********";
		wsPublish("BecomeBroker_Channel",data);
		//abort;
	}

}