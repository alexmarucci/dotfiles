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
  console.error('Usage: node get-pipeline-info.js <project_id> <pipeline_id>');
  process.exit(1);
}

const api = new GitLabAPI(gitlabToken, gitlabUrl);

try {
  const pipeline = await api.getPipeline(projectId, pipelineId);
  const jobs = await api.getPipelineJobs(projectId, pipelineId);
  const failedJobs = jobs.filter(j => j.status === 'failed');
  const duration = pipeline.duration || 0;

  console.log(`Pipeline: ${pipeline.id} - ${pipeline.status.toUpperCase()}`);
  console.log(`Duration: ${duration}s`);
  console.log(`Web URL: ${pipeline.web_url}`);
  console.log(`Failed Jobs: ${failedJobs.length}\n`);

  if (failedJobs.length > 0) {
    console.log('---JSON---');
    console.log(JSON.stringify({
      status: pipeline.status,
      pipeline_id: pipeline.id,
      duration: duration,
      web_url: pipeline.web_url,
      created_at: pipeline.created_at,
      updated_at: pipeline.updated_at,
      failed_jobs: failedJobs.map(j => ({
        id: j.id,
        name: j.name,
        stage: j.stage,
        failure_reason: j.failure_reason,
        duration: j.duration,
        web_url: j.web_url,
      })),
    }, null, 2));
  }
} catch (error) {
  if (error.message?.includes('Invalid')) {
    console.error('ERROR:', error.message);
    process.exit(1);
  }
  console.error('ERROR:', error.message);
  process.exit(1);
}
