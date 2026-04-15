"""
    _pixfrac_check(pixfrac)

Checks that the pixel fraction is not negative.
"""
function _pixfrac_check(pixfrac)
    pixfrac >= 0 || throw(ArgumentError("pixel fraction must be positive (got $pixfrac)."))
    return pixfrac
end

"""
    AbstractDroplet{T}

Supertype for all droplets (drizzle kernels).

All droplets should define `Drizzle.pixfrac(::K)`, which describes the linear scale of the droplet
relative to that of the pixels in the input image (i.e. pixel fraction).
`pixfrac(::AbstractDroplet)` defaults to `k.pixfrac`.
"""
abstract type AbstractDroplet{T}
end

"""
    pixfrac(k::AbstractDroplet)

Gets the linear scale factor (pixel fraction) for the given droplet.

Note that `pixfrac` is not necessarily comparable across different types of droplets.
For droplets with a finite support (like [`SquareDroplet`](@ref)), `pixfrac` is the linear scaling
factor relative to the support's bounding box.
Droplets without finite support (like [`GaussianDroplet`](@ref)) should have their `pixfrac`
convention documented.
"""
pixfrac(k::AbstractDroplet) = k.pixfrac

"""
    is_flux_preserving(::Type{<:AbstractDroplet})
    is_flux_preserving(::AbstractDroplet)

Returns `true` if the kernel is flux-preserving, false otherwise.
For new `AbstractDroplet` subtypes, this defaults to false.
"""
is_flux_preserving(::Type{<:AbstractDroplet}) = false
is_flux_preserving(::T) where T<:AbstractDroplet = is_flux_preserving(T)

#---Droplet implementations------------------------------------------------------------------------#
"""
    PointDroplet <: AbstractDroplet{Bool}

The simplest droplet: an infinitely small point.
This is equivalent to any other droplet `k` with `pixfrac(k) == 0`.

In practice, this droplet requires large numbers of dither positions to avoid leaving gaps in the
image, but it is fast.
"""
struct PointDroplet <: AbstractDroplet{Bool}
end

pixfrac(::PointDroplet) = false

Base.:(==)(::PointDroplet, ::PointDroplet) = true
Base.:(==)(::PointDroplet, k::AbstractDroplet) = iszero(pixfrac(k))
Base.:(==)(k::AbstractDroplet, ::PointDroplet) = iszero(pixfrac(k))

"""
    SquareDroplet{T<:Real} <: AbstractDroplet{T}

A droplet which maps the input pixels to centered squares with the same orientation as the input.
This droplet is flux-preserving and suitable for stellar photometric applications, but may not
preserve PSFs as well as [`GaussianDroplet`](@ref).

For faster processing, consider using [`TurboDroplet`](@ref) instead, or [`PointDroplet`](@ref) if
there are a large number of dither positions and `pixfrac` is very small.
"""
struct SquareDroplet{T<:Real} <: AbstractDroplet{T}
    pixfrac::T
    SquareDroplet{T}(pixfrac) where T = new(_pixfrac_check(pixfrac))
end

SquareDroplet(pixfrac::T) where T = SquareDroplet{T}(pixfrac)

is_flux_preserving(::Type{<:SquareDroplet}) = true

"""
    TurboDroplet{T<:Real} <: AbstractDroplet{T}

A simplified implementation of [`SquareDroplet`](@ref).
This droplet assumes that the rotation of the input image is negligible compared to the output grid,
which can speed up processing for large datasets.
"""
struct TurboDroplet{T<:Real} <: AbstractDroplet{T}
    pixfrac::T
    TurboDroplet{T}(pixfrac) where T = new(_pixfrac_check(pixfrac))
end

TurboDroplet(pixfrac::T) where T = TurboDroplet{T}(pixfrac)

"""
    GaussianDroplet{T<:Real} <: AbstractDroplet{T}

A droplet based on a Gaussian function with `pixfrac` equal to the ratio of the full-width half
maximum (FWHM) to the pixel length scale.

Although this droplet is not flux-preserving like [`SquareDroplet`](@ref), it tends to preserve 
point spread functions better and may yield a smoother result, which may be more appealing for an
astrophotographer, or even point source photometry.
"""
struct GaussianDroplet{T<:Real} <: AbstractDroplet{T}
    pixfrac::T
    GaussianDroplet{T}(pixfrac) where T = new(_pixfrac_check(pixfrac))
end

GaussianDroplet(pixfrac::T) where T = GaussianDroplet{T}(pixfrac)

"""
    LanczosDroplet{A,T<:Real} <: AbstractDroplet{T}

A droplet based on the Lanczos window function.

!!! note This droplet is only designed for resampling images without rescaling them (i.e. rotating
    and reflecting). `pixfrac` should usually be 1.
"""
struct LanczosDroplet{A,T<:Real} <: AbstractDroplet{T}
    pixfrac::T
    function LanczosDroplet{A,T}(pixfrac) where {A,T}
        A isa Integer || throw(DomainError(A, "type parameter A must be an Integer"))
        A > 0 || throw(
            DomainError(A, LazyString("type parameter A must be positive (got ", A, ')'))
        )
        return new(_pixfrac_check(pixfrac))
    end
end

LanczosDroplet{A}(pixfrac::T) where {A,T} = LanczosDroplet{A,T}(pixfrac)
