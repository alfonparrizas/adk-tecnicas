# ADK Agent Template (Python)

Welcome to your new ADK agent project! This repository is configured with the essential skills, knowledge, and workflows to help you build, test, and deploy sophisticated AI agents using the [Agent Development Kit (ADK)](https://google.github.io/adk-docs/).

## Getting Started

1.  **Fork this repository**: Use this as a starting point for your new agent.
2.  **Configure MCP Server**: (Recommended) Follow the [MCP Setup Guide](.agents/workflows/setup-mcp-server.md) to connect your AI assistant to the latest ADK documentation.
3.  **Create a Virtual Environment**:
    We strongly recommend using `uv` for environment management:
    ```bash
    uv venv
    source .venv/bin/activate
    ```
    Alternatively, using standard `venv`:
    ```bash
    python3 -m venv .venv
    source .venv/bin/activate
    ```
4.  **Install dependencies**:
    ```bash
    pip install -e .
    ```
3.  **Explore Skills**: The `.agents/skills` directory contains specialized skills for development, deployment, and observability.
4.  **Follow Workflows**: Check `.agents/workflows` for step-by-step guides on common tasks.

## Project Structure

- `.github/`: CI/CD workflows for GitHub Actions (if configured).
- `GEMINI.md`: Coding Agent Guide for AI assistants like Antigravity, Gemini, or Cursor.
- `.agents/`: Contains agent-specific configuration, skills, knowledge, and workflows.
  - `skills/`: Development skills for your AI coding assistant.
  - `knowledge/`: Best practices and project-specific information.
  - `workflows/`: Standardized procedures for common tasks.
- `pyproject.toml`: Project metadata and dependencies.
- `README.md`: This file.

## Recommended Tools

- **AI Coding Assistant**: Use Antigravity, Gemini CLI, or Cursor with the ADK skills for the best experience. Refer to [GEMINI.md](GEMINI.md) for detailed AI coding guidelines.
- **MCP Server**: Connect your tool to the [ADK documentation MCP server](https://google.github.io/adk-docs/tutorials/coding-with-ai/#adk-docs-mcp-server).

## Resources

- [ADK Documentation](https://google.github.io/adk-docs/)
- [ADK Python Reference](https://google.github.io/adk-docs/api-reference/python/)
- [Coding with AI Tutorial](https://google.github.io/adk-docs/tutorials/coding-with-ai/)
