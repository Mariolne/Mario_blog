---
title: "Two Sum"
date: 2026-11-17T09:00:00+08:00
draft: false
tags: ["Hash Table", "Array"]
summary: "Brute force is O(n²). Hash the seen values and look up the complement as you scan: one pass, O(n)."
ShowToc: true
TocOpen: false
---

## Problem

Given an integer array `nums` and a target `target`, return the indices of the two numbers that add up to `target` (each element used once, exactly one answer exists).

## Approach

The trick isn't "finding two numbers" — it's making "look up the other number" O(1).

At each `nums[i]`, what you need is `target - nums[i]`. If that value appeared before, you're done; otherwise record `nums[i]` in a hash map `value -> index` and move on.

Why insert **as you scan** instead of pre-filling the map: an element can't pair with itself. Check-then-insert rules that case out by construction.

## Complexity

- Time: O(n) — one hash lookup per element
- Space: O(n) — worst case the map holds every element

## Code

```cpp
class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        unordered_map<int, int> pos;   // value -> index
        for (int i = 0; i < (int)nums.size(); ++i) {
            auto it = pos.find(target - nums[i]);
            if (it != pos.end()) return {it->second, i};  // check first
            pos[nums[i]] = i;                             // insert after
        }
        return {};
    }
};
```

Python version, same idea:

```python
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        seen = {}
        for i, x in enumerate(nums):
            if target - x in seen:
                return [seen[target - x], i]
            seen[x] = i
        return []
```

## Pitfalls

- Insert before checking and `[3,3]` degenerates to `[i, i]` — always **check then insert**;
- The answer wants **indices**, not values;
- With duplicates (e.g. `[3,3]`) a pre-filled map keeps only the last index, but check-then-insert returns the first valid pair before that ever matters.

> AI生成
