# Coding Agent Guide

## Project Configuration

| Parameter | Value | Description |
|-----------|-------|-------------|
| **Deployment Region** | `europe-west1` | Target region for all deployments |
| **Model Location** | `global` | Location for Gemini 3 series models |

---

## Reference Documentation

If you have ADK skills available, use those instead of fetching the URLs below.

Otherwise, fetch these resources as needed:
- **ADK Cheatsheet**: https://raw.githubusercontent.com/GoogleCloudPlatform/agent-starter-pack/refs/heads/main/agent_starter_pack/resources/docs/adk-cheatsheet.md — Agent definitions, tools, callbacks, orchestration
- **Evaluation Guide**: https://raw.githubusercontent.com/GoogleCloudPlatform/agent-starter-pack/refs/heads/main/agent_starter_pack/resources/docs/adk-eval-guide.md — Eval config, metrics, gotchas
- **Deployment Guide**: https://raw.githubusercontent.com/GoogleCloudPlatform/agent-starter-pack/refs/heads/main/agent_starter_pack/resources/docs/adk-deploy-guide.md — Infrastructure, CI/CD, testing deployed agents
- **Development Guide**: https://raw.githubusercontent.com/GoogleCloudPlatform/agent-starter-pack/refs/heads/main/docs/guide/development-guide.md — Full development workflow
- **ADK Docs**: https://google.github.io/adk-docs/llms.txt

---

## Quick Start for AI Assistants

If you need to quickly set up a test agent in this cloned repository, follow these steps:

1.  **Initialize Environment**: Create a virtual environment and install dependencies.
    ```bash
    uv venv && source .venv/bin/activate && uv pip install -e .
    ```
2.  **Bootstrap Agent**: Since this is a template, use `agent-starter-pack enhance` to scaffold a prototype agent in the current directory.
    ```bash
    uvx agent-starter-pack enhance . --agent adk --prototype -y
    ```
3.  **Run & Debug**: Start the ADK web interface and use the `chrome-devtools` skill to verify agent behavior.
    ```bash
    adk web .
    ```

## Development Phases

### Phase 1: Understand Requirements
Before writing any code, understand the project's requirements, constraints, and success criteria.

### Phase 2: Build and Implement
Implement agent logic in `app/`. Use `make playground` for interactive testing. Iterate based on user feedback.

### Phase 3: The Evaluation Loop (Main Iteration Phase)
Start with 1-2 eval cases, run `make eval`, iterate. Expect 5-10+ iterations. See the **Evaluation Guide** for metrics, evalset schema, LLM-as-judge config, and common gotchas.

### Phase 4: Pre-Deployment Tests
Run `make test`. Fix issues until all tests pass.

### Phase 5: Deploy to Dev
**Requires explicit human approval.** Run `make deploy` only after user confirms.
> [!IMPORTANT]
> Always use the project's default deployment region (`europe-west1`) and model location (`global`).

See the **Deployment Guide** for details.

### Phase 6: Production Deployment
Ask the user: Option A (simple single-project) or Option B (full CI/CD pipeline with `uvx agent-starter-pack setup-cicd`). See the [deployment docs](https://raw.githubusercontent.com/GoogleCloudPlatform/agent-starter-pack/refs/heads/main/docs/guide/deployment.md) for step-by-step instructions.

## Development Commands (ADK CLI)

If a `Makefile` is not present, use the following `adk` commands:

| Command | Purpose |
|---------|---------|
| `adk web .` | Start interactive web interface (playground) |
| `adk run --local` | Run agent locally in terminal |
| `adk eval <dir> <evalset>` | Run evaluation against evalsets |
| `pytest` | Run unit and integration tests |
| `ruff check .` | Check code quality |

*Note: Always ensure your virtual environment is active before running these commands.*

## Development Commands (Makefile)

| Command | Purpose |
|---------|---------|
| `make playground` | Interactive local testing |
| `make test` | Run unit and integration tests |
| `make eval` | Run evaluation against evalsets |
| `make eval-all` | Run all evalsets |
| `make lint` | Check code quality |
| `make setup-dev-env` | Set up dev infrastructure (Terraform) |
| `make deploy` | Deploy to dev |

---

## Operational Guidelines for Coding Agents

- **Code preservation**: Only modify code directly targeted by the user's request. Preserve all surrounding code, config values (e.g., `model`), comments, and formatting.
- **NEVER change the model** unless explicitly asked. Use `gemini-3-flash-preview` or `gemini-3-pro-preview` for new agents.
- **Model 404 errors**: Fix `GOOGLE_CLOUD_LOCATION` (e.g., `global` instead of `us-central1`), not the model name.
- **ADK tool imports**: Import the tool instance, not the module: `from google.adk.tools.load_web_page import load_web_page`
- **Run Python with `uv`**: `uv run python script.py`. Run `make install` first.
- **Stop on repeated errors**: If the same error appears 3+ times, fix the root cause instead of retrying.
- **Terraform conflicts** (Error 409): Use `terraform import` instead of retrying creation.

---

## Project-Specific Troubleshooting & Gotchas

- **Model Availability**: To verify which Flash models are available in the `global` location, run:
  ```python
  from google.genai import Client
  client = Client(vertexai=True, project='fon-test-project', location='global')
  print([m.name for m in client.models.list()])
  ```
- **Location vs. Region**: Follow the **Project Configuration** at the top of this file. Use the specified **deployment region** for infrastructure and the **model location** for model initialization.
- **Remote Query API**: Deployed `AgentEngine` objects use `async_stream_query(...)`. **MANDATORY**: You must include the `user_id` and `message` parameters. Do **not** use `async_query(...)` as it will raise an `AttributeError`.
- **404 Handling**: If `gemini-2.5-flash` returns a 404, verify that the project has explicit access to that specific model version in the `global` location.
