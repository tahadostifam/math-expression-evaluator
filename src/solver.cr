module MathSolver
    class Solver
        alias Object = Hash(String, String)

        private def detect_senteces_and_solve_math(arr : Array(String)) : String
            nos : Int32 = Validators.cosents(arr) # -> number of senteces
            op : String | Nil # -> operator
            sents = [] of Object # -> array of our senteces
            fres : Int64 = 0 # -> final result

            Validators.dosents(arr) do |op_i|
                sents << Object{
                    "op" => arr[op_i],
                    "fisent" => arr[op_i - 1],
                    "sesent" => arr[op_i + 1]
                }
            end

            ss = 0 # -> solved sentences
            while ss < sents.size
                sent = arr[ss]
                
                # TODO
                # sorting the sentences by prorit

                ss += 1
            end
            
            fres
        end
        
        def solve(line : String) : String | UnacceptableSyntax
            if MathSolver::Validators.validate_line(line)
                line = clear_spaces(line)
                
                result = detect_senteces_and_solve_math(line)

                return result
            else
                raise UnacceptableSyntax.new UnacceptableSyntax.message
            end
        end

        def clear_spaces(str : String) : Array(String)
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

    class Validators
        @@operators : Array(String) = ["+", "-", "*", "/"]

        def self.is_operator?(ch : String)
            @@operators.includes?(ch)
        end

        def self.cosents(arr : Array(String))
            c = 0
            arr.each do |i|
                c += 1 if @@operators.includes?(i)
            end
            c
        end

        def self.dosents(arr : Array(String)) # -> yield if item is an operator
            c = 0
            while c < arr.size
               yield(c) if @@operators.includes?(arr[c]) 
               c += 1
            end      
        end

        def self.validate_line(line : String) : Bool
            fr = 0
            fr = line.count("a-zA-Z")
            fr = line.count("+-/*")
            fr != 0
        end
    end

    class UnacceptableSyntax < Exception
        def self.message 
            "Unacceptable Syntax"
        end
    end
end