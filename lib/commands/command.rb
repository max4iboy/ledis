module Commands
  class Command
    class WrongTypeError < StandardError; end
    class WrongArgumentsNumberError < StandardError; end

    def check_type(value, type)
      if !value.nil? && !value.is_a?(type)
        raise_wrong_type_error
      end
    end

    def raise_wrong_arguments_number_error
      raise Commands::Command::WrongArgumentsNumberError, "(error) ERR wrong number of arguments for '#{self.class.name.split('::').last.downcase}' command"
    end

    def raise_wrong_type_error
      raise Commands::Command::WrongTypeError, "(error) WRONGTYPE Operation against a key holding the wrong kind of value"
    end
  end
end
