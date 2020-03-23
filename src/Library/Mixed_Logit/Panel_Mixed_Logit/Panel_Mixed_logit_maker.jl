


function complete_Model!(pmlm::Panel_MLM, U::Utilities, R::Int64)
    batch = mlm.batch
    
    function F_panel(β::Array{Float64, 1}, b::Batch = batch)
		reset_stream!(b.rng)
        return SLL(β, b, U, R)
    end
    
    function ∇F_panel!(β::Array{Float64, 1}, stack::Array{Float64, 1}, b::Batch = batch)
		reset_stream!(b.rng)
		stack[:] = ∇SLL(β, b, U, R)
    end
    
    
    mlm.f = F              
    mlm.∇f! = ∇F!
end 