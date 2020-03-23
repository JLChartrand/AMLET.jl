function logit(θ::Vector, X::T, choice::Int, gamma::Array{Float64, 1}, U::Utilities) where T
    uti = U.V(θ, X, gamma)
    uti .-= maximum(uti) #numerical thing. 
    map!(exp, uti, uti)#inplace map, uti contains exponential of utilities, re-use of memory.
    return uti[xhoice]/sum(uti)
end

function ∇logit(θ::Vector, X::T, choice::Int, gamma::Array{Float64, 1}, U::Utilities)
    uti = U.V(θ, ind.data, gamma)
    uti .-= maximum(uti)
    
    map!(exp, uti, uti) #inplace map, uti contains exponential of utilities, re-use of memory.
    s = sum(uti)
    return (s*uti[choice]*U.∇V_i(θ, X, choice, gamma) - 
        uti[choice]*sum(uti[i]*U.∇V_i(θ, X, i, gamma) for i in 1:length(uti)))/(s^2)
end

function Prod_logit(θ::Vector, datas::Array{T, 1}, choices::Array{Int64, 1}, gamma::Array{Float64, 1}, 
        U::Utilities)
    return prod(logit(θ, datas[i], choices[i], gamma, U) for i in 1:length(choices))
end

function ∇Prod_logit(θ::Vector, datas::Array{T, 1}, choices::Array{Int64, 1}, gamma::Array{Float64, 1}, 
        U::Utilities) 
    p = prod(logit(θ, datas[i], choices[i], gamma, U) for i in 1:length(choices))
    return p*sum(∇logit(θ, datas[i], choices[i], gamma, U)/logit(θ, datas[i], choices[i], gamma, U))
end

function SR_panel(