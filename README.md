# [Drizzle.jl][repo-url]

[![Stable][docs-stable-img]][docs-stable-url]
[![Dev][docs-dev-img]][docs-dev-url]
[![Build Status][ci-status-img]][ci-status-url]
[![Aqua.jl][aqua-img]][aqua-url]

Drizzle.jl is a Julia implementation of the [drizzle algorithm (also known as variable-pixel linear reconstruction)][drizzle-paper].
Drizzle can be used as an alternative to interpolation-based image registration and stacking.

This package only covers the registration aspect of drizzling.
For stacking registered frames, consider using [ImageStacking.jl].

[repo-url]:         https://github.com/esitohi/Drizzle.jl
[docs-stable-img]:  https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]:  https://esitohi.github.io/Drizzle.jl/stable
[docs-dev-img]:     https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]:     https://esitohi.github.io/Drizzle.jl/dev
[ci-status-img]:    https://github.com/esitohi/Drizzle.jl/workflows/CI/badge.svg
[ci-status-url]:    https://github.com/esitohi/Drizzle.jl/actions
[aqua-img]:         https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg
[aqua-url]:         https://github.com/JuliaTesting/Aqua.jl
[codecov-img]:      https://codecov.io/gh/brainandforce/Drizzle.jl/branch/main/graph/badge.svg
[codecov-url]:      https://codecov.io/gh/brainandforce/Drizzle.jl/
[drizzle-paper]:    https://arxiv.org/abs/astro-ph/9808087
[ImageStacking.jl]: https://github.com/esitohi/ImageStacking.jl
