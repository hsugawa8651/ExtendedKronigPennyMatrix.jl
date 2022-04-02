
using ExtendedKronigPennyMatrix
using LinearAlgebra
using PyPlot
pygui(false)

function plot_KP(v0, rho)
   clf()
   cm=get_cmap("tab10")

   pot=FiniteSquareWell(v0, rho)
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
   ylim(-2,32)
   xlabel(L"$Ka / \pi$")
   ylabel(L"Energy / $E_0$")
   title( L"$v_{0} =$"*string(v0)*", "*L"$\rho =$"*string(rho))
end

function main()
   #
   plot_KP(      0, 0.5)
   ylim(-0.5,25)
   savefig("Pavelich_Fig4a.png")
   #
   plot_KP(     10, 0.5)
   ylim(-0.5,30)
   savefig("Pavelich_Fig4b.png")
   savefig("KP_10_05.png")
   #
   plot_KP(     10, 0.8)
   ylim(-0.5,30)
   savefig("KP_10_08.png")
   #
   plot_KP(20.5607, 0.5)
   ylim(-0.5,40)
   savefig("Pavelich_Fig6.png")
   #
   plot_KP(10.8775, 0.8)
   ylim(-0.5,30)
   savefig("Pavelich_Fig7.png")
end

main()
