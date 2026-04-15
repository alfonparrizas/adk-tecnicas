---
description: How to configure your AI coding assistant with the ADK Docs MCP Server.
---

# ADK Docs MCP Server Setup

To get the most out of this template, you should connect your AI coding assistant (Antigravity, Cursor, etc.) to the official ADK documentation using the Model Context Protocol (MCP).

## Setup for Antigravity

1.  Open the **MCP store** via the **...** (more) menu at the top of the editor's agent panel.
2.  Click on **Manage MCP Servers**, then **View raw config**.
3.  Add the following to your `mcp_config.json`:

    ```json
    {
      "mcpServers": {
        "adk-docs-mcp": {
          "command": "uvx",
          "args": [
            "--from",
            "mcpdoc",
            "mcpdoc",
            "--urls",
            "AgentDevelopmentKit:https://google.github.io/adk-docs/llms.txt",
            "--transport",
            "stdio"
          ]
        }
      }
    }
    ```

## Setup for Cursor / Other Tools

The configuration is identical. Adapt the JSON above to your tool's MCP settings (e.g., `mcp.json` in Cursor).

## Why is this important?

With the MCP server connected, your AI assistant can:
- **Search and read** the latest ADK documentation in real-time.
- **Provide accurate code patterns** based on the official spec.
- **Help you debug** issues using up-to-date documentation.
