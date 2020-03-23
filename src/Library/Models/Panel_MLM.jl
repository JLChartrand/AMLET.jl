mutable struct Panel_MLM <: Models
    batch::Batch
    f::Function              
    ∇f!::Function             
    Hf!::Function
    
    x::Vector                #value of the optimal parameters completed by a solve methods
    undefine                 #wathever you want
    
    
    function Panel_MLM(batch::Batch)
        mlm = new()
        mlm.batch = batch
        return mlm
    end
end