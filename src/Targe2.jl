module Targe2
# /*  
#     =========================================================================

#     targe2: a program for "T"riangulation of "AR"bitrary "GE"ometries in "2"D

#     =========================================================================

#                       Copyright: 1993, 1994 Petr Krysl 

#        Czech Technical University in Prague, Faculty of Civil Engineering,
#            Dept. Structural Mechanics, 166 29 Prague, Czech Republic,
#                           e-mail: pk@power2.fsv.cvut.cz

#     This program is free software; you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation; either version 2 of the License, or
#     (at your option) any later version.

#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.

#     You should have received a copy of the GNU General Public License
#     along with this program; if not, write to the Free Software
#     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

#     =========================================================================
    # */

include("Export.jl")

function targe2mesher(commands::String; args...)
    # Automatic triangulation of a general 2-D domain. 
    #
    # function [fens,fes,groups,edge_fes,edge_groups] =
        #                     targe2_mesher(fs,thickness,varargin)
    #
    # Automatic triangulation of a general 2-D domain. The input is given as a cell array
    # of commands to the mesher Targe2. These are described in the manual,
    # targe2_users_guide.pdf.
    #
    # Input:
    # fs -- cell array of strings, each string a command recognized
    #       by the mesher (targe2_users_guide.pdf) 
    # thickness -- thickness of the two-dimensional slab
    # varargin-- optional argument: structure with name-value pairs
    #                - quadratic: convert the triangulation to
    #                             quadratic elements, true or false;
    #                - merge_tolerance: see this option in
    #                             targe2_users_guide.pdf
    #                - and any other attributes recognized by the constructors
    #                of the geometric cells, for instance axisymm.
    #
    # Output:
    #  fens= the finite element nodes
    #  fes=the triangles
    # The following are optional outputs:
    #  groups=cell array of indexes of the triangles in the individual subregions;
    #       For instance groups{3} is the list of the triangles that belong to
    #       subregion 3
    #  edge_fes=cell array of the edge elements
    #  edge_groups=cell array of indexes of the edge elements on the individual
    #       edges;
    #
    # Examples: 
    # h=5;
    # [fens,fes,groups,edge_fes,edge_groups]=targe2_mesher({...
    #     'curve 1 line 0 0 75 0',...
    #     'curve 2 line 75 0 75 40',...
    #     'curve 3 line 75 40 0 0',...
    #     'curve 4 circle Center 60 10 radius 8',...
    #     ['subregion 1  property 1 boundary '...
    #     ' 1  2 3 hole -4'],...
    #     ['subregion 2  property 2 boundary 4'],...
    #     ['m-ctl-point constant ' num2str(h)]
    #     }, 1);
    # gv= reset(graphic_viewer);
    # drawmesh({fens,subset(fes,groups{1})},'gv',gv,'fes','facecolor','r','shrink', 0.9)
    # drawmesh({fens,subset(fes,groups{2})},'gv',gv,'fes','facecolor','y','shrink', 0.9)
    # view(2)
    #
    # See also: 
    
    quadratic= false;
    mergetolerance =eps(1.0);
    for arg in args
        sy, val = arg
        if sy==:quadratic
            quadratic=val
        elseif sy==:mergetolerance
            mergetolerance=val
        end
    end
    
    # Input file
    inpath, inio =mktemp()
    @printf(inio,"%s\n",commands);
    close (inio);               # input written

    # Output file
    outpath, outio =mktemp()
    close(outio)                # close it, as it is going to be written when the mesher is run

    onWindows=@windows?  true: false
    if (onWindows)
        exe=Pkg.dir("Targe2","bin") * "/Targe2.exe"
        #exe="C:/Users/P/Documents/GitHub/Targe2.jl" * "/bin/" * "Targe2.exe"
	# exe="C:/Users/pkrysl/Dropbox/Targe2.jl-master/bin/" * "Targe2.exe"
        # Run it
        run (`"$exe" -i "$inpath" -f  2  -o "$outpath"`);
    else
        onLinux=@linux?  true: false
        if (onLinux)
            exe=Pkg.dir("Targe2","bin") * "/targe2_GLNXA64"
            #exe="/home/pkrysl/Documents/Targe2.jl-master/bin/targe2_GLNXA64"
            run (`chmod +x "$exe"`);
	    run (`"$exe" -i "$inpath" -f  2  -o "$outpath"`);
        else
            if (false)
            else
                error("Computer platform " * " is not supported: contact the author")
            end
        end
    end
    
    outio= open(outpath)        # open the output file
    
    l=readline(outio);
    totals= readdlm(IOBuffer(l)) # totals of vertices, edges, and triangles

    # Read the vertices
    vs=zeros(Float64,convert(Int,totals[1]),4)
    for j=1:totals[1]
        l=readline(outio);
        vs[j,:]= readdlm(IOBuffer(l))
    end
    # Read the edges
    es=zeros(Float64,convert(Int,totals[2]),4)
    for j=1:totals[2]
        l=readline(outio);
        es[j,:]= readdlm(IOBuffer(l))
    end
    # Read the triangles
    ts=zeros(Float64,convert(Int,totals[3]),5)
    for j=1:totals[3]
        l=readline(outio);
        ts[j,:]= readdlm(IOBuffer(l))
    end

    close(outio)              # close it, we are done reading
    
    # Assign triangle groups
    ngroup=  convert(Int,maximum(ts[:,5]))
    trigroups = cell(ngroup)
    for i=1:length(trigroups)
        trigroups[i]=Int[]
    end    
    for i= 1:totals[3]
        group =ts[i,5];
        push!(trigroups[group],i);
    end

    # Assign edge groups
    ngroup=  convert(Int,maximum(es[:,4]))
    edgegroups = cell(ngroup)
    for i=1:length(edgegroups)
        edgegroups[i]=Int[]
    end    
    for i= 1:totals[2]
        group =es[i,4];
        if (group!=0)
            push!(edgegroups[group],i);
        end
    end

    # Vertices
    XY=zeros(Float64,convert(Int,totals[1]),2)
    XY=float(vs[int(vs[:,1]),2:3])

    if quadratic
        nnodes= size (XY, 1);
        nedges=size(es, 1);
        nmidnodes =nedges;
        oes=es;
        es=  zeros(typeof(es),size(es,1),size(es,2)+1)
        es[:,1:4]=oes;
        es[:,5]= [(nnodes+1:nnodes+nmidnodes)];
        oxy=XY;
        XY=  zeros(typeof(XY),size(XY,1)+nmidnodes,size(XY,2))
        XY[1:size(oxy,1),:]=oxy;    # 
        edgeconn=zeros(nedges,3);
        for i=1:nedges
            XY[nnodes+i,:]=mean(oxy[es[i,2:3],:],1); # location of mid-side node
            edgeconn[i,:] =es[i,[2,3,5]]
        end
        ntris=size (ts, 1);
        triconn=zeros(Int,ntris,6);
        for i=1:ntris               # generate the triangles
            nns=[intersect(es[ts[i,2],2:3],es[ts[i,2],2:3]),
                 intersect(es[ts[i,2],2:3],es[ts[i,3],2:3]),
                 intersect(es[ts[i,3],2:3],es[ts[i,4],2:3])];
            enns=es[ts[i,2:4],5];   # edge mid-side nodes
            nns = [nns, enns];      # connectivity of the six node triangle
            if det([1 XY[nns[1],:]; 1 XY[nns[2],:]; 1 XY[nns[3],:]])<0.
                nns=nns([1, 3, 2, 6, 5, 4]);
            end
            triconn[i,:] =nns;
        end
    else
        ntris=size (ts, 1);
        triconn =zeros(Int,ntris,3);
        for i=1:ntris
            nns=int(unique([es[ts[i,2],2:3] es[ts[i,3],2:3] es[ts[i,4],2:3]]));
            if det([1 XY[nns[1],:]; 1 XY[nns[2],:]; 1 XY[nns[3],:]])<0.
                nns =nns[[1, 3, 2]];
            end
            triconn[i,:] =nns;
        end
        nedges=size(es, 1);
        edgeconn =zeros(Int,nedges,2);
        for i=1:nedges
            edgeconn[i,:] =es[i,2:3];
        end
    end

    return XY,triconn,trigroups,edgeconn,edgegroups;
end
export targe2mesher

end
