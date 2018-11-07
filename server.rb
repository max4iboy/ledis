require 'drb'
require 'set'

class WrongTypeError < StandardError; end

class LedisMem

  private

  attr_accessor :memory

  public

  def initialize
    @memory = {}
  end

  def set(key, value)
    check_type(memory[key], String)
    memory[key] = value
  end

  def get(key)
    check_type(memory[key], String)
    memory[key]
  end

  def llen(key)
    check_type(memory[key], Array)
    memory[key].nil? ? 0 : memory[key].length
  end

  def rpush(key, elements)
    check_type(memory[key], Array)
    arr = memory[key] || []
    arr.push(*elements)
    memory[key] = arr
    arr.length
  end

  def lpop(key)
    check_type(memory[key], Array)
    arr = memory[key]
    return nil if arr.nil?
    value = arr.shift
    memory[key] = arr
    del(key) if arr.empty?
    value
  end

  def rpop(key)
    check_type(memory[key], Array)
    arr = memory[key]
    return nil if arr.nil?
    value = arr.pop
    memory[key] = arr
    del(key) if arr.empty?
    value
  end

  def lrange(key, start, stop)
    check_type(memory[key], Array)
    arr = memory[key]
    return nil if arr.nil?
    arr[start..stop]
  end

  def sadd(key, members)
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
    check_type(memory[key], Set)
    memory[key].nil? ? 0 : memory[key].length
  end

  def smembers(key)
    check_type(memory[key], Set)
    memory[key].nil? ? nil : memory[key].to_a
  end

  def srem(key, members)
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
    inter_set = memory[keys.first]
    check_type(inter_set, Set)
    inter_set ||= Set.new
    keys[1..-1].each do |key|
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
  end

  def keys
    memory.keys
  end

  def flushdb
    memory.clear
  end

  private

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

DRb.start_service('druby://localhost:9999', memory)
DRb.thread.join
