module Commands
  class Srem < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length > 1
      key = key_value[0]
      members = key_value[1..-1]
      set = memory[key]
      check_type(set, ::Set)
      return 0.to_s if set.nil?
      count = 0
      members.each do |m|
        count += 1 if set.include?(m)
        set.delete(m)
      end
      memory[key] = set
      memory.delete(key) if set.empty?
      count.to_s
    end
  end
end
