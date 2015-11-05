module Metrics::Risk::AbstractRisk

extend Metrics::AbstractMetricMapping;
import List;
import Exception;

data Risk = Simple()
         | Moderate()
         | Complex()
         | Untestable();

alias RiskDefinition = map[Risk, range];

public Risk getRisk(int \value, RiskDefinition definition) throws IllegalArgument {
    return findInMapUsingRange(\value, definition, Untestable(), 1);
}

public str stringifyRisk(Risk r) {
    return (
        Simple(): "simple, without much risk",
        Moderate(): "more complex, moderate risk",
        Complex(): "complex, high risk",
        Untestable(): "untestable, very high risk"
    )[r];
}