#!/usr/bin/env python3

# based on: https://gist.githubusercontent.com/minimal/3799247/raw/b960a004e3b44ed34c39a5d35a3f57bc26f75e1e/githubstatus.py

import logging
import json
import argparse
import os

import requests

logging.basicConfig(level=logging.INFO)
log = logging.getLogger('main')
log.setLevel(logging.INFO)

github_base = "https://api.github.com"
github_status_url = github_base + "/repos/{repo_name}/statuses/{sha}?access_token={token}"

token = os.environ.get("GITHUB_STATUS_ACCESS_TOKEN", 'PUT_DEFAULT_TOKEN_HERE')

allowed_repos = ["voteflux/voting_app"]

def update_status(repo_name, sha, state, desc, context, target_url=None):

    log.info(f"Args: {[repo_name, sha, state, desc, context]}")

    if repo_name not in allowed_repos:
      raise Exception(f"Updating statuses on repo named '{repo_name}' is forbidden")

    url = github_status_url.format(repo_name=repo_name,
                                   sha=sha, token=token)
    params = dict(state=state,
                  description=desc,
                  context=context)

    if target_url:
        params["target_url"] = target_url

    headers = {"Content-Type": "application/json"}

    log.info("Setting status on %s/%s to %s (context: %s), description: %s", repo_name, sha, state, context, desc)

    requests.post(url,
                  data=json.dumps(params),
                  headers=headers)



def main():
    parser = argparse.ArgumentParser(description='Set github status')
    parser.add_argument('--repo', required=True, help="user/repo")
    parser.add_argument('--sha', required=True)
    parser.add_argument('--desc', required=True, help="Description to send to GitHub")
    parser.add_argument('--context', default=os.environ.get("GITHUB_STATUS_CONTEXT", None), help="Context to differentiate status messages")

    def status_type(status):
        if status in ('pending', 'success', 'error', 'failure'):
            return status

        log.error("Allowed statuses: {pending', 'success', 'error', 'failure'}")
        raise ValueError()

    parser.add_argument('--status', type=status_type, required=True)
    parser.add_argument('--url', help="Job url")

    args = parser.parse_args()

    update_status(args.repo, args.sha, args.status, args.desc, args.context, target_url=args.url)

if __name__ == '__main__':
  try:
    main()
  except Exception as e:
    log.error(f"Exception: {e}")
