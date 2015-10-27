component output="false"  
{
	import IActivity;
	import Logger;
	
	function init( IActivity successor)
	{
		try
        {
        	variables.log = new Logger();
			variables.meta = getMetaData(successor);
			writelog(text="----------------------------#meta.name#--------------------------------", application=log.getIsApplication(), file=log.getFileName(), type=log.getType());
			writelog(text="#meta.name# Activity initialization started", application=log.getIsApplication(), file=log.getFileName(), type=log.getType());
        }
        catch(Any e)
        {
        	writelog(text=e.message, application='yes', file='WFExeption');
        }

	}
	
	void function onActivityStart( )
	{
		try
        {
        	writelog(text="#meta.name# Activity started", application=log.getIsApplication(), file=log.getFileName(), type=log.getType());
        }
        catch(Any e)
        {
        	writelog(text=e.message, application='yes', file='WFExeption');
        }

	}
	
	public boolean function execute(IActivity activity)
	{
		try
        {
        	
        	var act = arguments.activity;		
			writelog(text="#meta.name# Activity executed", application=log.getIsApplication(), file=log.getFileName(), type=log.getType());	
			act.onActivityStart();			
			act.predecessor();	
			act.process();				
			act.successor();
			act.onActivityEnd();
			
			return true;
        }
        catch(Any e)
        {
        	writelog(text=e.message, application='yes', file='WFExeption');
        }

	}
	
	void function predecessor()
	{
		try
        {
        	writelog(text="#meta.name# Activity predecessor started", application=log.getIsApplication(), file=log.getFileName(), type=log.getType());
		
        }
        catch(Any e)
        {
        	writelog(text=e.message, application='yes', file='WFExeption');
        }
	}
		
	void function process()
	{
		try
        {
        	writelog(text="#meta.name# Activity process started", application=log.getIsApplication(), file=log.getFileName(), type=log.getType());
		
        }
        catch(Any e)
        {
        	writelog(text=e.message, application='yes', file='WFExeption');
        }
	}
		
	void function successor()
	{
		try
        {
        	writelog(text="#meta.name# Activity successor started", application=log.getIsApplication(), file=log.getFileName(), type=log.getType());
		
        }
        catch(Any e)
        {
        	writelog(text=e.message, application='yes', file='WFExeption');
        }
	}
	
	void function onActivityEnd()
	{
		try
         {
         	writelog(text="#meta.name# Activity ended", application=log.getIsApplication(), file=log.getFileName(), type=log.getType());
			writelog(text="----------------------------#meta.name#--------------------------------", application=log.getIsApplication(), file=log.getFileName(), type=log.getType());
		
         }
         catch(Any e)
         {
         	writelog(text=e.message, application='yes', file='WFExeption');
         }
	}
}