#logit return the value 
#∇logit! and Hlogit! add the required value to the stack, they do not replace it

function logit(θ::Vector, ind::MLM_Individual, U::Utilities)
    gamma = rand(ind.rng, ind.ngamma)
    uti = U.V(θ, ind.data, gamma)
    v_plus = maximum(uti)
    uti -= v_plus*ones(length(uti))
    map!(exp, uti, uti)
    s = sum(uti)
    return uti[ind.choice]/s
end

function ∇logit(θ::Vector, ind::MLM_Individual, U::Utilities)
    gamma = rand(ind.rng, ind.ngamma)

    uti = U.V(θ, ind.data, gamma)
    v_plus = maximum(uti)
    
    uti -= v_plus*ones(length(uti))
    map!(exp, uti, uti)
    s = sum(uti)
    
    
    return (s*uti[ind.choice]*U.∇V_i(θ, ind.data, ind.choice, gamma) - 
        
        uti[ind.choice]*sum(uti[i]*U.∇V_i(θ, ind.data, i, gamma) for i in 1:length(uti)))/(s^2)
    

end
