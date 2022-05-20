include("RBT.jl")
const RED = true
const BLACK = false
global comparisions = 0
global weird_comparisions = 0
function reset_globals()
    global comparisions = 0
    global weird_comparisions = 0
end

function rb_transplant(tree::RBTREE, u::Union{RBT, Nothing}, v::Union{RBT, Nothing})
    global weird_comparisions += 1
    if u.upper == tree.nil
        global weird_comparisions += 1
        tree.root = v
    elseif u == u.upper.left
        global weird_comparisions += 2
        u.upper.left = v
    else
        global weird_comparisions += 3
        u.upper.right = v
    end
    global weird_comparisions += 1
    v.upper = u.upper
end
function minimum_node(tree::RBTREE, node::RBT)
    global weird_comparisions += 1
    (node == tree.nil) && return node
    while node.left != tree.nil
        global weird_comparisions += 1
        node = node.left
    end
    return node
end
function delete(tree::RBTREE, d::Int)
    global weird_comparisions += 1
    z = tree.nil
    global weird_comparisions += 1
    node = tree.root
    while node !== tree.nil
        global weird_comparisions += 1
        global comparisions += 1
        if node.n == d
            global weird_comparisions += 1
            z = node
        end
        global comparisions += 1
        if d < node.n
            global weird_comparisions += 1
            node = node.left
        else
            global weird_comparisions += 1
            node = node.right
        end
    end
    global weird_comparisions += 1
    (z === tree.nil) && return tree

    y = z
    y_original_color = y.color
    local x
    global weird_comparisions += 1
    if z.left === tree.nil
        global weird_comparisions += 1
        x = z.right
        rb_transplant(tree, z, z.right)
    elseif z.right === tree.nil
        global weird_comparisions += 1
        x = z.left
        rb_transplant(tree, z, z.left)
    else
        y = minimum_node(tree, z.right)
        y_original_color = y.color
        global weird_comparisions += 1
        x = y.right
        global weird_comparisions += 1
        if y.upper == z
            global weird_comparisions += 1
            x.upper = y
        else
            rb_transplant(tree, y, y.right)
            global weird_comparisions += 1
            y.right = z.right
            global weird_comparisions += 1
            y.right.upper = y
        end

        rb_transplant(tree, z, y)
        global weird_comparisions += 1
        y.left = z.left
        global weird_comparisions += 1
        y.left.upper = y
        y.color = z.color
    end

    y_original_color == BLACK && delete_fix(tree, x)
    return tree
end

function delete_fix(tree::RBTREE, node::Union{RBT, Nothing})

    while node != tree.root && node.color == BLACK
        global weird_comparisions += 2
         if node == node.upper.left
            global weird_comparisions += 1
            sibling = node.upper.right
            if sibling.color == RED
                sibling.color = BLACK
                node.upper.color = RED
                left_rotate(tree, node.upper)
                global weird_comparisions += 1
                sibling = node.upper.right
            end
            if isnothing(sibling.left) || isnothing(sibling.right)
                sibling = node.upper
            end
            if sibling.right.color == BLACK && sibling.left.color == BLACK
                sibling.color = RED
                global weird_comparisions += 1
                node = node.upper
            else
                if sibling.right.color == BLACK
                    sibling.left.color = BLACK
                    sibling.color = RED
                    right_rotate(tree, sibling)
                    global weird_comparisions += 1
                    sibling = node.upper.right
                end

                sibling.color = node.upper.color
                node.upper.color = BLACK
                sibling.right.color = BLACK
                left_rotate(tree, node.upper)
                global weird_comparisions += 1
                node = tree.root
            end
        else
            global weird_comparisions += 1
            sibling = node.upper.left
            if sibling.color == RED
                sibling.color = BLACK
                node.upper.color = RED
                right_rotate(tree, node.upper)
                global weird_comparisions += 1
                sibling = node.upper.left
            end
            if isnothing(sibling.left) || isnothing(sibling.right)
                sibling = node.upper
            end
            if sibling.right.color == BLACK && sibling.left.color == BLACK
                sibling.color = RED
                global weird_comparisions += 1
                node = node.upper
            else
                if sibling.left.color == BLACK
                    sibling.right.color = BLACK
                    sibling.color = RED
                    left_rotate(tree, sibling)
                    global weird_comparisions += 1
                    sibling = node.upper.left
                end

                sibling.color = node.upper.color
                node.upper.color = BLACK
                sibling.left.color = BLACK
                right_rotate(tree, node.upper)
                global weird_comparisions += 1
                node = tree.root
            end
        end
    end
    node.color = BLACK
    return nothing
end


function left_rotate(T::RBTREE,z::RBT)
    global weird_comparisions += 1
    y = z.right
    global weird_comparisions += 1
    z.right = y.left
    global weird_comparisions += 1
    if y.left != T.nil
        global weird_comparisions += 1
        y.left.upper = z
    end
    global weird_comparisions += 1
    y.upper = z.upper
    global weird_comparisions += 1
    if z.upper == T.nil
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

function right_rotate(T::RBTREE,z::RBT)
    global weird_comparisions += 1
    y = z.left
    global weird_comparisions += 1
    z.left = y.right
    global weird_comparisions += 1
    if y.right != T.nil
        global weird_comparisions += 1
        y.right.upper = z
    end
    global weird_comparisions += 1
    y.upper = z.upper
    global weird_comparisions += 1
    if z.upper == T.nil
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
