module Commands
  class Lrange < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length == 3
      key = key_value[0]
      start = key_value[1]
      stop = key_value[2]
      integer_reg = /\A[+-]?\d\z/
      raise 'ERROR!' unless integer_reg.match(start) && integer_reg.match(stop)
      value = memory[key]
      check_type(value, Array)
      return "(empty list or set)" if value.nil?
      result = value[start.to_i..stop.to_i]
      return "(empty list or set)" if result.nil? || result.empty?
      "'#{result.join("', '")}'"
    end
  end
end
