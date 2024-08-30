var documenterSearchIndex = {"docs":
[{"location":"#SimpleRandom","page":"SimpleRandom","title":"SimpleRandom","text":"","category":"section"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"This is a collection of Julia functions to make random things. ","category":"page"},{"location":"#Random-Unit-Vector","page":"SimpleRandom","title":"Random Unit Vector","text":"","category":"section"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"random_unit_vector(d) returns a random d-dimensional unit vector.","category":"page"},{"location":"#Random-Subsets","page":"SimpleRandom","title":"Random Subsets","text":"","category":"section"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"random_subset creates a random subset with the following variations:","category":"page"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"random_subset(A): create a random subset of A  with each element included with probability 0.5.\nrandom_subset(A,k): create a random k-element subset of A.\nrandom_subset(n): create a random subset of 1:n.\nrandom_subset(n,k): create a random k-element","category":"page"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"subset of 1:n.","category":"page"},{"location":"#Random-Selection","page":"SimpleRandom","title":"Random Selection","text":"","category":"section"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"random_choice is used to select a number or object at random according to some (finite, discrete distribution). We provide two variants:","category":"page"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"random_choice(weights) randomly chooses a value from 1 to n, where n is the number of elements in weights. The probability that k is chosen is proportional to weights[k]. The weights must be nonnegative and not all zero.\nrandom_choice(dict) choose a random key k from dict with weight proportional to dict[k]. Thus, dict must be of type Dict{S, T<:Real}.","category":"page"},{"location":"#Notes","page":"SimpleRandom","title":"Notes","text":"","category":"section"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"No error checking is done on the input. An error might be raised for bad input, but that's not guaranteed.\nThe implementation might be improved. If the size of the argument is small, this is efficient enough. But if wts (or d) has many elements, I probably should do some sort of binary search through the vector of cumulative sums.","category":"page"},{"location":"#Histogram","page":"SimpleRandom","title":"Histogram","text":"","category":"section"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"The function histplot(x) creates a PyPlot bar chart giving a histogram of the values in the list x. Called as histplot(x,n) creates such a plot with n bins.","category":"page"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"Note: This function has been moved to a separate file histplot.jl in the src directory. I've been having some issues with PyPlot and this function doesn't really apply to creating random things (but rather to visualizing them).","category":"page"},{"location":"#Distributions","page":"SimpleRandom","title":"Distributions","text":"","category":"section"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"Note: I'm just wrapping stuff found in  Distributions. Probably better just to use that package directly.","category":"page"},{"location":"#Binomial","page":"SimpleRandom","title":"Binomial","text":"","category":"section"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"binom_rv(n,p) generates a random binomial random value. p defaults to 0.5.","category":"page"},{"location":"#Poisson","page":"SimpleRandom","title":"Poisson","text":"","category":"section"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"poisson_rv(lambda) returns a Poisson random value with mean lambda (which defaults to 1.0).","category":"page"},{"location":"#Exponential","page":"SimpleRandom","title":"Exponential","text":"","category":"section"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"exp_rv(theta) returns an exponential random value with mean theta (which defaults to 1.0).","category":"page"},{"location":"#Random-Variable-Type","page":"SimpleRandom","title":"Random Variable Type","text":"","category":"section"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"The RV type represents a random variable with finite support; that is, the set of possible values produced by the random variable is finite. This rules out continuous random variables and discrete random variables with infinite support such as Poisson random variables.","category":"page"},{"location":"#Defining-a-Random-Variable","page":"SimpleRandom","title":"Defining a Random Variable","text":"","category":"section"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"The user needs to specify the value type of the random variable (which needs to be a Number type) and the data type for the probabilities (which needs to be a Real type such as Float64 or Rational{Int}).","category":"page"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"For example, to define a random variable whose values are integers and whose probabilities are rational numbers, we do this:","category":"page"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"julia> using SimpleRandom\n\njulia> X = RV{Int, Rational{Int}}()\nRV{Int64,Rational{Int64}} with 0 values","category":"page"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"Now let's imagine that we want the values of X to be in the set {1,2,3} with probabilities 1/2, 1/4, and 1/4 respectively. We can specify this in two ways.","category":"page"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"First, we can directly enter the probabilities like this:","category":"page"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"julia> X = RV{Int, Rational{Int}}()\nRV{Int64,Rational{Int64}} with 0 values\n\njulia> X[1]=1//2\n1//2\n\njulia> X[2]=1//4\n1//4\n\njulia> X[3]=1//4\n1//4\n\njulia> report(X)\n1   1//2\n2   1//4\n3   1//4","category":"page"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"Alternatively, we can enter values and have them automatically scaled so that they add to 1.","category":"page"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"julia> X = RV{Int, Rational{Int}}()\nRV{Int64,Rational{Int64}} with 0 values\n\njulia> X[1] = 2\n2\n\njulia> X[2] = 1\n1\n\njulia> X[3] = 1\n1\n\njulia> report(X)\n1\t  1//2\n2\t  1//4\n3\t  1//4","category":"page"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"Rescaling happens automatically any time the user/computer wants to access the probability associated with a value. In this case, the report function prints out the probabilities associated with each value so the rescaling took place behind the scenes then it was invoked.","category":"page"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"Continuing this example, if we now enter X[4]=1//2, the probabilities no longer sum to 1, so if we request the probability associated with a value, the rescaling takes place.","category":"page"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"julia> X[4] = 1//2\n1//2\n\njulia> X[4]\n1//3\n\njulia> report(X)\n1\t 1//3\n2\t 1//6\n3\t 1//6\n4\t 1//3","category":"page"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"In summary, X[v]=p assigns probability p to the value v. Retrieving a value invokes a rescaling operation (if needed) before the value is returned. Note that if v is a value that has not been assigned a probability, then 0 is returned.","category":"page"},{"location":"#Functions","page":"SimpleRandom","title":"Functions","text":"","category":"section"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"The following functions are provided:","category":"page"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"E(X) returns the expected value of X.\nVar(X) returns the variance of X.\nlength(X) returns the number of values to which probabilities have been assigned.\nvals(X) returns an iterator to the values associated with X.\nprobs(X) returns an iterator to the probabilities associated with values in X.\nreport(X) prints a table consisting of the values and their associated probabilities.\nrandom_choice(X) returns a random value v of X at random with probability X[v]. This function is not efficient.  Compare these timings for generating an array of ten thousand binomial random values:","category":"page"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"julia> X = Binomial_RV(20,.5)\nRV{Int64,Float64} with 21 values\n\njulia> @time A = [ random_choice(X) for _=1:10_000 ];\n  0.024765 seconds (60.78 k allocations: 10.015 MiB, 83.96% compilation time)\n\njulia> @time B = [ binom_rv(20,.5) for _=1:10_000];\n  0.009486 seconds (27.78 k allocations: 1.928 MiB, 91.27% compilation time)","category":"page"},{"location":"#Operations","page":"SimpleRandom","title":"Operations","text":"","category":"section"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"a*X where a is a number creates a new random variable by multiplying the values in X by a.\nX+Y creates a new random variable that represents the sum of the random variables X and Y considered as independent. Note that 2*X is not the same as X+X.\nX-Y is the difference of independent X and Y.","category":"page"},{"location":"#Pre-made-Random-Variables","page":"SimpleRandom","title":"Pre-made Random Variables","text":"","category":"section"},{"location":"","page":"SimpleRandom","title":"SimpleRandom","text":"Uniform_RV(n) creates a random variable whose values are in 1:n each with probability 1//n.\nBernoulli_RV(p) creates a random variable whose value is 0 with probability 1-p and 1 with probability p.\nBinomial(n,p) creates a random variable whose values are in 0:n with probability given by the binomial distribution. That is, the value k has probability binomial(n,k)*p^k*(1-p)^(n-k).","category":"page"}]
}
