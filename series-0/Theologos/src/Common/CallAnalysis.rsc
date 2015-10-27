module Common::CallAnalysis

import Set;
import Relation;
import analysis::graphs::Graph;

// just for redability, a new type synonim (haskell like)
alias Proc = str;

// describe the call graph as a set of relation.
rel[Proc, Proc] Calls = {
        <"a", "b">, <"b", "c">, <"b", "d">, <"d", "c">, 
        <"d", "e">, <"f", "e">, <"f", "g">, <"g", "e">
    };

/** 
 * Since each tuple in the Calls relation represents 
 * a call between procedures, the number of tuples 
 * is equal to the number of calls.
 * 
 * Determine the number of elements in a set or relation.
 */
public int numberOfCalls = size(Calls);

/** 
 * Since a procedure may call (or be called) by several others 
 * and the number of tuples is therefore not indicative. 
 * What we need are the set of procedures that occur 
 * (as first or second element) in any tuple.
 * This is precisely what the function Rascal:carrier gives us
 */
 
public int proceduresOccurInTheSystem = size(carrier(Calls));

/**
 * The top of a relation contains those left-hand sides of tuples in 
 * a relation that do not occur in any right-hand side. 
 * When a relation is viewed as a graph, its top corresponds to the 
 * root nodes of that graph.
 */
public set[Proc] entryPoints = top(Calls);

/**
 * Similarly, the bottom of a relation corresponds to 
 * the leaf nodes of the graph.
 */
public set[Proc] leaves = bottom(Calls);


/**
 * We can also determine the indirect calls between procedures, 
 * by taking the transitive closure of the Calls relation
 */
public rel[Proc, Proc] closureCalls = Calls+;

/**
 * Which procedures are called directly or indirectly from each entry point?
 */
public set[Proc] calledFromA = closureCalls["a"];
public set[Proc] calledFromF = closureCalls["f"];

/**
 * we can determine which procedures are called from both entry points 
 * by taking the intersection of the two sets calledFromA and calledFromF
 */
 
public set[Proc] calledFromAllEntryPoints = calledFromA & calledFromF; 

/**
 * Or using reducer:
 * The reducer is initialized with all procedures (carrier(Calls)) 
 * and iterates over all entry points (p <- top(Calls)). 
 * At each iteration the current value of the reducer (it) is 
 * intersected (&) with the procedures called directly 
 * or indirectly from that entry point ((Calls+)[p]).
 */
public set[Proc] calledFromAllEntryPoints2 = 
     (carrier(Calls) | it & (Calls+)[p] | p <- top(Calls));
     
