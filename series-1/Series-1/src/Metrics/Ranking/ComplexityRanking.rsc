module Metrics::Ranking::ComplexityRanking

import Metrics::Ranking::AbstractRanking;
import Metrics::Risk::AbstractRisk;
import Metrics::Risk::ComplexityRisk;
import Metrics::Complexity;
import Metrics::LinesOfCode;
import Map;
import List;
import util::Math;
import IO;

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
        Untestable(): 0.0
    );
    
    for (risk <- [r | r <- methodRiskLOCMap]) {
        methodRiskPercentageMap[risk] = (toReal(methodRiskLOCMap[risk]) / toReal(overallLOC)) * 100;
    }
    
    return methodRiskPercentageMap;
}

public RiskSchema riskRankDefinition = (
    VeryHigh(): (
        Moderate(): <0, 25>,
        Complex(): <0, 0>,
        Untestable(): <0, 0>
    ),
    High(): (
        Moderate(): <0, 30>,
        Complex(): <0, 4>,
        Untestable(): <0, 0>
    ),
    Medium(): (
        Moderate(): <0, 40>,
        Complex(): <0, 10>,
        Untestable(): <0, 0>
    ),
    Low(): (
        Moderate(): <0, 50>,
        Complex(): <0, 15>,
        Untestable(): <0, 5>
    )
);

public Rank getComplexityRank(RiskPercentageMap riskMap) = getRankFromRisk(riskMap, riskRankDefinition);
