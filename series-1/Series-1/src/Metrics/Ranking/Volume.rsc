module Metrics::Ranking::Volume

import Metrics::Volume;
import Metrics::Ranking;

private RankDefinition definition = (
    VeryHigh(): <0, 66>,
    High(): <66, 246>,
    Medium(): <246, 665>,
    Low(): <655, 1310>
);

Rank getVolumeRank(int linesOfCode) = getRank(linesOfCode, definition);