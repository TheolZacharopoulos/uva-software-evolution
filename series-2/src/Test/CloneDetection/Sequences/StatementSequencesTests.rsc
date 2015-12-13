module Test::CloneDetection::Sequences::StatementSequencesTests

import CloneDetection::Sequences::StatementSequences;
import Test::CloneDetection::Provider::SequencesProvider;

test bool getLargestSequenceSizeZero() = getLargestSequenceSize([]) == 0;

test bool getLargestSequenceSize() = getLargestSequenceSize(getTestSequencesOne()) == 4;