<cfscript>
	secondActivity = new SecondActivity(javacast('null',''),new FirstActivity() );
	firstActivity = new FirstActivity( secondActivity );
	
	firstActivity.execute(); 	
</cfscript>
