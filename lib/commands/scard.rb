module Commands
  class Scard < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length == 1
      key = key_value.first
      value = memory[key]
      check_type(value, ::Set)
      return 0.to_s if value.nil?
      value.length.to_s
    end
  end
end
