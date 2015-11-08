module Metrics::Risk::UnitInterfacingRisk

import Metrics::Risk::AbstractRisk;
import Metrics::UnitInterfacing;

private RiskDefinition definition = (
    Simple(): <0, 2>,
    Moderate(): <3, 5>,
    Complex(): <6, 7>
);

Risk getUnitInterfacingRisk(int unitParams) = getRisk(unitParams, definition, 0);