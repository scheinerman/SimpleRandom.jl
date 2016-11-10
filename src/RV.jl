import Base: getindex, setindex!, (+), (*), length, show

export RV, RV_types, E, Var, validate!
export vals, probs
export Uniform_RV, Binomial_RV, Bernoulli_RV


"""
`RV` represents a discrete random variable with finite support.
"""
type RV{S<:Number, T<:Real}
  data::Dict{S,T}
  valid::Bool
  function RV()
    d = Dict{S,T}()
    new(d,false)
  end
end

RV_types{S,T}(X::RV{S,T}) = (S,T)

"""
`length(X::RV)` returns the number of values in the random variable `X`.
"""
length(X::RV) = length(X.data)

function show(io::IO, X::RV)
  S,T = RV_types(X)
  print(io, "RV{$S,$T} with $(length(X.data)) values")
end

"""
`vals(X::RV)` returns an iterator of the values this random variable
can take. Use `X[v]` to get the associate probability of the
value `v`.
"""
vals(X::RV) = keys(X.data)

"""
`probs(X::RV)` returns an iterator of the probabilities associated with
the values in `X`.
"""
function probs(X::RV)
  validate!(X)
  return values(X.data)
end

"""
`validate!(X)` ensures that the probabilies of the values in `X`
sum to one. If not, they are rescaled.
"""
function validate!(X::RV)
  if !X.valid
    u = sum(values(X.data))
    for x in keys(X.data)
      X.data[x]/= u
    end
    X.valid = true
  end
  nothing
end



"""
`E(X)` is the expected value of `X`.
"""
function E{S,T}(X::RV{S,T})
  validate!(X)
  return  sum( k*X.data[k] for k in keys(X.data))
end

"""
`Var(Y)` is the variance of `Y`.
"""
function Var{S,T}(X::RV{S,T})
  validate!(X)
  exex = E(X)^2
  exx  = sum( k*k*X.data[k] for k in keys(X.data))
  return exx - exex
end

"""
`Bernoulli(p)` makes a single coin flip RV.
"""
function Bernoulli_RV{T}(p::T)
  @assert 0<=p && p<=1 "p must be in [0,1]"
  X = RV{Int,T}()
  X[1] = p
  X[0] = 1-p
  X.valid = true
  return X
end

"""
`Binomial_RV(n,p)` returns a binomial random variable.
"""
function Binomial_RV{S<:Integer,T}(n::S, p::T)
  @assert n>=0 "n must be nonnegative"
  @assert 0<=p && p<=1 "probability must be in [0,1]"
  X = RV{S,T}()
  for k=0:n
    X[k] = binomial(n,k)*(p^k)*(1-p)^(n-k)
  end
  return X
end

"""
`Uniform_RV(n)` returns the uniform distribution on `{1,2,...,n}`.
"""
function Uniform_RV(n::Int)
  X = RV{Int,Rational{Int}}()
  for k=1:n
    X[k] = 1//n
  end
  return X
end

"""
`X[v]` returns the probability of `v` in the random variable `X`.
Note that we validate `X` (with `validate!`) before retrieving
the value.
"""
function getindex{S,T}(X::RV{S,T}, k::S)
  validate!(X)
  try
    return X.data[k]
  end
  return zero(T)
end

function setindex!{S,T}(X::RV{S,T}, p::Real, k::S)
  @assert p>=0 "Probability must be nonnegative"
  X.data[k] = T(p)
  X.valid = false
  return p
end

"""
`X+Y` sum of independent random variables.
"""
function (+)(X::RV, Y::RV)
  S = typeof( first(vals(X)) + first(vals(Y)) )
  T = typeof( first(probs(X)) + first(probs(Y)) )

  Z = RV{S,T}()
  for a in keys(X.data)
    for b in keys(Y.data)
      Z[a+b] += X[a]*Y[b]
    end
  end
  return Z
end

"""
`a*X` creates a scalar multiple of the random variable `X`.
"""
function (*)(a, X::RV)
  S = typeof( first(vals(X)) * a)
  T = typeof( first(probs(X)) )
  aX = RV{typeof(a),T}()
  for k in vals(X)
    aX[a*k] = X[k]
  end
  return aX
end
