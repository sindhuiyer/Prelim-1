## Prelim 1 Solution - Sindhu Iyer

## Question 1

(a) To solve for B, use





(d) The model does have the correct fit we assume that the gain function K is a constant, 3.56 x 10<sup>11</sup> nmol/gDW.

### How to construct the stoichoimetric matric S for the urea cycle
The stoichiometric matrix was constructed using data from KEGG (arginine biosynthesis in humans). The matrix is contained in the ``data.CSV`` file.

### How to determine is the urea cycle reconstruction is elemntally balanced for C, H,N,O,P, and S
To check if the chemical reactions in the the ``data.CSV`` file are balanced, the elemental matrix was constructed by looking at the elemental compositions of the materials in each reaction. The matrix is contained in the ``element array.CSV`` file.

To determine if the stoichiometric matrix is elementally balanced, the following commands are issued:

  ```jl
    julia > using CSV
    julia > S=Matrix(CSV.read("data.CSV";header=0))
    julia > A=Matrix(CSV.read("element array.CSV";header=0))
    julia > balance=A'S
  ```
This will formulate the stoichiometric array,``S`` , the elemetal array, ``A``,  and then compute the product of ``transpose(A)*S``, which is defined as ``balance``. The first five columns and the final column of the ``balance`` array should contain only zeros, indicating that the urea cycle reconstruction is elementally balanced.

### How do I estimate the fluxes
To estimate the Urea flux, first define the array of species lower and upper bounds, contained in ``species array lower and upper.CSV``. Similarly, define the array of flux lower and upper bounds contained in ``flux array lower and upper.CSV``. Define the input c, the vector holding indicies for out objective vector, which in our case is urea.

  ```jl
    julia > LxUx=Matrix(CSV.read("species array lower and upper.CSV"))
    julia > LvUv=Matrix(CSV.read("flux array lower and upper.CSV"))
    julia > c=[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-1.0,0.0,0.0,0.0,0.0,0.0]
  ```
``LxUx`` contains an array of zeros since the system is at steady state. ``LvUv`` contains flux bounds further constrained by the metabolite data from Park et al paper. To estimate the Urea flux, issue the following commands:

  ```jl
    julia > include("Flux.jl")
    julia > calculate_optimal_flux_distribution(S,LvUv,LxUx,c;min_flag=true)
    
  ```

The output return the ``objective_value``, ``calculated_flux_array``, ``dual_value_array``, ``uptake_array``, ``exit_flag``, and ``status_flag``. The optimal flux that I calculated was approximately: 0.30 mmol/gDW-hr.



