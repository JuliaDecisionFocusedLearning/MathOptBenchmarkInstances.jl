# MathProgBenchmarks.jl

A Julia package for automatic download and parsing of linear, quadratic and integer programming instances.

## Principle

Supported datasets:

- [x] [Netlib](https://www.netlib.org/lp/data/index.html)
- [x] [MIPLIB 2017](https://miplib.zib.de/index.html)
- [ ] [Mittelman benchmark](https://plato.asu.edu/ftp/lptestset/)

The source files are downloaded automatically thanks to [DataDeps.jl](https://github.com/oxinabox/DataDeps.jl).
The returned problem format is `QPSData` from [QPSReader.jl](https://github.com/JuliaSmoothOptimizers/QPSReader.jl).

## Getting started

To see which instances are available, call `list_instances(dataset, name)`.

To read a specific instance, call `read_instance(dataset, name)`.

More details are available in the docstrings of these functions.
