info "=> dependencies check"
ffmpeg -version >/dev/null 2>/dev/null || { info "xxx missing dependency ffmpeg\n"; exit 2; }
python3 --version | grep -E "Python 3.([1-9]|1[0-1])\..*" >/dev/null \
    ||  { info "Python version is not between 3.0 and 3.11 [detected: $(python3 --version)]"; exit 2; }
python3 -c "import scipy" >/dev/null 2>/dev/null \
    || { info "scipy not present. installing .."; python3 -m pip install scipy >/dev/null 2>/dev/null; }
python3 -c "import matplotlib" >/dev/null 2>/dev/null \
    || { info "matplotlib not present. installing .."; python3 -m pip install matplotlib >/dev/null 2>/dev/null; }
python3 -c "import numpy" >/dev/null 2>/dev/null \
    || { info "numpy not present. installing .."; python3 -m pip install numpy >/dev/null 2>/dev/null; }