module Strategy::Commons

import lang::java::m3::AST;

alias CloneOccurance = tuple[Declaration original, Declaration clone];
alias Clones = set[CloneOccurance];

data CloneTree = 
               // Class that has a clone
               clonedClass(Declaration origin, Declaration clone)
               // Class that holds cloned fragments
               | class(Declaration class, list[CloneTree] \methods) 
               // Method that has a clone
               | clonedMethod()
               ;