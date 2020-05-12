using DifferentialEquations
using Plots
gr(size=(500,500), show = true)  #use the gr backend for plotting


alpx = 1.5;
betax = 5.0;
zx = 0.4;
nzx = 2.7;
nxz = 2.7;
xz = 1.5;
delz = 1.0;
S = 0.01:0.0001:10;
uval =  zeros(size(S,1)+1,3);
#Function for the lorenz equation
#u[1] = x; u[2] = y; u[3] = z
uval[1,:] = [0.1;0.0001;10]
for i  = 1:size(S,1)
    function lorenz!(du,u,p,t)
        du[1] =  ((alpx+betax*S[i])/(1+S[i]+(u[3]/zx)^nzx)) - u[1]               #dx/dt
        du[3] =  (1/(1+((u[1]/xz)^nxz))) - delz*u[3]                             #dz/dt
    end
                                                   #intial conditions
    tspan = (0.0,1000.0)                           #start and end time
    prob = ODEProblem(lorenz!,uval[i,:],tspan)     #Create an ODE problem for the Lorenz fxn
    sol = solve(prob)                              #Solve the system

#Loop over nums and check if the current number is even or odd
    uval[i+1,:] = sol.u[end]

end

S_rev = 10:-.0001:.01;
rev_uval =  zeros(size(S_rev,1)+1,3);

for i  = 1:size(S_rev,1)
    function lorenz!(du,u,p,t)
        du[1] =  ((alpx+betax*S_rev[i])/(1+S_rev[i]+(u[3]/zx)^nzx)) - u[1]               #dx/dt
        du[3] =  (1/(1+((u[1]/xz)^nxz))) - delz*u[3]                             #dz/dt
    end
                                      #intial conditions
    tspan = (0.0,1000.0)                     #start and end time
    prob = ODEProblem(lorenz!,rev_uval[i,:],tspan)     #Create an ODE problem for the Lorenz fxn
    sol = solve(prob)                       #Solve the system


#Loop over nums and check if the current number is even or odd
    rev_uval[i+1,:] = sol.u[end]

end


#Plot the results; the vars=(0,1) argument specifies to plot X (column 1 of sol)
#vs t (column 0 of sol)

plot(S,uval[2:end,1], xaxis="S", yaxis = "X" )
plot!(S_rev,rev_uval[2:end,1], xaxis="S", yaxis = "X" )
#plt2 = plot!(S_rev,rev_uval[2:end,1], xaxis="S", yaxis = "X" )
display()
#display(plt1,plt2)
