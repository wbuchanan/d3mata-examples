cap prog drop d3splom

prog def d3splom 

	version 13.1

	// Defines the ado syntax for generating the variables
	syntax  [using/] , OUTput(string) FILEnm(string) VLName(string)			 ///   
	[ Width(integer 960) TSize(integer 20) SCale(integer 5)  OMit(string) 	 ///   
	DIAGlabel(string) PALette(string) COLors(string) STYLEsheet(string) ]

	// Initializes an HTML Link object
	mata: style = style()

	if substr(`"`output'"', 1, 1) == "~" {
		loc output `"`: subinstr loc output `"~"' `"`: environment HOME'"''"'
	}
	
	// Check for ending path delimiter
	if inlist(substr(`"`output'"', -1, 1), "/", "\") {
		
		// Remove the last path delimiter if there is no file/directory after it
		loc output `"`: di substr(`"`output'"', 1, length(`"`output'"') - 1)'"'
		
	} // End IF Block for cleaning output parameter
	
	// Preserve current state of data
	cap: preserve
			
		// Writes the json data to the output name
		if `"`using'"' != "" jsonio using `"`using'"' `if' `in', w(all) file(`output'/`filenm')
		
		else jsonio `if' `in', w(all) file(`output'/`filenm')
		
		// If the user specifies a cascading style sheet
		if (`"`stylesheet'"' != "") {
		
			// Add the appropriate elements to the object
			mata: style.setClassArgs("`stylesheet'")

		} // End IF Block for stylesheet
		
		// Create the splom object
		mata: splom = d3splom("`filenm'", "`vlname'", `width', `tsize',   	 ///   
		`scale', "`omit'", "traits", "domainByTrait", "svg", "p", 			 ///   
		"`diaglabel'", "brushCell", "", "`colors'", "`palette'")

		// Creates the HTML doc object
		mata: doc = doctype()
		
		// Sets the document type to html
		mata: doc.setDocType("html")
		
		// Creates the HTML meta object
		mata: meta = meta()
		
		// Sets the character set to UTF-8
		mata: meta.setCharset("utf-8")
		
		// Creates a script object to reference the d3js library		
		mata: d3ref = script()
		
		// Adds the source reference to the script object
		mata: d3ref.setSrc("//d3js.org/d3.v3.min.js").setCharset("utf-8")

		// Creates an HTML head object
		mata: head = head()
		
		// Prints the link and script objects inside of the head
		mata: head.setClassArgs(style.print() + splom.nl + d3ref.print())
		
		// Creates a new script object for the graph code
		mata: d3graph = script()
		
		// Adds the JavaScript to the script object
		mata: d3graph.setClassArgs(char((10)) + splom.getter() + char((10)))
		
		// Creates an HTML body object
		mata: body = body()
		
		// Adds the graph code in the body of the HTML document
		mata: body.setClassArgs(d3graph.print())
		
		// Adds the meta, head, and body elements to the document type object
		mata: doc.setClassArgs(meta.print() + splom.nl + head.print() + 	 ///   
		splom.nl + body.print())
		
		cap: erase "`output'/index.html"
		
		// Opens a new file for writing the HTML output
		mata: fh = fopen("`output'/index.html", "w")
		
		// Writes the HTML code
		mata: fwrite(fh, doc.print())
		
		// Closes the file for writing
		mata: fclose(fh)
		
	// Restores data back to original state
	cap: restore
	
// Ends the definition of the program
end

	
