require './command'

module Commands
  class Del < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length == 1
      key = key_value.first
      if memory.del(key).nil?
        0.to_s
      else
        1.to_s
      end
    end
  end
end
