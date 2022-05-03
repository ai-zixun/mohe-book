# Design a Rate Limiter

## Question to ask

* Where is the rate limiter been used?
  * For a gRPC/REST api on the server side?
  * For a client side - to avoid sending too many request to the server?
  * For DDoS prevention?
* Do we impose a hard limit or a soft limit?
  * Stop serving the request if it hit more than exact 100 QPS?
  * Or just roughly around 100 QPS?
* How do we identify the user?
  * Using IP address?
  * user account?
  * AK/SK?
* The scale of the system?
  * QPS?
  * Number of user?
* Type of system
  * Distributed system? Monolith?
  * Single region? Cross-region?
* Where is the rate limiter located?
  * A pass-through gateway? Frontend service?
  * A microservice that determine if a request should be processed?
* How do we inform the user?
  * Error code
  * HTTP Code 429 - Too many

## Off the shelf solution

* AWS: AWS API Gateway - configure throttling for the API
* GCP: GCP API Gateway - quota and limits
* Azure: Azure API Management - advanced api throttling

## Rate limit algorithms

* token bucket
* leaking bucket
* fixed window counter
* sliding window log
* sliding window counter

### Token Bucket Algorithms

algorithms
* each user is assigned a pre-defined token bucket
* each token bucket has a pre-defined capacity
* each token bucket receive a fix-ed amount of token at a pre-defined interval
  * if the amount of token exceed the capacity, it would overflow, so the amount of token in the bucket does not exceed the capacity limitation
* when receiving a request, the rate limiter will try to retrieve a token from the bucket
  * if a token exist: proceed to process the request
  * if the bucket is empty: refuse the request

key parameters
* bucket capacity
* refill amount
* refill interval

pro
* simple algorithm
* allow burst request within the bucket capacity
cos
* limited tunability due to limited configurable parameters

### leaking bucket algorithms

algorithms
* each user is assigned a pre-defined FIFO queue with pre-defined size
* request are pulled and processed at a fixed rate
* when a request comes in, it would try to insert it into the queue
  * if the queue is full, the request will be rejected
  * if the queue has room, the request will be stored in the queue to be processed

key parameters
* queue size
* rate of processing

pro
* stable process flow due to the fixed rate
con
* the queue might rate limit after the burst instead of at the burst
* limited tunability due to limited configurable parameters

### fixed window counter algorithm

TODO

### sliding window log algorithm

TODO

### sliding window counter algorithm

TODO

## High level design

Where to store the counter/queue/log?
* not in disk (not local disk, not dynamodb, not mysql)
* in memory (local memory, redis, memcached)

Data consistency (race condition & )
* require atomic operation - INCR redis operation


synchronization issue
* more than one rate limiter servers, different server is storing different states
* solution:
  * consistent hashing
  * using a shared data store - redis / memcached



### TODO???

* what if we want to rate limit the amount of open gRPC stream / websocket connection ?
  * assuming an user can have 5 stream at a time
  * reject new connection is there are 5 stream open

## References
* Alex Xu - *System Design Interview - An Insider's Guide*