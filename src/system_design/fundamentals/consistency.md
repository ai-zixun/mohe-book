# Consistency

## Definitions

**Consensus**: The methods to get all of the instances/nodes in the system to agree on something.

**Eventual Consistency (Convergence)**: All replicas in the system will eventually converge to the same value after an unspecified length of time.

**Faults Tolerant**: The ability of keeping the software system functioning correctly, even if some internal component is faulty.

**Linearizability**: The system appears as if there is only one copy of data, and all operation on the data are atomic.

**Split Brain**: More than one instance/node in the system believe that they are the leader in a single-leader system.

**Strict Serializability / Strong One-Copy Serializability**: The database/system satisfy both the serializability and linearizability requirements.

## Replication Methods

* Single-Leader Replication
* Multi-Leader Replication
* Leaderless Replication

## Linearizability

**Requirement of Linearizability**
* After one read has returned an updated value, all following read by the same client and all other clients must also returns the same updated value.

### Linearizability of Replication Models

#### Single-leader Replication - Potentially Linearizable

Example: MongoDB with `linearizable` Read Concern

A single-leader replication system can become fully *linearizable* if the following condition are met
1. All write and read are done via the leader node
2. All client and knows who is the leader node.

Failover might cause the system violate the *linearizability* concern
1. When using asynchronous replication, the lost of committed writes would cause the system to violate the *linearizability* and *durability* requirements
2. When using synchronous replication, the system meet the *linearizability* and *durability* requirements, but the system will be slow.

#### Multi-leader Replication - Not Linearizable

Example:

Since there are multiple copy of the data handled by multiple leaders, and the replication of the data are done asynchronously, the multi-leader replication system cannot meet the *linearizability* requirements.

#### Leaderless Replication - Not Linearizable (Most of the Cases)

Example:

#### Consensus Algorithms - Linearizable

Example: etcd and ZooKeeper

Consensus algorithms has built-in measures to avoid/prevent split brain and stale replicas, which allows the consensus algorithms to meed the *linearizability* requirements.



## CAP Theorem
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
    * A distributed system can deliver only two of the three characteristics
  * TRUE
    * Partition Tolerance is required; to avoid partition tolerance, there can only be one service, which is not a distributed system
    * Hence, all distributed system need to balance between consistency and availability
