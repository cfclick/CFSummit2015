var app = angular.module("BecomeBroker",[]);

app.controller("MainController", function($scope){
	
	$scope.message = "";
	
	$scope.listenToWebSocket = function(aEvent,aToken) 
	{
		$scope.currentMessage = {}; //holds result of current received data from server
	 	if(aEvent.data)
	 	{
	 		if(aEvent.data)
	 		{
	 			if(aEvent.data.refresh)
	 			
				$scope.message = $scope.message + aEvent.data.MESSAGE  + "\n";
			}
		}						
     }
})
