mata:


class d3 scalar d3splom(string scalar filename, string scalar vlname, |		 ///   
						real scalar width, real scalar textSize, 			 ///   
						real scalar scaleFactor, string scalar excludeVars,  ///   
						string scalar traitnm, string scalar extObj, 		 ///   
						string scalar graphObj, string scalar brushArgName,  ///   
						string scalar d3label, string scalar brushVarName, 	 ///   
						string scalar padding, string scalar colorAssign, 	 ///   
						string scalar colorScale) {
								
	class d3 scalar varExtent, cross, x, y, xAxis, yAxis, brush, color, svg, 
		frame, clsxaxis, clsyaxis, cell, cellfilter, cellcall, splom, gob, retob
	class d3 rowvector brushFunctions
	string scalar textsize, grwidth, scale, tref, body
	string colvector cb
	real scalar i
	if (graphObj == "") graphObj = "svg"
	if (colorAssign == "") colorAssign = "steelblue"
	if (brushVarName == "") brushVarName = "brushCell"
	if (brushArgName == "") brushArgName = "p"
	if (extObj == "") extObj = "domainByTrait"
	if (missing(textSize) == 1) {
		textsize = "20px"
		textSize = 20
	}	
	else {
		textsize = strofreal(textSize) + "px"
	}
	if (missing(width) == 1) grwidth = "960"
	else grwidth = "obj_" + strofreal(width) 
	if (padding == "") padding = "Math.round(10 + Math.log(100 * Math.pow(" + traitnm + ".length, 2)));"

	if (missing(scaleFactor) == 1) scale = "scaleFactor = " + traitnm + ".length;"
	else scale = "scaleFactor = " + strofreal(scaleFactor) + ";"

	tref = traitnm + ".length"
	varExtent = splomVars(traitnm, excludeVars, extObj, vlname)
	if (colorScale == "") color = colorScale()
	else color = colorScale(colorScale)


	// Defines teh scale used by the x axis			
	x.init("x").scale().linear().range("obj_[padding, size - padding / 2]")

	// Defines the scale used by the y axis
	y.init("y").scale().linear().range("obj_[size - padding / 2, padding]")

	// Defines the x axis properties
	xAxis.init("xAxis").svg().axis().scale("obj_x").orient("bottom")
	xAxis.tickSize("obj_size * " + tref)

	// Defines the y axis properties 
	yAxis.init("yAxis").svg().axis().scale("obj_y").orient("left")
	yAxis.tickSize("obj_-size * " + tref)

	// Adds the svg element to the body of the document
	svg.init(graphObj).select("body").append("svg")
	svg.attr("width", "obj_(size + (padding * 2)) * " + tref)
	svg.attr("height", "obj_(size + (padding * 2)) * " + tref)
	svg.append("g")
	svg.attr("transform", `"obj_"translate(" "' + "padding" + " * " + tref + 
			`" + ", " + "' + "padding" + " * " + tref + `" + ")" "')

	// Draws the x-axes on the graph
	clsxaxis.init().jsfree("svg").selectAll(".x.axis").data("obj_" + traitnm)
	clsxaxis.enter().append("g").attr("class", "x axis")
	clsxaxis.attr("transform", `"obj_function(d, i) { return "translate(" + ("' + tref + `" - i - 1) * size + ", 0)"; }"')
	clsxaxis.each("obj_function(d) { x.domain(" + extObj + "[d]); d3.select(this).call(xAxis); }")

	// Draws the y-axes on the graph
	clsyaxis.init().jsfree("svg").selectAll(".y.axis").data("obj_" + traitnm)
	clsyaxis.enter().append("g").attr("class", "y axis")
	clsyaxis.attr("transform", `"obj_function(d, i) { return "translate(0, " + i * size + ")"; }"')
	clsyaxis.each("obj_function(d) { y.domain(" + extObj + "[d]); d3.select(this).call(yAxis); }")

	// Calls the plot function and adds the cells to the document
	cell.init().jsfree("svg").selectAll(".cell")
	cell.data("obj_cross(varnames, varnames)").enter().append("g")
	cell.attr("class", "cell")
	cell.attr("transform", `"function(d) { return "translate(" + ("' + tref + " - d.i - 1) * size + " + `""," + d.j * size + ")"; }"')
	cell.each("obj_plot")

	// Removes points from diagonal cells
	cellfilter.init().jsfree("cell")
	cellfilter.filter("obj_function(d) { return d.i === d.j; }")
	cellfilter.selectAll("circle").remove()

	// Creates variable that issues the calls to the brush
	cellcall.init().jsfree("cell").call("obj_brush")

	// Creates the function used to draw the splom
	splom = splomPlot(traitnm, "p", extObj, "data", "size", "padding", 
					  colorAssign, textSize, d3label)

	// Creates the brush variable that issues the brush callbacks
	brush = xyBrushDispatcher(graphObj)

	// Defines the brush callbacks
	brushFunctions = xyBrushFunctions(brushArgName, extObj, brushVarName, graphObj)

	// Makes selection on current document to draw the graph  
	frame.init().jsfree("d3").select("obj_self.frameElement")
	frame.style("height", "obj_size * " + traitnm + ".length + padding + 20 + " + `""px""')

	// Provides the cross function
	cross = d3cross()

	cb = (	"function(error, json) {" + gob.nlindent \
			"if (error) throw error;" + gob.nlindent \
			"width = " + grwidth + ";" + gob.dblnl \
			"stdata = json;" + gob.nlindent \
			"data = json.data;" + gob.nlindent \
			"varnames = json.variableNames;" + gob.nlindent \
			"varlabels = json.variableLabels;" + gob.nlindent \
			"vallabels = json.valueLabels;" + gob.nlindent \
			scale + gob.nlindent \
			"size = width / scaleFactor;" + gob.nlindent \
			extObj + " = {};" + gob.nlindent \
			varExtent.complete() + gob.nlindent \ 
			"padding = " + padding + gob.nlindent \
			"textsize = " + textsize + gob.nlindent \
			x.complete() + gob.nlindent \ 
			y.complete() + gob.nlindent \ 
			xAxis.complete() + gob.nlindent \
			yAxis.complete() + gob.nlindent \
			color.complete() + gob.nlindent \ 
			brush.complete() + gob.nlindent \ 
			svg.complete() + gob.nlindent \ 
			clsxaxis.complete() + gob.nlindent \
			clsyaxis.complete() + gob.nlindent \
			cell.complete() + gob.nlindent \
			cellfilter.complete() + gob.nlindent \
			cellcall.complete() + gob.nlindent \
			splom.getter() + gob.nlindent \
			brushFunctions[1, 1].getter() + gob.nlindent \
			brushFunctions[1, 2].getter() + gob.nlindent \
			brushFunctions[1, 3].getter() + gob.nlindent \
			frame.complete() + gob.nl \ "}" + gob.dblnl )

	// Makes the body variable an empty string		
	body = ""			
	
	// Loops over all records 
	for(i = 1; i <= rows(cb); i++) {
		body = body + cb[i, 1]
	}

	// Constructs the data loader and the callback inside of it that creates the 
	// graph
	gob.init().jsfree("d3").json(filename, body)

	// Constructs the final return object
	retob.init().jsfree(gob.complete() + retob.dblnl + cross.getter() + retob.dblnl)

	// Returns the object to the user
	return(retob)

} // End of Function declaration

end


	
