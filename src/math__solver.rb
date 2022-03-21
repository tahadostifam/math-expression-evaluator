module MathSolver
    @expr_arr = []

    def self.solve(expr)
      @expr_arr = expr
      @expr_arr = separate_characters!
      @expr_arr = string_to_int!
      @expr_arr = evalDevisionExpr!
      @expr_arr = evalMultipExpr!
      @expr_arr = evalMinusExpr!
      @expr_arr = evalPlusExpr!
      return @expr_arr.join("")
    end
    
    private
    
    def evalDevisionExpr!
      i = 0
      coo = count_of_ops!("/")

      if coo > 0
        while coo > 0
          current_item = @expr_arr[i]
          
          if current_item == "/"
            result = nil
            prev_word = @expr_arr[i - 1].to_i
            next_word = @expr_arr[i + 1].to_i
            
            result = prev_word / next_word
            @expr_arr[(i - 1)..(i + 1)] = result
            i = i - 1
  
            coo -= 1
          end
  
          i += 1
        end
      end

      @expr_arr
    end

    def evalMultipExpr!
      i = 0
      coo = count_of_ops!("*")

      if coo > 0
        while coo > 0
          current_item = @expr_arr[i]
          
          if current_item == "*"
            result = nil
            prev_word = @expr_arr[i - 1].to_i
            next_word = @expr_arr[i + 1].to_i
            
            result = prev_word * next_word
            @expr_arr[(i - 1)..(i + 1)] = result
            i = i - 1
  
            coo -= 1
          end
  
          i += 1
        end
      end

      @expr_arr
    end

    def evalMinusExpr!
      i = 0
      coo = count_of_ops!("-")

      if coo > 0
        while coo > 0
          current_item = @expr_arr[i]
          
          if current_item == "-"
            result = nil
            prev_word = @expr_arr[i - 1].to_i
            next_word = @expr_arr[i + 1].to_i
            
            result = prev_word - next_word
            @expr_arr[(i - 1)..(i + 1)] = result
            i = i - 1
  
            coo -= 1
          end
  
          i += 1
        end
      end

      @expr_arr
    end

    def evalPlusExpr!
      i = 0
      coo = count_of_ops!("+")

      if coo > 0
        while coo > 0
          current_item = @expr_arr[i]
          
          if current_item == "+"
            result = nil
            prev_word = @expr_arr[i - 1].to_i
            next_word = @expr_arr[i + 1].to_i
            
            result = prev_word + next_word
            @expr_arr[(i - 1)..(i + 1)] = result
            i = i - 1
  
            coo -= 1
          end
  
          i += 1
        end
      end

      @expr_arr
    end

    def count_of_ops!(op)
      i = 0
      c = 0
      while i < @expr_arr.length
        if @expr_arr[i] == op
          c += 1
        end
        i += 1
      end
      c
    end

    def string_to_int!
      i = 0
      while i < @expr_arr.length
        current_item = @expr_arr[i]

        if !MathSolver.operators.include?(current_item)
          @expr_arr[i] = current_item.to_i
        end

        i += 1
      end
      @expr_arr
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