module Test::CloneDetection::Provider::SequenceParentsProvider

import Test::CloneDetection::Provider::SequenceProvider;
import lang::java::m3::AST;
import Prelude;

anno int node @ uniqueKey;

Declaration getTestCompilationUnitOne() {
    list[Declaration] types = [];
    return \compilationUnit(package("FirstPackage")[@uniqueKey=19], [getTestClassOne()], types)[@uniqueKey=20];
}

Declaration getTestCompilationUnitTwo() {
    list[Declaration] types = [];
    return \compilationUnit(package("SecondPackage")[@uniqueKey=21], [getTestClassTwo()], types)[@uniqueKey=22];
}

Declaration getTestClassOne() {
    list[Type] extends = [];
    list[Type] implements = [];
    list[Declaration] body = [getTestSequenceParentOne()];
    return \class("FirstClass", extends, implements, body)[@uniqueKey=17];
}

Declaration getTestClassTwo() {
    list[Type] extends = [];
    list[Type] implements = [];
    list[Declaration] body = [getTestSequenceParentOneExactClone()];
    return \class("SecondClass", extends, implements, body)[@uniqueKey=18];
}

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