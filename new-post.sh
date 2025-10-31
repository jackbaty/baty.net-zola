#!/bin/bash

# Zola new blog post script
# Creates a new markdown file for blog posts
# This was written entirely using Claude, if that matters to you
# It mimics what I used in Emacs, and is specific to my setup

# Function to convert title to slug (dashed words)
title_to_slug() {
    echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g'
}

# Function to prompt for yes/no
ask_yes_no() {
    while true; do
        read -p "$1 (y/n): " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

# Check for help flag first
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: $0 [OPTIONS] \"Post Title\""
    echo "       $0 [OPTIONS]  (will prompt for title)"
    echo ""
    echo "Options:"
    echo "  -f, --force    Overwrite existing file"
    echo "  -b, --bundle   Create as bundle (directory with index.md)"
    echo "  -s, --single   Create as single file (.md)"
    echo "  -h, --help     Show this help message"
    echo ""
    echo "If neither -b nor -s is specified, you will be prompted to choose."
    exit 0
fi

# Parse command line arguments
FORCE_OVERWRITE=false
BUNDLE_MODE=""
TITLE=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -f|--force)
            FORCE_OVERWRITE=true
            shift
            ;;
        -b|--bundle)
            BUNDLE_MODE="yes"
            shift
            ;;
        -s|--single)
            BUNDLE_MODE="no"
            shift
            ;;
        -*)
            echo "Unknown option $1"
            exit 1
            ;;
        *)
            TITLE="$1"
            shift
            ;;
    esac
done

# Get title if not provided
if [ -z "$TITLE" ]; then
    read -p "Title: " TITLE
fi

# Validate title
if [ -z "$TITLE" ]; then
    echo "Error: Title cannot be empty"
    exit 1
fi

# Get current date components
YEAR=$(date +%Y)
MONTH=$(date +%m)
DATE_PREFIX=$(date +%Y-%m-%d)
ISO_DATE=$(date +"%Y-%m-%d %H:%M:%S%:z")

# Create slug from title
SLUG=$(title_to_slug "$TITLE")

# Construct the directory path
CONTENT_DIR="./content/posts/${YEAR}/${MONTH}"

# Determine if we're making a bundle or single file
if [ -z "$BUNDLE_MODE" ]; then
    if ask_yes_no "Make Bundle?"; then
        BUNDLE_MODE="yes"
    else
        BUNDLE_MODE="no"
    fi
fi

# Set up file path based on bundle choice
if [ "$BUNDLE_MODE" = "yes" ]; then
    # Bundle: create directory with index.md
    POST_DIR="${CONTENT_DIR}/${DATE_PREFIX}-${SLUG}"
    FILE_PATH="${POST_DIR}/index.md"
    mkdir -p "$POST_DIR"
else
    # Single file: create .md file directly
    FILE_PATH="${CONTENT_DIR}/${DATE_PREFIX}-${SLUG}.md"
    mkdir -p "$CONTENT_DIR"
fi

# Check if file exists and handle force flag
if [ -f "$FILE_PATH" ] && [ "$FORCE_OVERWRITE" = false ]; then
    echo "Post already exists: $FILE_PATH"
    echo "Use -f or --force flag to overwrite, or edit the existing file."
    exit 1
fi

# Show overwrite warning if forcing
if [ "$FORCE_OVERWRITE" = true ] && [ -f "$FILE_PATH" ]; then
    echo "Overwriting existing file: $FILE_PATH"
fi

# Create the markdown file with frontmatter
cat > "$FILE_PATH" << EOF
+++
title = "${TITLE}"
date = ${ISO_DATE}
slug = ${SLUG}
[taxonomies]
tags = ["Misc"]
+++

EOF

echo "Created new blog post: $FILE_PATH"

# Optionally open the file in your preferred editor
# Uncomment one of the following lines based on your preference:
# code "$FILE_PATH"        # VS Code
nvim "$FILE_PATH"         # Vim
# nano "$FILE_PATH"        # Nano
# open "$FILE_PATH"        # macOS default app



