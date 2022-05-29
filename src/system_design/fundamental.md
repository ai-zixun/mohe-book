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

CAP Theorem
* Characteristics
  * Consistency
    * All nodes on the network must return the same data
    * HARD!!!!!!
    * Requires: Instant and universal replication
    * Eventual Consistency does not count: It's not the C in CAP
    * Consistency is not a binary state, there are many degrees of consistency
  * Availability
  * Partition Tolerance
    * Network partition occur when network connectivity between two nodes is interrupted
* Theorem
  * NOT TRUE
    * A distributed systen can deliver only two of the three characteristics
  * TRUE
    * Partition Tolerance is required; to avoid partition tolerance, there can only be one service, which is not a distributed system
    * Hence, all distributed system need to balance between consistency and availability

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