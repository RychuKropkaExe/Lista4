include("RBT.jl")
include("Printer.jl")
include("delete.jl")
global size = 0
function insert(T::RBTREE,n::Int)
    insert_caller(T,RBT(n))
end
function insert_caller(T::RBTREE, z::RBT)
    global size += 1
    global weird_comparisions += 1
    y = T.nil
    global weird_comparisions += 1
    x = T.root
    while x != T.nil
        global weird_comparisions += 1
        y = x
        global comparisions += 1
        if z.n < x.n
            global weird_comparisions += 1
            x = x.left
        else
            global weird_comparisions += 1
            x = x.right
        end
    end
    global weird_comparisions += 1
    z.upper = y
    global weird_comparisions += 1
    if y == T.nil
        global weird_comparisions += 1
        T.root = z
    elseif z.n < y.n
        global comparisions += 1
        global weird_comparisions += 1
        y.left = z
    else 
        global comparisions += 1
        global weird_comparisions += 1
        y.right=z
    end
    global weird_comparisions += 1
    z.left = T.nil
    global weird_comparisions += 1
    z.right = T.nil
    z.color = RED
    insert_fixup(T::RBTREE,z::RBT)     
end

function insert_fixup(T::RBTREE, z::RBT)
    while z.upper.color == RED
        global weird_comparisions += 1
        if z.upper == z.upper.upper.left
            global weird_comparisions += 1
            y = z.upper.upper.right
            if y.color == RED
                z.upper.color = BLACK
                y.color = BLACK
                z.upper.upper.color = RED
                global weird_comparisions += 1
                z = z.upper.upper
            else
                global weird_comparisions += 1
                if z == z.upper.right
                    global weird_comparisions += 1
                    z = z.upper
                    left_rotate(T,z)
                end
                z.upper.color = BLACK
                z.upper.upper.color = RED
                right_rotate(T,z.upper.upper)
            end
        else
            global weird_comparisions += 1
            y = z.upper.upper.left
            if y.color == RED
                z.upper.color = BLACK
                y.color = BLACK
                z.upper.upper.color = RED
                global weird_comparisions += 1
                z = z.upper.upper
            else
                global weird_comparisions += 1
                if z == z.upper.right
                    global weird_comparisions += 1
                    z = z.upper
                    left_rotate(T,z)
                end
                z.upper.color = BLACK
                z.upper.upper.color = RED
                left_rotate(T,z.upper.upper)
            end
        end
    end
    T.root.color = BLACK
end


function treeHeight(tree::RBTREE)
    root = tree.root
    if root == tree.nil
        return 0
    end
    q = Array{RBT,1}()
     
    push!(q,root)
    height = 0
 
    while true
        nodeCount = length(q)
        if nodeCount == 0 
            return height
        end
        height += 1
        while(nodeCount > 0)
            node = q[1]
            popfirst!(q)
            if node.left != tree.nil
                push!(q,node.left)
            end
            if node.right != tree.nil
                push!(q,node.right)
            end
            nodeCount -= 1
        end
    end
end

function maxDepth(nil::RBT,node::Union{RBT,Nothing})
    if node == nil
        return -1
    else
        lDepth = maxDepth(nil,node.left)
        rDepth = maxDepth(nil,node.right)
        if (lDepth > rDepth)
            return lDepth+1
        else
            return rDepth+1
        end
    end
end

