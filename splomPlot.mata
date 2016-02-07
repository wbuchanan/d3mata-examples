// Example functions used to create filters and extent objects in a d3 graph 
// Based on the bl.ock at http://bl.ocks.org/mbostock/4063663

// Begin mata session/interpreter
mata:

/* 
Requires that Java script variables for "size" and "padding" already exist 
elsewhere in the definition of the graph
To apply colors based on the values of another variable in the data set you 
can pass something like:

"obj_function(d) { return color(d.rep78); }"

This, of course, assumes that there is a JS variable named color in the scope 
of the graph already. The table below describes the default values for each of 
the function's parameters:

Parameter 		Default Value
pname			"p"
extObj			"domainByTrait"
dataObj			"data"
sizeObj			"size"
paddingObj		"padding"
color 			"steelblue"
textSize		25
d3label			"obj_function(d) { return varlabels[p.x]; }"
*/
class d3 scalar splomPlot(string scalar varnm, | string scalar pname, 		 ///   
						  string scalar extObj, string scalar dataObj, 		 ///   
						  string scalar sizeObj, string scalar paddingObj, 	 ///   
						  string scalar color, real scalar textSize, 		 ///   
						  string scalar d3label) {

	// Declares d3 objects used by the function internally and the return object
	class d3 scalar r, rect, text, circle
	
	// Defines a column vector of strings used to organize the body of the object
	string colvector lines
	
	// Used to declare string value for the text size in pixels
	string scalar textsize
	
	// Sets default value if no argument is passed to each of the function parameters
	if (pname == "") pname = "p"
	if (extObj == "") extObj = "domainByTrait"
	if (dataObj == "") dataObj = "data"
	if (sizeObj == "") sizeObj = "size"
	if (paddingObj == "") paddingObj = "padding"
	if (color == "") color = "steelblue"
	if (missing(textSize) == 1) textsize = "25px"
	else textsize = strofreal(textSize) + "px"
	if (d3label == "") d3label = "obj_function(d) { return varlabels[p.x]; }"
	
	// Initializes the rectangle object from the cell object defined in the 
	// second line of the lines object below
	rect.init().jsfree("cell").append("rect").attr("class", "frame")
	rect.attr("x", "obj_" + paddingObj).attr("y", "obj_" + paddingObj)
	rect.attr("width", "obj_dims").attr("height", "obj_dims")

	// Initialize object used to append text to the diagonal elements
	text.init().jsfree("cell").append("text")
	text.filter("obj_function() { return p.i === p.j; }")
	text.attr("dx", "obj_dims / 2").attr("dy", "obj_dims / 2")
	text.style("font-size", textsize)
	text.style("writing-mode", "rl-tb").style("text-align", "left").text(d3label)

	// Appends the points to each of the graphs and implements pairwise deletion
	// to avoid any possible not a number exceptions
	circle.init().jsfree("cell").selectAll("circle").data("obj_" + dataObj)	
	circle.enter().append("circle")	
	circle.filter("obj_function(d) { return !isNaN(x(d[p.x])) && !isNaN(y(d[p.y])); }")	
	circle.attr("cx", "obj_function(d) { return x(d[p.x]); }")	
	circle.attr("cy", "obj_function(d) { return y(d[p.y]); }")	
	circle.attr("r", "obj_function(d) { return 4 * (1 - (1 / " + varnm + ".length)); }")	
	circle.style("fill", color)

	// Stores the lines to be written into the return object
	lines = ("function plot(" + pname + ") {" + r.nlindent \
			 "var cell = d3.select(this);" + r.nlindent \ 
			 "x.domain(" + extObj + "[p.x]);" + r.nlindent \
			 "y.domain(" + extObj + "[p.y]);" + r.nlindent \
			 "var dims = " + sizeObj + " - " + paddingObj + " * 2;" + r.nlindent \ 
			 r.printer(rect) + r.nlindent \
			 r.printer(text) + r.nlindent \
			 r.printer(circle) + r.nl \ 
			 "}" + r.dblnl)
	
	// Initializes the return object and passes all of the code/objects to it
	r.init().jsfree(lines[1, 1] + lines[2, 1] + lines[3, 1] + lines[4, 1] +
					lines[5, 1] + lines[6, 1] + lines[7, 1] + lines[8, 1] + 
					lines[9, 1])	
	
	// Returns the return object
	return(r)

  } // End of the function declaration
  
  // End of the mata session
  end
  
  
