@testset "KronigPenny" begin
   @testset "KP_ex" begin
      filenames = [ 
         "KP_10_05.png", "KP_10_08.png", 
         "Pavelich_Fig4a.png", "Pavelich_Fig4b.png",
         "Pavelich_Fig6.png", "Pavelich_Fig7.png" ]
      ENV["MPLBACKEND"]="agg" # no GUI
      using PythonPlot
      using LaTeXStrings
      include("../example/ex1_FiniteSquareWell.jl")
      using CRC32c
      for filename in filenames
         @test open(crc32c, filename) == open(crc32c, joinpath("example", filename))
         rm(filename)
      end
   end
end
