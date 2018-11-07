module Commands
  class Sinter < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length >= 1
      key = key_value[0]
      result = memory[key]
      result ||= Set.new
      raise 'ERROR!' unless result.is_a? Set
      keys = key_value[1..-1]
      keys.each do |key|
        set = memory[key]
        set ||= Set.new
        raise 'ERROR!' unless set.is_a? Set
        result = result.intersection(set)
        return 'empty list or set' if result.empty?
      end
      if result.empty?
        'empty list or set'
      else
        "'#{result.to_a.join("', '")}'"
      end
    end
  end
end
