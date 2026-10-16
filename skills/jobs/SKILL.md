---
name: jobs
description: Add, schedule, run and watch jobs on Small Field. Use when the user wants a cron job, a nightly task, a background script, a scheduled report, or to run a job now and see if it worked.
---

# Jobs

A `job` is a script that runs to the end, on a schedule, on demand or both. Before writing config,
call `read_doc` with slug `jobs` for the exact fields and run rules.

## Steps

1. Add a `job` component to `smallfield.json` with `dir` and `command`.
   `command` is `"node run.js"`, `["node", "run.js"]`, or steps `[["node", "a.js"], "node b.js"]`
   that stop at the first failure.
2. Add `schedule` (a five-field cron line) for regular runs.
   Leave it out for on-demand only.
3. Set `timeoutSeconds` if a run may take over 600 seconds (max 21600).
4. Deploy, then `run_job` with `project` and `job` to start it now.
5. Read the run's output in the console under the environment, **Workflow runs**.
   Statuses: `queued`, `running`, `succeeded`, `failed`, `timed_out`, `skipped`.
6. Only one run of a job at a time; a scheduled run that overlaps is `skipped`. A failed script is
   not retried.

## Example

```json
"cleanup": {
  "kind": "job",
  "dir": "jobs",
  "command": ["node", "cleanup.js"],
  "schedule": "0 2 * * *"
}
```

The script can read `SF_RUN_ID` and `SF_JOB`.
