module CloneDetection::Utils::FingerprintCache

anno int node @ uniqueKey;

private map[int, str] cache = ();

void addFingerprintCache(node tree, str fingerprint) {
    cache[tree@uniqueKey] = fingerprint;
}

void clearFingerprintCache() {
    cache = ();
}

bool isFingerprintCached(node tree) = cache[tree@uniqueKey]?;

str getCachedFingerprint(node tree) = cache[tree@uniqueKey];