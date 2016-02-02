// Example functions to construct a linked brush for a scatter plot matrix.  
// Based on the bl.ock at http://bl.ocks.org/mbostock/4063663

// Start Mata session
mata:

// Constructs the dispacting variable
class d3 scalar xyBrushDispatcher(| string scalar graphObj) {

	// Declares a member to construct the d3 object
	class d3 scalar brush
	
	// If no arguments passed assume the graph is defined as d3.svg...
	if (args() == 0) {
	
		// Creates the d3 object with the necessary callbacks to the brush functions
		brush.init("brush").svg()

	} // End IF Block for no argument case
	
	// If user passes a value use that as the basis for constructing the brush variable
	else {
	
		// Initialize the object with a different name
		brush.init().jsfree("var brush = " + graphObj)
	
	} // End else block for user specified graph object name

	// Adds the callback listeners
	brush.brush().x("obj_x").y("obj_y").on("brushstart", "obj_brushstart").on("brush", "obj_brushmove").on("brushend", "obj_brushend")
	
	// Returns the object
	return(brush)

} // End function declaration	

// Defines a function that will return all three of the brush functions from 
// the example referenced above
class d3 rowvector xyBrushFunctions(string scalar extentObject, 			 ///   
									string scalar argname, |				 ///   
									string scalar varname, 					 ///   
									string scalar graphObject) {

	// Declares variables used to store the functions that will be returned
	class d3 scalar brush, brushStart, brushMove, brushEnd
	
	// Declares variables that will be used to test/populate optional arguments
	string scalar varnm, graphobj
	
	// If no varname is passed, the var declared in the JS will be brushCell
	if (varname == "") varnm = "brushCell"
	
	// Or it will be assigned the name passed by the user
	else varnm = varname	
	
	// If no graphObject argument is passed we assume there is a JS var named 
	// svg on which the brush will select observations
	if (graphObject == "") graphobj = "svg"
	
	// Otherwise, use the name passed by the end user
	else graphobj = graphObject
	
	// Call the xyBrushStart function
	brushStart = xyBrushStart(extentObject, argname, varnm)

	// Call the xyBrushMove function
	brushMove = xyBrushMove(argname, graphobj)

	// Call the xyBrushEnd function
	brushEnd = xyBrushEnd(graphobj)

	// Return a rowvector with all three of the brush functions
	return((brushStart, brushMove, brushEnd))

} // End declaration of Mata function

// Defines Mata function that constructs the js var and function to start the 
// brush action
class d3 scalar xyBrushStart(string scalar extentObject, 					 ///   
							 string scalar argname, 						 ///   
							 string scalar varname) {

	// Declares d3 objects used by the function						 
	class d3 scalar retval, s
	
	// Declares a column vector of strings used to store the lines of the 	 
	// function body
	string colvector lines
	
	// Initialize object and populate some of the fields
	s.init().jsfree("d3").select("obj_" + varname).call("obj_brush.clear()")

	// Create the lines of the function body
	lines = ("var " + varname + ";" + s.dblnl \
			 "function brushstart(" + argname + ") {" + s.nlindent \
			 "if (" + varname + " !== this) {" + s.nlindent + "  " \
			 s.complete() + s.nlindent  + "  " \ 
			 "x.domain(" + extentObject + "[p.x]);" + s.nlindent  + "  " \
			 "y.domain(" + extentObject + "[p.y]);" + s.nlindent  + "  " \
			 varname + " = this;" + s.nlindent + "}" + s.nl + "}")

	// Initializes the return value object and populate it with the lines of 
	// the function body
	retval.init().jsfree(lines[1, 1] + lines[2, 1] + lines[3, 1] + 			 ///   
						 lines[4, 1] + lines[5, 1] + lines[6, 1] + lines[7, 1])

	// Returns the d3 object
	return (retval)
	
} // End of function declaration

// Defines function for handling the brush selection
class d3 scalar xyBrushMove(string scalar argname, string scalar graphObject) {

	// Variable used to create and return the value returned by the function
	class d3 scalar retval
	
	// Creates a column vector of strings used to define the lines of the 
	// JS function body
	string colvector lines
	
	// Populates the lines
	lines = ("function brushmove(" + argname + ") {" + retval.nlindent \
			 "var e = brush.extent();" + retval.nlindent \ 
			 graphObject + `".selectAll("circle").classed("hidden", function(d) {"' + retval.nlindent + "  " \
			 "return e[0][0] > d[p.x] || d[p.x] > e[1][0] || e[0][1] > d[p.y] || d[p.y] > e[1][1];" + retval.nlindent \
			 "});" + retval.nl \
			 "}")
	
	// Initializes the return value and populates it with the lines of the 
	// function body
	retval.init().jsfree(lines[1, 1] + lines[2, 1] + lines[3, 1] + 			 ///   
						 lines[4, 1] + lines[5, 1] + lines[6, 1])

	// Returns the object
	return(retval)
	
} // End of the function declaration
	
// Define function that returns a JS function to clear the brush
class d3 scalar xyBrushEnd(string scalar graphObject) {

	// variable used to store return value
	class d3 scalar retval

	// String variable used to call the .selectAll method on the appropriate object
	string scalar d3obj

	// If no argument is passed assume svg is the object to call .selectAll on
	if (args() == 0) d3obj = "svg"

	// Otherwise, use the string passed to the function
	else d3obj = graphObject	

	// Populate the object
	retval.init().jsfree("function brushend() {" + retval.nlindent +
		`"if (brush.empty()) "' + d3obj + `".selectAll(".hidden").classed("hidden", false);"' +
		retval.nl + `"}"')

	// Return the object
	return(retval)

} // End definition of brushend function

// Ends Mata session
end



