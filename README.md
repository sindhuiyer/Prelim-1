## Prelim 1 Solution - Sindhu Iyer

## Question 1

**(a)** To solve for for a specific volume basis, solve for B = <mc>VNc, where V = 1 mL, Nc = 1 x 10<sup>8</sup> cells/mL, and mc = 4.33 x 10<sup>-15</sup> gDW/cell for a doubling time of 40 minutes found on [Bionumbers][Td_1]. B is determined to be 4.33 x 10<sup>-5</sup> gDW. The given mRNA/cell values are converted to nmol and divided by B to give the specific volume on a nmol/gDW basis. ``1written`` and the ``1a.xlsx`` spreadsheet show the process.
  
[Td_1]:https://bionumbers.hms.harvard.edu/bionumber.aspx?id=103892&ver=10&trm=mass+ecoli+cell+doubling+time+40+min&org=
  
**(b)** Assuming steady state, m* was calculated. The written work can be found in ``1written``.

**(c)** First the promoter function u was determined by normalizing the nmol/gDW of mRNA and plotting it. The data was fitted to the model reviewed in lecture as done in the excel sheet for ``1c.xlsx``. The values for promoter model constants were determined to be n = 1.54, K = 0.204, W1 = 0.26 and W2 = 1.167. 

Gene abundance was determined to be 7.67 x 10<sup>-11</sup> nmol/gDW based on the number of copies in the cell. The gene abundance depends on the doubling time of the cells. The elongation rate constant was determined based on the elongation rate of the polymerase found on [Bionumbers][k_e] and the characteristic transcript length to be 3.72 min<sup>-1</sup>. The calculations can be seen in ``1written`` and the a table of constant values can be found in ``1c.xlsx``

You could assume that the parameters are the same as for A2 promoter from the McClure paper, but this would not lead to as precise of a fit. The calculations and values are shown in ``1written`` and ``1c.xlsx``. It would be best to assume that the gain is a constant value of 3.56 x 10<sup>-9</sup> nmol/gDW to create the best fit for the data.

[k_e]:https://bionumbers.hms.harvard.edu/bionumber.aspx?id=103021&ver=1&trm=rna+polymerase+elongation+rate&org=

**(d)** The model does have the correct fit we assume that the gain function K is a constant, 3.56 x 10<sup>-9</sup> nmol/gDW. The plot in ``1d.xlsx`` shows that.

## Question 2

**(a) & (b)** Refer to ``2written`` for the derivations and functions

**(c)** The nondimesional system of equations developed in (b) was solved for X in terms of X and S using Mathematica file ``2 (c)``. The stable steady-state values of X were plotted using Excel and circular referencing. The solid black lines on the bifurcation diagram are qualitatively reproducible as, the plot in ``2c.xlsx`` shows.

**(d)** The time varying values with the specified initial conditions were plotted using ``2D.jl`` file for S = 0.02, 10, and 10<sup>5</sup>. The nondimensional differential equations and constants were found in the paper. The produced plots are displayed in ``2plots.doc``.

**(e)**

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



