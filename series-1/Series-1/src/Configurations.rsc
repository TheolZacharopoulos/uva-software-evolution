module Configurations

// some hardcoded project locations.
private loc demoProjectLocation     = |project://demo_project|;
private loc smallSqlProjectLocation = |project://smallsql0.21_src|;
private loc hsqlProjectLocation     = |project://hsqldb_src|;

/**
 * Get a project location.
 * @return a project location.
 */
loc getProjectLocation() = demoProjectLocation;

/**
 * Get the duplication threshold.
 * @return the duplication threshold.
 */
int getDuplicationThreshold = 6;