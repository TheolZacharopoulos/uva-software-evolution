module Metrics::Ranking::UnitSizeRanking

import Metrics::Ranking::AbstractRanking;
import Metrics::Risk::AbstractRisk;
import Metrics::Risk::UnitSizeRisk;
import Metrics::UnitSize;
import Metrics::LinesOfCode;
import Metrics::Ranking::DefaultRiskRankThresholds;

import Map;
import List;
import util::Math;

private RiskSchema riskRankDefinition = getDefaultRiskRankThresholds();

public Rank getUnitSizeRank(RiskPercentageMap riskMap) = getRankFromRisk(riskMap, riskRankDefinition);