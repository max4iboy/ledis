Dir['./lib/commands/*'].each {|file| require file}

module Command
  COMMANDS = {
    "set" => Commands::Set,
    "get" => Commands::Get,
    "llen" => Commands::Llen,
    "rpush" => Commands::Rpush,
    "lpop" => Commands::Lpop,
    "rpop" => Commands::Rpop,
    "lrange" => Commands::Lrange,
    "sadd" => Commands::Sadd,
    "scard" => Commands::Scard,
    "smembers" => Commands::Smembers,
    "srem" => Commands::Srem,
    "sinter" => Commands::Sinter,
    "keys" => Commands::Keys,
    "del" => Commands::Del,
    "flushdb" => Commands::FlushDB,
    "expire" => Commands::Expire,
    "ttl" => Commands::Ttl
  }

  def self.parse_from(command)
    raise 'ERROR!' unless COMMANDS.has_key?(command)
    COMMANDS[command].new
  end
end
