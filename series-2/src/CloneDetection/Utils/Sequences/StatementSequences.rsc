module CloneDetection::Utils::Sequences::StatementSequences

import Configurations;
import CloneDetection::Utils;

import lang::java::jdt::m3::AST;

alias Sequence = list[Statement];
alias Sequences = list[Sequence];

@doc{
Get all possible sequences from the AST
}
Sequences extractSequencesFromAST(set[Declaration] ast) {
    
    Sequences sequences = [];
    
    bottom-up visit (ast) {
        case Sequence sequence: {
            if (size(sequence) >= MINIMUM_SEQUENCE_LENGTH) {
                sequences += [sequence];
            }
        }
    }
    
    return sequences;
}

@doc{
Extract potentionally cloned sequences from the list of all sequences 
}
Sequences getSequencesContainingClones(Sequences sequences, Clones clones) {

    list[Statement] statements = [];
    
    visit (clones) {
        case Statement statement: {
            statements += statement;
        }
    }

    return [
        sequence | sequence <- sequences, 
        sequenceStatement <- sequence,
        availableStatement <- statements,
        availableStatement@uniqueKey == statement@uniqueKey
    ];
}

@doc{
Find the size of the largest sequence in the sequences list
}
int getLargestSequenceSize(Sequences sequences) {
    return max([size(sequence) | sequence <- sequences]);
}

@doc{
Extracts all unique keys from a sequence
}
list[int] getSequenceUniqueKeys(Sequence sequence) = [statement@uniqueKey | statement <- sequence];