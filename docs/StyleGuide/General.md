# General Rules
Following rules apply to all sort of files and programming languages.

## When not to adhere to the style guide
Some files will not follow the naming / style guide, usually for history reasons.
If you encounter code that is clearly written in a different style, try to adhere the existing style for this file.

## Boyscout principle
Try to leave code that you are working with in a better state as you found it.
* DO improve code you are working on
* DO NOT cleanup or improve code that are not related to your current change (R# syndrome)

## Do not to exceed column 100
This is our variant of [Mark Seemans's 80/24](https://blog.ploeh.dk/2019/11/04/the-80-24-rule/) rule.

As a general rule try to orchestrate your code from smaller, meaningful chunks.

Also, code should be written to allow side-by-side diffs for better reasoning about changes.

* AVOID writing code that exceed column 100
* CONSIDER refactoring functions / methods that consist of more around 24 lines of code

## Do not shorten code, just because you can
There are tons of language features, that allow you to write code in a very consice way. But, just because you can, this does not mean you have to.
Code should always be easy to read, even if it takes some more lines of code!

## Code Comments
Well written code should be self-explanatory on _what_ it does.
There should be no reason to comment _what_ code does.
However, it is not always obvious _why_ the code is in place.

* DO comment _why_ code does something
* DO NOT comment _what_ the code does.

## Avoid Section Comments
In most cases section comments are good indicator where you could have broken down you code into smaller pieces of code.

* CONSIDER to refactor code to smaller chunks before writing section comments.

## Compiler Warnings
The compiler is your friend.
A compiler warning is usually a sign that you will run into problems.
If you need to keep the code as is, suppress the warning and provide a comment _why_ the warning has been supressed.

* DO resolve as many warnings as possible
* DO comment why a warning is suppressed
