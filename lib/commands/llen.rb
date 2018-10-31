module Commands
  class Llen
    def run(memory, params)
      key_value = params.split(' ')[1..-1]
      raise 'ERROR!' unless key_value.length == 1
      key = key_value.first
      return 0.to_s if memory[key].nil?
      raise 'ERROR!' unless memory[key].is_a? Array
      memory[key].length.to_s
    end
  end
end
