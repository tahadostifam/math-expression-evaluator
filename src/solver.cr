private alias Object = Hash(Symbol, String)

module MathSolver
  def self.solve(expr : String)
  end

  private def sliceArgs(args : String, start : Int32)
    res = [] of String
    i : Int32 = start
    while i < args.size
      res.push(args[i].to_s)
      i += 1
    end
    return res
	end

	struct Logger
    @@logs = [] of Object

    def self.log(_message : String, _level : String)
        @@logs.push({:message => _message, :level => _level})
    end

    def self.get_logs
        @@logs
    end
  end
end
