require_relative "../src/math__solver"

include MathSolver

$input = "sqrt(9)"

RSpec.describe MathSolver, "#count_of_methods" do
    context "Count Of Methods" do
        if MathSolver::Lib.is_valid_expr? $input
            expr_arr = 
                MathSolver::Lib.separate_characters($input)
            expr_arr = 
                MathSolver::Lib.convert_string_to_int($input)

            count_of_methods = MathSolver::Lib.count_of_methods(expr_arr)

            puts "count_of_methods: #{count_of_methods}"
            
            it "Success"
        else
            raise "Invalid Syntax!"
        end
    end
end