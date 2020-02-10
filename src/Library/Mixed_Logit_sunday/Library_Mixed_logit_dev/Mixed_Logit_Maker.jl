function complete_Model!(mlm::MLM, U::Utilities, R::Int64)
    batch = mlm.batch
    
    function F(β::Array{Float64, 1}, b::Batch = batch)
		reset_stream!(b.rng)
        return SLL(β, b, U, R)
    end
    
    function ∇F!(β::Array{Float64, 1}, stack::Array{Float64, 1}, b::Batch = batch)
		reset_stream!(b.rng)
		ForwardDiff.gradient!(stack, F, β)
    end
    
    
    mlm.f = F              
    mlm.∇f! = ∇F!
end 