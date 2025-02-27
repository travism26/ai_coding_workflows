#!/bin/bash
# create-project.sh - Script to create a new project task file in the memlog system

# Help function
show_help() {
    echo "Usage: $0 [options] PROJECT_NAME"
    echo "Create a new project task file in the memlog system."
    echo ""
    echo "Options:"
    echo "  -d, --description DESC  Add a project description"
    echo "  -s, --sprint SPRINT     Set the initial sprint name/number (default: Sprint 1)"
    echo "  -p, --priority PRIORITY Set the default task priority (default: Medium)"
    echo "  -h, --help              Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 new-project                     Create a basic new project task file"
    echo "  $0 -d \"API Service\" api-service    Create with description"
    echo "  $0 -s \"Q1-Sprint\" new-project      Create with custom sprint name"
}

# Parse command line arguments
DESCRIPTION=""
SPRINT="Sprint 1"
PRIORITY="Medium"

while [[ $# -gt 0 ]]; do
    case $1 in
        -d|--description)
            DESCRIPTION="$2"
            shift 2
            ;;
        -s|--sprint)
            SPRINT="$2"
            shift 2
            ;;
        -p|--priority)
            PRIORITY="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        -*)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
        *)
            PROJECT_NAME="$1"
            shift
            ;;
    esac
done

# Check if project name was provided
if [ -z "$PROJECT_NAME" ]; then
    echo "Error: Project name is required"
    show_help
    exit 1
fi

# Convert project name to a standardized format (lowercase, hyphens instead of spaces)
PROJECT_ID=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

# Set the base directory
MEMLOG_DIR="$(pwd)"
echo "Creating new project in: $MEMLOG_DIR"

# Ensure the active directory exists
mkdir -p "$MEMLOG_DIR/active"

# Check if project already exists
if [ -f "$MEMLOG_DIR/active/$PROJECT_ID.md" ]; then
    echo "Error: Project '$PROJECT_ID' already exists"
    exit 1
fi

# Create the project file
echo "Creating project file: $PROJECT_ID.md"
PROJECT_FILE="$MEMLOG_DIR/active/$PROJECT_ID.md"

# Get current date
CURRENT_DATE=$(date +%Y-%m-%d)

# Calculate end date (30 days from now)
END_DATE=$(date -v+30d +%Y-%m-%d 2>/dev/null || date -d "+30 days" +%Y-%m-%d 2>/dev/null || echo "TBD")

# Create the project file with standardized format
cat > "$PROJECT_FILE" << EOF
# ${PROJECT_NAME} Active Tasks

## Current Sprint: ${SPRINT}

Start Date: ${CURRENT_DATE}
End Date: ${END_DATE}

EOF

# Add description if provided
if [ -n "$DESCRIPTION" ]; then
    cat >> "$PROJECT_FILE" << EOF
## Project Description

${DESCRIPTION}

EOF
fi

# Add initial task sections
cat >> "$PROJECT_FILE" << EOF
## Active Tasks

### 1. Project Setup [Priority: ${PRIORITY}]

Status: Pending

- [ ] Define project requirements
- [ ] Set up development environment
- [ ] Create initial project structure
- [ ] Define coding standards and guidelines
- [ ] Set up version control

### 2. Core Implementation [Priority: ${PRIORITY}]

Status: Pending

- [ ] Implement basic functionality
- [ ] Create unit tests
- [ ] Document API/interfaces
- [ ] Perform code review

## Recent Updates (Last 2 weeks)

[${CURRENT_DATE}]

- Created project task file
- Defined initial tasks and structure

## Next Steps

1. Review and refine project requirements
2. Begin implementation of core functionality
3. Set up CI/CD pipeline
EOF

echo "Project file created successfully: $PROJECT_FILE"

# Update the index file
INDEX_FILE="$MEMLOG_DIR/index.md"

# Create index file if it doesn't exist
if [ ! -f "$INDEX_FILE" ]; then
    echo "Creating index file..."
    cat > "$INDEX_FILE" << EOF
# Memlog System Index

Last Updated: ${CURRENT_DATE}

## Active Projects

| Project | Current Sprint | Priority Tasks | Status |
|---------|---------------|----------------|--------|

## Recently Completed Tasks

| Project | Task | Completion Date | Archive Link |
|---------|------|----------------|-------------|

## Shared Resources

- [Changelog](./shared/changelog.md)
- [Stability Checklist](./shared/stability_checklist.md)
- [URL Debug Checklist](./shared/url_debug_checklist.md)
EOF
fi

# Update the index file with the new project
echo "Updating index file..."

# Update the "Last Updated" date
sed -i "s/Last Updated: .*/Last Updated: ${CURRENT_DATE}/" "$INDEX_FILE"

# Add the project to the Active Projects section if not already present
if ! grep -q "\[$PROJECT_NAME\]" "$INDEX_FILE"; then
    # Find the line after the Active Projects table header
    LINE_NUM=$(grep -n "^|---------|" "$INDEX_FILE" | head -n 1 | cut -d: -f1)
    
    # Insert the new project entry after the table header
    sed -i "${LINE_NUM}a| [$PROJECT_NAME](./active/$PROJECT_ID.md) | $SPRINT | Project Setup | Pending |" "$INDEX_FILE"
fi

echo "Index file updated successfully"
echo ""
echo "New project '$PROJECT_NAME' has been created and added to the memlog system."
echo "You can find the project file at: $PROJECT_FILE"
