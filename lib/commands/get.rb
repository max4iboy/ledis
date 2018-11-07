module Commands
  class Get < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length == 1
      key = key_value.first
      value = memory.get(key)
      if value.nil?
         '(nil)'
      else
        value
      end
    end
  end
end
