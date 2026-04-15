---
description: How to deploy the ADK agent to Vertex AI Agent Engine.
---

# Deploy to Agent Engine

Follow these steps to deploy your agent to Google Cloud Vertex AI Agent Engine.

1.  **Authenticated with Google Cloud**:
    Make sure you are logged in to the Google Cloud CLI.
    ```bash
    gcloud auth login
    ```

2.  **Set your project ID**:
    ```bash
    gcloud config set project [PROJECT_ID]
    ```

3.  **Verify Deployment Region**:
    Ensure the target region matches the project standard (e.g., `europe-west1`) before proceeding.

3.  **Prepare the deployment configuration**:
    Ensure you have an `agent_config.yaml` file in your project root.

4.  **Deploy using ADK CLI**:
    // turbo
    ```bash
    adk deploy --target agent-engine
    ```

5.  **Verify the deployment**:
    Check the status of your agent in the Vertex AI console or use:
    ```bash
    adk status
    ```
