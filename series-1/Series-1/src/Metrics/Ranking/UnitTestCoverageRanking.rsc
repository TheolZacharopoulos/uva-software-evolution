module Metrics::Ranking::UnitTestCoverageRanking

import Metrics::Ranking::AbstractRanking;
import util::Math;

private RankDefinition definition = (
    VeryHigh(): <95, 100>,
    High(): <80, 94>,
    Medium(): <60, 79>,
    Low(): <20, 59>
);

public Rank getUnitTestCoverageRank(real coverage) {
    return getRank(toInt(coverage), definition);
}