module Commands
  class Get
    def run(memory, params)
      key_value = params.split(' ')[1..-1]
      raise 'ERROR!' unless key_value.length == 1
      key = key_value.first
      memory[key].nil? ? "(nil)" : memory[key].to_s
    end
  end
end
