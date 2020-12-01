using BadAD
using ForwardDiff
using Test

@testset "BadAD.jl" begin

    a = b = Dual(1, 1)

    S(x) = 1/(1 + exp(-x))
    dS(x) = exp(-x)/(1 + exp(-x))^2

    f(x) = x^2
    g(x) = sin(x)
    h(x) = f(x)/g(x)

    f2(x) = 3^x

    @test -1 * (a + b) == -a + -b
    @test derivative(g ∘ f, 3.14) == 2*3.14*cos(3.14^2)
    @test derivative(h, 3) == (2*3*sin(3) - 3^2 * cos(3))/(sin(3)^2)
    @test derivative(S, 1) == dS(1)
    @test ForwardDiff.derivative(x->3.5^x, 3) ≈ derivative(x->3.5^x, 3)


    f3(x) = SA[log(x[1])]
end
