local values = {}

local result = redis.call('SCAN', ARGV[1], 'MATCH', ARGV[2], 'COUNT', ARGV[3])
local cursor = result[1];
local keys = result[2];

for i,key in ipairs(keys) do
  local ttl = redis.call('ttl', key)
  if ttl == -1 then
    values[#values + 1] = key
  end
end

return { cursor, values }
