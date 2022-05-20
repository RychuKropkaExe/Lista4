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
function delete(tree::SplayTree, value::Int)
    global weird_comparisions += 1
    pointer = tree.root
    while !isnothing(pointer)
        global weird_comparisions += 1
        global comparisions += 1
        if pointer.n == value
            global weird_comparisions += 1
            if !isnothing(pointer.upper)
                global weird_comparisions += 2
                if isnothing(pointer.right) && isnothing(pointer.left)
                    if match(pointer.upper,pointer) == 1
                        global weird_comparisions += 1
                        pointer = pointer.upper 
                        global weird_comparisions += 1
                        pointer.right = nothing
                    else
                        global weird_comparisions += 1
                        pointer = pointer.upper 
                        global weird_comparisions += 1
                        pointer.left = nothing
                    end
                else
                    if match(pointer.upper,pointer) == 1
                        global weird_comparisions += 1
                        pointer = merge(pointer.upper,pointer)
                    else
                        global weird_comparisions += 1
                        pointer = merge(pointer.upper,pointer)
                    end
                end
                tree.size -= 1
                splay(tree, pointer)
                return true
            else
                global weird_comparisions += 1
                root = new_root(pointer.left,pointer.right)
                if isnothing(root)
                    global weird_comparisions += 1
                    tree.root = SPT()
                else
                    global weird_comparisions += 1
                    tree.root = root
                end  
                return true
            end
        else
            global comparisions += 1
            if pointer.n <= value
                global weird_comparisions += 1
                pointer = pointer.right
            else
                global weird_comparisions += 1
                pointer = pointer.left
            end
        end
    end
    return false
end