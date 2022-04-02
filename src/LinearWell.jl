# LinearWell

"""
    struct LinearWell(A)

holds parameters of finite square well potential.

Fields
* `A` ``= \\hbar\\omega`` in units of ``E_{1}^{(0)}``
"""
struct LinearWell <: Potential
   A:: Real
end

"""
    get_potential(::LinearWell)

returns a function ``v`` to evaluate potential ``v(x)`` as a position ``x``, 
such that:
```math
\\begin{aligned}
v(x) & = \\begin{cases}
2A \\left( \\dfrac{1}{2} - \\dfrac{x}{a} \\right) & 
0 \\le \\dfrac{x}{a} \\le \\dfrac{1}{2} \\\\
2A \\left( \\dfrac{x}{a} - \\dfrac{1}{2} \\right) & 
\\dfrac{1}{2} \\le \\dfrac{x}{a} \\le 1
\\end{cases}
\\\\
v(x+a) &= v(x)
\\end{aligned}
```
* Note that a position ``x`` is expressed in units of ``a`` throughout this package.
"""
function get_potential(pot::LinearWell)
   return x -> (x1 = mod(x,1.0);
      x1 < 1/2 ? 
         2 * pot.A * (1/2 - x1)  :
         2 * pot.A * (x1 - 1/2) )
end



"""
    constuctMatrix(model::Model{LinearWell})

computes and fills Hamiltonian matrix fields `hnm` in `model` with finite square well.

```math
h_{nm} = \\begin{cases} 
\\left(2n + \\dfrac{Ka}{\\pi}\\right)^{2} + \\dfrac{A}{2}  &
\\text{for}\\; n = m\\;\\text{(diagonal elements)} \\\\
\\dfrac{-A}{\\pi^2 (m-n)^{2}}  \\left[ 1-(-1)^{m-n}\\right]
 & 
 \\text{for}\\; n \\neq m\\;\\text{(off-diagonal elements)}\\end{cases}
```
"""
function constuctMatrix(model::Model{LinearWell})
   qnum=model.qnum
   hnm=model.hnm
   Ka=model.Ka
   potential=model.potential
   A=potential.A
   
   for (i,m) in enumerate(qnum)
      for (j,n) in Iterators.take(enumerate(qnum), i-1)
         hnm[i,j] = 0
      end
   end

   for (i,m) in enumerate(qnum)
      hnm[i,i] = (2m+Ka/π)^2 + A / 2
   end

   for (i,m) in enumerate(qnum)
      for (j,n) in Iterators.take(enumerate(qnum), i-1)
         hnm[i,j] = -A / pi^2 / (m-n)^2 * ( 1 - (-1)^(m-n))
      end
      for (j,n) in Iterators.drop(enumerate(qnum), i)
         hnm[i,j] = -A / pi^2 / (m-n)^2 * ( 1 - (-1)^(m-n))
      end
   end
end
