require './lib/commands/command'

module Commands
  class Rpop < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length == 1
      key = key_value.first
      value = memory.rpop(key)
      value.nil? ? "(empty list or set)" : value.to_s
    end
  end
end
