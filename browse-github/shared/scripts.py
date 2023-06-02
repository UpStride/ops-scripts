import argparse
import base64
import json
import os
import pathlib
import sys
from logging import getLogger, basicConfig, ERROR, INFO
from urllib.request import Request, urlopen
from urllib.parse import urljoin

logger = getLogger("backup-registry")
basicConfig(level=INFO, format="%(levelname)s: %(message)s")


def _auth():
    """
    auth method for request
    """
    token = os.environ.get("GITHUB_TOKEN")
    username = os.environ.get("GITHUB_USERNAME")
    assert username
    assert token
    login = f"{username}:{token}".encode()
    return {"Authorization": f"Basic {base64.b64encode(login)}"}


def recursive_join(base: str, paths: list):
    logger.info(base)
    if len(paths) > 0:
        return recursive_join(urljoin(base, paths[0]), paths[1:])
    else:
        return base


def _build_endpoint(org, res="repos"):
    """
    build api endoint
    :param: org organization's name
    :param: res targeted resource
    :return: json
    """
    url_definitions = \
        {
            "repos": '/'.join(["https://api.github.com", "orgs", org, "repos"])
        }
    return url_definitions[res]


def _request(org, method="GET"):
    """
    get object from registry API
    :param: path
    :return: json
    """
    logger.info(f"hitting the endpoint {str(_build_endpoint(org))}")
    req = Request(_build_endpoint(org), method=method, headers={
        "Content-Type": "application/json",
        "Accept": "application/vnd.github.v3+json",
        **_auth()
    })
    try:
        resp = urlopen(req)
    except Exception:
        raise

    return json.loads(resp.read())


def list_repo(org):
    """
    :return: prints into stdout or into a file
    """
    repos = _request(org)
    for r in repos:
        logger.info(f"owner={r['owner']['login']}/ name={r['full_name']}")


def analyze_repos(opt):
    """
    List tags from a repo
    :param opt:
    :return: prints into stdout or into a file
    """
    logger.info(f'orga name={opt.org}')
    repos = list_repo(opt.org[0])


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


