@testset "basic" begin
   @test get_E10(1.0) ≈ 0.3760301626167376u"eV"
   @test get_E10(1u"nm") ≈ 0.3760301626167376u"eV"
   @test get_E10(1u"nm", me=1.0) ≈ 0.3760301626167376u"eV"
end
