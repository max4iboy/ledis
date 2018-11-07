module Commands
  class Get < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length == 1
      key = key_value.first
      return '(nil)' if memory[key].nil?
      raise 'ERROR!' unless memory[key].is_a? String
      memory[key].to_s
    end
  end
end
