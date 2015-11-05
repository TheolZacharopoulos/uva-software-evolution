module Metrics::Ranking::VolumeRanking

import Metrics::Volume;
import Metrics::Ranking::AbstractRanking;

private RankDefinition definition = (
    VeryHigh(): <0, 65999>,
    High(): <66000, 245999>,
    Medium(): <246000, 664999>,
    Low(): <655000, 1310000>
);

Rank getVolumeRank(int linesOfCode) = getRank(linesOfCode, definition);