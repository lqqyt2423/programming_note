# Python 基础知识点

## string

```python
name = "li qiang"
name.title() => "Li Qiang"
name.upper()
name.lower()

name.strip()
name.rstrip()
name.lstrip()
```

## number

```python
# number to string
age = 23
str(age) => "23"

int('23') => 23
```

## list

```python
a = [1, 2, 3]
a.append(4)

a.insert(0, 0)

del a[0]

b = a.pop()
b = a.pop(0)

# 删除值
a.remove(3)

a.sort()
a.sort(reverse=True)

b = sorted(a)
b = sorted(a, reverse=True)

a.reverse()

len(a)


for i in a:
    print(i)

for i in range(1, 5):
    print(i)

a = list(range(10))

max(a)
min(a)
sum(a)

# 列表解析
b = [i*2 for i in a]

# 切片
b = a[0:3]
b = a[:3]
b = a[2:]
b = a[-3:]
# 复制列表
b = a[:]

# 集合
set(a)
```

## 元组

```python
a = (100, 50)
```

## 字典

```python
a = { 'name': 'lq', 'age': 24 }
a['name']
a['age']

del a['age']

for key, value in a.items():
    print(key, value)

for key in a:
    print(key)

for key in a.keys():
    print(key)

for value in a.values():
    print(value)
```

## 用户输入

```python
msg = input('please input something')
```

## function

```python
# 接受任意数量的参数
# args 元组
def func(*args):
    for i in args:
        print(i)

# 关键词实参
def build_profile(first, last, **user_info):
    do something

**user_info 字典
```

## file

```python
# read
with open('1.txt') as x:
    contents = x.read()
    print(contents)

# read line
with open('1.txt') as x:
    for line in x:
        print(line)

# write
with open('1.txt', 'w') as x:
    x.write('hello world\n')

# json dump
import json
a = [1, 2, 3]
while open('1.txt', 'w') as x:
    json.dump(a, x)

# json load
import json
while open('1.txt') as x:
    c = json.load(x)
```
