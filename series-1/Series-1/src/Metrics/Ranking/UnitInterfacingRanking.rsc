module Metrics::Ranking::UnitInterfacingRanking

import Metrics::Ranking::AbstractRanking;
import Metrics::Risk::AbstractRisk;
import Metrics::Risk::UnitInterfacingRisk;
import Metrics::UnitInterfacing;
import Metrics::LinesOfCode;
import Metrics::Ranking::DefaultRiskRankThresholds;

import Map;
import List;
import util::Math;

private RiskSchema riskRankDefinition = getDefaultRiskRankThresholds();

public Rank getUnitInterfacingRank(RiskPercentageMap riskMap) = getRankFromRisk(riskMap, riskRankDefinition);