var app = angular.module("BecomeBroker",[]);

app.controller("MainController", function($scope){
	
	$scope.message = ""; //holds result of current received data from server
	$scope.libdata = "";
	
	$scope.listenToWebSocket = function(aEvent,aToken) 
	{
	 	if(aEvent.data)
	 	{	 			
			$scope.message = $scope.message + aEvent.data.MESSAGE  + "\n";
			//alert(JSON.stringify(aEvent.data));
			if(aEvent.data.FILEINFO)
			{
				$scope.libdata = $scope.libdata + aEvent.data.FILEINFO.name + "\n";
			}
			
			if(aEvent.data.REFRESH)
			{
				location.reload();
			}
	 				
		}						
     }
})
