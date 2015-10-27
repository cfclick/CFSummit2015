
<cfpdf action=protect source="#expandPath( '../template/CFDemo1.pdf' )#" newownerpassword="o"  
encrypt="AES_128" permissions="AllowSecure"     
destination="#expandPath( '../template/sample_Allowsecure.pdf' )#" overwrite="true">

<cfpdf action="getinfo" source="#expandPath( '../template/sample_Allowsecure.pdf' )#" name="test">

<cfdump var="#test#"> <cfabort>
<cfscript>
	pdf = new PDF();
	pdf.setSource( expandPath( '../template/CFDemo01.pdf' ) );
	pdf.setpermissions('AllowSecure');
	pdfRead = pdf.read();
	writeDump(pdfRead);	
	
	
</cfscript><cfabort>
<!---<cfmail from="ColdFusion" subject="test" to="shirakavakian@gmail.com" >
	this is test
</cfmail>--->
<!---<cfif isdefined("PDF")>
	<cfdump var="#PDF#">
	<cfpdfform source="#PDF.content#" result="resultStruct" action="read"/>
	<cfdump var="#resultStruct#">
	<cfpdf action="readsignaturefields" source="#PDF.content#" name="signRead" >
	<cfdump var="#signRead#">
</cfif>--->

<!---<cfpdf action="validatesignature" name="" source="" >--->
<!doctype html>
<html >
	<head>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="jquery.signaturepad.min/jquery.signaturepad.min.js" >
	
</script>

</head>
<body>
<canvas  class="pad" width="218" height="55" style="margin: 0px 0px 0px 100px;  border-style: solid; border-width: 1px; border-color: #bbbbbb #dbdfe6 #e3e9ef #e2e3ea; -webkit-border-radius: 1px; -moz-border-radius: 1px; -o-border-radius: 1px; border-radius: 1px; -webkit-box-sizing: border-box; -moz-box-sizing: border-box; box-sizing: border-box; background-color: #FFFFFF;"></canvas></br>
	<span style="margin: 0px 0px 0px 264px;">
		<input type="reset" class="clearButton" value="Clear">
	</span>
<input type="hidden" name="output" class="output">
<script type="text/javascript">
	$(document).ready(function () {
	  	$('#caspioform').signaturePad({drawOnly : true});
	});
	$("#cb_sign_wrapper form").submit(function(){
	$("#InsertRecordSignature")[0].value = $("#cb_sign_wrapper .output")[0].value;
	});
</script>

<div id="cb_sign_wrapper"></div>
</body>
</html>