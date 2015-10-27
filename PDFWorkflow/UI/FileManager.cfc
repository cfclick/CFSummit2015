component  output="false"
{
	remote void function Reject(any fileInfo){
		try{
			writelog( text=fileInfo, file="PDFWorkflowDirWatcher"  );
			var f = deserializeJSON(fileInfo);
			fileMove(f.SOURCE,f.REJECT);
		}catch(any e){
			writelog( text=e.message, file="PDFWorkflowDirWatcher"  )
			
		}
		
	}
}