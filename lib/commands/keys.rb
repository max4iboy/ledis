module Commands
  class Keys
    def run(memory, params)
      key_value = params.split(' ')[1..-1]
      raise 'ERROR!' unless key_value.length == 0
      return "empty list or set" if memory.keys.empty?
      "'#{memory.keys.join("', '")}'"
    end
  end
end
