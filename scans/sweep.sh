#!/bin/bash
# Scans all targets in the targets directory
# Good for obtaining initial recon against a large number of targets

set -e

source "$HOME/.recon-scripts/includes/start.sh"

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
    take_screenshots $target_dir
done
find . -size 0 -delete
