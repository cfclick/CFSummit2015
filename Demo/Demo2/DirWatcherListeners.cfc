component  output="false"
{
	public function onAdd(struct cfEvent)
	{
		//define PDF File Info
		try
        {
        	var data = arguments.cfEvent.data;
			writelog(file="DWDemo", application="No" , text="ACTION: #data.type#;FILE: #data.filename#; TIME: #timeFormat(data.lastmodified)#");			
        }
        catch(Any e)
        {
        	writelog(file="PDFWorkflowDirWatcher", application="No" , text="Error: directory watcher onAdd() #e.message#");
        	throw(object=e);
        }

			
	}
	
	public function onDelete( struct cfEvent )
	{
		var data = arguments.cfEvent.data;
		writelog(file="DWDemo", application="No" , text="ACTION: #data.type#;FILE: #data.filename#; TIME: #timeFormat(data.lastmodified)#");			
        
		//return cfEvent;
	}
	
	public function onChange( struct cfEvent )
	{
		var data = arguments.cfEvent.data;
		writelog(file="DWDemo", application="No" , text="ACTION: #data.type#;FILE: #data.filename#; TIME: #timeFormat(data.lastmodified)#");			
        
		//return cfEvent;
	}
}