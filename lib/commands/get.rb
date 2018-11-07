module Commands
  class Get < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length == 1
      key = key_value.first
      value = memory[key]
      check_type(value, String)
      return '(nil)' if value.nil?
      value.to_s
    end
  end
end
