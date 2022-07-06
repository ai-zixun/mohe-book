# Delta / Difference Array

The idea of prefix sum is to construct an array that record the changes happened at each index. This is often useful when deal with scheduling issue and when working with a time series of events

```
Schedule - bookings
 |-----------------------|  [0, 6]
         |-----------|  [2, 5]
     |-------|  [1, 3]
         |-------------------|  [2, 7]
 +---+---+---+---+---+---+---+---+
 0   1   2   3   4   5   6   7   8

Delta / Diff Array
 1   1   2   0  -1   0  -1  -1  -1
 +---+---+---+---+---+---+---+---+
 0   1   2   3   4   5   6   7   8

Number of booking at each timestamp
 1   2   4   4   3   3   2   1   0
 +---+---+---+---+---+---+---+---+
 0   1   2   3   4   5   6   7   8
```

**Example**

In the graph above we have the following 4 time slot `[0, 6], [2, 5], [1, 3], [4, 7]`, let's say that we want to find out at each timestamp how many booking are there on the schedule. How can we figure it out?

**Using a BTreeMap**
```rust
# use std::collections::BTreeMap;
#
let schedule = vec![(0, 6), (2, 5), (1, 3), (4, 7)];
let mut delta: BTreeMap<usize, i32> = BTreeMap::new();

for (start, end) in schedule {
    *delta.entry(start).or_insert(0) += 1;
    *delta.entry(end + 1).or_insert(0) -= 1;
}

println!("delta - diff array: {:?}", delta);
```

**Using a Vec**
```rust
# use std::collections::BTreeMap;
#
let schedule = vec![(0, 6), (2, 5), (1, 3), (4, 7)];
let mut delta = vec![0; 9];

for (start, end) in schedule {
    delta[start] += 1;
    delta[end + 1] -= 1;
}

let mut num_of_booking = vec![0; 9];
let mut curr_number_of_booking = 0;

for i in 0..9 {
    curr_number_of_booking += delta[i];
    num_of_booking[i] = curr_number_of_booking;
}

println!("delta - diff array: {:?}", delta);
println!("number of booking:  {:?}", num_of_booking);
```
