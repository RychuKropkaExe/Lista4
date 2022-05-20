include("rotates.jl")
global size = 0
function search_node(tree::SplayTree, n::Int)
    global weird_comparisions += 1
    node = tree.root
    global weird_comparisions += 1
    prev = nothing
    while !isnothing(node) && node.n != n
        global weird_comparisions += 1
        global comparisions += 2
        prev = node
        if node.n < n
            global weird_comparisions += 1
            node = node.right
        else
            global weird_comparisions += 1
            node = node.left
        end
    end
    global weird_comparisions += 1
    return isnothing(node) ? prev : node
end

function insert(tree::SplayTree, value::Int)
    global weird_comparisions += 1
    node = tree.root
    global weird_comparisions += 1
    if isnothing(node.n)
        global size += 1
        global weird_comparisions += 1
        tree.root = SPT(value)
        tree.size += 1
        return
    end
    flag = search_node(tree,value)
    global weird_comparisions += 1
    global comparisions += 1
    if !isnothing(search_node(tree,value)) && flag.n == value
        println(value)
        return
    end
    tree.size += 1
    global weird_comparisions += 1
    pointer = node
    while true
        global comparisions += 1
        if value >= pointer.n
            global weird_comparisions += 1
            if isnothing(pointer.right)
                global weird_comparisions += 1
                pointer.right = SPT(value)
                global weird_comparisions += 1
                pointer.right.upper = pointer
                splay(tree,pointer.right)
                return
            else
                global weird_comparisions += 1
                pointer = pointer.right
            end
        else 
            global weird_comparisions += 1
            if isnothing(pointer.left)
                global weird_comparisions += 1
                pointer.left = SPT(value)
                global weird_comparisions += 1
                pointer.left.upper = pointer
                splay(tree,pointer.left)
                return
            else 
                global weird_comparisions += 1
                pointer = pointer.left
            end
        end
    end
end

function treeHeight(root::Union{SPT,Nothing})
     
    if isnothing(root)
        return 0
    end
    q = Array{SPT,1}()
     
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

function maxDepth(node::Union{SPT,Nothing})
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