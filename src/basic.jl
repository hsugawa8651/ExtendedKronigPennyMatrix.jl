
"""
    Alternates(nmax)

is an iterator to generate the series ``\\{0, 1, -1, 2, -2, \\ldots \\}``
up to `nmax` as an ordering of quantum numbers.

```
collect(Alternates(0)) => [0]
collect(Alternates(1)) => [0, 1, -1]
collect(Alternates(2)) => [0, 1, -1, 2, -2]
```
"""
struct Alternates
   nmax::Int
end

Base.eltype(::Type{Alternates}) = Int
Base.length(alt::Alternates) = alt.nmax*2+1

"""
    Base.iterate(alt::Alternates, state::Int = 1)
"""
function Base.iterate(alt::Alternates, state::Int = 1)
   state > alt.nmax*2+1 && return nothing
   nxt = state ÷ 2
   if state % 2 == 1
      nxt *= -1
   end
   (nxt, state+1)
end

"""
    get_E10(a; me=1)

calculates the ground state energy ``E_{1}^{(0)}``.

```math
E_{1}^{(0)} = \\dfrac{\\pi^2\\hbar^2}{2ma^2}
```

* `a` : system length
* `me` : electron mass

This function handles physical quantities with Unitful package.
* If `a` is dimensionless, suppose that `a` is in `nm` unit.
  * Otherwise, `a` must have a dimension of length `L`.

* If `me` is dimensionless, suppose that `me` is an effective mass with respect to electron rest mass.
  * Otherwise, `me` must have a dimension of mass `M`.

* The resultant enegy value is repesented in `eV`.
"""
function get_E10(a; me=1)
   a0 = if isa(a, Unitful.Length)
      a
   elseif  isa(a, Real)
      a * 1u"nm"
   else
      throw(Unitful.DimensionError)
   end

   m0 = if isa(me, Unitful.Mass)
      me
   elseif  isa(me, Real)
      me * 1u"me"
   else
      throw(Unitful.DimensionError)
   end

   e10 = pi^2*(1u"ħ")^2 / (2*m0*a0^2) |> u"eV"
   return e10
end

"""
    Potential

is an abstraction of potential including
* potential height, and/or
* other parameters depending on specific potential.

A subtype of `Potential` is expected to possess following methods:
* `get_potential(<:Potential)`
  * returns a function to evaluate potential value as a position.
"""
abstract type Potential
end

"""
    struct Model{P<:Potential}

is an abstraction of model including following fields:
  * `potential` : concrete Potential
  * `Ka` : wavenumber multiplied by `a`, period
  * `nmax` : maximum of quantum numbers
  * `mmax` : size of Hamiltonian matrix
  * `qnum` : iterator of quantum numbers
  * `hnm` : hamiltonian matrix

A concrete subtype of model is expected to possess following methods:
  * `constuctMatrix(model::Model{P})`
"""
struct Model{P<:Potential}
   potential::P
   Ka::Float64
   nmax::Int64  # maximum of quantum numbers
   mmax::Int64  # size of Hamiltonian
   qnum::Alternates
   hnm::Matrix
end


"""
    function Model(pot::Potential,Ka::Float64,nmax::Int64=60)

is a constructor of Kronig-Penny model, and defines other fields: `qnum`, `nmax`, and `hnm`

* Mandantory parameters:
  * `pot` : potential
  * `Ka` : wavenumber multiplied by `a`, period
  * `nmax` : maximum of quantum numbers

* Mandantory parameters:
  * `potential`
  * `Ka` : wavenumber multiplied by `a`, period

* Optional parameters: 
  * `nmax` : maximum of quantum numbers
"""
function Model(pot::Potential,Ka::Float64,nmax::Int64=60)
   qnum=Alternates(nmax)
   mmax=length(qnum)
   hnm=zeros(Float64,(mmax,mmax))
   model=Model(pot,Ka,nmax,mmax,qnum,hnm)
   constuctMatrix(model)
   model
end