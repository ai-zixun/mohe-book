# Algorithms

*When dealing with system design questions such as designing a rate limiting system, a sharding system, or a global location service, candidate can use some of the following system design algorithms during the interview.*

## Leaky Bucket Algorithms

**Use-case**: Rate Limiting Systems

**Process**
1. a client send a message to the server
2. the server uses an sharding algorithms to find the corresponding bucket for the message
3. the server tries to append the message to the bucket - a local message queue
   - if the queue is full (i.e. has `bucket_size` message in the queue already), then drop the message
   - if the queue has space, append the message to the end of the queue
4. the consumer will pull message from the queue with a rate of `drain_rate`
5. the consumer process the message

**Parameters**
- `bucket_size`: the maximum amount of messages can be stored in each bucket
- `drain_rate`: the speed that the message is been consumed from the bucket

![Leaky Bucket Algorithms](./images/algorithms_000.png)

## Token Bucket Algorithms

**Use-case**: Rate Limiting System

**Process**
1. a client send a message to the server
2. the server uses an sharding algorithms to find the corresponding bucket for the message
3. the server tries to acquire a token from the bucket
   - if a token is acquired, the request is processed
   - if no token exist in the bucket, the request is dropped
4. the bucket receive a refill of `refill_size` amount of token each for each `refill_rate` interval
5. the amount of token can be stored in the bucket is limited by the `bucket_size`


**Parameters**
- `bucket_size`: the maximum amount of token can be stored in each bucket
- `refill_size`: the amount of token
- `refill_rate`: the time interval between each refill

**Alteration**
- *token per request*: for each token, the system can process one message. if there are `n` message, then it would requires `n` token from the bucket for all the message to be processed.
- *token per bytes*: for each token, the system can process `x` byte of message. if there are `n` message each with `s` size, then it would requires `CEIL(x / s) * n` tokens from the bucket for all message to be processed.

![Token Bucket Algorithms](./images/algorithms_001.png)