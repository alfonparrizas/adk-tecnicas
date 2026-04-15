---
description: How to run evaluation sets for the ADK agent.
---

# Run Evaluations

Evaluation is a critical part of agent development. Use this workflow to run your evalsets.

1.  **Define your evalset**:
    Create or update your evaluation set (e.g., in `evals/my_evalset.jsonl`).

2.  **Run the evaluation**:
    // turbo
    ```bash
    adk eval run --evalset evals/my_evalset.jsonl
    ```

3.  **Review the results**:
    The evaluation results will be displayed in the terminal and saved to the `eval_results/` directory.

4.  **Iterate**:
    Use the findings to refine your agent's tools, prompts, or logic.
