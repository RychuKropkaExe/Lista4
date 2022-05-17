include("Printer.jl")
include("rotates.jl")
include("SplayTree.jl")




a = SplayTree()
a.root = SPT(1)
a.root.right = SPT(10)
a.root.left = SPT(-2)
a.root.left.left = SPT(-10)
a.root.left.upper = a.root
a.root.left.left.upper = a.root.left
a.root.right.right = SPT(3)
a.root.right.upper = a.root
a.root.right.right.upper = a.root.right
a.root.right.right.right = SPT(100)
a.root.right.right.right.upper = a.root.right.right
splay(a,a.root.right.right.right)

caller(a.root,1,' ',10)
