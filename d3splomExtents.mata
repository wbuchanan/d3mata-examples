// Example functions used to create filters and extent objects in a d3 graph 
// Based on the bl.ock at http://bl.ocks.org/mbostock/4063663

// Begin mata session
mata:

// Declare function used to filter variables from d3 graphs						  
class d3 scalar excludeVars(string scalar varnm, | string scalar excludeVars, ///   
							string scalar vlname) {

	// Initializes object for return value
	class d3 scalar vars
	
	// Used to parse the varlist passed to the first parameter
	string rowvector toks
	
	// Variables used to store the function body and name of the variable list object
	string scalar filter, varlistName
	
	// Variable used for iterating in the for loop
	real i
	
	// If no variable list name object passed assume varnames
	if (vlname == "") vlname = "varnames"
	
	// Process excluded variables
	if (excludeVars != "") {
	
		// String used to build the filter conditions
		filter = "obj_function(d) { return "
		
		// Tokenizes the filter variable list argument
		toks = tokens(subinstr(excludeVars, ",", " "))

		// Loops over the variables passed
		for(i = 1; i <= cols(toks); i++) {
		
			// For all but the last iteration
			if (i != cols(toks)) {
			
				// Specify the filter condition 
				filter = filter + `"d !== ""' + toks[1, i] + `"" && "'
				
			} // End IF Block for non-ending iterations
			
			// For the last iteration
			else {
			
				// On the last iteration add the closing semicolon and curly brace 
				// used when defining the call back
				filter = filter + `"d !== ""' + toks[1, i] + `""; }"'
				
			} // End ELSE Block for final iteration
			
		} // End Loop over the variables to exclude
		
		// Create the d3 class object with the appropriate filter method called on it
		vars.init().jsfree(varnm + " = " + vlname).filter(filter)
	
	} // End IF Block for varlist to exclude	

	// If no variables are being excluded
	else {
	
		// Create the d3 class object with the appropriate filter method called on it
		vars.init().jsfree(varnm + " = " + vlname)
	
	} // End ELSE Block for case without excluded variables
	
	// Return the object
	return(vars)
	
} // End of function declaration

// Function to create the extents and filtered 
class d3 scalar varExtents(string scalar extObj, string scalar traitnm) {
	
	// Declares object used to contain the return value
	class d3 scalar traits
	
	// Used to organize the lines of the function body
	string colvector funcbody
	
	// Defines the lines of the callback body
	funcbody = ("obj_function(theVariable) {" + traits.nlindent \
				extObj + "[theVariable] = d3.extent(data, function(d) { return d[theVariable]; });" + traits.nl \
				"}")

	// Initializes the extent container object
	traits.init().jsfree(extObj + " = {}; " + traits.dblnl)

	// Adds the method to populate the extent object with the extents of each variable
	traits.jsfree(traitnm).forEach(funcbody[1, 1] + funcbody[2, 1] + funcbody[3, 1])

	// Returns the object
	return(traits)

} // End of function declaration


// Defines convenience function that calls the varExtents and excludeVars functions
class d3 scalar splomVars(string scalar traitnm, string scalar extObj, |	 /// 
						  string scalar excludeVars, string scalar vlname) {
	
	// Declares variables used to store intermediate and returned results
	class d3 scalar exclusion, extents, retval
	
	// Declares variable used to check the name of the variable list
	string scalar varlistName, body
	
	// If no name supplied use varnames
	if (vlname == "") vlname = "varnames"

	// Gets the variable exclusion object
	exclusion = excludeVars(traitnm, excludeVars, vlname)

	// Gets the extents object using the excluded variable list
	extents = varExtents(extObj, traitnm)
	
	body = retval.printer(exclusion) + retval.dblnl + retval.printer(extents)
	
	// Puts the results of both objects in the object to be returned
	retval.init().jsfree(body)
	
	// Return the object containing the combined objects without the terminating
	// semicolon after the second object
	return(retval)
						  
} // End function declaration
						  

// End of method declarations
end

