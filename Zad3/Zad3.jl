include("RBT.jl")
include("Printer.jl")
include("delete.jl")
global size = 0
function insert(T::RBTREE,n::Int)
    insert_caller(T,RBT(n))
end
function insert_caller(T::RBTREE, z::RBT)
    global size += 1
    y = T.nil
    x = T.root
    while x != T.nil
        y = x
        if z.n < x.n
            x = x.left
        else
            x = x.right
        end
    end
    z.upper = y
    if y == T.nil
        T.root = z
    elseif z.n < y.n
        y.left = z
    else 
        y.right=z
    end
    z.left = T.nil
    z.right = T.nil
    z.color = RED
    insert_fixup(T::RBTREE,z::RBT)     
end

function insert_fixup(T::RBTREE, z::RBT)
    while z.upper.color == RED
        if z.upper == z.upper.upper.left
            y = z.upper.upper.right
            if y.color == RED
                z.upper.color = BLACK
                y.color = BLACK
                z.upper.upper.color = RED
                z = z.upper.upper
            else
                if z == z.upper.right
                    z = z.upper
                    left_rotate(T,z)
                end
                z.upper.color = BLACK
                z.upper.upper.color = RED
                right_rotate(T,z.upper.upper)
            end
        else
            y = z.upper.upper.left
            if y.color == RED
                z.upper.color = BLACK
                y.color = BLACK
                z.upper.upper.color = RED
                z = z.upper.upper
            else
                if z == z.upper.right
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



a = RBTREE()
list = []
for i in 1:20
    b = rand(1:50)
    push!(list,b)
    insert(a,b)
end
caller(a.root,1,' ',size)

for i in 1:20
    println(i)
    delete(a,list[i])
    caller(a.root,1,' ',size)
end

