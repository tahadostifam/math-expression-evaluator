class MathSolver
    def self.eval(expr : String)
        expr = expr.dup
        go = true
        while go
            go = false
            p! /(-?\d+)\s*([*\/])\s*(-?\d+)/.match(expr)
            # while expr.sub!(/(-?\d+)\s*([*\/])\s*(-?\d+)/) do
            #     m, op, n = $1.to_i, $2, $3.to_i
            #     op == "*" ? m*n : m/n
            # end
            # while expr.sub!(/(-?\d+)\s*([+-])\s*(-?\d+)/) do
            #     a, op, b = $1.to_i, $2, $3.to_i
            #     op == "+" ? a+b : a-b
            # end
            # while expr.gsub!(/\(\s*(-?\d+)\s*\)/, '\1')
            # end
        end
        expr.to_i
    end
end