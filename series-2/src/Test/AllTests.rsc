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

//extend Test::CloneDetection::Utils::TreeMassTests;
//extend Test::CloneDetection::Utils::TreeSimilarityTests;
//extend Test::CloneDetection::Utils::TreeBucketTests;
//extend Test::CloneDetection::Utils::CloneStatementPairsTests;
//extend Test::CloneDetection::Utils::Sequences::SequenceBucketTests;
//extend Test::CloneDetection::Utils::Sequences::SubsequencesExtractorTests;
