module Commands
  class Lpop
    def run(memory, params)
      key_value = params
      raise 'ERROR!' unless key_value.length == 1
      key = key_value.first
      return "empty list or set" if memory[key].nil?
      raise 'ERROR!' unless memory[key].is_a? Array
      arr = memory[key]
      ret_value = arr.shift
      memory[key] = arr
      memory.delete(key) if memory[key].empty?
      ret_value.to_s
    end
  end
end
