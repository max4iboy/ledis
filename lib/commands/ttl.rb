require './lib/commands/command'

module Commands
  class Ttl < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length == 1
      key = key_value[0]
      result = memory.ttl(key)
      result.to_s
    end
  end
end
