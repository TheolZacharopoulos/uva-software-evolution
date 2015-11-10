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
import Metrics::Ranking::UnitTestCoverageRanking;
import Metrics::Ranking::UnitInterfacingRanking;
import Metrics::Ranking::DuplicationRanking;

import Metrics::Risk::AbstractRisk;
import Metrics::Risk::ComplexityRisk;
import Metrics::Risk::UnitSizeRisk;
import Metrics::Risk::UnitInterfacingRisk;

import Scores;

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
    MetricRanking metricRankings = ();
    
    // Volume
    totalLinesOfCode = getLinesTotalOfCode(model);
    Rank volumeRank = getVolumeRank(totalLinesOfCode);
    println("===================================================");
    println("Calculating the Volume metric");
    iprintln("Total lines of code (LOC): < totalLinesOfCode >");
    iprintln("Lines of code (LOC) rank: < stringifyRank(volumeRank) >");    
    metricRankings[Volume()] = volumeRank;
    
    // Complexity
    complexityMap = getComplexity(model);
    RiskPercentageMap ccRiskPercentageMap = getRiskPercentageMap(complexityMap, getCyclomaticComplexityRisk);
    Rank complexityRank = getComplexityRank(ccRiskPercentageMap);
    println("===================================================");
    println("Calculating the risk ranking");
    println("Complexity rank is <stringifyRank(complexityRank)>");
    println("Complexity risk profile is:");
    iprintln(ccRiskPercentageMap);
    metricRankings[ComplexityPerUnit()] = complexityRank;
    
    // Unit Size
    unitSizeMap = getTotalLinesPerUnit(model);
    RiskPercentageMap usRiskPercentageMap = getRiskPercentageMap(unitSizeMap, getUnitSizeRisk);
    Rank unitSizeRank = getUnitSizeRank(usRiskPercentageMap);
    println("===================================================");
    println("Calculating the Units size metric");
    println("Unit Size rank is <stringifyRank(unitSizeRank)>");
    println("Unit Size risk profile is:");
    iprintln(usRiskPercentageMap);
    metricRankings[UnitSize()] = unitSizeRank;
    
    // Duplication
    codeDuplications = detectDuplicates(model);
    Rank duplicationRank = getDuplicationRank(totalLinesOfCode, codeDuplications);
    println("===================================================");
    println("Calculating the Duplication metric: ");
    println("Code duplicates: <codeDuplications>");
    println("Code duplication rank is: <stringifyRank(getDuplicationRank(totalLinesOfCode, codeDuplications))>");
    metricRankings[Duplication()] = duplicationRank;
    
    // Unit Interfacing
    UnitInterfacingMap unitInterfacingMap = getUnitInterfacing(model);
    RiskPercentageMap unitInterRiskPercentageMap = getRiskPercentageMap(unitInterfacingMap, getUnitInterfacingRisk);
    Rank unitInterfacingRank = getUnitInterfacingRank(unitInterRiskPercentageMap);
    println("===================================================");
    println("Calculating the Unit intefacing metric");
    println("Unit Interfacing rank is <stringifyRank(unitInterfacingRank)>");
    println("Unit Interfacing risk profile is:");
    iprintln(unitInterRiskPercentageMap);
    metricRankings[UnitInterfacing()] = unitInterfacingRank;
    
    //// Tests Quality
    //coverage = getUnitTestingCoverage(model);
    //Rank testsQualityRank = getUnitTestCoverageRank(coverage);
    //println("===================================================");
    //println("Calculating the Test Quality metric: ");
    //println("Unit Testing coverage: <coverage> %");
    //println("Assertions number: <getAssertionsNumber(model)>");
    //println("Unit Testing coverage: <getUnitTestCoverageRank(coverage)>");
    //metricRankings[UnitTesting()] = testsQualityRank;
    
    println("===================================================");
    println("===================================================");
    println("Total Scores:");
    displayScores(metricRankings);
}