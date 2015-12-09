module CloneDetection::Utils::ProgressTracker

import util::Math;
import util::ShellExec;
import IO;

private map[str, tuple[int total, int progress]] trackers = ();
private map[str, int] tickers = ();

private real getPercentage(str key) = (toReal(trackers[key].progress)/trackers[key].total) * 100;

void startProgress(str key, int total) {
    println("Starting <key>...");
    trackers[key] = <total, 0>;
    tickers[key] = 0;
}

void advanceProgress(str key, int step) {
    trackers[key].progress = trackers[key].progress + 1;
    printProgress(key);
}

void endProgress(str key) {
    trackers[key].progress = trackers[key].total;
    printProgress(key);
    println("");
}

void increaseProgressTotal(str key, int amount) {
    trackers[key].total += 1;
    printProgress(key);
}

void indicateProgressWork(str key) {
    printProgress(key);

    switch (tickers[key]) {
        case 1: print("o---------");
        case 2: print("-o--------");
        case 3: print("--o-------");
        case 4: print("---o------");
        case 5: print("----o-----");
        case 6: print("-----o----");
        case 7: print("------o---");
        case 8: print("-------o--");
        case 9: print("--------o-");
        case 10: print("--------o");
        case 11: print("-------o--");
        case 12: print("------o---");
        case 13: print("-----o----");
        case 14: print("----o-----");
        case 15: print("---o------");
        case 16: print("--o-------");
        case 17: print("-o--------");
        case 18: print("o---------");
    }

    tickers[key] = tickers[key] == 18 ? 1 : tickers[key] + 1;
}

private void printProgress(str key) {
    progress = toInt(getPercentage(key));
    
    left = 100 - progress;
    print("\r");
    print("[<for (i <- [0..progress]) {>=<}><if (left > 0) {>\><for (i <- [0..left]) {> <}><}>] <progress>% ");
    print("(<trackers[key].progress>/<trackers[key].total>) ");
}