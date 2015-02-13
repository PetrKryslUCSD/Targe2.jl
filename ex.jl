module ex
using Targe2


input="""
curve 1 line 0 0 75 0 
curve 2 line 75 0 75 40 
curve 3 line 75 40 0 0 
curve 4 circle Center 60 10 radius 8 
subregion 1  property 1 boundary      1  2 3 hole -4 
subregion 2  property 2 boundary 4 
m-ctl-point constant 5.0
"""
#fens,fes,groups,edge_fes,edge_groups=Targe2.targe2mesher(input)
XY,triconn,trigroups,edgeconn,edgegroups=Targe2.targe2mesher(input)

Targe2.Export.vtkexport("mesh1.vtk",triconn,XY,Targe2.Export.T3)

end
