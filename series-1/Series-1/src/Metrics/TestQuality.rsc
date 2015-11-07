module Metrics::TestQuality

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

import IO;
import List;
import Set;

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
        
    // Match methods with implementation, or contructor.
    if (\method(_, _, _, _, Statement impl) := methodAst ||
        \constructor(_, _, _, Statement impl) := methodAst) return true;
    
    return false;
}

// TODO: traverse the AST for method calls 
set[loc invocations] getMethodInvocations(loc method, M3 model) {
    Declaration methodAst = getMethodASTEclipse(method, model=model);
    
    // Match method with implementation, or contructor.
    if (\method(_, _, _, _, Statement impl) := methodAst ||
        \constructor(_, _, _, Statement impl) := methodAst) {
        set[loc] invocations = {};
        
        if (\block(list[Statement] statements) := impl) {
            for (st <- statements) {
                // TODO TRAVERSE for method calls.
                iprintln(st);
            }
        }
        return invocations;
    }
    return {};
}

public set[loc] getInvokedMethods(M3 model) {
    set[loc] testClasses = getAllTestClasses(model, getTestFrameWorksBaseClasses());    
    set[loc] testMethods = {testMethod | 
                                    testClass <- testClasses, 
                                    testMethod <- methods(model, testClass)};
                                    
    // TODO: model@methodInvocation works only for static methods. 
    // getMethodInvocations in progress.
    return {invokedMethod | 
                <methodInvokes, invokedMethod> <- model@methodInvocation,
                methodInvokes in testMethods,   // the method that invokes is a test method
                invokedMethod notin testMethods, // the method that invoked isn't a test method
                invokedMethod in methods(model), // the method that invoked is in the model
                isTestableMethod(invokedMethod, model)}; // the method that invoked is testable;
}

public int getInvokedMethodsNumber(M3 model) = size(getInvokedMethods(model));