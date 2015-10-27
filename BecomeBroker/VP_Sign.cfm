<cfset agencyName = "" />
<cfif isdefined("URL.agencyName")>
	<cfset agencyName = url.agencyName />
<cfelse>
	<cfset agencyName = "default.pdf"/>
</cfif>
<cfif isdefined("Url.valid")>
	<cfpdf action="sign" 
			source="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/temp/Manager_signature_#agencyName#"
			destination="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/temp/VP_signature_#agencyName#" 
			keystore="#expandPath('../packagePDF/signatures/valid/saro_hamamah.pfx')#" 
			keystorepassword="123456"
			signaturefieldname="VP_Signature"
			overwrite="yes" >
<cfelse>

	<cfpdf action="sign" 
		source="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/temp/Manager_signature_#agencyName#"
		destination="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/temp/VP_signature_#agencyName#" 
		keystore="#expandPath('../packagePDF/signatures/SaroHamamah.pfx')#" 
		keystorepassword="baghdad"
		signaturefieldname="VP_Signature"
		overwrite="yes" >

</cfif>


<cffile action="copy" destination="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/print/" 
source="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/temp/VP_signature_#agencyName#" >

<cfpdf action="merge" 
destination="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/byVP/#agencyName#" overwrite="yes" package="true">
	<cfpdfparam source="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/Assembled/#agencyName#"  >
	<cfpdfparam source="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/temp/VP_signature_#agencyName#"  >
	
</cfpdf>

<cfif fileExists("C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/Assembled/#agencyName#")>
	<cffile action="delete" file="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/Assembled/#agencyName#" >
</cfif>

<cfif fileExists("C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/temp/Manager_signature_#agencyName#")>
	<cffile action="delete" file="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/temp/Manager_signature_#agencyName#" >
</cfif>

<cfif fileExists("C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/temp/VP_signature_#agencyName#")>
	<cffile action="delete" file="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/temp/VP_signature_#agencyName#" >
</cfif>


<cfif fileExists("C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/temp/Manager_signature_#agencyName#")>
	<cffile action="delete" file="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/temp/Manager_signature_#agencyName#" >
</cfif>

<cfif fileExists("C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/byManager/completed/#agencyName#")>
	<cffile action="delete" file="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/byManager/completed/#agencyName#" >
</cfif>

<cffile action="move" destination="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/byVP/completed" 
source="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/byVP/#agencyName#" >

<cfmail from="no-reply@cnico.com" to="shirakgrigor@cnico.com" type="text/html" 
	        subject="Agency #agencyName# submitted application Approved">
	    
	    <h3>Please sign attached document</h3>   
		<cfmailparam file="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/byVP/completed/#agencyName#">
</cfmail>


<cfset message = "Application signed and approved by VP">
<cfset type = "success">

<cflocation url="http://localhost:8500/TestProjects/index.cfm?message=#message#&type=#type#" >