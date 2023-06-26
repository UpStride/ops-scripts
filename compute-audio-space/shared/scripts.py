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

THRESHOLD = 1.E-30
FRACTAL_DIVISION_LIMIT = 0.1


class Color:
    COLORS_PALETTE = [
        "xkcd:reddish orange", "xkcd:lime green",
        "xkcd:sky blue", "xkcd:neon blue",
        "xkcd:umber", "xkcd:golden yellow"
    ]

    def __init__(self):
        self.index = -1
        self.len = len(self.COLORS_PALETTE)

    def next(self):
        self.index += 1
        return self.COLORS_PALETTE[self.index % self.len]


color = Color()


def fft_audio(opt):
    """
    in: opt: command line option object.
            Attributes:
                 - audio: list of audio files
                 - output: output file path for fft plot
    """
    if opt.debug:
        logger.setLevel(DEBUG)
    _start_plot()
    # Plot in reverse order, so that the first fft is on top
    for i, a in enumerate(reversed(opt.audio)):
        logger.info(f"audio file: {a}")
        rate, audio_data = _read_audio(a)
        _plot_audio(rate=rate, audio_data=audio_data, label=a)
    _end_plot(opt)


def _start_plot():
    plot.figure(figsize=(20, 10))


def _end_plot(opt):
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


def _read_audio(file_name):
    try:
        with warnings.catch_warnings():
            warnings.filterwarnings("ignore", category=WavFileWarning)
            rate, audio_data = wavfile.read(file_name)
            return rate, audio_data
    except FileNotFoundError as error:
        logger.error(error)
        exit(2)
    except Exception:
        raise


def _plot_audio(rate, audio_data, label):
    n = len(audio_data)
    if len(audio_data.shape) == 2:
        amplitude = _scale(numpy.fft.fft(audio_data.sum(axis=1) / 2))
    else:
        amplitude = _scale(numpy.fft.fft(audio_data))  # take the fourier transform of left channel
    freq = numpy.arange(0, n, 1.0) * (rate / n) / 1000
    logger.info(f"#_freq={n}, min_freq={freq[0]}(khz), max_freq={freq[-1]}(khz)")
    plot.plot(freq, numpy.log10(amplitude), color=color.next(), label=label)
    return


if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog="scripts")
    subparsers = parser.add_subparsers(help="select the action's command")
    sub = subparsers.add_parser("fft", help="compute fft transform")
    sub.add_argument("--audio", "-a", help=f"audio(s) file", nargs="+", type=pathlib.Path)
    sub.add_argument("--show", "-s", help=f"show or hide plot", nargs=1, choices=['yes', 'no'], default='no')
    sub.add_argument("--debug", "-d", help=f"debug mode", action='store_true')
    sub.add_argument("--output", "-o", help=f"output fft", nargs="?", type=pathlib.Path)
    sub.set_defaults(func=fft_audio)
    args = parser.parse_args(args=None if sys.argv[1:] else ['--help'])
    try:
        args.func(args)
    except Exception as e:
        raise e
