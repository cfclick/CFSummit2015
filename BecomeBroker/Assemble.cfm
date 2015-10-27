<cfif isdefined("URL.agencyName")>
	<cfset agencyName = url.agencyName />
<cfelse>
	<cfset agencyName = "default.pdf"/>
</cfif>
<cfhtmltopdf destination="../packagePDF/source/htmlsource.pdf"
  source="http://www.foxnews.com/"
  orientation="landscape"  pagetype="letter" margintop="0.5" marginbottom="0.5"
  marginleft="0.5" marginright="0.5" ownerpassword="owner" userpassword="user"
  encryption="RC4_128" permissions="AllowPrinting,AllowCopy" overwrite="true" />
  
<cfpdf action="merge" destination="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/Assembled/temp/#agencyName#" overwrite="yes" package="true">
	<cfpdfparam source="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/pending/toAssemble/#agencyName#"  >
	<cfpdfparam source="../packagePDF/source/TestPolicies2013Nov.pdf"  >
	<cfpdfparam source="../packagePDF/source/Slide1.jpg"  >
	<cfpdfparam source="../packagePDF/source/Curro.mp3"  >
	<cfpdfparam source="../packagePDF/source/jt021109-desktop.m4v"  >
	<cfpdfparam source="../packagePDF/source/Document Factory.pptx"  >
	<cfpdfparam source="../packagePDF/source/DocumentFactoryDiagram.vsd"  >
	<cfpdfparam source="../packagePDF/source/phone1.xls"  >
	<cfpdfparam source="../packagePDF/source/DocumentFactoryDoc.doc"  >
	<cfpdfparam source="../packagePDF/source/htmlsource.pdf" password="owner"  >
	
</cfpdf>

<cfset PDFinfo=StructNew()> 
<cfset PDFinfo.Title="#agencyName#"> 
<cfset PDFinfo.Author="Century-National Insurance"> 
<cfset PDFinfo.Keywords="Assembled"> 
<cfset PDFinfo.Subject="#agencyName# Complete Package"> 
<cfset PDFinfo.FillingForm = "No">
<cfset PDFinfo.Application = "Demo by Shirak">
<cfpdf action="setInfo" source="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/Assembled/temp/#agencyName#" 
		info="#PDFinfo#" destination="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/Assembled/#agencyName#" 
		overwrite="yes">
		<cffile action="copy" 
		destination="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/byManager/tosign/#agencyName#" 
		source="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/Assembled/#agencyName#" 
		>

<cfif fileExists("C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/pending/toAssemble/#agencyName#")>
	<cffile action="delete" file="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/pending/toAssemble/#agencyName#" >
</cfif>

<cfif fileExists("C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/Assembled/temp/#agencyName#")>
	<cffile action="delete" file="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/Assembled/temp/#agencyName#" >
</cfif>

<cfset message = "Application assembled successfully">
<cfset type = "success">

<cflocation url="http://localhost:8500/TestProjects/index.cfm?message=#message#&type=#type#" >

