module Test::Metrics::Ranking::ComplexityRankingTests

import Metrics::Ranking::ComplexityRanking;
import Metrics::Risk::AbstractRisk;
import Metrics::Ranking::AbstractRanking;
import IO;

test bool t1() = getComplexityRank( (Moderate():0.0, Complex():0.0, Untestable():0.0) ) == VeryHigh();
test bool t2() = getComplexityRank( (Moderate():0.0, Complex():1.0, Untestable():0.0) ) == High();
test bool t3() = getComplexityRank( (Moderate():0.0, Complex():0.0, Untestable():1.0) ) == Low();
test bool t4() = getComplexityRank( (Moderate():0.0, Complex():6.0, Untestable():0.0) ) == Medium();
test bool t5() = getComplexityRank( (Moderate():25.0, Complex():0.0, Untestable():0.0) ) == VeryHigh();
test bool t6() = getComplexityRank( (Moderate():26.0, Complex():0.0, Untestable():0.0) ) == High();
test bool t7() = getComplexityRank( (Moderate():30.0, Complex():0.0, Untestable():0.0) ) == High();
test bool t8() = getComplexityRank( (Moderate():31.0, Complex():0.0, Untestable():0.0) ) == Medium();
test bool t9() = getComplexityRank( (Moderate():40.0, Complex():0.0, Untestable():0.0) ) == Medium();
test bool tA() = getComplexityRank( (Moderate():41.0, Complex():0.0, Untestable():0.0) ) == Low();