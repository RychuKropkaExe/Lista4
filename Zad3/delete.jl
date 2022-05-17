include("RBT.jl")
const RED = true
const BLACK = false

function rb_transplant(tree::RBTREE, u::Union{RBT, Nothing}, v::Union{RBT, Nothing})
    if u.upper == tree.nil
        tree.root = v
    elseif u == u.upper.left
        u.upper.left = v
    else
        u.upper.right = v
    end
    v.upper = u.upper
end
function minimum_node(tree::RBTREE, node::RBT)
    (node == tree.nil) && return node
    while node.left != tree.nil
        node = node.left
    end
    return node
end
function delete(tree::RBTREE, d::Int)
    z = tree.nil
    node = tree.root
    while node !== tree.nil
        if node.n == d
            z = node
        end

        if d < node.n
            node = node.left
        else
            node = node.right
        end
    end

    (z == tree.nil) && return tree

    y = z
    y_original_color = y.color
    local x
    if z.left == tree.nil
        x = z.right
        rb_transplant(tree, z, z.right)
    elseif z.right == tree.nil
        x = z.left
        rb_transplant(tree, z, z.left)
    else
        y = minimum_node(tree, z.right)
        y_original_color = y.color
        x = y.right

        if y.upper == z
            x.upper = y
        else
            rb_transplant(tree, y, y.right)
            y.right = z.right
            y.right.upper = y
        end

        rb_transplant(tree, z, y)
        y.left = z.left
        y.left.upper = y
        y.color = z.color
    end

    y_original_color == BLACK && delete_fix(tree, x)
    return tree
end

function delete_fix(tree::RBTREE, node::Union{RBT, Nothing})
    while node != tree.root && node.color == BLACK
         if node == node.upper.left
            sibling = node.upper.right
            if sibling.color == RED
                sibling.color = BLACK
                node.upper.color = RED
                left_rotate(tree, node.upper)
                sibling = node.upper.right
            end

            if sibling.right.color == BLACK && sibling.left.color == BLACK
                sibling.color = RED
                node = node.upper
            else
                if sibling.right.color == BLACK
                    sibling.left.color = BLACK
                    sibling.color = RED
                    right_rotate(tree, sibling)
                    sibling = node.upper.right
                end

                sibling.color = node.upper.color
                node.upper.color = BLACK
                sibling.right.color = BLACK
                left_rotate(tree, node.upper)
                node = tree.root
            end
        else
            sibling = node.upper.left
            if sibling.color == RED
                sibling.color = BLACK
                node.upper.color = RED
                right_rotate(tree, node.upper)
                sibling = node.upper.left
            end

            if sibling.right.color == BLACK && sibling.left.color == BLACK
                sibling.color = RED
                node = node.upper
            else
                if sibling.left.color == BLACK
                    sibling.right.color = BLACK
                    sibling.color = RED
                    left_rotate(tree, sibling)
                    sibling = node.upper.left
                end

                sibling.color = node.upper.color
                node.upper.color = BLACK
                sibling.left.color = BLACK
                right_rotate(tree, node.upper)
                node = tree.root
            end
        end
    end
    node.color = BLACK
    return nothing
end


function left_rotate(T::RBTREE,z::RBT)
    y = z.right
    z.right = y.left
    if y.left != T.nil
        y.left.upper = z
    end
    y.upper = z.upper
    if z.upper == T.nil
        T.root = y
    elseif z == z.upper.left
        z.upper.left = y
    else
        z.upper.right = y
    end
    y.left = z
    z.upper = y
end

function right_rotate(T::RBTREE,z::RBT)
    y = z.left
    z.left = y.right
    if y.right != T.nil
        y.right.upper = z
    end
    y.upper = z.upper
    if z.upper == T.nil
        T.root = y
    elseif z == z.upper.right
        z.upper.right = y
    else
        z.upper.left = y
    end
    y.right = z
    z.upper = y
end
