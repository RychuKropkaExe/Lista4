

using Random

function min_maks(arr::Array)
    len = length(arr)
    mins = Array{Union{Int,Nothing},1}(nothing,ceil(Int,len/2))
    maks = Array{Union{Int,Nothing},1}(nothing,ceil(Int,len/2))
    flag = len % 2
    for i in 1:2:(len - flag)
        if arr[i] >= arr[i+1]
            mins[ceil(Int,i/2)] = arr[i+1]
            maks[ceil(Int,i/2)] = arr[i]
        else
            mins[ceil(Int,i/2)] = arr[i]
            maks[ceil(Int,i/2)] = arr[i+1]
        end
    end
    maks[ceil(Int,len/2)] = arr[len]
    mins[ceil(Int,len/2)] = arr[len]
    return (maximum(maks),minimum(mins))
end

function better_min_maks(arr::Array, n::Int)
    min = arr[1]
    maks = arr[1]
    flag = n % 2
    for i in 1:2:n-flag
        if arr[i] >= arr[i+1]
            if arr[i] > maks 
                maks = arr[i]
            end
            if arr[i+1] < min
                min = arr[i+1]
            end
        else
            if arr[i+1] > maks 
                maks = arr[i+1]
            end
            if arr[i] < min
                min = arr[i]
            end
        end
    end
    if flag == 1 
        if arr[n] > maks
            maks = arr[n]
        end
        if arr[n] < min
            min = arr[n]
        end
    end
    return (min, maks)
end



function randomArray(len)
    rng = MersenneTwister()
    array = rand(0:(2*len-1), len)
    return array
end
arr = randomArray(101)
println(maximum(arr))
println(minimum(arr))
println(better_min_maks(arr, length(arr)))