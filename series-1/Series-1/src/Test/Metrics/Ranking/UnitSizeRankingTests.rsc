module Test::Metrics::Ranking::UnitSizeRankingTests

import Metrics::Ranking::UnitSizeRanking;
import Metrics::Risk::AbstractRisk;
import Metrics::Ranking::AbstractRanking;

test bool t1() = getUnitSizeRank( (Moderate():0.0, Complex():0.0, Untestable():0.0) ) == VeryHigh();
test bool t2() = getUnitSizeRank( (Moderate():0.0, Complex():1.0, Untestable():0.0) ) == High();
test bool t3() = getUnitSizeRank( (Moderate():0.0, Complex():0.0, Untestable():1.0) ) == Low();
test bool t4() = getUnitSizeRank( (Moderate():0.0, Complex():6.0, Untestable():0.0) ) == Medium();
test bool t5() = getUnitSizeRank( (Moderate():25.0, Complex():0.0, Untestable():0.0) ) == VeryHigh();
test bool t6() = getUnitSizeRank( (Moderate():26.0, Complex():0.0, Untestable():0.0) ) == High();
test bool t7() = getUnitSizeRank( (Moderate():30.0, Complex():0.0, Untestable():0.0) ) == High();
test bool t8() = getUnitSizeRank( (Moderate():31.0, Complex():0.0, Untestable():0.0) ) == Medium();
test bool t9() = getUnitSizeRank( (Moderate():40.0, Complex():0.0, Untestable():0.0) ) == Medium();
test bool tA() = getUnitSizeRank( (Moderate():41.0, Complex():0.0, Untestable():0.0) ) == Low();