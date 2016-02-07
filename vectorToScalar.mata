/*
Convenience functions that collapse vectors of strings into a single scalar by 
either forward or reverse order of the vector elements
*/


// Starts mata interpretter/session
mata:

// Function to collapse a column vector of strings into a single string scalar
// based on the forward order of the elements in the vector
string scalar rowsForward(string colvector stringArray) {

	// Variable used to store the return value
	string scalar retval
	
	// Variable used to iterate over the rows in the column vector
	real scalar iterator
	
	// For each row from 1 - the number of rows in the column vector 
	for(iterator = 1; iterator <= rows(stringArray); iterator++) {
	
		// Add each string scalar to the return value variable
		retval = retval + stringArray[iterator, 1]
		
	} // End Loop 
	
	// Return the scalar variable to the caller
	return(retval)
	
} // End of function declaration


// Function to collapse a row vector of strings into a single string scalar
// based on the forward order of the elements in the vector
string scalar colsForward(string rowvector stringArray) {

	// Variable used to store the return value
	string scalar retval
	
	// Variable used to iterate over the columns in the row vector
	real scalar iterator
	
	// For each column from 1 - the number of columns in the row vector 
	for(iterator = 1; iterator <= cols(stringArray); iterator++) {
	
		// Add each string scalar to the return value variable
		retval = retval + stringArray[1, iterator]
		
	} // End Loop 
	
	// Return the scalar variable to the caller
	return(retval)
	
} // End of function declaration

// Function to collapse a column vector of strings into a single string scalar
// based on the reverse order of the elements in the vector
string scalar rowsReverse(string colvector stringArray) {

	// Variable used to store the return value
	string scalar retval
	
	// Variable used to iterate over the rows in the column vector
	real scalar iterator
	
	// For each row from 1 - the number of rows in the column vector 
	for(iterator = rows(stringArray); iterator >= 1; iterator--) {
	
		// Add each string scalar to the return value variable
		retval = retval + stringArray[iterator, 1]
		
	} // End Loop 
	
	// Return the scalar variable to the caller
	return(retval)
	
} // End of function declaration


// Function to collapse a row vector of strings into a single string scalar 
// based on the reverse order of the elements in the vector
string scalar colsReverse(string rowvector stringArray) {

	// Variable used to store the return value
	string scalar retval
	
	// Variable used to iterate over the columns in the row vector
	real scalar iterator
	
	// For each column from 1 - the number of columns in the row vector 
	for(iterator = cols(stringArray); iterator >= 1; iterator--) {
	
		// Add each string scalar to the return value variable
		retval = retval + stringArray[1, iterator]
		
	} // End Loop 
	
	// Return the scalar variable to the caller
	return(retval)
	
} // End of function declaration




// End of Mata session
end

