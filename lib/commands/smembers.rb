require './lib/commands/command'

module Commands
  class Smembers < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length == 1
      key = key_value.first
      result = memory.smembers(key)
      result.nil? ? "(empty list or set)" : "'#{result.join("', '")}'"
    end
  end
end
