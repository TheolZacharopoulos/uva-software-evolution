module CloneDetection::CloneDetector

import Configurations;
import CloneDetection::Utils::TreeMass;
import CloneDetection::Utils::TreeSimilarity;

import Prelude;
import lang::java::jdt::m3::AST;

// TODO Of course I'll change it, chill... just testing here
void detectClones(set[Declaration] complicationUnits) {

    bucket = [];
    
    // \part@src does not work on each node, that's why I specify possibilities
    bottom-up visit (complicationUnits) {
        case Statement \part: {
            if (getTreeMass(\part) >= TREE_MASS_THRESHOLD && \part@src?) {
                bucket += \part;
            }
        }
    }
    
    for (origin <- bucket, clone <- bucket, origin != clone) {
        if (getSimilarityFactor(clone, origin) > SIMILARITY_THRESHOLD) {
                println("Found clone:");
                println(origin@src);
                println(clone@src);
                println(readFile(origin@src));
                println("*********************************");
        }
    }
}