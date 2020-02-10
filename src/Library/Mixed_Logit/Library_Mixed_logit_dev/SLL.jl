function SLL(θ::Vector, it::Batch, U::Utilities, R::Int64)
    val = 0.0
    total = 0
    for ind in it
        val += ind.n_sim*log(SP(θ, ind, U, R))
        total += ind.n_sim
    end
    return -val/total
end

function ∇SLL(θ::Vector, it::Batch, U::Utilities, R::Int64)
	grad = zeros(length(θ))
    total = 0
    for ind in it
        grad_SP_i = ∇SP(θ, ind, U, R)
		reset_substream!(ind.rng)
		SP_i = SP(θ, ind, U, R)
        grad += ind.n_sim*grad_SP_i/SP_i
		total += ind.n_sim
    end
    return -grad/total
end
