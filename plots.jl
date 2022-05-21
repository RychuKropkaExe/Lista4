using Random
using PyPlot
using TimesDates, CompoundPeriods, TimeZones, Dates



function plotForOne(arrx::Array, arry::Array, t::String, xl::String, yl::String)
    plot(arrx,arry)
    legend()
    xlabel(xl)
    ylabel(yl)
    title(t)
    show()
end
function plotForAny(arrx::Array,arry::Array,title1::String,t::Array,xl::String,yl::String)
    maxs = []
    for i in 1:length(arry)
        push!(maxs,maximum(arry[i]))
    end
    for i in 1:length(arry)
        plot(arrx,arry[i], label = t[i])
        axis([arrx[1],arrx[length(arrx)],0,maximum(maxs)])
    end
    legend()
    xlabel(xl)
    ylabel(yl)
    title(title1)
    show()
end
function plotForTwo(arrx::Array, arry::Array, arry2::Array, t::String, xl::String, yl::String, firstPlot::String, secondPlot::String)
    plot(arrx,arry, label = firstPlot)
    plot(arrx,arry2, label = secondPlot)
    legend()
    xlabel(xl)
    ylabel(yl)
    title(t)
    show()
end
function plotForFour(arrx::Array, arry::Array, arry2::Array,arry3::Array,arry4::Array,t::String, xl::String, yl::String, firstPlot::String, secondPlot::String, thirdPlot::String, fourthPlot::String)
    plot(arrx,arry, label = firstPlot)
    plot(arrx,arry2, label = secondPlot)
    plot(arrx,arry3, label = thirdPlot)
    plot(arrx,arry4, label = fourthPlot)
    legend()
    xlabel(xl)
    ylabel(yl)
    title(t)
    show()
end