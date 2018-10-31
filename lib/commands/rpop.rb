module Commands
  class Rpop
    def run(memory, params)
      key_value = params.split(' ')[1..-1]
      raise 'ERROR!' unless key_value.length == 1
      key = key_value.first
      return "empty list or set" if memory[key].nil?
      raise 'ERROR!' unless memory[key].is_a? Array
      arr = memory[key]
      ret_value = arr.pop
      memory[key] = arr
      memory.delete(key) if memory[key].empty?
      ret_value
    end
  end
end
