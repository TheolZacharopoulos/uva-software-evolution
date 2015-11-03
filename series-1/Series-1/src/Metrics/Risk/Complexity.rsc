module Metrics::Risk::Complexity

import Metrics::Risk;
import Metrics::Complexity;

private RiskDefinition definition = (
    Simple(): <1, 10>,
    Moderate(): <11, 20>,
    Complex(): <21, 50>
);

Risk getCyclomaticComplexityRisk(CyclomaticComplexity cc) = getRisk(cc, definition);