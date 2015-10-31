component 
{
	public function init()
	{
		variables.InetAddress = createObject("java", "java.net.InetAddress");
		variables.machineName = variables.InetAddress.localhost.getCanonicalHostName();
		variables.system = createobject("java","java.lang.System");
		variables.fileSeparator = variables.system.getProperty("file.separator");
		variables.templatePath = getCurrentTemplatePath();
    	variables.dir = getDirectoryFromPath(templatePath);
    	variables.path = replace(dir,"Config#variables.fileSeparator#","");    		
	}
	
	public struct function GetEnvironment()
	{
		var config = {};
		
		config.host.name = variables.machineName;
		config.host.hostAddress = variables.InetAddress.localhost.getHostAddress();
		config.host.port = CGI.serVER_PORT;
		config.path.root = "/";
		config.path.fileSeparator = variables.fileSeparator;
		config.path.pending = variables.path & "\documents_process\pending\";
		config.path.assemble = variables.path & "\documents_process\assemble\";
		config.path.approved = variables.path & "\documents_process\approved\";
		config.path.archive = variables.path & "\documents_process\archive\";
		config.path.print = variables.path & "\documents_process\print\";
		config.path.assets = variables.path & "\assets\";
		
		return config;		
	}
}