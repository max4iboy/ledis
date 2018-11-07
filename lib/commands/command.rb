module Commands
  class Command
    class WrongArgumentsNumberError < StandardError; end
    class InvalidIntegerError < StandardError; end

    def raise_wrong_arguments_number_error
      raise Commands::Command::WrongArgumentsNumberError, "(error) ERR wrong number of arguments for '#{self.class.name.split('::').last.downcase}' command"
    end

    def raise_not_integer_error
      raise Commands::Command::InvalidIntegerError, "(error) ERR value is not an integer or out of range"
    end

    def raise_not_positive_integer_error
      raise Commands::Command::InvalidIntegerError, "(error) ERR value is not a positive integer or out of range"
    end
  end
end
