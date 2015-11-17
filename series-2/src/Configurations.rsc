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

public int TREE_MASS_THRESHOLD = 20;
public real SIMILARITY_THRESHOLD = 0.4;