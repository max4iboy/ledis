require './lib/commands/command'

module Commands
  class FlushDB < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length == 0
      memory.flushdb
      "OK"
    end
  end
end
