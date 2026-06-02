import axios from 'axios';

export class GitLabAPI {
  constructor(token, baseUrl = 'https://gitlab.com/api/v4') {
    this.client = axios.create({
      baseURL: baseUrl,
      headers: {
        'PRIVATE-TOKEN': token,
      },
      timeout: 30000,
    });
  }

  async getPipeline(projectId, pipelineId) {
    this._validateNumeric(projectId, 'project ID');
    this._validateNumeric(pipelineId, 'pipeline ID');
    const { data } = await this.client.get(
      `/projects/${projectId}/pipelines/${pipelineId}`
    );
    return data;
  }

  async getPipelineJobs(projectId, pipelineId) {
    this._validateNumeric(projectId, 'project ID');
    this._validateNumeric(pipelineId, 'pipeline ID');
    const { data } = await this.client.get(
      `/projects/${projectId}/pipelines/${pipelineId}/jobs`
    );
    return data;
  }

  async getJobTrace(projectId, jobId) {
    this._validateNumeric(projectId, 'project ID');
    this._validateNumeric(jobId, 'job ID');
    const { data } = await this.client.get(
      `/projects/${projectId}/jobs/${jobId}/trace`
    );
    return data;
  }

  async getTestReport(projectId, pipelineId) {
    this._validateNumeric(projectId, 'project ID');
    this._validateNumeric(pipelineId, 'pipeline ID');
    try {
      const { data } = await this.client.get(
        `/projects/${projectId}/pipelines/${pipelineId}/test_report`
      );
      return data;
    } catch (error) {
      if (error.response?.status === 404) {
        return null;
      }
      throw error;
    }
  }

  async getProject(projectId) {
    this._validateNumeric(projectId, 'project ID');
    const { data } = await this.client.get(`/projects/${projectId}`);
    return data;
  }

  _validateNumeric(value, name) {
    if (!/^\d+$/.test(String(value))) {
      throw new Error(`Invalid ${name} (must be numeric): ${value}`);
    }
  }
}

export default GitLabAPI;
