```@meta
CurrentModule = ExtendedKronigPennyMatrix
```

# ExtendedKronigPennyMatrix

Documentation for [ExtendedKronigPennyMatrix](https://github.com/hsugawa8651/ExtendedKronigPennyMatrix.jl).

# Introduction

Construct a numerical Hamiltonian matrix $(h_{nm})$ of Kronig-Penny model 
extended to arbitrary potentials 
based on the paper written by Pavelich and Marsiglio.

```math
\sum_{m=1}^{\infty} h_{nm} c_{m} = ec_{n}
```

Energy is expressed in units of $E_{1}^{(0)}$.

```math
E_{1}^{(0)} = \dfrac{\pi^2\hbar^2}{2ma^2}
```

Refer the formulations to the following paper:
> R. L. Pavelicha and F. Marsigliob,
> "The Kronig-Penney model extended to arbitrary potentials via numerical matrix mechanics," American Journal of Physics 83, 774 (2015). 
> [DOI:10.1119/1.4923026](https://doi.org/10.1119/1.4923026), 
> [ResearchGate](https://www.researchgate.net/publication/268227429_The_Kronig-Penney_model_extended_to_arbitrary_potentials_via_numerical_matrix_mechanics)

