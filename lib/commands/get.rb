module Commands
  class Get
    def run(memory, params)
      key_value = params
      raise 'ERROR!' unless key_value.length == 1
      key = key_value.first
      return '(nil)' if memory[key].nil?
      raise 'ERROR!' unless memory[key].is_a? String
      memory[key].to_s
    end
  end
end
