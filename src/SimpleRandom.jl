# module SimpleRandom

"""
`RandomUnitVector(d)` returns a random `d`-dimensional unit vector.
"""
function RandomUnitVector(d::Int)
  v = randn(d)
  return v / norm(v)
end

# end
