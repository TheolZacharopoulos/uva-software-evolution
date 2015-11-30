module Test::CloneDetection::Utils::Sequences::SubsequencesExtractorTests

import CloneDetection::Sequences::SubsequencesExtractor;
import Test::CloneDetection::Utils::TestTreeProvider;

import lang::java::jdt::m3::AST;

test bool testGetSubSequences() {
    testSequence = [
      expressionStatement(methodCall(
          false,
          qualifiedName(
            simpleName("System"),
            simpleName("out")),
          "print",
          [stringLiteral("\"1\"")])),
      expressionStatement(methodCall(
          false,
          qualifiedName(
            simpleName("System"),
            simpleName("out")),
          "print",
          [stringLiteral("\"2\"")])),
      expressionStatement(methodCall(
          false,
          qualifiedName(
            simpleName("System"),
            simpleName("out")),
          "print",
          [stringLiteral("\"3\"")]))
    ];
    
    subSequences = getSubSequences(testSequence, 2);
    return subSequences == [
        [
          expressionStatement(methodCall(
              false,
              qualifiedName(
                simpleName("System"),
                simpleName("out")),
              "print",
              [stringLiteral("\"1\"")])),
          expressionStatement(methodCall(
              false,
              qualifiedName(
                simpleName("System"),
                simpleName("out")),
              "print",
              [stringLiteral("\"2\"")]))
        ],
        [
            expressionStatement(methodCall(
              false,
              qualifiedName(
                simpleName("System"),
                simpleName("out")),
              "print",
              [stringLiteral("\"2\"")])),
            expressionStatement(methodCall(
              false,
              qualifiedName(
                simpleName("System"),
                simpleName("out")),
              "print",
              [stringLiteral("\"3\"")]))
        ]
    ];
}