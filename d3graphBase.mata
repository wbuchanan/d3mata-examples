/*
Mata function to build out a standardized object to use as the basis for graphs.  
This uses Bostock's typical pattern, where the only modification is not 
explicitly creating variables to store the height, width, and margins objects.  
However, it should still provide the same effect and if the user wants to first 
generate height, width, and margins objects that is perfectly fine.  In that 
case, the margins object will need to have its elements passed to the function 
call individually.  
*/

// Start Mata session
mata:

// Class to construct the basis for a data visualization
class d3 scalar d3graphBase(transmorphic scalar bindobj, real scalar width,  ///   
							real scalar height, | transmorphic scalar lmarg, ///   
					  		transmorphic scalar rmarg, 						 ///    
							transmorphic scalar tmarg,						 ///   
					  		transmorphic scalar bmarg) {
	
	// Initializes object used to construct the return value
	class d3 scalar retval
	
	// Used to define the translation 
	string scalar left, top, translation
	
	// Check for left and right margins and if not present use 15% of the 
	// Total width.  Also, set the string value used in the translation
	if (missing(lmarg) == 1 & missing(rmarg) == 1) {
		lmarg = width * 0.075
		left = strofreal(lmarg)
		rmarg = width * 0.075	
	} else if (missing(lmarg) == 1 & missing(rmarg) == 0) {
		lmarg = rmarg
		left = strofreal(lmarg)
	} else if (missing(lmarg) == 0 & missing(rmarg) == 1) {
		rmarg = lmarg
		left = strofreal(lmarg)
	}
	
	// Repeat the process above, for the top and bottom margins
	if (missing(tmarg) == 1 & missing(bmarg) == 1) {
		tmarg = height * 0.075
		bmarg = height * 0.075
		top = strofreal(tmarg)
	} else if (missing(tmarg) == 1 & missing(bmarg) == 0) {
		tmarg = bmarg
		top = strofreal(tmarg)
	} else {
		bmarg = tmarg
		top = strofreal(tmarg)
	}
	
	// Construct the translation parameter string
	translation = `""translate(" + "' + left + `" + ", " + "' + top + `" + ")""'
	
	// Build the d3 object 
	retval.init("svg").select(bindobj).append("svg")
	retval.attr("width", width + lmarg + rmarg)
	retval.attr("height", height + tmarg + bmarg).append("g")
	retval.attr("transform", translation)
		  
	// Return the d3 class object to the user	  
	return(retval)
	
} // End of the function declaration						
			
// End of mata interpretation			
end

	
