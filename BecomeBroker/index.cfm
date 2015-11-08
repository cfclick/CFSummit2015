

<!DOCTYPE html>
<!--- 
		THIS CODE IS FOR DEMO PURPOSE 
		NOT TO DEMONSTRATE BEST PRACTICES
--->
<cfset config = new Config().GetEnvironment()/>
<!---<cfdump var="#config#">--->
<html lang="en" ng-app="BecomeBroker">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after*
		these tags -->
		<title>
			Template
		</title>
		
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" 
		      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
		
		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js">

		</script>
		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js">

		</script>
		<![endif]-->
		<script type="text/javascript" >
			var onMessageHandler = function(event, token){
				var local_scope = angular.element(document.getElementById('mainContainer')).scope();     	
        		local_scope.$apply( function() { local_scope.listenToWebSocket( event,token );} );  
			}
			
			var onOpenHandler = function(event){
				
			}
			
			function print(url){
			
				printer = document.getElementById("printerName").value;
				email = document.getElementById('sendEmail').checked;
				page = url + "&printer=" + printer + "&email=" + email;	
				window.location = page;// "http://Shirak-Dell:80/CFSummit2015/BecomeBroker/print.cfm?agencyName=Verdugo_Insurance.pdf&printer=" + printer;
			}
		</script>
	</head>
	<body>
		<cfparam name="url.message" default="">
		<cfparam name="url.type" default="">
		<div id="mainContainer" class="container-fluid" ng-controller="MainController as mctrl">
			<h1>
				PDF Signatures 
			</h1>
			<div class="row">
				<div class="col-lg-5">
					<div class="btn-group btn-group-justified" role="group">
						<cfoutput>
							<a class="btn btn-danger" 
							   href="http://#config.host.name#:#config.host.port##config.path.root#/BecomeBroker/clearall.cfm">
								Clear All
							</a>
							<a class="btn btn-danger" 
							   href="http://#config.host.name#:#config.host.port##config.path.root#/BecomeBroker/index.cfm">
								Refresh
							</a>
						</cfoutput>
					</div>
					<br>
					<cfoutput>
						<cfif isdefined("URL.message") and len(URL.message)>
							<div class="alert alert-#url.type#">
								#url.message#
							</div>
						</cfif>
					</cfoutput>
				
					<div class="panel panel-info">
						<div class="panel-heading">
							<h3 class="panel-title">
								Pending Assembly
							</h3>
						</div>
						<div class="panel-body">
							<cfdirectory action="list" directory="#config.path.pending#toAssemble" name="pendingList" 
							             filter="*.pdf">
							<table class="table table-striped">
								<tr>
									<th>File Name</th>
									<th>Date & Time</th>
									<th>Action</th>
								</tr>
								<cfoutput query="pendingList">
								<tr>
									<td>#Name# </td>
									<td>#DateTimeFormat(DateLastModified, 'mm/dd/yyyy hh:mm tt')#</td>
									<td><a href="http://#config.host.name#:#config.host.port##config.path.root#BecomeBroker/Assemble.cfm?agencyName=#Name#" 
										   class="btn btn-primary">
											Assemble
										</a>
										<a href="http://#config.host.name#:#config.host.port##config.path.root#BecomeBroker/documents_process/pending/toAssemble/#Name#" 
										   target="_blank" class="btn btn-info">
											View PDF
										</a>
										</td>
								</tr>
								</cfoutput>
							</table>
							
						</div>
					</div>
					
					<div class="panel panel-info">
						<div class="panel-heading">
							<h3 class="panel-title">
								Pending Manager Signature
							</h3>
						</div>
						<div class="panel-body">
							<cfdirectory action="list" directory="#config.path.approved#\byManager\tosign" 
							             name="AssembledList" filter="*.pdf">
							<table class="table table-striped">
								<tr>
									<th>File Name</th>
									<th>Date & Time</th>
									<th>Action</th>
								</tr>
								<cfoutput query="AssembledList">
								<tr>
									<td>#Name#</td>
									<td>#DateTimeFormat(DateLastModified, 'mm/dd/yyyy hh:mm tt')# </td>
									<td><a href="http://#config.host.name#:#config.host.port##config.path.root#BecomeBroker/Manager_Sign.cfm?agencyName=#Name#" 
										   class="btn btn-danger">
											Sign
										</a>
										<a href="http://#config.host.name#:#config.host.port##config.path.root#BecomeBroker/documents_process/approved/byManager/tosign/#Name#" 
										   target="_blank" class="btn btn-info">
											View PDF
										</a></td>
								</tr>
								</cfoutput>
							</table>
							
						</div>
					</div>
					
					<div class="panel panel-info">
						<div class="panel-heading">
							<h3 class="panel-title">
								Pending VP Signature
							</h3>
						</div>
						<div class="panel-body">
							<cfdirectory action="list" directory="#config.path.approved#\byManager\completed" 
							             name="ApprovedList" filter="*.pdf">
							<table class="table table-striped">
								<tr>
									<th>File Name</th>
									<th>Date & Time</th>
									<th>Action</th>
								</tr>
								<cfoutput query="ApprovedList">
								<tr>
									<td>#Name#</td>
									<td>#DateTimeFormat(DateLastModified, 'mm/dd/yyyy hh:mm tt')#</td>
									<td><a href="http://#config.host.name#:#config.host.port##config.path.root#BecomeBroker/VP_Sign.cfm?agencyName=#Name#" 
										   class="btn btn-danger">
											Sign
										</a>
										<a href="http://#config.host.name#:#config.host.port##config.path.root#BecomeBroker/documents_process/approved/byManager/completed/#Name#" 
										   target="_blank" class="btn btn-info">
											View PDF
										</a></td>
								</tr>
								</cfoutput>
								</table>
							
						</div>
					</div>
					
					
					<div class="panel panel-info">
						<div class="panel-heading">
							<h3 class="panel-title">
								To Print								
								<cfset printers = ListToArray(GetPrinterList()) />
							
										<select name="printerName" id="printerName">
											<option value="">Select printer</option>
											<cfloop array="#printers#" index="item" >
												<cfoutput><option value="#item#" >#item#</option></cfoutput>
											</cfloop>
										</select>
										
								<input type="checkbox" name="sendEmail" id="sendEmail" /> Email 
							</h3>
							
						</div>
						<div class="panel-body">
							<cfdirectory action="list" directory="#config.path.print#" name="PrintList" filter="*.pdf">
							<table class="table table-striped">
								<tr>
									<th>File Name</th>
									<th>Date & Time</th>
									<th>Action</th>
								</tr>
								<cfoutput query="PrintList">
								<tr>
									<td>#Name# </td>
									<td>#DateTimeFormat(DateLastModified, 'mm/dd/yyyy hh:mm tt')#</td>
									<td><button name="printBtn" id="printBtn" onclick="print('http://#config.host.name#:#config.host.port##config.path.root#BecomeBroker/print.cfm?agencyName=#Name#')" class="btn btn-default">
											Print PDF
										</button></td>
								</tr>
								</cfoutput>
							</table>
							
						</div>
					</div>
					
					
					<div class="panel panel-info">
						<div class="panel-heading">
							<h3 class="panel-title">
								Archived
							</h3>
						</div>
						<div class="panel-body">
							<cfdirectory action="list" directory="#config.path.archive#\temp" name="ArchiveList" 
							             filter="*.pdf">
							<table class="table table-striped">
								<tr>
									<th>File Name</th>
									<th>Date & Time</th>
									<th>Action</th>
								</tr>
								<cfoutput query="ArchiveList">
									<tr>
										<td>
											#Name#
										</td>
										<td>
											#DateTimeFormat(DateLastModified, 'mm/dd/yyyy hh:mm tt')# 
										</td>
										<td>
											<a href="http://#config.host.name#:#config.host.port##config.path.root#BecomeBroker/documents_process/archive/temp/#Name#" 
											   target="_blank" class="btn btn-info">
												View PDF
											</a>
										</td>
									</tr>
								</cfoutput>
							</table>
						</div>
					</div>
				</div>
				
				<div class="col-lg-4">
					
					<div class="panel panel-success">
						<div class="panel-heading">
							<h3 class="panel-title">
								Real time logging
							</h3>
						</div>
						<div class="panel-body">
							<div id="logging_data" ng-bind="message">
							</div>
						</div>
					</div>
					
					<div class="panel panel-success">
						<div class="panel-heading">
							<h3 class="panel-title">
								Lib (Listener)
							</h3>
						</div>
						<div class="panel-body">
							<div id="lib_data" ng-bind="libdata">
							</div>
						</div>
					</div>
					
				</div>
			</div>
		</div>
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js">

		</script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<!-- Latest compiled and minified JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js">

		</script>
		
		<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.7/angular.min.js"></script>
		
		<script src="js/main.js">

		</script>
		
		<cfwebsocket name="BecomeBroker_websoket" onmessage="onMessageHandler" onopen="onOpenHandler" 
		             subscribeto="BecomeBroker_Channel"/>
	</body>
</html>