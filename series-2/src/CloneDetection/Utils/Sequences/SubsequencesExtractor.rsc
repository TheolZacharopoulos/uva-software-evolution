module CloneDetection::Utils::Sequences::SubsequencesExtractor

import CloneDetection::AbstractClonePairs;

import List;
import Exception;

@doc{
Extracts all possible subsequences from a sequence
}
Sequences getSubSequences(Sequence sequence, int length) throws IllegalArgument {
    if (length > size(sequence)) {
        throw IllegalArgument("Length cannot be more than the size of the sequence");
    }
    
    return [
        subSequence | 
        \start <- [0..size(sequence)], 
        subSequence := sequence[\start .. (\start + length)], 
        size(subSequence) == length
    ];
}

@doc{
Shortcut for computing size 1 subsequences
}
Sequences getSubSequences(Sequence sequence, int length) = [sequence] when length == size(sequence);

@doc{
Extract subsequences from list of sequences
}
Sequences getSubSequences(Sequences sequences, int length) {
    return ([] | it + getSubSequences(sequence, length) | sequence <- sequences);
}