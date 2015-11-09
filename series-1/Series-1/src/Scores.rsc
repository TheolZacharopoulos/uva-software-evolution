module Scores

import Metrics::Ranking::AbstractRanking;

data Metric = Volume() | ComplexityPerUnit() | Duplication() | UnitSize() | UnitTesting();

alias Rankings = map[Metric, Rank];

public Rankings 