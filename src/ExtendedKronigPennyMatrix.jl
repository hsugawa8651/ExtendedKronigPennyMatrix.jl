
__precompile__(true)

using LinearAlgebra

module ExtendedKronigPennyMatrix

include("basic.jl")

export
   Alternates,
   get_potential,
   update!

include("KronigPenny.jl")

export
   KronigPennyPotential, KronigPennyModel,
   constructMatrix

end
