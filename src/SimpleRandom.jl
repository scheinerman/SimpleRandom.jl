# module SimpleRandom

"""
`RandomUnitVector(d)` returns a random `d`-dimensional unit vector.
"""
function RandomUnitVector(d::Int)
  v = randn(d)
  return v / norm(v)
end

"""
`RandomSubset` is used to create random subsets as follows:

+ `RandomSubset(A)`: random subset of `A` with each element
chosen with probability 1/2.
+ `RandomSubset(A,k)`: random `k`-element subset of `A`.
+ `RandomSubset(n)`: random subset of `1:n`.
+ `RandomSubset(n,k)`: random `k`-element subset of `1:n`.
"""
function RandomSubset(A::Union{Set,IntSet})
  T = typeof(A)
  B = T()
  for a in A
    if rand() < 0.5
      push!(B,a)
    end
  end
  return B
end

function RandomSubset(n::Int)
  A = Set(1:n)
  return RandomSubset(A)
end

# end
