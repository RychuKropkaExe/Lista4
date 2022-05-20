include("SplayTree.jl")
global comparisions = 0
global weird_comparisions = 0

function left_rotate(T::SplayTree,z::SPT)
    global weird_comparisions += 1
    y = z.right
    global weird_comparisions += 1
    z.right = y.left
    global weird_comparisions += 1
    if !isnothing(y.left)
        global weird_comparisions += 1
        y.left.upper = z
    end
    global weird_comparisions += 1
    y.upper = z.upper
    global weird_comparisions += 1
    if isnothing(z.upper)
        global weird_comparisions += 1
        T.root = y
    elseif z == z.upper.left
        global weird_comparisions += 2
        z.upper.left = y
    else
        global weird_comparisions += 3
        z.upper.right = y
    end
    global weird_comparisions += 1
    y.left = z
    global weird_comparisions += 1
    z.upper = y
end

function right_rotate(T::SplayTree,z::SPT)
    global weird_comparisions += 1
    y = z.left
    global weird_comparisions += 1
    z.left = y.right
    global weird_comparisions += 1
    if !isnothing(y.right)
        global weird_comparisions += 1
        y.right.upper = z
    end
    global weird_comparisions += 1
    y.upper = z.upper
    global weird_comparisions += 1
    if isnothing(z.upper)
        global weird_comparisions += 1
        T.root = y
    elseif z == z.upper.right
        global weird_comparisions += 2
        z.upper.right = y
    else
        global weird_comparisions += 3
        z.upper.left = y
    end
    global weird_comparisions += 1
    y.right = z
    global weird_comparisions += 1
    z.upper = y
end

function splay(tree::SplayTree, node::SPT)
    while !isnothing(node.upper)
        global weird_comparisions += 1
        upper = node.upper
        global weird_comparisions += 1
        upper_upper = node.upper.upper
        global weird_comparisions += 1
        if isnothing(upper_upper)
            global weird_comparisions += 1
            if node == upper.left
                right_rotate(tree, node.upper)
            else
                left_rotate(tree, node.upper)
            end
        elseif node == upper.left && upper == upper_upper.left
            global weird_comparisions += 2
            right_rotate(tree, upper_upper)
            right_rotate(tree, upper)
        elseif node == upper.right && upper == upper_upper.right
            global weird_comparisions += 4
            left_rotate(tree, upper_upper)
            left_rotate(tree, upper)
        elseif node == upper.right && upper == upper_upper.left
            global weird_comparisions += 6
            left_rotate(tree, node.upper)
            right_rotate(tree, node.upper)
        else
            global weird_comparisions += 8
            right_rotate(tree, node.upper)
            left_rotate(tree, node.upper)
        end
    end
end

function reset_globals()
    global comparisions = 0
    global weird_comparisions = 0
end