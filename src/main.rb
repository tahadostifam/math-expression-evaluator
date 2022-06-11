require_relative "math__solver.rb"

PROMPT = "> "
RESULT = "# -> "

include MathSolver

def main
  while true
    print PROMPT
    input = gets
    case input.strip
    when "exit"
      exit
    when "clear", "cls"
      Gem.win_platform? ? (system "cls") : (system "clear")
    else
      result = MathSolver.solve(input)
      puts "# -> #{result}"
    end
  end
end

main
