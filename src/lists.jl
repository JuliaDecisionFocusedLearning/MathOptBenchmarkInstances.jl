"""
    list_instances(dataset::Dataset)

Return the names of all available instances in a given `dataset`.

# See also

- [`Dataset`](@ref)
"""
function list_instances(dataset::Dataset)
    if dataset == MIPLIB2017
        return list_miplib2017_instances()
    elseif dataset == Netlib
        return list_netlib_instances()
    elseif dataset == MittelmannLP
        return list_mittelmann_lp_instances()
    elseif dataset == MarosMeszaros
        return list_marosmeszaros_instances()
    end
end

function list_miplib2017_instances(; benchmark_only::Bool = false)
    list_path = if benchmark_only
        joinpath(datadep"miplib2017-benchmark-list", "benchmark-v2.test")
    else
        joinpath(datadep"miplib2017-collection-list", "collection-v1.test")
    end
    lines = open(list_path, "r") do file
        readlines(file)
    end
    return map(n -> string(chopsuffix(n, ".mps.gz")), lines)
end

function list_netlib_instances()
    netlib_path = fetch_netlib()
    valid_instances = filter(n -> endswith(n, ".SIF"), readdir(netlib_path))
    return map(n -> lowercase(chopsuffix(n, ".SIF")), valid_instances)
end

function list_mittelmann_lp_instances()
    all_names = reduce(vcat, MITTELMANN_LP_INSTANCES)
    return map(n -> string(chopsuffix(split(n, "/")[end], ".mps")), all_names)
end

function list_marosmeszaros_instances()
    return map(n -> string(chopsuffix(n, ".QPS")), readdir(datadep"marosmeszaros"))
end
