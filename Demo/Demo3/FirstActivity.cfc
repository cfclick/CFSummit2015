component implements="IActivity" extends="BaseActivity" output="false" accessors="true" 
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
		sleep(3000);
		super.onActivityStart(this.getActivityCollection());
	}
	
	public void function predecessor()
	{
		sleep(3000);
		super.predecessor();
		if( !isNull(predecessorActivity)  && isInstanceOf( predecessorActivity, "IActivity" ) ){
			predecessorActivity.process();
		}
				
	}
	
	public boolean function execute()
	{
		sleep(3000);
		return super.execute(this);
	}
	
	public void function process()
	{
		sleep(3000);
		writelog( text="Im firstActivity process running", file="Demo"  );
	}
	
	public void function successor()
	{
		sleep(3000);
		super.successor();
		
		try
        {      	
			if( !isNull(successorActivity)  && isInstanceOf( successorActivity, "IActivity" ) )
				successorActivity.execute();
        }
        catch(Any e)
        {
        	writelog(text=e.message, application='yes', file='WFExeption');
        	continue;
        }

	}
	
	public void function onActivityEnd()
	{
		sleep(3000);
		super.onActivityEnd();
	}

}