@testset "Alternates" begin
   @test collect(Alternates(0)) == [0] 
   @test collect(Alternates(1)) == [0, 1, -1 ] 
   @test collect(Alternates(2)) == [0, 1, -1, 2, -2 ] 
   @test collect(Alternates(3)) == [0, 1, -1, 2, -2, 3, -3 ] 
end
