module Basic::Examples

import List;
import IO;

// Determine the number of strings that contain "a". 
public int count(list[str] text) {
    n = 0;
    for(s <- text)
        if( /a/ := s)
            n +=1;
    return n;
}

//  Return the strings that contain "o".
public list[str] find(list[str] text) {
    return 
        for (s <- text)
            if (/o/ := s) append s;
}

// this function that finds duplicates in a list of strings
public list[str] duplicates(list[str] text) {
    m = {};
    return 
        for(s <- text) {

           if (s in m) 
               append s;
           else 
               m += s;
        }
}

// tests that a list of words forms a palindrome.
public bool isPalindrome(list[str] words) {
    return words == reverse(words);
}