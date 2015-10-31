module Metrics::MeasuringClasses

// The model is called M3, and its definition is split acros 
// a generic language independent module called Rascal:analysis/m3/Core 
// and a Java specific part called Rascal:lang/java/m3/Core. 
import lang::java::m3::Core;

// Then we import the API for extracting an M3 model from an Eclipse project.
import lang::java::jdt::m3::Core;

import IO;
import List;

// Create a new model from eclipse project.
M3 getModel(loc l) {
    return createM3FromEclipseProject(l);
}

// let's focus on the containment relation. 
// This defines what parts of the source code are parts of which other parts:
rel[loc from, loc to] getContainments(M3 model) {
    return model@containment;
}

// As you can read, classes contain methods, methods contain variables, etc. 
// Classes could also contain other classes (nested classes), 
// and methods can even contain classes (anonymous classes). 
// Let's focus on a specific class, and project what it contains from the relation:
// rascal> myModel@containment[|java+class:///HelloWorld|]

// filter the methods:
// rascal> helloWorldMethods = [ e | e <- myModel@containment[|java+class:///HelloWorld|], e.scheme == "java+method"];

// How many methods does this class contain?
// rascal> size(helloWorldMethods);

// Let's generalize and compute the number of methods for all classes 
// in one big expression. First a function to compute the number for a given class:
int numberOfMethods(loc cl, M3 model) = 
    size([ m | m <- model@containment[cl], isMethod(m)]);

map[loc class, int methodCount] getNumberOfMethodsPerClass(M3 model) {
    // append to map. 
    return (cl:numberOfMethods(cl, model) | <cl,_> <- model@containment, isClass(cl));
}

// Number of fields
int numberOfFields(loc cl, M3 model) = size([ m | m <- model@containment[cl], isField(m)]);

map[loc class, int fieldCount] getNumberOfFieldsPerClass(M3 model) {
    return (cl:numberOfFields(cl, model) | <cl,_> <- model@containment, isClass(cl));
}

// what is the ratio between fields and methods for each class?
map[loc, real] getFieldsMethodsRatio(M3 model) {
    numberOfMethodsPerClass = getNumberOfMethodsPerClass(model);
    numberOfFieldsPerClass  = getNumberOfFieldsPerClass(model);
    
    return (cl : (numberOfFieldsPerClass[cl] * 1.0) / (numberOfMethodsPerClass[cl] * 1.0) | cl <- classes(model));
}

// ====================================
// Methods

// get the methods:
set[loc] getMethods(M3 model) = methods(model);

// The source code of the method:
str getMethodSource(loc method) = readFile(method);

// The number of the words in a method
int numOfWordInMethod(str methodSrc) = (0 | it + 1 | /\W+/ := methodSrc);