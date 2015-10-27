component accessors="true" output="false"
{
	property type="string" name="text";
	property type="boolean" name="isApplication";
	property type="string" name="fileName";
	property type="string" name="type"; 
	
	function init(){
		this.setText('this is test');
    	this.setFileName('cfwf2');
    	this.setType('Test');
    	this.setIsApplication(true);
	}
}