using DifferentialEquations
using Plots
gr(size=(500,500), show = true)  #use the gr backend for plotting

alpx = 3.9*10^-2;
alpy = 4.3*10^-3
betax = 6.1;
betay = 5.7;
zx = 1.3*10^-5;
yz = 11*10^-3;
nzx = 2.32;
nxy = 2;
nxz = 2;
nyz = 2;
xz = 12*10^-2;
xy = 7.9*10^-4;
delz = 1.04;
dely = 1.05;
S = 0.5;

#Function for the lorenz equation
#u[1] = x; u[2] = y; u[3] = z
function lorenz!(du,u,p,t)
 du[1] =  ((alpx+betax*S)/(1+S+(u[3]/zx)^nzx)) - u[1]               #dx/dt
 du[2] =  ((alpy+betay*S)/(1+S+(u[1]/xy)^nxy)) - dely*u[2]          #dy/dt
 du[3] =  (1/(1+((u[1]/xz)^nxz)+((u[2]/yz)^nyz))) - delz*u[3]          #dz/dt
end

u0 = [0.0;0.0;0.0]                      #intial conditions
tspan = (0.0,100)                        #start and end time
prob = ODEProblem(lorenz!,u0,tspan)     #Create an ODE problem for the Lorenz fxn
sol = solve(prob)                       #Solve the system

#Plot the results; the vars=(0,1) argument specifies to plot X (column 1 of sol)
#vs t (column 0 of sol)

# get final ss value
xhopf = sol.u[end]
S = 100;
# xsaddle
# cell 1
uc_1 = xhopf
# simulate cell 1 with u0 = uc_1
prob1 = ODEProblem(lorenz!,uc_1,tspan)     #Create an ODE problem for the Lorenz fxn
sol1 = solve(prob1)
# cell 2
uc_2 = xsaddle .* 1.25
# simulate cell 2 with u0 = uc_2
prob2 = ODEProblem(lorenz!,uc_2,tspan)     #Create an ODE problem for the Lorenz fxn
sol2 = solve(prob2)
# cell 3
# simulate cell 3 with u0 = uc_3
uc_3 = xsaddle .* 0.75

prob3 = ODEProblem(lorenz!,uc_3,tspan)     #Create an ODE problem for the Lorenz fxn
sol3 = solve(prob3)

plot(sol1,vars = (0,3), xaxis="t", yaxis = "Z")
plot!(sol2,vars = (0,3), xaxis="t", yaxis = "Z")
plot!(sol3,vars = (0,3), xaxis="t", yaxis = "Z")
