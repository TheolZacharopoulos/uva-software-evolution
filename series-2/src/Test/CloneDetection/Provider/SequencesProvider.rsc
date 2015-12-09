module Test::CloneDetection::Provider::SequencesProvider

import Test::CloneDetection::Provider::SequenceProvider;

list[list[node]] getTestSequencesOne() {
    return [
        getTestSequenceOne(),
        getTestSequenceOneExactClone()
    ];
}