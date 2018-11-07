require './lib/commands/command'

module Commands
  class Keys < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length == 0
      return "(empty list or set)" if memory.keys.empty?
      "'#{memory.keys.join("', '")}'"
    end
  end
end
