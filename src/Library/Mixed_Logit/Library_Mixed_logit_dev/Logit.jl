#logit return the value 
#∇logit! and Hlogit! add the required value to the stack, they do not replace it

function logit(θ::Vector, ind::MLM_Individual, U::Utilities)
	rigued = Rigged(rand(ind.rng, ind.ngamma))
    #println(γ)
    uti = U.V(θ, ind.data, rigued)
    v_plus = maximum(uti)
    uti -= v_plus*ones(length(uti))
    map!(exp, uti, uti)
    s = sum(uti)
    return uti[ind.choice]/s
end

function ∇logit(θ::Vector, ind::MLM_Individual, U::Utilities)
    rigued = Rigged(rand(ind.rng, ind.ngamma))

    uti = U.V(θ, ind.data, rigued)
    v_plus = maximum(uti)
    
    uti -= v_plus*ones(length(uti))
    map!(exp, uti, uti)
    s = sum(uti)
    
    
    return (s*uti[ind.choice]*U.∇V_i(θ, ind.data, ind.choice, rigued) - 
        
        uti[ind.choice]*sum(uti[i]*U.∇V_i(θ, ind.data, i, rigued) for i in 1:length(uti)))/(s^2)
    

end