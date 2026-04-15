module Drizzle

include("droplets.jl")
export AbstractDroplet, PointDroplet, SquareDroplet, TurboDroplet, GaussianDroplet, LanczosDroplet
export pixfrac

"""
    drizzle!(transform, grid!, image, droplet::AbstractDroplet)

Drizzles a image onto `grid!` with the given droplet model.
This function may be called with `do` syntax describing the transform function.
"""
function drizzle!(
    transform,
    grid!::AbstractMatrix,
    image,
    kernel::AbstractDroplet
)
    # TODO: implement drizzle lol
    return grid!
end

end
