# KronigPenny

"""
    mutable struct KronigPennyPotential <: Potential

    KronigPennyPotential(v0, ρ) # Default constructor

holds parameters of Kronig-Penny potential.

Fields
* `v0` : potential height in units of ``E_{1}^{(0)}``
* `ρ` : barrier width in units of period ``a``,  ``\\rho = \\dfrac{b}{a}``, ``0 < \\rho < 1``
  * Note that a position ``x`` is expressed in units of ``a`` throughout this package.

The constructor `KronigPennyPotential(v0, ρ)` confirms that `0 ≤ ρ ≤ 1`, otherwise throws an error.
"""
mutable struct KronigPennyPotential <: Potential
   v0:: Real
   ρ:: Real # ρ = b/a

   KronigPennyPotential(v0, ρ) = 0 ≤ ρ ≤ 1 ? new(v0,ρ) : error("ρ < 0 or 1 < ρ")
end

"""
    get_potential(::KronigPennyPotential)

returns a function ``v`` to evaluate potential ``v(x)`` as a position ``x``, 
such that:
```math
\\begin{aligned}
v(x) & = \\begin{cases} 
v_{0} &
\\text{inside well, i.e.,} 
 \\dfrac{1-\\rho}{2} \\le \\dfrac{x}{a} \\le \\dfrac{1+\\rho}{2}, 
 \\\\ 
0 & \\text{outside well}\\end{cases}
\\\\
v(x+a) &= v(x)
\\end{aligned}
```
* Note that a position ``x`` is expressed in units of ``a`` throughout this package.
"""
function get_potential(pot::KronigPennyPotential)
   return x -> (1-pot.ρ)/2 <= mod(x,1)< (1+pot.ρ)/2 ? 0 : pot.v0
end



"""
    mutable struct KronigPennyModel <: Model

holds parameters of Kronig-Penny model.

* Fields given to the constructor:
  * `potential`
  * `nmax`
  * `Ka` : wavenumber multiplied by `a`, period
* Fields calculated by constructor:
  * `mmax` : size of Hamiltonian matrix
  * `qnum` : iterator of quantum numbers
* Fields calculated by constructor and `update!` methods:
  * `hnm` : hamiltonian matrix
"""
mutable struct KronigPennyModel <: Model
   potential::KronigPennyPotential
   nmax::Int64  # maximum of quantum numbers
   mmax::Int64  # size of Hamiltonian
   Ka::Float64
   qnum::Alternates
   hnm::Matrix
end

"""
    KronigPennyModel(::KronigPennyPotential, nmax, Ka)

is a constructor of Kronig-Penny model, and defines other fields: `qnum`, `nmax`, and `hnm`
* Mandantory parameters:
  * `pot` : potential
  * `nmax` : maximum of quantum numbers
  * `Ka` : wavenumber multiplied by `a`, period
"""
function KronigPennyModel(pot::KronigPennyPotential, nmax, Ka)
   qnum=Alternates(nmax)
   mmax=length(qnum)
   hnm=zeros(Float64,(mmax,mmax))
   model_lem=KronigPennyModel(pot,nmax,mmax,Ka,qnum,hnm)
   constuctMatrix(model_lem)
   model_lem
end


"""
    update!(model_lem::KronigPennyModel; Ka=nothing)

updates Kronnig-Penny model.

* Optional parameters
  * `Ka` : wavenumber multiplied by `a`, period
"""
function update!(model_lem::KronigPennyModel; Ka=nothing)
   if !isnothing(Ka)
      model_lem.Ka=Ka
   end
   constuctMatrix(model_lem)
   model_lem
end


"""
    constuctMatrix(model_lem::KronigPennyModel)

computes and fills Hamiltonian matrix fields `hnm` in `model_lem`.

```math
h_{nm} = \\begin{cases} 
\\left(2n + \\dfrac{Ka}{\\pi}\\right)^{2} + v_{0} (1-\\rho) &
\\text{for}\\; n = m\\;\\text{(diagonal elements)} \\\\
v_{0}
\\dfrac{(-1)^{m-n+1}}{\\pi} \\dfrac{\\sin \\pi(m-n)\\rho}{m-n} 
 & 
 \\text{for}\\; n \\neq m\\;\\text{(off-diagonal elements)}\\end{cases}
```
"""
function constuctMatrix(model_lem::KronigPennyModel)
   qnum=model_lem.qnum
   hnm=model_lem.hnm
   Ka=model_lem.Ka
   potential=model_lem.potential
   v0=potential.v0
   ρ=potential.ρ
   
   for (i,m) in enumerate(qnum)
      for (j,n) in Iterators.take(enumerate(qnum), i-1)
         hnm[i,j] = 0
      end
   end

   for (i,m) in enumerate(qnum)
      hnm[i,i] = (2m+Ka/π)^2 + v0*(1-ρ)
   end

   for (i,m) in enumerate(qnum)
      for (j,n) in Iterators.take(enumerate(qnum), i-1)
         hnm[i,j] = v0*(-1)^(m-n+1)/π * sinpi((m-n)ρ)/(m-n)
      end
      for (j,n) in Iterators.drop(enumerate(qnum), i)
         hnm[i,j] = v0*(-1)^(m-n+1)/π * sinpi((m-n)ρ)/(m-n)
      end
   end
end