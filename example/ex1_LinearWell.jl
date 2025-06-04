
using ExtendedKronigPennyMatrix
using LinearAlgebra
using PyPlot
using LaTeXStrings
pygui(false)

function plot_IHO(A)
   clf()
   cm=get_cmap("tab10")

   pot= LinearWell(A)
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
   ylim(0,40)
   xlabel(L"$Ka / \pi$")
   ylabel(L"Energy / $E_0$")
   title( L"$A =$"*string(A))
end

function main()
   #
   plot_IHO(19.8705)
   savefig("Pavelich_Fig10.png")
end

main()
