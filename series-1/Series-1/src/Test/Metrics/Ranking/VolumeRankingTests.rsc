module Test::Metrics::Ranking::VolumeRankingTests

import Metrics::Volume;
import Metrics::Ranking::AbstractRanking;
import Metrics::Ranking::VolumeRanking;

test bool rankDefinition_VH_D() = getVolumeRank(0) == VeryHigh();
test bool rankDefinition_VH_U() = getVolumeRank(65999) == VeryHigh();

test bool rankDefinition_H_D() = getVolumeRank(66000) == High();
test bool rankDefinition_H_U() = getVolumeRank(245999) == High();

test bool rankDefinition_M_D() = getVolumeRank(246000) == Medium();
test bool rankDefinition_M_U() = getVolumeRank(654999) == Medium();

test bool rankDefinition_L_D() = getVolumeRank(655000) == Low();
test bool rankDefinition_L_U() = getVolumeRank(1310000) == Low();

test bool rankDefinition_VL() = getVolumeRank(2000000) == VeryLow();