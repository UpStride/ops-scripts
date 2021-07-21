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
basicConfig(level=ERROR, format="%(levelname)s: %(message)s")

REGISTRY_USERNAME = os.environ.get("REGISTRY_USERNAME")
REGISTRY_PASSWORD = os.environ.get("REGISTRY_PASSWORD")
REGISTRY_HOST = os.environ.get("REGISTRY_HOST", "http://localhost:5000")


def _request(host, location):
    """
    get object from registry API
    :param: path
    :return: json
    """
    auth = {"Authorization": f"Basic {base64.b64encode(f'{REGISTRY_USERNAME:REGISTRY_PASSWORD}')}"} \
        if REGISTRY_USERNAME and REGISTRY_PASSWORD else {}
    api = urljoin(REGISTRY_HOST, "/v2/")
    endpoint = urljoin(api, location)
    logger.info(f"hitting the endpoint {endpoint}")
    req = Request(endpoint, method="GET", headers={
        "Content-Type": "application/json",
        **auth
    })
    try:
        resp = urlopen(req)
    except Exception:
        raise

    return json.loads(resp.read())


def list_repo(host):
    """
    :return: prints into stdout or into a file
    """
    return _request(host, "_catalog").get("repositories", [])


def list_tags(opt):
    """
    List tags from a repo
    :param opt:
    :return: prints into stdout or into a file
    """
    repos = list_repo(opt.host)
    logger.info("\nrepos list:" + "".join(map(lambda s: f"\n{s}", repos)))
    tags = []
    for r in repos:
        content = _request(opt.host, f"{r}/tags/list")
        logger.info(content)
        tags += list(map(lambda t: f"{r}:{t}", content.get("tags")))
    if opt.output:
        with open(opt.output, 'w') as f:
            for row in tags:
                f.write("%s" % row)
    else:
        for row in tags:
            print("%s" % row)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog="scripts")
    subparsers = parser.add_subparsers(help="select the action's command")
    sub = subparsers.add_parser("list", help="list all dockers into the registry")
    sub.add_argument("--host", help=f"registry host", nargs=1, required=True, type=pathlib.Path)
    sub.add_argument("--output", "-o", help=f"output file", nargs="?", type=pathlib.Path)
    sub.set_defaults(func=list_tags)
    args = parser.parse_args(args=None if sys.argv[1:] else ['--help'])
    try:
        args.func(args)
    except Exception as e:
        raise e
        exit(2)
