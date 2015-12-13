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

Declaration getTestCompilationUnitThree() {
    list[Declaration] types = [];
    return \compilationUnit(package("ThirdPackage")[@uniqueKey=52], [getTestClassThree()], types)[@uniqueKey=53];
}

Declaration getTestCompilationUnitFour() {
    list[Declaration] types = [];
    return \compilationUnit(package("FourthPackage")[@uniqueKey=54], [getTestClassFour()], types)[@uniqueKey=55];
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

Declaration getTestClassThree() {
    list[Type] extends = [];
    list[Type] implements = [];
    list[Declaration] body = [getTestSequenceParentTwo()];
    return \class("FirstClass", extends, implements, body)[@uniqueKey=46];
}

Declaration getTestClassFour() {
    list[Type] extends = [];
    list[Type] implements = [];
    list[Declaration] body = [getTestSequenceParentThree()];
    return \class("SecondClass", extends, implements, body)[@uniqueKey=47];
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

Declaration getTestSequenceParentTwo() {
    list[Statement] seq = getTestSequenceOne();
    list[Declaration] params = [];
    list[Expression] exceptions = [];
    Type \return = float();
    return method(\return, "method_two", params, exceptions, block(seq)[@uniqueKey=48])[@uniqueKey=49];
}

Declaration getTestSequenceParentThree() {
    list[Statement] seq = getTestSequenceTwo();
    list[Declaration] params = [];
    list[Expression] exceptions = [];
    Type \return = float();
    return method(\return, "method_two", params, exceptions, block(seq)[@uniqueKey=50])[@uniqueKey=51];
}