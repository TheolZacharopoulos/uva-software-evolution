module Metrics::Ranking::VolumeRanking

import Metrics::Volume;
import Metrics::Ranking::AbstractRanking;

private RankDefinition definition = (
    VeryHigh(): <0, 65>,
    High(): <66, 245>,
    Medium(): <246, 664>,
    Low(): <655, 1310>
);

Rank getVolumeRank(int linesOfCode) = getRank(linesOfCode, definition);