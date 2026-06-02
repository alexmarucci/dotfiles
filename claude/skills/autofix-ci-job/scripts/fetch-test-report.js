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
  console.error('Usage: node fetch-test-report.js <project_id> <pipeline_id>');
  process.exit(1);
}

const api = new GitLabAPI(gitlabToken, gitlabUrl);

try {
  const testReport = await api.getTestReport(projectId, pipelineId);

  if (!testReport) {
    console.log('NO_TEST_REPORT');
    process.exit(0);
  }

  const failedTests = testReport.test_cases.filter(t => t.status === 'failed');

  if (failedTests.length === 0) {
    console.log('No failed tests found');
    process.exit(0);
  }

  console.log(`Test Report: ${testReport.total_time}s`);
  console.log(`Total: ${testReport.total_count}, Failed: ${failedTests.length}\n`);

  console.log('---JSON---');
  console.log(JSON.stringify({
    total_time: testReport.total_time,
    total_count: testReport.total_count,
    success_count: testReport.success_count,
    failed_count: failedTests.length,
    failed_tests: failedTests.map(t => ({
      name: t.name,
      classname: t.classname,
      file: t.file,
      execution_time: t.execution_time,
      status: t.status,
      output: t.output,
      stack_trace: t.stack_trace,
    })),
  }, null, 2));
} catch (error) {
  if (error.response?.status === 404) {
    console.log('NO_TEST_REPORT');
    process.exit(0);
  }
  if (error.message?.includes('Invalid')) {
    console.error('ERROR:', error.message);
    process.exit(1);
  }
  console.error('ERROR:', error.message);
  process.exit(1);
}
