module Metrics::Ranking::Complexity

import Metrics::Ranking::AbstractRanking;
import Metrics::Risk::AbstractRisk;
import Metrics::Risk::Complexity;
import Metrics::Complexity;
import Metrics::LinesOfCode;
import Map;
import List;
import util::Math;
import IO;

alias RiskPercentageMap = map[Risk, real];
alias RiskSchema = map[Rank, map[Risk, range]];

public RiskPercentageMap getRiskPercentageMap(MethodComplexityMap complexityMap) {
    int overallLOC = sum([countLinesOfCode(method)| method <- domain(complexityMap)]);
    
    map[Risk, int] methodRiskLOCMap = ();
    
    for (method <- [r | r <- complexityMap]) {
        risk = getCyclomaticComplexityRisk(complexityMap[method]);
        linesOfCodeForMethod = countLinesOfCode(method);
        methodRiskLOCMap[risk] ? 0 += linesOfCodeForMethod;
    }
    
    RiskPercentageMap methodRiskPercentageMap = (
        Simple(): 0.0,
        Moderate(): 0.0,
        Complex(): 0.0,
        Unstable(): 0.0
    );
    
    for (risk <- [r | r <- methodRiskLOCMap]) {
        methodRiskPercentageMap[risk] = (toReal(methodRiskLOCMap[risk]) / toReal(overallLOC)) * 100;
    }
    
    return methodRiskPercentageMap;
}

private RiskSchema riskRankDefinition = (
    VeryHigh(): (
        Moderate(): <0, 24>,
        Complex(): <0, 0>,
        Unstable(): <0, 0>
    ),
    High(): (
        Moderate(): <0, 29>,
        Complex(): <0, 4>,
        Unstable(): <0, 0>
    ),
    Medium(): (
        Moderate(): <0, 39>,
        Complex(): <0, 9>,
        Unstable(): <0, 0>
    ),
    Low(): (
        Moderate(): <0, 49>,
        Complex(): <0, 14>,
        Unstable(): <0, 4>
    )
);

public Rank getComplexityRank(RiskPercentageMap riskMap)
{
    for (rank <- [r | r <- [VeryHigh(), High(), Medium(), Low()]]) {
        riskRangesMap = riskRankDefinition[rank];
        
        hasMatch = true;
        
        for (risk <- [r | r <- riskRangesMap]) {
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
