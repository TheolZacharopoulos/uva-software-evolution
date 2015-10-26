module Common::WordReplacement

import String;

/**
 * Converts every first letter of a word to uppercase.
 */
public str capitalize(str word) {
    // pattern match the first letter of the word if is not capital
    // and keep the letter in the letter variable.
    if (/^<letter:[a-z]><rest:.*$>/ := word) {
        return toUpperCase(letter) + rest;
    } else {
        // if the letter is already Capital
        return word; 
    }
}

// Capitalize all words in a string

// Version 1: capAll1: using a while loop
public str capAll1(str S) {
    result = "";
    
    // pattern match the text before and after the word
    while (/^<before:\W*><word:\w+><after:.*$>/ := S) {
    
        // append the text to the result, capitalized. 
        result = result + before + capitalize(word);
        
        // continue with the rest (after the word)
        S = after;
    }
    return result;
}

// Version 2: capAll2: using visit
public str capAll2(str S) {
    return visit(S) {
        // visit all words in the sentence
        // replace them by a capitalized version
        case /^<word:\w+>/i => capitalize(word)
    };
}