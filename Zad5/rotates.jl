include("SplayTree.jl")


function left_rotate(T::SplayTree,z::SPT)
    y = z.right
    z.right = y.left
    if !isnothing(y.left)
        y.left.upper = z
    end
    y.upper = z.upper
    if isnothing(z.upper)
        T.root = y
    elseif z == z.upper.left
        z.upper.left = y
    else
        z.upper.right = y
    end
    y.left = z
    z.upper = y
end

function right_rotate(T::SplayTree,z::SPT)
    y = z.left
    z.left = y.right
    if !isnothing(y.right)
        y.right.upper = z
    end
    y.upper = z.upper
    if isnothing(z.upper)
        T.root = y
    elseif z == z.upper.right
        z.upper.right = y
    else
        z.upper.left = y
    end
    y.right = z
    z.upper = y
end