#!/bin/bash
# archive-tasks.sh - Script to archive completed tasks from active files to archive files

# Default period is current quarter
DEFAULT_PERIOD=$(date +%Y)-Q$(( ($(date +%-m)-1)/3+1 ))

# Help function
show_help() {
    echo "Usage: $0 [options]"
    echo "Archive completed tasks from active files to archive files."
    echo ""
    echo "Options:"
    echo "  -p, --project PROJECT   Specify a project to archive (default: all projects)"
    echo "  -d, --period PERIOD     Specify the archive period (default: current quarter, e.g., 2025-Q1)"
    echo "  -a, --all               Archive all completed tasks regardless of age"
    echo "  -h, --help              Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                      Archive all projects' completed tasks to the current quarter"
    echo "  $0 -p project-one       Archive only project-one completed tasks"
    echo "  $0 -d 2024-Q4           Archive to the 2024-Q4 period"
    echo "  $0 -p project-two -d 2025-Q2  Archive project-two tasks to 2025-Q2"
}

# Parse command line arguments
PROJECT=""
PERIOD=$DEFAULT_PERIOD
ARCHIVE_ALL=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -p|--project)
            PROJECT="$2"
            shift 2
            ;;
        -d|--period)
            PERIOD="$2"
            shift 2
            ;;
        -a|--all)
            ARCHIVE_ALL=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Set the base directory
MEMLOG_DIR="$(pwd)"
echo "Starting task archiving in: $MEMLOG_DIR"

# Ensure the archive directory exists
mkdir -p "$MEMLOG_DIR/archived"

# Function to archive tasks for a specific project
archive_project_tasks() {
    local project=$1
    local period=$2
    
    echo "Archiving tasks for project: $project (Period: $period)"
    
    # Check if active file exists
    active_file="$MEMLOG_DIR/active/$project.md"
    if [ ! -f "$active_file" ]; then
        echo "Error: Active file not found for project: $project"
        return 1
    fi
    
    # Create archive directory for this project if it doesn't exist
    mkdir -p "$MEMLOG_DIR/archived/$project"
    
    # Create or append to archive file
    archive_file="$MEMLOG_DIR/archived/$project/$period.md"
    
    # Check if archive file exists, create if not
    if [ ! -f "$archive_file" ]; then
        # Extract project name from active file
        project_name=$(head -n 1 "$active_file" | sed 's/# \(.*\) Active Tasks/\1/')
        
        echo "# $project_name Archived Tasks - $period" > "$archive_file"
        echo "" >> "$archive_file"
        echo "## Completed Tasks" >> "$archive_file"
        echo "" >> "$archive_file"
    fi
    
    # Create a temporary file for the updated active file
    temp_active_file=$(mktemp)
    
    # Initialize variables for tracking sections
    in_completed_task=false
    task_content=""
    current_task_title=""
    found_completed_tasks=false
    
    # Read the active file line by line
    while IFS= read -r line; do
        # Check if this is a task header
        if [[ $line =~ ^###\ .*\ \[Priority:.*\]$ ]]; then
            # If we were in a completed task, add it to the archive
            if $in_completed_task; then
                echo "$current_task_title" >> "$archive_file"
                echo "" >> "$archive_file"
                echo "$task_content" >> "$archive_file"
                echo "" >> "$archive_file"
                found_completed_tasks=true
                in_completed_task=false
                task_content=""
            fi
            
            # Check if the next lines indicate this is a completed task
            current_task_title=$line
            in_completed_task=false
            
        # Check if this is a status line indicating completion
        elif [[ $line =~ ^Status:\ Completed$ ]]; then
            in_completed_task=true
            task_content="$line"
            
        # If we're in a completed task, add this line to the task content
        elif $in_completed_task; then
            task_content="$task_content
$line"
            
        # If we're not in a completed task, add this line to the new active file
        else
            echo "$line" >> "$temp_active_file"
        fi
    done < "$active_file"
    
    # Check if we ended with a completed task
    if $in_completed_task; then
        echo "$current_task_title" >> "$archive_file"
        echo "" >> "$archive_file"
        echo "$task_content" >> "$archive_file"
        echo "" >> "$archive_file"
        found_completed_tasks=true
    fi
    
    # If we found and archived completed tasks, replace the active file
    if $found_completed_tasks; then
        mv "$temp_active_file" "$active_file"
        echo "Successfully archived completed tasks for $project to $period"
        
        # Update the index file with the newly archived tasks
        update_index_file "$project" "$period"
    else
        echo "No completed tasks found for project: $project"
        rm "$temp_active_file"
    fi
}

# Function to update the index file
update_index_file() {
    local project=$1
    local period=$2
    
    echo "Updating index file with archived tasks for $project ($period)"
    
    index_file="$MEMLOG_DIR/index.md"
    
    # Create index file if it doesn't exist
    if [ ! -f "$index_file" ]; then
        echo "# Memlog System Index" > "$index_file"
        echo "" >> "$index_file"
        echo "Last Updated: $(date +%Y-%m-%d)" >> "$index_file"
        echo "" >> "$index_file"
        echo "## Active Projects" >> "$index_file"
        echo "" >> "$index_file"
        echo "| Project | Current Sprint | Priority Tasks | Status |" >> "$index_file"
        echo "|---------|---------------|----------------|--------|" >> "$index_file"
        echo "" >> "$index_file"
        echo "## Recently Completed Tasks" >> "$index_file"
        echo "" >> "$index_file"
        echo "| Project | Task | Completion Date | Archive Link |" >> "$index_file"
        echo "|---------|------|----------------|-------------|" >> "$index_file"
        echo "" >> "$index_file"
        echo "## Shared Resources" >> "$index_file"
        echo "" >> "$index_file"
        echo "- [Changelog](./shared/changelog.md)" >> "$index_file"
        echo "- [Stability Checklist](./shared/stability_checklist.md)" >> "$index_file"
        echo "- [URL Debug Checklist](./shared/url_debug_checklist.md)" >> "$index_file"
    fi
    
    # Extract project name from active file
    active_file="$MEMLOG_DIR/active/$project.md"
    project_name=$(head -n 1 "$active_file" | sed 's/# \(.*\) Active Tasks/\1/')
    
    # Extract a completed task from the archive file
    archive_file="$MEMLOG_DIR/archived/$project/$period.md"
    completed_task=$(grep -A 1 "Priority:" "$archive_file" | grep -v "Priority" | head -n 1 | sed 's/^Status: //')
    if [ -z "$completed_task" ]; then
        completed_task="Tasks archived"
    fi
    
    # Update the "Last Updated" date
    sed -i "s/Last Updated: .*/Last Updated: $(date +%Y-%m-%d)/" "$index_file"
    
    # Add entry to Recently Completed Tasks section if not already present
    if ! grep -q "$project.*$period" "$index_file"; then
        # Find the line after the Recently Completed Tasks header
        line_num=$(grep -n "## Recently Completed Tasks" "$index_file" | cut -d: -f1)
        line_num=$((line_num + 3))  # Skip header and table header
        
        # Insert the new entry after the table header
        sed -i "${line_num}i| $project_name | $completed_task | $(date +%Y-%m-%d) | [$period](./archived/$project/$period.md) |" "$index_file"
    fi
}

# Main execution
if [ -n "$PROJECT" ]; then
    # Archive tasks for a specific project
    archive_project_tasks "$PROJECT" "$PERIOD"
else
    # Archive tasks for all projects
    for active_file in "$MEMLOG_DIR/active"/*.md; do
        if [ -f "$active_file" ]; then
            filename=$(basename "$active_file")
            project=${filename%.md}
            archive_project_tasks "$project" "$PERIOD"
        fi
    done
fi

echo "Task archiving completed!"
