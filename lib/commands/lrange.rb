module Commands
  class Lrange
    def run(memory, params)
      key_value = params.split(' ')[1..-1]
      raise 'ERROR!' unless key_value.length == 3
      key = key_value[0]
      start = key_value[1]
      stop = key_value[2]
      integer_reg = /\A[+-]?\d\z/
      raise 'ERROR!' unless integer_reg.match(start) && integer_reg.match(stop)
      return "empty list or set" if memory[key].nil?
      raise 'ERROR!' unless memory[key].is_a? Array
      result = memory[key][start.to_i..stop.to_i]
      return "empty list or set" if result.nil? || result.empty?
      "'#{result.join("', '")}'"
    end
  end
end
