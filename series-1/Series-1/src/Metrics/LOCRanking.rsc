module Metrics::LOCRanking

import List;

data Rank = VeryLow()
         | Low()
         | Medium()
         | High()
         | VeryHigh();

alias RankRange = tuple[int bottom, int top];
alias RankDefinition = map[Rank, RankRange];

public Rank getRank(int \value, RankDefinition definition)
{
    for (rank <- sort([r | r <- definition])) {
        rankRange = definition[rank];
        if (\value in [rankRange.bottom .. rankRange.top]) {
            return rank;
        }
    }
    return VeryLow();
}