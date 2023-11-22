# Problem

You are planning to hike on a mountain and have a backpack with a maximum weight capacity, W, that you can carry. There are several items you want to take on the hike, each with a weight and an associated value. However, you cannot take all the items as the backpack has limited capacity.
Your goal is to determine which items to select to maximize the total value of the items taken, respecting the maximum capacity of the backpack. Write a program to help make this decision.

# Input:

- A list of N items, where each item is represented by a pair of values (weight, value).
- The maximum capacity of the backpack, W.

# Output:

- The list of items you should take in the backpack to maximize the total value, represented by their indices in the input item list.

# Example:

Input:

```python
items = [(2, 10), (3, 7), (4, 13), (5, 17)]
weight_capacity = 10
```

Output:

```python
Selected items: [(2, 10), (3, 7), (5, 17)]
Total value: 34
```
