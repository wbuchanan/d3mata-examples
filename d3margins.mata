// Start mata interpreter/compiler
mata: 

// Defines a Mata function that returns a D3 object containing the margins, 
// height, and width of the svg element in the dom
class d3 scalar d3margins(string scalar varnm, | real scalar height, 
real scalar width, real scalar top, real scalar bottom, real scalar left, 
real scalar right) {
	
	// Declares variable that will be returned
	class d3 scalar marg
	
	// Declares members used if optional args are not passed
	string scalar h, w, t, b, l, r
	
	// If no height parameter is supplied use 600
	if (missing(height) == 1) h = "600"
	else h = strofreal(height)
	
	// If no width parameter is supplied use 960
	if (missing(width) == 1) w = "960"
	else w = strofreal(width)
	
	// If no top parameter is supplied top margin will be set to 20
	if (missing(top) == 1) t = "20"
	else t = strofreal(top)
	
	// If no bottom parameter is supplied bottom margin will be set to 20
	if (missing(bottom) == 1) b = "20"
	else b = strofreal(bottom)
	
	// If no right parameter is supplied right margin will be set to 20
	if (missing(right) == 1) r = "20"
	else r = strofreal(right)
	
	// If no left parameter is supplied left margin will be set to 20
	if (missing(left) == 1) l = "20"
	else l = strofreal(left)
	
	// Create the margins object that will be used to provide the margins and 
	// size of the svg element in the dom
	marg.init().jsfree("var " + varnm + " = {top: " + t + ", bottom: " + b +
				", right: " + r + ", left: " + l + "}," + marg.nlindent + 
				"height = " + h + " - " + varnm + ".bottom - " + varnm + 
				".top," + marg.nlindent + "width = " + w + " - " + varnm + 
				".left - " + varnm + ".right")
	
	// Return the d3 object to the user
	return(marg);
						
} // End of method definition		

// Exit Mata mode
end

