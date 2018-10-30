require 'drb'

memory = {}

DRb.start_service('druby://localhost:9999', memory)
DRb.thread.join
