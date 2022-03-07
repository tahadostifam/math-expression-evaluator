require "./solver.cr"

PROMPT = "> "
RESULT = "# -> "

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
        result = MathSolver.solve(line)
        puts "#{RESULT}#{result}"
      end
    end
  end
end

main
