import argparse
import pathlib
import sys
import urllib
from logging import getLogger, basicConfig, ERROR, INFO
from urllib.parse import urljoin

logger = getLogger("download-videos")
basicConfig(level=ERROR, format="%(levelname)s: %(message)s")

YOUTUBE = "https://youtu.be/"


def check_urls(opt):
    """
    check urls
    :param opt:
    :return: prints into stdout or into a file
    """
    with open(opt.urls[0]) as f:
        urls = f.readlines()
    logger.info(f"# urls ={len(urls)}")
    clean_list = []
    for u in urls:
        try:
            up = urllib.parse.urlparse(u)
            if up.query:
                qs = urllib.parse.parse_qs(up.query)
                clean = YOUTUBE + qs['v'][0]
            else:
                clean = urllib.parse.urlunparse(up)
            clean_list.append(clean)
            print(clean)
        except Exception as err:
            logger.error(err)
    logger.info(f"# cleaned ={len(clean_list)}")
    print(" ".join(clean_list))
    if opt.output :
        with open(opt.output[0]) as f:
            f.writelines(clean_list)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog="scripts")
    subparsers = parser.add_subparsers(help="select the action's command")
    sub = subparsers.add_parser("check", help="check urls videos are valid")
    sub.add_argument("--urls", help=f"urls file", nargs=1, required=True, type=pathlib.Path)
    sub.add_argument("--output", "-o", help=f"output file", nargs="?", type=pathlib.Path)
    sub.set_defaults(func=check_urls)
    args = parser.parse_args(args=None if sys.argv[1:] else ['--help'])
    try:
        args.func(args)
    except Exception as e:
        raise e
        exit(2)
