include("RBT.jl")
include("delete.jl")
using Base
using Crayons.Box
global left_trace = Array{Char,1}()
global right_trace = Array{Char,1}()
function print_RBT(root::Union{RBT,Nothing},depth::Int,prefix::Char,io::IO)
    if isnothing(root) 
        return
    end
    if !isnothing(root.left)
        print_RBT(root.left, depth+1, '┎',io)
    end
    if prefix == '┎'
        left_trace[depth-1]='|'
    end
    if prefix == '┕'
        right_trace[depth-1]=' '
    end
    if depth > 1 
        print(io,"  ")
    end
    for i in 1:depth-2
        if left_trace[i]== '|' || right_trace[i] =='|' 
            print(io,"| ")
        else
            print(io,"  ")
        end
    end
    if depth > 1
        print(io,prefix,"---")
    end
    if !isnothing(root.n)
        if root.color == BLACK
            print(io,"[$(root.n)]\n")
            #print(io,BLACK_FG,"[$(root.n)]\n");
            #print(io,WHITE_FG)
        else
            print(io,"[$(root.n)]\n")
            # print(io,RED_FG,"[$(root.n)]\n");
            # print(io,WHITE_FG)
        end
    else
        print(io,"nil\n")
        # print(io,BLACK_FG,"nil\n")
        # print(io,WHITE_FG)
    end
    left_trace[depth]=' '
    if !isnothing(root.right)
        right_trace[depth]='|'
        print_RBT(root.right, depth+1, '┕',io)
    end
end
function caller(root::Union{RBT,Nothing},depth::Int,prefix::Char, size::Int,io::IO)
    global left_trace = Array{Char,1}()
    for _ in 1:size
        push!(left_trace,' ')
    end
    global right_trace = Array{Char,1}()
    for _ in 1:size
        push!(right_trace,' ')
    end
    print_RBT(root,depth,prefix,io)
end