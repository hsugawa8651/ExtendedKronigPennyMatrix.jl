
using ExtendedKronigPennyMatrix
using LinearAlgebra
using PythonPlot
using LaTeXStrings
pygui(false)

function plot_SHO(v0)
   clf()
   cm=get_cmap("tab10")

   pot=SimpleHarmonicOscillator(v0)
   pf = get_potential(pot)
   a=1
   xs=-2a:a/100:3a
   plot(xs, pf.(xs), "k")

   for Ka in (-18:18)/18*π
      model=Model(pot, Ka)
      ev = eigvals(model.hnm)
      for i in 1:5
         plot(Ka/ π, ev[i], ".", color=cm(i-1))
      end
   end
   xlim(-1,1)
   ylim(0,30)
   xlabel(L"$Ka / \pi$")
   ylabel(L"Energy / $E_0$")
   title( L"$v0 =$"*string(v0))
end

function main()
   #
   plot_SHO( 4.84105)
   savefig("Pavelich_Fig8.png")
end

main()
