module basic::Squares

import IO;

public void squares(int n)
{
	println("Table of squares from 1 up to <n>");
	for (int a <- [1 .. n + 1]) {
		println("Square of <a> is <a * a>");
	}	 
}

public str squaresTemplate(int n) =
	"Table of squares from 1 to <n>
	'<for (int a <- [1 .. n + 1]) {>
	'	Square of <a> is <a * a> 
	'<}>
	";