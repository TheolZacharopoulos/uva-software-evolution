module Language::ExpManual

import ParseTree;
import String;
import vis::ParseTree;

lexical IntegerLiteral = [0-9]+;

start syntax Exp
    = IntegerLiteral        // alternative #1: an IntegerLiteral
    | bracket "(" Exp ")"   // alternative #2: parentheses.
    > left Exp "*" Exp      // alternative #3: multiplication.
    > left Exp "+" Exp      // alternative #4: addition.
    ;

/**
 * Parse the tree and visualize it.
 */
Tree parseAndVis(str txt) {
    res = parseExp(txt);
    renderParsetree(res);
}

public Tree parseExp(str txt) = parse(#Exp, txt);

// The top level load function that converts a string to an abstract syntax tree.
public Exp loadExp(str txt) = load(parseExp(txt));        

// The conversion from parse tree to abstract syntax tree start here.
public Exp load((Exp)`<IntegerLiteral l>`) = con(toInt("<l>"));       
public Exp load((Exp)`<Exp e1> * <Exp e2>`) = mul(load(e1), load(e2));  
public Exp load((Exp)`<Exp e1> + <Exp e2>`) = add(load(e1), load(e2)); 
public Exp load((Exp)`( <Exp e> )`) = load(e);

// The interpreter
public int eval(str txt) = eval(loadExp(txt));
