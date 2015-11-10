module Test::Metrics::Risk::AbstractRiskTests

import Metrics::Risk::AbstractRisk;
import Exception;
import Type;

private RiskDefinition exampleDefinition = (
    Simple(): <1, 10>,
    Moderate(): <11, 20>,
    Complex(): <21, 50>
);

public test bool shouldGetSimpleRisk() {
    int exampleNumber = 5;

    Risk Risk = getRisk(exampleNumber, exampleDefinition, 0);
    return Risk == Simple();
}

public test bool shouldGetModerateRisk() {
    int exampleNumber = 12;

    Risk Risk = getRisk(exampleNumber, exampleDefinition, 0);
    return Risk == Moderate();
}

public test bool shouldGetComplexRisk() {
    int exampleNumber = 22;

    Risk Risk = getRisk(exampleNumber, exampleDefinition, 0);
    return Risk == Complex();
}

public test bool shouldGetUnstableRisk() {
    int exampleNumber = 60;

    Risk Risk = getRisk(exampleNumber, exampleDefinition, 0);
    return Risk == Unstable();
}

public test bool shouldThrowExceptionOnWrongValue() {
    int exampleNumber = 0;
    
    try getRisk(exampleNumber, exampleDefinition, 0);
    catch: return true;
    
    return false;
}

public test bool shouldStringifyRisk() = typeOf(stringifyRisk(Simple())) == \str();