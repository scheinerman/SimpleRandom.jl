module SimpleRandom

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

RandomSubset(n::Int) = RandomSubset(Set(1:n))

function RandomSubset(A::Union{Set,IntSet}, k::Int)
  n = length(A)
  if k<0 || k>n
    error("k = $k is out of range")
  end
  T = typeof(A)
  B = T()
  elements = collect(A)
  p = randperm(n)
  for j=1:k
    push!(B,elements[p[j]])
  end
  return B
end

function RandomSubset(n::Int, k::Int)
  if n<0 || k<0 || k>n
    error("n = $n and/or k = $k invalid")
  end
  x = randperm(n)
  y = x[1:k]
  return Set(y)
end


end  # end of module
