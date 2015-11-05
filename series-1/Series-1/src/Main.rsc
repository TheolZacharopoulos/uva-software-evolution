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

import Metrics::Ranking::AbstractRanking;
import Metrics::Ranking::VolumeRanking;
import Metrics::Ranking::ComplexityRanking;

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
    RiskPercentageMap riskPercentageMap = getRiskPercentageMap(complexityMap);
    println("===================================================");
    println("Calculating the risk ranking");
    println("Complexity rating is <stringifyRank(getComplexityRank(riskPercentageMap))>");
    
    // Units
    println("===================================================");
    println("Calculating the Units size metric");
    iprintln("Lines of code (LOC) per unit (method): < getTotalLinesPerUnit(model) >"); 
    
    // Duplication
    println("===================================================");
    println("Calculating the Duplication metric: ");
    println("Code duplications: <detectDuplicates(model)>");
    
    // Unit Interfacing
    println("===================================================");
    println("Calculating the Unit Interfacing metric: ");
    iprintln("Unit Parameters size: <getUnitInterfacing(model)>");
}