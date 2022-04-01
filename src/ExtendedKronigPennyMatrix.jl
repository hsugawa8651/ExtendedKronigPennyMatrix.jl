
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

include("FiniteSquareWell.jl")
include("SimpleHarmonicOscillator.jl")

export
   FiniteSquareWell, 
   SimpleHarmonicOscillator,
   constructMatrix

end
