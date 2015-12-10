module Test::CloneDetection::Provider::SequenceProvider

import lang::java::m3::AST;

anno int node @ uniqueKey;

list[Statement] getTestSequenceOne() {
    return [
      expressionStatement(methodCall(
          false,
          qualifiedName(
            simpleName("System"),
            simpleName("out")),
          "print",
          [stringLiteral("\"1\"")]))[@uniqueKey=1],
      expressionStatement(methodCall(
          false,
          qualifiedName(
            simpleName("System"),
            simpleName("out")),
          "print",
          [stringLiteral("\"2\"")]))[@uniqueKey=2],
      expressionStatement(methodCall(
          false,
          qualifiedName(
            simpleName("System"),
            simpleName("out")),
          "print",
          [stringLiteral("\"5\"")]))[@uniqueKey=3]
    ];
}

list[Statement] getTestSequenceOneExactClone() {
    return [
      expressionStatement(methodCall(
          false,
          qualifiedName(
            simpleName("System"),
            simpleName("out")),
          "print",
          [stringLiteral("\"1\"")]))[@uniqueKey=4],
      expressionStatement(methodCall(
          false,
          qualifiedName(
            simpleName("System"),
            simpleName("out")),
          "print",
          [stringLiteral("\"2\"")]))[@uniqueKey=5],
      expressionStatement(methodCall(
          false,
          qualifiedName(
            simpleName("System"),
            simpleName("out")),
          "print",
          [stringLiteral("\"5\"")]))[@uniqueKey=6]
    ];
}

list[Statement] getTestSequenceTwo() {
    return [
      expressionStatement(methodCall(
          false,
          qualifiedName(
            simpleName("System"),
            simpleName("out")),
          "print",
          [stringLiteral("\"1\"")]))[@uniqueKey=7],
      expressionStatement(methodCall(
          false,
          qualifiedName(
            simpleName("System"),
            simpleName("out")),
          "print",
          [stringLiteral("\"2\"")]))[@uniqueKey=8],
      expressionStatement(methodCall(
          false,
          qualifiedName(
            simpleName("System"),
            simpleName("out")),
          "print",
          [stringLiteral("\"5\"")]))[@uniqueKey=9]
    ];
}

list[Statement] getTestSequenceTwoExactClone() {
    return [
      expressionStatement(methodCall(
          false,
          qualifiedName(
            simpleName("System"),
            simpleName("out")),
          "print",
          [stringLiteral("\"1\"")]))[@uniqueKey=10],
      expressionStatement(methodCall(
          false,
          qualifiedName(
            simpleName("System"),
            simpleName("out")),
          "print",
          [stringLiteral("\"2\"")]))[@uniqueKey=11],
      expressionStatement(methodCall(
          false,
          qualifiedName(
            simpleName("System"),
            simpleName("out")),
          "print",
          [stringLiteral("\"5\"")]))[@uniqueKey=12]
    ];
}