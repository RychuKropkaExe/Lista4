mutable struct BST
    n::Int
    upper::Union{BST, Nothing}
    left::Union{BST, Nothing}
    right::Union{BST, Nothing}
end


function BST(n::Int)
    return BST(n,nothing,nothing,nothing)
end