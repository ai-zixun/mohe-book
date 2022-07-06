# Prefix Sum

The idea of prefix sum is to construct an array that for each index `prefix_sum[index]` represent the total cumulative sum of all element between the first element to the element for the given index. This is an useful tool when there are a lot of operation of getting the sum of a sub-array of the inputting array.
```
numbers
 ----- ----- ----- ----- ----- ----- -----
|  4  |  6  |  10 |  40 |  5  |  8  |  30 |
 ----- ----- ----- ----- ----- ----- -----
   0     1     2     3     4     5     6

prefix-sum (inclusive)
 ----- ----- ----- ----- ----- ----- -----
|  4  |  10 |  20 |  60 |  65 |  73 | 103 |
 ----- ----- ----- ----- ----- ----- -----
   0     1     2     3     4     5     6

prefix-sum (exclusive)
 ----- ----- ----- ----- ----- ----- ----- -----
|  0  |  4  |  10 |  20 |  60 |  65 |  73 | 103 |
 ----- ----- ----- ----- ----- ----- ----- -----
   0     1     2     3     4     5     6     7

```
**Variables**
* `numbers` the input arrays that contains numbers with length of `n`
* `prefix_sum` the prefix sum array

**Two types of prefix sum**
* inclusive prefix sum
  * `prefix_sum[i] = prefix_sum[i - 1] + number[i]`
  * The value `prefix_sum[i]` includes `number[i]` and all numbers comes before `number[i]`

* exclusive prefix sum
  * `prefix_sum[i] = prefix_sum[i - 1] + number[i - 1]`
  * The value `prefix_sum[i]` does not `number[i]` but includes all numbers comes before `number[i]`

For the sake of simplicity and to avoid accessing numbers with native index, I always use the **exclusive prefix sum**

How to build the prefix sum array:
```rust
let numbers = vec![4, 6, 10, 40, 5, 8, 30];
let mut prefix_sum = vec![0; numbers.len() + 1];

for i in 0..numbers.len() {
    prefix_sum[i + 1] = prefix_sum[i] + numbers[i];
}

println!{"numbers:    {:?}", numbers};
println!{"prefix_sum: {:?}", prefix_sum};
```

How to access the sum of all element with index `[i, j)`:
```rust
# let prefix_sum = vec![0, 4, 10, 20, 60, 65, 73, 103];
let (i, j) = (2, 5);
let sum = prefix_sum[j] - prefix_sum[i];

println!("sum of sub array [10, 40, 5]: {:?}", sum);
```

