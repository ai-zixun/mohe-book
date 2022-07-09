# Algorithms

*When dealing with system design questions such as designing a rate limiting system, a sharding system, or a global location service, candidate can use some of the following system design algorithms during the interview.*

## Leaky Bucket Algorithms

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
