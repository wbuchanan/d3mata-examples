// Start mata interpreter/compiler
mata: 

// Defines a function to create axis titles
class d3 scalar d3axes(	string scalar varnm, string scalar axis, string scalar position) {
	
	class d3 scalar axisFunction, retval
	class script scalar axisScript
	
	axisScript.setClassArgs("axes.js")
	axisFunction.init().jsfree("axes(" + axis + ", " + varnm + ", " + position + ")") 
	retval.init().jsfree(axisScript.print() + char((10, 10)) + axisFunction.complete())
	return(retval)
}
	
end
