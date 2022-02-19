module MathSolver
    class Solver
        def solve(line : String) : String | UnacceptableSyntax
            if validate_line(line)
                line = clear_spaces(line)
                puts puts 
                return "ok"
            else
                raise UnacceptableSyntax.new UnacceptableSyntax.message
            end
        end

        def validate_line(line : String) : Bool
            fr = 0
            fr = line.count("a-zA-Z")
            fr = line.count("+-/*")
            fr != 0
        end

        def clear_spaces(str : String)
            result = [] of String
            str.each_char do |ch|
                chs = ch.to_s
                if chs.strip.size > 0
                    result << chs
                end
            end

            result
        end
    end

    class UnacceptableSyntax < Exception
        def self.message 
            "Unacceptable Syntax"
        end
    end
end