import argparse
import pathlib
import sys
from logging import getLogger, basicConfig, INFO, DEBUG, ERROR
import warnings

from scipy.io.wavfile import WavFileWarning

logger = getLogger("compute-audio-space")
basicConfig(level=ERROR, format="%(levelname)s: %(message)s")

import matplotlib.pyplot as plot
from scipy.io import wavfile
import numpy

COLORS = "rgbcmykw"
COLORS_PALETTE = ["xkcd:reddish orange", "xkcd:lime green", "xkcd:sky blue",
                  "xkcd:neon blue", "xkcd:umber", "xkcd:golden yellow"]
LEN_COLORS = len(COLORS_PALETTE)
THRESHOLD = 1.E-30


def transform_audio(opt):
    """
    in: opt: command line option object.
            Attributes:
                 - audio: list of audio files
                 - output: output file path for fft plot
    """
    if opt.debug:
        logger.setLevel(DEBUG)
    plot.figure(figsize=(20, 10))
    # Plot in reverse order, so that the first fft is on top
    for i, a in enumerate(reversed(opt.audio)):
        logger.info(f"audio file: {a}")
        _plot_audio(file_name=a, color=COLORS_PALETTE[i % LEN_COLORS])
    plot.legend()
    plot.xlabel('Channel_Frequency (kHz)')
    plot.ylabel('Channel_Power (dB)')
    logger.debug(f"show option: {opt.show}")
    if opt.show[0] == 'yes':
        plot.show()
    logger.debug(f"output: {opt.output}")
    plot.savefig(opt.output)


def _scale(arr: numpy.array):
    """
    in: complex numpy array
    """
    # Scaling formulae: |arr| / n + delta
    #   A delta is added to remove null values
    return numpy.absolute(arr) / float(len(arr)) + THRESHOLD


def _scale_re(arr: numpy.array):
    """
    in: complex numpy array
    """
    # Scaling formulae: |Re(arr)| / n + delta
    #   A delta is added to remove null values
    return numpy.abs(numpy.real(arr)) / float(len(arr)) + THRESHOLD


def _plot_audio(file_name, color):
    try:
        with warnings.catch_warnings():
            warnings.filterwarnings("ignore", category=WavFileWarning)
            rate, audiodata = wavfile.read(file_name)
    except FileNotFoundError as e:
        logger.error(e)
        return
    n = len(audiodata)
    if len(audiodata.shape) == 2:
        amplitude = _scale(numpy.fft.fft(audiodata.sum(axis=1) / 2))
    else:
        amplitude = _scale(numpy.fft.fft(audiodata))  # take the fourier transform of left channel
    freq = numpy.arange(0, n, 1.0) * (rate / n) / 1000
    logger.info(f"#_freq={n}, min_freq={freq[0]}(khz), max_freq={freq[-1]}(khz)")
    plot.plot(freq, numpy.log10(amplitude), color=color, label=file_name)
    return


if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog="scripts")
    subparsers = parser.add_subparsers(help="select the action's command")
    sub = subparsers.add_parser("fft", help="compute fft transform")
    sub.add_argument("--audio", "-a", help=f"audio(s) file", nargs="+", type=pathlib.Path)
    sub.add_argument("--show", "-s", help=f"show or hide plot", nargs=1, choices=['yes', 'no'], default='no')
    sub.add_argument("--debug", "-d", help=f"debug mode", action='store_true')
    sub.add_argument("--output", "-o", help=f"output fft", nargs="?", type=pathlib.Path)
    sub.set_defaults(func=transform_audio)
    args = parser.parse_args(args=None if sys.argv[1:] else ['--help'])
    try:
        args.func(args)
    except Exception as e:
        raise e
