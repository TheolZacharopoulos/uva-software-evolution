module Metrics::Ranking

extend Metrics::AbstractMetricMapping;

import List;
import Exception;

data Rank = VeryLow()
         | Low()
         | Medium()
         | High()
         | VeryHigh();

alias RankDefinition = map[Rank, range];

public Rank getRank(int \value, RankDefinition definition) throws IllegalArgument {
    return findInMapUsingRange(\value, definition, VeryLow(), 0);
}

public str stringifyRank(Rank r) {
    map[Rank, str] rankToStringMap = (
        VeryHigh(): "++",
        High(): "+",
        Medium(): "o",
        Low(): "-",
        VeryLow(): "--"
    );
    
    return rankToStringMap[r];
}