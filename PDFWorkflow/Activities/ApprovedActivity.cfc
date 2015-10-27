component  implements="IActivity" extends="BaseActivity"
{
	 property name="activityCollection" type="struct";
	 
	 public function init( IActivity successor )
	 {
		 super.init(this);
		 if(!isNull(arguments.successor))
			 variables.successorActivity = arguments.successor;		
	 }
	
	 public void function onActivityStart()
	 {
		super.onActivityStart( this.getActivityCollection() );
	 }
	 
	 public boolean function execute()
	 {
		return super.execute( this );
	 }	
	
	 public void function predecessor()
	 {
		super.predecessor();
	 }
	
	 public void function process()
	 {
		super.process();
		var signRead = querynew("");
		//get injected data (PDF)
		var pdf = this.getActivityCollection();
		//Make sure the physical file exist
		if( fileexists( pdf.source ) ){
			pdf.status = "Reading PDF data";
			wsPublish("CFSummit2015_PDFWorkflow_Approval",pdf);
			sleep(500);
			//read the PDF	
			cfpdfform ( action="read", source=pdf.source, result="resultStruct");
			
			pdf.status = "Validating digital signature";
			wsPublish("CFSummit2015_PDFWorkflow_Approval",pdf);
			sleep(500);
			//read signature fields
			cfpdf (action="readsignaturefields", source=pdf.source, name="signRead");
			//loop over digital signature fields
			for(item in signRead){
				//validate required field
				if( compareNocase( item.FIELDNAME,"Manager_Signature") == 0 )
				{
					if( item.SIGNED ){
						pdf.status = "The PDF has digital signature validating..";
						wsPublish("CFSummit2015_PDFWorkflow_Approval",pdf);
						sleep(500);
						//Validate Signature			
						cfpdf(action="validatesignature" , source=pdf.source, name="pdfInfo");
						if( pdfInfo.success ){
							pdf.status = "Validation passed, the digital signature is valid";
							wsPublish("CFSummit2015_PDFWorkflow_Approval",pdf);
							sleep(500);
							//Move the pdf to manager out folder
							try
	                        {
	                        	pdf.status = "Archiving PDF";
								wsPublish("CFSummit2015_PDFWorkflow_Approval",pdf);
								sleep(500);
	                        	cffile( action="copy" , destination=expandPath("../Listener/Archive/")   ,source=pdf.source  );
	                        	sleep(500);
	                        	//delete original file after successful copy
	                        	cffile( action="delete" ,file=pdf.source  );
	                        	pdf.status = "Applicant Approved";
								wsPublish("CFSummit2015_PDFWorkflow_Approval",pdf);
								//send email to applicant here.
	                        	break;
	                        }
	                        catch(Any e)
	                        {
	                        	writelog(file="PDFWorkflowDirWatcher", application="No" , text=e.detail);
	                        }
	
						}else{
							
							pdf.status = "Invalid digital signature.";
							wsPublish("CFSummit2015_PDFWorkflow_Approval",pdf);
							//send email to applicant to resign					
							/*mailerService.setTo('shirakavakian@gmail.com'); 			      
					        mailerService.setSubject("invalid signature"); 
					        mailerService.setType("html"); 
					        savecontent variable="mailBody"{ 
					               writeOutput("Unable to validate your signature, please sign the document again");
	            			} 
	        				mailerService.send(body=mailBody); */
	        				break;
						}
					}else{
						pdf.status = "The manager did not sign the PDF or the signature is invalid.";
						wsPublish("CFSummit2015_PDFWorkflow_Approval",pdf);
						//send email to applicant to resign
						/*mailerService.setTo('shirakavakian@gmail.com'); 			      
				        mailerService.setSubject("Signature is required"); 
				        mailerService.setType("html"); 
				        savecontent variable="mailBody"{ 
				               writeOutput("Digital signature is required to accept your application.");
	        			} 
	    				mailerService.send(body=mailBody); */
	    				break;
					}
				}else{
					pdf.status = "The PDF is missing manager signature.";
					wsPublish("CFSummit2015_PDFWorkflow_Approval",pdf);
				}
			}
		}		
	 }
	
	 public void function successor()
	 {
		super.successor();
		if( !isNull( successorActivity ) )
			successorActivity.execute();
	 }
		
	 public void function onActivityEnd()
	 {
		super.onActivityEnd();
	 }
}