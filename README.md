# Stata D3 Examples
These examples are being updated little by little to reflect changes in the [jsonio](https://wbuchanan.github.io/StataJSON) and in preparation for the 2016 North American Stata Users Group Meeting in Chicago.  

# Update
Recently, [D3.js](https://www.d3js.org) released a new major version (4.0).  This library does not reflect any of the changes to the new API, but may be modified overtime to use the newer API or include capabilities to manage the code generation in a way that will allow the library to handle the version 3 or 4 APIs.


## Examples
The examples page will evolve over time, but there is currently a single example that shows output generated by the d3scatterTip Mata function defined in this repository.  After converting the auto.dta dataset to JSON using [jsonio](http://wbuchanan.github.io/StataJSON/about/) and defining the d3scatterTip Mata function, the graph was created using the code:

```   
mata: d3scatterTip("~/Desktop/Programs/StataPrograms/d/d3/examples//index.html", ///   
		   "data/auto.json", "length", "gear_ratio", "foreign", "make")
```   

The example above can be viewed on the [project page](http://wbuchanan.github.io/d3mata-examples/).  If, for example, we wanted to generate the points colored based on the number of repairs in the `rep78` variable, it would be as simple as:

```
mata: d3scatterTip("~/Desktop/Programs/StataPrograms/d/d3/examples//index.html", ///   
                   "data/auto.json", "length", "gear_ratio", "rep78", "make")
```
 


