using Yao
using Yao.Zoo
using Compat.Test

@testset "RotBasis" begin
    rt = RotBasis(0.5, 0.4)
    crt = chain(rt)
    dispatch!(crt, [2.,3.])
    @test nparameters(crt) == 2
    @test parameters(rt) == [2, 3] == parameters(crt)

    # check consistency
    rb = roll(1, RotBasis(0.1,0.3))#rot_basis(1)
    angles = randpolar(1)
    # prepair a state in the angles direction.
    psi = angles |> polar2u |> register

    # rotate to the same direction for measurements.
    dispatch!(rb, vec(angles))
    @test state(psi |> rb) ≈ [1,0]
    
    @test nparameters(rot_basis(3)) == 6
end

@testset "polar and u" begin
    polar = randpolar(10)
    @test size(polar) == (2,10)
    @test polar |> polar2u |> u2polar ≈ polar
end