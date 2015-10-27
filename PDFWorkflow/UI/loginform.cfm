<!DOCTYPE html>
<html lang="en">
	<head>
		<title>
			Login
		</title>
		<!-- load CSS -->
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" 
		      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
		<!-- Optional theme -->
		<link rel="stylesheet" 
		      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
		
		<!-- Latest compiled and minified JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js">

		</script>
		
		<script src="js/jquery.js">

		</script>
	</head>
	<body>
		<div class="container">
		<form method="post" action="index.cfm">
			<div class="form-group">
				<label for="Input_UserName">
					User Name
				</label>
				<input type="text" class="form-control" name="username" id="Input_UserName"
				       placeholder="Enter your username">
			</div>
			<div class="form-group">
				<label for="Input_Password">
					Password
				</label>
				<input type="password" class="form-control" name="password" id="Input_Password"
				       placeholder="Password">
			</div>
			
			<button type="submit" class="btn btn-default">
				Submit
			</button>
		</form>
		</div>
	</body>
</html>