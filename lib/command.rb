Dir['./lib/commands/*'].each {|file| require file}

module Command
  COMMANDS = {
    "set" => Commands::Set,
    "get" => Commands::Get,
    "llen" => Commands::Llen,
    "rpush" => Commands::Rpush,
    "lpop" => Commands::Lpop,
    "rpop" => Commands::Rpop,
    "lrange" => Commands::Lrange
  }

  def self.parse_from(command)
    raise 'ERROR!' unless COMMANDS.has_key?(command)
    COMMANDS[command].new
  end
end
