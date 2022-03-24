
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

```@docs
ExtendedKronigPennyMatrix.Model(pot::ExtendedKronigPennyMatrix.Potential,Ka::Float64,nmax::Int64=60)
```


## Kronig-Penny model

```@docs
KronigPennyPotential
```

```@docs
get_potential(::KronigPennyPotential)
```

```@docs
ExtendedKronigPennyMatrix.constuctMatrix(::Model{KronigPennyPotential})
```


## Alphabetical Index

```@index
```
