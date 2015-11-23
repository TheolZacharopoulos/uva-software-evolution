@doc{
    A hash function is considered good if it minimizes the probability p 
    of hash value collision for two structurally different subtrees.
}
module CloneDetection::Utils::Fingerprinter

import lang::java::jdt::m3::AST;
import IO;
import List;
import Set;
import Node;
import String;
import util::Math;

alias Hash = int;

int RANDOM_SMALL_PRIME = 7;
int RANDOM_PRIME = 31;
str SIMILAR_HASH = "X";
int RANDOM_LARGE_PRIME1 = 1231;
int RANDOM_LARGE_PRIME2 = 1237;

public Hash getFingerprint(set[node] trees) = { getHash(tree) | tree <- trees };
public Hash getFingerprint(node tree) {
    return getHash(tree);
}

Hash getHash(str s) = (RANDOM_SMALL_PRIME | it * RANDOM_PRIME + charAt(s, i) | i <- [0..size(s)]);
Hash getHash(int n) = (n*2654435761) % pow(2, 32);
Hash getHash(bool b) = b ? RANDOM_LARGE_PRIME1 : RANDOM_LARGE_PRIME2;

// Get the string of the node and hash it.
default Hash getHash(node n) = getHash(itoString(n));