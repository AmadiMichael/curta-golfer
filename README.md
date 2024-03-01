## Curta golf solutions

- Golf 1: Log10
- Golf 2: Factorial
  - Costs a constant 82 gas per factorial of numbers > 1 and < 58,
  - Costs a constant 43 gas for numbers 0 and 1.
  - Costs a constant 55 gas per factorial >= 58 which also reverts because their factorial is > 256 bits
