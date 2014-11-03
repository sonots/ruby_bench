```
$ rackup rack.ru
$ ab -n 1000 http://localhost:9292/
Requests per second:    356.58 [#/sec] (mean)

$ unicorn rack.ru -c unicon.conf
$ ab -n 1000 http://localhost:9292/
Requests per second:    1056.11 [#/sec] (mean)
```

```
$ rackup sinatra.ru
$ ab -n 1000 http://localhost:9292/
Requests per second:    298.55 [#/sec] (mean)

$ unicorn rack.ru -c unicorn.conf
$ ab -n 1000 http://localhost:9292/
Requests per second:    622.58 [#/sec] (mean)
```
