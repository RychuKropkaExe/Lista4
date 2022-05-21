using JSON
include("plots.jl")



function main()
    names = ["BSTResultsAR.json","RBTResultsAR.json","SPTResultsAR.json","BSTResultsRR.json","RBTResultsRR.json","SPTResultsRR.json"]
    labels = ["BST-asc-rand", "RBT-asc-rand","SPT-asc-rand","BST-rand-rand","RBT-rand-rand","SPT-rand-rand"]
    arrx = Array{Int,1}(1:100000)
    arrayIC = []
    arrayIWC = []
    arrayIH = []
    arrayDC = []
    arrayDWC = []
    arrayDH = []
    for name in names
        f = open(name, "r")
        df = JSON.parse(read(f,String))
        push!(arrayIC,df[1]./20)
        push!(arrayIWC,df[2]./20)
        push!(arrayIH,df[3]./20)
        push!(arrayDC,reverse(df[4]./20))
        push!(arrayDWC,reverse(df[5]./20))
        push!(arrayDH,reverse(df[6]./20))
    end
    println("BST ASC IC: ",ceil(Int,maximum(arrayIC[1])))
    println("RBT ASC IC: ",ceil(Int,maximum(arrayIC[2])))
    println("SPT ASC IC: ",ceil(Int,maximum(arrayIC[3])))
    println("BST RAND IC: ",ceil(Int,maximum(arrayIC[4])))
    println("RBT RAND IC: ",ceil(Int,maximum(arrayIC[5])))
    println("SPT RAND IC: ",ceil(Int,maximum(arrayIC[6])))
    println("BST ASC INC: ",ceil(Int,maximum(arrayIWC[1])))
    println("RBT ASC INC: ",ceil(Int,maximum(arrayIWC[2])))
    println("SPT ASC INC: ",ceil(Int,maximum(arrayIWC[3])))
    println("BST RAND INC: ",ceil(Int,maximum(arrayIWC[4])))
    println("RBT RAND INC: ",ceil(Int,maximum(arrayIWC[5])))
    println("SPT RAND INC: ",ceil(Int,maximum(arrayIWC[6])))
    println("BST ASC IH: ",ceil(Int,maximum(arrayIH[1])))
    println("RBT ASC IH: ",ceil(Int,maximum(arrayIH[2])))
    println("SPT ASC IH: ",ceil(Int,maximum(arrayIH[3])))
    println("BST RAND IH: ",ceil(Int,maximum(arrayIH[4])))
    println("RBT RAND IH: ",ceil(Int,maximum(arrayIH[5])))
    println("SPT RAND IH: ",ceil(Int,maximum(arrayIH[6])))
    println("BST ASC DC: ",ceil(Int,maximum(arrayDC[1])))
    println("RBT ASC DC: ",ceil(Int,maximum(arrayDC[2])))
    println("SPT ASC DC: ",ceil(Int,maximum(arrayDC[3])))
    println("BST RAND DC: ",ceil(Int,maximum(arrayDC[4])))
    println("RBT RAND DC: ",ceil(Int,maximum(arrayDC[5])))
    println("SPT RAND DC: ",ceil(Int,maximum(arrayDC[6])))
    println("BST ASC DNC: ",ceil(Int,maximum(arrayDWC[1])))
    println("RBT ASC DNC: ",ceil(Int,maximum(arrayDWC[2])))
    println("SPT ASC DNC: ",ceil(Int,maximum(arrayDWC[3])))
    println("BST RAND DNC: ",ceil(Int,maximum(arrayDWC[4])))
    println("RBT RAND DNC: ",ceil(Int,maximum(arrayDWC[5])))
    println("SPT RAND DNC: ",ceil(Int,maximum(arrayDWC[6])))
    println("BST ASC DH: ",ceil(Int,maximum(arrayDH[1])))
    println("RBT ASC DH: ",ceil(Int,maximum(arrayDH[2])))
    println("SPT ASC DH: ",ceil(Int,maximum(arrayDH[3])))
    println("BST RAND DH: ",ceil(Int,maximum(arrayDH[4])))
    println("RBT RAND DH: ",ceil(Int,maximum(arrayDH[5])))
    println("SPT RAND DH: ",ceil(Int,maximum(arrayDH[6])))
    exit(0)
    # arry1 = arrayIC[1:3]
    # arry2 = arrayIWC[1:3]
    # arry3 = arrayIH[1:3]
    # arry4 = arrayDC[1:3]
    # arry5 = arrayDWC[1:3]
    # arry6 = arrayDH[1:3]
    # plotForAny(arrx,arry1,"Ascending data: insert: comparisions",labels[1:3],"n","comparisions")
    # plotForAny(arrx,arry2,"Ascending data: insert: nodes comparisions",labels[1:3],"n","nodes comparisions")
    # plotForAny(arrx,arry3,"Ascending data: insert: height",labels[1:3],"n","height")
    # plotForAny(reverse(arrx),arry4,"Ascending data: Deletion: comparisions",labels[1:3],"n","comparisions")
    # plotForAny(reverse(arrx),arry5,"Ascending data: Deletion: nodes comparisions",labels[1:3],"n","nodes comparisions")
    # plotForAny(reverse(arrx),arry6,"Ascending data: Deletion: height",labels[1:3],"n","height comparisions")
    # arry1 = arrayIC[4:6]
    # arry2 = arrayIWC[4:6]
    # arry3 = arrayIH[4:6]
    # arry4 = arrayDC[4:6]
    # arry5 = arrayDWC[4:6]
    # arry6 = arrayDH[4:6]
    # println(arry1[1][2])
    # println(arry2[1][2])
    # println(arry3[1][2])
    # plotForAny(arrx,arry1,"Random data: insert: comparisions",labels[4:6],"n","comparisions")
    # plotForAny(arrx,arry2,"Random data: insert: nodes comparisions",labels[4:6],"n","nodes comparisions")
    # plotForAny(arrx,arry3,"Random data: insert: height",labels[4:6],"n","height")
    # plotForAny(reverse(arrx),arry4,"Random data: Deletion: comparisions",labels[4:6],"n","comparisions")
    # plotForAny(reverse(arrx),arry5,"Random data: Deletion: nodes comparisions",labels[4:6],"n","nodes comparisions")
    # plotForAny(reverse(arrx),arry6,"Random data: Deletion: height",labels[4:6],"n","height comparisions")

end

main()