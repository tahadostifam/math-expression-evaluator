module MathSolver
    class Solver
        private alias Object = Hash(String, String)
        private alias Number = Float64 | Int64

        private def prev_sent(arr : Array(String), point : Int32) : String | Nil
            dtrt : Array(String) | Nil # data to return
            c = point
            while true
                ch = arr[c]

                if c == 0
                    dtrt = arr[0..point]
                    break
                elsif Validators.is_operator?(arr[c - 1])
                    dtrt = arr[c..point]
                    break
                end

                c -= 1
            end
            if dtrt
                dtrt.join("")
            end
        end

        private def detect_senteces_and_solve_math(arr : Array(String)) : String
            nos : Int32 = Validators.cosents(arr) # -> number of senteces
            op : String | Nil # -> operator
            sents = [] of Object # -> array of our senteces
            fres : Number = 0 # -> final result

            Validators.dosents(arr) do |op_i|
                fisent : String | Nil = prev_sent(arr, op_i - 1)
                if fisent
                    sents << Object{
                        "op" => arr[op_i],
                        "fisent" => fisent, # -> first sentece
                        "sesent" => arr[op_i + 1] # -> second sentece
                    }
                end
            end

            puts sents

            # ss = 0 # -> solved sentences
            # while ss < sents.size
            #     sent = sents[ss]
                
            #     puts sent
            #     # sentece_result = __answer_of_sentence(sent["op"], sent["fisent"].to_i, sent["sesent"].to_i)
            #     # if sentece_result
            #     #     sentece_result
            #     # else
            #     #     puts "result is empty"
            #     # end

            #     ss += 1
            # end
            
            fres.to_s
        end

        private def __answer_of_sentence(op : String, x : Int32, y : Int32)
            case op
            when "+"
                return x + y
            when "-"
                return x - y
            when "*"
                return x * y
            when "/"
                return x / y
            else
                raise UnknownOperator.new UnknownOperator.message
                return Nil
            end
        end
        
        def solve(line : String) : String | UnacceptableSyntax # -> main function
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

        def self.cosents(arr : Array(String)) # -> counts the senteces
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
    class UnknownOperator < Exception
        def self.message 
            "Unknown Operator"
        end
    end
end