#!/bin/bash

set -e # exit on failure
set -x # print commands

echo "Starting load_sample_data.sh script"

SAMPLE_DATA_DIR="/workspace/sample_data"

# Ensure the sample data is readable
if [ ! -d "$SAMPLE_DATA_DIR" ] || [ ! -r "$SAMPLE_DATA_DIR" ]; then
    echo "Error: Sample data directory not found or not readable at $SAMPLE_DATA_DIR"
    ls -la /workspace
    exit 1
fi

# Run mongoimport to copy sample data into MongoDB
import_data() {
    local db_name="$1"
    local file="$2"
    local filename=$(basename -- "$file")
    local collection="${filename%.*}"
    
    echo "Importing $filename into database $db_name, collection $collection..."
    if mongoimport --host localhost --db "$db_name" --collection "$collection" --file "$file"; then
        echo "Successfully imported $filename into $db_name.$collection"
    else
        echo "Failed to import $filename into $db_name.$collection"
        return 1
    fi
}

# Run import_data() on each file in the directory
find "$SAMPLE_DATA_DIR" -type d | while read -r dir; do
    # Skip the root sample_data directory
    if [ "$dir" = "$SAMPLE_DATA_DIR" ]; then
        continue
    fi

    # Get the database name from the directory name
    db_name=$(basename "$dir")
    echo "Processing database: $db_name"

    # Import all JSON files in this directory
    for file in "$dir"/*.json; do
        if [ -f "$file" ] && [ -r "$file" ]; then
            import_data "$db_name" "$file" || echo "Error importing $file"
        else
            echo "Warning: File $file not found or not readable"
        fi
    done
done

echo "Sample data import process completed."