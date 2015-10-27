component accessors="true" output="false"
{
	property string text;
	property boolean isApplication;
	property string fileName;
	property string type; 
	
	function init(){
		this.setText('welcome');
    	this.setFileName('cfwf');
    	this.setType('');
    	this.setIsApplication(true);
	}
}