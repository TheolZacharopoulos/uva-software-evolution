module Metrics::UnitSize

/**
 * To measure unit size, we again use a simple lines of code metric. 
 * The risk categories and scoring guidelines are similar to those for complexity per unit, 
 * except that the particular threshold values are different.
 */

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;

import Metrics::LinesOfCode;

alias UnitSize = int;
alias MethodUnitSizeMap = map[loc, UnitSize];

public MethodUnitSizeMap getTotalLinesPerUnit(M3 model) {
    return (method: countLinesOfCode(method) | method <- methods(model));
}