include("SplayTree.jl")
include("rotates.jl")
function match(upper_node::Union{SPT,Nothing}, node::Union{SPT,Nothing})
    global weird_comparisions += 1
    if upper_node.right == node
        return 1
    else 
        return 0
    end
end

function merge(upper_node::Union{SPT,Nothing}, node::Union{SPT,Nothing})
    global weird_comparisions += 1
    pointer = upper_node
    if match(upper_node, node) == 1
        global weird_comparisions += 1
        if !isnothing(node.right)
            global weird_comparisions += 1
            pointer.right = node.right
            global weird_comparisions += 1
            node.right.upper = pointer
        elseif !isnothing(node.left)
            global weird_comparisions += 2
            pointer.right = node.left
            global weird_comparisions += 1
            node.left.upper = pointer
            return pointer
        end
        global weird_comparisions += 2
        if !isnothing(node.right) && !isnothing(node.left)
            global weird_comparisions += 1
            node.left.upper = pointer
            global weird_comparisions += 1
            node.right.left = node.left
            return pointer
        end
        return pointer
    else 
        global weird_comparisions += 1
        if !isnothing(node.right)
            global weird_comparisions += 1
            pointer.left = node.right
            global weird_comparisions += 1
            node.right.upper = pointer
        elseif !isnothing(node.left)
            global weird_comparisions += 1
            pointer.left = node.left
            global weird_comparisions += 1
            node.left.upper = pointer
            return pointer
        end
        global weird_comparisions += 2
        if !isnothing(node.right) && !isnothing(node.left)
            global weird_comparisions += 1
            node.left.upper = pointer
            global weird_comparisions += 1
            node.right.left = node.left
            return pointer
        end
        return pointer
    end
end
function new_root(left_node::Union{SPT,Nothing}, right_node::Union{SPT,Nothing})
    global weird_comparisions += 1
    if !isnothing(right_node)
        global weird_comparisions += 1
        right_node.upper = nothing
        global weird_comparisions += 1
        if !isnothing(left_node)
            global weird_comparisions += 1
            left_node.upper = right_node
            global weird_comparisions += 1
            pointer = right_node
            while !isnothing(pointer.left)
                global weird_comparisions += 1
                pointer = pointer.left
            end
            global weird_comparisions += 1
            pointer.left = left_node
            return right_node
        else
            return right_node
        end
    elseif !isnothing(left_node)
        global weird_comparisions += 2
        left_node.upper = nothing
        return left_node
    end
end
function maximum_node(node::Union{SPT, Nothing})
    (isnothing(node)) && return node
    while !isnothing(node.right)
        global weird_comparisions += 1
        node = node.right
    end
    return node
end
function _join!(tree::SplayTree, s::Union{SPT, Nothing}, t::Union{SPT, Nothing})
    global weird_comparisions += 1
    if s === nothing
        return t
    elseif t === nothing
        global weird_comparisions += 1
        return s
    else
        global weird_comparisions += 1
        x = maximum_node(s)
        splay(tree, x)
        global weird_comparisions += 1
        x.right = t
        global weird_comparisions += 1
        t.upper = x
        return x
    end
end
function delete(tree::SplayTree, d::Int)
    node = tree.root
    if isnothing(node.left) && isnothing(node.right) && node.n == d
        node.n = nothing
        return
    end
    x = search_node(tree, d)
    isnothing(x) && return tree
    t = nothing
    s = nothing
    splay(tree, x)
    if x.right !== nothing
        t = x.right
        t.upper = nothing
    end

    s = x
    s.right = nothing

    if s.left !== nothing
        s.left.upper = nothing
    end
    if !isnothing(t) || !isnothing(s.left)
        tree.root = _join!(tree, s.left, t)
    end
    return tree
end