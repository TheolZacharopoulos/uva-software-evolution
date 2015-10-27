module basic::Evens

import IO;
import List;

public list[int] even0(int max)
{
    list[int] result = [];
    for (int a <- [0 .. max + 1]) {
        if (a % 2 == 0) {
            result += a;
        }
    }
    
    return result;
}

public list[int] even1(int max)
{
    result = [];
    for (int a <- [0 .. max + 1]) {
        if (a % 2 == 0)
            result += a;
    }
    return result;
}

public list[int] even2(int max)
{
    result = [];
    for (int a <- [0 .. max + 1], a % 2 == 0) {
        result += a;
    }
    return result;
}

public list[int] even3(int max)
{
    result = for (i <- [0..max], i % 2 == 0) append i;
    return result;
}

public list[int] even4(int max)
{
    return for (i <- [0..max], i % 2 == 0) append i;
}

public list[int] even5(int max)
{
    return [ i | i <- [0..max], i % 2 == 0];
}

public list[int] even6(int max) = [ i | i <- [0..max], i % 2 == 0];

public set[int] even7(int max) = { i | i <- [0..max], i % 2 == 0};