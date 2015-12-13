module Configurations

import Exception;

// some hardcoded project locations.
private loc demoProjectLocation     = |cwd:///../../series-1/system-for-analysis/demo_project/src|;
private loc smallSqlProjectLocation = |cwd:///../../series-1/system-for-analysis/smallsql0.21_src/src|;
private loc hsqlProjectLocation     = |cwd:///../../series-1/system-for-analysis/hsqldb-2.3.1/hsqldb/src|;

public str PROJECT_KEY_SMALL_SQL = "smallsql";
public str PROJECT_KEY_HSQLDB    = "hsqldb";
public str PROJECT_KEY_DEMO    = "demo";

/**
 * Get a project location.
 * @return a project location.
 */
public loc getProjectLocation(PROJECT_KEY_SMALL_SQL) = smallSqlProjectLocation;
public loc getProjectLocation(PROJECT_KEY_DEMO) = demoProjectLocation;
public loc getProjectLocation(PROJECT_KEY_HSQLDB) = hsqlProjectLocation;
public default loc getProjectLocation(str project) throws IllegalArgument {
    throw IllegalArgument("Unrecognized project <project>");
}

/**
 * The mass threshold parameter specifies the minimum sub-tree mass (number of nodes) value 
 * to be considered, so that small pieces of code (e.g., expressions) are ignored.
 */
public int TREE_MASS_THRESHOLD = 0;

/**
 * The minimum number of sequences which will be considered for comparing
 */
public int MINIMUM_SEQUENCE_LENGTH = 5;

/**
 * The minimum number of sequences which will be considered for comparing
 */
public int MAXIMUM_SEQUENCE_GAP = 10;

/**
 * The difference of mass threshold parameter is used in the similarity algorithm.
 * Simply put, when comparing two trees and the difference between their masses is more then 
 * the number in TREE_DIFF_MASS_THRESHOLD the trees will be ignored (e.g. similarity will be forced to 0).
 */
public int TREE_DIFF_MASS_THRESHOLD = 10;

/**
 * The similarity threshold parameter allows the user to specify
 * how similar two sub-trees should be.
 */
public real SIMILARITY_THRESHOLD = 0.8;

/**
 * Path to the output json file
 */
public loc RESULTS_FILE = |cwd:///../src/Visualization/data/results.json|;