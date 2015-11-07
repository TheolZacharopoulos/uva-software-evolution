module Metrics::Ranking::AbstractRanking

extend Metrics::AbstractMetricMapping;

import Metrics::Risk::AbstractRisk;
import List;
import Exception;
import Map;
import util::Math;
import IO;

data Rank = VeryLow()
         | Low()
         | Medium()
         | High()
         | VeryHigh();

alias RankDefinition = map[Rank, range];
alias RiskPercentageMap = map[Risk, real];
alias RiskSchema = map[Rank, map[Risk, range]];

public Rank getRank(int \value, RankDefinition definition) throws IllegalArgument {
    return findInMapUsingRange(\value, definition, VeryLow(), 0);
}

public str stringifyRank(Rank r) {
    return (
        VeryHigh(): "++",
        High(): "+",
        Medium(): "o",
        Low(): "-",
        VeryLow(): "--"
    )[r];
}

// TODO: IMPROVE THIS FUNCTION
public Rank getRankFromRisk(RiskPercentageMap riskMap, RiskSchema riskRankDefinition) {
    for (rank <- [VeryHigh(), High(), Medium(), Low()]) {
        riskRangesMap = riskRankDefinition[rank];
        
        hasMatch = true;
        
        for (risk <- riskRangesMap) {
            range \range = riskRangesMap[risk];
            riskPercentage = toInt(riskMap[risk]);
            
            if (riskPercentage notin [\range.bottom .. \range.top + 1]) {
                hasMatch = false;
            }
        }
        
        if (hasMatch) {
            return rank;
        }
    }
    
    return VeryLow();
}