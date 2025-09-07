# Vibe Coding Agent Rules

This document contains a set of rules that apply to all agents in the Vibe Coding system. These rules are designed to ensure consistency, efficiency, and adherence to best practices across the entire agent team.

## 1. Core Principles

*   **Tactical & Efficient Execution:** All tasks must be executed with precision, clarity, and conciseness, eliminating ambiguity and redundant actions.
*   **Instructional Specificity:** All prompts, rules, and instructions must be unambiguous and directly testable.
*   **Evidence-Based Decisions:** All changes to agent behavior or workflow must be justified by empirical evidence, not assumptions.
*   **Structured & Verifiable Workflows:** All tasks must follow a standardized, repeatable process to ensure clarity and traceability.

## 2. Global Mandates

*   **Adhere to Tool Usage Protocol:** You MUST adhere to the Tool Usage Protocol in all actions.
*   **Mandatory Task Planning:** For any task that involves more than two distinct steps, you MUST use the `update_todo_list` tool to create a checklist of the steps you will take.
*   **Post-Modification Quality Gate:** After making any modifications, you MUST identify and run the appropriate quality assurance commands (e.g., linting, type-checking, tests).

## 3. Search and Discovery Hierarchy

1.  **Broad Conceptual Search (`codebase_search`):**
    *   **When to Use:** At the beginning of any new task or when exploring an unfamiliar area of the codebase. Use this tool to find relevant files based on natural language descriptions of functionality (e.g., "user authentication logic," "database connection handling").
    *   **Purpose:** To gain initial context and identify key files for deeper investigation.

2.  **Specific Pattern Matching (`search_files`):**
    *   **When to Use:** After identifying target files or directories with `codebase_search`. Use this tool to find exact string literals, function names, variable usages, or specific code patterns using regular expressions.
    *   **Purpose:** To perform precise, targeted searches for known syntax or patterns.
    *   **Anti-Pattern:** Do NOT use `execute_command` with `grep`, `rg`, or `find` for code searches. The native `search_files` tool is optimized for this environment and provides better-structured output.

## 4. File Operations Protocol: The Read-Modify-Verify Loop

To ensure data integrity and prevent context loss, all file modifications MUST adhere to the following strict, three-step loop:

1.  **READ (`read_file`):**
    *   Immediately before any modification, an agent **MUST** use `read_file` to load the most current state of the file into its context. This action is **mandatory** even if the file was read previously in the task, as other processes or agents may have altered it.

2.  **MODIFY (Choose one):**
    *   **Surgical Edits (`apply_diff`):** This is the **preferred** method for modifying existing code blocks.
    *   **Targeted Additions (`insert_content`):** For adding new, distinct blocks of code (e.g., imports, functions) without altering existing lines.
    *   **Targeted Replacements (`search_and_replace`):** For replacing specific strings or patterns across a file.
    *   **Creation or Full Rewrite (`write_to_file`):** Use this tool ONLY for creating new files or when a complete, intentional overwrite is required.

3.  **VERIFY (`read_file` or `search_files`):**
    *   Immediately after the modification tool runs, the agent **MUST** re-read the file using `read_file` or use `search_files` with a specific pattern to confirm that the changes were applied exactly as intended. This step is critical for catching partial or failed writes.

## 5. Command Execution (`execute_command`)

1.  **Explanation Mandate:** For any non-trivial or potentially destructive command, the agent **must** provide a concise explanation of the command's purpose and expected outcome *before* executing it.
2.  **Pathing and Directory Protocol:** Agents **must** use absolute paths for all file and directory references in commands. Avoid using `cd` to change the working directory.
3.  **Post-Modification Quality Gate:** After making any code modifications, the agent is **required** to identify and run the appropriate quality assurance commands (e.g., linting, type-checking, tests).
4.  **Command Chaining:** To ensure workflow continuity and prevent unnecessary pauses, agents **must** use the `&&` operator to chain sequential, non-interactive commands. This allows the entire sequence to complete as a single operation, returning the full output to the agent without requiring manual intervention.

## 6. Task Management (`update_todo_list`)

1.  **Mandatory Planning:** At the outset of a multi-step task (more than two steps), the agent **must** use `update_todo_list` to create a checklist.
2.  **Real-Time Updates:** The agent must update the status of each item as it progresses. Only one task should be `in_progress` at a time.

## 7. Agent Collaboration & Roles

The 8-agent collective is the core of our operational model. Collaboration is framed by the following roles and protocols:

### 7.1. The 8-Agent Collective:
1. **@architect-evolver**: System Architecture & Orchestration.
2. **@product-strategist**: Iteration Planning & Roadmapping.
3. **@technical-architect**: Technical Specification.
4. **@technical-maestro**: Code Implementation.
5. **@knowledge-weaver**: Documentation.
6. **@quality-catalyst**: Validation & Testing.
7. **@insight-hunter**: Research & Analysis.
8. **@creative-orchestrator**: Design & UX.

### 7.2. Pre-Implementation Protocol: The Design Phase Gate v2.0

To prevent the premature initiation of implementation planning, all tasks delegated to the `@architect-evolver` are subject to a mandatory, automated verification step—the `ExecutionGuard`.

1.  **Initiation**: The `@product-strategist` identifies a strategic need and creates a "Design Mandate" task.

2.  **Design Brief Creation**: The `@product-strategist` delegates the "Design Mandate" to the `@creative-orchestrator` and `@insight-hunter`. They **must** follow the **Deep Task Analysis Framework (DTAF)** to produce the "Design Brief." This structured process ensures every brief is built on evidence and deep analysis, not assumptions. The official template for this artifact is the [`design_brief_template.md`](../../content_templates/design_brief_template.md).

3.  **Validation & Approval**: The "Design Brief" is submitted to the `@product-strategist` for review. Upon approval, the `@product-strategist` marks the task as complete and updates the "Design Brief" document to include "Status: APPROVED."

4.  **Formal Handoff**: The `@product-strategist` delegates the implementation planning task to the `@architect-evolver`, including a context mention of the approved "Design Brief."

5.  **`ExecutionGuard` Verification**: The `ExecutionGuard` automatically intercepts the task and verifies the following:
    *   **Task Record Verification:** A preceding, completed task exists where a "Design Brief" was created.
    *   **Artifact Verification:** The referenced "Design Brief" document exists and contains "Status: APPROVED."
    *   **Context Verification:** The task delegation includes a direct context mention of the approved "Design Brief."

6.  **Architectural Planning**: Only if all verification steps pass does the task proceed to the `@architect-evolver`. If verification fails, the task is rejected with a notification to the delegating agent.

### 7.3. Failure & Escalation Protocol (PDCA Cycle)

To prevent flawed plans, we use a hierarchical Plan-Do-Check-Act (PDCA) cycle:
1.  **Do**: The `@technical-maestro` implements the code based on the technical specification.
2.  **Check & Act (Hierarchical Feedback):**
    *   **L1 Feedback (Bugs)**: `@quality-catalyst` finds bugs and reports them directly to `@technical-maestro`.
    *   **L2 Escalation (Spec Flaw)**: If the spec is flawed, the issue is escalated back to the `@technical-architect`.
    *   **L3 Escalation (Architectural Flaw)**: If the issue stems from a design flaw, it is escalated back to the `@architect-evolver`.

## 8. Structured Debugging Protocol (OODA Loop)

When encountering any error (from a command, test, or application log), the agent MUST explicitly follow the four-step OODA Loop:

**Step 1: OBSERVE - Gather Comprehensive Data**
- Collect full error messages, stack traces, relevant logs (application, container), service statuses (`docker ps`), and the source code of implicated components and configuration files (`.env`, `docker-compose.yml`).

**Step 2: ORIENT - Form a Root Cause Hypothesis**
- Synthesize all observed data to formulate a single, clear, testable hypothesis about the *root cause*.
- **Example Hypothesis:** "My hypothesis is that the `POSTGRES_DB` environment variable is not correctly set for the `db` service in `docker-compose.yml`."

**Step 3: DECIDE - Formulate a Targeted Action Plan**
- Based on the hypothesis, decide on a minimal, specific action to prove or disprove it.
- **Example Plan:** "To test this, I will read `docker-compose.yml` and `.env` to verify the variable is present and passed correctly. If missing, I will add it."

**Step 4: ACT - Execute and Re-Observe**
- Execute the precise action.
- Immediately loop back to **Step 1: OBSERVE** to analyze the outcome of the action and determine if the problem is resolved before proceeding.

This protocol explicitly forbids reactive re-execution of failed commands without a new, clearly stated hypothesis.

## 9. Agent Delegation Protocol

To ensure that tasks are handled by our specialized 8-agent collective and to avoid the use of generic, less-effective default agents, the following protocol is mandatory:

- **Forbidden Delegation Targets:** Under no circumstances should any agent delegate tasks to the default, non-specialized agents (`Architect`, `Code`, `Ask`, `Debug`, `Orchestrator`). All task delegations MUST be directed to a specific agent within our 8-agent collective (e.g., `@technical-maestro`, `@insight-hunter`).

## 10. Explicit Protocol Adherence

All agents MUST adhere to the protocols outlined in the following documents:

- [Environment & Dependency Management Protocol](environment_management_protocol.md)
- [OSS Analysis Instruction](OSS_Analysis_Instruction.md)
- [Project Mission](project_mission.md)
- [Regex Search Best Practice](regex_search_best_practice.md)

## 11. Secure Credential Discovery Protocol

To enhance security and streamline development, all agents MUST adhere to the following protocol for discovering and managing credentials.

### Core Principle: Discover, Never Ask

- **Mandate:** Agents are strictly prohibited from asking the user for credentials (e.g., API keys, passwords, database connection strings).
- **Workflow:** When an agent requires a credential, it MUST first consult the `/.env.example` file to identify the correct environment variable name. It MUST then read the `/.env` file to retrieve the value.

### Escalation Path for Missing Credentials

- **If `/.env` is missing or lacks the required variable:** The agent MUST NOT ask the user. Instead, it MUST delegate a task to the `@technical-architect`, clearly specifying the missing variable as defined in `/.env.example`.
- **If credentials need to be created:** The agent MUST delegate the creation and population of the credentials to the `@technical-architect`. The `@technical-architect` is then responsible for documenting these new credentials in a secure, shared location.