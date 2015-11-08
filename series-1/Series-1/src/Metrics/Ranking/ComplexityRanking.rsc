module Metrics::Ranking::ComplexityRanking

import Metrics::Ranking::AbstractRanking;
import Metrics::Risk::AbstractRisk;
import Metrics::Risk::ComplexityRisk;
import Metrics::Complexity;
import Metrics::LinesOfCode;
import Metrics::Ranking::DefaultRiskRankThresholds;

import Map;
import List;
import util::Math;

private RiskSchema riskRankDefinition = getDefaultRiskRankThresholds();

public Rank getComplexityRank(RiskPercentageMap riskMap) = getRankFromRisk(riskMap, riskRankDefinition);
