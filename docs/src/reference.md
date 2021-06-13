
## Interface

### Alternates - iterator for quantum numbers

```@docs
Alternates
```

```@docs
Base.iterate(::Alternates, state::Int = 1)
```

### E10 - the ground state energy
```@docs
ExtendedKronigPennyMatrix.get_E10
```


### Potential
```@docs
ExtendedKronigPennyMatrix.Potential
```

### Model
```@docs
ExtendedKronigPennyMatrix.Model
```


## Kronig-Penny model

```@docs
KronigPennyPotential
```

```@docs
get_potential(::KronigPennyPotential)
```

```@docs
KronigPennyModel
```

```@docs
KronigPennyModel(::KronigPennyPotential, nmax, Ka)
```

```@docs
update!(::KronigPennyModel; Ka=nothing)
```

```@docs
ExtendedKronigPennyMatrix.constuctMatrix(::KronigPennyModel)
```

## Alphabetical Index

```@index
```
