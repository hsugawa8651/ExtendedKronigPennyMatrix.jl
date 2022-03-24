
__precompile__(true)

using LinearAlgebra

module ExtendedKronigPennyMatrix
using Unitful

include("basic.jl")

export
   Alternates,
   get_E10,
   get_potential
export
   Model

include("KronigPenny.jl")

export
   KronigPennyPotential, 
   constructMatrix

end
