component output="false"  
{
	import IActivity;		
	
	private string function getLogFileName(){
		return "CFWF";
	}
	
	private string function getExceptionLogFileName(){
		return "CFWFExceptions";
	}
	
	private boolean function isApplication(){
		return true;
	}
	
	private numeric function getSleepTime(){
		return 1000;
	}
	
	public function init( IActivity successor)
	{
		try
        {
        	variables.log = {};
			variables.meta = getMetaData(successor);
			writelog( text="----------------------------#meta.name#--------------------------------", application=isApplication(), file=getLogFileName() );
			data.message = meta.name & "Activity initialization started";
			writelog( text=data.message, application=isApplication(), file=getLogFileName() );			
			wsPublish("BecomeBroker_Channel",data);
        }
        catch(Any e)
        {
        	data.message = meta.name & " *Error* " & e.message;
        	writelog( text=data.message, application=isApplication(), file=getExceptionLogFileName() );
        }

	}
	
	public void function onActivityStart( )
	{
		try
        {
        	data.message = meta.name & " Activity started";
        	writelog( text="#meta.name# Activity started", application=isApplication(), file=getLogFileName() );
        	wsPublish("BecomeBroker_Channel",data);
        }
        catch(Any e)
        {
        	data.message = meta.name & " *Error* " & e.message;
        	writelog( text=data.message, application=isApplication(), file=getExceptionLogFileName() );
        }

	}
	
	public boolean function execute(IActivity activity)
	{
		try
        {        	
        	var act = arguments.activity;		
        	//data.message = meta.name & " Activity executed";
			writelog(text=data.message, application=isApplication(), file=getLogFileName );	
			//wsPublish("BecomeBroker_Channel",data);
			 sleep( getSleepTime() );
			act.onActivityStart();	
			 sleep( getSleepTime() );		
			act.predecessor();	
			 sleep( getSleepTime() );
			act.process();
			 sleep( getSleepTime() );				
			act.successor();
			 sleep( getSleepTime() );
			act.onActivityEnd();
			
			return true;
        }
        catch(Any e)
        {
        	data.message = meta.name & " *Error* " & e.message;
        	writelog( text=data.message, application=isApplication(), file=getExceptionLogFileName() );
        	wsPublish("BecomeBroker_Channel",data);
        }

	}
	
	public void function predecessor()
	{
		try
        {
        	data.message = meta.name & " Activity predecessor started";
        	writelog( text=data.message, application=isApplication(), file=getLogFileName() );
        	wsPublish("BecomeBroker_Channel",data);
		
        }
        catch(Any e)
        {
        	data.message = meta.name & " *Error* " & e.message;
        	writelog( text=data.message, application=isApplication(), file=getExceptionLogFileName() );
        	wsPublish("BecomeBroker_Channel",data);
        }
	}
		
	public void function process()
	{
		try
        {
        	data.message = meta.name & " Activity process started";
        	writelog( text=data.message, application=isApplication(), file=getLogFileName() );
        	wsPublish("BecomeBroker_Channel",data);
		
        }
        catch(Any e)
        {
        	data.message = meta.name & " *Error* " & e.message;
        	writelog( text=data.message, application=isApplication(), file=getExceptionLogFileName() );
        	wsPublish("BecomeBroker_Channel",data);
        }
	}
		
	public void function successor()
	{
		try
        {
        	data.message = meta.name & " Activity successor started";
        	writelog( text=data.message, application=isApplication(), file=getLogFileName() );
        	wsPublish("BecomeBroker_Channel",data);
		
        }
        catch(Any e)
        {
        	data.message = meta.name & " *Error* " & e.message;
        	writelog( text=data.message, application=isApplication(), file=getExceptionLogFileName() );
        	wsPublish("BecomeBroker_Channel",data);
        }
	}
	
	public void function onActivityEnd()
	{
		try
         {
         	data.message = meta.name & " Activity ended";
         	writelog( text=data.message, application=isApplication(), file=getLogFileName() );
			writelog( text="----------------------------#meta.name#--------------------------------", application=isApplication(), file=getLogFileName() );
			wsPublish("BecomeBroker_Channel",data);
		
         }
         catch(Any e)
         {
         	data.message = meta.name & " *Error* " & e.message;
         	writelog(text=data.message, application=isApplication(), file=getExceptionLogFileName() );
         	wsPublish("BecomeBroker_Channel",data);
         }
	}
}