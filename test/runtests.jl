
using ExtendedKronigPennyMatrix
using Test
using Unitful

@testset "ExtendedKronigPennyMatrix.jl" begin
   include("Alternates.jl")
   include("basic.jl")
   # include("KronigPennyTest.jl")
end
