@testset "Droplets" begin
    @test PointDroplet() == PointDroplet()
    @test PointDroplet() == SquareDroplet(false)
    @test PointDroplet() != TurboDroplet(1)
    @test GaussianDroplet(0.0) == PointDroplet()
    @test LanczosDroplet{3}(BigFloat(6.7)) != PointDroplet()
    @test SquareDroplet(0.5) === SquareDroplet{Float64}(1//2)
    # This is surprisingly complicated to implement generally!
    @test_broken SquareDroplet(0.5) == SquareDroplet(1//2)
    @test LanczosDroplet{2}(true) != LanczosDroplet{3}(true)
    @test pixfrac(LanczosDroplet{2}(true)) == 1
end
