module Language::ExpAutomatic

import ParseTree;

lexical LAYOUT = [\t-\n\r\ ];
layout LAYOUTLIST = LAYOUT* !>> [\t-\n\r\ ];
lexical IntegerLiteral = [0-9]+;

start syntax Exp = con: IntegerLiteral
                 | bracket "(" Exp ")"
                 > left mul: Exp "*" Exp
                 > left add: Exp "+" Exp
                 ;
 
/**
 * It is good practice to introduce separate modules for parsing and for the conversion itself:
 * - A Parse module defines a parse function and returns a parse tree. It imports only the concrete syntax.
 * - A Load module defines a load function that first calls the above parse function 
 *   and then applies implode to it. This is the only module that imports both concrete and 
 *   abstract syntax at the same time and is therefore the only place to be concerned about name clashes. 
 *   (If I mention Exp, do you know which one I mean?).
 */

// Parse module
public Tree parseExp(str txt) = parse(#Exp, txt);

// Load module
public Exp load(str txt) = implode(#Exp, parseExp(txt));

// Evaluation module
public int eval(str txt) = eval(load(txt));

public value main(list[value] args){
  return eval("1+2");
}
