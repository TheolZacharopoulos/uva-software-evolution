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

map[Characteristic, real] getTotalScores(MetricRanking metricRanking) {
    map[Characteristic, StarNumber] totalScore = ();
    map[Characteristic, real] totalScoreAvg = ();
    
    scoresPerMetric = for (metric <- metricRanking) append(getStarsForMetric(metric, metricRanking[metric]));
   
    map[Characteristic, int] characteristicsCounter = ();
    for (scorePerMetric <- scoresPerMetric) {
        for (characteristic <- scorePerMetric) {
            totalScore[characteristic] ? 0 += scorePerMetric[characteristic];
            characteristicsCounter[characteristic] ? 0 += 1;
        }
    }
    
    for (characteristic <- totalScore) {
         totalScoreAvg[characteristic] = 
                toReal(totalScore[characteristic]) / toReal(characteristicsCounter[characteristic]);
    }
    
    return totalScoreAvg;
}

Rank getOverallMaintainability(MetricRanking metricRanking) {
    map[Characteristic, real] totalScores = getTotalScores(metricRanking);
    real overallScore = toReal( toReal(sum(range(totalScores))) / toReal(size(totalScores)));
    return rankifyStar(round(overallScore));
}

public void displayScores(MetricRanking metricRanking) {
    map[Characteristic, real] totalScore = getTotalScores(metricRanking);
    
    for (metric <- metricRanking) {
        print("* <metric> : <stringifyRank(metricRanking[metric])> <for (char <- MetricCharMap[metric]) {> 
                    '\t @ <char> : <stringifyRank(rankifyStar(getStarsForMetric(metric, metricRanking[metric])[char]))> <}>
               '\n");
    }
    
    println("==================================");
    println("Characteristics Overview:");
    println("==================================");
    for (char <- totalScore) println("<char> : <stringifyRank(rankifyStar(round(totalScore[char])))>");
    println("==================================");
    println("Overall Maintainability: <stringifyRank(getOverallMaintainability(metricRanking))>");
    println("==================================");
}