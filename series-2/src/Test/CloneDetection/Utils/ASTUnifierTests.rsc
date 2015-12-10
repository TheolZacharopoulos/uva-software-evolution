module Test::CloneDetection::Utils::ASTUnifierTests

import CloneDetection::Utils::ASTUnifier;
import Test::CloneDetection::Provider::SequenceProvider;
import Prelude;
import lang::java::m3::AST;

test bool testUnifyAST() = unifyAST(getTestSequenceOne()) == [                                                                 
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
      ]
    ];