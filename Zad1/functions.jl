include("BST.jl")
include("Printer.jl")
global size = 1
global comparisions = 0
global weird_comparisions = 0
function insert(node::BST, value::Int)
    global size += 1
    if isnothing(node.n)
        node.n = value
        return
    end
    pointer = node
    while true
        global comparisions += 1
        if value >= pointer.n
            global weird_comparisions += 1
            if isnothing(pointer.right)
                pointer.right = BST(value)
                pointer.right.upper = pointer
                return
            else
                pointer = pointer.right
            end
        else 
            global weird_comparisions += 1
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
    global weird_comparisions += 1
    if upper_node.right == node
        return 1
    else 
        return 0
    end
end
function treeHeight(root::Union{BST,Nothing})
    if isnothing(root)
        return 0
    end
    q = Array{BST,1}()
     
    push!(q,root)
    height = 0
 
    while true
        nodeCount = length(q)
        if nodeCount == 0 
            return height
        end
        height += 1
        while(nodeCount > 0)
            node = q[1]
            popfirst!(q)
            if !isnothing(node.left)
                push!(q,node.left)
            end
            if !isnothing(node.right)
                push!(q,node.right)
            end
            nodeCount -= 1
        end
    end
end

function merge(upper_node::Union{BST,Nothing}, node::Union{BST,Nothing})
    pointer = node.upper
    if match(upper_node, node) == 1
        global weird_comparisions += 1
        if !isnothing(node.right)
            global weird_comparisions += 1
            pointer.right = node.right
            global weird_comparisions += 1
            node.right.upper = pointer
        elseif !isnothing(node.left)
            global weird_comparisions += 1
            pointer.right = node.left
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
function new_root(node::Union{BST,Nothing}, left_node::Union{BST,Nothing}, right_node::Union{BST,Nothing})
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
        global weird_comparisions += 1
        left_node.upper = nothing
        global weird_comparisions += 1
        return left_node
    end
end
function delete(node::Union{BST,Nothing}, value::Int)
    pointer = node
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
                        pointer.upper.right = nothing
                        return node
                    else
                        global weird_comparisions += 1
                        pointer.upper.left = nothing
                        return node
                    end
                else
                    if match(pointer.upper,pointer) == 1
                        global weird_comparisions += 1
                        pointer = merge(pointer.upper,pointer)
                        return node
                    else
                        global weird_comparisions += 1
                        pointer = merge(pointer.upper,pointer)
                        return node
                    end
                end
            else
                global weird_comparisions += 1
                return new_root(pointer,pointer.left,pointer.right)
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
    return node
end
function reset_globals()
    global comparisions = 0
    global weird_comparisions = 0
end

function deleteIterative(root, key)
    global weird_comparisions += 1
    curr = root
    prev = nothing
    while !isnothing(curr) && curr.n != key
        global weird_comparisions += 1
        prev = curr
        global comparisions += 1
        if curr.n < key
            global weird_comparisions += 1
            curr = curr.right
        else
            global weird_comparisions += 1
            curr = curr.left
        end
    end
    global weird_comparisions += 1
    if isnothing(curr)
        return root
    end
    global weird_comparisions += 2
    if isnothing(curr.left) || isnothing(curr.right)
        newCurr = nothing
        if isnothing(curr.left)
            global weird_comparisions += 1
            newCurr = curr.right
        else
            global weird_comparisions += 1
            newCurr = curr.left
        end

        global weird_comparisions += 1
        if isnothing(prev)
            return newCurr
        end
        global weird_comparisions += 1
        if curr == prev.left
            global weird_comparisions += 1
            prev.left = newCurr
        else
            global weird_comparisions += 1
            prev.right = newCurr
        end
        global weird_comparisions += 1
        curr = nothing
    else
        p = nothing
        temp = nothing
 
        # Compute the inorder
        # successor of curr.
        global weird_comparisions += 1
        temp = curr.right
        while !isnothing(temp.left)
            global weird_comparisions += 2
            p = temp
            temp = temp.left
        end
        if !isnothing(p)
            global weird_comparisions += 1
            p.left = temp.right
 
        else
            global weird_comparisions += 1
            curr.right = temp.right
        end
        global weird_comparisions += 1
        curr.n = temp.n
        temp = nothing
    end
    return root
end




