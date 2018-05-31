# Part 1: loading and visualizing
# use a package that reads 5000 training examples of handwritten digits (subset
# of MNIST: http://yann.lecun.com/exdb/mnist/) with X and y

m = size(X, 1)

# 100 random data points
rand_indices = randperm(m)
sel = X[rand_indices[1:100], :]
display(sel)

# Part 2a: vectorized and regularized logit for one-vs-all classification of dataset

# Sigmoid function
function sigmoid(z)
    1.0 ./ (1.0 .+ exp.(-z))
end

sigmoid(0) # => 0.5
z = rand(3,1); sigmoid(z) # vector
z = rand(3,3); sigmoid(z) # matrix

# Hypothesis: linearly combines X[i] and θ[i], to calculate all instances of cost()
function h(θ, X)
    z = 0
    for i in 1:length(θ)
        z += θ[i] .* X[i, :]
    end
    sigmoid(z)
end

h([-24, 0.2, 0.2], X)

# Vectorized cost function
function cost(θ, X, y)
    hx = sigmoid(X * θ)
    m = length(y)
    global J = (-y' * log.(hx) - (1 - y') * log.(1 - hx)) / m
    global grad = X' * (hx - y) / m
    println("Cost is $J")
    println("Gradient is $grad")
end

# test cost function
theta_t = [-2, -1, 1, 2]
X_t = [ones(5, 1) reshape(1:15, 5, 3) / 10]
y_t = [[1, 0, 1, 0, 1] >= 0.5]
lambda_t = 3

cost(theta_t, X_t, y_t, # missing lambda_t)

# Part 2b: one-vs-all training
function one_vs_all end

lambda = 0.1
[all_theta] = one_vs_all(X, y, num_labels, lambda);