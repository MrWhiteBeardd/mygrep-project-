#!/bin/bash

# Custom grep implementation with bonus features
VERSION="1.0"
AUTHOR="Your Name"

# Initialize variables
show_line_numbers=false
invert_match=false
search_string=""
file=""
usage_examples_shown=false

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to display version
show_version() {
    echo "mygrep.sh version $VERSION"
    echo "Author: $AUTHOR"
    exit 0
}

# Function to display help with examples
display_help() {
    echo -e "${GREEN}mygrep.sh - Custom grep implementation${NC}"
    echo "Usage: mygrep.sh [OPTIONS] SEARCH_STRING FILE"
    echo ""
    echo -e "${YELLOW}Options:${NC}"
    echo "  -n, --line-number   Show line numbers for each match"
    echo "  -v, --invert-match  Invert match (print non-matching lines)"
    echo "  -h, --help          Display this help message"
    echo "  -V, --version       Display version information"
    echo ""
    echo -e "${YELLOW}Examples:${NC}"
    echo "  ${GREEN}Basic search:${NC}"
    echo "  ./mygrep.sh hello testfile.txt"
    echo ""
    echo "  ${GREEN}Search with line numbers:${NC}"
    echo "  ./mygrep.sh -n hello testfile.txt"
    echo "  ./mygrep.sh --line-number hello testfile.txt"
    echo ""
    echo "  ${GREEN}Inverted match:${NC}"
    echo "  ./mygrep.sh -v hello testfile.txt"
    echo "  ./mygrep.sh --invert-match hello testfile.txt"
    echo ""
    echo "  ${GREEN}Combined options:${NC}"
    echo "  ./mygrep.sh -vn hello testfile.txt"
    echo "  ./mygrep.sh -nv hello testfile.txt"
    exit 0
}

# Parse options using enhanced getopts
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            display_help
            ;;
        -V|--version)
            show_version
            ;;
        -n|--line-number)
            show_line_numbers=true
            shift
            ;;
        -v|--invert-match)
            invert_match=true
            shift
            ;;
        -*)
            # Handle combined short options
            if [[ "$1" =~ -[nv]+ ]]; then
                options="${1#-}"
                [[ "$options" == *n* ]] && show_line_numbers=true
                [[ "$options" == *v* ]] && invert_match=true
                shift
            else
                echo -e "${RED}Error: Unknown option $1${NC}" >&2
                echo "Use --help for usage information" >&2
                exit 1
            fi
            ;;
        *)
            if [[ -z "$search_string" ]]; then
                search_string="$1"
            elif [[ -z "$file" ]]; then
                file="$1"
            else
                echo -e "${RED}Error: Too many arguments${NC}" >&2
                display_help
                exit 1
            fi
            shift
            ;;
    esac
done

# Validate input
if [[ -z "$search_string" ]]; then
    echo -e "${RED}Error: Missing search string${NC}" >&2
    display_help
    exit 1
fi

if [[ -z "$file" ]]; then
    echo -e "${RED}Error: Missing file argument${NC}" >&2
    display_help
    exit 1
fi

if [[ ! -f "$file" ]]; then
    echo -e "${RED}Error: File '$file' does not exist or is not readable${NC}" >&2
    exit 1
fi

# Perform the search
line_number=0
match_count=0

while IFS= read -r line; do
    ((line_number++))
    
    # Case-insensitive match
    shopt -s nocasematch
    [[ "$line" =~ $search_string ]]
    match=$?
    shopt -u nocasematch
    
    # Handle invert match
    if $invert_match; then
        ((match = !match))
    fi
    
    # Print if matched
    if ((match == 0)); then
        ((match_count++))
        if $show_line_numbers; then
            printf "${GREEN}%d:${NC}" "$line_number"
        fi
        echo "$line"
    fi
done < "$file"

# Print match count if no matches found (similar to grep)
if ((match_count == 0)); then
    echo -e "${YELLOW}No matches found${NC}"
fi

exit 0
