local result = {};

for i,key in ipairs(KEYS) do
  local response = redis.call('DEL', key)
  if response == 1 then
    result[#result + 1] = key;
  end
end

return result;
