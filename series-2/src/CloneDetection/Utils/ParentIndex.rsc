module CloneDetection::Utils::ParentIndex

import CloneDetection::ClonePairs;

import lang::java::m3::AST;
import Node;
import Prelude;

anno int Statement @ uniqueKey;
anno int Declaration @ uniqueKey;
anno int node @ uniqueKey;

private map[int childOf, node parent] childrenToParent = ();

void collectChildrenToParentIndexFromAST(set[Declaration] asts) {
    bottom-up visit (asts) {
        case Statement subTree: setChildrenFromAParent(subTree);
        case Declaration subTree: setChildrenFromAParent(subTree);
    }
}

map[int childOf, node parent] getParentIndex() = childrenToParent;

void clearParentIndex() {
    childrenToParent = ();
}

private void setChildrenFromAParent(subTree) {

    int parentUniqueKey = subTree@uniqueKey;
    allChildrenNodes = getChildren(subTree);
    
    for (child <- allChildrenNodes) {
        switch (child) {
            case Statement statement: childrenToParent[statement@uniqueKey] = subTree;
            case Declaration declaration: childrenToParent[declaration@uniqueKey] = subTree;
            case list[Statement] block: {
                for (statement <- block) {
                    childrenToParent[statement@uniqueKey] = subTree;
                }
            }
            case list[Declaration] declarations: {
                for (declaration <- declarations) {
                    childrenToParent[declaration@uniqueKey] = subTree;
                }
            }
        }
    }
}

bool hasParent(Statement tree) = childrenToParent[tree@uniqueKey]?;
bool hasParent(Declaration tree) = childrenToParent[tree@uniqueKey]?;

bool hasParent(Sequence tree) {
    firstStatement = tree[0];
    
    return childrenToParent[firstStatement@uniqueKey]?;
}

node getParentOf(Statement tree) = childrenToParent[tree@uniqueKey];
node getParentOf(Declaration tree) = childrenToParent[tree@uniqueKey];

node getParentOf(Sequence tree) {
    firstStatement = tree[0];
    
    return childrenToParent[firstStatement@uniqueKey];
}