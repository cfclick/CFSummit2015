interface  displayname="IActivity"
{	
	boolean function execute();
	void function onActivityStart();
	void function predecessor();
	void function process();
	void function successor();
	void function onActivityEnd();
}