<!--- READ ALL SIGNATURE FIELDS --->
<cfpdf action="readsignaturefields" 
	   source="#expandpath('pdfs/dsdemo_acrobat_signature_filed.pdf')#" 
	   name="readsignaturefields" >
	   
<cfdump var="#readsignaturefields#" label="No signed">	


<!--- SIGN, VALIDATE, READ AUTHOR PDF --->
<!--- SIGN --->
<cfpdf action="sign" 
	   source="#expandpath('pdfs/dsdemo_acrobat_signature_filed.pdf')#" 
	   destination="#expandpath('pdfs/dsDemo_acrobat_signature_field_signed_author.pdf')#" 
	   keystore="#expandPath('../../signatures/CFSummit.pfx')#" 
	   keystorepassword="CFSummit2015" 
	   overwrite="true" pages="1" 
	   height="50"
  	   width="250" 
  	   position="10,30" 
  	   author="true"> 

<!--- VALIDATE --->
<cfpdf action="validatesignature" 
		source="#expandpath('pdfs/dsDemo_acrobat_signature_field_signed_author.pdf')#" 
		name="signatureValidation_author" >
		
<cfdump var="#signatureValidation_author#" label="Author signature validation">


<!--- READ ALL SIGNATURE FIELDS --->
<cfpdf action="readsignaturefields" 
	   source="#expandpath('pdfs/dsDemo_acrobat_signature_field_signed_author.pdf')#" 
	   name="pdfAfterSignature_author" >
	   
<cfdump var="#pdfAfterSignature_author#" label="Signed by author"/>


<!--- END AUTHOR --->

<!--- SIGN, VALIDATE, READ APPLICANT PDF --->
<!--- SIGN --->	   
<cfpdf action="sign" signaturefieldname="Applicant_Signature" 
	   source="#expandpath('pdfs/dsDemo_acrobat_signature_field_signed_author.pdf')#" 
	   destination="#expandpath('pdfs/dsDemo_acrobat_signature_field_signed_applicant.pdf')#" 
	   keystore="#expandPath('../../signatures/Shirak.pfx')#" 
	   keystorepassword="CFSummit2015" 
	   overwrite="true"
	   author="false">

<!--- VALIDATE --->
<cfpdf action="validatesignature" 
		source="#expandpath('pdfs/dsDemo_acrobat_signature_field_signed_applicant.pdf')#" 
		name="signatureValidation_applicant" >
		
<cfdump var="#signatureValidation_applicant#" label="Applicant signature validation">


<!--- READ ALL SIGNATURE FIELDS --->
<cfpdf action="readsignaturefields" 
	   source="#expandpath('pdfs/dsDemo_acrobat_signature_field_signed_applicant.pdf')#" 
	   name="pdfAfterSignature_applicant" >

<cfdump var="#pdfAfterSignature_applicant#" label="Applicant signature read">


