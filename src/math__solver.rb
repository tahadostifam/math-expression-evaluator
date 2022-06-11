module MathSolver
  class Lib
    def self.count_of_operators!(expr_arr, op)
      i = 0
      c = 0

      while i < expr_arr.length
        if expr_arr[i].to_s.include? op || is_valid_keyword?(expr_arr, op)
          c += 1
        end
        i += 1
      end
      c
    end

    def self.convert_string_to_int(expr_arr)
      i = 0
      while i < expr_arr.length
        current_item = expr_arr[i]

        if !MathSolver::Lib.include_ops? current_item
          expr_arr[i] = current_item.to_i
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
        if include_ops?(current_char)
          fn_i = separated_chars_index - 1 # finish of word's index
          if include_ops?(without_white_space_arr[separated_chars_index + 1])
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

    def self.is_valid_keyword?(expr_arr, inp)
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
            ret = true
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

        if item.strip.length > 0 && !valid_chars.include?(item) && !is_valid_keyword?(expr_arr, item)
          result = false
        end
        i += 1
      end

      result
    end

    def self.valid_chars
      ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "(", ")"] + MathSolver::Lib.operators
    end

    def self.operators
      return ["+", "-", "*", "/", "sqrt"]
    end

    def self.include_ops?(inp)
      MathSolver::Lib.operators.include?(inp)
    end
  end

  class OperatorEvalulator
    def self.start_solve!(expr_arr, op)
      i = 0
      coo = MathSolver::Lib.count_of_operators!(expr_arr, op)

      if coo > 0
        while coo > 0
          current_item = expr_arr[i]

          if current_item == op
            result = nil
            prev_word = expr_arr[i - 1].to_i
            next_word = expr_arr[i + 1].to_i

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

            coo -= 1
          end

          i += 1
        end
      end

      expr_arr
    end
  end

  class MethodEvalulator
    def self.start_solve!(expr_arr, name)
    end
  end

  def self.solve(expr)
    final_result = nil

    if MathSolver::Lib.is_valid_expr? expr
      expr = MathSolver::Lib.separate_characters(expr)
      expr = MathSolver::Lib.convert_string_to_int(expr)

      MathSolver::OperatorEvalulator.start_solve!(expr, "/")
      MathSolver::OperatorEvalulator.start_solve!(expr, "*")
      MathSolver::OperatorEvalulator.start_solve!(expr, "-")
      MathSolver::OperatorEvalulator.start_solve!(expr, "+")

      final_result = expr.join("")
    else
      puts "Invalid Syntax!"
      exit
    end

    final_result
  end
end
