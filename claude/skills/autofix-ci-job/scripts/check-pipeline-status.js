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
  console.error('Usage: node check-pipeline-status.js <project_id> <pipeline_id>');
  process.exit(1);
}

const api = new GitLabAPI(gitlabToken, gitlabUrl);

try {
  const pipeline = await api.getPipeline(projectId, pipelineId);

  console.log(pipeline.status.toUpperCase());
  console.log('\n---JSON---');
  console.log(JSON.stringify({
    status: pipeline.status,
    pipeline_id: pipeline.id,
    duration: pipeline.duration,
    created_at: pipeline.created_at,
    updated_at: pipeline.updated_at,
    web_url: pipeline.web_url,
  }, null, 2));
} catch (error) {
  if (error.message?.includes('Invalid')) {
    console.error('ERROR:', error.message);
    process.exit(1);
  }
  console.error('ERROR:', error.message);
  process.exit(1);
}
