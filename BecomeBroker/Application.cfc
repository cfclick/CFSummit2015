component 
{
	this.name = "BecomeBroker";
	this.root = getDirectoryFromPath( getCurrentTemplatePath() );
	this.mappings = {};
	this.mappings["/BecomeBroker"] = this.root;
	this.mappings["/pending"] = this.root & "documents_process/pending/";
}