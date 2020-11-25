module BadAD

struct Dual{T}
    x::T # primal ?
    der::T # derivative
end

# """ a and b are functions
# $ c(x) = a(x) + b(x) $
# $ dc/dx = da/dx + db/dx $
# """

Base.:+(a::Dual, b::Dual) = Dual(a.x + b.x, a.der + b.der)

Base.:+(a::Dual, b::Number) = Dual(a.x + b, a.der)
Base.:+(a::Number, b::Dual) = b + a


Base.:-(a::Dual, b::Dual) = Dual(a.x - b.x, a.der - b.der)

Base.:-(a::Dual, b::Number) = Dual(a.x - b, a.der)
Base.:-(a::Number, b::Dual) = b - a

Base.:-(a::Dual) = Dual(-a.x, -a.der)


Base.:*(a::Dual, b::Dual) = Dual(a.x * b.x, a.der*b.x + a.x*b.der) # product rule

Base.:*(a::Dual, b::Number) = Dual(a.x * b, a.der * b) # product rule
Base.:*(a::Number, b::Dual) = b * a 

Base.:/(a::Dual, b::Dual) = Dual(a.x / b.x, (a.der * b.x - a.x * b.der) / (b.x ^ 2))
Base.:/(a::Dual, b::Number) = a * inv(b)
Base.:/(a::Number, b::Dual) = Dual(a * b.x, a * b.der)

Base.:^(a::Dual, b::Integer) = Base.power_by_squaring(a, b) # the power rule falls out of this 

derivative(f, x) = f(Dual(x, one(x))).der

# primatives
Base.sin(a::Dual) = Dual(sin(a.x), a.der * cos(a.x))
Base.cos(a::Dual) = Dual(cos(a.x), -a.der * sin(a.x))
Base.exp(a::Dual) = Dual(exp(a.x), exp(a.x) * a.der) 

# we can now take derivative of the sigmoid function 
σ(a) = 1/(1+exp(a)) # derivative(σ, 1) ≈ ℯ 



end
