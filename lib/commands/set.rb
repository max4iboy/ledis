require './command'

module Commands
  class Set < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length == 2
      key = key_value[0]
      str = key_value[1]
      memory.set(key, str)
      "OK"
    end
  end
end
