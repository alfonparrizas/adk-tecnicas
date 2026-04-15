# Coding Agent Guide

## Reference Documentation

If you have ADK skills available, use those instead of fetching the URLs below.

Otherwise, fetch these resources as needed:
- **ADK Cheatsheet**: https://raw.githubusercontent.com/GoogleCloudPlatform/agent-starter-pack/refs/heads/main/agent_starter_pack/resources/docs/adk-cheatsheet.md — Agent definitions, tools, callbacks, orchestration
- **Evaluation Guide**: https://raw.githubusercontent.com/GoogleCloudPlatform/agent-starter-pack/refs/heads/main/agent_starter_pack/resources/docs/adk-eval-guide.md — Eval config, metrics, gotchas
- **Deployment Guide**: https://raw.githubusercontent.com/GoogleCloudPlatform/agent-starter-pack/refs/heads/main/agent_starter_pack/resources/docs/adk-deploy-guide.md — Infrastructure, CI/CD, testing deployed agents
- **Development Guide**: https://raw.githubusercontent.com/GoogleCloudPlatform/agent-starter-pack/refs/heads/main/docs/guide/development-guide.md — Full development workflow
- **ADK Docs**: https://google.github.io/adk-docs/llms.txt

---

## Development Phases

### Phase 1: Understand Requirements
Before writing any code, understand the project's requirements, constraints, and success criteria.

**Note on Google Cloud Authentication:**
Ensure you are authenticated with Google Cloud before proceeding. Run the following commands:
- `gcloud auth login` to authenticate your account.
- `gcloud auth application-default login` to set up Application Default Credentials (ADC) for Vertex AI.
- `gcloud config set project [YOUR_PROJECT_ID]` to set your active project.
- `gcloud auth list` to verify your active account.

### Phase 2: Build and Implement
Implement agent logic in `app/`. Use `make playground` for interactive testing via the web UI. For fast, text-based validation or when testing programmatically (e.g., by another agent), use `uv run adk run ./app`. Iterate based on user feedback.

### Phase 3: The Evaluation Loop (Main Iteration Phase)
Start with 1-2 eval cases, run `make eval`, iterate. Expect 5-10+ iterations. See the **Evaluation Guide** for metrics, evalset schema, LLM-as-judge config, and common gotchas.

### Phase 4: Pre-Deployment Tests
Run `make test`. Fix issues until all tests pass.

### Phase 5: Deploy to Dev
**Requires explicit human approval.** Run `make deploy` only after user confirms. See the **Deployment Guide** for details.

**Controlling the Deployment Region:**
The deployment script uses the `GOOGLE_CLOUD_REGION` environment variable or defaults to `us-west1`. To specify a region, run:
- `export GOOGLE_CLOUD_REGION=europe-west1 && make deploy`
- Or use the `REGION` variable if supported: `make deploy REGION=europe-west1`.

Always verify the region in the deployment logs before confirming the operation.

**Verifying the Deployment (Phase 4):**
To avoid SDK versioning issues, use direct REST calls via `curl` for the most reliable verification.

1. **Locate your agent details:** Identify your `PROJECT_ID`, `LOCATION` (e.g., `us-west1`), and `RESOURCE_ID` (the 19-digit number) from the deployment logs.
2. **The "Golden" Verification Command:** Use `async_stream_query` to verify the agent can call tools and respond:
   ```bash
   curl -s -X POST \
   -H "Authorization: Bearer $(gcloud auth print-access-token)" \
   -H "Content-Type: application/json" \
   https://{LOCATION}-aiplatform.googleapis.com/v1/projects/{PROJECT_ID}/locations/{LOCATION}/reasoningEngines/{RESOURCE_ID}:streamQuery?alt=sse \
   -d '{
     "class_method": "async_stream_query",
     "input": {
       "user_id": "test_user",
       "message": "What is the current time in San Francisco?"
     }
   }'
   ```
3. **Troubleshooting Methods:** If the command above fails with "method not found", call the endpoint with a wrong method name to see the list of available methods in the error message.

### Phase 6: Production Deployment
Ask the user: Option A (simple single-project) or Option B (full CI/CD pipeline with `uvx agent-starter-pack setup-cicd`). See the [deployment docs](https://raw.githubusercontent.com/GoogleCloudPlatform/agent-starter-pack/refs/heads/main/docs/guide/deployment.md) for step-by-step instructions.

## Development Commands

| Command | Purpose |
|---------|---------|
| `make playground` | Interactive local testing (Web UI) |
| `uv run adk run ./app` | Fast CLI-based interaction (preferred for automated agent testing) |
| `make test` | Run unit and integration tests |
| `make eval` | Run evaluation against evalsets |
| `make eval-all` | Run all evalsets |
| `make lint` | Check code quality |
| `make setup-dev-env` | Set up dev infrastructure (Terraform) |
| `make deploy` | Deploy the agent to Agent Engine |

---

## Operational Guidelines for Coding Agents

- **Code preservation**: Only modify code directly targeted by the user's request. Preserve all surrounding code, config values (e.g., `model`), comments, and formatting.
- **NEVER change the model** unless explicitly asked. Use `gemini-3-flash-preview` or `gemini-3.1-pro-preview` for new agents.
- **Model 404 errors**: Fix `GOOGLE_CLOUD_LOCATION` (e.g., `global` instead of `europe-west1`), not the model name.
- **ADK tool imports**: Import the tool instance, not the module: `from google.adk.tools.load_web_page import load_web_page`
- **Run Python with `uv`**: `uv run python script.py`. Run `make install` first.
- **Stop on repeated errors**: If the same error appears 3+ times, fix the root cause instead of retrying.
- **Terraform conflicts** (Error 409): Use `terraform import` instead of retrying creation.
