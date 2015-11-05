<cfscript>
	config = {};
	config = new Config().GetEnvironment();
	activityManager = new ActivityManager();
	activityManager.executeSweeperProcess();
	message = "All PDFs deleted successfully";
	type = "success";
	cflocation( url="http://" & config.host.name & ":" & config.host.port & config.path.root & "/BecomeBroker/index.cfm?message=#message#&type=#type#");
</cfscript>


<!---<cfdirectory action="list"  directory="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/byManager/completed/" name="manager_completed" filter="*.pdf" >
<cfdump var="#manager_completed#">
<cfabort>
<cfloop query="manager_completed">
	<cffile action="delete"  file="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/byManager/completed/#Name#" >
</cfloop>
	
<cfdirectory action="list" directory="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/byManager/tosign/" name="manager_tosign" filter="*.pdf">
<cfloop query="manager_tosign">
	<cffile action="delete"  file="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/byManager/tosign/#Name#" >
</cfloop>

<cfdirectory action="list" directory="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/byVP/" name="VP" filter="*.pdf">
<cfloop query="VP">
	<cffile action="delete"  file="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/byVP/#Name#" >
</cfloop>

<cfdirectory action="list" directory="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/byVP/completed/" name="VP_completed" filter="*.pdf">
<cfloop query="VP_completed">
	<cffile action="delete"  file="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/byVP/completed/#Name#" >
</cfloop>

<cfdirectory action="list" directory="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/temp" name="approved_temp" filter="*.pdf">
<cfloop query="approved_temp">
	<cffile action="delete"  file="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/temp/#Name#" >
</cfloop>

<cfdirectory action="list" directory="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/archive/temp/" name="archive_temp" filter="*.pdf" >
<cfloop query="archive_temp">
	<cffile action="delete"  file="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/archive/temp/#Name#" >
</cfloop>

<cfdirectory action="list" directory="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/Assembled/temp/" name="assembled_temp" filter="*.pdf">
<cfloop query="assembled_temp">
	<cffile action="delete"  file="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/Assembled/temp/#Name#" >
</cfloop>

<cfdirectory action="list" directory="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/Assembled/" name="assembled" filter="*.pdf" >
<cfloop query="assembled">
	<cffile action="delete"  file="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/Assembled/#Name#" >
</cfloop>

<cfdirectory action="list" directory="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/pending/temp/" name="pending_temp" filter="*.pdf" >
<cfloop query="pending_temp">
	<cffile action="delete"  file="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/pending/temp/#Name#" >
</cfloop>

<cfdirectory action="list" directory="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/pending/toAssemble/" name="pending_toAssemble" filter="*.pdf" >
<cfloop query="pending_toAssemble">
	<cffile action="delete"  file="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/pending/toAssemble/#Name#" >
</cfloop>

<cfdirectory action="list" directory="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/print/" name="print" filter="*.pdf" >
<cfloop query="print">
	<cffile action="delete"  file="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/print/#Name#" >
</cfloop>

<cfset message = "All PDFs deleted successfully">
<cfset type = "success">

<cflocation url="http://localhost:8500/TestProjects/index.cfm?message=#message#&type=#type#" >--->