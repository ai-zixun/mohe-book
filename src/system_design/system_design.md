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


**Stage 1: Comprehend the requirement**
* what does the customer/end-user wants?
  * what product feature is the customer looking for?
  * what problem is the customer trying to solve?
* what is the scale of the system?
  * how many users?
  * what is the avg/p100 qps
  * when does the customer need to scale 10x/100x
* understand the technology the team is using
  * AWS? GCP? Azure?
  * Java? Rust? Python?
  * GraphQL? gRPC? REST?

**Stage 2: Propose high-level designs**
* propose design for different scales
  * get the interviewers involved
* make some estimation on the traffic/scale
  * dive deep only if the interviewer is asking for deeper analysis
* design the api schema / database schema if it is suited to the question

**Stage 3: Detailed design**

**Stage 4: Discussions**
* limitation, bottlenecks, disaster recovery, dev-ops, etc.


## References
* Alex Xu - *System Design Interview - An Insider's Guide*