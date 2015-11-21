@doc{
    A hash function is considered good if it minimizes the probability p 
    of hash value collision for two structurally different subtrees.
}
module CloneDetection::Utils::Fingerprinter

import lang::java::jdt::m3::AST;
import IO;
import List;
import Set;
import String;
import util::Math;

alias Hash = int;

int RANDOM_SMALL_PRIME = 7;
int RANDOM_PRIME = 31;
str SIMILAR_HASH = "X";
int RANDOM_LARGE_PRIME1 = 1231;
int RANDOM_LARGE_PRIME2 = 1237;

public Hash perfectHash(tree) {
    bottom-up visit(tree) {
    
        // Declaration
        case \enum(str name, _, _, _): {
                iprintln("");
            }
        case \enumConstant(str name, _, _): {
                iprintln("");
            }
        case \enumConstant(str name, _): {
                iprintln("");
            }
        case \class(str name, _, _, _): {
                iprintln("");
            }
        case \interface(str name, _, _, _): {
                iprintln("");
            }
        case \method(_, str name, _, _, _): {
                iprintln(getHash(name));
            }
        case \method(_, str name, _, _): {
                iprintln("");
            }
        case \constructor(str name, _, _, _): {
                iprintln("");
            }
        case \import(str name): {
                iprintln("");
            }
        case \package(str name): {
                iprintln("");
            }
        case \package(_, str name): {
                iprintln("");
            }
        case \typeParameter(str name, _): {
                iprintln("");
            }
        case \annotationType(str name, _): {
                iprintln("");
            }
        case \annotationTypeMember(_, str name): {
                iprintln("");
            }
        case \annotationTypeMember(_, str name, _): {
                iprintln("");
            }
        case \parameter(_, str name, _): {
                iprintln("");
            }
        case \vararg(_, str name): {
                iprintln("");
            }
        
        // Expression
        case \arrayAccess(_, _): {
                iprintln("");
            }
        case \newArray(_, _, _): {
                iprintln("");
            }
        case \newArray(_, _): {
                iprintln("");
            }
        case \arrayInitializer(_): {
                iprintln("");
            }
        case \assignment(_, _, _): {
                iprintln("");
            }
        case \cast(_, _): {
                iprintln("");
            }
        case \characterLiteral(str charValue): {
                iprintln(getHash(charValue));
            }
        case \newObject(_, _, _, _): {
                iprintln("");
            }
        case \newObject(_, _, _): {
                iprintln("");
            }
        case \newObject(_, _, _): {
                iprintln("");
            }
        case \newObject(_, _): {
                iprintln("");
            }
        case \qualifiedName(_, _): {
                iprintln("");
            }
        case \conditional(_, _, _): {
                iprintln("");
            }
        case \fieldAccess(_, _, str name): {
                iprintln("");
            }
        case \fieldAccess(_, str name): {
                iprintln("");
            }
        case \instanceof(_, _): {
                iprintln("");
            }
        case \methodCall(_, str name, _): {
                iprintln("");
            }
        case \methodCall(_, _, str name, _): {
                iprintln("");
            }
        case \null(): {
                iprintln("");
            }
        case \number(str numberValue): {
                iprintln(getHash(numberValue));
            }
        case \booleanLiteral(bool boolValue): {
                iprintln(getHash(boolValue));
            }
        case \stringLiteral(str stringValue): {
                iprintln(getHash(stringValue));
            }
        case \type(Type \type): {
                iprintln("");
            }
        case \variable(str name, _): {
                iprintln("");
            }
        case \variable(str name, _, _): {
                iprintln("");
            }
        case \bracket(_): {
                iprintln("");
            }
        case \this(): {
                iprintln("");
            }
        case \this(_): {
                iprintln("");
            }
        case \super(): {
                iprintln("");
            }
        case \declarationExpression(_): {
                iprintln("");
            }
        case \infix(_, str operator, _): {
                iprintln("");
            }
        case \postfix(_, str operator): {
                iprintln("");
            }
        case \prefix(str operator, _): {
                iprintln("");
            }
        case \simpleName(str name): {
                iprintln(getHash(name));
            }
        case \markerAnnotation(str typeName): {
                iprintln(getHash(typeName));
            }
        case \normalAnnotation(str typeName, _): {
                iprintln(getHash(typeName));
            }
        case \memberValuePair(str name, _): {
                iprintln(getHash(name));
            }             
        case \singleMemberAnnotation(str typeName, _): {
                iprintln(getHash(typeName));
            }            
        }
    return 0;
}

Hash getHash(str s) = (RANDOM_SMALL_PRIME | it * RANDOM_PRIME + charAt(s, i) | i <- [0..size(s)]);
Hash getHash(int n) = (n*2654435761) % pow(2, 32);
Hash getHash(bool b) = b ? RANDOM_LARGE_PRIME1 : RANDOM_LARGE_PRIME2;

public Hash degradedHash(tree) {
    return 0;
}