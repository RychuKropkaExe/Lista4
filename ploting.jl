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
    arry1 = arrayIC[4:6]
    arry2 = arrayIWC[4:6]
    arry3 = arrayIH[4:6]
    arry4 = arrayDC[4:6]
    arry5 = arrayDWC[4:6]
    arry6 = arrayDH[4:6]
    println(arry1[1][2])
    println(arry2[1][2])
    println(arry3[1][2])
    plotForAny(arrx,arry1,"Random data: insert: comparisions",labels[4:6],"n","comparisions")
    plotForAny(arrx,arry2,"Random data: insert: nodes comparisions",labels[4:6],"n","nodes comparisions")
    plotForAny(arrx,arry3,"Random data: insert: height",labels[4:6],"n","height")
    plotForAny(reverse(arrx),arry4,"Random data: Deletion: comparisions",labels[4:6],"n","comparisions")
    plotForAny(reverse(arrx),arry5,"Random data: Deletion: nodes comparisions",labels[4:6],"n","nodes comparisions")
    plotForAny(reverse(arrx),arry6,"Random data: Deletion: height",labels[4:6],"n","height comparisions")

end

main()