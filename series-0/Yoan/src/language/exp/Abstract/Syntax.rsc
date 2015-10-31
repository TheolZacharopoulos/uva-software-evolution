module language::exp::Abstract::Syntax

data Exp = con(int n)          
         | mul(Exp e1, Exp e2) 
         | add(Exp e1, Exp e2) 
         ;

 