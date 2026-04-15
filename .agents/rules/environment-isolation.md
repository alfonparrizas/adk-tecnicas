# Rule: Environment Isolation

To ensure consistent and reproducible development environments, all AI coding agents working on this project MUST follow these rules:

## 1. Virtual Environment Enforcement
- **MANDATORY**: All Python-related commands (running scripts, tests, `adk` CLI, or dependency management) MUST be executed within a project-local virtual environment.
- **Verification**: Before running any command, confirm that a virtual environment is active (e.g., by checking the `VIRTUAL_ENV` environment variable or the existence of a `.venv` directory).
- **Auto-Initialization**: If a virtual environment does not exist, initialize one (using `uv venv` or `python -m venv .venv`) before proceeding with other tasks.

## 2. Dependency Management
- **No Global Installs**: Do not install packages to the system or user global site-packages.
- **Prefer `uv`**: Use `uv` for all environment and dependency management tasks. It is significantly faster and more reliable than standard `venv` and `pip`.
- **Syncing**: Always keep the environment synchronized with the `pyproject.toml` file.

## 3. Tool Execution
- When using the `run_command` tool, ensure the command is prefixed with an activation step or use the full path to the virtual environment's executable if possible.
- **Example**: `source .venv/bin/activate && adk run` or `.venv/bin/python main.py`.

## 4. Failure Protocol
- If a command fails due to a missing or inactive virtual environment, the agent must point this out and attempt to resolve it before retrying the original command.
