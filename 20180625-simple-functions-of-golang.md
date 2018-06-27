# 学习golang之一些小函数记录

## 连续输出1-100内的数字

```go
func main() {
  i := 1
  for {
    if i > 100 {
      break
    }
    fmt.Println(i)
    i = i + 1
  }
}
```

```go
func main() {
  s := make([]int, 100)
  for k := range s {
    fmt.Println(k + 1)
  }
}
```

## 连续输出1-100内的偶数

```go
func main() {
  i := 1
  for {
    if i > 100 {
      break
    }
    if i % 2 == 0 {
      fmt.Println(i)
    }
    i = i + 1
  }
}
```

```go
func main() {
  s := make([]int, 100)
  for k := range s {
    i := k + 1
    if i % 2 == 0 {
      fmt.Println(i)
    }
  }
}
```

## 连续输出1-100内的质数

```go
func main() {
  s := make([]int, 100)
  for k := range s {
    i := k + 1
    if i == 2 {
      fmt.Println(i)
    }
    if i > 2 {
      isTrue := true
      for j := 2; j < i; j++ {
        if i % j == 0 {
          isTrue = false
          break
        }
      }
      if isTrue {
        fmt.Println(i)
      }
    }
  }
}
```

## 牛顿法实现平方根函数

```go
package main

import "fmt"

func sqrt(x float64) float64 {
  eps := 1e-12
  result := x
  for {
    lastValue := result
    result = (result + x / result) / 2
    fmt.Println(result)
    if abs(result - lastValue) < eps {
      break
    }
  }
  return result
}

func abs(x float64) float64 {
  if x < 0 {
    x = -x
  }
  return x
}

func main() {
  sqrt(4)
}
```

## 自定义String 方法打印ip 地址

```go
package main

import "fmt"
import "strconv"

type IPAddr [4]byte

func (ip IPAddr) String() string {
  var str string
  for _, v := range ip {
    str = str + "." + strconv.Itoa(int(v))
  }
  str = str[1:]
  return str
}

func main() {
  hosts := map[string]IPAddr{
    "loopback": {127, 0, 0, 1},
    "googleDNS": {8, 8, 8, 8},
  }
  for name, ip := range hosts {
    fmt.Printf("%v: %v\n", name, ip)
  }
}
```