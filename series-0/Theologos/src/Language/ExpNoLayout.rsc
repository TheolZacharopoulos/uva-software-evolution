module Language::ExpNoLayout

// ==========================================
// 1. Build a grammar for Exp

// defines a lexical syntax rule for IntegerLiterals; 
// they consist of one or more digits.
lexical IntegerLiteral = [0-9]+;

// Define the alternatices for Exp
// start means that this is a start symbol of the grammar.
start syntax Exp
    = IntegerLiteral        // alternative #1: an IntegerLiteral
    | bracket "(" Exp ")"   // alternative #2: parentheses.
    > left Exp "*" Exp      // alternative #3: multiplication.
    > left Exp "+" Exp      // alternative #4: addition.
    ;

// # 2  
// The | says that this alternative has the same priority as 
// the previous one. The keyword bracket marks this as an 
// alternative that defines parentheses.

// # 3,4
// The > says that the previous rule has a higher priority 
// than the current one. The keyword left marks this as a 
// left-associative rule.

// ==========================================
// 2. Build an evaluator for Exp
import String;
import ParseTree;

// parse(#Exp, txt) parses the given txt according to non-terminal Exp 
// as defined by the grammar. The result is a parse tree.
// This parse tree is given to another eval function that will 
// reduce the tree to an integer.
public int eval(str txt) = eval(parse(#Exp, txt));                

// Converts an IntegerLiteral to an integer
public int eval((Exp)`<IntegerLiteral l>`) = toInt("<l>");

// handle multiplication        
public int eval((Exp)`<Exp e1>*<Exp e2>`)  = eval(e1) * eval(e2);

// handle addition  
public int eval((Exp)`<Exp e1>+<Exp e2>`)  = eval(e1) + eval(e2);

// handle parenthesis  
public int eval((Exp)`(<Exp e>)`)          = eval(e);


