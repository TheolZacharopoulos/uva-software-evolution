module basic::Factorial

import IO;

public int factorialFunctional(int n) = n <= 0 ? 1 : n * factorialFunctional(n - 1);

public int factorialImperative(int n)
{
	if (n == 0) {
		return 1;
	}
	
	return n * factorialImperative(n - 1);
}

public int factorialPatternMatching(0) = 1;
public default int factorialPatternMatching(int n) 
    = factorialPatternMatching(n - 1) * n;