module Test::CloneDetection::Utils::TestTreeProvider

import CloneDetection::Utils::ASTIdentifier;
import lang::java::m3::AST;

data TestTree = TestNodeA(TestTree l, TestTree r) | TestNodeB(int number) | TestNodeC(str text);

int lastUnique = 0;

Statement getTestTreeBig() {
    lastUnique += 100;
    return putIdentifiers(block([
        declarationStatement(variables(
            \int(),
            [variable(
                "blablabla",
                0,
                number("123"))])),
        \if(
          infix(
            simpleName("blablabla"),
            "\>",
            \number("240")),
          block([
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
            ]),
          block([
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
                  [stringLiteral("\"5\"")]))
            ]))
      ]), lastUnique);
}

Statement getTestTreeMedium() {
    lastUnique += 150;
    return putIdentifiers(block([
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
    ]), lastUnique);
}

Statement getTestTreeSmall() { 
    lastUnique += 200;
    return putIdentifiers(expressionStatement(methodCall(
      false,
      qualifiedName(
        simpleName("System"),
        simpleName("out")),
      "print",
      [stringLiteral("\"3\"")])), lastUnique);
}