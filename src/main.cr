require "./solver.cr"

PROMPT = "> "
ERROR = "# Error -> "
RESULT = "# -> "

include MathSolver
MATH_SOLVER = Solver.new

def main
  while true
    print PROMPT
    line : String | Nil = gets

    if line && line.strip
      case line.strip
      when "clear"
        puts `clear`
        next
      when "exit"
        exit
      else
        begin
          __result__ = MATH_SOLVER.solve line  
          puts RESULT + __result__
        rescue e
          puts e.message
        end
      end
    end
  end
end

main