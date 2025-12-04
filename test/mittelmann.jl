using MathOptBenchmarkInstances
using QPSReader
using Test

mittelmann_list = list_instances(MittelmannLP)
@test length(mittelmann_list) == 116

# only instances under 10M, most from the main list and one or two from each subfolder
# files that are .bz2 (as opposed to .mps.bz2) don't work for now

mittelmann_small = [
    # "Linf_520c",
    # "bdry2",
    "brazil3",
    "chromaticindex1024-7",
    "datt256_lp",
    "ex10",
    "bal8x12",
    "n370a",
    # "fome11",
    # "fome13",
    "graph40-40",
    "irish-electricity",
    # "cont1",
    # "neos",
    # "ns1687037",
    # "sgpf5y6",
    # "watson_1",
    "neos-5052403-cygnet",
    "neos-5251015",
    "16_n14",
    "lo10",
    # "nug08-3rd",
    # "pds-20",
    "physiciansched3-3",
    "qap15",
    # "rail507",
    "rmine15",
    "s100",
    "s250r10",
    "savsched1",
    "supportcase10",
    "woodlands09",
]

for name in mittelmann_small
    @test name in mittelmann_list
    @test read_instance(MittelmannLP, name) isa Tuple{QPSData, String}
end

@test_throws ArgumentError read_instance(MittelmannLP, "bdry2")
