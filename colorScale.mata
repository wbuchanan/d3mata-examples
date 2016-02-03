// Starts mata interpreter
mata:

/* Defines function to return a color scale.
If no value is passed to the varnm argument the function will return the 
color scale in the JS variable named color.  If no d3 color scale is passed 
the category10() color scale will be assumed.  */
class d3 scalar colorScale(| string scalar arg, string scalar varnm) {

	// Stores the return value object
	class d3 scalar retval
	
	// If no varnm is passed use color
	if (varnm == "") varnm = "color"
	
	// Test the first parameter and construct the appropriate color scale based 
	// on the argument passed to the function
	if (arg == "category10") retval.init(varnm).scale().category10()
	else if (arg == "category20") retval.init(varnm).scale().category20()
	else if (arg == "category20b") retval.init(varnm).scale().category20b()
	else if (arg == "category20c") retval.init(varnm).scale().category20c()
	else if (arg == "ordinal") retval.init(varnm).scale().ordinal()
	else if (arg == "interpolate") retval.init(varnm).scale().linear().interpolate()
	// If no arugment is passed, use category10 as the default
	else retval.init(varnm).scale().category10()
	
	// Return the d3 object 
	return(retval)
	
} // End of the function definition

// End the mata session
end

