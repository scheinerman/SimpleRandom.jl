# Simple Random

This is a collection of Julia functions to make
random things. Part of the `SimpleWorld` collection.

## Functions

+ `RandomUnitVector(d)` returns a random `d`-dimensional unit vector.
+ `RandomSubset` creates a random subset with the following variations:
  + `RandomSubset(A)`: create a random subset of `A`
  with each element included with probability 0.5.
  + `RandomSubset(A,k)`: create a random `k`-element
  subset of `A`.
  + `RandomSubset(n)`: create a random subset of `1:n`.
  + `RandomSubset(n,k)`: create a random `k`-element
  subset of `1:n`.
