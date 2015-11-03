module Main

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import IO;

import Configurations;
import Metrics::Volume;
import Metrics::UnitSize;
import Metrics::Ranking::AbstractRanking;
import Metrics::Ranking::Volume;

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
    
    totalLinesOfCode = getLinesTotalOfCode(model);
    // Volume
    println("===================================================");
    println("Calculating the Volume metric");
    iprintln("Lines of code (LOC) per module (class): < getTotalLinesPerModule(model) >");
    iprintln("Total lines of code (LOC): < totalLinesOfCode >");
    iprintln("Lines of code (LOC) rank: < stringifyRank(getVolumeRank(totalLinesOfCode)) >");
    
    
    // Units
    println("===================================================");
    println("Calculating the Units size metric");
    iprintln("Lines of code (LOC) per unit (method): < getTotalLinesPerUnit(model) >"); 
      
}