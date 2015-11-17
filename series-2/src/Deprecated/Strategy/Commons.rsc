module Strategy::Commons

import lang::java::m3::AST;
import Prelude;

data CloneOccurance = declaration(Declaration originalDeclaration, Declaration cloneDeclaration)
                    | statement(Statement originalStatement, Statement cloneStatement);

alias Clones = set[CloneOccurance];