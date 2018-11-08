# Golang Tour 笔记

### hello world

```go
package main

import "fmt"

func main() {
    fmt.Println("hello world")
}
```

### 包

每个 Go 程序都是由包构成。

程序从 main 包开始运行。

### 导入

```go
import "fmt"
import "math"
```

或

```go
import (
    "fmt"
    "math"
)
```

### 导出

如果一个名字以大写字母开头，那么它就是已导出的。在导入一个包时，只能引用其已经导出的名字。

### 函数

当连续两个或多个函数的已命名形参类型相同时，除最后一个类型以外，其他都可以省略。

```go
func add(x int, y int) int {
    return x + y
}
```

等价于

```go
func add(x, y int) int {
    return x + y
}
```

函数可以返回任意数量的返回值

```go
func swap(x, y string) (string, string) {
    return y, x
}
```

返回值可以被命名，会被当做定义在函数顶部的变量

```go
func split(sum int) (x, y int) {
    x = sum * 4 / 9
    y = sum - x
    return
}
```

### 变量

var 语句声明一个变量列表，类型在最后面，可以出现在包或函数级别

变量声明可以包含初始值，如果初始值存在，可以省略类型，变量会从初始值中获得类型

在函数中可以用 := 代替类型明确时的 var 声明，函数外不能使用

### 基本类型

```
bool

string

int int8 int16 int32 int64
uint uint8 uint16 uint32 uint64 uintptr

byte // uint8 的别名

rune // int32 的别名，表示一个 Unicode 码点

float32 float64

complex64 complex128
```

### 零值

没有明确初始值的变量声明会被赋予零值：

* 数值类型 0
* 布尔类型 false
* 字符串为 ""

### 类型转换

表达式 T(v) 将值 v 转换为类型 T

```go
var i int = 42
var f float64 = float64(i)
var u uint = uint(f)

i := 42
f := float64(i)
u := uint(f)
```

### 常量

常量声明使用 const 关键字，常量可以是字符、字符串、布尔值或数值

### for

go 只有一种循环结构：for 循环

go 的 for 语句后面没有小括号，大括号则是必须的

* 初始化语句
* 条件表达式
* 后置语句

初始化语句变量声明仅在 for 语句作用域中可见

初始化语句和后置语句是可选的

只有条件表达式就等价于其他语句中的 while

无限循环

```go
for {
}
```

### if

if 语句后面没有小括号，大括号是必须的

if 语句在条件表达式前可以执行一个简单的语句，该语句声明的变量作用域仅在 if 之内（包含可以在 else 块中使用）

```go
if v := 1; v < 2 {
    h := v
}
```

### switch

Go 自动提供了在这些语言中每个 case 后面所需的 break 语句。 除非以 fallthrough 语句结束，否则分支会自动终止。 Go 的另一点重要的不同在于 switch 的 case 无需为常量，且取值不必为整数。

switch 的 case 语句从上到下顺次执行，直到匹配成功时停止。

```go
// 在 i == 0 时 f 不会被调用
switch i {
case 0:
case f():
}
```

switch 也可以没有条件，功能就相当于 if-then-else

### defer

defer 语句会将函数推迟到外层函数返回之后执行。推迟调用的函数其参数会立即求值，但直到外层函数返回前该函数都不会被调用。推迟的函数调用会被压入一个栈中。当外层函数返回时，被推迟的函数会按照后进先出的顺序调用。

### 指针

指针保存了值的内存地址。类型 `*T` 是指向 `T` 类型值的指针。其零值为 `nil`。

`&` 操作符会生成一个指向其操作数的指针。

`*` 操作符表示指针指向的底层值。

```go
var p *int
i := 42
p = &i

fmt.Println(*p) // 通过指针 p 读取 i
*p = 21 // 通过指针 p 设置 i
```

### 结构体

一个结构体就是一个字段的集合。结构体字段使用点号来访问。结构体字段可以通过结构体指针来访问。

```go
(*p).X
// 隐式间接引用
p.X
```

结构体文法通过直接列出字段的值来新分配一个结构体。使用 `Name:` 语法可以仅列出部分字段

```go
type Vertex struct {
    X int
    Y int
}

type Vertex struct {
    X, Y int
}

v1 := Vertex{1, 2}
v2 := Vertex{X: 1}
v3 := Vertex{}
p := &Vertex{1, 2}
```

### 数组

类型 `[n]T` 表示拥有 `n` 个 `T` 类型的值的数组，数组的长度是其类型的一部分。

```go
func main() {
    var a [2]string
    a[0] = "Hello"
    a[1] = "World"

    primes := [6]int{2, 3, 5, 7, 11, 13}
}
```

### 切片

切片为数组元素提供动态大小的、灵活的视角，切片比数组更常用。类型 `[]T` 表示一个元素类型为 `T` 的切片。

```go
// 半开区间，包括第一个元素，但排除最后一个元素
a[low:high]
// a中下标1到3的元素
a[1:4]
```

切片就像数组的引用，它不存储任何数据，仅描述了底层数组中的一段。更改切片的元素会修改其底层数组中对应的元素。与它共享底层数组的切片都会观测到这些修改。

切片文法类似于没有长度的数组文法。

```go
// 数组文法
[3]bool{true, true, false}
// 创建一个和上面相同的数组，然后构建一个引用了它的切片
[]bool{true, true, false}
```

```go
var a [10]int

// 以下切片是等价的
a[0:10]
a[:10]
a[0:]
a[:]
```

切片拥有**长度**和**容量**。切片的长度就是它所包含的元素个数。容量是从它的第一个元素开始数，到其底层数组元素末尾的个数。分别通过 `len(s)` 和 `cap(s)` 来获取。

切片的零值是 nil。nil 切片的长度和容量为0且没有底层数组。

```go
// nil 切片
var s []int
```

用 `make` 创建切片，`make` 函数会分配一个元素为零值的数组并返回一个引用它的切片

```go
a := make([]int, 5) // len(a)=5
b := make([]int, 0, 5) // len(b)=0, cap(b)=5
```

切片可以包含任何类型，甚至包含其他切片。

`append` 函数向切片追加元素

```go
func append(s []T, vs ...T) []T
```

### Range

for 循环的 range 形式可遍历切片或映射。当使用 for 循环遍历切片是，每次迭代都会返回两个值。第一个值为当前元素的下标，第二个值为该下标所对应元素的一份副本。

```go
for i, v := range p {
    // do something
}
for i := range p {}
for _, v := range p {}
```

### 映射

映射将键映射到值。映射的零值为 nil。nil 映射既没有键，也不能添加键。 make 函数会返回给定类型的映射，并将其初始化备用。映射的文法与结构体相似，不过必须有键名。

若顶级类型只是一个类型名，则可在文法的元素中省略它

```go
type Vertex struct {
    Lat, Long float64
}
// 1
var m map[string]Vertex
m = make(map[string]Vertex)
m["Bell Labs"] = Vertex{
    40.6, -74.3,
}
// 2
var m = map[string]Vertex{
    "a": Vertex{
        1.0, 2.0,
    },
    "b": Vertex{
        3.0, 4.0,
    },
}
// 3
var m = map[string]Vertex{
    "a": {1.0, 2.0},
    "b": {3.0, 4.0},
}


// set
m[key] = elem
// get
elem = m[key]
// delete
delete(m, key)
// 通过双赋值监测键是否存在
// 若存在 ok 为 true 否则 为 false
// 若不存在 elem 为零值
elem, ok = m[key]
elem, ok := m[key]
```

### 函数值

函数也是值。函数值可以用作函数的参数或返回值。

Go 函数可以是一个闭包。闭包是一个函数值，它引用了其函数体之外的变量。该函数可以访问并赋予其引用的变量的值，换句话说，该函数被“绑定”在了这些变量上。

### 方法

Go 没有类。不过可以为结构体类型定义方法。方法就是一类带特殊的**接收者**参数的函数。方法接收者在它自己的参数列表内，位于 func 关键字和方法名之间。

```go
type Vertex struct {
    X, Y float64
}
// Abs 方法拥有一个名为 v，类型为 Vertex 的接收者
func (v Vertex) Abs() float64 {
    return math.Sqrt(v.X * v.X + v.Y * v.Y)
}

// 调用方法
v := Vertex{3, 4}
v.Abs()
```

方法只是个带接收者参数的函数。

也可为非结构体类型声明方法。不能为内建类型声明方法。

可以为指针接收者声明方法。指针接收者的方法可以修改接收者指向的值。若使用值接收者，只能对副本进行操作。

```go
func (v *Vertex) Scale(f float64) {
    v.X = v.X * f
    v.Y = v.Y * f
}
v := Vertex{3, 4}
v.Scale(10) // {30, 40}
```

以指针为接收者的方法被调用时，接收者既能为值又能为指针。
以值为接收者的方法被调用时，接收者既能为值又能为指针。

使用指针接收者的原因有二：

* 首先，方法能够修改其接收者指向的值。
* 其次，这样可以避免在每次调用方法时复制该值。若值的类型为大型结构体时，这样做会更加高效。

### 接口

```go
type I interface {
    M()
}
```

**接口类型**是由一组方法签名定义的集合。接口类型的变量可以保存任何实现了这些方法的值。

类型通过实现一个接口的所有方法来实现该接口。既然无需专门显式声明，也就没有“implements”关键字。

在内部，接口值可以看做包含值和具体类型的元组：

```
(value, type)
```

接口值保存了一个具体底层类型的具体值。接口值调用方法时会执行其底层类型的同名方法。

即便接口内的具体值为 nil，方法仍然会被 nil 接收者调用。保存了 nil 具体值的接口其自身并不为 nil。

nil 接口值既不保存值也不保存具体类型。为 nil 接口调用方法会产生运行时错误，因为接口的元组内并未包含能够指明改调用哪个**具体**方法的类型。

指定了零个方法的接口值被称为**空接口**

```go
interface{}
```

空接口可保存任何类型的值。空接口被用来处理未知类型的值。

**类型断言**提供了访问接口值底层具体值的方式。

```go
t := i.(T)
```

该语句断言接口值 i 保存了具体类型 T，并将其底层类型为 T 的值赋予变量 t。若 i 并未保存 T 类型的值，该语句就会触发一个恐慌。

也可返回两个值，将不会产生恐慌。

```go
t, ok := i.(T)
```

类型选择

```go
switch v := i.(type) {
case T:
case S:
default:
}


func do(i interface{}) {
	switch v := i.(type) {
	case int:
		fmt.Printf("Twice %v is %v\n", v, v*2)
	case string:
		fmt.Printf("%q is %v bytes long\n", v, len(v))
	default:
		fmt.Printf("I don't know about type %T!\n", v)
	}
}
```

此选择语句判断接口值 i 保存的值类型是 T 还是 S。在 T 或 S 的情况下，变量 v 会分别按 T 或 S 类型保存 i 拥有的值。在默认（即没有匹配）的情况下，变量 v 与 i 的接口类型和值相同。

### 错误

Go 程序使用 error 值来表示错误状态。error 类型是一个内建接口。

```go
type error interface {
    Error() string
}
```

通常函数会返回一个 error 值，调用的它的代码应当判断这个错误是否等于 nil 来进行错误处理。

### Reader

io 包指定了 io.Reader 接口，它表示从数据流的末尾进行读取。

Go 标准库包含了该接口的许多实现，包括文件、网络连接、压缩和加密等等。

io.Reader 接口有一个 Read 方法：

```go
func (T) Read(b []byte) (n int, err error)
```

Read 用数据填充给定的字节切片并返回填充的字节数和错误值。在遇到数据流的结尾时，它会返回一个 io.EOF 错误。

### Goroutines

轻量级线程，在相同的地址空间中运行，因此在访问共享的内存时必须进行同步。

```go
// 启动一个新的 goroutine 执行 f
go f(x, y, z)
```

### Channels

信道是带有类型的管道，可以通过信道操作符 `<-` 来发送或接收值。

```go
ch <- v // 将 v 发送至信道 ch
v := <-ch // 从 ch 接收值并赋予 v
```

```go
// 创建 channel
ch := make(chan int)
```

默认情况下，发送和接收操作在另一端准备好之前都会阻塞。这使得 Go 程可以在没有显式的锁或竞态变量的情况下进行同步。

带缓冲的信道。仅当信道的缓冲区填满后，向其发送数据时才会阻塞。当缓冲区为空时，接收方会阻塞。

```go
ch := make(chan int, 100)
```

发送者可通过 close 关闭一个信道来表示没有需要发送的值了。接收者可以通过为接收表达式分配第二个参数来测试信道是否被关闭。

循环 `for i := range c` 会不断从信道接收值，直到它被关闭。

select 语句使一个 Go 程可以等待多个通信操作。

select 会阻塞到某个分支可以继续执行为止，这时就会执行该分支。当多个分支都准备好时会随机选择一个执行。

```go
func fibonacci(c, quit chan int) {
	x, y := 0, 1
	for {
		select {
		case c <- x:
			x, y = y, x+y
		case <-quit:
			fmt.Println("quit")
			return
		}
	}
}
```

当 select 中的其它分支都没有准备好时，default 分支就会执行。

为了在尝试发送或者接收时不发生阻塞，可使用 default 分支

```go
select {
case i := <-c:
    // 使用 i
default:
    // 从 c 中接收会阻塞时执行
}
```

### sync.Mutex

我们已经看到信道非常适合在各个 Go 程间进行通信。

但是如果我们并不需要通信呢？比如说，若我们只是想保证每次只有一个 Go 程能够访问一个共享的变量，从而避免冲突？

这里涉及的概念叫做 __互斥（mutual_exclusion）__ ，我们通常使用 __互斥锁（Mutex）__ 这一数据结构来提供这种机制。

Go 标准库中提供了 sync.Mutex 互斥锁类型及其两个方法：

* Lock
* Unlock

我们可以通过在代码前调用 Lock 方法，在代码后调用 Unlock 方法来保证一段代码的互斥执行。参见 Inc 方法。

我们也可以用 defer 语句来保证互斥锁一定会被解锁。参见 Value 方法。

```go
package main

import (
	"fmt"
	"sync"
	"time"
)

// SafeCounter 的并发使用是安全的。
type SafeCounter struct {
	v   map[string]int
	mux sync.Mutex
}

// Inc 增加给定 key 的计数器的值。
func (c *SafeCounter) Inc(key string) {
	c.mux.Lock()
	// Lock 之后同一时刻只有一个 goroutine 能访问 c.v
	c.v[key]++
	c.mux.Unlock()
}

// Value 返回给定 key 的计数器的当前值。
func (c *SafeCounter) Value(key string) int {
	c.mux.Lock()
	// Lock 之后同一时刻只有一个 goroutine 能访问 c.v
	defer c.mux.Unlock()
	return c.v[key]
}

func main() {
	c := SafeCounter{v: make(map[string]int)}
	for i := 0; i < 1000; i++ {
		go c.Inc("somekey")
	}

	time.Sleep(time.Second)
	fmt.Println(c.Value("somekey"))
}

```
