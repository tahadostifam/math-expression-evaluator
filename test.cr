# def sliceArgs(args : String, start : Int32)
#     res = [] of String
#     i : Int32 = start
#     while i < args.size
#       res.push(args[i].to_s)
#       i += 1
#     end
#     return res
# end

# puts sliceArgs("String", 0)

# alias Log = NamedTuple(level: String, message: String)

# arr = [] of Array(Log)

private alias Log = NamedTuple(level: String, message: String)

struct Logger
    logs = [] of Array(Log)

    def self.log(message : String, level : String)
        logs << {message: message, level: level}
    end
end