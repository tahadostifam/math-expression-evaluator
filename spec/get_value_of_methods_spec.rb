require_relative "../src/math__solver"

include MathSolver

$input = "sqrt(1)"

RSpec.describe MathSolver, "#get_value_of_method" do
    context "Get Value Of Method" do
        sqrt_callback = MathSolver::Methods.get_value_of_method("sqrt", $input)

        if sqrt_callback[:state] == :success
            puts sqrt_callback[:value]
        end
        
        if sqrt_callback[:state] == :empty_method
            puts "Is a empty method"
        end

        if sqrt_callback[:state] == :bad_syntax
            puts "Bad Syntax"
        end
    end
end