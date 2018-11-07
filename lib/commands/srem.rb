require './command'

module Commands
  class Srem < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length > 1
      key = key_value[0]
      members = key_value[1..-1]
      removed_count = memory.srem(key, members)
      removed_count.to_s
    end
  end
end
