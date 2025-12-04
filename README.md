# MathOptBenchmarkInstances.jl

[![Build Status](https://github.com/JuliaDecisionFocusedLearning/MathOptBenchmarkInstances.jl/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/JuliaDecisionFocusedLearning/MathOptBenchmarkInstances.jl/actions/workflows/test.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/JuliaDecisionFocusedLearning/MathOptBenchmarkInstances.jl/branch/main/graph/badge.svg)](https://app.codecov.io/gh/JuliaDecisionFocusedLearning/MathOptBenchmarkInstances.jl)
[![code style: runic](https://img.shields.io/badge/code_style-%E1%9A%B1%E1%9A%A2%E1%9A%BE%E1%9B%81%E1%9A%B2-black)](https://github.com/fredrikekre/Runic.jl)
[![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

A Julia package for automatic download and parsing of linear, quadratic and integer programming instances.

## Datasets

Please read and abide by the license of the dataset you plan to use.

### LP

- [x] [Netlib](https://www.netlib.org/lp/data/index.html)
- [x] [Mittelmann LP benchmark](https://plato.asu.edu/ftp/lptestset/)

### MILP

- [x] [MIPLIB 2017](https://miplib.zib.de/index.html)

### QP

- [x] [Maros-Meszaros](https://www.doc.ic.ac.uk/~im/#DATA)
- [ ] [QPLIB](https://qplib.zib.de/)

## Getting started

1. To list the datasets available, call `values(Dataset)`.
2. To list the instances from a `dataset`, call `list_instances(dataset)`.
3. To read a specific instance given its `name`, call `read_instance(dataset, name)`. The return value is a tuple `(problem, path)` where `problem isa QPSData` from [QPSReader.jl](https://github.com/JuliaSmoothOptimizers/QPSReader.jl) and `path` points to the decompressed source file on your computer.

See the docstrings for details.

## Tips

The problem source files are downloaded automatically thanks to [DataDeps.jl](https://github.com/oxinabox/DataDeps.jl).
Note that each download has to be validated manually from the REPL.
This doesn't work well when the triggering line of code is executed with VSCode's Julia extension, you better run it in the REPL directly.
An alternative is to set `ENV["DATADEPS_ALWAYS_ACCEPT"] = true`.

The decompressed instances can be rather large (over 80 GB for the complete MIPLIB 2017 collection).
If you need to clean up some space, you can delete unneeded files inside the folder located at `MathOptBenchmarkInstances.MPS_SCRATCH`.

## Contributing

To contribute a new dataset:

1. Add its name to the `Dataset` enum.
2. Register a new `DataDep` inside the `__init__()` function of the package.
3. Implement a reader based on the files downloaded by the `DataDep`. This part might need decompression or file conversion steps, for which you can use the `MPS_SCRATCH` folder.
4. Write documentation and tests.

You can (and should) draw inspiration from the implementation of existing datasets.
