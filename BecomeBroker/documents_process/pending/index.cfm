<a href="http://localhost:8500/TestProjects/PDFStuff/clearall.cfm">[Clear All]</a><br>
<cfdirectory 
action="list" 
directory="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/pending/toAssemble" 
name="pendingList"
filter="*.pdf">


<cfoutput>
		<ul>
			<cfloop query="pendingList">
			<li><a href="http://localhost:8500/TestProjects/PDFStuff/Assemble.cfm?agencyName=#Name#">Assemble - #Name#</a> - [<a href="http://localhost:8500/TestProjects/PDFStuff/pending/toAssemble/#Name#" target="_blank" >View PDF</a>] - #DateTimeFormat(DateLastModified,'mm/dd/yyyy hh:mm tt')#</li>
			</cfloop>
		</ul>
	
</cfoutput>

<cfdirectory 
action="list" 
directory="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/approved/byManager/tosign" 
name="AssembledList"
filter="*.pdf">

<cfoutput>
		<ul>
			<cfloop query="AssembledList">
				<li><a href="http://localhost:8500/TestProjects/PDFStuff/Manager_Sign.cfm?agencyName=#Name#">Manager Sign - #Name#</a> 
					<a href="http://localhost:8500/TestProjects/PDFStuff/Manager_Sign.cfm?agencyName=#Name#&valid=true">Manager Valid Signature - #Name#</a>
					- [<a href="http://localhost:8500/TestProjects/PDFStuff/approved/byManager/tosign/#Name#" target="_blank" >View PDF</a>] - #DateTimeFormat(DateLastModified,'mm/dd/yyyy hh:mm tt')#</li>
			</cfloop>
		</ul>
	
</cfoutput>

<cfdirectory 
action="list" 
directory="C:/ColdFusion11/cfusion/wwwroot/TestProjects/PDFStuff/Approved/byManager/completed" 
name="ApprovedList"
filter="*.pdf">

<cfoutput>
		<ul>
			<cfloop query="ApprovedList">
			<li><a href="http://localhost:8500/TestProjects/PDFStuff/VP_Sign.cfm?agencyName=#Name#">VP Sign - #Name#</a> 
				<a href="http://localhost:8500/TestProjects/PDFStuff/VP_Sign.cfm?agencyName=#Name#&valid=true">VP Valid Signature - #Name#</a>
				- [<a href="http://localhost:8500/TestProjects/PDFStuff/approved/byManager/completed/#Name#" target="_blank" >View PDF</a>] - #DateTimeFormat(DateLastModified,'mm/dd/yyyy hh:mm tt')#</li>
			</cfloop>
		</ul>
	
</cfoutput>