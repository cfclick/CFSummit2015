 var PDFWF = angular.module( "PDFWF", [] );
  
 PDFWF.controller(
            "MainController",
            function( $scope, $timeout ) 
            {	
            	//Define $scope variables
				$scope.managerListCount = 0;
				
				if( localStorage && localStorage.getItem('managerList') )
					$scope.managerList = JSON.parse(localStorage.getItem('managerList'));
				else
					$scope.managerList = []; //holds the data from local storage
				
				$scope.managerListCount = $scope.managerList.length;
							    
			    $scope.clearStorage = function(key){
			    	
			    	if(key)
			    	{		    		
			    		temp = removeByAttr($scope.managerList,'TOKEN',key.TOKEN );
			    		localStorage.setItem('managerList',JSON.stringify( temp ) );
			    		alert(JSON.stringify(key));
			    		rejectPDF(key);			    		
			    	}
			    	else
			    	{
			    		localStorage.clear();
			    		$scope.managerList = [];
			    		//$scope.transactionLogs = [];
			    	}	
			    	
			    	$scope.managerListCount = $scope.managerList.length;		    			    	
			    }
			    				
				$scope.listenToWebSocket = function(aEvent,aToken) 
				{
					$scope.currentMessage = {}; //holds result of current received data from server
				 	if(aEvent.data)
				 	{
				 		sessionStatusUpdate(aEvent.data,'Token', aEvent.data.Token )
					}						
			     }
			     
			     var rejectPDF = function (item) {	
			     	$.ajax({
					   url: "FileManager.cfc?method=Reject", 
					   dataType: "json",
					   data: {fileInfo: JSON.stringify(item)}
					   
					});	
					}
				/* $.get("FileManager.cfc?method=Reject", data:item, function() {});
				 console.log(item.PATHANDNAME);
				 }*/
			     
			   
			     function sessionStatusUpdate( currSession, attr, value )
			     {
			     	var tempArray = [];
			     	var isNewSession = true;
			     	if(localStorage && localStorage.getItem('managerList'))
			     	{			     		
			     		console.log('getting it from local storage');
						tempArray = JSON.parse(localStorage.getItem('managerList'));
						
						var i = tempArray.length;
						console.log('session length: ' + i );
				    	
				    	
				    	if( isNewSession )
				    	{
				    		console.log('No active session: ' + value );
				    		tempArray.push( currSession );
				    		console.log('session pushed to temp array: ' + value );
				    		localStorage.setItem('managerList',JSON.stringify( tempArray ) );
				    		console.log('local storage updated: ' + value );
				    		$scope.managerList = JSON.parse(localStorage.getItem('managerList'));
				    		$scope.managerListCount = $scope.managerList.length;
				    		
				    	}else{
				    		console.log('active session found: ' + value );
				    		localStorage.setItem('managerList',JSON.stringify( tempArray ) );
				    		console.log('local storage updated: ' + value );
				    		$scope.managerList = JSON.parse(localStorage.getItem('managerList'));
				    		$scope.managerListCount = $scope.managerList.length;
				    	}				    	
						
						
					}
					else 
					{
						console.log('local storage not found');
						tempArray.push(currSession);
						
						localStorage.setItem('managerList',JSON.stringify( tempArray ));
						console.log('loca storage created and inserted with current sessian: ' + value);
						$scope.managerList = JSON.parse(localStorage.getItem('managerList'));
						$scope.managerListCount = $scope.managerList.length;					  
					}
			     	
			     	console.log('scope activeSessions updated');
			     }
               
                function sortOn( collection, name ) 
                {
                    collection.sort( function( a, b ) 
                    				 {
                            			if ( a[ name ] <= b[ name ] ) 
                            			{
                                			return( -1 );
                            			}
                            			return( 1 );
                        			 }
                   				    );
                }
                
                var removeByAttr = function(arr, attr, value)
                {
			    	var i = arr.length;
			    	while(i--)
			    	{
			       		if( arr[i] && arr[i].hasOwnProperty(attr) && (arguments.length > 2 && arr[i][attr] === value ) )
			       		{ 
			           		arr.splice(i,1);
			
			       		}
			    	}
			    	return arr;
				}              
                
            }
        );

		