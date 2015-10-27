module Language::FuncLang::Syntax

/**
 * Func is a functional language with the following features:
 * - A program consists of a number of function declarations.
 * - A function declaration consists of a name, zero or more formal parameter names and an expression.
 * - An expression can be one of:
 *      - an integer constant.
 *      - a variable.
 * - arithmetic operators +, -, * and /.
 * - comparison operators <, <=, > and >=.
 * - a call of a function.
 * - an if expression.
 * - a sequence of expressions (;).
 * - an assignment (:=).
 * - a let expression to introduce new bindings for local variables.
 * - an address of a variables (denoted by &).
 * - derefence of a variable (denoted by *).
 */
 
 // FuncLang Examples:
 
 /**
  * fact(n) = if n <= 1 then
  *             1 
  *         else 
  *           n * fact(n-1)
  *        end
  */
  
  /**
   * fact(n) = if n <= 1 then 
   *          n := 1
   *       else 
   *          n := n * fact(n-1)
   *       end;
   *       n
   */

// =============================================
// The Grammar
lexical Ident =  [a-zA-Z][a-zA-Z0-9]* !>> [a-zA-Z0-9];
lexical Natural = [0-9]+ !>> [0-9];
lexical LAYOUT = [\t-\n\r\ ];

layout LAYOUTLIST = LAYOUT*  !>> [\t-\n\r\ ] ;

start syntax Prog = prog: Func* ;

syntax Func = func: Ident name "(" {Ident ","}* ")" "=" Exp;

syntax Exp = let: "let" {Binding ","}* "in" Exp "end"
           | cond: "if" Exp "then" Exp "else" Exp "end"
           | bracket "(" Exp ")"
           | var: Ident
           | nat: Natural 
           | call: Ident "(" {Exp ","}* ")"
           | address: "&" Ident
           > deref: "*" Exp 
           > non-assoc (
               left mul: Exp "*" Exp 
             | non-assoc div: Exp "/" Exp
           ) 
           > left (
               left add: Exp "+" Exp 
             | left sub: Exp "-" Exp
           )
           >
           non-assoc (
               non-assoc gt: Exp "\>" Exp
             | non-assoc lt:  Exp "\<" Exp
             | non-assoc geq:  Exp "\>=" Exp
             | non-assoc leq:  Exp "\<=" Exp
           )
           >
           right assign: Exp ":=" Exp
           >
           right seq: Exp ";" Exp; 

syntax Binding = binding: Ident "=" Exp;