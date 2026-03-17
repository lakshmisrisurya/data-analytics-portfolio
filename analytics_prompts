# 🤖 LLM Prompts for Data Analytics — Prompt Library

> **Author: Lakshmi Surya | Lead Data Analyst**
> 
> A curated library of LLM prompts I use to accelerate analytics work across SQL development, BI design, stakeholder communication, and data strategy. These prompts are designed to work with Claude, ChatGPT, or any capable LLM.

---

## How to Use This Library

1. Copy a prompt template
2. Fill in the `[bracketed]` placeholders with your context
3. Paste into your LLM of choice
4. Iterate on the output with follow-up questions

**Pro tip:** Always include domain context (industry, company stage, tech stack) in your prompt — the more specific you are, the more useful the output.

---

## 📂 Category 1: SQL & Data Modeling

### 1.1 — SQL Query Builder
```
You are an expert SQL developer working in [Snowflake / BigQuery / Redshift / PostgreSQL].

I need to write a SQL query that:
- Source tables: [table names + key columns]
- Business logic: [describe what the query should compute]
- Output: [what columns should the result have]
- Performance constraints: [table size, SLA, partitioning available]

Please:
1. Write the SQL query using CTEs for readability
2. Add inline comments explaining the business logic
3. Flag any edge cases or data quality risks
4. Suggest indexes or clustering keys if applicable
```

### 1.2 — dbt Model Design
```
You are a senior dbt developer and analytics engineer.

I need to design a dbt model for: [describe the business metric or entity]
Source system: [Salesforce / NetSuite / application DB / etc.]
Target warehouse: [Snowflake / BigQuery]
Refresh cadence: [hourly / daily / real-time]

Please provide:
1. Which dbt layer this model belongs in (staging / intermediate / mart)
2. The full SQL for the model
3. The schema.yml tests I should add (not_null, unique, accepted_values, etc.)
4. Any ref() dependencies I should declare
5. How to handle incremental vs full refresh for this model
```

### 1.3 — Query Performance Debugger
```
You are a Snowflake query optimization expert.

This query is running slowly (taking [X] minutes):

[PASTE YOUR SLOW QUERY HERE]

Table sizes:
- [table_a]: [X] rows, [Y] GB
- [table_b]: [X] rows, [Y] GB

Please:
1. Identify the most likely performance bottlenecks
2. Rewrite the query with optimizations applied
3. Suggest warehouse size and clustering key recommendations
4. Explain the changes you made and why they help
```

---

## 📂 Category 2: BI & Dashboard Design

### 2.1 — Dashboard Requirements Extractor
```
I have a stakeholder meeting with [role: VP of Sales / CFO / Product Manager].
They have asked for "better visibility" into [topic area].

Act as a BI consultant facilitating a requirements gathering session.
Generate 10 clarifying questions I should ask this stakeholder to:
1. Understand what decisions this dashboard will drive
2. Identify the right metrics and granularity
3. Uncover any data availability concerns
4. Set realistic expectations on refresh frequency
5. Determine who else will use this dashboard

After the questions, also suggest what the dashboard's primary KPI and secondary metrics should likely be, based on the role.
```

### 2.2 — Metric Definition Writer
```
I need to write a clear, unambiguous definition for the following business metric:

Metric name: [e.g., "Net Revenue Retention"]
Business context: [SaaS company / healthcare / retail]
Intended audience: [Finance / Marketing / Executive / all teams]

Please write:
1. A plain-language definition (1–2 sentences, no jargon)
2. A precise technical definition with the formula
3. What is INCLUDED and EXCLUDED (edge cases)
4. The calculation frequency (daily / monthly / annual)
5. Who owns this metric
6. What a "healthy" vs "concerning" value looks like for our industry
```

### 2.3 — Dashboard Narrative Generator
```
You are a data analyst writing an automated commentary for an executive dashboard.

Here is this week's/month's data:
[PASTE KEY METRICS AND THEIR VALUES + PRIOR PERIOD VALUES]

Write a 2–3 sentence narrative that:
- Leads with the most important story (positive or negative)
- Quantifies the change and its likely cause
- Ends with what to watch or what action is underway

Tone: Direct, professional, no fluff. Assume the reader has 30 seconds.
```

---

## 📂 Category 3: Data Engineering & ETL

### 3.1 — Data Pipeline Architect
```
You are a senior data engineer specializing in modern data stacks.

I need to build a data pipeline with:
- Source: [system + connection type: REST API / database / file]
- Destination: [Snowflake / BigQuery / Redshift]
- Update frequency: [real-time / hourly / daily batch]
- Data volume: [approximate rows/day and GB]
- Team: [1 / 2–5 / 5+ engineers maintaining this]

Please recommend:
1. Best ingestion tool (Fivetran, Airbyte, custom Python, Kafka, etc.) and why
2. Error handling and retry strategy
3. Monitoring and alerting setup
4. How to handle schema changes in the source
5. Estimated cost considerations
```

### 3.2 — Data Quality Rule Generator
```
You are a data quality expert.

I have a table called [table_name] in [Snowflake / BigQuery] with these columns:
[PASTE COLUMN NAMES AND DATA TYPES]

This table represents: [describe what the data is]
It is used for: [describe downstream use cases]

Please generate:
1. A list of 10–15 data quality checks this table should have
2. For each check: the check name, what it validates, and the SQL assertion
3. Prioritize them by severity (ERROR vs WARNING)
4. Identify which checks should block pipeline completion vs. just alert
```

### 3.3 — Data Incident Root Cause Analyzer
```
We have a data quality incident. Here are the facts:

- Affected metric: [metric name]
- Symptom: [e.g., "ARR dropped by $2M overnight with no business explanation"]
- Tables involved: [list tables in the pipeline]
- Recent changes: [any recent deploys, source system changes, etc.]
- Time of first detection: [timestamp]

Act as a data incident commander. Help me:
1. List the 5 most likely root causes in order of probability
2. Write the diagnostic SQL queries I should run to investigate each
3. Draft the incident communication to send to stakeholders
4. Suggest process changes to prevent this class of incident in the future
```

---

## 📂 Category 4: Stakeholder Communication & Strategy

### 4.1 — Insight Communicator
```
I have found the following insight in my data analysis:

[Describe your finding in technical terms]

My audience: [CFO / VP Sales / Product Manager / All-hands]

Please help me communicate this finding as:
1. A one-sentence headline (for Slack / email subject)
2. A 3-bullet executive summary
3. A recommended action or next step
4. A FAQ anticipating the top 3 questions this audience will ask
```

### 4.2 — Analytics Roadmap Prioritizer
```
You are a Head of Analytics helping prioritize a backlog of analytics requests.

Here are our pending requests:
[List your analytics requests with requester, business impact, and effort estimate]

Prioritization criteria:
- Business impact (revenue / cost / risk)
- Data availability and readiness
- Stakeholder urgency
- Strategic alignment with company OKRs: [list OKRs]

Please:
1. Score each request across these dimensions
2. Recommend a prioritized sequence
3. Flag any requests that need more scoping before they can start
4. Identify quick wins (high impact, low effort)
```

### 4.3 — LLM Use Case Identifier for Analytics Teams
```
You are a data analytics expert who also deeply understands LLM capabilities.

My team is a [size]-person analytics team supporting [functions: Finance / GTM / Product].
Our current tools: [BI tool, data warehouse, ETL tool]
Our biggest pain points: [list 3–5 pain points]

Please identify:
1. The top 5 highest-value LLM use cases for our analytics team right now
2. For each use case:
   - What problem it solves
   - What tools/APIs would be needed
   - Estimated time to implement
   - Risks or limitations to be aware of
3. Which use cases should we NOT pursue with LLMs (and why)
```

---

## 📂 Category 5: AI-Assisted Analytics Workflows

### 5.1 — Automated Insight Generation (Python + LLM API)

```python
# Example: Call Claude API to generate narrative insights from metrics data
import anthropic
import json

def generate_metrics_narrative(metrics: dict, audience: str = "executive") -> str:
    """
    Use Claude to generate a human-readable narrative from a metrics dictionary.
    
    Parameters
    ----------
    metrics : dict
        Key-value pairs of metric names and their current + prior values.
        Example: {"ARR": {"current": 12_000_000, "prior": 10_500_000}}
    audience : str
        Target audience for the narrative tone.
    
    Returns
    -------
    str
        A plain-English narrative summary of the metrics.
    """
    client = anthropic.Anthropic()
    
    metrics_text = json.dumps(metrics, indent=2)
    
    prompt = f"""
    You are a data analyst writing an executive summary for a {audience} audience.
    
    Here are the current metrics vs. prior period:
    {metrics_text}
    
    Write a 2-3 sentence narrative that:
    1. Leads with the most important story
    2. Quantifies changes with specifics
    3. Ends with what to watch or action underway
    
    Tone: Direct, professional, data-grounded. No fluff. No headers.
    """
    
    message = client.messages.create(
        model="claude-opus-4-5",
        max_tokens=300,
        messages=[{"role": "user", "content": prompt}]
    )
    
    return message.content[0].text


# Example usage
if __name__ == "__main__":
    sample_metrics = {
        "ARR": {"current": 12_000_000, "prior": 10_500_000, "unit": "USD"},
        "NRR": {"current": 118, "prior": 114, "unit": "%"},
        "New Customers": {"current": 28, "prior": 22, "unit": "count"},
        "Churn Rate": {"current": 1.8, "prior": 2.1, "unit": "%"},
    }
    
    narrative = generate_metrics_narrative(sample_metrics, audience="CFO")
    print(narrative)
```

---

## 🏷️ Tags Index

| Tag | Relevant Prompts |
|-----|-----------------|
| `#sql` | 1.1, 1.2, 1.3 |
| `#dbt` | 1.2, 3.1 |
| `#snowflake` | 1.3, 3.1 |
| `#dashboard` | 2.1, 2.2, 2.3 |
| `#saas-metrics` | 2.2, 4.1 |
| `#data-quality` | 3.2, 3.3 |
| `#stakeholder` | 4.1, 4.2 |
| `#python` | 5.1 |
| `#llm-use-cases` | 4.3, 5.1 |
