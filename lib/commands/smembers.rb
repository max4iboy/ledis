module Commands
  class Smembers
    def run(memory, params)
      key_value = params.split(' ')[1..-1]
      raise 'ERROR!' unless key_value.length == 1
      key = key_value.first
      return "empty list or set" if memory[key].nil?
      raise 'ERROR!' unless memory[key].is_a? Set
      "'#{memory[key].to_a.join("', '")}'"
    end
  end
end
