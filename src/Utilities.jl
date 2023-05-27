module Utilities

using Printf

function _executable()
    binpath = joinpath(@__DIR__,"..","bin")
    onWindows = Base.Sys.iswindows() 
    if (onWindows)
        exe = "Targe2.exe"
    else
        onLinux = Base.Sys.islinux() 
        if (onLinux)
            exe = "targe2_GLNXA64"
            exepath = joinpath(@__DIR__,"..","bin",exe)
            run(`chmod +x $exepath`)
        else
            onMac = Base.Sys.isapple()
            if (onMac)
                exe = "targe2_MACI"
                exepath = joinpath(@__DIR__,"..","bin",exe)
                run(`chmod +x $exepath`)
            else
                exe = ""
            end
        end
    end
    return joinpath(binpath,exe)
end

_area2(v, w) = (v[1] * w[2] - v[2] * w[1])

"""
    polygon(v)

Create curve commands based on a vertex array.

# Example
```
using Targe2.Utilities: polygon
a, b, d = 2.3, 0.05, 12
v = [0 0; a 0; a d; a+b d; a+b 0; 2*a+b 0; 2*a+b  d+a; 0 d+a]
s = polygon(v)
```
gives
```
julia> s = polygon(v)
8-element Vector{Any}:
 "curve 1 line 0.000000 0.000000 2.300000 0.000000"
 "curve 2 line 2.300000 0.000000 2.300000 12.000000"
 "curve 3 line 2.300000 12.000000 2.350000 12.000000"
 "curve 4 line 2.350000 12.000000 2.350000 0.000000"
 "curve 5 line 2.350000 0.000000 4.650000 0.000000"
 "curve 6 line 4.650000 0.000000 4.650000 14.300000"
 "curve 7 line 4.650000 14.300000 0.000000 14.300000"
 "curve 8 line 0.000000 14.300000 0.000000 0.000000"
```

The vertices must be provided in counterclockwise order,
keeping the domain interior on the left.
"""
function polygon(v)
    s = []
    for j in 1:(size(v,1)-1)
        push!(s, @sprintf("curve %d line %f %f %f %f", j, v[j, 1], v[j, 2], v[j+1, 1], v[j+1, 2]))
    end
    push!(s, @sprintf("curve %d line %f %f %f %f", size(v,1), v[end, 1], v[end, 2], v[1, 1], v[1, 2]))
    s
end

end
