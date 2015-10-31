module language::exp::Concrete::NoLayout::Eval

import language::exp::Concrete::NoLayout::Syntax;
import String;
import ParseTree;                                                 

public int eval(str txt) = eval(parse(#Exp, txt));                

public int eval((Exp)`<IntegerLiteral l>`) = toInt("<l>");        
public int eval((Exp)`<Exp e1>*<Exp e2>`) = eval(e1) * eval(e2);  
public int eval((Exp)`<Exp e1>+<Exp e2>`) = eval(e1) + eval(e2);  
public int eval((Exp)`<Exp e1>/<Exp e2>`) = eval(e1) / eval(e2);  
public int eval((Exp)`(<Exp e>)`) = eval(e); 