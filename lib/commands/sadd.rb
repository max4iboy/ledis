require './command'

module Commands
  class Sadd < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length > 1
      key = key_value[0]
      members = key_value[1..-1]
      new_mem_count = memory.sadd(key, members)
      new_mem_count.to_s
    end
  end
end
