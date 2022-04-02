
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
include("InvertedHarmonicOscillator.jl")
include("LinearWell.jl")

export
   FiniteSquareWell, 
   SimpleHarmonicOscillator,
   InvertedHarmonicOscillator,
   LinearWell,
   constructMatrix

end
