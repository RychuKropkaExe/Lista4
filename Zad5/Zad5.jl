include("Printer.jl")
include("rotates.jl")
include("SplayTree.jl")




a = SplayTree()
a.root = SPT(1)
a.root.right = SPT(10)
a.root.left = SPT(-2)
right_rotate(a,a.root)

caller(a.root,1,' ',10)
