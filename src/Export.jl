module Export
 
const L2=3
const T3=5
const Q4=9
const T4=10
const H8=12
const L3=21
const T6=22
const Q8=23
const T10=24
const H20=25

# Export mesh to a VTK 1.0 file as an unstructured grid.
function vtkexport{FLT<:FloatingPoint}(theFile::String,Connectivity::Array{Int,2},Points::Array{FLT,2}, Cell_type::Int;
                        vectors=nothing,vectors_name ="vectors",
                        scalars=nothing, scalars_name ="scalars",binary = false)
# theFile= File name as a string,
    # Connectivity= connectivity array, one row per cell,
    # Points= Coordinate array, one row per point,
    # Cell_type= Cell type code: L2=3, T3=5, Q4=9, T4=10, H8=12
    # options = structure,  with optional attributes:
    # options.binary= Boolean flag, should the file be written as binary?
    # Default is false (file is ASCII).
    # options.scalars =Array of per-node data, same number of rows as  array Points.
    # options.scalars_name = String (no spaces), name for the scalars array.
    # options.vectors =Array of per-node data, same number of rows as  array Points, three columns.
    # options.vectors_name = String (no spaces), name for the vectors array.

    X= Points
    if size(Points, 2)<3
        X=   zeros(size (Points,1),3)
        X [:,1: size(Points,2)] = Points
    end
    if (Cell_type==L2) && (size(Connectivity,2)!=2)
        error("Wrong number of connected nodes")
    end
    if (Cell_type==T3) && (size(Connectivity,2)!=3)
        error("Wrong number of connected nodes")
    end
    if (Cell_type==Q4) && (size(Connectivity,2)!=4)
        error("Wrong number of connected nodes")
    end
    if (Cell_type==T4) && (size(Connectivity,2)!=4)
        error("Wrong number of connected nodes")
    end
    if (Cell_type==H8) && (size(Connectivity,2)!=8)
        error("Wrong number of connected nodes")
    end

    #    if (~strcmp(ext,"vtk"))
    #        theFile = [theFile ".vtk"];
    #    end

    fid=open(theFile,"w");
    if (fid==-1)
        error (["Could not open " * theFile])
        return nothing
    end
    print(fid,"# vtk DataFile Version 1.0\n");
    print(fid,"JFinEALE Export\n");
    if (!binary)
        print(fid,"ASCII\n");
    else
        print(fid,"BINARY\n");
    end
    print(fid,"\n");
    print(fid,"DATASET UNSTRUCTURED_GRID\n");
    print(fid,"POINTS ", size(X,1), " double\n");
    if (!binary)
        for i= 1:size(X, 1)
            for j= 1:size(X,2)-1
                print(fid,X[i,j]," ");
            end
            print(fid,X[i,end],"\n");
        end
    else
        fwrite(fid,cast(X,"double"),"double","n");
    end
    print(fid,"\n");
    print(fid,"\n");

    print(fid,"CELLS ",size(Connectivity,1)," ",(size(Connectivity,1)*(size(Connectivity,2)+1)),"\n");
    if (!binary)
        for i= 1:size(Connectivity, 1)
            print(fid,size(Connectivity,2)," ");
            for j= 1:size(Connectivity,2)-1
                print(fid,Connectivity[i,j]-1," ");
            end
            print(fid,Connectivity[i,end]-1,"\n");
        end
    else
        fwrite(fid,cast([zeros(size(f,1),1)+size(f,2),f-1],"int32"),"int32","n");
    end
    print(fid,"\n");
    print(fid,"\n");
    print(fid,"CELL_TYPES ",size(Connectivity,1),"\n");
    if (!binary)
        for i= 1:size(Connectivity,1)
            print(fid,Cell_type,"\n");
        end
    else
        fwrite(fid,cast(ctype,"int32"),"int32","n");
    end

    did_point_data=false
    if (scalars!=nothing) && (length(scalars)==size(Points,1))
        did_point_data=true
        print(fid,"POINT_DATA ",length(scalars),"\n");
        print(fid,"SCALARS ",scalars_name," double\n");
        print(fid,"LOOKUP_TABLE default\n");
        if (!binary)
            for j= 1:length(scalars)
                print(fid,scalars[j],"\n");
            end
        else
            fwrite(fid,cast(scalars,"double"),"double","n");
        end
    end

    if vectors!=nothing
        if (!did_point_data)
            print(fid,"POINT_DATA ",size(vectors,1),"\n");
        end
        did_point_data=true
        print(fid,"VECTORS ",vectors_name," double\n");
        #print(fid,"LOOKUP_TABLE default\n");
        X=vectors
        if size(vectors, 2)<3
            X=   zeros(size (vectors,1),3)
        end
        X[:,1:size(vectors,2)] = vectors
        if (!binary)
            for j= 1:size(X,1)
                k=1;
                print(fid,X[j,k]);
                for k=2:size(X,2)
                    print(fid," ",X[j,k]);
                end
                print(fid,"\n");
            end
        else
            fwrite(fid,cast(X,"double"),"double","n");
        end
    end
    
    if (scalars!=nothing) && (length(scalars)==size(Connectivity,1))
        did_point_data=true
        print(fid,"CELL_DATA ",length(scalars),"\n");
        print(fid,"SCALARS ",scalars_name," double\n");
        print(fid,"LOOKUP_TABLE default\n");
        if (!binary)
            for j= 1:length(scalars)
                print(fid,scalars[j],"\n");
            end
        else
            fwrite(fid,cast(scalars,"double"),"double","n");
        end
    end
    
    print(fid,"\n");
    fid=close(fid);
    return true
end
export vtkexport

end
