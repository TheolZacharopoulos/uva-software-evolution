module Results::ProjectNames

import Exception;
import Configurations;

public str getProjectName(PROJECT_KEY_SMALL_SQL) = "Small SQL";
public str getProjectName(PROJECT_KEY_HSQLDB) = "HyperSQL";
public str getProjectName(PROJECT_KEY_DEMO) = "DEMO";
public default str getProjectName(str project) throws IllegalArgument {
    throw IllegalArgument("Unrecognized project <project>");
}