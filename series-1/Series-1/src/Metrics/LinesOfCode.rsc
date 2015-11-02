module Metrics::LinesOfCode

/**
 * Lines of code: counts all lines of source code that are not comment or blank lines.
 */

import Metrics::Utils::SourceCleaner;

import IO;
import String;
import List;

alias Line = str;

/**
 * Read the source code from a location
 * @param location, the location to read the source from.
 */
private Source getLocationSrc(loc location) {     
    return readFile(location);
}

/**
 * Returns the number of (valid) lines in the specific location.
 * @param location, the location to get the source from
 * @returns the number of valid lines. 
 */
public int countLinesOfCode(loc location) {
    Source originalSource = getLocationSrc(location);
    Source cleanedSource  = cleanSource(originalSource);

    return size([line | line <- split("\n", cleanedSource)]);
}