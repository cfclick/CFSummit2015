component  implements="IActivity" extends="BaseActivity" accessors="true"   
{
	property name="activityCollection" type="struct";
	
	function init( IActivity successor )
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
	
	public void function process()
	{
		super.process();
		var mailerService = new Mail();
		mailerService.setFrom("CFSummit2015");
		 	
		try
        {
        	var pdf = this.getActivityCollection();
			//Make sure the physical file exist
			if( fileexists( pdf.source ) ){
				//read the PDF	
				cfpdfform ( action="read", source=pdf.source, result="resultStruct");
				
			    mailerService.setTo(resultStruct.Email);		      
		        mailerService.setSubject("Your application accepted"); 
		        mailerService.setType("html"); 
		        savecontent variable="mailBody"{ 
		               writedump(resultStruct);
				} 
				mailerService.send(body=mailBody); 
				
				FileMove(pdf.source,destination)
			}
        }
        catch(Any e)
        {
        	var mailerService = new Mail();
			mailerService.setFrom("CFSummit2015");
			mailerService.setTo('shirakavakian@gmail.com'); 	
        	mailerService.setSubject("pdf form read"); 
		    mailerService.setType("html"); 
		        savecontent variable="mailBody"{ 
		               writedump(e);
				} 
			mailerService.send(body=mailBody); 
        }

	}
	
	public void function successor()
	{
		super.successor();
		if( !isNull( successorActivity ) )
			successorActivity.execute();
	}
	public void function predecessor()
	{
		super.predecessor();
	}
	
	public void function onActivityEnd()
	{
		super.onActivityEnd();
	}
}