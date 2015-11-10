module Metrics::Ranking::AbstractRanking

extend Metrics::AbstractMetricMapping;

import Metrics::Risk::AbstractRisk;
import Metrics::LinesOfCode;
import List;
import Exception;
import Map;
import util::Math;
import IO;

data Rank = VeryLow()
          | Low()
          | Medium()
          | High()
          | VeryHigh()
          ;

alias RankDefinition = map[Rank, range];
alias RiskPercentageMap = map[Risk, real];
alias RiskSchema = map[Rank, map[Risk, int]];
alias StarNumber = int;

public Rank getRank(int \value, RankDefinition definition) throws IllegalArgument {
    return findInMapUsingRange(\value, definition, VeryLow(), 0);
}

public Rank rangifyStar(StarNumber stars) {
    // Handle edge cases.
    if (stars > 4) return VeryHigh();
    if (stars < 0) return VeryLow();
     
    return (
        4: VeryHigh(),
        3: High(),
        2: Medium(),
        1: Low(),
        0: VeryLow()
    )[stars];
}

public StarNumber starifyRank(Rank r) {
    return (
        VeryHigh(): 4,
        High(): 3,
        Medium(): 2,
        Low(): 1,
        VeryLow(): 0
    )[r];
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

public Rank getRankFromRisk(RiskPercentageMap riskMap, RiskSchema riskRankDefinition) {
    for (rank <- [VeryHigh(), High(), Medium(), Low()]) {
        riskRangesMap = riskRankDefinition[rank];
        
        hasMatch = true;
        
        for (risk <- riskRangesMap) {
            thresehold = riskRangesMap[risk];
            riskPercentage = toInt(riskMap[risk]);
            
            if (riskPercentage notin [0 .. thresehold + 1]) {
                hasMatch = false;
            }
        }
        
        if (hasMatch) {
            return rank;
        }
    }
    
    return VeryLow();
}


public RiskPercentageMap getRiskPercentageMap(map[loc, int] valuesMap, riskResolver) {
    int overallLOC = sum([countLinesOfCode(method) | method <- domain(valuesMap)]);
    
    map[Risk, int] methodRiskLOCMap = ();
    
    for (method <- [r | r <- valuesMap]) {
        risk = riskResolver(valuesMap[method]);
        linesOfCodeForMethod = countLinesOfCode(method);
        methodRiskLOCMap[risk] ? 0 += linesOfCodeForMethod;
    }
    
    RiskPercentageMap methodRiskPercentageMap = (
        Simple(): 0.0,
        Moderate(): 0.0,
        Complex(): 0.0,
        Untestable(): 0.0
    );
    
    for (risk <- [r | r <- methodRiskLOCMap]) {
        methodRiskPercentageMap[risk] = (toReal(methodRiskLOCMap[risk]) / toReal(overallLOC)) * 100;
    }
    
    return methodRiskPercentageMap;
}
