include("BST.jl")
global left_trace = Array{Char,1}()
global right_trace = Array{Char,1}()
function print_BST(root::Union{BST,Nothing},depth::Int,prefix::Char)
    if isnothing(root) 
        return
    end
    if !isnothing(root.left)
        print_BST(root.left, depth+1, ',')
    end
    if prefix == ','
        left_trace[depth-1]='|'
    end
    if prefix == '''
        right_trace[depth-1]=' '
    end
    if depth > 1 
        print(" ")
    end
    for i in 1:depth-1
        if left_trace[i]== '|' || right_trace[i] =='|' 
            print("| ")
        else
            print("  ")
        end
    end
    if depth > 1
        print(prefix,"---")
    end
    print("[$(root.n)]\n");
    left_trace[depth]=' '
    if !isnothing(root.right)
        right_trace[depth]='|'
        print_BST(root.right, depth+1, ''')
    end
end
function caller(root::Union{BST,Nothing},depth::Int,prefix::Char, size::Int)
    global left_trace = Array{Char,1}()
    for _ in 1:size
        push!(left_trace,' ')
    end
    global right_trace = Array{Char,1}()
    for _ in 1:size
        push!(right_trace,' ')
    end
    print_BST(root,depth,prefix)
end