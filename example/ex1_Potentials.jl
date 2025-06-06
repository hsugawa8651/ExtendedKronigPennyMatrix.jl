
using ExtendedKronigPennyMatrix
using LinearAlgebra
using PythonPlot: pyplot as plt
using LaTeXStrings
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

   fig, axs = plt.subplots(npotentials,1, sharex=true, tight_layout=true)
   # @show axs
   for (ax, desc) in zip(axs, potentials)
      # cntp=cnt-1 # Index for Python array
      pot, ttl = desc
      pf = get_potential(pot)
      a=1
      xs=-2a:a/100:2a
      ax.plot(xs, pf.(xs))
      ax.set_title(ttl, y=-0.5)
      ax.set_xlabel("")
      # axs[cntp].set_xticks([])
      ax.get_xaxis().set_visible(false)
      ax.set_ylabel("")
      # ax.axis("off")
   end
   fig.savefig("Pavelich_Fig5.png")
end

plot_potential()

