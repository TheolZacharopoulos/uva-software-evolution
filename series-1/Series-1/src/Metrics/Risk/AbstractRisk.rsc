module Metrics::Risk::AbstractRisk

extend Metrics::AbstractMetricMapping;
import List;
import Exception;

data Risk = Simple()
         | Moderate()
         | Complex()
         | Unstable();

alias RiskDefinition = map[Risk, range];

public Risk getRisk(int \value, RiskDefinition definition) throws IllegalArgument {
    return findInMapUsingRange(\value, definition, Unstable(), 1);
}

public str stringifyRisk(Risk r) {
    map[Risk, str] RiskToStringMap = (
        Simple(): "simple, without much risk",
        Moderate(): "more complex, moderate risk",
        Complex(): "complex, high risk",
        Unstable(): "untestable, very high risk"
    );
    
    return RiskToStringMap[r];
}