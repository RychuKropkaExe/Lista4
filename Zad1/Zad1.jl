include("BST.jl")
include("Printer.jl")
global size = 0
function insert(node::BST, value::Int)
    global size += 1
    pointer = node
    while true
        if value >= pointer.n
            if isnothing(pointer.right)
                pointer.right = BST(value)
                pointer.right.upper = pointer
                return
            else
                pointer = pointer.right
            end
        else 
            if isnothing(pointer.left)
                pointer.left = BST(value)
                pointer.left.upper = pointer
                return
            else 
                pointer = pointer.left
            end
        end
    end
end
function maxDepth(node::Union{BST,Nothing})
    if isnothing(node)
        return -1
    else
        lDepth = maxDepth(node.left)
        rDepth = maxDepth(node.right)
        if (lDepth > rDepth)
            return lDepth+1
        else
            return rDepth+1
        end
    end
end
function match(upper_node::Union{BST,Nothing}, node::Union{BST,Nothing})
    if upper_node.right == node
        return 1
    else 
        return 0
    end
end

function merge(upper_node::Union{BST,Nothing}, node::Union{BST,Nothing})
    pointer = upper_node
    if match(upper_node, node) == 1
        if !isnothing(node.right)
            pointer.right = node.right
            node.right.upper = pointer
        elseif !isnothing(node.left)
            pointer.right = node.left
            node.left.upper = pointer
            return pointer
        end
        if !isnothing(node.right) && !isnothing(node.left)
            node.left.upper = pointer
            node.right.left = node.left
            return pointer
        end
        return pointer
    else 
        if !isnothing(node.right)
            pointer.left = node.right
            node.right.upper = pointer
        elseif !isnothing(node.left)
            pointer.left = node.left
            node.left.upper = pointer
            return pointer
        end
        if !isnothing(node.right) && !isnothing(node.left)
            node.left.upper = pointer
            node.right.left = node.left
            return pointer
        end
        return pointer
    end
end
function new_root(node::Union{BST,Nothing}, left_node::Union{BST,Nothing}, right_node::Union{BST,Nothing})
    if !isnothing(right_node)
        right_node.upper = nothing
        if !isnothing(left_node)
            left_node.upper = right_node
            pointer = right_node
            while !isnothing(pointer.left)
                pointer = pointer.left
            end
            pointer.left = left_node
            return right_node
        else
            return right_node
        end
    elseif !isnothing(left_node)
        left_node.upper = nothing
        return left_node
    end
end
function delete(node::Union{BST,Nothing}, value::Int)
    pointer = node
    while !isnothing(pointer)
        if pointer.n == value
            if !isnothing(pointer.upper)
                if isnothing(pointer.right) && isnothing(pointer.left)
                    if match(pointer.upper,pointer) == 1
                        pointer.upper.right = nothing
                    else
                        pointer.upper.left = nothing
                    end
                else
                    if match(pointer.upper,pointer) == 1
                        pointer = merge(pointer.upper,pointer)
                    else
                        pointer = merge(pointer.upper,pointer)
                    end
                end
                return node
            else
                return new_root(pointer,pointer.left,pointer.right)
            end
        else
            if pointer.n <= value
                pointer = pointer.right
            else
                pointer = pointer.left
            end
        end
    end
    return node
end
a = BST(25)
insert(a,12)
insert(a,15)
insert(a,32)
insert(a,40)
insert(a,36)
insert(a,1)
insert(a,8)
insert(a,37)
#caller(a,1,'-',size)
a = delete(a,37)
global size -= 1
caller(a,1,' ',size)
