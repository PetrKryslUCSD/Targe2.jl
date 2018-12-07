# Targe2.jl

Constrained triangulation of arbitrary two-dimensional regions.

<img src=  "http://hogwarts.ucsd.edu/~pkrysl/site.images/ScreenHunter_31 Feb. 12 20.51.jpg" height=200>
<img src=  "http://hogwarts.ucsd.edu/~pkrysl/site.images/ScreenHunter_32 Feb. 12 20.55.jpg" height=200>

Targe2.jl implements an interface to the C-language program
Targe2 for advancing-front triangulation of two-dimensional regions
with arbitrary boundaries and vertex and curve constraints.

The author would appreciate if issues and suggestions were reported. 
Please don't hesitate to e-mail pkrysl@ucsd.edu.
 
## Get Targe2.jl 
 
Pkg.clone("https://github.com/PetrKryslUCSD/Targe2.jl")

## Testing

Pkg.test("Targe2")
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build Status](https://travis-ci.org/PetrKryslUCSD/Targe2.jl.svg?branch=master)](https://travis-ci.org/PetrKryslUCSD/Targe2.jl) 
[![Build status](https://ci.appveyor.com/api/projects/status/0qgyw2aa2529fahy?svg=true)](https://ci.appveyor.com/project/PetrKryslUCSD/Targe2-jl)  

## Usage

Examples of inputs can be found in the srcoftests.jl  source file 
in the test folder. The folder "samples"  holds pretty much 
the same information in individual files.

The User's Guide in PDF form is available in the "doc" folder.

 
