module Metrics::Ranking::UnitSizeRanking

// TODO: ABstract this together with the Complexity Ranking.

import Metrics::Ranking::AbstractRanking;
import Metrics::Risk::AbstractRisk;
import Metrics::Risk::UnitSizeRisk;
import Metrics::UnitSize;
import Metrics::LinesOfCode;
import Map;
import List;
import util::Math;
import IO;

alias RiskPercentageMap = map[Risk, real];
alias RiskSchema = map[Rank, map[Risk, range]];

public RiskPercentageMap getRiskPercentageMap(MethodUnitSizeMap unitSizeMap) {
    int overallLOC = sum([countLinesOfCode(method)| method <- domain(unitSizeMap)]);
    
    map[Risk, int] methodRiskLOCMap = ();
    
    for (method <- [r | r <- complexityMap]) {
        risk = getUnitSizeRisk(complexityMap[method]);
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

public RiskSchema riskRankDefinition = (
    VeryHigh(): (
        Moderate(): <0, 25>,
        Complex(): <0, 0>,
        Unstable(): <0, 0>
    ),
    High(): (
        Moderate(): <0, 30>,
        Complex(): <0, 4>,
        Unstable(): <0, 0>
    ),
    Medium(): (
        Moderate(): <0, 40>,
        Complex(): <0, 10>,
        Unstable(): <0, 0>
    ),
    Low(): (
        Moderate(): <0, 50>,
        Complex(): <0, 15>,
        Unstable(): <0, 5>
    )
);

// TODO IMPROVE THIS FUNCTION
public Rank getUnitSizeRank(RiskPercentageMap riskMap) {
    for (rank <- [VeryHigh(), High(), Medium(), Low()]) {
        riskRangesMap = riskRankDefinition[rank];
        
        hasMatch = true;
        
        for (risk <- riskRangesMap) {
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

// TODO move tests
test bool t1() = getUnitSizeRank( (Moderate():0.0, Complex():0.0, Unstable():0.0) ) == VeryHigh();
test bool t2() = getUnitSizeRank( (Moderate():0.0, Complex():1.0, Unstable():0.0) ) == High();
test bool t3() = getUnitSizeRank( (Moderate():0.0, Complex():0.0, Unstable():1.0) ) == Low();
test bool t4() = getUnitSizeRank( (Moderate():0.0, Complex():6.0, Unstable():0.0) ) == Medium();
test bool t5() = getUnitSizeRank( (Moderate():25.0, Complex():0.0, Unstable():0.0) ) == VeryHigh();
test bool t6() = getUnitSizeRank( (Moderate():26.0, Complex():0.0, Unstable():0.0) ) == High();
test bool t7() = getUnitSizeRank( (Moderate():30.0, Complex():0.0, Unstable():0.0) ) == High();
test bool t8() = getUnitSizeRank( (Moderate():31.0, Complex():0.0, Unstable():0.0) ) == Medium();
test bool t9() = getUnitSizeRank( (Moderate():40.0, Complex():0.0, Unstable():0.0) ) == Medium();
test bool tA() = getUnitSizeRank( (Moderate():41.0, Complex():0.0, Unstable():0.0) ) == Low();