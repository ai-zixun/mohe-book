# Two Dimensional Matrix

## Valid Neighbors

```rust
fn get_neighbor(
    board: &Vec<Vec<char>>,
    row_idx: usize,
    col_idx: usize,
) -> Vec<(usize, usize)> {
    let mut neighbor = vec![];

    let row_len = board.len();
    let col_len = board[0].len();

    if row_idx > 0 {
        neighbor.push((row_idx - 1, col_idx));
    }

    if col_idx > 0 {
        neighbor.push((row_idx, col_idx - 1));
    }

    if row_idx + 1 < row_len {
        neighbor.push((row_idx + 1, col_idx));
    }

    if col_idx + 1 < col_len {
        neighbor.push((row_idx, col_idx + 1));
    }

    neighbor
}
```