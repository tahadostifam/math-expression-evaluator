module MathSolver
    @expr_arr = []

    def self.solve(expr)
        @expr_arr = expr
        @expr_arr = separate_characters!
        return @expr_arr
    end
    
    private

    def parseMultipExpr
        
    end

    def parseMinusExpr
        
    end

    def parsePlusExpr
        
    end

    def separate_characters!
       wws = [] # without_white_space
       wws_i = 0
       while wws_i < @expr_arr.length
        current_char = @expr_arr[wws_i].strip
        if current_char.length > 0
          wws << current_char
        end
        wws_i += 1
       end
       sc = [] # separated_chars
       sc_i = 0
       lo_i = 0 # last operator's index
       while sc_i < wws.length + 1
        current_char = wws[sc_i]

        if MathSolver.operators.include?(current_char)
          fn_i = sc_i - 1# finish of word's index
          if MathSolver.operators.include?(wws[sc_i + 1])
            fn_i = sc_i
          end
          sc << wws[lo_i..fn_i].join("")
          sc << current_char
          lo_i = sc_i + 1
        end

        if sc_i + 1 >= wws.length + 1
          # finish of chars
          sc << wws[lo_i..sc_i].join("")
        end
        
        sc_i += 1
       end
       sc
    end

    def self.operators
      return ["+", "-", "*", "/"]
    end
end