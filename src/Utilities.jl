module Utilities

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

end
