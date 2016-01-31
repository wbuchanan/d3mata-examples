// Function to map/pass values to construct the axes of a graph
var axes = function(axis, varnm, position) {
  if(axis === "x") {
    xValue = function(d) { return d[varnm]; } ;
    xScale = d3.scale.linear().range([0, width]) ; 
    xMap = function(d) { return xScale(xValue(d)); } ; 
    xAxis = d3.svg.axis().scale(xScale).orient(position) ;
  } else if(axis === "y") {
    yValue = function(d) { return d[varnm]; }; 
    yScale = d3.scale.linear().range([height, 0]); 
    yMap = function(d) { return yScale(yValue(d)); } ; 
    yAxis = d3.svg.axis().scale(yScale).orient(position);
  }
}
