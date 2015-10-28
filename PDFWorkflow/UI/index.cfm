<!DOCTYPE html>
<html lang="en" ng-app="PDFWF" >
	<head>
		<title>
			Dashboard
		</title>
		<!-- load CSS -->
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" 
		      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
		<!-- Optional theme -->
		<link rel="stylesheet" 
		      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
		
		<!-- load javascript -->		
		<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
		<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>		
		<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.15/angular.min.js" 
		        type="text/javascript">
		</script>
		<!-- Latest compiled and minified JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js">
		</script>
		
		
		<!--- main javascript --->
		<script type="text/javascript" >
			var onMessageHandler = function(event, token){
				//alert(JSON.stringify(event.data.ACTIONNAME));
				var local_scope = angular.element(document.getElementById('managerColumnDiv')).scope();     	
        		local_scope.$apply( function() { local_scope.listenToWebSocket( event,token );} );  
			}
			
			var onOpenHandler = function(event){
				
			}
		</script>
		
		<script src="js/pages/main.js" >			
		</script>
	</head>
	<body ng-controller="MainController">
		<div class="container">
			<nav class="navbar navbar-default">
				<div class="container-fluid">
					<div class="navbar-header">
						<h3>Welcome <cfoutput>#GetAuthUser()#</cfoutput></h3> 
						
					</div>
					<cfif IsuserLoggedIn()>
					
					  <div  class="navbar-form navbar-right">
					  <a href="?do=logout" class="btn btn-default">Logout</a>
					</div>
					</cfif>
				    
				</div>
			</nav>
			
			<div class="row">
				<cfif(isUserInAnyRole("GUEST,ADMIN"))>
				<div class="col-md-4">
					<div class="panel panel-primary col-md-*">
						<div class="panel-heading">
							Applicant
						</div>
						<div class="panel-body">						
							<form action="apply_for_community.cfm" method="post" target="_blank"  >
								<button type="submit" id="btn_applicant" class="btn btn-primary btn-lg">
									Apply For a Community 
								</button>
							</form>
							
						</div>
					</div>
				</div>
				</cfif>
				<cfif(isUserInAnyRole("ADMIN,MANAGER"))>
				<div class="col-md-4">
					<div id="managerColumnDiv" class="panel panel-primary col-md-*">
						<div class="panel-heading">
							Manager
						</div>
						<div class="panel-body">
							<button id="btn_manager" class="btn btn-primary btn-lg">
								Waiting For Review
								<span class="badge">
									{{managerListCount}}
								</span>
							</button>
							<br>
							<br>
							<div id="managerListDIV" class="list-group" ng-repeat="item in managerList">
								<a href="{{item.PATHANDNAME}}" class="list-group-item" target="_blank" >{{item.NAME}} - {{item.PATHANDNAME}}</a>
								<button ng-click="clearStorage(item)" class="btn btn-danger" >Reject</button>
							</div>
						</div>
					</div>
				</div>
				</cfif>
				<cfif(isUserInAnyRole("ADMIN,VP"))>
				<div class="col-md-4">
					<div class="panel panel-primary col-md-*">
						<div class="panel-heading">
							VP
						</div>
						<div class="panel-body">
							<button id="btn_vp" class="btn btn-primary btn-lg">
								Waiting For Approval 
								<span class="badge">
									42
								</span>
							</button>
							<br>
							<br>
							<div class="list-group">
								
							</div>
						</div>
					</div>
				</div>
				</cfif>
			</div>
		</div>
		
		<!--- Web Socket object --->
		
        	<cfwebsocket name="WS_PDF_Workflow" onmessage="onMessageHandler" onopen="onOpenHandler" subscribeto="CFSummit2015_PDFWorkflow" />        
      

	</body>
</html>