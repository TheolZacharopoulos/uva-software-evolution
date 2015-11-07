module Metrics::Ranking::UnitSizeRanking

import Metrics::Ranking::AbstractRanking;
import Metrics::Risk::AbstractRisk;
import Metrics::Risk::UnitSizeRisk;
import Metrics::UnitSize;
import Metrics::LinesOfCode;
import Map;
import List;
import util::Math;
import IO;

// TODO: Abstract this together with the Complexity Ranking.
public RiskPercentageMap getRiskPercentageMap(MethodUnitSizeMap unitSizeMap) {
    int overallLOC = sum([countLinesOfCode(method)| method <- domain(unitSizeMap)]);
    
    map[Risk, int] methodRiskLOCMap = ();
    
    for (method <- [r | r <- unitSizeMap]) {
        risk = getUnitSizeRisk(unitSizeMap[method]);
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

public Rank getUnitSizeRank(RiskPercentageMap riskMap) = getRankFromRisk(riskMap, riskRankDefinition);