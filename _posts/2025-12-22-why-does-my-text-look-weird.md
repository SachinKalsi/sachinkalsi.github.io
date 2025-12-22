---
layout: post
title: "A Simple Guide to Unicode and \\xa0"
date: 2025-12-22
author: "Sachin Kalsi"
---
## Why Does My Text Look Weird?

Have you ever copied text from a website and found strange symbols like `\xa0` in your data? Or noticed that searching for `resume` does not find `résumé`? These problems happen because of **Unicode**, a system computers use to understand text.

---

### 1. What is `\xa0`?

The symbol `\xa0` is a special kind of space called a **Non-Breaking Space**. A regular space tells the computer: "You can start a new line here if there is no space". **`\xa0`** tells the computer "Keep these two words together on the same line no matter what."

You mostly see this in web scraping because websites would like to keep things together like "42 Kg" or "Rs 2000".

---

### 2. One Character, Two Ways to Type It

The same letter can be written in different ways. `é` could be, for a computer, a single character OR an `e` plus a `floating accent` character. And if we don't normalise these, it could become problematic.

---

### 3. Normalization

There are 4 different ways (settings?) for "cleaning" the text:

#### 1. NFC (Normalization Form Composition)
It combines characters like `e` & `´` into `é`.

#### 2. NFD (Normalization Form Decomposition)
This does the opposite. It splits `é` into `e` and `´`. This is how Mac computers save files.

#### 3. NFKD (Normalization Form Compatibility Decomposition)
It splits `²` (squared) into a regular `2`, and it turns `½` into `1/2`. Use this to remove accents.

#### 4. NFKC (Normalization Form Compatibility Composition)
This is like NFKD but merges the accent at the end. It simplifies symbols (turning `²` into `2`), but it keeps the `é` as a single character. Would be useful in AI and Machine Learning.

**Note:** Whether `NFKD` is better than `NFKC` depends entirely on whether you consider the accent to be "signal" or "noise"!

---

## How to do it in Python?

```
import unicodedata

text = "machine\xa0learning!" # Text with a non-breaking space
clean_text = unicodedata.normalize('NFKC', text)

print(clean_text) # "machine learning!" (The \xa0 is now a normal space)
```