# Math

## Greatest Common Divisor

```rust
# fn main() {
#     println!("gcd of 10 and 5  is {}", greatest_common_divisor(10, 5));
#     println!("gcd of 11 and 22 is {}", greatest_common_divisor(11, 22));
#     println!("gcd of 44 and 63  is {}", greatest_common_divisor(44, 63));
#     println!("gcd of 44 and 64  is {}", greatest_common_divisor(44, 64));
# }

fn greatest_common_divisor(a: i32, b: i32) -> i32 {
    if b != 0 {
        greatest_common_divisor(b, a % b)
    } else {
        a
    }
}
```

## Least Common Multiple

```rust
# fn main() {
#     println!("lcm of 10 and 5  is {}", least_common_multiple(10, 5));
#     println!("lcm of 11 and 22 is {}", least_common_multiple(11, 22));
#     println!("lcm of 44 and 63  is {}", least_common_multiple(44, 63));
#     println!("lcm of 44 and 64  is {}", least_common_multiple(44, 64));
# }
#
# fn greatest_common_divisor(a: i32, b: i32) -> i32 {
#     if b != 0 {
#         greatest_common_divisor(b, a % b)
#     } else {
#         a
#     }
# }
#
fn least_common_multiple(a: i32, b: i32) -> i32 {
    a * b / greatest_common_divisor(a, b)
}
```

## Fraction Comparison / Slope Comparison

When comparing `a/b` and `x/y` in computer science, we can use a floating point (`f64` in rust or `double` in java). Nevertheless, due to the limited precision of IEEE 754-1985 / IEEE 754-2008 floating point standard, directly checking `a / b == x / y` might not yield the correct result. Hence, we have two alternative approaches:

1. **Cross Product**

    Instead of checking `a / b == x / y`, we can check `a * y == x * b`.

2. **GDC Slope**

    If `a / b` and `x / y` represent the same slope, then `a / gcd(a, b) == x / gcd(x, y)` and `b / gcd(a, b) == y / gcd(x, y)` must be true.

```rust
# fn gcd(a: i128, b: i128) -> i128 {
#     if b != 0 { gcd(b, a % b) } else { a }
# }
# let (a, b) = (1, 1);
# let (x, y) = (999999999999999999, 1000000000000000000);
#
println!("a: {}", a);
println!("b: {}", b);
println!("x: {}", x);
println!("y: {}", y);

let equal = a as f64 / b as f64 == x as f64 / y as f64;
let equal_cross_product = a * y == x * b;
let equal_gdc = a / gcd(a, b) == x / gcd(x, y) && b / gcd(a, b) == y / gcd(x, y);

println!("Standard approach:      {}", equal);
println!("Cross product approach: {}", equal_cross_product);
println!("GDC approach:           {}", equal_gdc);
```
