local values = {}

return redis.call('SCAN', 0, 'MATCH', ARGV[1], 'COUNT', ARGV[2])
