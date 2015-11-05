module Metrics::Risk::UnitSizeRisk

import Metrics::Risk::AbstractRisk;
import Metrics::UnitSize;

private RiskDefinition definition = (
    Simple(): <1, 20>,
    Moderate(): <21, 50>,
    Complex(): <51, 100>
);

Risk getUnitSizeRisk(int unitSize) = getRisk(unitSize, definition);