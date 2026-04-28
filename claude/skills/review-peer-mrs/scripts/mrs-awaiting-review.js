#!/usr/bin/env node

/**
 * Fetch merge requests awaiting your review from GitLab.
 * Equivalent to: https://gitlab.com/dashboard/merge_requests?scope=all&state=opened&reviewer_username=alessio.marucci1&not[author_username]=alessio.marucci1
 *
 * Usage:
 *   GITLAB_API_TOKEN=your_token node scripts/mrs-awaiting-review.js
 *
 * Or add to your shell profile:
 *   export GITLAB_API_TOKEN=your_token
 */

const REVIEWER_USERNAME = 'alessio.marucci1';
const GITLAB_API_URL = process.env.GITLAB_API_URL || 'https://gitlab.com/api/v4';

async function getMRsAwaitingReview() {
  const token = process.env.GITLAB_NPM_TOKEN;

  if (!token) {
    console.error('Error: GITLAB_NPM_TOKEN not found in environment');
    console.error('Usage: GITLAB_NPM_TOKEN=your_token node scripts/mrs-awaiting-review.js');
    process.exit(1);
  }

  try {
    const allMRs = [];
    let page = 1;
    let hasMore = true;

    while (hasMore) {
      const params = new URLSearchParams({
        reviewer_username: REVIEWER_USERNAME,
        state: 'opened',
        scope: 'all',
        per_page: '100',
        page: String(page),
        order_by: 'updated_at',
        sort: 'desc',
      });

      const response = await fetch(`${GITLAB_API_URL}/merge_requests?${params}`, {
        headers: {
          'PRIVATE-TOKEN': token,
        },
      });

      if (!response.ok) {
        const error = await response.text();
        throw new Error(`API error: ${response.status} - ${error}`);
      }

      const data = await response.json();
      allMRs.push(...data);

      // Check for next page via Link header
      const linkHeader = response.headers.get('Link');
      hasMore = linkHeader?.includes('rel="next"') ?? false;
      page++;
    }

    // Filter out MRs where user is the author and only show MRs updated in past 2 weeks
    const twoWeeksAgo = new Date();
    twoWeeksAgo.setDate(twoWeeksAgo.getDate() - 14);

    const recentMRs = allMRs.filter(
      (mr) =>
        mr.author?.username !== REVIEWER_USERNAME &&
        !mr.author?.username?.toLowerCase().includes('renovate') &&
        new Date(mr.updated_at) >= twoWeeksAgo
    );

    // Check approval status for each MR
    const mrsToReview = [];
    for (const mr of recentMRs) {
      try {
        const approvalResponse = await fetch(
          `${GITLAB_API_URL}/projects/${mr.project_id}/merge_requests/${mr.iid}/approvals`,
          { headers: { 'PRIVATE-TOKEN': token } }
        );

        if (approvalResponse.ok) {
          const approvalData = await approvalResponse.json();
          // Check if approvals are required and if they've been satisfied
          const approvalsRequired = approvalData.approvals_required || 0;
          const approvalsGiven = approvalData.approvals_left || approvalsRequired;
          const hasApproval = approvalData.approved || approvalsGiven === 0;

          if (!hasApproval) {
            mrsToReview.push(mr);
          }
        } else {
          // If we can't check approval status, include the MR
          mrsToReview.push(mr);
        }
      } catch {
        // On error, include the MR
        mrsToReview.push(mr);
      }
    }

    console.log(`\nMRs awaiting your review (${mrsToReview.length}):\n`);
    console.log('─'.repeat(80));

    if (mrsToReview.length === 0) {
      console.log('No merge requests awaiting your review.');
      return;
    }

    for (const mr of mrsToReview) {
      const project = mr.references?.full || mr.web_url?.split('/-/')[0] || 'Unknown';
      const updatedAt = new Date(mr.updated_at).toLocaleDateString('en-GB', {
        day: '2-digit',
        month: 'short',
        year: 'numeric',
      });

      console.log(`\n!${mr.iid} ${mr.title}`);
      console.log(`   Branch: ${mr.source_branch}`);
      console.log(`   Project: ${project}`);
      console.log(`   Author: @${mr.author?.username || 'Unknown'}`);
      console.log(`   Updated: ${updatedAt}`);
      console.log(`   URL: ${mr.web_url}`);
    }

    console.log('\n' + '─'.repeat(80) + '\n');
  } catch (error) {
    console.error('Error fetching MRs:', error.message);
    process.exit(1);
  }
}

getMRsAwaitingReview();
