# AI Rules and Guidelines Template

This document outlines the rules, best practices, and guidelines that AI must follow when assisting with the development of the [Project Name] project.

## Project Context

[Project Name] is a [brief description of the project's purpose and main features].

Key architectural features:

- [List key architectural features]
- [e.g., Scalability approach]
- [e.g., Design patterns used]
- [e.g., Integration methods]

## Tech Stack

Frontend:

- [List frontend technologies]

Backend:

- [List backend technologies]

Data Storage:

- [List databases and storage solutions]

Infrastructure:

- [List infrastructure technologies]

## Code Style and Structure

### Directory Structure

```text
# For Backend Services (e.g., Node.js/Express)
src/
├── routes/          # API routes
├── controllers/     # Request handlers
├── services/        # Business logic
├── models/          # Data models
├── middleware/      # Custom middleware
├── utils/           # Helper functions
└── config/          # Configuration

# For Frontend Applications (e.g., React)
src/
├── components/      # React components
├── pages/          # Page components
├── hooks/          # Custom hooks
├── contexts/       # React contexts
├── services/       # API services
├── utils/          # Helper functions
├── types/          # Type definitions
└── styles/         # Styling files
```

### Naming Conventions

[Primary Language]:

- [Naming convention for classes]
- [Naming convention for functions]
- [Naming convention for variables]
- [Naming convention for files]
- [Naming convention for tests]

### Component Structure

```typescript
// Example component structure
interface Props {
  // Props definition
}

export function ComponentName({ prop1, prop2 }: Props): JSX.Element {
  // Component implementation
}
```

## 1. Memlog System

### Directory Structure

The memlog system follows a hierarchical structure to optimize organization and token usage:

```text
memlog/
├── active/                 # Active tasks and current status
│   ├── log-aggregator.md
│   ├── system-monitoring-gateway.md
│   ├── siem-dashboard.md
│   └── ...
├── archived/               # Archived completed tasks by project
│   ├── log-aggregator/
│   │   ├── 2024-Q1.md
│   │   └── 2024-Q2.md
│   ├── system-monitoring-gateway/
│   │   └── 2024-Q1.md
│   └── ...
├── shared/                 # Shared tracking files
│   ├── changelog.md
│   ├── stability_checklist.md
│   └── url_debug_checklist.md
└── index.md                # Master index of all projects and their status
```

### Key Principles

- **Selective Loading**: Only load the index file and relevant active task files to minimize token usage
- **Regular Archiving**: Move completed tasks to archive files organized by project and time period
- **Standardized Format**: Follow consistent formatting for all task files
- **Cross-Referencing**: Use links between files rather than duplicating information

### Required Actions

1. **Before Starting Work**:

   - Check the index file (`memlog/index.md`) for project status overview
   - Load the relevant active task file for the specific project
   - Verify and update shared tracking files as needed

2. **During Task Execution**:

   - Update the active task file with progress, status changes, and new information
   - Add detailed timestamps for all updates
   - Cross-reference related tasks in other projects when applicable

3. **After Task Completion**:

   - Mark tasks as completed in the active file
   - Consider if completed tasks should be archived (based on age and relevance)
   - Update the index file to reflect current project status

4. **For New Projects**:
   - Create a new active task file following the standardized format
   - Add the project to the index file
   - Set up initial task structure and priorities

### File Maintenance

- Keep active files focused on current and upcoming tasks
- Maintain only the last 2 weeks of updates in active files
- Archive completed tasks quarterly or when files become too large
- Ensure all files follow the standardized format for consistency

## 2. Task Breakdown and Execution

- Break down tasks into clear, numbered steps
- Document both actions and reasoning
- Verify step completion before proceeding
- Document errors and recovery steps
- Maintain task dependencies and relationships

## 3. Credential Management

- Document credential requirements
- Guide credential acquisition process
- Test credential validity
- Use secure storage methods (environment variables)
- Implement credential refresh procedures
- Never store credentials in code or version control

## 4. Error Handling and Reporting

Implementation requirements:

- Detailed error messages with context
- Timestamp logging
- Error recovery procedures
- Error pattern tracking
- Escalation protocols
- System-wide error handling consistency

## 5. Third-Party Services Integration

Checklist for each integration:

- [ ] Verify setup requirements
- [ ] Check necessary permissions
- [ ] Test service connections
- [ ] Document version requirements
- [ ] Prepare contingency plans
- [ ] Monitor service health

## 6. Testing and Quality Assurance

Required test types:

- Unit tests for business logic
- Integration tests for APIs
- End-to-end tests for critical flows
- Error handling tests
- Performance tests
- Security tests

Documentation:

- Maintain test coverage metrics
- Document test procedures
- Update stability checklist

## 7. Security Best Practices

Required implementations:

- Authentication and authorization
- Secure communications (HTTPS)
- Input validation and sanitization
- CORS and CSP policies
- Principle of least privilege
- Regular security audits
- Dependency vulnerability scanning

## 8. Performance Optimization

Focus areas:

- Database query optimization
- Caching strategies
- Network request optimization
- Asynchronous operations
- Resource usage monitoring
- Load testing and profiling

## 9. Git Usage

Commit Message Prefixes:

- "fix:" for bug fixes
- "feat:" for new features
- "perf:" for performance improvements
- "docs:" for documentation changes
- "style:" for formatting changes
- "refactor:" for code refactoring
- "test:" for adding missing tests
- "chore:" for maintenance tasks

Rules:

- Use lowercase for commit messages
- Keep summary line under 50 characters
- Include detailed description for complex changes
- Reference issue numbers when applicable

## 10. Documentation

Required documentation:

- README files with setup instructions
- API documentation
- Configuration guides
- Architecture diagrams
- Changelog maintenance
- Component documentation
- Deployment procedures
- Troubleshooting guides

Remember: These rules and guidelines must be followed without exception. Always refer back to this document when making decisions or providing assistance during the development process.
