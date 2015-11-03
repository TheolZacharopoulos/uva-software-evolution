module Metrics::Duplication

/**
 * We calculate code duplication as the percentage of all code that 
 * occurs more than once in equal code blocks of at least 6 lines. 
 * When comparing code lines, we ignore leading spaces. 
 * So, if a single line is repeated many times, but the lines before
 * and after differ every time, we do not count it as duplicated. 
 * If however, a group of 6 lines appears unchanged in more than one 
 * place, we count it as duplicated. 
 * Apart from removing leading spaces, the duplication we measure is 
 * an exact string matching duplication.
 */
 
import Configurations;
import Metrics::Utils::SourceCleaner;

int DuplThreshold = getDuplicationThreshold();

