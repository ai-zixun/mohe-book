# Rust BTreeMap and BTreeSet

In rust
* the `std::collections::BTreeMap` is the implementation of a sorted map.
* the `std::collections::BTreeSet` is the implementation of a sorted set.

## Floor and Ceil

### Floor: The Entry with the Greatest Key that is Less or Equal to a Given Key

```rust
map.range(..=key).next_back().unwrap();
```

### Ceil: The Entry with the Least key that is Greater or Equal to a Given Key
```rust
map.range(key..).next().unwrap();
```

### First
```rust
let set = BTreeSet::from([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
// unstable approach: need `#![feature(map_first_last)]` feature flag
println!("{:?}", set.first());
// current approach:
println!("{:?}", set.range(..).next());
```
### Last

```rust
let set = BTreeSet::from([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
// unstable approach: need `#![feature(map_first_last)]` feature flag
println!("{:?}", set.last());
// current approach:
println!("{:?}", set.range(..).next_back());
```

### Remove all elements in a given range

*NOTE: This might not be the most idiomatic rust approach*

Instead of removing elements from the range one by one, we have to filter out of the element in the range and then re-create the tree-map.

```rust
use std::collections::BTreeMap;

fn main() {
    let mut map: BTreeMap<usize, usize> = BTreeMap::new();
    map.insert(10, 10);
    map.insert(20, 20);
    map.insert(30, 30);
    map.insert(40, 40);
    map.insert(50, 50);

    map = map
        .into_iter()
        .filter(|(key, _)| *key < 20 || *key >= 40)
        .collect();

    println!("{:?}", map);
}

```


### How does it work?
```rust
pub fn range<T, R>(&self, range: R) -> Range<'_, K, V>
```

BTreeMap has an range method that takes a range as input and will output all the entries from the map with a key that is within the given range.

```rust
# use std::collections::BTreeSet;
#
# fn main() {
let set = BTreeSet::from([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);

// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
let res = set.range(..);
println!("{:?}", res);

// [5, 6, 7, 8, 9]
let res = set.range(5..);
println!("{:?}", res);

// [0, 1, 2, 3, 4]
let res = set.range(..5);
println!("{:?}", res);

// [0, 1, 2, 3, 4, 5]
let res = set.range(..=5);
println!("{:?}", res);

// [4, 5, 6]
let res = set.range(4..=6);
println!("{:?}", res);
# }
```