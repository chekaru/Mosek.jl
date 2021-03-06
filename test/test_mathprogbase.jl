module TestMathProgBase

import Mosek.MosekMathProgSolverInterface
import Mosek
using MathProgBase
using Base.Test


#const MPB = MathProgBase
include(joinpath(Pkg.dir("MathProgBase","test","linprog.jl")))
include(joinpath(Pkg.dir("MathProgBase","test","mixintprog.jl")))
include(joinpath(Pkg.dir("MathProgBase","test","quadprog.jl")))
include(joinpath(Pkg.dir("MathProgBase","test","nlp.jl")))
include(joinpath(Pkg.dir("MathProgBase","test","conicinterface.jl")))
include(joinpath(Pkg.dir("MathProgBase","test","linproginterface.jl")))


function test_mathprogbase(solver)
    @testset "linprog" begin
        linprogtest(solver)
    end

    @testset "mip" begin
        mixintprogtest(solver)
    end
    
    @testset "qp" begin
        #quadprogtest(solver)
        #qpdualtest(solver)
        #socptest(solver)
    end

    @testset "conic" begin
        coniclineartest(solver, duals=true)
        conicSOCtest(solver, duals=true)
        conicSOCRotatedtest(solver, duals=true)
        conicSOCINTtest(solver)
        conicEXPtest(solver, duals=true)
        conicSDPtest(solver, duals=true)
    end

    @testset "linproginterface" begin
        linprogsolvertest(solver)
        linprogsolvertestextra(solver)
    end
end

test_mathprogbase(Mosek.MosekSolver(QUIET = true))

end
