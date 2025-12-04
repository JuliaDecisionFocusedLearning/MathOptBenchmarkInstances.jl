"""
    Dataset

Enum type for mathematical programming datasets.

Possible values:

- [`MIPLIB2017`](@ref)
- [`Netlib`](@ref)
- [`MittelmannLP`](@ref)
- [`MarosMeszaros`](@ref)
"""
@enum Dataset MIPLIB2017 Netlib MittelmannLP MarosMeszaros

"""
    MIPLIB2017

Mixed Integer Linear Programs from the MIPLIB2017 collection dataset.

Source: <https://miplib.zib.de/tag_collection.html>.
"""
MIPLIB2017

"""
    Netlib

Linear Programs from the Netlib dataset.

Source: <https://www.netlib.org/lp/data/index.html>.
"""
Netlib

"""
    MittelmannLP

Linear Programs from the Mittelmann benchmark dataset.

Source: <https://plato.asu.edu/ftp/lptestset/>.
"""
MittelmannLP

"""
    MarosMeszaros

Quadratic Programs from the Maros-Meszaros benchmark dataset.

Source: <https://www.doc.ic.ac.uk/~im/#DATA>.
"""
MarosMeszaros
