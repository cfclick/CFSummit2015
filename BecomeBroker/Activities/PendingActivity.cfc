component  implements="IActivity" extends="BaseActivity" output="false" accessors="true"   
{
	//SET & GET OBJECT BETWEEN ACTIVITIES
	property type="struct" name="ActivityCollection";
	 
	/*
	* CONSTRUCTOR
	* SUCCESSOR IS THE NEXT ACTIVITY TO EXECUTE
	* PREDECESSOR IS PERVIOUS  ACTIVITY TO ROLL BACK
	*/	
	public void function init(IActivity successor, IActivity Predecessor)
	{
		//EXECUTE PARENT INIT FOR LOGGING
		super.init(this);
		
		//IF THIS ACTIVITY HAS SUCCESSOR THEN ASSIGN THE SUCCESSOR TO VARIABLE FOR LATER USE		
		if( !isNull( arguments.successor ) && isInstanceOf( arguments.successor, "IActivity" ) )
			variables.successorActivity = arguments.successor;
		
		//IF THIS ACTIVITY HAS PREDECESSOR THEN ASSIGN THE PREDECESSOR TO VARIABLE FOR LATER USE
		if( !isNull( arguments.Predecessor ) && isInstanceOf( arguments.Predecessor, "IActivity" ) )
			variables.predecessorActivity = arguments.Predecessor;
	}
	
	/*
	* onActivityStart
	* BEFORE ACTIVITY START THE PROCESS
	*/	
	public void function onActivityStart()
	{
		//PASS ACTICITYCOLLECTION OBJECT TO SUCCESSOR (NEXT ACTIVITY)
		super.onActivityStart(this.getActivityCollection());
	}
	
	/*
	* PREDECESSOR
	* PREDECESSOR METHOD IS RESPONSIBLE TO RUN PREVIOUS ACTIVITY IF INJECTED
	*/
	public void function predecessor()
	{
		//EXECUTE THE PARENT PREDECESSOR
		super.predecessor();
		
		//IS THERE PREDECESSOR INJECTED TO THIS ACTIVITY
		if( !isNull(predecessorActivity)  && isInstanceOf( predecessorActivity, "IActivity" ) )	
		{
			//ECEXUTE PREVIOUS ACTIVITY
			predecessorActivity.process();	
		}		
	}
	
	/*
	* EXECUTE
	* THIS METHOD IS RESPONSIBLE TO RUN THIS ACTIVITY
	*/
	public boolean function execute()
	{
		//INJECT THIS ACTIVITY TO BASE ACTIVITY (PARENT) TO BE EXECUTED
		//YOU MUST INCLUDE BELOW LINE OTHERWISE YOUR CODE WILL NOT EXECUTE
		return super.execute(this);
	}
	
	/*
	* PROCESS
	* RUN YOUR BUSINEES LOGIC INSIDE THIS METHOD
	*/
	public void function process()
	{
		try
        {
        	//Get the data and assign it to local var
			var data = this.getActivityCollection();
			
			//check data has clientPDF stream
			if( !isNull(data) || structKeyExists(data,"clientPDF"))
			{
				//read pdf form from pdf content
				cfpdfform(action="read", source=data.clientPDF, result="PDFStructure");
				
				//extract agency name from pdf form
				var level1 = PDFStructure['topmostSubform[0]'];
				var level2 = level1['Page1[0]'];
				var agencyNameTemp = level2['Agency_Name[0]'];
				//replace any empty space with _
				var agencyname = Replace(agencyNameTemp,' ','_','All');
				//extract agency email from pdf form
				var email = level2['Primary_Contact_EMail[0]'];
				
				var pending_temp_path = data.config.path.pending & "temp\";
				
				//add to activitycollection pdf file name
				data.pdfFileName = "#agencyName#.pdf";
				
				//write file to temp location
				filewrite( pending_temp_path & data.pdfFileName , data.clientPDF);
				
				
				//start pdf writing process
				var pdf = new PDF();				
				pdf.setFlatten(true)
				.setSaveoption('linear')
				.setSource( pending_temp_path & data.pdfFileName )
				.setDestination( data.config.path.pending & "toAssemble\" & data.pdfFileName )
				.setOverwrite(true)
				.write();	
				
				//delete temp file from temp folder
				if ( fileExists(pending_temp_path & data.pdfFileName ) )
				{
					filedelete(pending_temp_path & data.pdfFileName );
				}
				
				//update activityCollection with current state data
				this.setActivityCollection(data);
				
				//Dispatch Activity completion
				data.refresh = false;//refresh the webpage
				wsPublish("BecomeBroker_Channel",data);
		
			}				
			else
				writelog( text="No PDFs defined", file=super.getLogFileName() );
        }
        catch(Any e)
        {
        	data.message ="*Error* " & e.message;
        	wsPublish("BecomeBroker_Channel",data);
        	writelog( text=e.message, application=super.isApplication(), file=super.getExceptionLogFileName() );
        	continue;
        }

	}
	
	
	/*
	* SUCCESSOR
	* THIS METHOD IS RESPONSIBLE TO EXCUTE NEXT INJECTED ACTIVITY
	*/
	public void function successor()
	{
		//EXECUTE PARANET SUCCESSOR FOR LOGGIN
		super.successor();
		
		try
        {      	
        	//IF WE HAVE SUCCESSOR THEN EXECUTE IT OTHERWISE THROW EXCEPTION 	
			if( !isNull(successorActivity)  && isInstanceOf( successorActivity, "IActivity" ) )
			{
				successorActivity.setActivityCollection( this.getActivityCollection() );
				successorActivity.execute();
			}
				
        }
        catch(Any e)
        {
        	//ON EXCEPTION LOG IT AND CONTINUE EXECUTION FOR THIS ACTIVITY WITHOUT INTERRUPTION
        	writelog( text=e.message, application=super.isApplication(), file=super.getExceptionLogFileName() );
        	continue;
        }

	}
	
	/*
	* ONACTIVITYEND
	* ON THIS ACTIVITY COMPLETE ITS PROCESS
	*/
	public void function onActivityEnd()
	{
		//TO FORCE STOP THIS ACTIVITY USE ABORT;
		//IF THIS ACTIVITY HAS SUCCESSORS ALL SUCCESSORS WILL CONTINUE TO RUN
		//IF YOU WANT TO END SUCCESSOR ACTIVITY ADD ABORT ON SUCCESSOR ONACTIVITYEND METHOD.
		super.onActivityEnd();
	}

}