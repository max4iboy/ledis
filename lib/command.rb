Dir['./lib/commands/*'].each {|file| require file}

module Command
  COMMANDS = {
    "set" => Commands::Set
  }

  def self.parse_from(command)
    raise 'ERROR!' unless COMMANDS.has_key?(command)
    COMMANDS[command].new
  end
end
