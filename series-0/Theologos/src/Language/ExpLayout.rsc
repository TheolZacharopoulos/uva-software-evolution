module Language::ExpLayout

/**
 * In Rascal, the major difference between lexical syntax and non-lexical syntax is that:
 * - Strings that are parsed according to the lexical syntax do not 
 *   contain additional layout characters such as spaces, new lines, 
 *   and source code comments.
 * - Strings that are parsed according to the normal (non-lexical) 
 *   syntax can contain layout characters between each element.
 * - Which 'layout' (whitespace and/or source code comments) will be 
 *   accepted has to be defined explicitly by the grammar writer.
 */

// Using the layout definition, we define that the Whitespace 
// non-terminal is used in between every symbol of the syntax 
// productions in the current module. 
layout Whitespace = [\t-\n\r\ ]*;    
lexical IntegerLiteral = [0-9]+;          

start syntax Exp 
    = IntegerLiteral          
    | bracket "(" Exp ")"     
    > left Exp "*" Exp        
    > left Exp "+" Exp        
    ;
    
// Now we can use spaces in our definition of the eval function as well:
import String;
import ParseTree;

public int eval((Exp)`<IntegerLiteral l>`)  = toInt("<l>");       
public int eval((Exp)`<Exp e1> * <Exp e2>`) = eval(e1) * eval(e2);  
public int eval((Exp)`<Exp e1> + <Exp e2>`) = eval(e1) + eval(e2); 
public int eval((Exp)`( <Exp e> )`)         = eval(e);                    

public value main(list[value] args) {
    return eval("2+3");
}

// the pattern matching will ignore all trees in layout positions, 
// such that the parse tree of "1 + \n1" will match against 
// <Exp e1> + <Exp e2>. The same goes for equality on parse trees.

 