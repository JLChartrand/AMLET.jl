#logit return the value 
#∇logit! and Hlogit! add the required value to the stack, they do not replace it

function logit(θ::Vector, ind::MLM_Individual, U::Utilities)
    #println(γ)
    uti = U.V(θ, ind.data, ind.rng)
    v_plus = maximum(uti)
    uti -= v_plus*ones(length(uti))
    map!(exp, uti, uti)
    s = sum(uti)
    return uti[ind.choice]/s
end

function ∇logit(θ::Vector, γ::Vector, ind::MLM_Individual{Array{Float64,2}}, U::Utilities)
	function tmp(θ::Vector)
		return logit(θ, γ, ind, U)
	end
	return ForwardDiff.gradient(tmp, θ)
end 