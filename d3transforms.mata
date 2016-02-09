// Defines convenience methods that can be used to return formatted transformation
// strings.  These all assume a static string will fulfill the requirements
mata:

// Method used to return a formatted translate string
string scalar d3translate(transmorphic scalar tx, | transmorphic scalar ty) {

	// Initializes a d3 class object
	class d3 scalar x
	
	// Sets the ty parameter to the default if missing
	if (missing(ty) == 1) ty = 0
	
	// Processes the arguments and returns the formatted string.
	return("translate(" + x.checkValue(tx) + ", " + x.checkValue(ty) + ")")
	
} // End of Function Declaration

// Method used to return a formatted rotate string
string scalar d3rotate(	transmorphic scalar angle, | transmorphic scalar cx, ///   
						transmorphic scalar cy) {

	// Initializes a d3 class object
	class d3 scalar x
	
	// Sets the cx parameter to default value if missing
	if (missing(cx) == 1) cx = 0
	
	// Sets the cy parameter to the default value if it was missing
	if (missing(cy) == 1) cy = 0 
	
	// Processes the arguments and returns the formatted string.
	return("rotate(" + x.checkValue(angle) + ", " + x.checkValue(cx) + ", " + x.checkValue(cy) + ")")

} // End of Function Declaration

// Method used to return a formatted scale string
string scalar d3scale(transmorphic scalar sx, | transmorphic sy) {

	// Initializes a d3 class object
	class d3 scalar x
	
	// Sets the ty parameter to the default if missing
	if (missing(sy) == 1) sy = sx
	
	// Sets the ty parameter to the default if missing
	return("scale(" + x.checkValue(sx) + ", " + x.checkValue(sy) + ")")
	
} // End of Function Declaration

// Ends mata session
end

	
