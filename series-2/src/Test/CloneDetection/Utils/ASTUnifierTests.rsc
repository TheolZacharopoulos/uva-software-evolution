module Test::CloneDetection::Utils::ASTUnifierTests

import CloneDetection::Utils::ASTUnifier;
import Test::CloneDetection::Provider::SequenceProvider;
import lang::java::m3::AST;

test bool testUnifyAST() {

    return unifyAST(getTestSequenceOne()) == [
      expressionStatement(methodCall(
          false,
          qualifiedName(
            simpleName("Y"),
            simpleName("Y")),
          "print",
          [stringLiteral("X")]))[
        @uniqueKey=1
      ],
      expressionStatement(methodCall(
          false,
          qualifiedName(
            simpleName("Y"),
            simpleName("Y")),
          "print",
          [stringLiteral("X")]))[
        @uniqueKey=2
      ],
      expressionStatement(methodCall(
          false,
          qualifiedName(
            simpleName("Y"),
            simpleName("Y")),
          "print",
          [stringLiteral("X")]))[
        @uniqueKey=3
      ],
      declarationStatement(variables(
        \int(),
        [variable(
            "Y",
            0,
            number("6"))])[@uniqueKey=41])[@uniqueKey=42]
    ];
}