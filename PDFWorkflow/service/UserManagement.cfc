component  output="false"
{
	public struct function authenticate( required string username, required string password ){
		var user = {};
		user.name = arguments.username;
		user.role = "";
		
		switch( user.name ){
			case 'Shirak':{
				user.role = "ADMIN";
				break;
			}
			case 'Joe':{
				user.role = "MANAGER";
				break;
			}
			case 'Mike':{
				user.role = "VP";
				break;
			}	
			default:{
				user.role = "GUEST";
				break;
			}			
		}
		
		return user;
	}
	
	public void function logoff(){
		logout;
	}
}