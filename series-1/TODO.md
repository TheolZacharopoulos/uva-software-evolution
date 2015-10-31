# TODO

## Calculate the metrics
Include motivation, calculate the actual metric value, each metric gets a score based on the SIG model (--, -, o, +, ++)

- Volume
  - Lines of source code (no comments, no blank lines)
  - Manyears according to the table.
  - Functional Size(tables, fields,screens, input fields, logical & physical files)
- Unit Size & risk profile
  - The size of the units in lines of code (methods).
- Unit Complexity & risk profile
  - Cyclomatic complexity per unit + Risk Evaluation.
  - Other complexity measures: Fan-in, fan-out,coupling, stability measures.
- Duplication
  - Duplication blocks over 6 lines. (the percentage of the code that occurs more than once in equal code blocks of at least 6 lines.)
- Test Quality (Bonus)
  - Unit test coverage, according to the given table.
  - Number of assert statements.
- Stability maintainability (Bonus)
- Extras, such as: Unit Interfacing "parameters number"(!!!), Component Coupling, Module Coupling

## Calcuate scores, include good motivation
- Maintainability (overall),
- Analysability,
- Changeability,
- Testability.

## More
- Give explanation and motivation
- Prove correctness
- Include unit tests
