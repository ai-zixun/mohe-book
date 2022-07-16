# System Design Fundamentals

Vertical/Horizontal Scaling
* Vertical Scaling
* Horizontal Scaling

Share Nothing Architecture
* Different machine on the same machine do not share physical resources (CPU, MEM, etc.)
*

What makes distributed computing different from local computing
* Latency: Processor speed vs network speed
* Memory Access: No pointers -> Share data via sending messages
* Partial Failures: Unavoidable on distributed system

8 Fallacies of Distributed Systems
1. The network is reliable
2. Latency is ZERO
3. Bandwidth is infinite
4. The network is secure
5. Topology does not changes
6. There is only one administrator
7. Transport cost $0
8. The network is homogeneous

The Byzantine General Problem

Latency -> How to set a

Fischer Lynch Paterson Correctness result
* Distributed consensus is impossible when at least one process might fail

To manage uncertainty we have mitigation strategies
* APPROACH 1: Limit who can write at a given time
  * Leader-Follower pattern
* APPROACH 2: Make rules for how many yes in the system
  * raft - consensus algorithm


Mental modal calibration
* Incident analysis - post mortem
  * fresh learning

Request Validation
* Check the request is hitting an valid API
* Check the request consist all required parameters
* Check the request parameters are within the valid range

Authentication / Authorization
* Authentication: validate the identity of the user/service
* Authorization: check the user/service has the permission for the given action

TLS / SSL Termination
* Decrypting the TLS/SSL request and pass the un-encrypted request to the backend services

Request Dispatching
* Sending the request to the appropriate backend service

Request De-duplication
*

Metrics Collection
*

Bulkhead Pattern

Circuit Breaker Pattern