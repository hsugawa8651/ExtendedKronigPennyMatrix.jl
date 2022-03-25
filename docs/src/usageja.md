# 使い方

このパッケージを利用して、分散関係を描画する手順を紹介します。
JuliaのREPLを用いた例です。

最初に、`FiniteSquareWell` ポテンシャルを作成します。

```@repl session1
using ExtendedKronigPennyMatrix
v0=10; 
rho=0.5 # b/a;
pot=FiniteSquareWell(v0, rho)
```

ポテンシャル形状は `get_function`関数で得られます。

ここでは `PyPlot` パッケージを用いて、プロットします。

```@repl session1
using PyPlot
clf()
begin
   pf = get_potential(pot)
   a = 1
   xs=-a:a/100:2a
   plot(xs, pf.(xs), "k")
   xlim(0,1)
   xlabel(L"$x / a$")
   ylabel(L"Energy / $E_0$")
   title( L"$\rho =$"*string(rho))
   # savefig("plot1.png", dpi=150); nothing # hide
end
```

![](plot1.png)


次に、`Model` オブジェクトを作成します。

```@repl session1
Ka=0.0 # wavenumber multiplied by a;
model=Model(pot, Ka)
```

このオブジェクトの `hnm` フィールドに、ハミルトニアン行列が計算されました。

```@repl session1
typeof(model.hnm)
size(model.hnm)
model.hnm[1:5,1:5]
```

Juliaの [`LinearAlgebra.eigvals`](https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/#LinearAlgebra.eigvals) メソッドを用いて、エネルギー固有値を計算します。
詳しくは、Juliaドキュメントの [`LinearAlgebra`](https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/)
標準ライブラリを参照してください。

```@repl session1
using LinearAlgebra
evs=eigvals(model.hnm);
evs[1:3]
```

波数（と周期`a`の積）`Ka` を ``[-\pi, \pi]`` の範囲で走査して、分散関係を描きます。

```@repl session1
using PyPlot
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

![](plot2.png)


