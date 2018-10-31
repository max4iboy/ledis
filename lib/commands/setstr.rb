module Commands
  class SetStr
    def run(memory, params)
      key_value = params.split(' ')[1..-1]
      raise 'ERROR!' unless key_value.length == 2
      key = key_value[0]
      value = key_value[1]
      memory[key] = value
      "OK"
    end
  end
end
