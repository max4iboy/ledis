module Commands
  class Rpush < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length > 1
      key = key_value[0]
      elements = key_value[1..-1]
      length = memory.rpush(key, elements)
      length.to_s
    end
  end
end
