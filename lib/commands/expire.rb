require './lib/commands/command'

module Commands
  class Expire < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length == 2
      key = key_value[0]
      seconds = key_value[1]
      raise_not_positive_integer_error unless /\A[+]?\d+\z/.match(seconds)
      result = memory.expire(key,seconds.to_i)
      result.to_s
    end
  end
end
