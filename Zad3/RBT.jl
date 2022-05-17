import Base.@kwdef
mutable struct RBT
    n::Union{Int,Nothing}
    upper::Union{RBT, Nothing}
    left::Union{RBT, Nothing}
    right::Union{RBT, Nothing}
    color::Union{Bool,Nothing}
    RBT() = new(nothing,nothing,nothing,nothing,nothing)
    RBT(n::Union{Int,Nothing}) = new(n,RBT(),RBT(),RBT(),true)
end

mutable struct RBTREE
    root::RBT
    nil::RBT
    function RBTREE()
        rb = new()
        rb.nil = RBT()
        rb.root = rb.nil
        return rb
    end
end
# function RBTREE(n::Int)
#     nil = RBT()
#     return RBTREE(RBT(n),nil)
# end

# function RBT(rb::RBTREE,n::Int, c::Bool)
#     return RBT(n,rb.nil,rb.nil,rb.nil,c)
# end

