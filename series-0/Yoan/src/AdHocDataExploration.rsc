module AdHocDataExploration

import IO;
import List;

public int fact(0) = 1;
public default int fact (int n) = n * fact(n - 1);

public int countTrailingZeros(int n) 
{
    if (n < 10) {
        return 0;
    } else if (n % 10 == 0) {
        return 1 + countTrailingZeros(n / 10);
    } else {
        return 0;
    }   
}

public void printLastTwenty (int n)
{
    for (int i <- [n-19..n+1]) {
        println ("<i>! has <countTrailingZeros(fact(i))> trailing zeros.");
    }
}

public void findLumps2 (int n, int tao) 
{
    int iMinusOneFactZeros = 0;
    for (int i <- [1..n+1]) {
        int iFactZeros = countTrailingZeros(fact(i));
        int diff = iFactZeros - iMinusOneFactZeros ;
        if (diff >= tao) {
            println ("<diff> more zeros at <i>!");
        }
        iMinusOneFactZeros = iFactZeros;
    }
}

public int predictZeros(int N) 
{
    int k = floorLogBase(N, 5);
    int nz = 0;
    for (int i <- [1..N+1] ) {
        int p5 = 1;
        for (int j <- [1..k+1]) {
            p5 *= 5;
            if (i % p5 == 0) {
                nz += 1;
            } else {
                break;
            }
        }
    }
    return nz; 
}

public int floorLogBase(int a, int b) 
{
    int remaining = a;
    int ans = 0;
    while (remaining >= b) {
        ans += 1;
        remaining /= b;
    }
    return ans;     
}

public void verifyTheory (int N) 
{
    int checkInterval = 100; // for printing
    bool failed = false;
    for (int i <- [1..N+1]) {
        ifact=fact(i);
        int p = predictZeros(i);
        int c = countTrailingZeros(ifact);
        if (p != c) {
            failed = true;
            println ("Found a counter example at i=<i>");
            break;
        } else {
            if (i % checkInterval == 0) {
                println ("<i>! has <p> trailing zeros");
            }
        }
    }
    
    if (!failed) {
        println ("The theory works for i: 1..<N>");
    }
}