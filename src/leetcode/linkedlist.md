# LinkedList

Let's first take a look at how LeetCode define the LinkedList in rust

```rust
#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}
```

As LeetCode is using `Box` as the pointer to point to the next node. It does not allow multiple reference to the same node and does not allow interior mutability. Hence, to make our life easier, we would like to change the `ListNode` definition to:

```rust
#[derive(PartialEq, Eq, Clone, Debug)]
pub struct MutListNode {
    pub val: i32,
    pub next: Option<Rc<RefCell<MutListNode>>>,
}
```

* With `Rc<T>`, we allow multiple ownership to the same `MutListNode`
* With `RefCell<T>`, we allow interior mutability for the heap allocated `MutListNode`

To convert between the LeetCode official `ListNode` and the mutable multi-referencing `MutListNode` we would need the following conversion utility functions

From `Option<Box<ListNode>>` to `Option<Rc<RefCell<MutListNode>>>`
```rust
fn to_mut_list_node(node: Option<Box<ListNode>>) -> Option<Rc<RefCell<MutListNode>>> {
    match node {
        None => None,
        Some(node) => Some(Rc::new(RefCell::new(MutListNode {
            val: node.val,
            next: to_mut_list_node(node.next),
        }))),
    }
}
```

From `Option<Rc<RefCell<MutListNode>>>` to `Option<Box<ListNode>>`
```rust
fn to_list_node(node: Option<Rc<RefCell<MutListNode>>>) -> Option<Box<ListNode>> {
    match node {
        None => None,
        Some(node) => Some(Box::new(ListNode {
            val: node.borrow().val,
            next: to_list_node(node.borrow().next.clone()),
        })),
    }
}
```

## Source Code
```rust
#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}

impl ListNode {
    #[inline]
    fn new(val: i32) -> Self {
        ListNode { next: None, val }
    }
}

#[derive(PartialEq, Eq, Clone, Debug)]
pub struct MutListNode {
    pub val: i32,
    pub next: Option<Rc<RefCell<MutListNode>>>,
}

impl MutListNode {
    #[inline]
    fn new(val: i32) -> Self {
        MutListNode { next: None, val }
    }
}

fn to_mut_list_node(node: Option<Box<ListNode>>) -> Option<Rc<RefCell<MutListNode>>> {
    match node {
        None => None,
        Some(node) => Some(Rc::new(RefCell::new(MutListNode {
            val: node.val,
            next: to_mut_list_node(node.next),
        }))),
    }
}

fn to_list_node(node: Option<Rc<RefCell<MutListNode>>>) -> Option<Box<ListNode>> {
    match node {
        None => None,
        Some(node) => Some(Box::new(ListNode {
            val: node.borrow().val,
            next: to_list_node(node.borrow().next.clone()),
        })),
    }
}

fn vec_to_linked_list(vec: Vec<i32>) -> Option<Box<ListNode>> {
    let mut root = ListNode::new(0);
    let mut curr = &mut root;
    for n in vec {
        curr.next = Some(Box::new(ListNode::new(n)));
        curr = curr.next.as_mut().unwrap();
    }

    root.next
}

fn linked_list_to_vec(node: Option<Box<ListNode>>) -> Vec<i32> {
    let mut vec = vec![];

    let mut curr = node;
    while curr != None {
        vec.push(curr.as_ref().unwrap().val);
        curr = curr.unwrap().next;
    }

    vec
}

fn vec_to_mut_linked_list(vec: Vec<i32>) -> Option<Rc<RefCell<MutListNode>>> {
    let root = Rc::new(RefCell::new(MutListNode::new(0)));
    let mut curr = root.clone();
    for n in vec {
        curr.borrow_mut().next = Some(Rc::new(RefCell::new(MutListNode::new(n))));
        let next = curr.borrow().next.clone().unwrap();
        curr = next;
    }

    let node = root.borrow().next.clone();
    node
}

fn mut_linked_list_to_vec(node: Option<Rc<RefCell<MutListNode>>>) -> Vec<i32> {
    let mut res = vec![];

    let mut curr = node;
    while let Some(curr_node) = curr {
        res.push(curr_node.borrow().val);
        curr = curr_node.borrow().next.clone();
    }

    res
}
```