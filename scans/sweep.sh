#!/bin/bash
# Scans all targets in the targets directory

set -e

TARGETS_DIR=$1
if [ ! -d "$TARGETS_DIR" ]; then
    echo "Directory '$TARGETS_DIR' does not exist"
    exit 0
fi

echo "Targets directory: $TARGETS_DIR"
echo "Targets found:"
echo "$(ls $TARGETS_DIR)"

cd $TARGETS_DIR

for target in *; do 
    [[ -d $target ]] || continue

    target_dir="$TARGETS_DIR/$target"
    domains_file="$target_dir/domains.txt"
    while IFS= read -r domain; do
        [[ ! -z $domain ]] || continue
        enumerate_subdomains $domain $target_dir
    done < "$domains_file"

    probe_subdomains $target_dir
    cloud_bucket_enum $target_dir
    crawl_urls $target_dir
    crawl_js $target_dir
    nuclei_scan $target_dir
    take_screenshots $target_dir

    find . -size 0 -delete
done

echo ""
echo "Done."
