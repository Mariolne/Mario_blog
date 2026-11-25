---
title: "两数之和 (LeetCode 1)"
date: 2026-11-17T09:00:00+08:00
draft: false
tags: ["Hash Table", "Array"]
summary: "暴力是 O(n²)。用哈希表边扫边查补数，一次遍历降到 O(n)。"
ShowToc: true
TocOpen: false
---

## 题目大意

给定整数数组 `nums` 和目标值 `target`，找出和为 `target` 的两个下标（每个元素只用一次，答案唯一存在）。

## 思路

关键不在"找两个数"，而在于把"查另一个数"变成 O(1)。

遍历到 `nums[i]` 时，需要的是 `target - nums[i]`。这个值如果之前出现过，答案就有了；没出现就把 `nums[i]` 记进哈希表 `值 -> 下标`，继续往后走。

之所以**边遍历边插入**而不是先全插一遍：题目不允许同一元素用两次，"先查后插"天然回避了元素和自己配对的情况。

## 复杂度

- 时间：O(n)，每个元素查一次哈希表
- 空间：O(n)，最坏情况存下全部元素

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

Python 版本，思路一致：

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

- 先插后查会让 `[3,3]` 退化成 `[i, i]` 自己配自己，必须**先查后插**；
- 返回的是**下标**不是数值；
- 有重复元素时（如 `[3,3]`）先全插的哈希表只保留最后一个下标，但先查后插在第一对答案出现时就返回了，不受影响。
