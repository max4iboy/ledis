module Commands
  class FlushDB
    def run(memory, params)
      key_value = params
      raise 'ERROR!' unless key_value.length == 0
      memory.clear
      "OK"
    end
  end
end
