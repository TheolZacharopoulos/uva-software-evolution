module Metrics::Ranking::UnitSizeRanking

import Metrics::Ranking::AbstractRanking;
import Metrics::Risk::AbstractRisk;
import Metrics::Ranking::DefaultRiskRankThresholds;

private RiskSchema riskRankDefinition = getDefaultRiskRankThresholds();

public Rank getUnitSizeRank(RiskPercentageMap riskMap) = getRankFromRisk(riskMap, riskRankDefinition);