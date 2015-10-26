module Bottles

import IO;

// define string as 'str'

// Auxiliary functions:
str bottles(0) = "no more bottles";
str bottles(1) = "1 bottle";

// default function (think of switch default / 'otherwise' word in Haskell guards)
// if the case for 0 and 1 do not match, this alternative should handle the other cases.
default str bottles(int n) = "<n> bottles";

public void sing() {
	// This is a Generator
	// it is NOT inclusive, does not include the 0. 
	for (n <- [99..0]) {
		println("<bottles(n)> of beer on the wall, <bottles(n)> of beer");
		println("Take one down, pass it around, <bottles(n-1)> of beer on the wall.\n");
	}
	
	println("No more bottles of beer on the wall, no more bottles of beer.");
  	println("Go to the store and buy some more, 99 bottles of beer on the wall.");
}
