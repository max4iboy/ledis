module Commands
  class Scard
    def run(memory, params)
      key_value = params
      raise 'ERROR!' unless key_value.length == 1
      key = key_value.first
      return 0.to_s if memory[key].nil?
      raise 'ERROR!' unless memory[key].is_a? Set
      memory[key].length.to_s
    end
  end
end
