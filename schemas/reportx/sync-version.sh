#!/usr/bin/env bash
# Copy reportx's schemas/ at a given ref into schemas/reportx/<version>/ here.
# Run manually only for breaking-change releases.
# Usage: schemas/reportx/sync-version.sh v0.3.0 [ref]   (ref defaults to v0.3.0)
set -euo pipefail
cd "$(dirname "$0")/../.."

version="${1:?usage: sync-version.sh <version> [ref]}"
ref="${2:-$version}"

git -C .reportx-src fetch --tags -q
mkdir -p "schemas/reportx/$version"
git -C .reportx-src archive "$ref" schemas | tar -x -C "schemas/reportx/$version" --strip-components=1
echo "synced $ref -> schemas/reportx/$version"
