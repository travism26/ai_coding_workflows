# AI Coding Workflows

A collection of tools, templates, and best practices for enhancing AI-assisted coding workflows. The goal of this repo is to create a efficent AI workflow that doesnt spead to much $ and also allows the coding assistent to be effective in large scale code bases.

## Projects

### TEMPLATE_MEMLOG_SYSTEM

The Memlog System is a hierarchical task tracking and memory management system designed to efficiently organize project tasks, track progress, and maintain a historical record while optimizing token usage when working with AI assistants.

#### Key Features

- **Hierarchical Organization**: Clear separation of active and archived tasks
- **Token Optimization**: Selective loading of only relevant files
- **Standardized Format**: Consistent structure across all task files
- **Automated Maintenance**: Scripts for common operations
- **Historical Record**: Complete project history in an accessible format

#### Directory Structure

```
TEMPLATE_MEMLOG_SYSTEM/
├── active/                 # Active tasks and current status
│   ├── project-one.md
│   └── ...
├── archived/               # Archived completed tasks by project
│   ├── project-one/
│   │   ├── 2024-Q1.md
│   │   └── ...
│   └── ...
├── shared/                 # Shared tracking files
│   ├── changelog.md
│   ├── stability_checklist.md
│   └── url_debug_checklist.md
└── index.md                # Master index of all projects and their status
```

#### Benefits

1. **Reduced Token Usage**

   - Loads only relevant, current information instead of entire project history
   - Separates active tasks from archived ones to minimize context size
   - Maintains focused task files with only recent updates (last 2 weeks)
   - Enables selective loading of only the files needed for current work

2. **Improved Organization**

   - Clear separation of active and archived tasks by project and time period
   - Standardized format across all files for consistency and predictability
   - Hierarchical structure that mirrors natural project organization
   - Dedicated shared files for cross-project information and standards

3. **Better Information Retrieval**

   - Structured format makes finding specific information faster and easier
   - Index file provides quick overview of all projects and their status
   - Consistent task formatting with priorities, status, and subtasks
   - Timestamped updates for clear chronological tracking

4. **Enhanced Collaboration**

   - Shared understanding of project status and priorities
   - Clear task ownership and status tracking
   - Standardized update format for consistent communication
   - Cross-referencing between related tasks across different projects

5. **Scalability**

   - System can grow with the project without becoming unwieldy
   - Automated archiving prevents active files from becoming too large
   - New projects can be added without restructuring existing ones
   - Consistent structure regardless of project size or complexity

6. **Comprehensive Historical Record**

   - Maintains complete project history in an accessible, organized format
   - Preserves task details, completion dates, and performance metrics
   - Enables analysis of past work for process improvement
   - Facilitates knowledge transfer and onboarding of new team members

7. **Automation Support**
   - Utility scripts automate common maintenance tasks
   - Standardized format enables programmatic processing
   - Consistent structure allows for automated reporting and metrics
   - Markdown format is compatible with various automation tools

#### Utility Scripts

The memlog system includes several utility scripts to help manage tasks:

1. **create-project.sh**: Creates a new project task file with standardized format
2. **archive-tasks.sh**: Archives completed tasks from active files to archive files

#### Implementation

To implement this memlog system in your project:

1. Copy the TEMPLATE_MEMLOG_SYSTEM directory to your project
2. Rename the directory to `memlog` if desired
3. Make the scripts executable with `chmod +x *.sh`
4. Create your first project with `./create-project.sh your-project-name`
5. Start using the system according to the guidelines in the template README

### AI_RULES_TEMPLATE

A template for creating AI rules and guidelines documents for your projects. This template helps establish clear expectations and requirements for AI assistants working on your codebase.

#### Key Features

- Project context and tech stack documentation
- Code style and structure guidelines
- Task breakdown and execution requirements
- Credential management protocols
- Error handling and reporting standards
- Third-party services integration checklists
- Testing and quality assurance requirements
- Security best practices
- Performance optimization guidelines
- Git usage rules
- Documentation requirements

## Getting Started

1. Clone this repository
2. Copy this directory into your repo
3. Add a `Custom Instructions` in you Cline Settings (Still work in Progress)

   ```text
   You must strictly adhere to the rules and guidelines outlined in the AI_RULES_AND_GUIDELINES.md file for the [Project Name] project. Before responding to any request:

   1. Check and Load Required Files:
   - Review memlog/index.md for project status overview
   - Load the relevant active task file from memlog/active/
   - Verify relevant shared tracking files in memlog/shared/

   2. Task Management:
   - Update active task files with timestamped progress
   - Cross-reference related tasks across projects when applicable
   - Consider task archival needs (tasks older than 2 weeks)
   - Maintain standardized file formats as specified in the memlog documentation

   3. Response Requirements:
   - Break down tasks into clear, numbered steps with explanations
   - Follow all coding, security, and documentation practices from the guidelines
   - Flag any actions that contradict the rules immediately
   - Document both actions and reasoning
   - Verify step completion before proceeding

   4. File Updates:
   - Add detailed timestamps for all updates
   - Keep active files focused on current and upcoming tasks
   - Maintain only the last 2 weeks of updates in active files
   - Update the index file to reflect current project status

   Your responses must demonstrate compliance with these guidelines, and you should actively reference them when providing assistance or generating code. Failure to follow these rules is not an option.
   ```

4. Get cline to create your `AI_RULES_AND_GUIDELINES.md` using the below prompt:

   ```text
   I am sharing a AI_RULES_AND_GUIDELINES template below can you review this code base and create me a AI_RULES_AND_GUIDELINES.md following the template structure below. Make sure NOT to just blindly copy the template but refer to the code base as the source of truth.

   <PASTE "AI_RULES_TEMPLATE.md">
   ```

## Contributing

Feel free to contribute your own AI coding workflows, templates, or improvements to existing ones by submitting a pull request.
