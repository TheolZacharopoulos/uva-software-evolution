module Strategy::Commons

import lang::java::m3::AST;
import Prelude;

data CloneOccurance = declaration(Declaration originalDeclaration, Declaration cloneDeclaration)
                    | statement(Statement originalStatement, Statement cloneStatement);

alias Clones = set[CloneOccurance];

int getTreeMass(node tree)
{
    c = 0;
    bottom-up visit (tree) {
        case node t: {
            c += 1;
        }
    }
    
    return c;
}


int getTreeMass(set[node] trees) = (0 | it + getTreeMass(subTree) | subTree <- trees);