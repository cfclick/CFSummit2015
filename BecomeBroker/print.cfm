<cfif isdefined("URL.agencyName")>
	<cfset agencyName = url.agencyName />
<cfelse>
	<cfset agencyName = "default.pdf"/>
</cfif>
<cfprint type="pdf" 
	source="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/print/#agencyName#" 
	printer="HP LaserJet 4100 Series PCL6"
	password="owner">
	

<cfset message = "Application printed successfully">
<cfset type = "success">

<cflocation url="http://localhost:8500/TestProjects/index.cfm?message=#message#&type=#type#" >