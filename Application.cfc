component 
{
	this.name = 'CFSummit2015';
	this.mappings['\CFSummit2015'] = "C:\inetpub\wwwroot\CFSummit2015\";
	this.wschannels=[{name="CFSummit2015_PDFWorkflow"}];
	this.sessionManagement = true;
	
	function onapplicationstart(){
		//abort;
	}
	
		
	function onrequestStart(page){
		if(isdefined("URL.do") && Url.do == 'logout'){
			var userManagement = new PDFWorkflow.service.UserManagement();		
			userManagement.logoff();
			location( url="loginform.cfm" , addtoken="false" );
		}
		cflogin( idletimeout="600" , allowconcurrent="true") {
			if(isdefined("form.username") && isdefined("form.password") )
			{
				var userManagement = new PDFWorkflow.service.UserManagement();					
				var user = userManagement.authenticate( trim(form.username),trim(form.password) );	
				cfloginuser( name="#user.name#", password="#trim(form.password)#",roles="#user.role#");
			}
			else{
				include "PDFWorkflow/UI/loginform.cfm"   ;
				abort;
			}				
										
		}
		return true;
	}
}