import GitLabAPI from './gitlab-api.js';

const gitlabToken = process.env.GITLAB_TOKEN;
const gitlabUrl = process.env.GITLAB_API_URL || 'https://gitlab.com/api/v4';
const projectId = process.argv[2];
const mrIid = process.argv[3];

if (!gitlabToken) {
  console.error('Error: GITLAB_TOKEN env var required');
  process.exit(1);
}

if (!projectId || !mrIid) {
  console.error('Usage: node check-pipeline-status.js <project_id> <mr_iid>');
  process.exit(1);
}

const api = new GitLabAPI(gitlabToken, gitlabUrl);

try {
  const { data: pipelines } = await api.client.get(
    `/projects/${projectId}/merge_requests/${mrIid}/pipelines`
  );

  if (pipelines.length === 0) {
    console.log('NO_PIPELINE');
    process.exit(0);
  }

  const latest = pipelines[0];
  console.log(latest.status.toUpperCase());
  console.log('\n---JSON---');
  console.log(JSON.stringify({
    status: latest.status,
    pipeline_id: latest.id,
    created_at: latest.created_at,
    web_url: latest.web_url,
  }, null, 2));
} catch (error) {
  console.error('ERROR:', error.message);
  process.exit(1);
}
