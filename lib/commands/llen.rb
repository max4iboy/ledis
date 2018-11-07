module Commands
  class Llen < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length == 1
      key = key_value.first
      length = memory.llen(key)
      length.to_s
    end
  end
end
