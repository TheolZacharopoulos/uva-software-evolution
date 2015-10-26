module Even

import IO;

// Classic imperative version.
list[int] even0(int max) {
    list[int] result = [];
    
    for (int i <- [0..max]) {
        if (i % 2 == 0) {
            result += i; // append to the list.
        }
    }
    return result;
}

// Remove temporary type declarations.
list [int] even1(int max) {
    result = []; // no type declaration
    for (i <- [0..max]) {
        if (i % 2 == 0) {
            result += i; 
        }
    }
    return result;
}

// Inline if statement in for statement.
list[int] even2(int max) {
    result = [];
    for (i <- [0..max], i % 2 == 0) { // like while.
        result += i;
    }
    return result;
}

// inline for, use the append statement
list[int] even3(int max) {
    result = for (i <- [0..max], i % 2 == 0) 
        append i;
    return result;
}

// return rightaway
list [int] even4(int max) {
    return for (i <- [0..max], i % 2 == 0) append i;
}

// ok just make a list comprehension out of it:
list[int] even5(int max) {
    return [i | i <- [0..max], i % 2 == 0]; 
}

// or inliner:
list[int] even6(int max) = [i | i <- [0..max], i % 2 == 0];

// to make it a Set:
list[int] even7(int max) = {i | i <- [0..max], i % 2 == 0};