module Metrics::Java::LOCRanking

alias Rank = str;
alias RankRange = tuple[int, int];

map[Rank, RankRange] ranks = (); 
