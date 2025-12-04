"""
    read_instance(dataset::Dataset, name::String)

Read the instance identified by `name` from a given `dataset`.

Return a tuple `(data, path)` where `data isa QPSReader.QPSData` is an object created by [QPSReader.jl](https://github.com/JuliaSmoothOptimizers/QPSReader.jl) and `path` is the path to the MPS file.

# See also

- [`Dataset`](@ref)
"""
function read_instance(dataset::Dataset, name::String)
    if !(name in list_instances(dataset))
        throw(ArgumentError("Instance $name is not available in dataset $dataset: please use `list_instances` to find valid instance names."))
    end
    if dataset == MIPLIB2017
        return read_miplib2017_instance(name)
    elseif dataset == Netlib
        return read_netlib_instance(name)
    elseif dataset == MittelmannLP
        return read_mittelmann_lp_instance(name)
    elseif dataset == MarosMeszaros
        return read_marosmeszaros_instance(name)
    end
end

function read_miplib2017_instance(name::String)
    folder = if name in list_miplib2017_instances(; benchmark_only = true)
        datadep"miplib2017-benchmark"
    else
        datadep"miplib2017-collection"
    end
    name = lowercase(name)
    mps_gz_path = joinpath(folder, "$name.mps.gz")
    return read_mps(mps_gz_path; scratch_subfolder = "miplib2017")
end

function read_netlib_instance(name::String)
    name = uppercase(name)
    if name in ("BLEND", "DFL001", "FORPLAN", "GFRD-PNC", "SIERRA")
        # https://github.com/JuliaSmoothOptimizers/QPSReader.jl/issues/58
        mpsformat = :fixed
    else
        mpsformat = :free
    end
    netlib_path = fetch_netlib()
    sif_path = joinpath(netlib_path, "$name.SIF")
    return read_mps(sif_path; scratch_subfolder = "netlib", mpsformat)
end

function read_mittelmann_lp_instance(name::String)
    folder_path = @datadep_str("mittelmann-lp")
    mps_bz2_path1 = joinpath(folder_path, "$name.mps.bz2")
    mps_bz2_path2 = joinpath(folder_path, "$name.bz2")
    if ispath(mps_bz2_path1)
        return read_mps(mps_bz2_path1; scratch_subfolder = "mittelman-lp")
    elseif ispath(mps_bz2_path2)
        return read_mps(mps_bz2_path2; scratch_subfolder = "mittelman-lp")
    end
end

function read_marosmeszaros_instance(name::String)
    folder_path = datadep"marosmeszaros"
    qps_path = joinpath(folder_path, "$name.QPS")
    return read_mps(qps_path)
end

function read_mps(
        path::String;
        scratch_subfolder::Union{String, Nothing} = nothing,
        mpsformat::Symbol = :free
    )
    name = splitext(splitext(splitpath(path)[end])[1])[1]
    if !isnothing(scratch_subfolder) && !isdir(joinpath(MPS_SCRATCH, scratch_subfolder))
        mkdir(joinpath(MPS_SCRATCH, scratch_subfolder))
    end
    if endswith(path, ".gz") || endswith(path, ".bz2")
        mps_path = joinpath(MPS_SCRATCH, scratch_subfolder, "$name.mps")
        if !ispath(mps_path)
            if endswith(path, ".mps.gz")
                contents = GZip.open(path, "r") do f
                    read(f, String)
                end
            elseif endswith(path, ".mps.bz2")
                compressed = CodecBzip2.read(path)
                contents = String(CodecBzip2.transcode(CodecBzip2.Bzip2Decompressor, compressed))
            elseif endswith(path, ".bz2")
                throw(ArgumentError("File at $path not supported (not a compressed MPS file).\nIf you know how to handle these files, please open an issue at <https://github.com/JuliaDecisionFocusedLearning/MathOptBenchmarkInstances.jl/issues>."))
            end
            open(mps_path, "w") do f
                write(f, contents)
            end
        end
    elseif endswith(lowercase(path), ".mps") ||
            endswith(lowercase(path), ".qps") ||
            endswith(lowercase(path), ".sif")
        mps_path = path
    else
        throw(ArgumentError("Invalid file extension for $(splitpath(path)[end])"))
    end

    qps_data = with_logger(NullLogger()) do
        readqps(mps_path; mpsformat)
    end
    return qps_data, mps_path
end
