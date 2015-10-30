component 
{
	this.name = "BecomeBroker";
	this.root = getDirectoryFromPath( getCurrentTemplatePath() );
	this.mappings = {};
	this.mappings["/pending"] = this.root & "document_process/pending/";
}