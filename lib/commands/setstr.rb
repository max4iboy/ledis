module Commands
  class SetStr < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length == 2
      key = key_value[0]
      str = key_value[1]
      value = memory[key]
      check_type(value, String)
      memory[key] = str
      "OK"
    end
  end
end
