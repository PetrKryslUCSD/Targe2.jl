module Targe2
#
# =========================================================================

# targe2: a program for "T"riangulation of "AR"bitrary "GE"ometries in "2"D

# =========================================================================

#                   Copyright: 1993, 1994 Petr Krysl 

#    Czech Technical University in Prague, Faculty of Civil Engineering,
#        Dept. Structural Mechanics, 166 29 Prague, Czech Republic,
#                       e-mail: pk@power2.fsv.cvut.cz

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

# =========================================================================
#

__precompile__(false)

using Printf
using DelimitedFiles

export targe2mesher

include("Utilities.jl")
using .Utilities: _executable, _area2, showmesh

 
"""
    targe2mesher(commands::String; args...)

Automatic triangulation of a general 2-D regions. 

Automatic triangulation of a general 2-D domain. The input is given as a
string representing a file of commands to the mesher Targe2. These are
described in the manual, `targe2_users_guide.pdf`.

# Input:
- `commands` -- a string, representing a file of commands recognized by the
  mesher (targe2_users_guide.pdf)
thickness -- thickness of the two-dimensional slab
- `quadratic` -- convert the triangulation to quadratic elements, true or
  false;
- `mergetolerance` -- see this option in targe2_users_guide.pdf

# Output:
- `mesh` –- named tuple with
    - `xy` = array of vertex locations, one per line, 
    - `triconn` = array of triangle connectivities, one per triangle, 
    - `trigroups` = triangle groups, the triangles in the individual subregions;
          For instance groups[3] is the list of the triangles that belong to
          subregion 3
    - `edgeconn` = , 
    - `edgegroups` = array of indexes of the edge elements on the individual
          edges;

# Examples: 
```julia
h=2;
mesh = targe2mesher(\"""
    curve 1 line 0 0 75 0
    curve 2 line 75 0 75 40
    curve 3 line 75 40 0 0
    curve 34 line 75 40 0 40
    curve 4 circle Center 60 10 radius 8
    subregion 1  property 1 boundary 1  2 3 34 hole -4
    subregion 2  property 2 boundary 4
    m-ctl-point constant \$h
    \""");
```
"""
function targe2mesher(commands::String; args...)
   # Process additional arguments
    quadratic = false;
    mergetolerance = eps(1.0);
    for arg in pairs(args)
        sy, val = arg
        if sy == :quadratic
            quadratic = val
        elseif sy == :mergetolerance
            mergetolerance = val
        end
    end
    
    # Input file
    inpath, inio = mktemp()
    @printf(inio,"%s\n",commands);
    close(inio);               # input written

    # Output file
    outpath, outio = mktemp()
    close(outio)                # close it, as it is going to be written when the mesher is run

    exe = _executable()
    run(`"$exe" -i "$inpath" -f  2  -o "$outpath"`);
    
    outio = open(outpath)        # open the output file
    
    l = readline(outio);
    totals = readdlm(IOBuffer(l)) # totals of vertices, edges, and triangles

    # Read the vertices
    vs = fill(0.0, convert(Int,totals[1]), 4)
    for j=1:size(vs, 1)
        l = readline(outio);
        vs[j,:] = readdlm(IOBuffer(l))
    end
    # Read the edges
    es = fill(0, convert(Int,totals[2]), 4)
    for j=1:size(es, 1)
        l = readline(outio);
        es[j,:] = readdlm(IOBuffer(l))
    end
    # Read the triangles
    ts = fill(0, convert(Int,totals[3]), 5)
    for j=1:size(ts, 1)
        l = readline(outio);
        ts[j,:] = readdlm(IOBuffer(l))
    end
 
    close(outio)              # close it, we are done reading
    
    # Assign triangle groups
    ngroup = convert(Int,maximum(ts[:,5]))
    trigroups = Vector{Int}[]
    for i=1:ngroup
        push!(trigroups, Int[])
    end    
    for i= 1:size(ts, 1)
        group = ts[i,5];
        push!(trigroups[group], i);
    end

    # Assign edge groups
    ngroup =  convert(Int,maximum(es[:,4]))
    edgegroups = Vector{Int}[]
    for i=1:ngroup
        push!(edgegroups, Int[])
    end    
    edgegroups
    for i= 1:size(es, 1)
        group = es[i,4];
        if (group != 0)
            push!(edgegroups[group], i);
        end
    end

    # Vertices
    XY = fill(0.0, convert(Int,totals[1]), 2)
    @. XY = vs[Int.(vs[:,1]), 2:3]

    if quadratic
        nnodes = size(XY, 1);
        nedges = size(es, 1);
        nmidnodes = nedges;
        oes = es;
        es = fill(zero(es[1]), size(es,1), size(es,2)+1)
        es[:,1:4] .= oes;
        es[:,5] .= (nnodes+1:nnodes+nmidnodes);
        oxy = XY;
        XY = fill(zero(XY[1]), size(XY,1)+nmidnodes, size(XY,2))
        @. XY[1:size(oxy,1), :] = oxy;    # 
        edgeconn = fill(0, nedges, 3);
        for i=1:nedges
            XY[nnodes+i,:] = mean(oxy[vec(es[i,2:3]), :], dims = 1); # location of mid-side node
            edgeconn[i,:] .= es[i,[2,3,5]]
        end
        ntris = size(ts, 1);
        triconn = fill(0, ntris, 6);
        for i=1:ntris               # generate the triangles
            ix = vec(ts[i,2:4])
            nns = [intersect(es[ix[1],2:3],es[ix[3],2:3]),
                 intersect(es[ix[1],2:3],es[ix[2],2:3]),
                 intersect(es[ix[2],2:3],es[ix[3],2:3])];
            enns = vec(es[ix,5]);   # edge mid-side nodes
            nns = vec([nns, enns]);      # connectivity of the six node triangle
            if det([1 XY[nns[1],:]; 1 XY[nns[2],:]; 1 XY[nns[3],:]]) < 0.0
                nns = nns[[1, 3, 2, 6, 5, 4]];
            end
            triconn[i,:] = nns;
        end
    else
        ntris = size(ts, 1);
        triconn = fill(0, ntris, 3);
        for i=1:ntris
            nns = unique(vcat(vec(es[ts[i,2],2:3]), vec(es[ts[i,3],2:3]), vec(es[ts[i,4],2:3])))
            if _area2(vec(XY[nns[2],:] - XY[nns[1],:]), vec(XY[nns[3],:] - XY[nns[1],:])) < 0.0
                nns = nns[[1, 3, 2]];
            end
            triconn[i,:] = nns;
        end
        nedges = size(es, 1);
        edgeconn = fill(0, nedges, 2);
        for i=1:nedges
            edgeconn[i,:] = es[i,2:3];
        end
    end

    return (xy = XY, triconn = triconn, trigroups = trigroups, edgeconn = edgeconn, edgegroups = edgegroups);
end

"""
    demo(filename, commands)

Generate a mesh Targe2 and show it with Paraview.
"""
function demo(filename, commands; show = false)
    mesh = targe2mesher(commands)
    show && showmesh(filename, mesh)
    return mesh
end

end
