include("SplayTree.jl")
using Base
using Crayons.Box
global left_trace = Array{Char,1}()
global right_trace = Array{Char,1}()
function print_SPT(root::Union{SPT,Nothing},depth::Int,prefix::Char)
    if isnothing(root) 
        return
    end
    if !isnothing(root.left)
        print_SPT(root.left, depth+1, '┎')
    end
    if prefix == '┎'
        left_trace[depth-1]='|'
    end
    if prefix == '┕'
        right_trace[depth-1]=' '
    end
    if depth > 1 
        print("  ")
    end
    for i in 1:depth-2
        if left_trace[i]== '|' || right_trace[i] =='|' 
            print("| ")
        else
            print("  ")
        end
    end
    if depth > 1
        print(prefix,"---")
    end
    print(RED_FG,"[$(root.n)]\n");
    print(WHITE_FG)
    left_trace[depth]=' '
    if !isnothing(root.right)
        right_trace[depth]='|'
        print_SPT(root.right, depth+1, '┕')
    end
end
function caller(root::Union{SPT,Nothing},depth::Int,prefix::Char, size::Int)
    global left_trace = Array{Char,1}()
    for _ in 1:size
        push!(left_trace,' ')
    end
    global right_trace = Array{Char,1}()
    for _ in 1:size
        push!(right_trace,' ')
    end
    print_SPT(root,depth,prefix)
end