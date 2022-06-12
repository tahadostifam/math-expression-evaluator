module MathSolver
  class Lib
    def self.convert_string_to_int(expr_arr)
      i = 0
      while i < expr_arr.length
        current_item = expr_arr[i]

        if !MathSolver::Operators.include_ops? current_item
          expr_arr[i] = current_item.to_f
        end

        i += 1
      end
      expr_arr
    end

    def self.separate_characters(expr_arr)
      without_white_space_arr = []
      without_white_space_index = 0
      while without_white_space_index < expr_arr.length
        current_char = expr_arr[without_white_space_index].to_s.strip
        if current_char.length > 0
          without_white_space_arr << current_char
        end
        without_white_space_index += 1
      end
      separated_chars = []
      separated_chars_index = 0
      last_operator_index = 0
      while separated_chars_index < without_white_space_arr.length + 1
        current_char = without_white_space_arr[separated_chars_index]
        if MathSolver::Operators.include_ops?(current_char)
          fn_i = separated_chars_index - 1 # finish of word's index
          if MathSolver::Operators.include_ops?(without_white_space_arr[separated_chars_index + 1])
            fn_i = separated_chars_index
          end
          separated_chars << without_white_space_arr[last_operator_index..fn_i].join("")
          separated_chars << current_char
          last_operator_index = separated_chars_index + 1
        end

        if separated_chars_index + 1 >= without_white_space_arr.length + 1
          # finish of chars
          separated_chars << without_white_space_arr[last_operator_index..separated_chars_index].join("")
        end

        separated_chars_index += 1
      end
      separated_chars
    end

    def self.is_valid_char?(expr_arr, inp)
      separated_chars_arr = separate_characters(expr_arr)
      return_value = true
      i = 0
      while i < separated_chars_arr.length
        item = separated_chars_arr[i]
        if !item.to_s.include?(inp.to_s)
          return_value = false
        end
        for valid_char in valid_chars
          if valid_char.include?(item)
            return_value = true
          end
        end
        i += 1
      end
      return_value
    end

    def self.is_valid_expr?(expr_arr)
      result = true
      i = 0
      while i < expr_arr.length
        item = expr_arr[i].to_s

        if item.strip.length > 0 && !valid_chars.include?(item) && !is_valid_char?(expr_arr, item)
          result = false
        end
        i += 1
      end

      result
    end

    def self.valid_chars
      ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "(", ")"] + MathSolver::Operators.operators
    end
  end

  class Operators
    def self.count_of_operators(expr_arr, op)
      i = 0
      c = 0

      while i < expr_arr.length
        if expr_arr[i].to_s.include? op || is_valid_char?(expr_arr, op)
          c += 1
        end
        i += 1
      end
      c
    end

    def self.operators
      return ["+", "-", "*", "/", "sqrt"]
    end

    def self.include_ops?(inp)
      MathSolver::Operators.operators.include?(inp)
    end

    def self.start_solve!(expr_arr, op)
      count_of_operators = MathSolver::Operators.count_of_operators(expr_arr, op)

      if count_of_operators > 0
        i = 0
        while count_of_operators > 0
          current_item = expr_arr[i]

          if current_item == op
            result = nil
            prev_word = expr_arr[i - 1].to_f
            next_word = expr_arr[i + 1].to_f

            result = 0
            case op
            when "+"
              result = prev_word + next_word
            when "-"
              result = prev_word - next_word
            when "*"
              result = prev_word * next_word
            when "/"
              result = prev_word / next_word
            else
              raise "bad operator"
            end
            expr_arr[(i - 1)..(i + 1)] = result
            i = i - 1

            count_of_operators -= 1
          end

          i += 1
        end
      end

      expr_arr
    end
  end

  class Methods
    def self.keywords
      [
        "sqrt",
        "pi"
      ]
    end

    def self.check_keywords!(expr_arr)
      for expr_item in expr_arr
        if !MathSolver::Lib.valid_chars.include?(expr_item) && !MathSolver::Lib.is_valid_char?(expr_arr, expr_item)
          finnaly_its_valid = false
          MathSolver::Methods.keywords.each do |keyword|
            method_name = get_method_name(expr_item)
            if MathSolver::Methods.keywords.include?(method_name)
              finnaly_its_valid = true
              break
            end
          end

          if !finnaly_its_valid
            puts "Invalid Syntax!"
            exit
          end
        end
      end
    end

    def self.get_value_of_method(method_name, input)
      start_point = (method_name.index method_name).to_i + method_name.length
      if input[start_point] == "(" && input[input.length - 1] == ")"
        method_values = []
        if defined? start_point
          for i in ((start_point + 1)..(input.length - 2))
            method_values << input[i]
          end
        else
          return { :state => :bad_syntax }
        end

        if method_values.length == 0
          return { :state => :empty_method }
        else
          return { :value => method_values.join(""), :state => :success }
        end
      else
        return { :state => :bad_syntax }
      end
    end

    def self.get_method_name(input)
      return_value = :bad_syntax
      i = 0
      while i < input.to_s.length do
        if input[i] == "("
          return_value = input[0..(i - 1)]
          break
        end

        if i >= (input.to_s.length - 1)
          return_value = input[0..(input.to_s.length - 1)]
          break
        end

        i += 1
      end
      return_value
    end

    def self.count_of_methods(expr_arr, op)
      count_of_methods = 0
      expr_arr.each do |item|
        method_name = get_method_name(item)
        if method_name != :bad_syntax
          if MathSolver::Methods.keywords.include?(method_name)
            count_of_methods += 1
          end
        end
      end
      count_of_methods
    end

    def self.start_solve!(expr_arr, name, configs)
      count_of_methods = MathSolver::Methods.count_of_methods(expr_arr, name)
      if count_of_methods > 0
        i = 0
        while i < count_of_methods
          if configs[:no_value] == nil || configs[:no_value] == false
            if MathSolver::Methods.get_method_name(expr_arr[i]) == name
              method_info = MathSolver::Methods.get_value_of_method(name, expr_arr[i])
  
              result = nil
  
              if method_info[:state] == :success
                result = yield(method_info[:value].to_f)
              end
  
              expr_arr[i] = result.to_f
            end
          else
            if MathSolver::Methods.get_method_name(expr_arr[i]) == name
              result = yield

              expr_arr[i] = result.to_f
            end
          end

          i += 1
        end
      end

      expr_arr
    end
  end

  def self.solve(expr)
    final_result = nil

    if MathSolver::Lib.is_valid_expr? expr
      expr = MathSolver::Lib.separate_characters(expr)

      MathSolver::Methods.check_keywords!(expr)
      
      MathSolver::Methods.start_solve!(expr, "sqrt", { :no_value => false }) do |value|
        Math.sqrt(value).truncate(3)
      end

      MathSolver::Methods.start_solve!(expr, "pi", { :no_value => true }) do
        Math::PI
      end

      expr = MathSolver::Lib.convert_string_to_int(expr)

      MathSolver::Operators.start_solve!(expr, "/")
      MathSolver::Operators.start_solve!(expr, "*")
      MathSolver::Operators.start_solve!(expr, "-")
      MathSolver::Operators.start_solve!(expr, "+")

      final_result = expr.join("")
    else
      puts "Invalid Syntax!"
      exit
    end

    final_result
  end
end
