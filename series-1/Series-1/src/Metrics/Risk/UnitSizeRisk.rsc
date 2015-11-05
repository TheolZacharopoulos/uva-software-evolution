module Metrics::Risk::UnitSizeRisk

import Metrics::Risk::AbstractRisk;
import Metrics::UnitSize;

private RiskDefinition definition = (
    Simple(): <1, 15>,
    Moderate(): <15, 30>,
    Complex(): <30, 60>
);

Risk getUnitSizeRisk(int unitSize) = getRisk(unitSize, definition);