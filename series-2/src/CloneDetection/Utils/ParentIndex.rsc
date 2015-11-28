module CloneDetection::Utils::ParentIndex

import CloneDetection::AbstractClonePairs;

import lang::java::m3::AST;
import Node;
import Prelude;

anno int Statement @ uniqueKey;
anno int Declaration @ uniqueKey;
anno int node @ uniqueKey;

private map[int childOf, node parent] childrenToParent = ();

void setChildrenFromAParent(subTree) {

    int parentUniqueKey = subTree@uniqueKey;
    allChildrenNodes = getChildren(subTree);
    
    for (child <- allChildrenNodes) {
        switch (child) {
            case Statement statement: {
                childrenToParent[statement@uniqueKey] = subTree;
            }
            case list[Statement] block: {
                for (statement <- block) {
                    childrenToParent[statement@uniqueKey] = subTree;
                }
            }
        }
    }
}

bool hasParent(Statement tree) = childrenToParent[tree@uniqueKey]?;
bool hasParent(Declaration tree) = childrenToParent[tree@uniqueKey]?;

node getParentOf(Statement tree) = childrenToParent[tree@uniqueKey];
node getParentOf(Declaration tree) = childrenToParent[tree@uniqueKey];