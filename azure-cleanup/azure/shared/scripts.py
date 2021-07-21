import argparse
import json
import pathlib
import sys
from logging import getLogger, basicConfig, INFO, ERROR
import csv

logger = getLogger("cleanup-azure")
basicConfig(level=ERROR, format="%(levelname)s: %(message)s")


def read_csv(opt):
    """
    :param opt:
    :return: prints into stdout or into a file
    """
    logger.info(f"loading <resources> csv file")
    resources = []
    with open(opt.source, newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            if opt.filter and row['Action'] == opt.filter or not opt.filter:
                resources.append(row['Resource Group'])
    if opt.output:
        with open(opt.output, 'w') as f:
            for row in resources:
                f.write("%s" % row)
    else:
        for row in resources:
            print("%s" % row)

    


if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog="scripts")
    subparsers = parser.add_subparsers(help="select the action's command")
    sub = subparsers.add_parser("read", help="read a resources csv file")
    sub.add_argument("--source", "-s", help=f"source file", nargs="?", required=True, type=pathlib.Path)
    sub.add_argument("--filter", "-f", help=f"action filter", nargs="?", type=str)
    sub.add_argument("--output", "-o", help=f"output file", nargs="?", type=pathlib.Path)
    sub.set_defaults(func=read_csv)
    args = parser.parse_args(args=None if sys.argv[1:] else ['--help'])
    try:
        args.func(args)
    except Exception as e:
        raise e
        exit(2)
