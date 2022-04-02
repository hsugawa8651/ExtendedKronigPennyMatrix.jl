# Simple Harmonic Oscillator

"""
    struct SimpleHarmonicOscillator(v0)

holds parameters of finite square well potential.

Fields
* `v0` ``= \\hbar\\omega`` in units of ``E_{1}^{(0)}``
"""
struct SimpleHarmonicOscillator <: Potential
   v0:: Real
end

"""
    get_potential(::SimpleHarmonicOscillator)

returns a function ``v`` to evaluate potential ``v(x)`` as a position ``x``, 
such that:
```math
\\begin{aligned}
v(x) & = \\dfrac{1}{2}m {\\omega}^{2} a^{2} \\left(\\dfrac{x}{a}-\\dfrac{1}{2}\\right)^2
= \\dfrac{\\pi^2}{4} v_{0}^2 E_{1}^{(0)} \\left(\\dfrac{x}{a}-\\dfrac{1}{2}\\right)^2, 
\\quad 0 \\le \\dfrac{x}{a} \\le 1
\\\\
v(x+a) &= v(x)
\\end{aligned}
```
* Note that a position ``x`` is expressed in units of ``a`` throughout this package.
"""
function get_potential(pot::SimpleHarmonicOscillator)
   return x -> pot.v0^2 * pi^2 / 4.0 * (mod(x,1.0)-1/2)^2
end



"""
    constuctMatrix(model::Model{SimpleHarmonicOscillator})

computes and fills Hamiltonian matrix fields `hnm` in `model` with finite square well.

```math
h_{nm} = \\begin{cases} 
\\left(2n + \\dfrac{Ka}{\\pi}\\right)^{2} + v_{0}^{2} \\dfrac{\\pi^2}{48}  &
\\text{for}\\; n = m\\;\\text{(diagonal elements)} \\\\
\\dfrac{v_{0}^2}{8}
\\dfrac{(-1)^{m-n}}{(m-n)^{2}} 
 & 
 \\text{for}\\; n \\neq m\\;\\text{(off-diagonal elements)}\\end{cases}
```
"""
function constuctMatrix(model::Model{SimpleHarmonicOscillator})
   qnum=model.qnum
   hnm=model.hnm
   Ka=model.Ka
   potential=model.potential
   v0=potential.v0
   
   for (i,m) in enumerate(qnum)
      for (j,n) in Iterators.take(enumerate(qnum), i-1)
         hnm[i,j] = 0
      end
   end

   for (i,m) in enumerate(qnum)
      hnm[i,i] = (2m+Ka/π)^2 + v0^2 * pi^2 / 48
   end

   for (i,m) in enumerate(qnum)
      for (j,n) in Iterators.take(enumerate(qnum), i-1)
         hnm[i,j] = v0^2/8 * (-1)^(m-n) / (m-n)^2
      end
      for (j,n) in Iterators.drop(enumerate(qnum), i)
         hnm[i,j] = v0^2/8 * (-1)^(m-n) / (m-n)^2
      end
   end
end