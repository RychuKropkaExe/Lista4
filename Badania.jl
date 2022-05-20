include("Modules.jl")
include("plots.jl")
using JSON
import .zad5 as SPT
import .zad3 as RBT
import .zad1 as BST
using Random

function badanie_BST()
    comparisionsI = Array{Int,1}(1:100000)
    comparisionsI.=0
    weird_comparisionsI = copy(comparisionsI)
    heightsI = copy(comparisionsI)
    comparisionsD = Array{Int,1}(1:100000)
    comparisionsD.=0
    weird_comparisionsD = copy(comparisionsI)
    heightsD = copy(comparisionsI)
    for j in 1:20
        b = BST.BST()
        for i in 1:100000
            BST.insert(b,i)
            comparisionsI[i] += BST.comparisions
            weird_comparisionsI[i] += BST.weird_comparisions
            heightsI[i] += BST.treeHeight(b)
            BST.reset_globals()
        end
        counter = 0
        for i in shuffle(1:100000-1)
            b = BST.delete(b,i)
            comparisionsD[100000-i] += BST.comparisions
            weird_comparisionsD[100000-i] += BST.weird_comparisions
            heightsD[100000-i] += BST.treeHeight(b)
            BST.reset_globals()
            counter += 1
        end
        if j == 20
            comparisionsD./20
            weird_comparisionsD./20
            heightsD./20
            comparisionsI./20
            weird_comparisionsI./20
            heightsI./20
            return [comparisionsI,weird_comparisionsI,heightsI, comparisionsD, weird_comparisionsD, heightsD]
        end
    end
end
function badanie_RBT()
    comparisionsI = Array{Int,1}(1:100000)
    comparisionsI.=0
    weird_comparisionsI = copy(comparisionsI)
    heightsI = copy(comparisionsI)
    comparisionsD = Array{Int,1}(1:100000)
    comparisionsD.=0
    weird_comparisionsD = copy(comparisionsI)
    heightsD = copy(comparisionsI)
    for j in 1:20
        b = RBT.RBTREE()
        for i in 1:100000
            RBT.insert(b,i)
            comparisionsI[i] += RBT.comparisions
            weird_comparisionsI[i] += RBT.weird_comparisions
            heightsI[i] += RBT.treeHeight(b)
            RBT.reset_globals()
        end
        counter = 0
        for i in shuffle(1:100000-1)
            RBT.delete(b,i)
            comparisionsD[100000-i] += RBT.comparisions
            weird_comparisionsD[100000-i] += RBT.weird_comparisions
            heightsD[100000-i] += RBT.treeHeight(b)
            RBT.reset_globals()
            counter += 1
        end
        if j == 20
            comparisionsD./20
            weird_comparisionsD./20
            heightsD./20
            comparisionsI./20
            weird_comparisionsI./20
            heightsI./20
            return [comparisionsI,weird_comparisionsI,heightsI, comparisionsD, weird_comparisionsD, heightsD]
        end
    end
end
function badanie_SPT()
    comparisionsI = Array{Int,1}(1:100000)
    comparisionsI.=0
    weird_comparisionsI = copy(comparisionsI)
    heightsI = copy(comparisionsI)
    comparisionsD = Array{Int,1}(1:100000)
    comparisionsD.=0
    weird_comparisionsD = copy(comparisionsI)
    heightsD = copy(comparisionsI)
    for j in 1:20
        b = SPT.SplayTree()
        for i in 1:100000
            SPT.insert(b,i)
            comparisionsI[i] += SPT.comparisions
            weird_comparisionsI[i] += SPT.weird_comparisions
            heightsI[i] += SPT.treeHeight(b)
            SPT.reset_globals()
        end
        counter = 0
        for i in shuffle(1:100000-1)
            SPT.delete(a,i)
            comparisionsD[100000-i] += SPT.comparisions
            weird_comparisionsD[100000-i] += SPT.weird_comparisions
            heightsD[100000-i] += SPT.treeHeight(b)
            SPT.reset_globals()
            counter += 1
        end
        if j == 20
            comparisionsD./20
            weird_comparisionsD./20
            heightsD./20
            comparisionsI./20
            weird_comparisionsI./20
            heightsI./20
            return [comparisionsI,weird_comparisionsI,heightsI, comparisionsD, weird_comparisionsD, heightsD]
        end
    end
end


function badanie()
    lk = ReentrantLock()
    Threads.@threads for i in 1:3
        if i==1
            result = badanie_BST()
            lock(lk)
                open("BSTResultsAR.json", "w") do io
                    JSON.print(io, result)
                end
            unlock(lk)
        elseif i==2
            result2 = badanie_RBT()
            lock(lk)
                open("RBTResultsAR.json", "w") do io
                    JSON.print(io, result2)
                end
            unlock(lk)
        else
            result3 = badanie_SPT()
            lock(lk)
                open("SPTResultsAR.json", "w") do io
                    JSON.print(io, result3)
                end
            unlock(lk)
        end
    end
end   


badanie()
