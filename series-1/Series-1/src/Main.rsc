module Main

import IO;
import util::Math;

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;

import Configurations;

import Metrics::Volume;
import Metrics::UnitSize;
import Metrics::Complexity;
import Metrics::Duplication;
import Metrics::UnitInterfacing;
import Metrics::TestQuality;

import Metrics::Ranking::AbstractRanking;
import Metrics::Ranking::VolumeRanking;
import Metrics::Ranking::ComplexityRanking;
import Metrics::Ranking::UnitSizeRanking;
import Metrics::Ranking::DuplicationRanking;

import Metrics::Risk::AbstractRisk;

/**
 * Create a new model from eclipse project.
 * @param eclipseProjectLocation, the location of the eclipse project.
 * @return a model of the project.
 */
M3 getModel(loc eclipseProjectLocation) {
    return createM3FromEclipseProject(eclipseProjectLocation);
}

public void main() {
    loc projectLocation = getProjectLocation();
    M3 model = getModel(projectLocation);
    
    // Volume
    totalLinesOfCode = getLinesTotalOfCode(model);
    println("===================================================");
    println("Calculating the Volume metric");
    iprintln("Total lines of code (LOC): < totalLinesOfCode >");
    iprintln("Lines of code (LOC) rank: < stringifyRank(getVolumeRank(totalLinesOfCode)) >");    
    
    // Complexity
    complexityMap = getComplexity(model);
    RiskPercentageMap ccRiskPercentageMap = getRiskPercentageMap(complexityMap);
    println("===================================================");
    println("Calculating the risk ranking");
    println("Complexity rank is <stringifyRank(getComplexityRank(ccRiskPercentageMap))>");
    println("Complexity risk profile is:");
    iprintln(ccRiskPercentageMap);
    
    // Unit Size
    unitSizeMap = getTotalLinesPerUnit(model);
    RiskPercentageMap usRiskPercentageMap = getRiskPercentageMap(unitSizeMap);
    println("===================================================");
    println("Calculating the Units size metric");
    println("Unit Size rank is <stringifyRank(getUnitSizeRank(usRiskPercentageMap))>");
    println("Unit Size risk profile is:");
    iprintln(usRiskPercentageMap);     
    
    // Duplication
    codeDuplications = detectDuplicates(model);
    println("===================================================");
    println("Calculating the Duplication metric: ");
    println("Code duplications: <codeDuplications>");
    println("Code duplication rank is: <stringifyRank(getDuplicationRank(totalLinesOfCode, codeDuplications))>");
    
    // Unit Interfacing
    println("===================================================");
    println("Calculating the Unit Interfacing metric: ");
    println("Unit Parameters size: ");
    iprintln(getUnitInterfacing(model));
    
    // Tests Quality
    println("===================================================");
    println("Calculating the Test Quality metric: ");
    println("Unit Testing coverage: <getUnitTestingCoverage(model)>%");
}