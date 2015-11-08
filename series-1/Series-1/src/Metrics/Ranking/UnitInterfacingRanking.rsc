module Metrics::Ranking::UnitInterfacingRanking

import Metrics::Ranking::AbstractRanking;
import Metrics::Risk::AbstractRisk;
import Metrics::Ranking::DefaultRiskRankThresholds;

private RiskSchema riskRankDefinition = getDefaultRiskRankThresholds();

public Rank getUnitInterfacingRank(RiskPercentageMap riskMap) = getRankFromRisk(riskMap, riskRankDefinition);