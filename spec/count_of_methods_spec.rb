require_relative "../src/math__solver"

include MathSolver

$input = "sqrt(9)"

RSpec.describe MathSolver, "#count_of_methods" do
    context "Count Of Methods" do
        if MathSolver::Lib.is_valid_expr? $input
            expr_arr = 
                MathSolver::Lib.separate_characters($input)        

            count_of_sqrt_methods = MathSolver::Methods.count_of_methods(expr_arr, "sqrt")

            puts "count_of_methods: #{count_of_sqrt_methods}"
            
            it "Success"
        else
            raise "Invalid Syntax!"
        end
    end
end