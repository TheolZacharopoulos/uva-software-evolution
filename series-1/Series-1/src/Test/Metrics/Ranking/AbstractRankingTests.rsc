module Test::Metrics::Ranking::AbstractRankingTests

import Metrics::Ranking::AbstractRanking;
import Exception;
import Type;

private RankDefinition exampleDefinition = (
    VeryHigh(): <0, 65>,
    High(): <66, 245>,
    Medium(): <246, 664>,
    Low(): <655, 1310>
);

public test bool shouldGetVeryHighRank() {
    int exampleNumber = 5;

    Rank rank = getRank(exampleNumber, exampleDefinition);
    return rank == VeryHigh();
}

public test bool shouldGetHighRank() {
    int exampleNumber = 70;

    Rank rank = getRank(exampleNumber, exampleDefinition);
    return rank == High();
}

public test bool shouldGetMediumRank() {
    int exampleNumber = 250;

    Rank rank = getRank(exampleNumber, exampleDefinition);
    return rank == Medium();
}

public test bool shouldGetLowRank() {
    int exampleNumber = 700;

    Rank rank = getRank(exampleNumber, exampleDefinition);
    return rank == Low();
}

public test bool shouldGetVeryLowRank() {
    int exampleNumber = 2000;

    Rank rank = getRank(exampleNumber, exampleDefinition);
    return rank == VeryLow();
}

public test bool shouldThrowExceptionOnNegativeValue()
{
    int exampleNumber = -1;
    
    try getRank(exampleNumber, exampleDefinition);
    catch: return true;
    
    return false;
}

public test bool shouldStringifyRank() = typeOf(stringifyRank(VeryHigh())) == \str();