# Metrics Calculation On Java Projects

## Calculate the metrics
Include motivation, calculate the actual metric value, each metric gets a score based on the SIG model (--, -, o, +, ++)

## Calculate scores for at least the following maintainability aspects based on the SIG model:
- Maintainability (overall),
- Analysability,
- Changeability,
- Testability.

# Metrics
- Volume
  - Lines of source code (no comments, no blank lines)
- Unit Size & risk profile
  - The size of the units in lines of code (methods).
- Unit Complexity & risk profile
  - Cyclomatic complexity per unit + Risk Evaluation.
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

<table border="1" style="width: 629px; height: 170px;"><tbody><tr><td><strong>Condition</strong></td><td style="text-align: right;"><strong>Base grade modification</strong></td></tr><tr><td>The metric value (total LOC) and/or score for Volume deviate without good motivation</td><td style="text-align: right;">-0.5 to -1.0</td></tr><tr><td>The metric value (%) and/or score for Duplication deviate without good motivation</td><td style="text-align: right;">&nbsp;-0.5 to -1.0</td></tr><tr><td>The risk profile and/or score for Unit Size deviate without good motiviation</td><td style="text-align: right;">-0.5 to -1.0</td></tr><tr><td>The risk profile and/or score for Unit Complexity deviate without good motivation</td><td style="text-align: right;">-0.5 to -1.0</td></tr><tr><td>The scores calculated for the maintainability aspects deviate without good motivation</td><td style="text-align: right;">-0.5</td></tr><tr><td>Your tool produces output that allows easy verification of the correctness of the result (metric values, risk profiles, scores, etc. are neatly listed next to each other)</td><td style="text-align: right;">+0.5</td></tr><tr><td>You also implemented Test Quality and Stability and can argue their correctness</td><td style="text-align: right;">&nbsp;+0.5</td></tr><tr><td>Your tool produces correct output for hsqldb within the time span of the grading session (~ 30 minutes), possibly with the clone detection turned off</td><td style="text-align: right;">+0.5</td></tr><tr><td>You can demonstrate that your own code is of high maintainability and has proper automated tests</td><td style="text-align: right;">+0.5</td></tr><tr><td>You have found another metric in the literature that is not in the SIG Maintainability Model, and you can argument why and how would it improve the results</td><td>+0.5 to +1.0</td></tr></tbody></table>
