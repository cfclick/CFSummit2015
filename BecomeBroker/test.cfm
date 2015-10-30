<cfscript>
	pdf = new PDF();
	  				pdf.setDestination( "C:\inetpub\wwwroot\CFSummit2015\BecomeBroker\documents_process\assemble\Verdugo_Insurance.pdf" )
	  				.setOverwrite(true)
	  				.setPackage(true);
	  				pdf.addParam(source= "C:\inetpub\wwwroot\CFSummit2015\BecomeBroker\assets\cover_letter.docx");
	  				pdf.addParam(source= "C:\inetpub\wwwroot\CFSummit2015\BecomeBroker\documents_process\pending\toAssemble\Verdugo_Insurance.pdf");
	  				pdf.addParam(source= "C:\inetpub\wwwroot\CFSummit2015\BecomeBroker\assets\mybackyard.jpg");
	  				pdf.addParam(source= "C:\inetpub\wwwroot\CFSummit2015\BecomeBroker\assets\Curro.mp3");
	  				pdf.addParam(source= "C:\inetpub\wwwroot\CFSummit2015\BecomeBroker\assets\jt021109-desktop.m4v");
	  				pdf.addParam(source= "C:\inetpub\wwwroot\CFSummit2015\BecomeBroker\assets\CFSummit2015-digital-signature.pptx");
	  				pdf.addParam(source= "C:\inetpub\wwwroot\CFSummit2015\BecomeBroker\assets\CFWfS_diagram.vsdx");
	  				pdf.addParam(source= "C:\inetpub\wwwroot\CFSummit2015\BecomeBroker\assets\MyList.xlsx"); 				  				
	  				pdf.merge();
	  				
cfhtmltopdf(destination="C:\inetpub\wwwroot\CFSummit2015\BecomeBroker\assets\htmlsource.pdf",
	  							source="http://www.foxnews.com/",
	  							orientation="landscape",
	  							pagetype="letter",
	  							margintop="0.5",
	  							marginbottom="0.5",
	  							marginleft="0.5",
	  							marginright="0.5",
	  							ownerpassword="owner",
	  							userpassword="user",
	  							encryption="RC4_128",
	  							permissions="AllowPrinting,AllowCopy",
	  							overwrite="true");	
</cfscript>
