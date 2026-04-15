# Rule: ADK Framework Versioning

To leverage the latest features and security updates, all AI coding agents working on this project MUST follow these rules:

## 1. Latest GA Version
- **MANDATORY**: Always work with the latest GA (General Availability) version of the `google-adk` framework.
- **Check for Updates**: Before starting any task, verify the current installed version against the latest available version using `uv pip list --outdated` or `pip list --outdated`.

## 2. Automated Updates
- **Auto-Update**: If a new GA version is available, the agent should update the `pyproject.toml` (if applicable) and the virtual environment before proceeding.
- **Example**: `uv pip install --upgrade google-adk`.

## 3. Dependency Consistency
- Ensure that all other dependencies are compatible with the latest ADK version.
- If an update causes conflicts, the agent must document the issue and request user intervention if it cannot be resolved automatically.
