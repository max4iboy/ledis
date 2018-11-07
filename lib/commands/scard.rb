require './lib/commands/command'

module Commands
  class Scard < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length == 1
      key = key_value.first
      length = memory.scard(key)
      length.to_s
    end
  end
end
