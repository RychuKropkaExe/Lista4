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
        println("Iteration for BST: ", j)
        b = BST.BST()
        counter = 0
        for i in shuffle(1:100000)
            BST.insert(b,i)
            comparisionsI[1+counter] += BST.comparisions
            weird_comparisionsI[1+counter] += BST.weird_comparisions
            heightsI[1+counter] += BST.treeHeight(b)
            BST.reset_globals()
            counter+=1
        end
        counter = 0
        println("Iteration for BST DELETE: ", j)
        for i in shuffle(1:100000-1)
            println(counter)
            b = BST.deleteIterative(b,i)
            comparisionsD[100000-counter] += BST.comparisions
            weird_comparisionsD[100000-counter] += BST.weird_comparisions
            heightsD[100000-counter] += BST.treeHeight(b)
            BST.reset_globals()
            counter += 1
        end
        if j == 20
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
        println("Iteration for RBT: ", j)
        b = RBT.RBTREE()
        counter = 0
        for i in shuffle(1:100000)
            RBT.insert(b,i)
            comparisionsI[1+counter] += RBT.comparisions
            weird_comparisionsI[1+counter] += RBT.weird_comparisions
            heightsI[1+counter] += RBT.maxDepth(b.nil,b.root)
            RBT.reset_globals()
            counter+=1
        end
        counter = 0
        println("Iteration for RBT DELETE: ", j)
        for i in shuffle(1:100000-1)
            println(counter)
            RBT.delete(b,i)
            comparisionsD[100000-counter] += RBT.comparisions
            weird_comparisionsD[100000-counter] += RBT.weird_comparisions
            heightsD[100000-counter] += RBT.maxDepth(b.nil,b.root)
            RBT.reset_globals()
            counter += 1
        end
        if j == 20
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
        println("Iteration for SPT INSERT: ", j)
        b = SPT.SplayTree()
        counter = 0
        for i in shuffle(1:100000)
            SPT.insert(b,i)
            comparisionsI[1+counter] += SPT.comparisions
            weird_comparisionsI[1+counter] += SPT.weird_comparisions
            heightsI[1+counter] += SPT.treeHeight(b.root)
            #heightsI[i] += i
            SPT.reset_globals()
            counter += 1
        end
        counter = 0
        println("Iteration for SPT DELETE: ", j)
        for i in shuffle(1:100000-1)
            println("Iteration: ", counter)
            SPT.delete(b,i)
            comparisionsD[100000-counter] += SPT.comparisions
            weird_comparisionsD[100000-counter] += SPT.weird_comparisions
            heightsD[100000-counter] += SPT.treeHeight(b.root)
            SPT.reset_globals()
            counter += 1
        end
        if j == 20
            return [comparisionsI,weird_comparisionsI,heightsI, comparisionsD, weird_comparisionsD, heightsD]
        end
    end
end


function badanie()
    lk = ReentrantLock()
    Threads.@threads for i in 1:3
        if Threads.threadid() == 1
            result = badanie_BST()
            open("BSTResultsRR.json", "w") do io
                JSON.print(io, result)
            end
        elseif Threads.threadid() == 2
            result2 = badanie_RBT()
            open("RBTResultsRR.json", "w") do io
                JSON.print(io, result2)
            end
        else
            result3 = badanie_SPT()
            open("SPTResultsAR.json", "w") do io
                JSON.print(io, result3)
            end
        end
    end
end   