
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


## Finite Square Well

```@docs
FiniteSquareWell
```

```@docs
get_potential(::FiniteSquareWell)
```

```@docs
ExtendedKronigPennyMatrix.constuctMatrix(::Model{FiniteSquareWell})
```


## Simple Harmonic Oscillator

```@docs
SimpleHarmonicOscillator
```

```@docs
get_potential(::SimpleHarmonicOscillator)
```

```@docs
ExtendedKronigPennyMatrix.constuctMatrix(::Model{SimpleHarmonicOscillator})
```


## Alphabetical Index

```@index
```
