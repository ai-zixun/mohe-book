# Binary Search

## Template

```rust
fn check(mid: i32) -> bool {
    todo!()
}

fn binary_search() -> i32 {
    let mut left = 0;
    let mut right = i32::MAX;

    while left < right {
        let mid = left + (right - left) / 2;
        if check(mid) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }

    left
}
```

## Key Approaches

*Credit to @Lee215*

1. use `left < right` or `left <= right`

    to make the binary search process easier, we do not handle the `left == right` case in the loop. Instead, we will try to make the least `left` index to point to the correct answer that we are looking for.

2. use `mid = left + (right - left) / 2` or `mid = left + (right - left + 1) / 2`
    * use `mid = left + (right - left) / 2` to find the index of the first valid element
    * use `mid = left + (right - left + 1) / 2` to find the index of the last valid element

## Search for the first index of the valid value


```
  0   1   2   3   4   5   6   7   8   9
 --- --- --- --- --- --- --- --- --- ---
| 0 | 0 | 1 | 1 | 2 | 2 | 2 | 3 | 3 | 3 |
 --- --- --- --- --- --- --- --- --- ---
                  ^
                  |
                target

                  ^   ^   ^   ^   ^   ^
                  |   |   |   |   |   |
                          valid
```


```rust
# fn main() {
#    let list = vec![0, 0, 1, 1, 2, 2, 2, 3, 3, 3];
#    let k = 2;
#    let res = binary_search_first_valid(list, k);
#    println!("Result: {:?}", res);
# }
#
fn binary_search_first_valid(list: Vec<i32>, target: i32) -> usize {
    fn check(list: &Vec<i32>, mid: usize, target: i32) -> bool {
        list[mid] >= target
    }

    let mut left = 0;
    let mut right = list.len();

    while left < right {
        let mid = left + (right - left) / 2;
        if check(&list, mid, target) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    left
}
```

## Search for the last index of the valid value


```
  0   1   2   3   4   5   6   7   8   9
 --- --- --- --- --- --- --- --- --- ---
| 0 | 0 | 1 | 1 | 2 | 2 | 2 | 3 | 3 | 3 |
 --- --- --- --- --- --- --- --- --- ---
                          ^
                          |
                        target
  ^   ^   ^   ^   ^   ^   ^
  |   |   |   |   |   |   |
            valid
```

```rust
# fn main() {
#     let list = vec![0, 0, 1, 1, 2, 2, 2, 3, 3 ,3];
#     let k = 2;
#     let res = binary_search_last_valid(list, k);
#     println!("Result: {:?}", res);
# }
#
fn binary_search_last_valid(list: Vec<i32>, target: i32) -> usize {
    fn check(list: &Vec<i32>, mid: usize, target: i32) -> bool {
        list[mid] <= target
    }

    let mut left = 0;
    let mut right = list.len();

    while left < right {
        let mid = left + (right - left + 1) / 2;
        if check(&list, mid, target) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }

    left
}
```


## Search for the exact index of a valid element

```
  0   1   2   3   4   5   6   7   8   9
 --- --- --- --- --- --- --- --- --- ---
| 0 | 0 | 1 | 1 | 1 | 1 | 2 | 3 | 3 | 3 |
 --- --- --- --- --- --- --- --- --- ---
                          ^
                          |
                        target
```

The first approach is to use the rust built-in binary search method of a `Vec`

```rust
let list = vec![0, 0, 1, 1, 1, 1, 2, 3, 3 ,3];
let target = 2;
let res = list.binary_search(&target);
println!("Result: {:?}", res); // Ok(6)
```

Another benefit is the built in binary search method will also yield the location where the given value should be inserted to keep the `Vec` in the sorted order.

```rust
let list = vec![0, 0, 1, 1, 1, 1, 3, 3, 3 ,3];
let target = 2;
let res = list.binary_search(&target);
println!("Result: {:?}", res); // Err(6)
```

Let's see how can we adapt the "Search for the first index of the valid value" to do the same as the above built-in binary search function.

```rust
# fn main() {
#    let list = vec![0, 0, 1, 1, 2, 3, 3, 3, 3, 3];
#    let k = 2;
#    let res = binary_search(list, k);
#    println!("Search for 2 in the list [0, 0, 1, 1, 2, 3, 3, 3, 3, 3]");
#    println!("Result: {:?}", res);
#
#    let list = vec![0, 0, 1, 1, 2, 3, 3, 3, 3, 3];
#    let k = 4;
#    let res = binary_search(list, k);
#    println!("Search for 4 in the list [0, 0, 1, 1, 2, 3, 3, 3, 3, 3]");
#    println!("Result: {:?}", res);
# }
#
fn binary_search(list: Vec<i32>, target: i32) -> Result<usize, usize> {
    fn check(list: &Vec<i32>, mid: usize, target: i32) -> bool {
        list[mid] >= target
    }

    let mut left = 0;
    let mut right = list.len();

    while left < right {
        let mid = left + (right - left) / 2;
        if check(&list, mid, target) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    if left < list.len() {
        Ok(left)
    } else {
        Err(left)
    }
}
```