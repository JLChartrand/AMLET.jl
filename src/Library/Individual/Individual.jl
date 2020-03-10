"""
`abstract type Individual{T} end`
"""

abstract type Individual{T} end

"""
`struct LM_Individual{T} <: Individual{T}`
## Fields:
### `data::T`
Contains the data

### `choice::Int64`
A `Int64` representing the choice of the Individual

### `n_sim::Int64`
The number of similar Individual
"""
struct LM_Individual{T} <: Individual{T}
    data::T
    choice::Int64
    n_sim::Int64
end

"""
'struct MLM_Individual{T <: Individual{Any} , S <: AbstractRNG} <: Individual{Any}'
## Fields:
### `ind::T where T<: Individual{Any}`
Contains an individual

### `rng::S where S <: AbstractRNG`
The RNG used for the monte carlos estimation
"""
struct MLM_Individual{T} <: Individual{T}
	data::T
    choice::Int64
    n_sim::Int64
    rng
	ngamma::Int64
    function MLM_Individual(ind::LM_Individual{T}, rng, ngamma::Int64) where T
        return new{T}(ind.data, ind.choice, ind.n_sim, rng, ngamma)
    end
end
