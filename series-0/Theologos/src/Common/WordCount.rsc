module Common::WordCount

// wordCount takes a list of strings and a count function
// that is applied to each line. The total number of words is returned
// int (str s) countInLine is a function in form : int countInLine(str s)
public int wordCount(list[str] input, int (str s) countInLine) {
    count = 0;
    for (str line <- input) {
        count += countInLine(line);    
    }
    return count;
}

// Pattern mach words.
public int countInLine1(str S) {
    int count = 0;
    
    // for every pattern match of regular expression in S
    // increment the counter.
    for(/[a-zA-Z0-9_]+/ := S) {
        count += 1;
    }
    return count;
}

// Each iteration removes the first word from S and counts it. 
public int countInLine2(str S) {
    int count = 0;
  
    // \w matches any word character
    // \W matches any non-word character
    // <...> are groups and should appear at the top level.
    while (/^\W*<word:\w+><rest:.*$>/ := S) { 
        count += 1;
        // the new value of S becomes the remainder of the current match.
        S = rest; 
    }
    return count;
}

// functional foldr
public int countInLine3(str S) {
    // this is a Rascal Reducer where:
    // - 0 is the initial value of the reducer
    // - The pattern match /\w+/ := S matches all words in S.
    // - Reduction is done by it + 1. 
    //   In the latter it is a keyword that refers to the value that 
    //   has been reduced sofar. Effectively, the matches are reduced
    //   to a match count.
    return (0 | it + 1 | /\w+/ := S);
}
