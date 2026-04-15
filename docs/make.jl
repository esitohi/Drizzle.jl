#! /usr/bin/env julia

using Drizzle
using Documenter

using_directives = :(using Drizzle)
DocMeta.setdocmeta!(Drizzle, :DocTestSetup, using_directives; recursive=true)

is_ci_env = (get(ENV, "CI", nothing) == true)
@info "is_ci_env == $is_ci_env"

makedocs(;
    sitename="Drizzle.jl",
    modules=[Drizzle],
    doctest=false,
    checkdocs = :exports,
    format=Documenter.HTML(;
        prettyurls = is_ci_env,
        canonical = "https://esitohi.github.io/Drizzle.jl",
        edit_link = "main",
        assets = String[],
    ),
    pages=[
        "Home" => "index.md"
        #= TODO: create more pages
        "API" => Any[
            "Stacking" => "api/stacking.md"
        ]
        =#
    ],
)

deploydocs(;
    repo="github.com/esitohi/Drizzle.jl.git",
    devbranch="main",
)
