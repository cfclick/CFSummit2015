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
        	//signaturePassword
        	//Signature file
        	//Signature PDF
        	//Destination
        	//Get the data and assign it to local var
			var data = this.getActivityCollection();
			
			//check data has physical file name pdfFileName
			if( !isNull(data) || structKeyExists(data,"pdfFileName"))
			{
				//make sure you have configuration data				
				if( structKeyExists(data,"config") )
				{
					var approved_manager_path = data.config.path.approved & "byManager\";
					var approved_vp_path = data.config.path.approved & "byVP\";
					var print_path = data.config.path.print;
					var assets = data.config.path.assets;
					
					var pdf = new PDF();
					cfpdf(  action="sign",
							source=assets & data.signaturePDFFile,
							destination=  data.config.path.approved & "temp\temp_signature_" & data.pdfFileName,
							pages="1",
							Height="50",
							Width="250",
							position="#data.position.x#,#data.position.y#",
							overwrite=true,
							keystore=assets & "signatures\" & data.certFile,
							keystorepassword= data.signaturePassword  );
	
		        	var destination = "";
		        	var source = "";
		        	data.directories = [];
		        	switch(data.certFile){
		        		
		        		case "CFSummit_Manager.pfx":
		        		{
		        			destination = approved_manager_path & "completed\" & data.pdfFileName ;
		        			source = approved_manager_path & "tosign\" & data.pdfFileName;

							data.directories[1] = approved_manager_path & "tosign\";
							data.fileType = "*.pdf";	
		        			break;
		        		}
		        		
		        		case "CFSummit_VP.pfx":
		        		{
		        			destination = print_path & data.pdfFileName;
		        			source = data.config.path.assemble & data.pdfFileName;
		        			
							data.directories[1] = data.config.path.assemble;
							data.directories[2] = approved_manager_path & "completed\";
							data.fileType = "*.pdf";
		        			break;
		        		}
		        	}
		        	
		        	writelog( text=destination, file=super.getLogFileName() );
		        	writelog( text=source, file=super.getLogFileName() );
		        	
		        	try
                    {
                    	var pdfPack = new PDF();
			        	pdfPack.setDestination( destination )
			        	.setOverwrite(true);
			        	pdfPack.AddParam( source=source );
			        	pdfPack.AddParam( source=data.config.path.approved & "temp\temp_signature_" & data.pdfFileName );
			        	pdfPack.setpackage(false);
			        	pdfPack.Merge();
                    }
                    catch(Any e)
                    {
                    	data.message ="*Error* " & e.message;
			        	wsPublish("BecomeBroker_Channel",data);
			        	writelog( text=e.detail, application=super.isApplication(), file=super.getExceptionLogFileName() );
			        	//continue;
			        	onActivityEnd();
                    	
                    }		        	
		        	
		        	data.directories[3] = data.config.path.approved & "temp\";
		        	this.setActivityCollection(data);		 	
		        	
		        	if( fileExists(data.config.path.approved & "temp\temp_signature_" & data.pdfFileName) )
						filedelete(data.config.path.approved & "temp\temp_signature_" & data.pdfFileName);
		        
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
        	//continue;
        	onActivityEnd();
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
		data.message = "******** #data.certFile# Signature Completed ********";
		wsPublish("BecomeBroker_Channel",data);
		abort;
	}

}