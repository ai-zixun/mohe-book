# Segment Tree Range Sum

```rust
use std::{
    cmp::Ordering,
    collections::{BinaryHeap, HashMap, HashSet},
    fmt::{Binary, Debug},
};

fn main() {
    let vec = vec![1, 3, 5];

    let mut num_array = NumArray::new(vec);
    println!("{:?}", num_array.sum_range(0, 2));
    println!("{:?}", num_array.update(1, 2));
    println!("{:?}", num_array.sum_range(0, 2))
}

struct SegmentTreeNode<'a, T> {
    left_node: Option<Box<SegmentTreeNode<'a, T>>>,
    right_node: Option<Box<SegmentTreeNode<'a, T>>>,
    left_index: usize,
    right_index: usize,
    info: T,
    operation: &'a dyn Fn(&T, &T) -> T,
}

impl<'a, T> Debug for SegmentTreeNode<'a, T>
where
    T: Debug,
{
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("SegmentTreeNode")
            .field("left_node", &self.left_node)
            .field("right_node", &self.right_node)
            .field("left_index", &self.left_index)
            .field("right_index", &self.right_index)
            .field("info", &self.info)
            .finish()
    }
}

impl<'a, T> SegmentTreeNode<'a, T>
where
    T: Copy + Debug,
{
    fn new_from_vec(vec: Vec<T>, operation: &'a dyn Fn(&T, &T) -> T) -> Self {
        let left_index = 0;
        let right_index = vec.len() - 1;
        Self::new_from_slice(&vec, left_index, right_index, operation)
    }

    fn new_from_slice(
        slice: &[T],
        left_index: usize,
        right_index: usize,
        operation: &'a dyn Fn(&T, &T) -> T,
    ) -> Self {
        if left_index == right_index {
            SegmentTreeNode {
                left_node: None,
                right_node: None,
                left_index,
                right_index,
                info: slice[0],
                operation,
            }
        } else {
            let mid_index = (left_index + right_index) / 2;
            let left_node = Self::new_from_slice(
                &slice[0..=(mid_index - left_index)],
                left_index,
                mid_index,
                operation,
            );
            let right_node = Self::new_from_slice(
                &slice[(mid_index - left_index + 1)..=(right_index - left_index)],
                mid_index + 1,
                right_index,
                operation,
            );

            let info = operation(&left_node.info, &right_node.info);

            SegmentTreeNode {
                left_node: Some(Box::new(left_node)),
                right_node: Some(Box::new(right_node)),
                left_index,
                right_index,
                info,
                operation,
            }
        }
    }

    fn update_index(&mut self, index: usize, info: T) {
        if self.left_index == index && self.right_index == index {
            self.info = info;
        }

        match (&mut self.left_node, &mut self.right_node) {
            (Some(left_node), Some(right_node)) => {
                if left_node.right_index >= index {
                    left_node.update_index(index, info);
                } else {
                    right_node.update_index(index, info);
                }
                self.info = (self.operation)(&left_node.info, &right_node.info);
            }
            _ => (),
        }
    }

    fn range_operation(&self, left_index: usize, right_index: usize) -> T {
        if left_index < self.left_index || right_index > self.right_index {
            panic!("indexes out of range")
        }

        if left_index == self.left_index && right_index == self.right_index {
            return self.info;
        }

        match (&self.left_node, &self.right_node) {
            (Some(left_node), Some(right_node)) => {
                if right_index <= left_node.right_index {
                    left_node.range_operation(left_index, right_index)
                } else if left_index >= right_node.left_index {
                    right_node.range_operation(left_index, right_index)
                } else {
                    (self.operation)(
                        &left_node.range_operation(left_index, left_node.right_index),
                        &right_node.range_operation(right_node.left_index, right_index),
                    )
                }
            }
            (Some(left_node), None) => left_node.range_operation(left_index, right_index),
            (None, Some(right_node)) => right_node.range_operation(left_index, right_index),
            (None, None) => unreachable!(),
        }
    }
}

struct NumArray<'a> {
    node: SegmentTreeNode<'a, i32>,
}

impl NumArray<'_> {
    fn new(nums: Vec<i32>) -> Self {
        NumArray {
            node: SegmentTreeNode::new_from_vec(nums, &|a: &i32, b: &i32| a + b),
        }
    }

    fn update(&mut self, index: i32, val: i32) {
        self.node.update_index(index as usize, val)
    }

    fn sum_range(&self, left: i32, right: i32) -> i32 {
        self.node.range_operation(left as usize, right as usize)
    }
}

```

## Segment Tree Min Index

```rust
use std::{
    fmt::Debug,
    cmp::{Ordering, Reverse},
    collections::{BinaryHeap, HashMap, HashSet},
    fmt::Binary,
    hash::Hash,
};

fn main() {
    let  target = vec![1,2,3,2,1];
    let res = Solution::min_number_operations(target);
    println!("{:?}", res);
}

struct Solution;

impl Solution {
    pub fn min_number_operations(target: Vec<i32>) -> i32 {
        let root = SegmentTreeNode::new_from_vec(&target);
        Self::dfs(0, target.len() - 1, 0, &root, &target)
    }

    fn dfs(left_idx: usize, right_idx:usize, base: i32, root: &SegmentTreeNode, target: &Vec<i32>) -> i32 {
        if right_idx < left_idx {
            return 0;
        }
        if left_idx == right_idx {
            return target[left_idx] - base;
        }

        let (min_idx, min_val) = root.query_range_min(left_idx, right_idx);
        let mut res = min_val - base;
        if min_idx > 0 { res += Self::dfs(left_idx, min_idx - 1, min_val, root, target); }
        res += Self::dfs(min_idx + 1, right_idx, min_val, root, target);

        res
    }
}


#[derive(Debug)]
struct SegmentTreeNode {
    left_node: Option<Box<SegmentTreeNode>>,
    right_node: Option<Box<SegmentTreeNode>>,
    left_index: usize,
    right_index: usize,
    min_idx: usize,
    min_val: i32,
}

impl SegmentTreeNode{
    fn new_from_vec(vec: &Vec<i32>) -> Self {
        let left_index = 0;
        let right_index = vec.len() - 1;
        Self::new_from_slice(&vec, left_index, right_index)
    }

    fn new_from_slice(
        slice: &[i32],
        left_index: usize,
        right_index: usize,
    ) -> Self {
        if left_index == right_index {
            SegmentTreeNode {
                left_node: None,
                right_node: None,
                left_index,
                right_index,
                min_idx: left_index,
                min_val: slice[0],
            }
        } else {
            let mid_index = (left_index + right_index) / 2;
            let left_node = Self::new_from_slice(
                &slice[0..=(mid_index - left_index)],
                left_index,
                mid_index,
            );
            let right_node = Self::new_from_slice(
                &slice[(mid_index - left_index + 1)..=(right_index - left_index)],
                mid_index + 1,
                right_index,
            );

            let (min_idx, min_val) = if left_node.min_val < right_node.min_val {
                (left_node.min_idx, left_node.min_val)
            } else {
                (right_node.min_idx, right_node.min_val)
            };

            SegmentTreeNode {
                left_node: Some(Box::new(left_node)),
                right_node: Some(Box::new(right_node)),
                left_index,
                right_index,
                min_idx,
                min_val,
            }
        }
    }

    fn query_range_min(&self, left_index: usize, right_index: usize) -> (usize, i32) {
        if right_index < self.left_index || left_index > self.right_index {
            (usize::MAX, i32::MAX)
        } else if left_index <= self.left_index && right_index >= self.right_index {
            (self.min_idx, self.min_val)
        } else {
            let (left_min_idx, left_min_val) = self.left_node.as_ref().unwrap().query_range_min(left_index, right_index);
            let (right_min_idx, right_min_val) = self.right_node.as_ref().unwrap().query_range_min(left_index, right_index);
            if left_min_val < right_min_val {
                (left_min_idx, left_min_val)
            } else {
                (right_min_idx, right_min_val)
            }
        }
    }
}

```