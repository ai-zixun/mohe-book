# Union Find

```rust
struct UnionFind {
    parents: Vec<usize>,
}

impl UnionFind {
    fn new(len: usize) -> Self {
        UnionFind {
            parents: (0..len).collect(),
        }
    }

    fn find(&mut self, node: usize) -> usize {
        if self.parents[node] == node {
            node
        } else {
            self.parents[node] = self.find(self.parents[node]);
            self.parents[node]
        }
    }

    fn union(&mut self, a: usize, b: usize) {
        let a = self.find(a);
        let b = self.find(b);

        self.parents[a] = b;
    }
}

```