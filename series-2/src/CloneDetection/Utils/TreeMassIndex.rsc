module CloneDetection::Utils::TreeMassIndex

import lang::java::m3::AST;
import Node;
import List;

import CloneDetection::Statements::TreeMass;

anno int node @ uniqueKey;

@doc{
Database for tree weight values
}
private map[int uniqueKey, int weight] treeToWeight = ();

void addTreeWeight(node tree) {    
    treeToWeight[tree@uniqueKey] = calculateTreeMass(tree);
}

bool hasTreeWeight(node tree) = treeToWeight[tree@uniqueKey]?;

int getTreeWeight(node tree) = treeToWeight[tree@uniqueKey] when treeToWeight[tree@uniqueKey]?;

int getTreeWeight(list[node] sequence) = (1 | it + getTreeWeight(child) | child <- sequence);