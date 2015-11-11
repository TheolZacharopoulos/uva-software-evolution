module Scores

import Metrics::Ranking::AbstractRanking;
import IO;
import Map;
import Set;
import util::Math;

data Metric = Volume() 
            | ComplexityPerUnit() 
            | Duplication() 
            | UnitSize() 
            | UnitInterfacing()
            | UnitTesting()
            ;

data Characteristic = Analysability()
                    | Changeability()
                    | Stability()
                    | Testability()
                    ;

alias MetricCharacteristicsMapping = map[Metric, list[Characteristic]];

public MetricCharacteristicsMapping MetricCharMap = (
    Volume(): [Analysability()],
    ComplexityPerUnit(): [Changeability(), Testability()],
    Duplication(): [Analysability(), Changeability()],
    UnitSize(): [Analysability(), Testability()],
    UnitInterfacing(): [Analysability(), Changeability()],
    UnitTesting(): [Analysability(), Stability(), Testability()]
);

map[Characteristic, StarNumber] getStarsForMetric(Metric metric, Rank metricRank) {
    return (characteritic:starNum |
                characteritic <- MetricCharMap[metric], 
                starNum := starifyRank(metricRank));
}

alias MetricRanking = map[Metric, Rank];

map[Characteristic, StarNumber] getTotalScores(MetricRanking metricRanking) {
    map[Characteristic, StarNumber] totalScore = ();
    
    scoresPerMetric = for (metric <- metricRanking) append(getStarsForMetric(metric, metricRanking[metric]));
   
    map[Characteristic, int] characteristicsCounter = ();
    for (scorePerMetric <- scoresPerMetric) {
        for (characteristic <- scorePerMetric) {
            totalScore[characteristic] ? 0 += scorePerMetric[characteristic];
            characteristicsCounter[characteristic] ? 0 += 1;
        }
    }
    
    for (characteristic <- totalScore) {
         totalScore[characteristic] = totalScore[characteristic] / characteristicsCounter[characteristic];
    }
    
    return totalScore;
}

Rank getOverallMaintainability(MetricRanking metricRanking) {
    map[Characteristic, StarNumber] totalScores = getTotalScores(metricRanking);
    return rankifyStar(sum(range(totalScores)) / size(totalScores));
}

public void displayScores(MetricRanking metricRanking) {
    map[Characteristic, StarNumber] totalScore = getTotalScores(metricRanking);
    
    for (metric <- metricRanking) {
        print("* <metric> : <stringifyRank(metricRanking[metric])> <for (char <- MetricCharMap[metric]) {> 
                    '\t @ <char> : <stringifyRank(rankifyStar(getStarsForMetric(metric, metricRanking[metric])[char]))> <}>
               '\n");
    }
    
    println("==================================");
    println("Characteristics Overview:");
    println("==================================");
    for (char <- totalScore) println("<char> : <stringifyRank(rankifyStar(totalScore[char]))>");
    println("==================================");
    println("Overall Maintainability: <stringifyRank(getOverallMaintainability(metricRanking))>");
    println("==================================");
}