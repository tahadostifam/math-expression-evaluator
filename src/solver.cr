module MathSolver
    class Solver
        private alias Object = Hash(String, String)
        private alias Number = Float64 | Int64 | Int32 | Int8
        private alias DataAndRange = NamedTuple(data: String, range: Range(Int32, Int32))

        private def prev_sent(arr : Array(String), point : Int32) : DataAndRange | Nil
            dtrt : Array(String) | Nil # data to return
            itrt : Range(Int32, Int32) | Nil # index to return
            c = point
            while true
                if c == 0
                    dtrt = arr[0..point]
                    itrt = 0..point
                    break
                    return
                end

                begin
                    if Validators.is_operator?(arr[c - 1])
                        dtrt = arr[c..point]
                        itrt = c..point
                        break
                        return
                    end
                rescue
                end

                c -= 1
            end
            if dtrt
                {data: dtrt.join(""), range: itrt}
            end
        end

        private def next_sent(arr : Array(String), point : Int32) : DataAndRange | Nil
            dtrt : Array(String) | Nil # data to return
            itrt : Range(Int32, Int32) | Nil # data to return
            c = point

            while true
                if c == arr.size
                    dtrt = arr[(point + 1)..c]
                    itrt = (point + 1)..c
                    break
                end

                begin
                    if !arr[c + 1].nil?
                        fncnum = Validators.is_operator?(arr[c + 1])
                        if fncnum
                            dtrt = arr[(point + 1)..c]
                            itrt = (point + 1)..c
                            break
                        end
                    end
                rescue
                end

                c += 1
            end
            if dtrt
                {data: dtrt.join(""), range: itrt}
            end
        end

        private def detect_senteces_and_solve_math(arr : Array(String)) : String
            nos : Int32 = Validators.cosents(arr) # -> number of senteces
            op : String | Nil # -> operator
            fres : Number = 0 # -> final result

            arr_string = arr.join ""

            p! arr_string # NOTE

            unsolved_op = nos
            op_i = 0
            while op_i < arr.size
               if Validators.operators.includes?(arr[op_i]) 
                    fisent : DataAndRange | Nil = prev_sent(arr, op_i - 1) # -> first sentece
                    sesent : DataAndRange | Nil = next_sent(arr, op_i) # -> second sentece
                    if fisent && sesent
                        begin
                            res = do_op(fisent["data"].to_f, sesent["data"].to_f, arr[op_i])
                            i1 = fisent["range"].to_a.first
                            i2 = sesent["range"].to_a.last - 1
                        rescue
                            raise Exception.new "Error in parsing String into Number"
                            break
                        end

                        arr[i1..i2] = res.to_s

                        # if nos == 2
                        #     arr[fisent["range"]] = ""
                        # end
                        
                        p! arr[fisent["range"]]

                        unsolved_op -= 1
                    else
                        ErrorInCalc.new ErrorInCalc.message
                    end
               end
               op_i += 1
            end  
            
            fres.to_s
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

        def do_op(s1 : Number, s2 : Number, op : String) : Number | Nil
            case op
            when "+"
                return s1 + s2
            when "-"
                return s1 - s2
            when "*"
                return s1 * s2
            when "/"
                return s1 / s2
            else
                raise UnknownOperator.new UnknownOperator.message
            end
        end
    end

    class Validators
        @@operators : Array(String) = ["+", "-", "*", "/"]

        def self.operators
            @@operators
        end

        def self.is_operator?(ch : String)
            @@operators.includes?(ch)
        end

        def self.priorities(i : Int32) : String
            case i
            when 4
                return "/"
            when 3
                return "*"
            when 2
                return "-"
            when 1
                return "+"
            else
                raise Exception.new "Bad I of Priority"
            end
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
    class ErrorInCalc < Exception
        def self.message 
            "Error In Calculate The Answer"
        end
    end
end