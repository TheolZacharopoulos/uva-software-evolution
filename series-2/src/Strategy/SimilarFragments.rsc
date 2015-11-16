module Strategy::SimilarFragments

import Strategy::Commons;
import Strategy::ExactFragments;

import lang::java::jdt::m3::AST;

import IO;

private set[Declaration] flattenIdentifiers(set[Declaration] complicationUnits) {
    complicationUnits = visit (complicationUnits) {
        case m:\method(a, _, b, c, d) => \method(a, "SIMILAR", b, c, d)[@src=m@src]
        case c:\constructor(_, a, b, c) => \constructor("SIMILAR", a, b, c)[@src=c@src]
        case p:\parameter(a, _, b) => \parameter(a, "SIMILAR", b)[@src=p@src]
        case v:\variable(_, a) => \variable("SIMILAR", a)[@src=v@src]
        case v:\variable(_, a, b) => \variable("SIMILAR", a, b)[@src=v@src]
        case l:\label(_, body) => \label("SIMILAR", body)[@src=l@src]
        case s:\stringLiteral(_) => \stringLiteral("SIMILAR")[@src=s@src]
        case s:\simpleName(_) => \simpleName("SIMILAR")
    }
    
    return complicationUnits;
}

ClonesSet findSimilarFragments(set[Declaration] complicationUnits) = findExactFragments(flattenIdentifiers(complicationUnits));