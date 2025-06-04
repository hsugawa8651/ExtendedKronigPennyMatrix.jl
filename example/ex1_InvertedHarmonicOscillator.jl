
using ExtendedKronigPennyMatrix
using LinearAlgebra
using PyPlot
using LaTeXStrings
pygui(false)

function plot_IHO(v0)
   clf()
   cm=get_cmap("tab10")

   pot=InvertedHarmonicOscillator(v0)
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
   ylim(0,50)
   xlabel(L"$Ka / \pi$")
   ylabel(L"Energy / $E_0$")
   title( L"$v0 =$"*string(v0))
end

function main()
   #
   plot_IHO( 7.30815)
   savefig("Pavelich_Fig9.png")
end

main()
