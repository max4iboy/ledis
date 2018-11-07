module Commands
  class Srem < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length > 1
      key = key_value[0]
      values = key_value[1..-1]
      return 0.to_s if memory[key].nil?
      raise 'ERROR!' unless memory[key].is_a? Set
      set = memory[key]
      count = 0
      values.each do |v|
        count += 1 if set.include?(v)
        set.delete(v)
      end
      memory[key] = set
      memory.delete(key) if memory[key].empty?
      count.to_s
    end
  end
end
