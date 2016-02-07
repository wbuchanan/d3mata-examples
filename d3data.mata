// Start Mata session
mata:

// Declares function to load data and expose the data, variable names, variable 
// labels, and value labels 
class d3 scalar d3data( string scalar filenm, class d3 scalar callback, |	 ///   
						string scalar datanm, string scalar vallabs, 		 ///   
						string scalar varlabs, string scalar stvarnames,	 ///   
						string scalar jsvarnm) {

	// Check the file name passed to the function					
	if (pathsuffix(filenm) != ".json" & pathsuffix(filenm) != "") {
	
		// If not a json file throw an exception
		_error(3602, "Must reference a file created by the jsonio package.")
		
	} // End IF Block for filename specification check
	
	// Declares member variables used in the function					
	class d3 scalar json, datavars, retval
	
	string colvector lines
	
	if (jsvarnm == "") jsvarnm = "d3MataGraph"
	
	// If value label argument not passed, the value labels will be accessible 
	// under the variable named valueLabels
	if (vallabs == "") vallabs = "valueLabels"
	
	// If variable label argument not passed, the variable labels will be 
	// accessible under the variable named varlabels
	if (varlabs == "") varlabs = "varlabels"
	
	// If variable names argument not passed, the variable names will be 
	// accessible under the variable named varnames
	if (stvarnames == "") stvarnames = "varnames"
	
	// If user does not specify name for JS data object use the name data
	if (datanm == "") datanm = "data"
	
	// Creates a d3 object used to make the data, value labels, variable labels, 
	// and variable names accessible outside of the callback that loads the data
	datavars.init().jsfree("var " + datanm + ", " + vallabs + ", " + varlabs + ", " + stvarnames)
	
	datavars.complete()
	
	lines = ("if (error) return console.warn(error);" + json.nlindent \
				datanm + " = json.data," + json.nlindent \
				vallabs + `" = json.valueLabels,"' + json.nlindent \
				varlabs + `" = json.variableLabels,"' + json.nlindent \
				stvarnames + `" = json.variableNames;"' + json.nlindent \
				callback.complete())
				
	// Start constructing the function
	json.init(jsvarnm).json(filenm, lines[1, 1] + lines[2, 1] + lines[3, 1] +  ///   
								  lines[4, 1] + lines[5, 1] + lines[6, 1])
			
	// Constructs the return value object to be passed back 		
	retval.init().jsfree(datavars.complete() + retval.dblnl + json.complete())
	
	// Return the d3 object containing the data callback function
	return(retval)
			
} // End Method declaration

// Ends mata session
end

						
