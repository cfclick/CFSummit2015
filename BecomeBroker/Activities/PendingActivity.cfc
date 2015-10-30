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
        	
			var data = this.getActivityCollection();
			if( isNull(data) || !structKeyExists(data,"clientPDF"))
			{
				var level1 = data.clientPDF['topmostSubform[0]'];
				var level2 = level1['Page1[0]'];
				var agencyNameTemp = level2['Agency_Name[0]'];
				var agencyname = Replace(agencyNameTemp,' ','_','All');
				var email = level2['Primary_Contact_EMail[0]'];
				
				if( fileExists("c:\ColdFusion11\cfusion\wwwroot\CFSummit2015\BecomeBroker\document_process\pending\temp\#agencyName#.pdf") )
				{
					filedelete("c:\ColdFusion11\cfusion\wwwroot\CFSummit2015\BecomeBroker\document_process\pending\temp\#agencyName#.pdf"); 
				}
				
				filewrite("c:\ColdFusion11\cfusion\wwwroot\CFSummit2015\BecomeBroker\document_process\pending\temp\#agencyName#.pdf",PDF.Content);
				
				var pdf = new PDF();				
				pdf.setFlatten(ture);
				pdf.setSaveoption('linear');
				pdf.setSource('C:/ColdFusion11/cfusion/wwwroot/CFSummit2015/BecomeBroker/document_process/pending/temp/#agencyName#.pdf');
				pdf.setDestination('C:/ColdFusion11/cfusion/wwwroot/CFSummit2015/BecomeBroker/document_process/pending/toAssemble/#agencyName#.pdf');
				pdf.setOverwrite(true);
				pdf.Action('write');	
	
				if (fileExists("C:/ColdFusion11/cfusion/wwwroot/CFSummit2015/BecomeBroker/document_process/pending/temp/#agencyName#.pdf"))
				{
					filedelete("C:/ColdFusion11/cfusion/wwwroot/CFSummit2015/BecomeBroker/document_process/pending/temp/#agencyName#.pdf");
				}
		
			}				
			else
				writelog( text="No PDFs defined", file=super.getLogFileName() );
        }
        catch(Any e)
        {
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