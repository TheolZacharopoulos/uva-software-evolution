module CloneDetection::Sequences::StatementSequences

import Configurations;
import CloneDetection::AbstractClonePairs;
import List;
import lang::java::jdt::m3::AST;

anno int node @ uniqueKey;
anno int Statement @ uniqueKey;
anno int Declaration @ uniqueKey;

@doc{
Get all possible sequences from the AST
}
Sequences extractSequencesFromAST(set[Declaration] ast) {
    
    Sequences sequences = [];
    
    bottom-up visit (ast) {
        case list[Statement] sequence: {
            if (size(sequence) >= MINIMUM_SEQUENCE_LENGTH) {
                sequences += [sequence];
            }
        }
    }    
    return sequences;
}

@doc{
Find the size of the largest sequence in the sequences list
}
int getLargestSequenceSize([])  = 0;
int getLargestSequenceSize(Sequences sequences) {
    return max([size(sequence) | sequence <- sequences]);
}