
__precompile__(true)

using LinearAlgebra

module ExtendedKronigPennyMatrix
using Unitful

include("basic.jl")

export
   Alternates,
   get_E10,
   get_potential

include("KronigPenny.jl")

export
   KronigPennyPotential, KronigPennyModel,
   constructMatrix

end
