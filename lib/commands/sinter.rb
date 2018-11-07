module Commands
  class Sinter < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length >= 1
      result = memory.sinter(key_value)
      if result.empty?
        '(empty list or set)'
      else
        "'#{result.join("', '")}'"
      end
    end
  end
end
