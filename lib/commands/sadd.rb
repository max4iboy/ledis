module Commands
  class Sadd < Command
    def run(memory, params)
      key_value = params
      raise_wrong_arguments_number_error unless key_value.length > 1
      key = key_value[0]
      values = key_value[1..-1]
      memory[key] ||= Set.new
      raise 'ERROR!' unless memory[key].is_a? Set
      count = 0
      my_set = memory[key]
      values.each do |v|
        count += 1 unless my_set.include?(v)
        my_set.add v
      end
      memory[key] = my_set
      count.to_s
    end
  end
end
