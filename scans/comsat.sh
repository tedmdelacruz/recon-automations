#!/bin/bash
# Takes screenshots of webservers 
# and checks for GitHub leaks of selected targets

set -e

source "$HOME/.recon-scripts/includes/init.sh"

if [ -z "$SELECTED_TARGETS"  ]; then
    echo ""
    echo -e "${Red} Target(s) in $TARGETS_DIR must be provided${Reset}"
    exit 0
fi

for target in $SELECTED_TARGETS; do
    target_dir="$TARGETS_DIR/$target"

    nuclei_scan $target_dir
    take_screenshots $target_dir
    notify_general ":satellite: Done running comsat on target: $target"
done
