// Start Mata session
qui: mata:

// Declares function to load data and expose the data, variable names, variable 
// labels, and value labels 
class d3 scalar d3data( string scalar filenm, string scalar varnm, 			 ///   
						string scalar callback, | string scalar datanm, 	 ///   
						string scalar vallabs, string scalar varlabs, 	 	 ///   
						string scalar stvarnames) {

	// Check the file name passed to the function					
	if (pathsuffix(filenm) != ".json" & pathsuffix(filenm) != "") {
	
		// If not a json file throw an exception
		_error(3602, "Must reference a file created by the jsonio package.")
		
	} // End IF Block for filename specification check
	
	// Declares member variables used in the function					
	class d3 scalar json, datavars
	
	// Declares string members used when validating arguments and constructing 
	// the string used to construct the the d3 object
	string scalar vall, varl, varnames, data
	
	// Initializes the d3 object used to expose data objects outside of the callback
	datavars = d3()
	
	// Initializes the d3 object used to read the data
	json = d3()
	
	// If value label argument not passed, the value labels will be accessible 
	// under the variable named valueLabels
	if (vallabs == "") vall = "valueLabels"
	
	// Else accessible with the argument passed to the vallabs parameter
	else vall = vallabs
	
	// If variable label argument not passed, the variable labels will be 
	// accessible under the variable named varlabels
	if (varlabs == "") varl = "varlabels"
	
	// Else accessible with the argument passed to the varlabs parameter
	else varl = varlabs
	
	// If variable names argument not passed, the variable names will be 
	// accessible under the variable named varnames
	if (stvarnames == "") varnames = "varnames"
	
	// Else, variable names accessible under the name passed to the stvarnames 
	// parameter
	else varnames = stvarnames
	
	// If user does not specify name for JS data object use the name data
	if (datanm == "") data = "data"
	
	// Else, data accessible under the variable named by the datanm parameter
	else data = datanm
	
	// Creates a d3 object used to make the data, value labels, variable labels, 
	// and variable names accessible outside of the callback that loads the data
	datavars.init().jsfree("var " + data + ", " + vall + ", " + varl + ", " + varnames)
	
	// Start constructing the function
	json.init().jsfree(datavars.complete() + char((10, 10)) +
		"var " + varnm + " = d3.json(" + filenm + 
			", function(error, json) {" + json.nlindent + 
			"if (error) return console.warn(error);" + json.nlindent + 
			data + " = json.data," + json.nlindent + 
			vall + `" = json.valueLabels,"' + json.nlindent + 
			varl + `" = json.variableLabels,"' + json.nlindent + 
			varnames + `" = json.variableNames;"' + char((10)) + "})" + 
			char((10, 10)) + callback)
			
	// Return the d3 object containing the data callback function
	return(json)
			
} // End Method declaration

// Ends mata session
end

						
