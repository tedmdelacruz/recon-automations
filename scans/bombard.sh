#!/bin/bash
# Comprehensive scan against a target
# Includes a nuclei vulnerability scan
# and an XSStrike scan against assets
# Quite noisy, can risk getting IP-blocked by a WAF

set -e

source "$HOME/.recon-scripts/includes/init.sh"

if [ -z "$SELECTED_TARGETS" ]; then
    echo ""
    echo -e "${Red} Target(s) in $TARGETS_DIR must be provided${Reset}"
    exit 0
fi

for target in $SELECTED_TARGETS; do
    target_dir="$TARGETS_DIR/$target"

    dir_brute $target_dir
    xss_basic $target_dir
    xss_advanced $target_dir
    notify_general ":boom: Done running bombardment on target: $target"
    delete_empty_files $target_dir
done
