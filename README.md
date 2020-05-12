## Prelim 1 Solution - Sindhu Iyer

## Question 1

**(a)** To solve for for a specific volume basis, solve for B = mcVNc, where V = 1 mL, Nc = 1 x 10<sup>8</sup> cells/mL, and mc = 4.33 x 10<sup>-15</sup> gDW/cell for a doubling time of 40 minutes found on [Bionumbers][Td_1]. B is determined to be 4.33 x 10<sup>-5</sup> gDW. The given mRNA/cell values are converted to nmol and divided by B to give the specific volume on a nmol/gDW basis. ``1written`` and the ``1(a).xlsx`` spreadsheet show the process.
  
[Td_1]:https://bionumbers.hms.harvard.edu/bionumber.aspx?id=103892&ver=10&trm=mass+ecoli+cell+doubling+time+40+min&org=
  
**(b)** Assuming steady state, m* was calculated. The written work can be found in ``1written``.

**(c)** First the promoter function u was determined by normalizing the nmol/gDW of mRNA and plotting it. The data was fitted to the model reviewed in lecture as done in the excel sheet for ``1(c).xlsx``. The values for promoter model constants were determined to be n = 1.54, K = 0.204, W1 = 0.26 and W2 = 1.167. 

Gene abundance was determined to be 7.67 x 10<sup>-11</sup> nmol/gDW based on the number of copies in the cell.  The elongation rate constant was determined based on the elongation rate of the polymerase found on [Bionumbers][k_e] and the characteristic transcript length to be 3.72 min<sup>-1</sup>. The calculations can be seen in ``1written`` and the a table of constant values can be found in ``1(c).xlsx``

You could assume that the parameters are the same as for A2 promoter from the McClure paper, but this would not lead to as precise of a fit. The calculations and values are shown in ``1written`` and ``1(c).xlsx``. It would be best to assume that the gain is a constant value of 3.56 x 10<sup>-9</sup> nmol/gDW to create the best fit for the data.

[k_e]:https://bionumbers.hms.harvard.edu/bionumber.aspx?id=103021&ver=1&trm=rna+polymerase+elongation+rate&org=

**(d)** The model does have the correct fit we assume that the gain function K is a constant, 3.56 x 10<sup>-9</sup> nmol/gDW. The plot in ``1(d).xlsx`` shows that.

## Question 2

**(a) & (b)** Refer to ``2written`` for the derivations and functions

**(c)** The nondimesional system of equations developed in (b) was solved for X in terms of X and S using Mathematica file ``2 (c).nb``. The stable steady-state values of X were plotted running ``Q2C.jl``, and the plot is in ``2plots.doc`` The solid black lines on the bifurcation diagram are qualitatively reproducible as the plot shows.

**(d)** The time varying values with the specified initial conditions were plotted by running ``Q2D.jl`` file for S = 0.02, 10, and 10<sup>5</sup>. The nondimensional differential equations and constants were found in the paper. The produced plots are displayed in ``2plots.doc``.

**(e)**



  ```jl
    julia > LxUx=Matrix(CSV.read("species array lower and upper.CSV"))
    julia > LvUv=Matrix(CSV.read("flux array lower and upper.CSV"))
    julia > c=[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-1.0,0.0,0.0,0.0,0.0,0.0]
  ```




