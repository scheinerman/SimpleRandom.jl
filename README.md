# Simple Random

This is a collection of Julia functions to make
random things. Part of the `SimpleWorld` collection.



## Random unit vector

`random_unit_vector(d)` returns a random `d`-dimensional unit vector.

## Random subsets

`random_subset` creates a random subset with the following variations:
+ `random_subset(A)`: create a random subset of `A`  with each element
included with probability 0.5.
+ `random_subset(A,k)`: create a random `k`-element
subset of `A`.
+ `random_subset(n)`: create a random subset of `1:n`.
+ `random_subset(n,k)`: create a random `k`-element
subset of `1:n`.

## Random selection

`random_choice` is used to select a number or object at random
according to some (finite, discrete distribution). We provide two
variants:

+ `random_choice(weights)` randomly chooses a value from `1` to `n`,
where `n` is the number of elements in `weights`. The probability
that `k` is chosen is proportional to `weights[k]`. The `weights`
must be nonnegative and not all zero.
+ `random_choice(dict)` choose a random key `k` from `dict` with weight
proportional to `dict[k]`. Thus, `dict` must be of type
`Dict{S, T<:Real}`.


#### Notes

+ No error checking is done on the input. An error
might be raised for bad input, but that's not
guaranteed.
+ The implementation might be improved. If the size
of the argument is small, this is efficient enough.
But if `wts` (or `d`) has many elements, I probably
should do some sort of binary search through the vector
of cummulative sums.


## Distributions

### Binomial

`binom_rv(n,p)` generates a random binomial random value. `p` defaults
to `0.5`.

**Note**: This is simply a wrapper around `StatsFuns.RFunctions.binomrand`
but converts the output to an `Int`.

### Poisson

`poisson_rv(lambda)` returns a Poisson random value with mean `lambda`
(which defaults to `1.0`).


#### To do list (for distributions)

+ Poisson
+ Exponential
