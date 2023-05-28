using Targe2.Utilities: _executable



exepath =  _executable()

onWindows = Base.Sys.iswindows()
if (onWindows)
    run(`icacls $(exepath) /grant everyone:\(RX\) /Q`)
else
    onLinux = Base.Sys.islinux()
    if (onLinux)
        run(`chmod +x $(exepath)`)
    else
        onMac = Base.Sys.isapple()
        if (onMac)
            run(`chmod +x $(exepath)`)
        end
    end
end
