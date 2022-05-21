include("Modules.jl")
include("plots.jl")
using JSON
import .zad5 as SPT
import .zad3 as RBT
import .zad1 as BST
using Random







bst = BST.BST()
rbt = RBT.RBTREE()
spt = SPT.SplayTree()
rm("sprawko.log")
file = open("sprawko.log","a")
println(file,"Dla BST ASC")
for i in 1:50
    BST.insert(bst,i)
    println(file,"Inserting: $i")
    BST.caller(bst,1,' ',i,file)
end

for i in shuffle(1:50)
    global bst = BST.delete(bst,i)
    println(file,"After Deleting: $i")
    BST.caller(bst,1,' ',50,file)
end
bst = BST.BST()
println(file,"Dla BST RAND")
for i in shuffle(1:50)
    BST.insert(bst,i)
    println(file,"Inserting: $i")
    BST.caller(bst,1,' ',200,file)
end
for i in shuffle(1:50)
    global bst = BST.delete(bst,i)
    println(file,"After Deleting: $i")
    BST.caller(bst,1,' ',50,file)
end
println(file,"Dla RBT ASC")
for i in 1:50
    RBT.insert(rbt,i)
    println(file,"Inserting: $i")
    RBT.caller(rbt.root,1,' ',200,file)
end

for i in shuffle(1:50)
    RBT.delete(rbt,i)
    println(file,"After Deleting: $i")
    RBT.caller(rbt.root,1,' ',200,file)
end
rbt = RBT.RBTREE()
println(file,"Dla RBT RAND")
for i in shuffle(1:50)
    RBT.insert(rbt,i)
    println(file,"Inserting: $i")
    RBT.caller(rbt.root,1,' ',200,file)
end

for i in shuffle(1:50)
    RBT.delete(rbt,i)
    println(file,"After Deleting: $i")
    RBT.caller(rbt.root,1,' ',200,file)
end
println(file,"Dla SPT ASC")
for i in 1:50
    SPT.insert(spt,i)
    println(file,"Inserting: $i")
    SPT.caller(spt.root,1,' ',200,file)
end
for i in shuffle(1:50)
    SPT.delete(spt,i)
    println(file,"After Deleting: $i")
    SPT.caller(spt.root,1,' ',200,file)
end
spt = SPT.SplayTree()
println(file,"Dla SPT RAND")
for i in shuffle(1:50)
    SPT.insert(spt,i)
    println(file,"Inserting: $i")
    SPT.caller(spt.root,1,' ',200,file)
end

for i in shuffle(1:50)
    SPT.delete(spt,i)
    println(file,"After Deleting: $i")
    SPT.caller(spt.root,1,' ',200,file)
end
close(file)