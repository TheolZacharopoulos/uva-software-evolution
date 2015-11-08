module Metrics::AbstractMetricMapping

import Exception;
import IO;

alias range = tuple[int bottom, int top];

private &Entity findInMapUsingRange(int \value, map[&Entity, range] definition, &Entity defaultValue, int minRange) throws IllegalArgument {
    
    if (\value < minRange) {
        throw IllegalArgument("Value minimum range is <minRange>");
    }
    
    for (entity <- definition, \value in [definition[entity].bottom .. definition[entity].top + 1]) {
        return entity;
    }
    
    return defaultValue;
}