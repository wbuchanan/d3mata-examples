cap prog drop d3splom

prog def d3splom 

	version 13.1

	// Defines the ado syntax for generating the variables
	syntax  [using/] , OUTput(string) FILEnm(string) VLName(string) ///   
	[ Width(integer 960) TSize(integer 20) SCale(integer -1) ///   
	OMit(string asis) DIAGlabel(string asis) PALette(string asis) ///   
	COLors(string asis) STYLEsheet(string asis) ]

	if substr(`"`output'"', 1, 1) == "~" {
		loc output `"`: subinstr loc output `"~"' `"`: environment HOME'"''"'
	}
	
	// Check for ending path delimiter
	if inlist(substr(`"`output'"', -1, 1), "/", "\") {
		
		// Remove the last path delimiter if there is no file/directory after it
		loc output `"`: di substr(`"`output'"', 1, length(`"`output'"') - 1)'"'
		
	} // End IF Block for cleaning output parameter
	
	// Check scale argument
	if `scale' == -1 loc scale 
	
	// Preserve current state of data
	cap: preserve
			
		// Writes the json data to the output name
		if `"`using'"' != "" jsonio using `using' `if' `in', w(all) file(`output'/`filenm')
		
		else jsonio `if' `in', w(all) file(`output'/`filenm')
		
		// Initializes an HTML Link object
		mata: link = link()

		// If the user specifies a cascading style sheet
		if (`"`stylesheet'"' != "") {
		
			// Add the appropriate elements to the object
			mata: link.rel("stylesheet").type("text/css").href("`stylesheet'")

		} // End IF Block for stylesheet
		
		// Create the splom object
		mata: splom = d3splom("`filenm'", "`vlname'", `width', `tsize',   	 ///   
		`scale', "`omit'", "traits", "domainByTrait", "svg", "p", 			 ///   
		"`diaglabel'", "brushCell", "padding", "`palette'", "`colors'")

		// Creates the HTML doc object
		mata: doc = doctype()
		
		// Sets the document type to html
		mata: doc.setDocType("html")
		
		// Creates the HTML meta object
		mata: meta = meta()
		
		// Sets the character set to UTF-8
		mata: meta.charset("utf-8")
		
		// Creates a script object to reference the d3js library		
		mata: d3ref = script()
		
		// Adds the source reference to the script object
		mata: d3ref.src("http://www.d3js.org/d3.v3.min.js")

		// Creates an HTML head object
		mata: head = head()
		
		// Prints the link and script objects inside of the head
		mata: head.setClassArgs(link.print() + splom.nl + d3ref.print())
		
		// Creates a new script object for the graph code
		mata: d3graph = script()
		
		// Adds the JavaScript to the script object
		mata: d3graph.setClassArgs(splom.getter())
		
		// Creates an HTML body object
		mata: body = body()
		
		// Adds the graph code in the body of the HTML document
		mata: body.setClassArgs(d3graph.print())
		
		// Adds the meta, head, and body elements to the document type object
		mata: doc.setClassArgs(meta.print() + splom.nl + head.print() + 	 ///   
		splom.nl + body.print())
		
		// Opens a new file for writing the HTML output
		mata: fh = fopen("`output'/index.html", "w")
		
		// Writes the HTML code
		mata: fwrite(doc.print(), fh)
		
		// Closes the file for writing
		mata: fclose(fh)
		
	// Restores data back to original state
	cap: restore
	
// Ends the definition of the program
end

	
