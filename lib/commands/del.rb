module Commands
  class Del
    def run(memory, params)
      key_value = params.split(' ')[1..-1]
      raise 'ERROR!' unless key_value.length == 1
      key = key_value.first
      if memory.delete(key).nil?
        0.to_s
      else
        1.to_s
      end
    end
  end
end
