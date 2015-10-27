component accessors="true" output="false"
{
	property type="string" name="text";
	property type="boolean" name="isApplication";
	property type="string" name="fileName";
	property type="string" name="type"; 
	
	function init(){
		this.setText('');
    	this.setFileName('Demo');
    	this.setType('');
    	this.setIsApplication(true);
	}
}