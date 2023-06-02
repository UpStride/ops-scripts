import argparse
import base64
import json
import os
import pathlib
import sys
from logging import getLogger, basicConfig, INFO
from operator import itemgetter
from urllib.error import HTTPError
from urllib.request import Request, urlopen
from prettytable import PrettyTable

logger = getLogger("backup-registry")
basicConfig(level=INFO, format="%(levelname)s: %(message)s")
GITHUB_API = "https://api.github.com"


def _auth():
    """
    auth method for request
    """
    token = os.environ.get("GITHUB_TOKEN")
    username = os.environ.get("GITHUB_USERNAME")
    if token is None:
        raise Exception('GITHUB_TOKEN missing in the env')
    if username is None:
        raise Exception('GITHUB_USERNAME missing in the env')
    login = f"{username}:{token}".encode()
    return {"Authorization": f"Basic {base64.b64encode(login)}"}


def _build_endpoint(org, page_number=1):
    """
    build api endoint
    :param: org organization's name
    :param: res targeted resource
    :return: json
    """
    url_definitions = \
        {
            "repos": '/'.join([GITHUB_API, "orgs", org, "repos"]) + f"?page={page_number}&per_page=100"
        }
    return url_definitions["repos"]


def _request(org, previous_pages=None, page_number=1, method="GET"):
    """
    get object from registry API
    :param: path
    :return: json
    """
    if previous_pages is None:
        previous_pages = []
    _endpoint = _build_endpoint(org, page_number=page_number)
    req = Request(_endpoint, method=method, headers={
        "Content-Type": "application/json",
        "Accept": "application/vnd.github.v3+json",
        **_auth()
    })
    try:
        resp = urlopen(req)
    except HTTPError as error:
        logger.error(f"\n\tGithub server returned explicit error code:: {error.status}"
                     f"\n\tStopping the lookup..")
        return []
    except Exception:
        raise
    repos = json.loads(resp.read())
    logger.debug(f"new research total: {len(repos)}")
    if repos:
        return _request(org, previous_pages=previous_pages + repos, page_number=page_number + 1)
    else:
        return previous_pages


def list_repo(org):
    """
    :return: prints into stdout or into a file
    """
    repos = _request(org)
    if not repos:
        logger.info("no repos found")
        exit(0)
    logger.info(f"public repos total = {len(repos)}")
    output = PrettyTable()
    output.field_names = ["Name", "Stars", "Language", "url"]
    data = []
    for r in repos:
        data.append([r['name'], int(r['stargazers_count']), r['language'], r['html_url']])
    for c in sorted(data, key=itemgetter(1), reverse=True):
        output.add_row(c)
    logger.info("\n" + str(output))


def analyze_repos(opt):
    """
    List tags from a repo
    :param opt:
    :return: prints into stdout or into a file
    """
    logger.debug(f"organization's name: '{opt.org[0]}'")
    list_repo(opt.org[0])


if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog="scripts")
    subparsers = parser.add_subparsers(help="select the action's command")
    sub = subparsers.add_parser("list", help="list all repos into the organization github")
    sub.add_argument("--org", help=f"organization's name", nargs=1, required=True, type=str)
    sub.add_argument("--filter", "-f", help=f"filter list in csv file", nargs="?", type=pathlib.Path)
    sub.add_argument("--output", "-o", help=f"output file", nargs="?", type=pathlib.Path)
    sub.set_defaults(func=analyze_repos)
    args = parser.parse_args(args=None if sys.argv[1:] else ['--help'])
    try:
        args.func(args)
    except Exception as e:
        raise e
        exit(2)
