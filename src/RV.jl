import Base: getindex, setindex!, (+), keys, values, (*)

export RV, RV_types, check, rescale!, E, Var
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
`check(X)` makes sure the probabilities are nonnegative
and sum to 1.
"""
function check{S,T}(X::RV{S,T})
  if X.valid
    return true
  end
  for v in values(X.data)
    if v<0
      return false
    end
  end
  u::T = sum(values(X.data))
  X.valid = (u == one(T))
  return X.valid
end

keys(RV) = keys(RV.data)
values(RV) = values(RV.data)

"""
`rescale!(X)`:
Make sure probabilities sum to one.
"""
function rescale!{S,T}(X::RV{S,T})
  u = sum(values(X.data))
  for x in keys(X.data)
    X.data[x]/= u
  end
  X.valid = true
  nothing
end

"""
`E(X)` is the expected value of `X`.
"""
function E{S,T}(X::RV{S,T})
  return  sum( k*X.data[k] for k in keys(X.data))
end

"""
`Var(Y)` is the variance of `Y`.
"""
function Var{S,T}(X::RV{S,T})
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


function getindex{S,T}(X::RV{S,T}, k::S)
  if !X.valid
    rescale!(X)
  end
  try
    return X.data[k]
  end
  return zero(T)
end

function setindex!{S,T}(X::RV{S,T}, p::T, k::S)
  @assert p>=0 "Probability must be nonnegative"
  X.data[k] = p
  return p
end

"""
`X+Y` sum of independent random variables.
"""
function (+)(X::RV, Y::RV)
  S = typeof( first(keys(X)) + first(keys(Y)) )
  T = typeof( first(values(X)) + first(values(Y)) )

  Z = RV{S,T}()
  for a in keys(X.data)
    for b in keys(Y.data)
      Z[a+b] += X[a]*Y[b]
    end
  end
  return Z
end

"""
`a*X` scalar multiple of the random variable `X`
"""
function (*)(a, X::RV)
  S = typeof( first(keys(X)) * a)
  T = typeof( first(values(X)) )
  aX = RV{typeof(a),T}()
  for k in keys(X)
    aX[a*k] = X[k]
  end
  return aX
end
