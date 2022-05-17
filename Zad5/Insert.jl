function search_node(tree::SplayTree, n::Int)
    node = tree.root
    prev = nothing
    while !isnothing(node) && node.n != n
        prev = node
        if node.n < n
            node = node.right
        else
            node = node.left
        end
    end
    return isnothing(node) ? prev : node
end