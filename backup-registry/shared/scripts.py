import argparse
import json
import pathlib
import sys
from logging import getLogger, basicConfig, INFO, ERROR
import csv

logger = getLogger("backup-registry")
basicConfig(level=ERROR, format="%(levelname)s: %(message)s")

REGISTRY_USERNAME = "upstride"
REGISTRY_PASSWORD = "secret"
REGISTRY_HOST = "localhost:5000"


def _request(path):
    """
    get object from registry API
    :param: path
    :return: json
    """
    return {}


def list_repo():
    """
    :return: prints into stdout or into a file
    """
    logger.info(f"list repos")

    return []


def list_tags(opt):
    """
    List tags from a repo
    :param opt:
    :return: prints into stdout or into a file
    """
    logger.info(f"loading <resources> csv file")
    return []


if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog="scripts")
    subparsers = parser.add_subparsers(help="select the action's command")
    sub = subparsers.add_parser("tags", help="list all tags into the registry")
    sub.add_argument("--output", "-o", help=f"output file", nargs="?", type=pathlib.Path)
    sub.set_defaults(func=list_tags())
    args = parser.parse_args(args=None if sys.argv[1:] else ['--help'])
    try:
        args.func(args)
    except Exception as e:
        raise e
        exit(2)
