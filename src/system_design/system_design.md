# System Design

## Overview

After working in the software industry for over two years, I have learned a lot about what is hiring manager and interviewer looking for when hiring a new software development engineer. Nevertheless, to become an senior/staff engineer, there is still a long way to go. Since I departed from my first job at AWS, I have been trying to learn from lectures, books, and keynote presentations regarding the knowledge and skills that I need to tackle a system design interview. Here, is where I keep all my notes. It is not a guide, it is not a book, it is not even well-organized at all. However, it is where I keep the knowledge that I have learned so far.

## System Design Interview

### What is a system design interview?
* simulate in-team design process
* solve an ambiguous problem
* work with teammates/co-workers
* two co-workers working together

### What are the desireable traits
* ability to collaborate with teammates
* work under pressure
* work with ambiguous problem
* constructive problem solving skills


#### How does the interviewer evaluate the desirable traits
* work with ambiguous problem
  * does the candidate asks requirement clarification?
### What are the undesirable traits
* over-engineering solution
* stubbornness
* do not answer without thinking, or without understanding the question's scope, requirements, backgrounds, etc.


### Does and Don'ts

**Dos**
* ask for clarification, do not make assumptions without verify with the interviewer
* thinking aloud - communicate
* make multiple design proposals
* design the most critical parts first
* ask for hints when stuck

**Don'ts**
* do not go into detailed design in the early stage
* do not thinking alone
### The approach

**Approaches - four stages**
1. Comprehend the requirement
2. Propose high-level designs
3. Detailed designs
4. Discussions


#### Stage 1: Comprehend the requirement

*After the interviewer asked the question, the candidate should list out the following 5 catagories of questions on the whiteboard/notepad. Then, the candidate can asks the following questions listed for each catagories. For each question asked, take notes on the information provided by the interviewer (e.g. user is an machine learning algorithm). If the information hits a design preference, please also take notes on the possible design solution (i.e. use gRPC streaming / use map-reduce).*


* **User/Customer:** what does the customer/end-user wants?
  * who is the user? and, how will the user use the product?
  * how the system will be used?
    * is the data going to be retrieved frequently? in real time? or by a cron job?
  * what product feature is the customer looking for?
  * what problem is the customer trying to solve?
* **Scale:** what is the scale of the system?
  * to understand how would our system handle the growing number of customers?
  * how many users?
  * what is the avg/p100 qps?
  * what is the size of the data per request?
  * do we need to handler spikes in traffic? what is the difference between peak traffic and average traffic
  * when does the customer need to scale 10x/100x
* **Performance:** what is the performance requirement of the system?
  * what is expected write-to-read delay?
    * can we use batch processing?
    * can we use stream processing?
    * do we need to use SSE/websocket for server-side push?
  * what is the expected P99 latency for read queries?
* **Cost:** what is the cost limit (budget constrain) of the system?
  * should the design minimized the cost of development?
  * should the design minimized the cost of dev/ops (maintenance)?
* **Tech Stack:** understand the technology the team is using
  * AWS? GCP? Azure?
  * Java? Rust? Python?
  * GraphQL? gRPC? REST?

#### Stage 2: List out the Functional/Non-Function Requirements

*After comprehend the question via asking clarification questions, the candidate can start list out the function requirements and the non-functional requirements. Make sure the interviewer is on the same page with the candidate. Also, please write down the functional requirement (i.e. API design) and non-functional requirements on the white board.*

* **Functional Requirements**
  * What does the APIs looks like? Input parameters? Output parameters?
  * What are the set of the operation that the system would support?

* **Non-Functional Requirements**
  * Scalability
  * Performance
  * Availability
  * Consistency
  * Cost

#### Stage 3: Propose high-level designs

*Once we have listed out all of the functional and non-functional requirements, we can start with something sample, such as a monolith with a front-end, a backend server, and a database.*

* propose design for different scales
  * get the interviewers involved
* make some estimation on the traffic/scale
  * dive deep only if the interviewer is asking for deeper analysis
* draw some components on the whiteboard for the high-level design
  * a frontend (e.g. Website/iOS/Android)
  * an api gateway
  * a load balancer
  * a backend service (running on EC2/ECS/AppRunner/Lambda)
  * a queue (if needed) (e.g. AWS SQS/Kafka/RocketMQ)
  * a database (if needed) (SQL/NoSQL) (e.g. AWS DynamoDB/Mongo/MySQL)
  * a data warehouse (if needed) ()
  * a batch processing service (if needed) (e.g. map-reduce)


#### Stage 4: Detailed design

*For each components listed during the previous stage, discuss with the interviewer which part we should dive deeper to propose an detailed design. If the interviewer did not provide any preference, the candidate can pick the part that the candidate has the most in-depth knowledge to discuss/design further.*

* design/discuss the api schema
  * REST/gRPC/GraphQL
* design/discuss the data schema
  * should we store individual data or aggregate data
* pick/discuss the database paradigms
  * should we use relational or key-value stores
* pick/discuss the usage of stream/batch process for the system
  * should we use a queue to buffer the request?
  * should we store the data somewhere and process them together latter?
* design/discuss the backend processing service
  * where to run the service? EC2/ECS/AppRunner/Lambda? trade-off? development cost vs operational cost?
  * how does the logic in the back end processing services looks like?
    * objected oriented design
    * using local cache?
  * how would it update the database?
    * per-request or batched
    * sync or async (queue)
    * user push or server pull?
  * single thread or multi thread?
  * internal dead-letter queue?
#### Stage 5: Discussions

*After finish the detailed design, the candidate and the interviewer can have a discussion regarding the pro/cons of the system such as the limitation and bottlenecks. How would the DevOps looks like during operation? How would the system handle disaster recovery? It is a great opportunity to demonstrate to the interviewer the depth and width of the knowledge of the candidate.*

* limitation
* bottlenecks
* disaster recovery
* dev-ops


### Question to ask:

#### Data schema

|     | Individual Data                                                                    | Aggregated Data                                                                                                                                |
| --- | ---------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| Pro | <ul><li>Fast to write</li><li>The data is flexible for future processing</li></ul> | <ul><li>Fast to read</li><li>The data is ready to be used</li></ul>                                                                            |
| Con | <ul><li>Slow to read</li><li>Costly to store</li></ul>                             | <ul><li>Usage is limited by the aggregation method</li><li>Requires data aggregation</li><li>Hard to fix pervious aggregation errors</li></ul> |

Ask: what is the expected data day?
* Few milliseconds/seconds -> store the individual data (stream processing)
* Few minutes -> store the individual data / aggregate the data on the fly
* Few hours -> aggregate the data using an aggregation pipeline / batch jobs (map-reduce)

#### Data Store Types

* Answer: How to scale write?
* Answer: How to scale reads?
* Answer: How to scale both write and reads?
* Answer: How to handle network partitions and hardware faults?
* Answer: Consistency model?
* Answer: How to recover data?
* Answer: Data security?
* Answer: How to make the data schema extensible for future changes?

#### Event/Request Processing Backend Service

* Answer: How to scale?
* Answer: How to achieve high throughput?
* Answer: How to handle instances failure?
* Answer: How to handle database failure? Unable to connect to database?

* Checkpoint:
  * the client write the request into a queue
  * the processing server pull from the queue, process it, write to database, the update the checkpoint offset

* Partitioning:
  * have several queue (use hashing to pick a queue)

#### OTHERS

* Blocking or Non-Blocking I/O
* Stream Service or Batch Service
* Buffering or Batching the request
* Timeouts / Retries (Thundering heard) (Exponential Back-Off / Jitter)
* Circuit Breaker
* Load Balancing: Using a Load Balancer or Service Mesh
* Service discovery (Server-Side/Client-Side)? DNS? Auto Scaling Group? Health Check? ZooKeeper?
* Sharding (For invoke / For database) (Sharding/Partition Strategy) (Hot Partition) (Consistent Hashing)
* Replications of server node (leader/leaderless)
* Data format (JSON/BSON/Thrift/ProtoBuf)
* Testing
  * correctness: unit test / functional test / integration test
  * performance: load test / stress test / soak test
  * monitoring: canary test
* monitoring:
  * logging: cloudwatch / elastic search / kibana
  * metrics: cloudwatch / grafana
  * alarm: cloudwatch

## References
* Alex Xu - *System Design Interview - An Insider's Guide*
* Mikhail Smarshchok - *System Design Interview - Step By Step Guile*