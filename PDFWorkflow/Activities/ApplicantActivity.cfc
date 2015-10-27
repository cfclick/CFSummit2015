component  implements="IActivity" extends="BaseActivity" output="false" accessors="true"   
{
	property name="activityCollection" type="struct";
	
	function init( IActivity successor )
	{
		super.init(this);
		if(!isNull(arguments.successor))
			variables.successorActivity = arguments.successor;		
	}
	
	void function onActivityStart()
	{
		super.onActivityStart( this.getActivityCollection() );
	}
	
	void function process()
	{
		super.process();
		//Start your actual business logic here
		writelog(file="PDFWorkflowDirWatcher", application="No" , text="running process");
		var mailerService = new Mail();
		    mailerService.setFrom("CFSummit2015");
		//place holder for digital signature fields     
		var signRead = querynew("");
		//get injected data (PDF)
		var pdf = this.getActivityCollection();
		//Make sure the physical file exist
		if( fileexists( pdf.source ) ){
			//read the PDF	
			cfpdfform ( action="read", source=pdf.source, result="resultStruct");
			//read signature fields
			cfpdf (action="readsignaturefields", source=pdf.source, name="signRead");
			//loop over digital signature fields
			for(item in signRead){
				//validate required field
				if( compareNocase( item.FIELDNAME,"Applicant_Signature") == 0 )
				{
					if( item.SIGNED ){
						//Validate Signature			
						cfpdf(action="validatesignature" , source=pdf.source, name="pdfInfo");
						if( pdfInfo.success ){
							//Move the pdf to manager out folder
							try
	                        {
	                        	cffile( action="copy" , destination=expandPath("../Listener/ManagerQueue/out/")   ,source=pdf.source  );
	                        	sleep(500);
	                        	//delete original file after successful copy
	                        	cffile( action="delete" ,file=pdf.source  );
	                        	break;
	                        }
	                        catch(Any e)
	                        {
	                        	writelog(file="PDFWorkflowDirWatcher", application="No" , text=e.detail);
	                        }
	
						}else{
							//send email to applicant to resign					
							mailerService.setTo('shirakavakian@gmail.com'); 			      
					        mailerService.setSubject("invalid signature"); 
					        mailerService.setType("html"); 
					        savecontent variable="mailBody"{ 
					               writeOutput("Unable to validate your signature, please sign the document again");
	            			} 
	        				mailerService.send(body=mailBody); 
	        				break;
						}
					}else{
						//send email to applicant to resign
						mailerService.setTo('shirakavakian@gmail.com'); 			      
				        mailerService.setSubject("Signature is required"); 
				        mailerService.setType("html"); 
				        savecontent variable="mailBody"{ 
				               writeOutput("Digital signature is required to accept your application.");
	        			} 
	    				mailerService.send(body=mailBody); 
	    				break;
					}
				}
			}
		}		
	}
	
	boolean function execute()
	{
		//write your desired logic before execution here
		
		//You should call this super method
		return super.execute( this );

	}
	
	void function successor()
	{
		super.successor();
		if( !isNull( successorActivity ) )
			successorActivity.execute();
	}
	
	void function predecessor()
	{
		super.predecessor();
	}
	
	void function onActivityEnd()
	{
		super.onActivityEnd();
	}
}