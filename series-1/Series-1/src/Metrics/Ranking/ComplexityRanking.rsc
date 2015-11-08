module Metrics::Ranking::ComplexityRanking

import Metrics::Ranking::AbstractRanking;
import Metrics::Risk::AbstractRisk;
import Metrics::Ranking::DefaultRiskRankThresholds;

private RiskSchema riskRankDefinition = getDefaultRiskRankThresholds();

public Rank getComplexityRank(RiskPercentageMap riskMap) = getRankFromRisk(riskMap, riskRankDefinition);
