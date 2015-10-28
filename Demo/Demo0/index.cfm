<cfif isdefined("form.submit")>
	
<cfhtmltopdf destination="usage_example2.pdf"
  source="#form.inputURL#" overwrite="true"  
  orientation="landscape" />
 
<cfcontent file="#getdirectoryfrompath(getbasetemplatepath())#usage_example2.pdf" type="application/pdf" >
<cfelse>
<form method="post" >
  <div class="form-group">
    <label for="inputURL">URL</label>
    <input type="URL" class="form-control" id="inputURL" name="inputURL" placeholder="URL">
  </div>
  
  <button type="submit" name="submit" class="btn btn-default">Get PDF</button>
</form>
</cfif>
