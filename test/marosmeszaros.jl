using MathOptBenchmarkInstances
using Test

maros_list = list_instances(MarosMeszaros)
@test length(maros_list) == 138

for name in maros_list
    if name in ["EXDATA", "QFORPLAN", "QGFRDXPN", "VALUES"]
        @test_broken read_instance(MarosMeszaros, name) isa Tuple{QPSData, String}
    else
        @test read_instance(MarosMeszaros, name) isa Tuple{QPSData, String}
    end
end
