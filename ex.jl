using Targe2


fens,fes,groups,edge_fes,edge_groups =targe2mesher("""
curve 1 line 0 0 75 0 
    curve 2 line 75 0 75 40 
    curve 3 line 75 40 0 0 
    curve 4 circle Center 60 10 radius 8 
    subregion 1  property 1 boundary      1  2 3 hole -4 
    subregion 2  property 2 boundary 4 
    m-ctl-point constant 5.0""")
