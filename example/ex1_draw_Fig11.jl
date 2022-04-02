
using ExtendedKronigPennyMatrix
using LinearAlgebra
using PyPlot
pygui(false)

function plot_potential()
   clf()
   cm=get_cmap("tab10")

   potentials = [
      [ FiniteSquareWell(20.5607, 0.5), "Kronig-Penny ρ=0.5" ],
      [ InvertedHarmonicOscillator(7.30845), "Inverted HO" ],
      [ FiniteSquareWell(10.8775, 0.8), "Kronig-Penny ρ=0.8" ],
      [ LinearWell(19.8705), "LinearWell" ],
      [ SimpleHarmonicOscillator(4.84105), "Simple HO" ],
   ]
   npotentials=length(potentials)

   for (cnt, desc) in enumerate(potentials)
      pot, ttl = desc
      pf = get_potential(pot)
      a=1
      Ka= -pi
      model=Model(pot, Ka)
      ev = eigvals(model.hnm)
      ev30=ev[3]
      @show ev30
      for (j,Ka) in enumerate((-36:36)/36*π)
         model=Model(pot, Ka)
         ev = eigvals(model.hnm)
         if j==1
            plot(Ka/ π, ev[3] - ev30, ".", color=cm(cnt-1), label=ttl)
         else
            plot(Ka/ π, ev[3] - ev30, ".", color=cm(cnt-1))
         end
      end   
   end
   legend(loc=3)
   xlim(-1,1)
   ylim(-3,0.2)
   xlabel(L"$Ka / \pi$")
   ylabel(L"Energy / $E_0$")
   savefig("Pavelich_Fig11.png")
end

plot_potential()

