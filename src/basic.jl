
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
    Model

is an abstraction of model including
* `potential` <: Potential
* `nmax`: maximum of quantum number
* `mmax`: size of Hailtonian matrix
* `Ka` : wavenumber multiplied by `a`, period
* `qnum` <: Alternates
* and other parameters depending on specific potential

A subtype of model is expected to possess following methods:

* `update!(<:Model, ...)`
  * updates parameters in model.
"""
abstract type Model
end
