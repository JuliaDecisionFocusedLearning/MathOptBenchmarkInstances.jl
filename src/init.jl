MPS_SCRATCH = ""

function __init__()
    global MPS_SCRATCH = @get_scratch!("mps_scratch")
    # MIPLIB 2017
    register(
        DataDep(
            "miplib2017-collection",
            """
            All instances in the MIPLIB 2017 collection set.
            Source: https://miplib.zib.de/index.html.
            Compressed download size: 3.5 GB
            Decompressed size: ?? GB""",
            "https://miplib.zib.de/downloads/collection.zip",
            post_fetch_method = unpack,
        ),
    )
    register(
        DataDep(
            "miplib2017-benchmark",
            """
            All instances in the MIPLIB 2017 benchmark set.
            Source: https://miplib.zib.de/index.html.
            Compressed download size: 317 MB
            Decompressed size: 639 MB""",
            "https://miplib.zib.de/downloads/benchmark.zip",
            "c756eefd544d83b31809306b45d3549a1a5b9378e6aa78b68738b1a3b6a418fa",
            post_fetch_method = unpack,
        ),
    )
    register(
        DataDep(
            "miplib2017-collection-list",
            """
            List of instances in the MIPLIB 2017 collection.
            Source: https://miplib.zib.de/index.html.""",
            "https://miplib.zib.de/downloads/collection-v1.test",
            "c416f857083e2b7ec6edad87acc80437e2ea4be65debdbe7c4f3072881981c3f"
        ),
    )
    register(
        DataDep(
            "miplib2017-benchmark-list",
            """
            List of instances in the MIPLIB 2017 benchmark.
            Source: https://miplib.zib.de/index.html.""",
            "https://miplib.zib.de/downloads/benchmark-v2.test",
            "0ee9758dba64bb1689cc121c794ee547992a046bcabe1cce9ea79158375dabd5"
        ),
    )
    # Mittelmann
    register(
        DataDep(
            "mittelmann-lp",
            """
            All instances in the Mittelmann LP benchmark set.
            Source: https://plato.asu.edu/ftp/lptestset/.
            Compressed download size: ??
            Decompressed size: 2.21 GB""",
            map(
                path -> "https://plato.asu.edu/ftp/lptestset/$path.bz2",
                MITTELMANN_LP_INSTANCES
            ),
        )
    )
    # Maros-Meszaros
    register(
        DataDep(
            "marosmeszaros",
            """
            All instances in the Maros-Meszaros QP benchmark set.
            Source: https://www.doc.ic.ac.uk/~im/#DATA.
            Compressed download size: 28.1 MB.
            Decompressed size: ??""",
            [
                "http://www.doc.ic.ac.uk/%7Eim/QPDATA1.ZIP",
                "http://www.doc.ic.ac.uk/%7Eim/QPDATA2.ZIP",
                "http://www.doc.ic.ac.uk/%7Eim/QPDATA3.ZIP",
            ];
            post_fetch_method = [unpack, unpack, unpack]
        )
    )
    return nothing
end
