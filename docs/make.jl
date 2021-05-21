using ExtendedKronigPennyMatrix
using Documenter

DocMeta.setdocmeta!(ExtendedKronigPennyMatrix, :DocTestSetup, :(using ExtendedKronigPennyMatrix); recursive=true)

makedocs(;
    modules=[ExtendedKronigPennyMatrix],
    authors="Hiroharu Sugawara <hsugawa@gmail.com>",
    repo="https://github.com/hsugawa8651/ExtendedKronigPennyMatrix.jl/blob/{commit}{path}#{line}",
    sitename="ExtendedKronigPennyMatrix.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://hsugawa8651.github.io/ExtendedKronigPennyMatrix.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Manual" => [
            "Usage" => "usage.md",
            "使い方" => "usageja.md"
        ],
        "Reference" => "reference.md",
    ],
)

deploydocs(;
    repo="github.com/hsugawa8651/ExtendedKronigPennyMatrix.jl",
)
