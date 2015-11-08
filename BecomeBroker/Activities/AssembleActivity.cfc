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
			
			//check data has physical file name pdfFileName
			if( !isNull(data) || structKeyExists(data,"pdfFileName"))
			{
				//make sure you have configuration data				
				if( structKeyExists(data,"config") )
				{
					var assemble_temp_path = data.config.path.assemble & "temp\";
					var pending_temp_path = data.config.path.pending & "temp\";
					var approved_manager_path = data.config.path.approved & "byManager\";
					var assets = data.config.path.assets;
					
					if( fileExists( data.config.path.pending & "toAssemble\" & data.pdfFileName ) )
					{
						/*try
	                    {
	                    	//create PDF realtime from any website
	                    	cfhtmltopdf(destination= assets & "htmlsource.pdf",
			  							source="http://www.foxnews.com/",
			  							orientation="landscape",
			  							pagetype="letter",
			  							margintop="0.5",
			  							marginbottom="0.5",
			  							marginleft="0.5",
			  							marginright="0.5",
			  							ownerpassword="owner",
			  							userpassword="user",
			  							encryption="RC4_128",
			  							permissions="AllowPrinting,AllowCopy",
			  							overwrite="true");
	                    }
	                    catch(Any e)
	                    {
	                    	writelog( text=e.message, file=super.getExceptionLogFileName() );
	                    	cfdocument(format="PDF" , filename= assets & "htmlsource.pdf", overwrite="true", ownerpassword="owner"    ){
	                    		writedump(e);
	                    	}
	                    	continue;
	                    	
	                    }finally{
	                    	
	                    	continue;
	                    }*/
						
						
		  				try
	                    {
	                    	//package multiple files in single PDF
	                      	var pdf = new PDF();
			  				pdf.setDestination( data.config.path.assemble & data.pdfFileName ).setOverwrite(true).setPackage(true);
			  				pdf.addParam(source= assets & "cover_letter.docx");
			  				pdf.addParam(source= data.config.path.pending & "toAssemble\" & data.pdfFileName);
			  				pdf.addParam(source= assets & "mybackyard.jpg");
			  				pdf.addParam(source= assets & "Curro.mp3");
			  				pdf.addParam(source= assets & "jt021109-desktop.m4v");
			  				pdf.addParam(source= assets & "CFSummit2015-digital-signature.pptx");
			  				pdf.addParam(source= assets & "CFWfS_diagram.vsdx");
			  				pdf.addParam(source= assets & "MyList.xlsx");
			  				//pdf.addParam(source= assets & "htmlsource.pdf", password="owner" );		  					  				
			  				pdf.merge();
	                  	}
	                  	catch(Any e)
	                  	{
	                  		writelog( text=e.message, file=super.getExceptionLogFileName() );
	                  	}
							
						//copy file for manager signature
						fileCopy(data.config.path.assemble & data.pdfFileName, approved_manager_path & "tosign\" & data.pdfFileName );
						fileCopy(data.config.path.assemble & data.pdfFileName, approved_manager_path & "tosign\" & data.pdfFileName );
						//delete files		
						if (fileExists( data.config.path.pending & "toAssemble\" & data.pdfFileName ))
							filedelete(data.config.path.pending & "toAssemble\" & data.pdfFileName);
		
						
						
					}else{
						writelog( text="#data.pdfFileName# does not exists.", file=super.getLogFileName() );
					}
					
														
					
				}else{
					writelog( text="No config defined", file=super.getLogFileName() );
				}						
			}				
			else{
				writelog( text="No PDFs defined", file=super.getLogFileName() );
			}
				
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
		//Dispatch Activity completion
		data.refresh = true;//refresh the webpage
		data.message = "**************** Assemble Completed **************";
		wsPublish("BecomeBroker_Channel",data);
	}

}