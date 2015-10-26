module Basic::Squares

import IO;

public void squares(int N) {

	// string, value interpolation 
	println("Table of squares from 1 to <N>");
	
	// hmm haskell-like lazy lists nice.
	for (int I <- [1..N+1]) {
		println("<I> squared = <I * I>");
	}
}

// String templates, cool!
public str squareTemplates(int N)
	= "Table of squares from 1 to <N>
	  '<for (int I <- [1 .. N + 1]) {>
	  '    <I> squared = <I * I> <}>
	  ";
