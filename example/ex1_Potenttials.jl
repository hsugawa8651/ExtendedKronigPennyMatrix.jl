
using ExtendedKronigPennyMatrix
using LinearAlgebra
using PyPlot
pygui(false)

function plot_potential()
   clf()
   cm=get_cmap("tab10")

   potentials = [
      [ FiniteSquareWell(1.0, 0.5), "Kronig-Penny ρ=0.5" ],
      [ FiniteSquareWell(1.0, 0.8), "Kronig-Penny ρ=0.8" ],
      [ SimpleHarmonicOscillator(1.0), "Simple Harmonic Oscillator" ], 
      [ InvertedHarmonicOscillator(1.0), "Inverted Harmonic Oscillator" ],
      [ LinearWell(1.0), "LinearWell" ]
   ]
   npotentials=length(potentials)

   fig, axs = subplots(npotentials,1, sharex=true, tight_layout=true)
   @show axs
   for (cnt, desc) in enumerate(potentials)
      pot, ttl = desc
      pf = get_potential(pot)
      a=1
      xs=-2a:a/100:2a
      axs[cnt].plot(xs, pf.(xs))
      axs[cnt].set_title(ttl, y=-0.5)
      axs[cnt].set_xlabel("")
      axs[cnt].set_xticks([])
      axs[cnt].set_ylabel("")
      # axs[cnt].axis("off")
   end
   fig.savefig("Pavelich_Fig5.png")
end

plot_potential()

