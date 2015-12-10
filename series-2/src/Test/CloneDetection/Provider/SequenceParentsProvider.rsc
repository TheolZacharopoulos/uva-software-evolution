module Test::CloneDetection::Provider::SequenceParentsProvider

import Test::CloneDetection::Provider::SequenceProvider;
import lang::java::m3::AST;
import Prelude;

anno int node @ uniqueKey;

Declaration getTestSequenceParentOne() {
    list[Statement] seq = getTestSequenceOne();
    list[Declaration] params = [];
    list[Expression] exceptions = [];
    Type \return = float();
    return method(\return, "method_one", params, exceptions, block(seq)[@uniqueKey=13])[@uniqueKey=14];
}

Declaration getTestSequenceParentOneExactClone() {
    list[Statement] seq = getTestSequenceOneExactClone();
    list[Declaration] params = [];
    list[Expression] exceptions = [];
    Type \return = float();
    return method(\return, "method_one", params, exceptions, block(seq)[@uniqueKey=15])[@uniqueKey=16];
}