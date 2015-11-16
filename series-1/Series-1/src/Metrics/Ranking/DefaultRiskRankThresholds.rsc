module Metrics::Ranking::DefaultRiskRankThresholds

import Metrics::Ranking::AbstractRanking;
import Metrics::Risk::AbstractRisk;

public RiskSchema getDefaultRiskRankThresholds()
{
    return (
        VeryHigh(): (
            Moderate(): 25,
            Complex(): 0,
            Untestable(): 0
        ),
        High(): (
            Moderate(): 30,
            Complex(): 5,
            Untestable(): 0
        ),
        Medium(): (
            Moderate(): 40,
            Complex(): 10,
            Untestable(): 0
        ),
        Low(): (
            Moderate(): 50,
            Complex(): 15,
            Untestable(): 5
        )
    );
}