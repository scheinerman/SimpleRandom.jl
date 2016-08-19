# Simple Random

This is a collection of Julia functions to make
random things. Part of the `SimpleWorld` collection.

## Functions

+ `random_unit_vector(d)` returns a random `d`-dimensional unit vector.
+ `random_subset` creates a random subset with the following variations:
  + `random_subset(A)`: create a random subset of `A`
  with each element included with probability 0.5.
  + `random_subset(A,k)`: create a random `k`-element
  subset of `A`.
  + `random_subset(n)`: create a random subset of `1:n`.
  + `random_subset(n,k)`: create a random `k`-element
  subset of `1:n`.
