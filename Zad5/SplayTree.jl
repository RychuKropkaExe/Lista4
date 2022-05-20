


mutable struct SPT
    n::Union{Int,Nothing}
    upper::Union{SPT, Nothing}
    left::Union{SPT, Nothing}
    right::Union{SPT, Nothing}
    SPT() = new(nothing,nothing,nothing,nothing)
    SPT(n::Union{Int,Nothing}) = new(n,nothing,nothing,nothing)
end


mutable struct SplayTree
    root::SPT
    size::Int
    SplayTree() = new(SPT(),0)
end
