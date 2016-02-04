Redis Scripts
---

A bunch of Redis scripts written in Lua to make our life easier when playing around with Redis

### Usage

#### Basic

Non yet!

#### Advance

##### Remove all KEYS that match a given pattern without TTL

```bash
./clean_up_keys_without_ttl.sh [REDIS_IP] [REDIS_PORT] [PATTERN]
```

---

### Lua Scripts

#### Basic

##### DEL KEYS

```bash
redis-cli -h [REDIS_IP] -p [REDIS_PORT] EVAL "$(cat ./lua/del_keys.lua)" [COUNT_KEYS] [KEYS]
```

###### Result

It will return some like:

```bash
1) "a:2"
2) "a:3"
3) "a:1"
```

Where the first element is the KEY that have been DEL and the second the number of elements that have been deleted

> There is an example of usage in [clean_up_keys_without_ttl.sh]()

#### Advance

##### SCAN cursor [MATCH pattern] [COUNT count] KEYS without TTL

```bash
keys=$(redis-cli -h $1 -p $2 EVAL "$(cat ./lua/scan_match_count_keys_without_ttl.lua)" 0 $3 $4)
```

> There is an example of usage in [clean_up_keys_without_ttl.sh]()
