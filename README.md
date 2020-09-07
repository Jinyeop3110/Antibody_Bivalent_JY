# 2020_Antibody_ThermoCalc_JY (last updated : 2020 / 07 / 20)
 
## Description
This code calculates thermodynamic properties of antigen-antibody system with weak-bidning linkers. Markov Chain Monte Carlo(MCMC) method is used for the thermodynamic simulation. The project is under supervision of Prof.Won-Ki Cho & Prof.Byung-Ha Oh

## Requirement
MATALB(>2019)
Parallel Computing Toolbox(https://kr.mathworks.com/help/parallel-computing/index.html)

## Overview
[Folders]

>**`AT_system`**: is set of functions working for MCMC simulation of antigen-antibody system. For now, linear1D, circular1D, square2D, triangularSphere2D, qubicSphere2D are supported for antigen distributing pattern.

>**`AntonSemechko-S2-Sampling-Toolbox-79cc337`**: generates uniform sampling patterns and decompositions of a unit sphere. This code is written by AntonSemechko, (see https://github.com/AntonSemechko/S2-Sampling-Toolbox)

>**`Data`**: a place to store data from MCMC thermodynamic simulation.

>**`Figure`**: a place to store figures from MCMC thermodynamic simulation.

[Main functions]

>**`Demo_SingleRun_ThermoCalc.m`**: is demo code for single run of MCMC thermodynamic simulation. The code supports a visualization of an antigen-antibody system with weak-binding linkers and it's step-wise evolution as MCMC progresses.

>**`Demo_Kd2Change_ThermoCalc.m`**: is demo code for multiple run of MCMC thermodynamic simulation as Kd2 changes. The code supports a graph visualization of semilog plot of antigen binding occupancy and loglog plot of effective Kd.

## Demo
See Demo_SingleRun_ThermoCalc.m & Demo_Kd2Change_ThermoCalc.m

## Contact
The code and README is written by Jinyeop Song(KAIST, Department of Physics, yeopjin@kaist.ac.kr)
