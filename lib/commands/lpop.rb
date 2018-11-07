module Commands
  class Lpop < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length == 1
      key = key_value.first
      value = memory[key]
      check_type(value, Array)
      return "(empty list or set)" if value.nil?
      ret_value = value.shift
      memory[key] = value
      memory.delete(key) if value.empty?
      ret_value.to_s
    end
  end
end
