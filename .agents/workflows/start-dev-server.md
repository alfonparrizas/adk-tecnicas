---
description: Starting the local runtime for development.
---

# Start Local Dev Server

Run your agent locally to test interactions and debug.

1.  **Ensure virtual environment is active**:
    Your environment must be active to ensure consistent dependencies.
    ```bash
    source .venv/bin/activate
    ```

2.  **Ensure dependencies are installed**:
    ```bash
    pip install -e .
    ```

2.  **Start the ADK runtime**:
    // turbo
    ```bash
    adk run --local
    ```

3.  **Interact with your agent**:
    Once the server is running, you can send requests to it using the ADK CLI or a web interface if configured.

4.  **Debug**:
    Check the logs in the terminal for real-time feedback on agent behavior.
