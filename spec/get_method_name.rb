require_relative "../src/math__solver"

include MathSolver

RSpec.describe MathSolver, "#method_name" do
    context "Method Name" do
        puts "method_name: #{MathSolver::Methods.get_method_name("pi")}"
        puts "method_name: #{MathSolver::Methods.get_method_name("sqrt(9)")}"
        puts "method_name: #{MathSolver::Methods.get_method_name("cin(0)")}"
    end
end