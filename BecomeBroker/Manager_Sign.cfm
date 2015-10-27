<cfif isdefined("URL.agencyName")>
	<cfset agencyName = url.agencyName />
<cfelse>
	<cfset agencyName = "default.pdf"/>
</cfif>
<cfif isdefined("Url.valid")>
	<cfpdf action="sign" 
		source="../packagePDF/source/BecomeBrokerSignaturePage.pdf"
		destination="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/temp/Manager_signature_#agencyName#" 
		keystore="#expandPath('../packagePDF/signatures/valid/dominique_lark.pfx')#" 
		keystorepassword="123456"
		pages="1"
		height="50"
		width="250"
		position="60,470"
		author="false"
		overwrite="yes" >
<cfelse>
	<cfpdf action="sign" 
		source="../packagePDF/source/BecomeBrokerSignaturePage.pdf"
		destination="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/temp/Manager_signature_#agencyName#" 
		keystore="#expandPath('../packagePDF/signatures/DominiqueLark.pfx')#" 
		keystorepassword="baghdad"
		pages="1"
		height="50"
		width="250"
		position="60,470"
		author="false"
		overwrite="yes" >
</cfif>

<cfpdf 
	action="validatesignature" 
	source="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/temp/Manager_signature_#agencyName#" 
	name="verify" >

<cfif comparenocase(verify.Success,"YES") eq 0 >	
	<cfpdf action="merge" 
	destination="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/byManager/completed/#agencyName#" overwrite="yes" package="true">
		<cfpdfparam source="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/byManager/tosign/#agencyName#"  >
		<cfpdfparam source="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/temp/Manager_signature_#agencyName#"  >	
	</cfpdf>
	
	<cfif fileExists("C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/byManager/tosign/#agencyName#")>
		<cffile action="delete" file="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/byManager/tosign/#agencyName#" >
	</cfif>
	<h3>Application signed by manager</h3>
	<cfset message = "Application signed by manager">
	<cfset type = "success">
<cfelse>
	<cfpdf action="unsign" 
	source="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/temp/Manager_signature_#agencyName#"
	destination="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/temp/Manager_signature_unsign_#agencyName#"
	unsignall="true" >
	<cfset message = "Sorry, Invalid signature">
	<cfset type = "danger">
</cfif>

<cflocation url="http://localhost:8500/TestProjects/index.cfm?message=#message#&type=#type#" >
		





