function SP(θ::Vector, ind::MLM_Individual, U::Utilities, R::Int64)
    
    value = 0.0
    for _ in 1:R
        value += logit(θ, ind, U)
    end
    value *= 1/R
    return value
end

function ∇SP(θ::Vector, ind::MLM_Individual, U::Utilities, R::Int64)
    function tmp(θ::Vector)
		return SP(θ, ind, U, R)
	end
	return ForwardDiff.gradient(tmp, θ)
end
