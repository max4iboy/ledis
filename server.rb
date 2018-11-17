require 'drb'
require 'set'
require 'yaml'

class WrongTypeError < StandardError; end

class LedisMem

  private

  attr_accessor :memory, :ttl_h

  public

  def initialize
    @memory = {}
    @ttl_h = {}
  end

  def set(key, value)
    check_expire(key)
    check_type(memory[key], String)
    ttl_h.delete(key)
    memory[key] = value
  end

  def get(key)
    check_expire(key)
    check_type(memory[key], String)
    memory[key]
  end

  def llen(key)
    check_expire(key)
    check_type(memory[key], Array)
    memory[key].nil? ? 0 : memory[key].length
  end

  def rpush(key, elements)
    check_expire(key)
    check_type(memory[key], Array)
    arr = memory[key] || []
    arr.push(*elements)
    memory[key] = arr
    arr.length
  end

  def lpop(key)
    check_expire(key)
    check_type(memory[key], Array)
    arr = memory[key]
    return nil if arr.nil?
    value = arr.shift
    memory[key] = arr
    del(key) if arr.empty?
    value
  end

  def rpop(key)
    check_expire(key)
    check_type(memory[key], Array)
    arr = memory[key]
    return nil if arr.nil?
    value = arr.pop
    memory[key] = arr
    del(key) if arr.empty?
    value
  end

  def lrange(key, start, stop)
    check_expire(key)
    check_type(memory[key], Array)
    arr = memory[key]
    return nil if arr.nil?
    arr[start..stop]
  end

  def sadd(key, members)
    check_expire(key)
    check_type(memory[key], Set)
    set = memory[key] || Set.new
    new_mem_count = 0
    members.each do |m|
      new_mem_count += 1 unless set.include?(m)
      set.add m
    end
    memory[key] = set
    new_mem_count
  end

  def scard(key)
    check_expire(key)
    check_type(memory[key], Set)
    memory[key].nil? ? 0 : memory[key].length
  end

  def smembers(key)
    check_expire(key)
    check_type(memory[key], Set)
    memory[key].nil? ? nil : memory[key].to_a
  end

  def srem(key, members)
    check_expire(key)
    check_type(memory[key], Set)
    set = memory[key]
    return 0 if set.nil?
    removed_count = 0
    members.each do |m|
      removed_count += 1 if set.include?(m)
      set.delete(m)
    end
    memory[key] = set
    del(key) if set.empty?
    removed_count
  end

  def sinter(keys)
    check_expire(keys.first)
    inter_set = memory[keys.first]
    check_type(inter_set, Set)
    inter_set ||= Set.new
    keys[1..-1].each do |key|
      check_expire(key)
      set = memory[key]
      check_type(set, Set)
      set ||= ::Set.new
      inter_set = inter_set.intersection(set)
      return inter_set if inter_set.empty?
    end
    inter_set.to_a
  end

  def del(key)
    memory.delete(key)
    ttl_h.delete(key)
  end

  def keys
    memory.keys.each do |key|
      check_expire(key)
    end
    memory.keys
  end

  def flushdb
    memory.clear
    ttl_h.clear
  end

  def expire(key, seconds)
    check_expire(key)
    return 0 if memory[key].nil?
    ttl_h[key] = Time.now + seconds
    seconds
  end

  def ttl(key)
    check_expire(key)
    return -2 if memory[key].nil?
    return -1 if ttl_h[key].nil?
    (ttl_h[key] - Time.now).to_i
  end

  def save
    File.open('dump.yml', 'w') {|f| f.write memory.to_yaml}
  end

  def restore
    data = YAML.load_file('dump.yml')
    self.memory = data
    ttl_h.clear
  end

  private

  def check_expire(key)
    if !memory[key].nil? && !ttl_h[key].nil?
      if ttl_h[key] < Time.now
        del(key)
      end
    end
  end

  def check_type(value, type)
    if !value.nil? && !value.is_a?(type)
      raise_wrong_type_error
    end
  end

  def raise_wrong_type_error
    raise WrongTypeError, "(error) WRONGTYPE Operation against a key holding the wrong kind of value"
  end

end

memory = LedisMem.new

$SAFE = 1 # disable eval() and friends

DRb.start_service('druby://localhost:9999', memory)
DRb.thread.join
