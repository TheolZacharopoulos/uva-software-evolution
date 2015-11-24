module Test::CloneDetection::Utils::Sequences::SubsequencesExtractorTests

import CloneDetection::Utils::Sequences::SubsequencesExtractor;
import Test::CloneDetection::Utils::TestTreeProvider;

import lang::java::jdt::m3::AST;

test bool testGetSubSequences() {
    sequence = [
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
    
    subSequences = getSubSequences(sequence, 2);
    
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