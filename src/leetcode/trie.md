# Trie

```rust
#[derive(Debug)]
struct Trie {
    value: char,
    children: HashMap<char, Trie>,
}

impl Trie {
    fn new(value: char) -> Trie {
        Trie {
            value,
            children: HashMap::new(),
        }
    }

    fn from_vec_string(words: Vec<String>) -> Trie {
        let mut root = Trie::new(' ');
        words.into_iter().for_each(|word| root.add_string(word));
        root
    }

    fn from_vec_vec_char(words: &Vec<Vec<char>>) -> Trie {
        let mut root = Trie::new(' ');
        words.iter().for_each(|word| root.add_vec_char(word));
        root
    }

    fn add_string(&mut self, word: String) {
        let word = word.chars().collect();
        self.add_vec_char(&word)
    }

    fn add_vec_char(&mut self, word: &Vec<char>) {
        let mut node = self;
        for character in word.iter() {
            node = node
                .children
                .entry(*character)
                .or_insert(Trie::new(*character))
        }
    }
}
```