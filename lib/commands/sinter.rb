module Commands
  class Sinter < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length >= 1
      key = key_value[0]
      result = memory[key]
      check_type(result, Set)
      result ||= Set.new
      keys = key_value[1..-1]
      keys.each do |key|
        set = memory[key]
        check_type(set, Set)
        set ||= Set.new
        result = result.intersection(set)
        return '(empty list or set)' if result.empty?
      end
      if result.empty?
        '(empty list or set)'
      else
        "'#{result.to_a.join("', '")}'"
      end
    end
  end
end
