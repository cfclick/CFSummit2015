component output="false"  
{
	import IActivity;
	import Logger;
	
	function init( IActivity successor)
	{
		variables.log = new Logger();
		variables.meta = getMetaData(successor);
		writelog(text="------------------------------------------------------------", application=log.getIsApplication(), file=log.getFileName(), type=log.getType());
		writelog(text="#meta.name# Activity initialization started", application=log.getIsApplication(), file=log.getFileName(), type=log.getType());
	}
	
	void function onActivityStart( )
	{
		writelog(text="#meta.name# Activity started", application=log.getIsApplication(), file=log.getFileName(), type=log.getType());
	}
	
	public boolean function execute(IActivity activity)
	{
		var act = arguments.activity;		
		writelog(text="#meta.name# Activity execute started", application=log.getIsApplication(), file=log.getFileName(), type=log.getType());
		act.onActivityStart();
		act.predecessor();	
		act.process();	
		act.successor();
		act.onActivityEnd();
		
		return true;
	}
	
	void function predecessor()
	{
		writelog(text="#meta.name# Activity predecessor started", application=log.getIsApplication(), file=log.getFileName(), type=log.getType());
	}
		
	void function process()
	{
		writelog(text="#meta.name# Activity process started", application=log.getIsApplication(), file=log.getFileName(), type=log.getType());
	}
		
	void function successor()
	{
		writelog(text="#meta.name# Activity successor started", application=log.getIsApplication(), file=log.getFileName(), type=log.getType());
	}
	
	void function onActivityEnd()
	{
		writelog(text="#meta.name# Activity ended", application=log.getIsApplication(), file=log.getFileName(), type=log.getType());
		writelog(text="-------------------------------------------------------------------", application=log.getIsApplication(), file=log.getFileName(), type=log.getType());
	}
}