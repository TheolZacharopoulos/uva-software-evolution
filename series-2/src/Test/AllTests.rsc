module Test::AllTests

extend Test::CloneDetection::ClonePairsTests;
extend Test::CloneDetection::Sequences::SequenceBucketTests;
extend Test::CloneDetection::Sequences::StatementSequencesTests;
extend Test::CloneDetection::Sequences::SubsequencesExtractorTests;
extend Test::CloneDetection::Utils::ASTUnifierTests;
extend Test::CloneDetection::Utils::ClonesGeneralizeTests;
extend Test::CloneDetection::SequenceClonesDetectorTests;
extend Test::CloneDetection::Strategy::TypeOneTests;
extend Test::CloneDetection::Strategy::TypeTwoTests;
extend Test::CloneDetection::StrategyAggregateTests;
extend Test::CloneDetection::SequenceClonesDetectorWithGapsTests;
