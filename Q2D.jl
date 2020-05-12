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
S = 100000;

#Function for the lorenz equation
#u[1] = x; u[2] = y; u[3] = z
function lorenz!(du,u,p,t)
 du[1] =  ((alpx+betax*S)/(1+S+(u[3]/zx)^nzx)) - u[1]               #dx/dt
 du[2] =  ((alpy+betay*S)/(1+S+(u[1]/xy)^nxy)) - dely*u[2]          #dy/dt
 du[3] =  (1/(1+((u[1]/xz)^nxz)+((u[2]/yz)^nyz))) - delz*u[3]          #dz/dt
end

u0 = [0.0;0.0;0.0]                      #intial conditions
tspan = (0.0,50)                        #start and end time
prob = ODEProblem(lorenz!,u0,tspan)     #Create an ODE problem for the Lorenz fxn
sol = solve(prob)                       #Solve the system

#Plot the results; the vars=(0,1) argument specifies to plot X (column 1 of sol)
#vs t (column 0 of sol)
plt1 = plot(sol,vars=(0,1), xaxis="t", yaxis = "X" )
display(plt1)
