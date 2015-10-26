module Common::Derivative

// Compute derivative, rules:
// dN / dX = 0.
// dX / dX = 1.
// dX / dY = 0, when X != Y.
// d(E1 + E2) /dX = dE1 / dX + d E2 /dX.
// d(E1 * E2) / dX = (d E1 / dX * E2) + (E1 * d E2 /dX).

// Define a data type Exp to represent expressions 
data Exp = con(int n)           
         | var(str name)
         | mul(Exp e1, Exp e2)
         | add(Exp e1, Exp e2)
         ;

// Introduce an example expression E for later us
public Exp E = add(mul(con(3), var("y")), mul(con(5), var("x"))); 

// Define the actual differentiation function dd
public Exp dd(con(n), var(V))              = con(0);  
public Exp dd(var(V1), var(V2))            = con((V1 == V2) ? 1 : 0);
public Exp dd(add(Exp e1, Exp e2), var(V)) = add(dd(e1, var(V)), dd(e2, var(V)));
public Exp dd(mul(Exp e1, Exp e2), var(V)) = add(mul(dd(e1, var(V)), e2), mul(e1, dd(e2, var(V))));
 
// Define simplification rules
public Exp simp(add(con(n), con(m))) = con(n + m);   
public Exp simp(mul(con(n), con(m))) = con(n * m);

public Exp simp(mul(con(1), Exp e))  = e;
public Exp simp(mul(Exp e, con(1)))  = e;
public Exp simp(mul(con(0), Exp e))  = con(0);
public Exp simp(mul(Exp e, con(0)))  = con(0);

public Exp simp(add(con(0), Exp e))  = e;
public Exp simp(add(Exp e, con(0)))  = e;

public default Exp simp(Exp e)       = e;            

// Define the actual simplication function simplify that 
// performs a bottom up traversal of the expression, 
// application simplification rules on the the up.
public Exp simplify(Exp e) {
    return bottom-up visit(e) {
            case Exp e1 => simp(e1)
        }
}
