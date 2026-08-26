using MathOptBenchmarkInstances
using QPSReader
using Test

miplib_list = list_instances(MIPLIB2017)
@test length(miplib_list) == 1065

miplib_benchmark_list = MathOptBenchmarkInstances.list_miplib2017_instances(; benchmark_only = true)
@test length(miplib_benchmark_list) == 240

for name in miplib_benchmark_list[1:10]
    @test read_instance(MIPLIB2017, name) isa Tuple{QPSData, String}
end

# mixed-case
@test read_instance(MIPLIB2017, "beasleyC3") isa Tuple{QPSData, String}
