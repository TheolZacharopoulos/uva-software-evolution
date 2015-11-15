module IdenticalBlocks

import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::m3::Core;

import Prelude;

set[tuple[loc, loc]] findIdenticalMethods(M3 model)
{
    map[loc, Statement] bodies = ();
    
    for (class <- classes(model)) {
        for (method <- methods(model, class)) {
            methodAST = getMethodASTEclipse(method, model = model);
            for ((\method(_, str name, _, _, Statement impl) := methodAST || \constructor(str name, _, _, Statement impl) := methodAST)) {
                bodies[method] = delAnnotationsRec(impl);
            }
        }
    }
    
    iprintln(bodies);
    
    return {<methodA, methodB> | methodA <- bodies, methodB <- bodies, methodA != methodB, bodies[methodA] == bodies[methodB]};
}