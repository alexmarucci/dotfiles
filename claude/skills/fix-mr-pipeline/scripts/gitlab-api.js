import axios from 'axios';

export class GitLabAPI {
  constructor(token, baseUrl = 'https://gitlab.com/api/v4') {
    this.client = axios.create({
      baseURL: baseUrl,
      headers: {
        'PRIVATE-TOKEN': token,
      },
    });
  }
}

export default GitLabAPI;
