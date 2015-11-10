module Metrics::TestQuality

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

import IO;
import List;
import Set;
import util::Math;

import Configurations;

private set[loc] getAllTestClasses(M3 model, {})  = {};

private set[loc] getAllTestClasses(M3 model, loc baseClass) = 
    baseClass + getAllTestClasses(model, {from | <from, to> <- model@extends, to == baseClass});

private default set[loc] getAllTestClasses(M3 model, set[loc] baseClasses) {
    list[loc] cls = [*baseClasses];
    return getAllTestClasses(model, head(cls)) + getAllTestClasses(model, toSet(tail(cls)));
}

private bool isTestableMethod(loc method, M3 model) {
    Declaration methodAst = getMethodASTEclipse(method, model=model);
        
    // Match methods with implementation.
    if (\method(_, _, _, _, Statement impl) := methodAst) return true;    
    return false;
}

set[loc] getTestingMethods(M3 model) {
    set[loc] testClasses = getAllTestClasses(model, getTestFrameWorksBaseClasses());    
    return {testMethod | testClass <- testClasses, testMethod <- methods(model, testClass)};
}

set[loc] getNotTestingMethods(M3 model) {
    set[loc] testMethods = getTestingMethods(model);                                    
    return { m | m <- methods(model), m notin testMethods};
}

set[loc] getInvokedMethods(M3 model) {
    set[loc] testClasses = getAllTestClasses(model, getTestFrameWorksBaseClasses());    
    set[loc] testMethods = getTestingMethods(model);

    return {invokedMethod | 
                <methodInvokes, invokedMethod> <- model@methodInvocation,
                methodInvokes in testMethods,   // the method that invokes is a test method
                invokedMethod notin testMethods, // the method that invoked isn't a test method
                invokedMethod in methods(model), // the method that invoked is in the model
                isTestableMethod(invokedMethod, model)}; // the method that invoked is testable;
}

public real getUnitTestingCoverage(M3 model) {
    int allNotTestingMethods = size(getNotTestingMethods(model));
    int invokedFromTestsMethods = size(getInvokedMethods(model));
    
    return ((toReal(invokedFromTestsMethods) / toReal(allNotTestingMethods)) * 100);
}

private int countAssertionsInMethod(loc method, M3 model) {
    Declaration methodAst = getMethodASTEclipse(method, model=model);
    int assertNum = 0;
    
    if (\method(_, _, _, _, Statement impl) := methodAst ||
        \constructor(_, _, _, Statement impl) := methodAst) 
    {   
        visit (impl) {
            case \assert(Expression expression): assertNum += 1;
            case \assert(Expression expression, Expression message): assertNum += 1;
            case \methodCall(bool isSuper, /assert/, list[Expression] arguments): assertNum += 1;
            case \methodCall(bool isSuper, Expression receiver, /assert/, list[Expression] arguments): assertNum += 1;
        }
    }
    return assertNum;
}

public int getAssertionsNumber(M3 model) {
    set[loc] testingMethods = getTestingMethods(model);
    int assertSum = 0;
    for (method <- testingMethods) assertSum += countAssertionsInMethod(method, model);    
    return assertSum;
}