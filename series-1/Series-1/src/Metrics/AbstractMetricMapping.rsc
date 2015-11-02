module Metrics::AbstractMetricMapping

import Exception;

alias range = tuple[int top, int bottom];

private &Entity findInMapUsingRange(int \value, map[&Entity, range] definition, &Entity defaultValue, int minRange) throws IlligalArgument
{
    // TODO same here as with ranking...
    if (\value < minRange) {
        throw IllegalArgument("Value should be a positive number");
    }

    for (entity <- [r | r <- definition]) {
        defRange = definition[entity];
        if (\value in [defRange.bottom .. defRange.top]) {
            return entity;
        }
    }
    
    return defaultValue;
}