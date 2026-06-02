import GitLabAPI from './gitlab-api.js';

const gitlabToken = process.env.GITLAB_TOKEN;
const gitlabUrl = process.env.GITLAB_API_URL || 'https://gitlab.com/api/v4';
const projectId = process.argv[2];
const pipelineId = process.argv[3];

if (!gitlabToken) {
  console.error('Error: GITLAB_TOKEN env var required');
  process.exit(1);
}

if (!projectId || !pipelineId) {
  console.error('Usage: node fetch-job-logs.js <project_id> <pipeline_id>');
  process.exit(1);
}

const api = new GitLabAPI(gitlabToken, gitlabUrl);

try {
  const jobs = await api.getPipelineJobs(projectId, pipelineId);
  const failedJobs = jobs.filter(j => j.status === 'failed');

  if (failedJobs.length === 0) {
    console.log('No failed jobs found');
    process.exit(0);
  }

  const results = [];
  for (const job of failedJobs) {
    let trace = '';
    try {
      trace = await api.getJobTrace(projectId, job.id);
      trace = trace.split('\n').slice(-200).join('\n');
    } catch {
      trace = 'Could not fetch job trace';
    }

    results.push({
      id: job.id,
      name: job.name,
      stage: job.stage,
      status: job.status,
      failure_reason: job.failure_reason,
      duration: job.duration,
      web_url: job.web_url,
      trace,
    });
  }

  console.log(`Found ${failedJobs.length} failed job(s):\n`);
  for (const r of results) {
    console.log(`  ${r.name} (${r.stage}) - ${r.failure_reason || 'unknown'}`);
    console.log(`  Duration: ${r.duration}s`);
    console.log(`  ${r.web_url}\n`);
  }

  console.log('---JSON---');
  console.log(JSON.stringify(results, null, 2));
} catch (error) {
  if (error.message?.includes('Invalid')) {
    console.error('ERROR:', error.message);
    process.exit(1);
  }
  console.error('ERROR:', error.message);
  process.exit(1);
}
