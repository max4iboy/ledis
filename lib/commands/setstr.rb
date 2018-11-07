module Commands
  class SetStr < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length == 2
      key = key_value[0]
      value = key_value[1]
      if !memory[key].nil? && !memory[key].is_a?(String)
        raise 'ERROR!'
      end
      memory[key] = value
      "OK"
    end
  end
end
