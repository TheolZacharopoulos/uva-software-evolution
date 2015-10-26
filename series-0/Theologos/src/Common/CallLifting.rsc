module Common::CallLifting

alias proc = str;
alias comp = str;

/**
 * The situation can be characterized by:
 * - A call relation between procedures
 * - A partOf relation between procedures and components.
 */
public rel[comp,comp] lift(rel[proc,proc] aCalls, rel[proc,comp] aPartOf) {
    return { <C1, C2> | 
                    <proc P1, proc P2> <- aCalls, 
                    <comp C1, comp C2> <- aPartOf[P1] * aPartOf[P2]};
}