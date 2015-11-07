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

// TODO move tests
test bool t1() = getUnitSizeRank( (Moderate():0.0, Complex():0.0, Untestable():0.0) ) == VeryHigh();
test bool t2() = getUnitSizeRank( (Moderate():0.0, Complex():1.0, Untestable():0.0) ) == High();
test bool t3() = getUnitSizeRank( (Moderate():0.0, Complex():0.0, Untestable():1.0) ) == Low();
test bool t4() = getUnitSizeRank( (Moderate():0.0, Complex():6.0, Untestable():0.0) ) == Medium();
test bool t5() = getUnitSizeRank( (Moderate():25.0, Complex():0.0, Untestable():0.0) ) == VeryHigh();
test bool t6() = getUnitSizeRank( (Moderate():26.0, Complex():0.0, Untestable():0.0) ) == High();
test bool t7() = getUnitSizeRank( (Moderate():30.0, Complex():0.0, Untestable():0.0) ) == High();
test bool t8() = getUnitSizeRank( (Moderate():31.0, Complex():0.0, Untestable():0.0) ) == Medium();
test bool t9() = getUnitSizeRank( (Moderate():40.0, Complex():0.0, Untestable():0.0) ) == Medium();
test bool tA() = getUnitSizeRank( (Moderate():41.0, Complex():0.0, Untestable():0.0) ) == Low();
