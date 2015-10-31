module Metrics::Volume

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;

import List;

import Metrics::LinesOfCode;

/**
 * Volume: The overall volume of the source code influences the analysability of the system.
 * It is fairly intuitive that the total size of a system should feature heavily
 * in any measure of maintainability. A larger system requires, in general, a larger effort
 * to maintain. In particular, higher volume causes lower analysability (the system is harder to understand).
 */
 
private set[loc] getModelClasses(M3 model) {
    return classes(model);
}

public map[loc, int] getTotalLinesPerModule(M3 model) {
    return (class: countLinesOfCode(class) | class <- getModelClasses(model));
}

public int getLinesTotalOfCode(M3 model) {
    return sum([countLinesOfCode(class) | class <- getModelClasses(model)]);
}