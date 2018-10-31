module Commands
  class FlushDB
    def run(memory, params)
      key_value = params.split(' ')[1..-1]
      raise 'ERROR!' unless key_value.length == 0
      memory.clear
      "OK"
    end
  end
end
