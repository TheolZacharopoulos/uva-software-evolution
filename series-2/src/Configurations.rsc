module Configurations

// some hardcoded project locations.
private loc demoProjectLocation     = |project://clones_demo|;
private loc smallSqlProjectLocation = |project://smallsql0.21_src|;
private loc hsqlProjectLocation     = |project://hsqldb_src|;

/**
 * Get a project location.
 * @return a project location.
 */
public loc getProjectLocation() = smallSqlProjectLocation;

/**
 * Get test project location.
 * @return a project location.
 */
public loc getTestProjectLocation() = demoProjectLocation;

/**
 * The mass threshold parameter specifies the minimum sub-tree mass (number of nodes) value 
 * to be considered, so that small pieces of code (e.g., expressions) are ignored.
 */
public int TREE_MASS_THRESHOLD = 20;

/**
 * The similarity threshold parameter allows the user to specify
 * how similar two sub-trees should be.
 */
public real SIMILARITY_THRESHOLD = 0.4;