module Test::Metrics::Ranking::UnitTestCoverageRanking

import Metrics::Ranking::UnitTestCoverageRanking;
import Metrics::Ranking::AbstractRanking;

test bool shouldReturnVeryLow()
{
    return VeryLow() == getUnitTestCoverageRank(10.00);
}

test bool shouldReturnLow()
{
    return Low() == getUnitTestCoverageRank(20.00);
}

test bool shouldReturnMedium()
{
    return Medium() == getUnitTestCoverageRank(60.00);
}

test bool shouldReturnHigh()
{
    return High() == getUnitTestCoverageRank(80.00);
}

test bool shouldReturnVeryHigh()
{
    return VeryHigh() == getUnitTestCoverageRank(95.00);
}