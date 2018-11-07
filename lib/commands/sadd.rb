module Commands
  class Sadd < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length > 1
      key = key_value[0]
      members = key_value[1..-1]
      value = memory[key]
      check_type(value, ::Set)
      value ||= ::Set.new
      count = 0
      members.each do |m|
        count += 1 unless value.include?(m)
        value.add m
      end
      memory[key] = value
      count.to_s
    end
  end
end
