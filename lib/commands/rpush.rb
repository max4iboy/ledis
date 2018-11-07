module Commands
  class Rpush
    def run(memory, params)
      key_value = params
      raise 'ERROR!' unless key_value.length > 1
      key = key_value[0]
      values = key_value[1..-1]
      memory[key] ||= []
      raise 'ERROR!' unless memory[key].is_a? Array
      memory[key] = memory[key].push(*values)
      memory[key].length.to_s
    end
  end
end
