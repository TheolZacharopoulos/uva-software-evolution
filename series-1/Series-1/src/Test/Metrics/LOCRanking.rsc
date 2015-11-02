module Test::Metrics::LOCRanking

import Metrics::LOCRanking;

public test bool shouldGetRankFromInt()
{
    int exampleNumber = 70;
    
    RankDefinition exampleDefinition = (
        VeryHigh(): <0, 66>,
        High(): <66, 246>,
        Medium(): <246, 665>,
        Low(): <655, 1310>
    );

    Rank rank = getRank(exampleNumber, exampleDefinition);
    return rank == High();
}