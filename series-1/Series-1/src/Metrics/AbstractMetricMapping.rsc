module Metrics::AbstractMetricMapping

import Exception;
import IO;

alias range = tuple[int bottom, int top];

private &Entity findInMapUsingRange(int \value, map[&Entity, range] definition, &Entity defaultValue, int minRange) throws IllegalArgument {
    if (\value < minRange) {
        throw IllegalArgument("Value should be a positive number");
    }

    for (entity <- [r | r <- definition]) {
        defRange = definition[entity];
        if (\value in [defRange.bottom .. defRange.top + 1]) {
            return entity;
        }
    }
    
    return defaultValue;
}