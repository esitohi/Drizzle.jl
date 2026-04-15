using Drizzle
using Aqua, Test

Aqua.test_all(Drizzle)

@testset "All tests" begin
    include("droplets.jl")
end
