---
title: "比赛题解：A – H"
date: 2026-11-26T15:30:00+08:00
draft: false
tags: ["题解", "贪心", "双指针"]
summary: "八道题：构造、模拟、贪心、排序、博弈、双指针。"
ShowToc: true
TocOpen: true
---

## A. 构造C的歪

等差，直接计算公差，加上即可.

```cpp
void __(){
    int a, b;
    cin >> a >> b;
    cout << b + (b - a) << "\n";
}
```

## B. hanayo和米饭

正常模拟就好

```cpp
void __(){
    int n, x, b[N];
    cin >> n;
    for(int i = 1; i <= n; i ++) b[i] = 1;
    for(int i = 1; i < n; i ++) cin >> x, b[x] = 0;
    for(int i = 1; i <= n; i ++) {
        if(b[i] == 1) {
            cout << i;
            return;
        }
    }
}
```

## C. 清楚姐姐买竹鼠

就三种情况，1.全部一只一只买， 2.先3只买，如果有剩下，就一只只买， 3.全三只三只的买，但多买一些，因为是至少x只。
然后，3为什么要考虑呢，就是你看2的情况，假如5只，买一次3只，还剩2只，我们可以选择直接花b买3只，也可以换2个a买两只。

```cpp
void __(){
    int a, b, x;
    cin >> a >> b >> x;
    cout << min({x * a, x / 3 * b + x % 3 * a, (x / 3 + 1) * b});
}
```

## D. 小红的天平

那边重往那边取，从大的开始取即可。

```cpp
void __(){
    int n, m, s1 = 0, s2 = 0;
    int a[N], b[N];
    cin >> n >> m;
    for(int i = 1; i <= n; i ++) cin >> a[i], s1 += a[i];
    for(int i = 1; i <= m; i ++) cin >> b[i], s2 += b[i];
    sort(a + 1, a + n + 1);
    sort(b + 1, b + m + 1);
    int ans = 0;
    if(s1 > s2){
        int j = n;
        while(s1 > s2 && j >= 1){
            s1 -= a[j --];
            ans ++;
        }
    }
    else if(s2 > s1){
        int j = m;
        while(s2 > s1 && j >= 1){
            s2 -= b[j --];
            ans ++;
        }
    }
    else if(s1 == s2) ans = 1;
    
    cout << ans << "\n";
}
```

## E. 小紫的劣势博弈

博弈题中，两个人都足够聪明，小红先手，所以出现的情况肯定是，小红先选最大的，小紫选第二大，然后一直下去。

```cpp
void __(){
    int n, ans = 0;
    int a[N];
    cin >> n;
    for(int i = 1; i <= n; i ++) cin >> a[i];
    sort(a + 1, a + 1 + n);
    int j = n;
    for(int i = 1; i <= n; i += 2){
        ans += a[i];
    }
    for(int i = 2; i <= n; i += 2){
        ans -= a[i];
    }
    cout << ans;
}  
```

## F. 做游戏

贪心的想，只要每一次都是牛牛能赢的都赢，那么，对应好，加起来即可。

```cpp
void __(){
    int a, b, c, x, y, z;
    cin >> a >> b >> c >> x >> y >> z;
    cout << min(a, y) + min(b, z) + min(c, x) << "\n";
}
```

## G. 小红的字符串

回文，只需要考虑每个对应位置的最小变换即可，要么s[i]变成s[j], 或者s[j]变s[i].

```cpp
void __(){
    string s;
    cin >> s;
    int n = s.size();
    s = ' ' + s;
    int i = 1, j = n;
    int p = 0, q = 0;
    for(; i < j; i ++, j --){
        p += (s[j] - s[i] + 26) % 26;
        q += (s[i] - s[j] + 26) % 26;
    }
    cout << min(p, q);
}
```

## H. 字符串

双指针

首先，计算所有想写字母种类的个数
接下来用双指针不断进行优化，找到最小值
j为更快的，跑在前面的，每一次，我们先累加s[j]
(这里我们将a .. z映射成0 .. 25)
当st的个数等于m，也就是满足当前字串含有的所有字符串s的所有小写字母时，进行更新答案。
同时，我们要移动更慢的指针i，讲s[i]减去，不断缩紧区间，找到更小的答案。

```cpp
#include<bits/stdc++.h>
using namespace std;
#define int long long
#define i128 __int128
#define lowbit(x) ((x) & -(x))
#define lson(x) ((x) << 1)
#define rson(x) (((x) << 1) | 1)
using pii = pair<int, int>;  
using tii = tuple<int, int, int>;     
const int N = 1000 * 1000 + 4, M = 998244353, P = 1e9 + 7;
const int INF = 0x3f3f3f3f3f3f3f3fLL;
string s;
int p[26];
void __(){
    cin >> s;
    int n = s.size();
    unordered_set<char> st;
    for(char c : s) st.insert(c);
    int m = st.size();
    st.clear();
    int i = 0, j = 0, ans = 1e18;
    while(j < n){
        int c = s[j] - 'a';
        p[c] ++;
        st.insert(s[j]);
        while(i <= j && st.size() == m){
            ans = min(ans, j - i + 1);
            p[s[i] - 'a'] --;
            if(p[s[i] - 'a'] == 0){
                st.erase(s[i]);
                i ++;
                break;
            } 
            i ++;
            ans = min(ans, j - i + 1);
        }
        j ++;
    }
    cout << ans << "\n";
}
signed main(){
    ios::sync_with_stdio(false), cin.tie(0), cout.tie(0);
    int _ = 1;
    // cin >> _;
    while(_ --)
      __();
    return 0;
}
```

## 约定

```cpp
#include<bits/stdc++.h>
using namespace std;
#define int long long
#define i128 __int128
#define lowbit(x) ((x) & -(x))
#define lson(x) ((x) << 1)
#define rson(x) (((x) << 1) | 1)
using pii = pair<int, int>;  
using tii = tuple<int, int, int>;     
const int N = 1000 * 1000 + 4, M = 998244353, P = 1e9 + 7;
const int INF = 0x3f3f3f3f3f3f3f3fLL;
void __(){
    
}
signed main(){
    ios::sync_with_stdio(false), cin.tie(0), cout.tie(0);
    int _ = 1;
    // cin >> _;
    while(_ --)
      __();
    return 0;
}
```
