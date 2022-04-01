# KronigPenny

"""
    struct FiniteSquareWell(v0, ρ) # Default constructor

holds parameters of finite square well potential.

Fields
* `v0` : potential height in units of ``E_{1}^{(0)}``
* `ρ` : barrier width in units of period ``a``,  where ``0 < \\rho = \\dfrac{b}{a} < 1``
  * Note that a position ``x`` is expressed in units of ``a`` throughout this package.

The constructor `FiniteSquareWell(v0, ρ)` confirms that `0 ≤ ρ ≤ 1`, otherwise throws an error.
"""
struct FiniteSquareWell <: Potential
   v0:: Real
   ρ:: Real # ρ = b/a

   FiniteSquareWell(v0, ρ) = 0 ≤ ρ ≤ 1 ? new(v0,ρ) : error("ρ < 0 or 1 < ρ")
end

"""
    get_potential(::FiniteSquareWell)

returns a function ``v`` to evaluate potential ``v(x)`` as a position ``x``, 
such that:
```math
\\begin{aligned}
v(x) & = \\begin{cases} 
v_{0} &
\\text{inside well, i.e.,} 
 \\dfrac{1-\\rho}{2} \\le \\dfrac{x}{a} \\le \\dfrac{1+\\rho}{2}, 
 \\\\ 
0 & \\text{outside well}\\end{cases}
\\\\
v(x+a) &= v(x)
\\end{aligned}
```
* Note that a position ``x`` is expressed in units of ``a`` throughout this package.
"""
function get_potential(pot::FiniteSquareWell)
   return x -> (1-pot.ρ)/2 <= mod(x,1)< (1+pot.ρ)/2 ? 0 : pot.v0
end



"""
    constuctMatrix(model::Model{FiniteSquareWell})

computes and fills Hamiltonian matrix fields `hnm` in `model` with finite square well.

```math
h_{nm} = \\begin{cases} 
\\left(2n + \\dfrac{Ka}{\\pi}\\right)^{2} + v_{0} (1-\\rho) &
\\text{for}\\; n = m\\;\\text{(diagonal elements)} \\\\
v_{0}
\\dfrac{(-1)^{m-n+1}}{\\pi} \\dfrac{\\sin \\pi(m-n)\\rho}{m-n} 
 & 
 \\text{for}\\; n \\neq m\\;\\text{(off-diagonal elements)}\\end{cases}
```
"""
function constuctMatrix(model::Model{FiniteSquareWell})
   qnum=model.qnum
   hnm=model.hnm
   Ka=model.Ka
   potential=model.potential
   v0=potential.v0
   ρ=potential.ρ
   
   for (i,m) in enumerate(qnum)
      for (j,n) in Iterators.take(enumerate(qnum), i-1)
         hnm[i,j] = 0
      end
   end

   for (i,m) in enumerate(qnum)
      hnm[i,i] = (2m+Ka/π)^2 + v0*(1-ρ)
   end

   for (i,m) in enumerate(qnum)
      for (j,n) in Iterators.take(enumerate(qnum), i-1)
         hnm[i,j] = v0*(-1)^(m-n+1)/π * sinpi((m-n)ρ)/(m-n)
      end
      for (j,n) in Iterators.drop(enumerate(qnum), i)
         hnm[i,j] = v0*(-1)^(m-n+1)/π * sinpi((m-n)ρ)/(m-n)
      end
   end
end