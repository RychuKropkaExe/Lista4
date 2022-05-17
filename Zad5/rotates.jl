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

function splay(tree::SplayTree, node::SPT)
    while !isnothing(node.upper)
        println("UMM?")
        upper = node.upper
        grand_upper = node.upper.upper
        if isnothing(grand_upper)
            if node == upper.left
                right_rotate(tree, node.upper)
            else
                left_rotate(tree, node.upper)
            end
        elseif node == upper.left && upper == grand_upper.left
            right_rotate(tree, grand_upper)
            right_rotate(tree, upper)
        elseif node == upper.right && upper == grand_upper.right
            left_rotate(tree, grand_upper)
            left_rotate(tree, upper)
        elseif node == upper.right && upper == grand_upper.left
            left_rotate(tree, node.upper)
            right_rotate(tree, node.upper)
        else
            right_rotate(tree, node.upper)
            left_rotate(tree, node.upper)
        end
    end
end