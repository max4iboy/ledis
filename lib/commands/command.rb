module Commands
  class Command
    class WrongArgumentsNumberError < StandardError; end

    def raise_wrong_arguments_number_error
      raise Commands::Command::WrongArgumentsNumberError, "(error) ERR wrong number of arguments for '#{self.class.name.split('::').last.downcase}' command"
    end
  end
end
