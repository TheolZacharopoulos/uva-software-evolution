module Factorial

// Version 1, hmm hello Haskell, conditional expression
public int fac(int N) = N <= 0 ? 1 : N * fac(N-1);

// Version 2, function overloading / pattern matching
public int fac2(0) = 1;
public default int fac2(int N) = N * fac2(N-1);

// Version 3, classical imperative style
public int fac3(int N) {
	if (N == 0) {
		return 1;
	}
	
	return N * fac3(N - 1);
}
