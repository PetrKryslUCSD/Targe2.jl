

using Targe2 
using Targe2.Utilities: showmesh 
using LinearAlgebra: norm
using Test
 
# function wrvtk(test, XY, triconn)
# 	cells = MeshCell[]
#     celltype = (size(triconn, 2) == 3) ? VTKCellTypes.VTK_TRIANGLE : VTKCellTypes.VTK_QUADRATIC_TRIANGLE
#     for i = 1:size(triconn, 1)
#         push!(cells, MeshCell(celltype, vec(view(triconn, i, :))))
#     end
#     vtk = vtk_grid(test, transpose(XY), cells)
#     vtk_save(vtk)
#     showmesh(test)
# 	return true
# end

function run1(test,input)
    println("Input " * test)
    result=true;
    mesh = targe2mesher(input)
    showmesh(test, mesh)
    return result
end

####################################################
####################################################
####################################################
# # t1
# input="""
# curve 1 line 0 0 75 0                                                             
# curve 2 line 75 0 75 40                                                           
# curve 3 line 75 40 0 40                                                               
# curve 34 line 0 40 0 0                                                          
# curve 4 circle Center $(75.0/2) 20 radius 8                                              
# subregion 1  property 1 boundary 1  2 3 34 hole -4                                
# subregion 2  property 2 boundary 4                                                
# m-ctl-point constant 4  
# """
# thetest="t1"
# run1(thetest,input)

input="""
curve 1 line 0 0 75 0                                                             
curve 2 line 75 0 75 40                                                           
curve 3 line 75 40 0 40                                                               
curve 34 line 0 40 0 0                                                          
curve 4 circle Center $(75.0/2) 20 radius 8                                              
subregion 1  property 1 boundary 1  2 3 34 hole -4                                
subregion 2  property 2 boundary 4                                                
m-ctl-point constant 4  
"""
mesh = targe2mesher(input);
showmesh("uniform", mesh)
# mc = meshcontrol(mesh, x -> 0.1  + 0.05 * x[2]);
# mc = meshcontrol(mesh, x -> 0.1  + 8 * sin(0.75 * x[1])^2);
# mc = meshcontrol(mesh, x -> 0.5  + 7.5 * (x[1]/75)^2);
mc = meshcontrol(mesh, x -> (norm(vec(x) - vec([75.0/2, 20])) < 8) ? 0.25 : 4.0 );
mesh = targe2mesher(input * mc);
showmesh("graded", mesh);


