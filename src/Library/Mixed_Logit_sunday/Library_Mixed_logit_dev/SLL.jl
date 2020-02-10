function SLL(θ::Vector, it::Batch, U::Utilities, R::Int64)
    val = 0.0
    total = 0
    for ind in it
        val += ind.n_sim*log(SP(θ, ind, U, R))
        total += ind.n_sim
    end
    return -val/total
end

function ∇SLL(θ::Vector, it::Batch, U::Utilities, R::Int64, dim_γ::Int64)
    function tmp(θ::Vector)
		LL(θ, it, U, R)
	end
	return ForwardDiff.gradient(tmp, θ)
end
