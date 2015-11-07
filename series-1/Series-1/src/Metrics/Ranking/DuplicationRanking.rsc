module Metrics::Ranking::DuplicationRanking

import Configurations;
import Metrics::Duplication;
import Metrics::Ranking::AbstractRanking;
import IO;
import util::Math;

private RankDefinition definition = (
    VeryHigh(): <0, 2>,
    High(): <3, 4>,
    Medium(): <5, 9>,
    Low(): <10, 19>
);

Rank getDuplicationRank(int volume, int numberOfDuplicates) {
    duplicationRate = ((toReal(getDuplicationThreshold()) * toReal(numberOfDuplicates))/volume)*100;
    //println("<duplicationRate>%");
    return getRank(toInt(duplicationRate), definition);
}