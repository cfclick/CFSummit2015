
<cfscript>
	message = "";
	type = "";
	if( isdefined("URL.agencyName") ){
		agencyName = url.agencyName;
	}else{
		agencyName = "default.pdf";
	}
	
	if( isdefined("URL.printer") ){
		printer = url.printer;
	}else{
		printer = "";
		message = "Printer not defined";
		type = "danger";
	}
	
	if( isdefined("URL.email") ){
		email = url.email;
	}else{
		email = false;
	}
	
	activityCollection = {};
	activityCollection.pdfFileName = agencyName;
	activityCollection.printer = printer;
	activityCollection.config = {};
	activityCollection.config = new Config().GetEnvironment();
	
	try
    {
    	if(email)
    	{
    		emailActivity = new Activities.EmailActivity();
    		printActivity = new Activities.PrintActivity( emailActivity );
    	}else{
    		printActivity = new Activities.PrintActivity( );
    	}
    	
		printActivity.setActivityCollection( activityCollection );
		printActivity.execute();
		message = "Application #activityCollection.pdfFileName# printer successfully using #printer#";
		type = "success";
		cflocation( url="http://" & activityCollection.config.host.name & ":" & activityCollection.config.host.port & activityCollection.config.path.root & "BecomeBroker/index.cfm?message=#message#&type=#type#");
    }
    catch(Any e)
    {
    	message = e.message;
		type = "danger";
    	continue;
    }finally{
    	//message = "Something wrong happen!";
		//type = "danger";
    	cflocation( url="http://" & activityCollection.config.host.name & ":" & activityCollection.config.host.port & activityCollection.config.path.root & "BecomeBroker/index.cfm?message=#message#&type=#type#");
    }


	/*cfprint( type="pdf",
			 source=config.path.print & agencyName,
			 printer=printer,
			 password="owner" );*/
	
	/*message = "Application printed successfully";
	type = "success";
	cflocation( url="http://" & activityCollection.config.host.name & ":" & activityCollection.config.host.port & activityCollection.config.path.root & "BecomeBroker/index.cfm?message=#message#&type=#type#");
*/</cfscript>

<!---
<cfprint type="pdf" 
	source="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/print/#agencyName#" 
	printer="#printer#"
	password="owner">
	

<cfset message = "Application printed successfully">
<cfset type = "success">

<cflocation url="http://localhost:8500/TestProjects/index.cfm?message=#message#&type=#type#" >--->