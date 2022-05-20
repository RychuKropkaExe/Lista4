mutable struct BST
    n::Union{Int,Nothing}
    upper::Union{BST, Nothing}
    left::Union{BST, Nothing}
    right::Union{BST, Nothing}
    BST() = new(nothing,nothing,nothing,nothing)
    BST(value::Int) = new(value,nothing,nothing,nothing)
end
