module Configurations

// some hardcoded project locations.
private loc demoProjectLocation     = |project://demo_project|;
private loc smallSqlProjectLocation = |project://smallsql0.21_src|;
private loc hsqlProjectLocation     = |project://hsqldb_src|;

/**
 * Get a project location.
 * @return a project location.
 */
public loc getProjectLocation() = hsqlProjectLocation;

/**
 * Get test project location.
 * @return a project location.
 */
public loc getTestProjectLocation() = demoProjectLocation;


/**
 * Get the duplication threshold.
 * @return the duplication threshold.
 */
public int getDuplicationThreshold() = 6;

public bool getVerboseLog() = true;

public set[loc] getTestFrameWorksBaseClasses() = {
    |java+class:///junit/framework/TestCase|    // JUnit Test Framework.
};