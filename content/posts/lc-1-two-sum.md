---
title: "LeetCode 1. 两数之和"
date: 2026-11-25T21:00:00+08:00
draft: false
tags: ["哈希表", "数组"]
categories: ["LeetCode"]
summary: "暴力两重循环是 O(n²)，用哈希表边遍历边查补数，一次扫描降到 O(n)。"
ShowToc: true
TocOpen: true
---

## 题意

给定整数数组 `nums` 和目标值 `target`，找出和等于 `target` 的两个下标（每个元素只能用一次，答案唯一）。

## 思路

关键不在"找两个数"，而在于把"查另一个数"变成 O(1)。

遍历到 `nums[i]` 时，需要的是 `target - nums[i]`。如果之前出现过这个值，答案就有了；没有就把 `nums[i]` 记下来。用 `unordered_map<值, 下标>` 存已遍历过的数即可。

之所以是**边遍历边插入**而不是先全插一遍，是因为题目要求同一个元素不能用两次——先查后插天然回避了自己配自己的情况。

## 复杂度

- 时间：O(n)，每个元素查一次哈希表
- 空间：O(n)，最坏情况要存下全部元素

## 代码

```cpp
class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        unordered_map<int, int> pos;   // 值 -> 下标
        for (int i = 0; i < (int)nums.size(); ++i) {
            auto it = pos.find(target - nums[i]);
            if (it != pos.end()) return {it->second, i};  // 先查
            pos[nums[i]] = i;                             // 后插
        }
        return {};
    }
};
```

Python 版本更短，思路一致：

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

## 易错点

- 先插后查会返回 `[i, i]`，自己和自己配对，必须**先查后插**；
- 返回的是**下标**不是数值；
- 有重复元素时（如 `[3,3]`）哈希表后插会覆盖前一个下标，但因为先查，第一对答案已经返回，不影响结果。

> AI生成
