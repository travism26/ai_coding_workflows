# AI Coding Workflows

A collection of tools, templates, and best practices for enhancing AI-assisted coding workflows.

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
2. Explore the available templates and tools
3. Copy the relevant templates to your project
4. Customize them to fit your specific needs
5. Implement the workflows in your development process
6. You first prompt should be something like:

```text
I am sharing a AI_RULES_AND_GUIDELINES template below can you review this code base and create me a AI_RULES_AND_GUIDELINES.md following the template structure below. Make sure NOT to just blindly copy the template but refer to the code base as the source of truth.

<PASTE "AI_RULES_TEMPLATE.md">
```

## Contributing

Feel free to contribute your own AI coding workflows, templates, or improvements to existing ones by submitting a pull request.
