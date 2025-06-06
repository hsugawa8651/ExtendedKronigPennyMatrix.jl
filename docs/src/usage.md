# Usage

```@setup session1
import Pkg
Pkg.add("PythonPlot")
using PythonPlot
using LaTeXStrings
clf()
```

Here is a sample REPL session to draw a dispersion relationship by using this package.

First, construct `FiniteSquareWell` potential object.

```@repl session1
using ExtendedKronigPennyMatrix
v0=10; 
rho=0.5 # b/a;
pot=FiniteSquareWell(v0, rho)
```

Use `get_function` method to acquire potential function.

```@repl session1
begin
   pf = get_potential(pot)
   a = 1
   xs=-a:a/100:2a
   plot(xs, pf.(xs), "k")
   xlim(0,1)
   xlabel(L"$x / a$")
   ylabel(L"Energy / $E_0$")
   title( L"$\rho =$"*string(rho))
   savefig("plot1.png", dpi=150); nothing # hide
end
```

![plot1](plot1.png)


Define `Model` by calling its constructor.
```@repl session1
Ka=0.0 # wavenumber multiplied by a;
model=Model(pot, Ka)
```

The field `hnm` of model contains Hamiltonian matrix.
```@repl session1
typeof(model.hnm)
size(model.hnm)
model.hnm[1:5,1:5]
```

Use [`LinearAlgebra.eigvals`](https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/#LinearAlgebra.eigvals) method to compute its energy eigenvalues.
Refer to the [`LinearAlgebra`](https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/) standard library section in Julia documentation.
```@repl session1
using LinearAlgebra
evs=eigvals(model.hnm);
evs[1:3]
```

Draw dispersion curve by scanning `Ka` values between ``[-\pi, \pi]``.
```@repl session1
using PythonPlot
using LaTeXStrings
clf()
begin
   a = 1
   xs=-a:a/100:2a
   plot(xs .- 1/2, pf.(xs), "k")  # Holizontally shift to centerize the potential well
   cm=get_cmap("tab10")
   for Ka in (-18:18)/18*π
      model=Model(pot, Ka)
      ev = eigvals(model.hnm)
      for i in 1:5
         plot(Ka/ π, ev[i], ".", color=cm(i-1))
      end
   end
   xlim(-1,1)
   ylim(-2,32)
   xlabel(L"$Ka / \pi$")
   ylabel(L"Energy / $E_0$")
   title( L"$\rho =$"*string(rho))
   savefig("plot2.png", dpi=150); nothing # hide
end
```

![plot2](plot2.png)


