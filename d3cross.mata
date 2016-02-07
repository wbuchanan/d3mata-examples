// Function based on function of same name defined at:
// http://bl.ocks.org/mbostock/4063663

// Starts mata session
mata:

// Defines function that returns the JS function of the same name referenced above
class d3 scalar d3cross(|string scalar a, string scalar b) {

	// Creates d3 object returned by function
	class d3 scalar retval

	// String scalars used to test for optional arguments
	string scalar x, y

	// Column vector of strings used to define the function body
	string colvector lines

	// If no value passed to the a parameter use the letter a
	if (a == "") x = "a"

	// Else use the user specified value	
	else x = a

	// If no value passed to the b parameter use the letter b	
	if (b == "") y = "b"

	// Else use the user specified value	
	else y = b	

	// Lines of the function body
	lines = ("function cross(" + x + ", " + y + ") {" + retval.nlindent \
	"var c = [], n = " + x + ".length, m = " + y + ".length, i, j;" + retval.nlindent \
	"for (i = -1; ++i < n;) for (j = -1; ++j < m;) c.push({x: " + x + "[i], i: i, y: " + y + "[j], j: j});" + retval.nlindent \
	"return c;" + retval.nl + "}")

	// Initializes the d3 object and populates it with the function body
	retval.init().jsfree(lines[1, 1] + lines[2, 1] + lines[3, 1] + lines[4, 1])

	// Return the d3 object
	return(retval)

} // End of Function definition

// End of Mata session
end
