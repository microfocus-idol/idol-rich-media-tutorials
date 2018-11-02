#!/usr/bin/env bash

# ===========================================================================
# IDOL service uninstaller
# ===========================================================================

# ---------------------------------------------------------------------------
# Variables
# ---------------------------------------------------------------------------

COMPONENTS=( "LicenseServer" "MediaServer" )

VERSION="12.1.0"
INSTALL_BASE="~"

INSTALL_DIR=$INSTALL_BASE"/IDOLServer-"$VERSION

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
for i in "${COMPONENTS[@]}"; do
	echo ""
	echo Uninstalling $i component...

	pushd $INSTALL_DIR"/"$i
	source stop-$(echo "$i" | awk '{print tolower($0)}').sh &
	wait
	popd

done

rm -rf $INSTALL_DIR

echo Uninstall complete.
