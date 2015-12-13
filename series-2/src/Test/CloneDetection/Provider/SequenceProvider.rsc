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
          [stringLiteral("\"5\"")]))[@uniqueKey=3],
      declarationStatement(variables(
            \int(),
            [variable(
                "blablabla",
                0,
                number("123"))])[@uniqueKey=41])[@uniqueKey=42]
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
          [stringLiteral("\"5\"")]))[@uniqueKey=6],
      declarationStatement(variables(
            \int(),
            [variable(
                "blablabla",
                0,
                number("123"))])[@uniqueKey=44])[@uniqueKey=45]
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
          [stringLiteral("\"5\"")]))[@uniqueKey=9],
      \if(
      infix(
        simpleName("blablabla"),
        "\>",
        \number("240")),
      block([
          declarationStatement(variables(
                \int(),
                [variable(
                    "blablabla",
                    0,
                    number("123"))])[@uniqueKey=29])[@uniqueKey=28]
        ])[@uniqueKey=27],
      block([
          declarationStatement(variables(
                \int(),
                [variable(
                    "blablabla",
                    0,
                    number("123"))])[@uniqueKey=24])[@uniqueKey=25]
        ])[@uniqueKey=26])[@uniqueKey=23]
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
          [stringLiteral("\"5\"")]))[@uniqueKey=12],
      \if(
      infix(
        simpleName("blablabla"),
        "\>",
        \number("240")),
      block([
          declarationStatement(variables(
                \int(),
                [variable(
                    "blablabla",
                    0,
                    number("123"))])[@uniqueKey=32])[@uniqueKey=33]
        ])[@uniqueKey=34],
      block([
          declarationStatement(variables(
                \int(),
                [variable(
                    "blablabla",
                    0,
                    number("123"))])[@uniqueKey=36])[@uniqueKey=37]
        ])[@uniqueKey=38])[@uniqueKey=39]
    ];
}