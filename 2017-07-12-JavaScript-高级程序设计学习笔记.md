---
title: JavaScript 高级程序设计学习笔记
date: 2017-07-12 14:47:41
tags:
- JavaScript
---

## 第1章 JavaScript 简介

JavaScript 具备与浏览器窗口及其内容等几乎所有方面交互的能力。

欧洲计算机制造商协会 ECMA European Computer Manufactures Association

ECMAScript ek-ma-script

一个完整的JavaScript实现应该由下列三个不同的部分组成：

- 核心（ECMAScript），提供核心语言功能
- 文档对象模型（DOM），提供访问和操作网页内容的方法和接口
- 浏览器对象模型（BOM），提供与浏览器交互的方法和接口

<!-- more -->

### ECMAScript

我们常见的 Web 浏览器知识 ECMAScript 实现可能的**宿主环境**之一，其他宿主环境包括Node（一种服务端JavaScript平台）和 Adobe Flash。

ECMAScript规定了这门语言的下列组成部分：

- 语法
- 类型
- 语句
- 关键字
- 保留字
- 操作符
- 对象

ECMAScript 3.1 成为 ECMA-262 第5版，在2009年发布。

### 浏览器对象模型（BOM）

- 弹出新浏览器窗口的功能
- 移动、缩放和关闭浏览器窗口的功能
- 提供浏览器详细信息的 navigator 对象
- 提供浏览器所加载页面的详细信息的 location 对象
- 提供用户显示器分辨率详细信息的 screen 对象
- 对 cookies 的支持
- 像 XMLHttpRequest 和 IE 的 ActiveXObject 这样的自定义对象

HTML5 致力于把很多 BOM 功能写入正式规范。

## 第2章 在 HTML 中使用 JavaScript

向 HTML 页面中插入 JavaScript 的主要方法，就是使用`<script>`元素。HTML 4.01 为`<script>`定义了下列6个属性：

- `async`：可选，**异步脚本**。表示应该立即下载脚本，但不应妨碍页面中的其他操作，比如下载其他资源或等待加载其他脚本。**只对外部脚本文件有效。**
- `charset`：可选。表示通过`src`属性指定的代码的字符集。由于大多数浏览器会忽略它的值，因此这个属性很少有人用。
- `defer`：可选，**延迟脚本**。**表示脚本可以延迟到文档被解析和显示之后再执行。**只对外部脚本文件有效。IE7 及更早版本对嵌入脚本也支持这个属性。也就是说，脚本会被延迟到整个页面都解析完毕后再运行。
- `language`：已废弃。大多数浏览器会忽略这个属性，因此也没有必要再用了。
- `src`：可选。表示包含要执行代码的外部文件。
- `type`：可选。可以看成是`language`的替代属性；表示编写代码使用的脚本语言的内容类型（也成为 MIME 类型）。虽然`text/javascript`和`text/ecmascript`都已经不被推荐使用，但人们一直以来使用的都还是`type/javascript`。实际上，服务器在传送JavaScript 文件时使用的 MIME 类型通常是`application/x-javascript`，但在`type`中设置这个值却可能导致脚本被忽略。这个属性不是必须的，如果没有指定这个属性，其默认值仍为`text/javascript`。

转义字符“\”

使用`<script>`元素的方式有两种：直接在页面中嵌入 JavaScript 代码和包含外部 JavaScript 文件。

第一种：

```html
<script type="text/javascript">
	function sayHi(){
      alert("Hi");
	}
</script>
```

第二种：

```html
<script type="text/javascript" src="example.js"></script>
```

外部文件`example.js`只需包含通常要放在开始的`<script>`和结束的`</script>`之间的那些 JavaScript 代码即可。

**与解析嵌入式 JavaScript 代码一样，在解析外部 JavaScript 文件（包括下载该文件）时，页面的处理也会暂时停止。**

需要注意的是，带有`src`属性的`<script>`元素不应该在其`<script>`和`</script>`标签之间再包含额外的JavaScript 代码。如果包含了嵌入的代码，则只会下载并执行外部脚本文件，嵌入的代码会被忽略。

另外，通过`<script>`元素的`src`属性还可以包含来自外部域的JavaScript 文件。

**引用外部JavaScript 文件的优点**

并不存在必须使用外部文件的硬性规定，但支持使用外部文件的人多会强调如下优点：

- **可维护性**：遍及不同HTML 页面的JavaScript 会造成维护问题。但把所有JavaScript 文件都放在一个文件夹中，维护起来就轻松多了。而且开发人员因此能够在不触及HTML 标记的情况下，集中精力编辑JavaScript 代码。
- **可缓存**：浏览器能够根据具体的设置缓存链接的所有外部JavaScript 文件。也就是说，如果有两个页面都使用同一个文件，那么这个文件只需下载一次。因此，最终结果就是能够加快页面加载的速度。
- **适应未来**

使用`<noscript>`元素可以指定在不支持脚本的浏览器中显示的替代内容。但在启用了脚本的情况下，浏览器不会显示`<noscript>`元素中的任何内容。

## 第3章 基本概念

任何语言的核心都必然会描述这门语言的最基本的工作原理。而描述的内容通常都要涉及这门语言的语法、操作符、数据类型、内置功能等用于构建复杂解决方案的基本概念。

本章将主要按照第3版定义的ECMAScript 介绍这门语言的基本概念，并就第5版的变化给出说明。

ECMAScript 中的一切（变量、函数名和操作符）都区分大小写。

### 标识符

所谓标识符，就是指变量、函数、属性的名字，或者函数的参数。标识符可以是按照下列格式规则组合起来的一或多个字符：

- 第一个字符必须是一个字母、下划线或一个美元符号
- 其他字符可以是字母、下划线、美元符号或数字

按照惯例，ECMAScript 标识符采用驼峰大小写格式，也就是第一个字母小写，剩下的每个单词的首字母大写。

### 关键字和保留字

以下就是ECMAScript 的全部关键字：

![](http://7xvxmb.com1.z0.glb.clouddn.com/170409-1.png)

以下是 ECMA-262 第3版定义的全部保留字：

![](http://7xvxmb.com1.z0.glb.clouddn.com/170409-2.png)

在实现 ECMAScript 3 的JavaScript 引擎中使用关键字做标识符，会导致“Identifier Expected”错误。

### 变量

ECMAScript 的变量是松散类型的，所谓松散类型就是可以用来保存任何类型数据。换句话说，每个变量仅仅是一个用于保存值的占位符而已。定义变量时要使用`var`操作符(注意`var`是一个关键字)，后跟变量名(即一个标识符)。

用`var`操作符定义的变量将成为定义该变量的作用域中的局部变量。也就是说，如果在函数中使用`var`定义一个变量，那么这个变量在函数退出后就会被销毁。可以省略`var`操作符，从而创建一个全局变量。

> 虽然省略`var`操作符可以定义全局变量，但不推荐这种做法。因为在局部作用域中定义的全局变量很难维护，而且如果有意地忽略了`var`操作符，也会由于相应变量不会马上就有定义而导致不必要的混乱。如未经声明的变量赋值在严格模式下会导致抛出`ReferenceError`错误。

### 数据类型

ECMAScript 中有5种简单数据类型（基本数据类型）：Undefinded、Null、Boolean、Number 和String。还有1种复杂数据类型——Object，Object 本质上是由一组无序的名值对组成的。

#### typeof 操作符

鉴于ECMAScript 是松散类型的，因此需要有一种手段来检测给定变量的数据类型——typeof 就是负责提供这方面信息的操作符。对一个值使用 typeof 操作符可能返回下列某个字符串：

- ”undefined“——未定义
- ”boolean“——布尔值
- ”string“——字符串
- ”number“——数值
- ”object“——对象或null
- ”function“——函数

注意，**typeof 是一个操作符而不是函数**，因此可以在其后使用圆括号，但不是必须的。

> 从技术角度讲，函数在ECMAScript 中是对象，不是一种数据类型。然而，函数也确实有一些特殊的属性，因此通过typeof 操作符来区分函数和其他对象是有必要的。

#### Undefined 类型

Undefined 类型只有一个值，即特殊的 undefined。在使用`var`声明变量但未对其加以初始化时，这个变量的值就是 undefined

#### Null 类型

Null 类型只有一个值，即特殊的 null。从逻辑角度来看，null 值表示一个**空对象指针**，而这也正是使用 typeof 操作符检测 null 值时会返回”object“的原因。

如果定义的变量准备在将来用于保存对象，那么最好将该变量初始化为null 而不是其他值。

#### Boolean 类型

Boolean 类型是ECMAScript 中使用最多的一种类型，该类型只有两个字面值：true 和 false。（区分大小写）

虽然Boolean 类型的字面值只有两个，但ECMAScript 中所有类型的值都有与这两个Boolean 值等价的值。要将一个值转换为其对应的Boolean 值，可以调用转型函数Boolean() 。下表给出了各种数据类型及其对应的转换规则：

![](http://7xvxmb.com1.z0.glb.clouddn.com/170409-3.png)

这些转换规则对理解流控制语句自动执行相应的Boolean 转换非常重要。

#### Number 类型

最基本的数值字面量格式是十进制整数。

八进制字面值的第一位必须是0

十六进制字面量的前两位必须是0x

在进行算数运算时，所有以八进制和十六进制表示的数值最终都将被转换成十进制数值。

**浮点数值**

所谓浮点数值，就是该数值中必须包含一个小数点，并且小数点后面必须至少有一位数字。由于保存浮点数值需要的内存空间是保存整数值的两倍，因此ECMAScript 会不失时机地将浮点数值转换为整数值。

对于那些极大或极小的数值，可以用e 表示法（即科学计数法）表示的浮点数值表示。

浮点数值的最高精读是17位小数，但在进行算术计算时其精确度远远不如整数。例如，0.1加0.2的结果不是0.3，而是0.30000000000000004。因此，**永远不要测试某个特定的浮点数值**。

**数值范围**

最小数值：Number.MIN_VALUE

最大数值：Number.MAX_VALUE

如果某次计算的结果得到了一个超出JavaScript 数值范围的值，那么这个数值将会被自动转换成特殊的Infinity 数值。要想确定一个数值是不是位于最大和最小的数值之间，可以使用`isFinite()`函数。这个函数在参数位于最大与最小数值之间时会返回true

**NaN**

NaN，即非数值（Not a Number）是一个特殊的数值，这个数值用于表示一个本来要返回数值的操作数未返回数值的情况（这样就不会抛出错误了）。例如，在其他编程语言中，任何数值除以非数值都会导致错误，从而停止执行代码。但在ECMAScript 中，任何数值除以非数值会返回NaN ，因此不会影响其他代码的执行。

NaN 本身有两个非同寻常的特点：

- 任何涉及NaN的操作（例如NaN/10）都会返回NaN
- NaN与任何值都不相等，包括NaN本身

针对NaN的这两个特点，ECMAScript 定义了`isNaN()`函数。这个函数接受一个参数，该参数可以是任何类型，而函数会帮我们确定这个参数是否”不是数值“。**任何不能被转换为数值的值都会导致这个函数返回true。**

![](http://7xvxmb.com1.z0.glb.clouddn.com/170409-4.png)

> `isNaN()`也适用于对象。

**数值转换**

有三个函数可以把非数值转换为数值：

- Number()
- parseInt()
- parseFloat()

Number() 函数的转换规则如下：

- 如果是Boolean 值，true 和 false 将分别被转换为1和0
- 如果是数字值，只是简单的传入和返回
- 如果是null 值，返回0
- 如果是undefined，返回NaN
- 字符串转换规则如下
- 如果是对象，则调用对象的`valueOf()`方法，然后依照前面的规则转换返回的值。如果转换的结果是NaN，则调用对象的`toString()`方法，然后再次依照前面的规则转换返回的字符串值

字符串的Number() 转换规则：

- 如果字符串中只包含数字，则将其转换为十进制数值
- 如果字符串中包含有效的浮点格式，将其转换为对应的浮点数值
- 如果字符串中包含有效的十六进制格式，将其转换为相同大小的十进制整数格式
- 如果字符串是空的，将其转换为0
- 如果字符串中包含除上述格式之外的字符，将其转换为NaN

示例：

![](http://7xvxmb.com1.z0.glb.clouddn.com/170409-5.png)

> 一元加操作符的操作与Number() 函数相同

处理整数时更常用的是`parseInt()`函数。转换时，它会忽略字符串前面的空格，直至找到第一个非空格字符。如果第一个字符不是数字字符或者符号，`parseInt()`就会返回NaN。也许考虑到八进制和十六进制的问题。示例：

![](http://7xvxmb.com1.z0.glb.clouddn.com/170409-6.png)

建议提供此函数第二个参数，表示转换时使用的基数(即多少进制)。多数情况下，我们要解析的都是十进制数值，因此始终将10作为第二个参数是非常有必要的。

![](http://7xvxmb.com1.z0.glb.clouddn.com/170409-7.png)

与`parseInt()`函数类似，`parseFloat()`也是从第一个字符开始解析每个字符。不同的是，`parseFloat()`只解析十进制数，因此不需要第二个参数。示例：

![](http://7xvxmb.com1.z0.glb.clouddn.com/170409-8.png)

#### String 类型

String 类型用于表示由零或多个16位Unicode 字符组成的字符序列，即字符串。可用双引号或单引号表示。

与PHP中的双引号和单引号会影响对字符串的解释方式不同，ECMAScript 中的这两种方式并没有什么区别。

**字符字面量**

String 数据类型包含一些特殊的字符字面量，也叫转义序列，用于表示非打印字符，或者具有其他用途的字符。

![](http://7xvxmb.com1.z0.glb.clouddn.com/170409-9.png)

这些字符字面量可以出现在字符串的任意位置，**将被作为一个字符来解析**。

**字符串的特点**

ECMAScript 中的字符串是不可变的，也就是说，字符串一旦创建，它们的值就不能改变。要改变某个变量保存的字符串，首先要销毁原来的字符串，然后再用另一个包含新值的字符串填充该变量。

**转换为字符串**

要把一个值转换为字符串有两种方式：

- toString()——例如a.toString()
- String()——例如String(a)

区别在于转换的数值为null 或undefined 的情况下，后者可以转换为相应的字面量。

> 要把某个值转换为字符串，可以使用加号操作符把它与一个字符串加在一起。

#### Object 类型

ECMAScript 中的对象其实就是一组数据和功能的集合。

在ECMAScript 中，Object 类型是所有它的实例的基础。换句话说，Object 类型所具有的任何属性和方法也同样存在于更具体的对象中。

Object 的每个实例都具有下列属性和方法：

- constructor：保存着用于创建当前对象的函数。
- hasOwnProperty(propertyName)：用于检查给定的属性在当前对象实例中（而不是在实例的原型中）是否存在。其中，作为参数的属性名（propertyName）必须以字符串的形式指定。
- isPrototypeof(object)：用于检查传入的对象是否是当前对象的原型
- propertyIsEnumerable(propertyName)：用于检查给定的属性是否能够使用for-in 语句来枚举。作为参数的属性名必须以字符串形式指定。
- toLocaleString()：返回对象的字符串表示，该字符串与执行环境的地区对应。
- toString()：返回对象的字符串表示。
- valueOf()：返回对象的字符串、数值或布尔值表示。通常与toString() 方法的返回值相同。

由于在ECMAScript 中Object 是所有对象的基础，因此所有对象都具有这些基本的属性和方法。

### 操作符

#### 一元操作符

只能操作一个值的操作符叫做一元操作符。一元操作符是ECMAScript 中最简单的操作符。

**递增和递减操作符**

分为前置型和后置型。

执行前置递增和递减操作时，变量的值都是在语句被求值以前改变的。而后置的是在包含它们的语句被求值之后才执行的。

所有这4个操作符对任何值都适用，规则如下：

- 在应用于一个包含有效数字字符的字符串时，先将其转换为数字值，再执行加减1的操作。字符串变量变成数值变量。
- 在应用于一个不包含有效数字字符的字符串时，将变量的值设置为NaN。字符串变量变成数值变量。
- 在应用于布尔值时，false转换为0，true转换为1，之后再执行加减1的操作。布尔值变量变成数值变量。
- 在应用于浮点数值时，执行加减1操作。
- 在应用于对象时，先调用对象的valueOf()  方法以取得一个可供操作的值。然后对该值应用前述规则。如果结果是NaN，则再调用toString() 方法后再应用前述规则。对象变量变为数值变量。

示例：

![](http://7xvxmb.com1.z0.glb.clouddn.com/170409-10.png)

**一元加和减操作符**

一元加和减操作符主要用于基本的算术运算。

对非数值应用一元加或减操作符时，该操作符会像Number() 转型函数一样对这个值执行转换。

#### 位操作符

位操作符用在最基本的层次上，即按内存中表示数值的位来操作数值。**速度更快**

在ECMAScript 中，当对数值应用位操作符时，后台会发生如下转换过程：64位的数值被转换为32位数值，然后执行位操作，最后再将32位的结果转换回64位数值。

如果对非数值应用位操作符，会先使用Number() 函数将该值转换为一个数值（自动完成），然后再应用位操作。得到的将是一个数值。

**按位非（NOT）**

按位非操作符由一个波浪线（~）表示，执行按位非的结果就是返回数值的反码。示例：

![](http://7xvxmb.com1.z0.glb.clouddn.com/170409-11.png)

按位非操作的本质：**操作数的负值减1**

**按位与（AND）**

按位与操作符由一个和号字符（&）表示，它有两个操作符数。**按位与操作只在两个数值对应位都是1时才返回1，任何一位是0，结果都是0。**

**按位或（OR）**

按位或操作符由一条竖线符号（|）表示，有两个操作数。**按位或操作在有一个位是1的情况下就返回1，而只有在两个位都是0的情况下才返回0。**

**按位异或（XOR）**

按位异或操作符由一个插入符号（^）表示，有两个操作数。**这个操作在两个数值对应位上只有一个1是才返回1，如果对应的两位都是1或都是0，则返回0。**

**左移**

左移操作符由两个小于号（<<）表示，这个操作符会将数值的所有位向左移动指定的位数。

注意，左移不会影响操作数的符号位。

**有符号的右移**

有符号的右移操作符由两个大于号（>>）表示，这个操作符会将数值向右移动，但保留符号位（即正负号标记）。

在移位的过程中，原数值会出现空位。只不过这次的空位出现在原数值的左侧、符号位的右侧。而此时ECMAScript 会用符号位的值来填充所有空位，以便得到一个完整的值。

![](http://7xvxmb.com1.z0.glb.clouddn.com/170409-12.png)

**无符号右移**

无符号右移操作符由3个大于号（>>>）表示，这个操作符会将数值的所有32位都向右移动，然后以0来填充空位。所以，对正数的无符号右移与有符号右移结果相同，但对负数的结果就不一样了。

无符号右移操作符会把负数的二进制码当成正数的二进制码。而且，由于负数以其绝对值的二进制补码形式表示，因此就会导致无符号右移后的结果非常之大。

#### 布尔操作符

布尔操作符一共有3个：

- 非（NOT）
- 与（AND）
- 或（OR）

**逻辑非**

逻辑非操作符由一个叹号（!）表示。**同时使用两个逻辑非操作符，实际上就会模拟Boolean() 转型函数的行为。**

**逻辑与**

逻辑与操作符由两个和号（&&）表示，有两个操作数。**逻辑与操作属于短路操作，即如果第一个操作数能够决定结果，那么就不会再对第二个操作数求值。**

**逻辑或**

逻辑或操作符由两个竖线符号（||）表示，有两个操作数。**也属于短路操作符**。

我们可以利用逻辑或的属性为变量赋值，以避免null 或 undefined 值。

```javascript
var myObject = preferredObject || backupObject;
```

ECMAScript 程序的赋值语句经常会使用这种模式。

#### 乘性操作符

ECMAScript 定义了3个乘性操作符：乘法*、除法/和求模%。如果参与乘性计算的某个操作数不是数值，后台会先使用Number() 转型函数将其转换为数值。也就是说，空字符串会被当作0，布尔值true 将被当作1。

#### 关系操作符

- 小于<
- 大于>
- 小于等于<=
- 大于等于>=

一些规则：

- 如果两个操作数都是数值，则执行数值比较
- 如果两个操作数都是字符串，则比较两个字符串对应的字符编码值
- 如果一个操作数是数值，则将另一个操作数转换为一个数值，然后执行数值比较
- 如果一个操作数是对象，则调用这个对象的valueof() 方法，用得到的结果按照前面的规则执行比较。如果对象没有valueof() 方法，则调用toString() 方法，并用得到的结果根据前面的规则执行比较。
- 如果一个操作数是布尔值，则先将其转换为数值，然后再执行比较。

#### 相等操作符

**相等和不相等**

- 相等==
- 不相等!=

这两个操作符都会先转换操作数（**强制转型**），然后再比较它们的相等性。

在转换不同的数据类型时，相等和不相等操作符遵循下列基本规则：

- 如果有一个操作数是布尔值，则在比较相等性之前先将其转换为数值
- 如果一个操作数是字符串，另一个操作数是数值，在比较相等性之前先将字符串转换为数值
- 如果一个操作数是对象，另一个操作数不是，则调用对象的valueOf() 方法，用得到的基本类型值按照前面的规则进行比较

进行比较时遵循下列规则：

- null 和undefined 是相等的
- 要比较相等性之前，不能将null 和undefined 转换成其他任何值
- 如果有一个操作数是NaN，则相等操作符返回false，而不相等操作符返回true。重要提示：即使两个操作数都是NaN，相等操作符也返回false；因为按照规则，NaN不等于NaN。
- 如果两个操作数都是对象，则比较它们是不是同一个对象。**如果两个操作数都指向同一个对象，则相等操作符返回true；否则，返回false。**

下表列出一些特殊情况及比较结果：

![](http://7xvxmb.com1.z0.glb.clouddn.com/170409-13.png)

**全等和不全等**

除了在比较之前不转换操作数之外，全等和不全等操作符没有什么区别。全等操作符由3个等于号（===）表示，它只在两个操作数未经转换就相等的情况下返回true。

不全等操作符由一个叹号后跟两个等于号（!==）表示，它在两个操作数未经转换就不相等的情况下返回true。

> 记住：null == undefined 会返回true，因为它们是类似的值；但null === undefined会返回false，因为它们是不同类型的值。

> 由于相等和不相等操作符存在类型转换问题，而为了保持代码中数据类型的完整性，我们推荐使用全等和不全等操作符。

#### 条件操作符

```javascript
variable = boolean_expression ? true_value : false_value;
```

例如：

```javascript
var max = (num1 > num2) ? num1 : num2;
```

#### 赋值操作符

简单的赋值操作符由等于号（=）表示，其作用就是把右侧的值赋给左侧的变量。

如果在等于号（=）前面再添加乘性操作符、加性操作符或位操作符，就可以完成**复合赋值**操作。

设计复合赋值操作符的主要目的是简化赋值操作，**并不会带来任何性能的提升。**

#### 逗号操作符

使用逗号操作符可以在一条语句中执行多个操作。

### 语句

#### if 语句

语法：

```javascript
if (condition) statement1 else statement2
```

其中的condition （条件）可以是任意表达式；而且对这个表达式求值的结果不一定是布尔值。ECMAScript 会自动调用Boolean() 转换函数将这个表达式的结果转换为一个布尔值。

#### do-while 语句

do-while 语句是一种后测试循环语句，即只有在循环体中的代码执行之后，才会测试出口条件。换句话说，在对条件表达式求值之前，循环体内的代码至少会被执行一次。语法：

```javascript
do {
  statement
} while (expression)
```

#### while 语句

while 语句属于前测试循环语句，也就是说，在循环体内的代码被执行之前，就会对出口条件求值。因此，循环体内的代码有可能永远不会被执行。语法：

```javascript
while (expression) statement
```

#### for 语句

for 语句也是一种前测试循环语句，但它具有在执行循环之前初始化变量和定义循环后要执行的代码的能力。

```javascript
for (initialization; expression; post-loop-expression) statement
```

使用while 循环做不到的，使用 for 循环同样也做不到。也就是说，for 循环知识把与循环有关的代码集中在了一个位置。

由于ECMAScript 中不存在块级作用域，因此在循环内部定义的变量也可以在外部访问到。

for 语句中的初始化表达式、控制表达式和循环后表达式都是可选的。将这三个表达式全部省略，就会创建一个无限循环。而只给出控制表达式实际上就把for 循环换成了while 循环。

#### for-in 语句

for-in 语句是一种精准的迭代语句，可以用来枚举对象的属性。**枚举的是属性而非值。**

```javascript
for (property in expression) statement
```

示例：

```javascript
for (var propName in window){
  document.write(propName);
}
```

在这个例子中，使用for-in 循环来显示BOM 中window 对象的所有属性。

ECMAScript 对象的属性没有顺序。因此，通过for-in 循环输出的属性名的顺序是不可预测的。具体来讲，所有属性都会被返回一次，但返回的先后次序可能会因浏览器而异。

为了保证最大限度的兼容性，建议在使用for-in 循环之前，先检测确认该对象的值不是null 或 undefined。

#### label 语句

使用label 语句可以在代码中添加标签，以便将来使用。语法：

```javascript
label: statement
```

定义的标签由break 或 continue 语句引用。加标签的语句一般都要与for 语句等循环语句配合使用。

#### break 和 continue 语句

break 和 continue 语句用于在循环中精确地控制代码的执行。其中，break 语句会立即退出循环，强制继续执行循环后面的语句。而 continue 语句虽然也是立即退出循环，但退出循环后会从循环的顶部继续执行。

break 和 continue 语句都可以与 label 语句联合使用，从而返回代码中特定的位置。这种联合使用的情况多发生在**循环嵌套**的情况下。

#### with 语句

with 语句的作用是将代码的作用域设置到一个特定的对象中。语法：

```javascript
with (expression) statement;
```

严格模式下不允许使用with 语句，否则将视为语法错误。

> 由于大量使用with 语句会导致性能下降，同时也会给调试代码造成困难，因此在开发大型应用程序时，不建议使用with 语句。

#### switch 语句

```javascript
switch (expression){
  case value: statement
  	break;
  case value: statement
  	break;
  default: statement
}
```

ECMAScript 中switch 语句中可以使用任何数据类型，无论是字符串，还是对象都没有问题。且每个case 的值不一定是常量，可以使变量，甚至是表达式。

switch 语句在比较值时使用的是全等操作符，因此不会发生类型转换。

### 函数

ECMAScript 中的函数使用function 关键字来声明，后跟一组参数以及函数体。语法：

```javascript
function functionName(arg0, arg1,...,argN){
  statements
}
```

函数中，可通过return 语句后跟要返回的值来实现返回值。位于return 语句之后的任何代码永远都不会执行。

#### 理解参数

ECMAScript 函数的参数与大多数其他语言中函数的参数有所不同。ECMAScript 函数不介意传递进来多少个参数，也不在乎传进来参数是什么数据类型。也就是说，即便你定义的函数只接收两个参数，在调用这个函数时也未必一定要传递两个参数。可以传递一个、三个甚至不传递参数，而解析器永远不会有什么怨言。之所以会这样，原因是ECMAScript 中的参数在内部是用一个数组来表示的。函数接收到的始终是这个数组，而不关心数组中包含哪些参数。实际上，在函数体内可以通过arguments 对象来访问这个参数数组，从而获得传递给函数的每一个参数。

ECMAScript 函数的一个重要特点：命名的参数只提供便利，但不是必需的。

通过访问arguments 对象的length 属性可以获知有多少个参数传递给了函数。

arguments 对象可以与命名参数一起使用，且它的值永远与对应命名参数的值保持同步。

没有传递值的命名参数将自动被赋予undefined 值。

#### 没有重载

ECMAScript 中定义了两个名字相同的函数，则该名字只属于后定义的函数。

**通过检查传入参数中函数的类型和数量并作出不同的反应，可以模仿方法的重载。**

例如：

```javascript
function doAdd(){
  if(arguments.length == 1){
    alert(arguments[0] + 10);
  } else if(arguments.length == 2){
    alert(arguments[0] + arguments[1])
  }
}
```

## 第4章 变量、作用域和内存问题

### 基本类型和引用类型的值

ECMAScript 变量可能包含两种不同数据类型的值：基本类型值和引用类型值。基本类型值指的是简单的数据段，而引用类型值指那些可能由多个值构成的对象。

#### 动态的属性

定义基本类型值和引用类型值的方式是类似的：创建一个变量并为该变量赋值。对于引用类型的值，我们可以为其添加属性和方法，也可以改变和删除其属性和方法。而基本类型值不能被添加。

#### 复制变量值

除了保存的方式不同之外，在从一个变量向另一个变量复制基本类型值和引用类型值时，也存在不同。

如果从一个变量向另一个变量复制基本类型的值，会在变量对象上创建一个新值，然后把该值复制到为新变量分配的位置上。示例：

```javascript
var num1 = 5;
var num2 = num1;
```

图示：

![](http://7xvxmb.com1.z0.glb.clouddn.com/170409-14.png)

当从一个变量向另一个变量复制引用类型的值时，**同样也会将存储在变量对象中的值复制一份放到为新变量分配的空间中**。不同的是，这个值的副本实际上是一个指针，而这个指针指向存储在堆中的另一个对象。复制操作结束后，两个变量实际上将引用同一个对象。因此，改变其中一个变量，就会影响另一个变量，示例如下：

```javascript
var obj1 = new Object();
var obj2 = obj1;
obj1.name = "Nicholas";
alert(obj2.name); //"Nicholas"
```

图示：

![](http://7xvxmb.com1.z0.glb.clouddn.com/170409-15.png)

#### 传递参数

ECMAScript 中所有函数的参数都是**按值传递**的。也就是说，把函数外部的值复制给函数内部的参数，就和把值从一个变量复制到另一个变量一样。**基本类型值的传递如同基本类型变量的复制一样，而引用类型值的传递，则如同引用类型变量的复制一样。**

在向参数传递基本类型的值时，被传递的值会被复制给一个局部变量（即命名参数，或者用ECMAScript 的概念来说，就是arguments 对象的一个元素）。在向参数传递引用类型的值时，会把这个值**在内存中的地址**复制给一个局部变量，**因此这个局部变量的变化会反映在函数的外部**。

#### 检测类型

typeof 操作符是确定一个变量是字符串、数值、布尔值，还是undefined 的最佳工具。如果变量的值是一个对象或null，则typeof 操作符会返回”object“。

检测是什么类型的对象，可以使用instanceof 操作符，语法如下：

```javascript
result = variable instanceof constructor
```

如果变量是给定引用类型的实例，那么instanceof 操作符就会返回true。

根据规定，所有引用类型的值都是Object 的实例。因此，在检测一个引用类型值和Object 构造函数时，instanceof 操作符始终会返回true。当然，如果使用instanceof 操作符检测基本类型的值，则该操作符会返回false，因为基本类型不是对象。

#### 小结

- 基本类型值在内存中占据固定大小的空间，因此被保存在**栈内存**中
- 从一个变量向另一个变量复制基本类型的值，会创建这个值的一个副本
- 引用类型的值是对象，保存在**堆内存**中
- 包含引用类型值的变量实际上包含的并不是对象本身，而是一个指向该对象的指针
- 从一个变量向另一个变量复制引用类型的值，复制的其实是指针，因此两个变量最终都指向同一个对象
- 确定一个值是哪种基本类型可以使用typeof 操作符，而确定一个值是哪种引用类型可以使用instanceof 操作符。

### 执行环境及作用域

执行环境定义了变量或函数有权访问的其他数据，决定了它们各自的行为。每个执行环境都有一个与之关联的变量对象，环境中定义的所有变量和函数都保存在这个对象中。虽然我们编写的代码无法访问这个对象，但解析器在处理数据时会在后台使用它。

全局执行环境是最外围的一个执行环境。在Web 浏览器中，全局执行环境被认为是window  对象，因此所有全局变量和函数都是作为window 对象的属性和方法创建的。

每个函数都有自己的执行环境。当执行流进入一个函数时，函数的环境就会被推入一个环境栈中。而在函数执行之后，栈将其环境弹出，把控制权返回给之前的执行环境。

当代码在一个环境中执行时，会创建变量对象的一个**作用域链**。作用域链的用途，是保证对执行环境有权访问的所有变量和函数的有序访问。作用域链的前端，始终都是当前执行的代码所在环境的变量对象。如果这个环境是函数，则将其**活动对象**作为变量对象。活动对象在最开始时只包含一个变量，即arguments 对象（这个对象在全局环境中是不存在的）。作用域链中的下一个变量对象来自包含（外部）环境，而再下一个变量对象则来自下一个包含环境。这样，一直延续到全局执行环境；全局执行环境的变量对象始终都是作用域链中的最后一个对象。

标识符解析是沿着作用域链一级一级地搜索标识符的过程。搜索过程始终从作用域链的前端开始，然后逐级地向后回溯，直至找到标识符为止（如果找不到标识符，通常会导致错误发生）。

内部环境可以通过作用域链访问所有的外部环境，但外部环境不能访问内部环境中的任何变量和函数。这些环境之间的联系是线性、有次序的。每个环境都可以向上搜索作用域链，以查询变量和函数名；但任何环境都不能通过向下搜索作用域链而进入另一个执行环境。

> 函数参数也被当做变量来对待，因此其访问规则与执行环境中的其他变量相同。

#### 延长作用域链

当执行流进入下列任何一个语句时，作用域链就会得到加长：

- try-catch 语句的catch 块
- with 语句

这两个语句都会在作用域链的前端添加一个变量对象。对with 语句来说，会将指定的对象添加到作用域链中。对catch 语句来说，会创建一个新的变量对象，其中包含的是被抛出的错误对象的声明。

#### 没有块级作用域

使用var 声明的变量会自动被添加到最接近的环境中。在函数内部，最接近的环境就是函数的局部环境；在with 语句中，最接近的环境是函数环境。如果初始化变量时没有使用var 声明，该变量会自动被添加到全局环境。

当在某个环境中为了读取或写入而引用一个标识符时，必须通过搜索来确定该标识符实际代表什么。搜索过程从作用域链的前端开始，向上逐级查询与给定名字匹配的标识符。如果在局部环境中找到了该标识符，搜索过程停止，变量就绪。如果在局部环境中没有找到该变量名，则继续沿作用域链向上搜索。搜索过程将一直追溯到全局环境的变量对象。如果在全局环境中也没有找到这个标识符，则意味着该变量尚未声明。

在这个搜索过程中，如果存在一个局部的变量的定义，则搜索会自动停止，不再进入另一个变量对象。换句话说，如果局部环境中存在着同名标识符，就不会使用位于父环境中的标识符。

如果在局部环境中需要访问同名的全局变量，需添加`window`。

#### 小结

- 执行环境有全局执行环境（也称为全局环境）和函数执行环境之分
- 每次进入一个新执行环境，都会创建一个用于搜索变量和函数的作用域链
- 函数的局部环境不仅有权访问函数作用域中的变量，而且有权访问其包含（父）环境，乃至全局环境
- 全局环境只能访问在全局环境中定义的变量和函数，而不能直接访问局部环境中的任何数据
- 变量的执行环境有助于确定应该何时释放内存

### 垃圾收集

JavaScript 具有自动垃圾收集机制，也就是说，执行环境会负责管理代码执行过程中使用的内存。

- 离开作用域的值将被自动标记为可以回收，因此将在垃圾收集期间被删除。
- ”标记清除“是目前主流的垃圾收集算法，这种算法的思想是给当前不使用的值加上标记，然后再回收其内存。
- 另一种垃圾收集算法是”引用计数“，这种算法的思想是跟踪记录所有值被引用的次数。JavaScript 引擎目前都不再使用这种算法。
- 在代码中存在循环引用现象时，”引用计数“算法就会导致问题。
- 解除变量的引用不仅有助于消除循环引用现象，而且对垃圾收集也有好处。为了确保有效地回收内存，应该及时解除不再使用的**全局对象、全局对象属性以及循环应用变量的引用**。

确保占用最少的内存可以让页面获得更好的性能。而优化内存占用的最佳方式，就是为执行中的代码只保存必要的数据。一旦数据不再有用，最好通过将其设置为null 来释放其引用——这个做法叫做**解除引用**。这一做法适用于大多数全局变量和全局对象的属性。局部变量会在它们离开执行环境时自动被解除引用。

不过，解除一个值的引用并不意味着自动回收该值所占用的内存。解除引用的真正作用是让值脱离执行环境，以便垃圾收集器下次运行时将其回收。

## 第5章 引用类型

引用类型的值（对象）是**引用类型**的一个示例。在ECMAScript 中，引用类型是一种数据结构，用于将数据和功能组织在一起。

对象是某个特定引用类型的**实例**。新对象是使用`new`操作符后跟一个**构造函数**来创建的。构造函数本身就是一个函数，只不过该函数是出于创建新对象的目的而定义的。

### Object 类型

创建Object 实例的方式有两种。第一种是使用new 操作符后跟Object 构造函数。

```javascript
var person = new Object();
person.name = "Nicholas";
person.age = 29;
```

另一种方式是使用**对象字面量**表示法。对象字面量是对象定义的一种简写形式，目的在于简化创建包含大量属性的对象的过程。

```javascript
var person = {
  name : "Nicholas",
  age : 29
}
```

在这个例子中，左边的花括号`{`表示对象字面量的开始，因为它出现在了表达式上下（expression context）文中。ECMAScript 中的表达式上下文指的是该上下文期待一个值（表达式）。赋值操作符表示后面是一个值，所以左花括号在这里表示一个表达式的开始。同样的花括号，如果出现在一个语句上下文（statement context）中，例如跟在if 语句条件的后面，则表示一个语句块的开始。

在使用对象字面量语法时，属性名也可以使用字符串。如果留空其花括号，则可以定义只包含默认属性和方法的对象。

对象字面量也是向函数传递大量**可选参数**的首选方式。

访问对象属性时使用的是点表示法。不过，在JavaScript 也可以使用方括号表示法来访问对象的属性。在使用方括号语法时，应该将要访问的属性以字符串的形式放在方括号中。方括号语法的主要优点是可以通过变量来访问属性。如果属性名中包含会导致语法错误的字符，或者属性名使用的是关键字或保留字，也可以使用方括号表示法。通常，除非必须使用变量来访问属性，否则**建议使用点表示法。**

### Array 类型

ECMAScript 中的数组与其他多数语言中的数组有着相当大的区别。ECMAScript 数组的每一项可以保存任何类型的数据。且ECMAScript 数组的大小是可以动态调整的。

创建数组的基本方式有两种。第一种是使用Array 构造函数，如：

```javascript
var colors = new Array()
```

第二种方式是使用数组字面量表示法。数组字面量由一对包含数组项的方括号表示，多个数组项之间以逗号隔开。如：

```javascript
var colors = ["red","blue","green"];
```

数组的length 属性很有特点——它不是只读的。因此，通过设置这个属性，可以从数组的末尾移除项或向数组中添加新项。如果将其length 属性设置为大于数组项数的值，则新增的每一项都会取得undefined 值。

#### 检测数组

对于一个网页，或者一个全局作用域而言，使用instanceof 操作符即可：

```javascript
if (value instanceof Array){
  // 对数组执行某些操作
}
```

ECMAScript 5 新增了`Array.isArray()`方法。这个方法的目的是最终确定某个值到底是不是数组，而不管它是在哪个全局执行环境中创建的。用法如下：

```javascript
if (Array.isArray(value)){
  // 对数组执行某些操作
}
```

#### 转换方法

调用数组的`toString()`方法会返回由数组中每个值得字符串形式拼接而成的一个以逗号分隔的字符串。而调用`valueOf()`返回的还是数组。

`toLocaleString()`方法经常也会返回与`toString()`和`valueOf()`方法相同的值，但也不总是如此。

以上三种方法，在默认情况下都会以逗号分隔的字符串的形式返回数组项。而如果使用`join()`方法，则可以使用不同的分隔符来构建这个字符串。`join()`方法只接收一个参数，即用作分隔符的字符串，然后返回包含所有数组项的字符串。

```javascript
var colors = ["red","green","blue"];
alert(colors.join(",")) //red,green,blue
alert(colors.join("||"))  //red||green||blue
```

如果不给`join()`方法传入任何值，或者给它传入`undefined`，则使用逗号作为分隔符。

#### 栈方法

数组可以表现的就像栈一样，后者是一种可以限制插入和删除项的数据结构。栈是一种 LIFO（Last-In-First-Out，后进先出）的数据结构，也就是最新添加的项最早被移除。而栈中项的插入（叫做**推入**）和移除（叫做**弹出**），只发生在一个位置——栈的顶部。ECMAScript 为数组专门提供了`push()`和`pop()`方法，以便实现类似栈的行为。

`push()`方法可以接受任意数量的参数，把它们逐个添加到数组末尾，并返回修改后数组的长度。而`pop()`方法则从数组末尾移除最后一项，减少数组的`length`值，然后返回移除的项。

#### 队列方法

队列数据结构的访问规则是FIFO（First-In-First-Out，先进先出）。队列在列表的末端添加项，从列表的前端移除项。`shift()`方法可以移除数组中的第一个项并返回该项，同时数组长度减1。结合使用`shift()`和`push()`方法，可以像使用队列一样使用数组。

`unshift()`方法能在数组前端添加任意个项并返回新数组的长度。同时使用`unshift()`和`pop()`方法，可以从相反的方向来模拟队列，即在数组的前端添加项，从数组末端移除项。

#### 重排序方法

`reverse()`方法会反转数组项的顺序。

在默认情况下，`sort()`方法按升序排列数组项——即最小的值位于最前面，最大的值排在最后面。为了实现排序，`sort()`方法会调用每个数组项的`toString()`转型方法，然后比较得到的字符串，以确定如何排序。即使数组中的每一项都是数值，`sort()`方法比较的也是字符串。

`sort()`方法可以接收一个比较函数作为参数，以便指定哪个值位于哪个值前面。比较函数接受两个参数，如果第一个参数应该位于第二个之前则返回一个负数，如果两个参数相等则返回0，如果第一个参数应该位于第二个之后则返回一个正数。

#### 操作方法

`concat()`方法可以基于当前数组中的所有项创建一个新数组。具体来说，这个方法会先创建当前数组的一个副本，然后将接收到的参数添加到这个副本的末尾，最后返回新构建的数组。在没有给`concat()`方法传递参数的情况下，它只是复制当前数组并返回副本。

`slice()`能够基于当前数组中的一或多个项创建一个新数组。`slice()`方法可以接受一或两个参数，即要返回项的起始和结束为止。在只有一个参数的情况下，该方法返回从该参数指定为止开始到当前数组末尾的所有项。 **`slice()`方法不会影响原始数组。**

> 如果`slice()`方法的参数中有一个负数，则用数组长度加上该数来确定相应的位置。如果结束位置小于起始位置，则返回空数组。

`splice()`的主要用途是向数组的中部插入项，方法：

- **删除**：可以删除任意数量的项，只需指定2个参数：要删除的第一项的位置和要删除的项数。例如，`splice(0,2)`会删除数组中的前两项。
- **插入**：可以向指定位置插入任意数量的项，只需提供3个参数：起始位置、0（要删除的项数）和要插入的项。如果要插入多个项，可以再传入第四、第五，以至任意多个项。
- **替换**：可以向指定位置插入任意数量的项，且同时删除任意数量的项，只需指定3个参数：起始位置、要删除的项数和要插入的任意数量的项。插入的项数不必与删除的项数相等。

`splice()`方法始终都会返回一个数组，该数组包含从原始数组中删除的项。

#### 位置方法

- indexOf()
- lastIndexOf()

接收两个参数：要查找的项和表示查找起点位置的索引（可选）。

返回要查找的项在数组中的位置，或者在没找到的情况下返回-1。查找时必须严格相等（===）。

#### 迭代方法

ECMAScript 5 为数组定义了5个迭代方法。每个方法都接收两个参数：要在每一项上运行的函数和运行该函数的作用域对象——影响this 的值（可选）。传入这些方法中的函数会接收三个参数：数组项的值、该项在数组中的位置和数组对象本身。

- every()：对数组中的每一项运行给定函数，如果该函数对每一项都返回true，则返回true
- filter()：对数组中的每一项运行给定函数，返回该函数会返回true 的项组成的数组
- forEach()：对数组中的每一项运行给定函数。这个方法没有返回值
- map()：对数组中的每一项运行给定函数，返回每次函数调用的结果组成的数组
- some()：对数组中的每一项运行给定函数，只要有任一项返回true，则返回true

filter() 示例：

```javascript
var numbers = [1,2,3,4,5,4,3,2,1];
var filterResult = number.filter(function(item,index,array){
  return (item>2);
});
alert(filterResult);  //[3,4,5,4,3]
```

map() 示例：

```javascript
var numbers = [1,2,3,4,5,4,3,2,1];
var mapResult = numbers.map(function(item,index,array){
  return item * 2;
});
alert mapResult;  //[2,4,6,8,10,8,6,4,2]
```

#### 归并方法

- reduce()
- reduceRight()

这两个方法都会迭代数组的所有项，然后构建一个最终返回的值。

这两个方法都接收两个参数：一个在每一项上调用的函数和作为归并基础的初始值（可选）。传给的函数接受4个参数：前一个值、当前值、项的索引和数组对象。这个函数返回的任何值都会作为第一个参数自动传给下一项。

使用reduce() 方法可以执行求数组中所有值之和的操作，例如：

```javascript
var values = [1,2,3,4,5];
var sum = values.reduce(function(prev,cur,index,array){
  return prev + cur;
});
alert (sum);  //15
```

### Date 类型

Date 类型使用自UTC 1970年1月1日零时开始经过的毫秒数来保存日期。

要创建一个日期对象，使用new 操作符和Date 构造函数即可：

```javascript
var now = new Date();
```

在调用Date 构造函数而不传递参数的情况下，新创建的对象自动获得当前日期和时间。

`Date.parse()`方法接收一个表示日期的字符串参数，然后尝试根据这个字符串返回相应日期的毫秒数。

`Date.UTC()`方法同样也返回表示日期的毫秒数，参数分别是年份、基于0的月份、月中的那一天、小时数、分钟、秒以及毫秒数。在这些参数中，只有前两个参数是必需的。

ECMAScript 5 添加了`Date.now()`方法，返回表示调用这个方法时的日期和时间的毫秒数。这个方法简化了使用Date 对象分析代码的工作。例如：

```javascript
var start = Date.now();
doSomething();
var stop = Date.now();
var result = stop - start;
```

### RegExp 类型

字面量形式：

```javascript
var expression = / pattern / flags ;
```

flags：

- g：表示全局模式global
- i：表示不区分大小写模式ignoreCase
- m：表示多行模式multiline

RegExp 构造函数：

```javascript
var pattern = new RegExp("pattern","flags");
```

模式中使用的所有**元字符**都必须转义。正则表达式中的元字符包括：

```
( [ { \ ^ $ | ) * + . ] }
```

#### RegExp 实例属性

- global：布尔值，表示是否设置了g 标志
- ignoreCase：布尔值，表示是否设置了i 标志
- lastIndex：整数，表示开始搜索下一个匹配项的字符位置，从0算起
- multiline：布尔值，表示是否设置了m 标志
- source：正则表达式的字符串表示，按照字面量形式而非传入构造函数中的字符串模式返回

#### RegExp 实例方法

主要方法是`exec()`，该方法是专门为捕获组而设计的。`exec()`接受一个参数，即要应用模式的字符串，然后返回包含**第一个匹配项**信息的数组；或者在没有匹配项的情况下返回null。返回的数组虽然是Array 的实例，但包含两个额外的属性：index 和input。其中，index 表示匹配项在字符串中的位置，而input 表示应用正则表达式的字符串。在数组中，**第一项是与整个模式匹配的字符串，其他项是与模式中的捕获组匹配的字符串**（如果模式中没有捕获组，则该数组只包含一项）。

对于exec() 方法而言，**即使在模式中设置了全局标志g ，它每次也只会返回一个匹配项**。在不设置全局标志的情况下，在同一个字符串上多次调用exec() 将始终返回第一个匹配项的信息。而在**设置全局标志的情况下，每次调用exec() 则都会在字符串中继续查找新匹配项**。

方法`test()`接受一个字符串参数。在模式与该参数匹配的情况下返回true；否则，返回false。此方法经常用在if 语句中。

#### RegExp 构造函数属性

![](http://7xvxmb.com1.z0.glb.clouddn.com/170410-1.png)

### Function 类型

由于函数是对象，因此函数名实际上也是一个指向函数对象的指针，不会与某个函数绑定。

使用函数声明语法定义：

```javascript
function sum(num1,num2){
  return num1 + num2;
}
```

使用函数表达式定义：

```javascript
var sum = function(num1,num2){
  return num1 + num2;
};
```

解析器在执行环境中加载数据时，对函数声明和函数表达式并非一视同仁。解析器会率先读取函数声明，并使其在执行任何代码之前可用；至于函数表达式，则必须等到解析器执行到它所在的代码行，才会真正被解释执行。

因为ECMAScript 中的函数名本身就是变量，所以函数也可以作为值来使用。也就是说，不仅可以像传递参数一样把一个函数传递给另一个函数，而且可以将一个函数作为另一个函数的结果返回。

#### 函数内部属性

- arguments
- this

虽然arguments 的主要用途是保存函数参数，但这个对象还有一个名叫`callee`的属性，该属性时一个指针，指向拥有这个arguments 对象的函数。

阶乘函数示例，使用arguments.callee ，可消除紧密耦合的现象：

```javascript
function factorial(num){
  if (num<=1){
    return 1;
  } else {
    return num*arguments.callee(num-1);
  }
}
```

this 引用的是**函数执行的环境对象**。例如在网页的全局作用域中调用函数时，this 对象引用的就是window。

ECMAScript 5 也规范化了另一个函数对象的属性：caller。这个属性中保存着调用当前函数的函数的引用，如果是在全局作用域中调用当前函数，它的值为null。

#### 函数属性和方法

ECMAScript 中的函数是对象，因此函数也有属性和方法。每个函数都包含两个属性：length 和 prototype。

length 属性表示函数希望接收的命名参数的个数。

每个函数都包含两个非继承而来的方法：apply() 和call()。这两个方法的用途都是在特定的作用域中调用函数，实际上等于设置函数体内this 对象的值。

apply() 方法接收两个参数：一个是在其中运行函数的作用域，另一个是参数数组。其中，第二个参数可以是Array 的实例，也可以是arguments 对象。

call() 方法接受的第一个参数this 值和上面相同，变化的是其余参数都直接传递给函数。换句话说，传递给函数的参数必须逐个列举出来。

**apply() 和call() 真正强大的地方是能够扩充函数赖以运行的作用域**，示例：

```javascript
window.color = "red";
var o = {color:"blue"};
function sayColor(){
  alert(this.color);
}
sayColor(); //red
sayColor.call(this);  //red
sayColor.call(window);  //red
sayColor.call(o); //blue
```

### 基本包装类型

引用类型与基本包装类型的主要区别就是对象的生存期。使用new 操作符创建的引用类型的实例，在执行流离开当前作用域之前都一直保存在内存中。而自动创建的基本包装类型的对象，则只存在于一行代码的执行瞬间，然后立即被销毁。这意味着我们不能在运行时为基本类型值添加属性和方法。

#### Number 类型

toFixed() 方法会按照指定的小数位返回数值的字符串表示，例如：

```javascript
var num = 10;
alert(num.toFixed(2));  //"10.00"
```

toExponential() 方法返回以指数表示法表示的数值的字符串形式。

```javascript
var num = 10;
alert(num.toExponentia(1)); //"1.0e+1"
```

#### String 类型

String 类型的每个实例都有一个length 属性，表示字符串中包含多个字符。

两个用于访问字符串中特定字符的方法是：charAt() 和 charCodeAt()。

```javascript
var stringValue = "hello world";
alert(stringValue.charAt(1)); //"e"
alert(stringValue.charCodeAt(1)); //输出"101"
alert(stringValue[1]);  //"e"
```

concat() 用于将一或多个字符串拼接起来，返回拼接得到的新字符串。实践中更多使用加号操作符（+）

```javascript
var a = "hello";
var b = a.concat(" world");
var c = a.concat(" world","!");
alert(b); //"hello world"
alert(a); //"hello"
alert(c); //"hello world!"
```

基于子字符串创建新字符串的方法：

- slice()
- substr()
- substring()

字符串位置方法：

- indexOf()
- lastIndexOf()

从一个字符串中搜索给定的子字符串，然后返回子字符串的位置，如果没有找到该子字符串，则返回-1。

trim() 方法：创建一个字符串的副本，删除前置及后缀的所有空格，然后返回结果。

大小写转换方法：

- toLowerCase()
- toUpperCase()

字符串中匹配模式的方法：

- match()
- search()

替换方法replace()：

```javascript
var text = "cat, bat, sat, fat";
var result = text.replace("at","ond");
alert(result);  //"cond, bat, sat, fat"
result = text.replace(/at/g,"ond");
alert(result);  //"cond, bond, sond, fond"
```

split() 可以基于指定的分隔符将一个字符串分割成多个子字符串，并将结果放在一个数组中。

fromCharCode() 接收一或多个字符编码，然后将它们转换成一个字符串。从本质上来看，这个方法与实例方法charCodeAt() 执行的是相反的操作。

### 单体内置对象

在所有代码执行之前，作用域中就已经存在两个内置对象：Global 和Math。在大多数ECMAScript 实现中都不能直接访问Global 对象；不过，Web 浏览器实现了承担该角色的window 对象。全局变量和函数都是Global 对象的属性。Math 对象提供了很多属性和方法，用于辅助完成复杂的数学计算任务。

#### Global 对象

URI编码方法：

- encodeURI()
- encodeURIComponent()
- decodeURI()
- decodeURIComponent()

eval() 方法就像是一个完整的ECMAScript 解析器，它只接受一个参数，即要执行的ECMAScript（或JavaScript）字符串。

当解析器发现代码中调用eval() 方法时，它会将传入的参数当做实际的ECMAScript 语句来解析，然后把执行结果插入到原位置。通过eval() 执行的代码被认为是包含该次调用的执行环境的一部分，因此被执行的代码具有与该执行环境相同的作用域链。这意味着通过eval() 执行的代码可以引用在包含环境定义的变量。

> 使用eval() 时必须谨慎，特别是在它执行用户输入数据的情况下。否则，可能会有恶意用户输入威胁你的站点或应用程序安全的代码（代码注入）。

#### Math 对象

Math 对象包含的属性大都是数学计算中可能会用到的一些特殊值。

![](http://7xvxmb.com1.z0.glb.clouddn.com/170410-2.png)

min() 和 max() 方法用于确定一组数值中的最小值和最大值。这两个方法都可以接收任意多个数值参数。

**如需要找到数组中的最大或最小值，可以使用apply() 方法**：

```javascript
var values = [1,2,3,4,5];
var max = Math.max.apply(Math,values);
```

舍入方法：

- Math.ceil() 执行向上舍入
- Math.floor() 执行向下舍入
- Math.round() 执行标准舍入（四舍五入）

Math.random() 方法返回大于等于0小于1的一个随机数。套用下面的公式，就可以利用Math.random() 从某个整数范围内随机选择一个值：

```javascript
值 = Math.floor(Math.random() * 可能值的总数 + 第一个可能的值)
```

其他方法：

![](http://7xvxmb.com1.z0.glb.clouddn.com/170410-3.png)

## 第6章 面向对象的程序设计

ECMAScript 中没有类的概念，因此它的对象也与基于类的语言中的对象有所不同。

可以把ECMAScript 的对象想象成散列表：无非就是一组名值对，其中值可以是数据或函数。

每个对象都是基于一个引用类型创建的。

### 理解对象

#### 属性类型

ECMAScript 有两种属性：数据属性和访问器属性。

数据属性包含一个数据值的位置。在这个位置可以读取和写入。数据属性有4个描述其行为的特性。

- [[Configurable]]：表示能否通过delete 删除属性从而重新定义属性，能否修改属性的特性，或者能否把属性修改为访问器属性。
- [[Enumerable]]：表示能否通过for-in 循环返回属性。
- [[Writable]]：表示能否修改属性的值。
- [[Value]]：包含这个属性的数据值。读取属性值的时候，从这个位置读；写入属性值的时候，把新值保存在这个位置。这个特性的默认值为undefined。

要修改属性默认的特性，必须使用ECMAScript 5 的Object.defineProperty() 方法。这个方法接收三个参数：属性所在的对象、属性的名字和一个描述符对象。其中描述符对象的属性必须是：configurable、enumerable、writable 和value。设置其中的一或多个值，可以修改对应的特性值。

访问器属性不包含数据值。有如下4个特性：

- [[Configurable]]
- [[Enuerable]]
- [[Get]]：在读取属性时调用的函数。默认值为undefined。
- [[Set]]：在写入属性时调用的函数。默认值为undefined。

访问器属性不能直接定义，必须使用Object.defineProperty() 来定义。

访问器属性的常见使用方式：设置一个属性的值会导致其他属性发生变化。

#### 定义多个属性

由于为对象定义多个属性的可能性很大，ECMAScript 5 又定义了一个Object.defineProperties() 方法。利用这个方法可以通过描述符一次定义多个属性。这个方法接收两个对象参数：第一个对象是要添加和修改其属性的对象，第二个对象的属性与第一个对象中要添加或修改的属性一一对应。

#### 读取属性的特性

使用ECMAScript 5 的Object.getOwnPropertyDescriptor() 方法，可以取得给定属性的描述符。这个方法接收两个参数：属性所在的对象和要读取其描述符的属性名称。返回值是一个对象，如果是访问器属性，这个对象的属性有configurable、enumerable、get和set；如果是数据属性，这个对象的属性有configurable、enumerable、writable和value。

### 创建对象

用Object 构造函数或对象字面量创建单个对象的缺点：使用同一个接口创建很多对象，会产生大量的重复代码。

#### 工厂模式

工厂模式抽象了创建具体对象的过程。考虑到在ECMAScript 中无法创建类，开发人员就发明了一种函数，用函数来封装以特定接口创建对象的细节，例如：

```javascript
function createPerson(name, age, job){
  var o = new Object();
  o.name = name;
  o.age = age;
  o.job = job;
  o.sayName = function(){
    alert(this.name);
  };
  return o;
}
var person1 = createPerson("Nicholas", 29, "Software Engineer");
var person2 = createPerson("Greg", 27, "Doctor");
```

函数createPerson() 能够根据接受的参数来构建一个包含所有必要信息的Person 对象。可以无数次地调用这个函数，而每次它都会返回一个包含三个属性和一个方法的对象。工厂模式虽然解决了创建多个相似对象的问题，但却没有解决对象识别的问题（即怎么知道一个对象的类型）。

#### 构造函数模式

```javascript
function Person(name, age, job){
  this.name = name;
  this.age = age;
  this.job = job;
  this.sayName = function(){
    alert(this.name);
  };
}
var person1 = new Person("Nicholas", 29, "Software Engineer");
var person2 = new Person("Greg", 27, "Doctor");
```

Person() 中的代码与createPerson() 有存下下面不同：

- 没有显式地创建对象
- 直接将属性和方法赋给了this 对象
- 没有return 语句

函数名Person 使用的是大写字母P。按照惯例，构造函数始终都应该以一个大写字母开头，而非构造函数则应该以一个小写字母开头。主要是为了区别于ECMAScript 中的其他函数，因为构造函数本身也是函数，只不过可以用来创建对象而已。

要创建Person 的新实例，必须使用new 操作符。以这种方式调用构造函数实际上会经历以下4个步骤：

1. 创建一个新对象
2. 将构造函数的作用域赋给新对象（因此this 就指向了这个新对象）
3. 执行构造函数中的代码（为这个新对象添加属性）
4. 返回新对象

此例的两个对象都有constructor （构造函数）属性，该属性指向Person。

```javascript
alert(person1.constructor == Person); //true
```

对象的constructor 属性最初是用来标识对象类型的。还可用instanceof 来检测对象类型。

```javascript
alert(person1 instanceof Object); //true
alert(person1 instanceof Person); //true
```

可看出通过上例创建的所有对象既是Object 的实例，也是Person 的实例。

创建自定义的构造函数意味着将来可以将它的实例标识为一种特定的类型；而这正是构造函数模式胜过工厂模式的地方。

构造函数与其他函数的唯一区别，**就在于调用它们的方式不同**。不过，构造函数毕竟也是函数，不存在定义构造函数的特殊语法。任何函数，只要通过new 操作符来调用，那它就可以作为构造函数；而任何函数，如果不通过new 操作符来调用，那它跟普通函数也不会有什么两样。

构造函数的缺点：每个方法都要在每个实例上重新创建一遍。

#### 原型模式

我们创建的每个函数都有一个prototype（原型）属性，这个属性是一个指针，指向一个对象，而这个对象的用途是包含可以由特定类型的所有实例共享的属性和方法。prototype 就是通过调用构造函数而创建的那个对象实例的原型对象。使用原型对象的好处是可以让所有对象实例共享它所包含的属性和方法。换句话说，不必在构造函数中定义对象实例的信息，而是可以将这些信息直接添加到原型对象中。示例：

```javascript
function Person(){
}
Person.prototype.name = "Nicholas";
Person.prototype.age = 29;
Person.prototype.job = "Software Engineer";
Person.prototype.sayName = function(){
  alert(this.name);
};
var person1 = new Person();
person1.sayName();  //"Nicholas"
var person2 = new Person();
person2.sayName();  //"Nicholas"
alert(person1.sayName == person2.sayName);  //true
```

![](http://7xvxmb.com1.z0.glb.clouddn.com/170411-1.png)

实例中的[[Prototype]] 这个连接存在于实例与函数的原型对象之间，而不是存在于实例与构造函数之间。**实例中的指针仅指向原型，而不指向构造函数。**

```javascript
alert(Person.prototype.isPrototypeOf(person1)); //true
alert(Object.getPrototypeOf(person1) == Person.prototype);  //true
alert(Object.getPrototypeOf(person1).name); //"Nicholas"
```

每当代码读取某个对象的某个属性时，都会执行一次搜索，目标是具体给定名字的属性。搜索首先从对象实例本身开始。如果在实例中找到了具有给定名字的属性，则返回该属性的值；如果没有找到，则继续搜索指针指向的原型对象，在原型对象中查找具有给定名字的属性。如果在原型对象中找到了这个属性，则返回该属性的值。

当为对象实例添加一个属性时，这个属性就会屏蔽原型对象中保存的同名属性；换句话说，添加这个属性只会阻止我们访问原型中的那个属性，但不会修改那个属性。使用delete 操作符可以完全删除实例属性，从而让我们能够重新访问原型中的属性。

使用hasOwnProperty() 方法可以检测一个属性是存在于实例中，还是存在于原型中。这个方法只在给定属性存在于对象实例中时，才会返回ture。

```javascript
alert(person1.hasOwnProperty("name"));  //false
person1.name = "Greg";
alert(person1.name);  //"Greg"——来自实例
alert(person1.hasOwnProperty("name")) //true

delete person1.name;
alert(person1.name);  //"Nicholas"——来自原型
alert(person1.hasOwnProperty("name"));  //false
```

in 操作符会在通过对象能够访问给定属性时返回ture，无论该属性存在于实例中还是原型中。

同时使用hasOwnProperty() 方法和in 操作符，就可以确定该属性到底是存在于对象中，还是存在于原型中。

要取得对象上所有可枚举的实例属性，可以使用ECMAScript 5 的Object.keys() 方法。这个方法接收一个对象作为参数，返回一个包含所有可枚举属性的字符串数组。

如果想得到所有实例属性，无论是否可枚举，可以使用Object.getOwnPropertyNames() 方法。

为了减少不必要的输入，也为了从视觉上更好地封装原型的功能，更常见的做法是用一个包含所有属性和方法的对象字面量来重写整个原型对象。但需注意`constructor`。

由于在原型中查找值的过程是一次搜索的，因此我们对原型对象所做的任何修改都能够立即从实例上反映出来——即使是先创建了实例后修改原型也照样如此。

原型模式缺点：

- 所有实例在默认情况下都将取得相同的属性值
- 若原型中包含**引用类型值**的属性，会出现所有实例共享的问题

#### 组合使用构造函数模式和原型模式

创建自定义类型的最常见方式，就是组合使用构造函数模式与原型模式。构造函数模式用于定义实例属性，而原型模式用于定义方法和共享的属性。结果，每个实例都会有自己的一份实例属性的副本，但同时又共享着对方法的引用，最大限度地节省了内存。另外，这种混成模式还支持向构造函数传递参数；可谓是集两种模式之长。示例：

```javascript
function Person(name, age, job){
  this.name = name;
  this.age = age;
  this.job = job;
  this.friends = ["Shelby", "Court"];
}
Person.prototype = {
  constructor : Person,
  sayName : function(){
    alert(this.name);
  }
}
var person1 = new Person("Nicholas", 29, "Software Engineer");
var person2 = new Person("Greg", 27, "Doctor");
person1.friends.push("Van");
alert(person1.friends); //"Shelby,court,Van"
alert(person2.friends); //"Shelby,court"
alert(person1.friends === person2.friends); //false
alert(person1.sayName === person2.sayName); //true
```

这种构造函数与原型混成的模式，是目前在ECMAScript 中使用最广泛、认同度最高的一种创建自定义类型的方法。可以说，**这是用来定义引用类型的一种默认模式**。

#### 动态原型模式

```javascript
function Person(name, age, job){
  //属性
  this.name = name;
  this.age = age;
  this.job = job;
  //方法
  if (typeof this.sayName != "function"){
    Person.prototype.sayName = function(){
      alert(this.name);
    };
  }
}
var friend = new Person("Nicholas", 29, "Software Engineer");
friend.sayName();
```

### 继承

许多OO 语言都支持两种继承方式：接口继承和实现继承。接口继承只继承方法签名，而实现继承则继承实现的方法。由于函数没有签名，在ECMAScript 中无法实现接口继承。ECMAScript 只支持实现继承，而且其实现继承主要是依靠原型链来实现的。

#### 原型链

构造函数、原型和实例的关系：每个构造函数都有一个原型对象，原型对象都包含一个指向构造函数的指针，而实例都包含一个指向原型对象的内部指针。

原型链的基本概念为：让原型对象等于另一个类型的实例。此时的原型对象将包含一个指向另一个原型的指针，相应地，另一个原型中也包含着一个指向另一个构造函数的指针。

实现原型链有一种基本模式，代码大致如下：

```javascript
function SuperType(){
  this.property = true;
}
SuperType.prototype.getSuperValue = function(){
  return this.property;
};
function SubType(){
  this.subproperty = false;
}
// 通过重写原型对象，继承了SuperType
SubType.prototype = new SuperType();
SubType.prototype.getSubValue = function(){
  return this.subproperty;
};
var instance = new SubType();
alert(instance.getSuperValue());  //true
```

**实现继承的本质是重写原型对象，代之以一个新类型的实例。**换句话说，原来存在于SuperType 的实例中的所有属性和方法，现在也存在于SubType.prototype 中了。新原型不仅具有作为一个SuperType 的实例所拥有的全部属性和方法，而且其内部还有一个指针，指向了SuperType 的原型。

![](http://7xvxmb.com1.z0.glb.clouddn.com/170411-2.png)

最终的结果是这样的：instance 指向了SubType 的原型，SubType 的原型又指向了SuperType 的原型。

需注意instance.constructor 现在指向的是SuperType。

确定原型和实例的关系：

- instanceof
- isPrototypeOf()

给原型添加方法的代码一定要放在替换原型的语句之后。

在通过原型链实现继承时，不能使用对象字面量创建原型方法。因为这样做会重写原型链。

原型链的问题：

- 包含引用类型值时
- 创建子类型的实例时，不能向超类型的构造函数中传递参数

#### 借用构造函数

在子类型构造函数的内部调用超类型构造函数。函数只不过是在特定环境中执行代码的对象，因此通过使用apply() 和call() 方法也可以在（将来）新创建的对象上执行构造函数，示例：

```javascript
function SuperType(){
  this.colors = ["red","blue","green"];
}
function SubType(){
  //继承了SuperType
  SuperType.call(this);
}
var instance1 = new SubType();
instance1.colors.push("black");
alert(instance1.colors);  //"red,blue,green,black"
var instance2 = new SubType();
alert(instance2.colors);  //"red,blue,green"
```

相对于原型链而言，借用构造函数有一个很大的优势，即可以在子类型构造函数中向超类型构造函数传递参数。

缺点：方法都需在构造函数中定义，不能复用函数。

#### 组合继承

使用原型链实现对原型属性和方法的继承，而通过借用构造函数来实现对实例属性的继承。既通过在原型上定义方法实现了函数复用，又能够保证每个实例都有它自己的属性。

组合继承避免了原型链和借用构造函数的缺陷，融合了它们的优点，成为JavaScript 中最常用的继承模式。

#### 寄生式继承

```javascript
function createAnother(original){
  var clone = Object(original); //通过调用函数创建一个新对象
  clone.sayHi = function(){ //以某种方式来增强这个对象
    alert("hi");
  };
  return clone; //返回这个对象
}
```

#### 寄生组合式继承

组合继承无论什么情况下，都会调用两次超类型构造函数：一次是在创建子类型原型的时候，另一次是在子类型构造函数构造函数内部。

寄生组合式继承：不必为了指定子类型的原型而调用超类型的构造函数，我们所需要的无非就是超类型原型的一个副本而已。

```javascript
function inheritPrototype(subType, superType){
  var prototype = Object(superType.prototype);  //创建对象
  prototype.constructor = subType;  //弥补下一步重写原型而失去的默认的constructor
  subType.prototype = prototype;  //指定对象
}

function SuperType(name){
  this.name = name;
  this.colors = ["red","blue","green"];
}
SuperType.prototype.sayName = function(){
  alert(this.name);
};
function SubType(name,age){
  SuperType.call(this,name);
  this.age = age;
}
inheriPrototype(SubType,SuperType);
SubType.prototype.sayAge = function(){
  alert(this.age);
}
```

这个例子的高效率体现在它只调用了一次SuperType 构造函数，并且因此避免了在SubType.prototype 上面创建不必要的、多余的属性。与此同时，原型链还能保持不变；因此，还能够正常使用instanceof 和isPrototypeOf() 。开发人员普遍认为**寄生组合式继承是引用类型最理想的继承范式**。

## 第7章 函数表达式

函数声明：

```javascript
function functionName(arg0,arg1,arg2){
  //函数体
}
```

函数表达式最常见的一种形式：

```javascript
var functionName = function(arg0,arg1,arg2){
  //函数体
}
```

创建一个函数并将它赋值给变量，这种情况下创建的函数叫做**匿名函数**，又称**拉姆达函数**。

在把函数当成值来使用的情况下，都可以使用匿名函数。

### 递归

递归函数是在一个函数通过名字调用自身的情况下构成的。

```javascript
var factorial = (function f(num){
  if (num <= 1){
    return 1;
  } else {
    return num * f(num-1)
  }
})
```

以上代码创建了一个名为f() 的命名函数表达式，然后将它赋值给变量factorial 。即便把函数赋值给另一个变量，函数的名字f 仍然有效，所以递归调用照样能正确完成。

#### 闭包

闭包是指有权访问另一个函数作用域中的变量的函数。创建闭包的常见方式就是在一个函数内部创建另一个函数。

闭包只能取得包含函数中任何变量的最后一个值。闭包所保存的是整个变量对象，而不是某个特殊的变量。

#### 模仿块级作用域

JavaScript 没有块级作用域的概念。在块语句中定义的变量，实际上是在包含函数中而非语句中创建的。

用作块级作用域（**私有作用域**）的匿名函数的语法如下：

```javascript
(function(){
  //这里是块级作用域
})();
```

以上代码定义并立即调用了一个匿名函数。将函数声明包含在一对圆括号中，表示它实际上是一个**函数表达式**。而紧随其后的另一对圆括号会立即调用这个函数。

无论在什么地方，只要临时需要一些变量，就可以使用私有作用域。

#### 私有变量

任何在函数中定义的变量，都可以认为是私有变量，因为不能在函数的外部访问这些变量。私有变量包括函数的参数、局部变量和在函数内部定义的其他函数。

用于访问私有变量的公有方法：在函数内部创建一个闭包，闭包可以通过自己的作用域链访问函数内部的变量。

有权访问私有变量和私有函数的公有方法称为**特权方法**。

## 第8章 BOM

BOM 提供了很多对象，用于访问浏览器的功能，这些功能与任何网页内容无关。

### window 对象

BOM 的核心对象时window ，它表示浏览器的一个实例。在浏览器中，window 对象有双重角色，它既是通过JavaScript 访问浏览器窗口的一个接口，又是ECMAScript 规定的Global 对象。

#### 全局作用域

所有在全局作用域中声明的变量、函数都会变成window 对象的属性和方法。

#### 窗口位置

使用下列代码可以跨浏览器取得窗口左边和上边的位置：

```javascript
var leftPos = (typeof window.screenLeft == "number") ? window.screenLeft : window.screenX;
var topPos = (typeof window.screenTop == "number") ? window.screenTop : window.screenY;
```

使用moveTo() 和moveBy() 将窗口精确地移动到一个新位置。这两个方法都接收两个参数，其中moveTo() 接收的是新位置的x 和y 坐标值，而moveBy() 接收的是在水平和垂直方向上移动的像素数。

#### 窗口大小

- innerWidth
- innerHeight
- outerWidth
- outerHeight

虽然最终无法确定浏览器窗口本身的大小，但却可以取得页面视口的大小：

```javascript
var pageWidth = window.innerWidth,
    pageHeight = window.innerHeight;
if (typeof pageWidth != "number"){
  if (document.compatMode == "CSS1Compat") {
    pageWidth = document.documentElement.clientWidth;
    pageHeight = document.documentElement.clientHeight;
  } else {
    pageWidth = document.body.clientWidth;
    pageHeight = document.body.clientHeight;
  }
}
```

使用resizeTo() 和 resizeBy() 方法可以调整浏览器窗口的大小。这两个方法都接收两个参数。其中 resizeTo() 接收浏览器窗口的新宽度和新高度，而resiziBy() 接收新窗口与原窗口的宽度和高度之差。

#### 导航和打开窗口

window.open()  方法既可以导航到一个特定的URL，也可以打开一个新的浏览器窗口。接收4个参数：要加载的URL、窗口目标、一个特性字符串以及一个表示新页面是否取代浏览器历史记录中当前加载页面的布尔值。通常只需传递第一个参数，最后一个参数只在不打开新窗口的情况下使用。

第二个参数可以是下列任何一个特殊的窗口名称：`_self`、`_parent`、`_top`、`_blank`。

如果给window.open() 传递的第二个参数并不是一个已经存在的窗口或框架，那么该方法就会根据在第三个参数位置上传入的字符串创建一个新窗口或新标签页。

第三个参数是一个逗号分隔的设置字符串，表示在新窗口中都显示哪些特性。

![](http://7xvxmb.com1.z0.glb.clouddn.com/170412-1.png)

window.open() 方法会返回一个指向新窗口的引用。引用的对象与其他window 对象大致相似，但我们可以对其进行更多控制。有些浏览器在默认情况下可能不允许我们针对主浏览器窗口调整大小或移动位置，但却允许我们针对通过window.open() 创建的窗口调整大小或移动位置。

```javascript
var a = window.open("http://www.baidu.com/","","height=400,width=400");
a.resizeTo(500,500);
a.moveTo(100,100);
a.close();
alert(a.closed);  //true
alert(a.opener == window);  //true
a.opener = null;  //切断新创建的标签页和打开它的标签页之间的通信
```

弹出窗口被屏蔽时，有两种可能性：

- 如果是浏览器内置的屏蔽程序阻止弹出窗口，那么window.open() 很可能会返回null
- 如果是浏览器扩展或其他程序阻止的弹出窗口，那么window.open() 通常会抛出一个错误

```javascript
var blocked = false;
try{
  var a = window.open("http://www.baidu.com/","_blank");
  if (a == null){
    blocked = true;
  }
} catch (ex){
  blocked = true;
}
if (blocked){
  alert("The popup was blocked!");
}
```

在任何情况下，以上代码都可以检测出调用window.open() 打开的弹出窗口是不是被屏蔽了。

#### 间歇调用和超时调用

- 超时调用：setTimeout()
- 间歇调用：setInterval()

都接收两个参数：要执行的代码和以毫秒表示测时间。

不建议在第一个参数传递字符串，可能会因此导致性能损失。

在使用超时调用时，没有必要跟踪超时调用ID，因为每次执行代码之后，如果不再设置另一次超时调用，调用就会自行停止。一般认为，**使用超时调用来模拟间歇调用是一种最佳模式**。在开发环境下，很少使用真正的间歇调用，原因是**后一个间歇调用可能会在前一个间歇调用结束之前启动**。而使用超时调用模拟间歇调用则可完全避免这一点。

#### 系统对话框

- alert()
- confirm() —— 返回值为true 表示单击了OK，false 表示 Cancel 或单击右上角关闭
- prompt() —— 接收两个参数：要显示给用户的文本提示和文本输入域的默认值。若单击OK，返回文本输入域的值，否则返回null

显示对话框的时候代码会停止执行，而关掉后代码又会恢复执行。

```javascript
//显示“打印”对话框
window.print();

//显示“查找”对话框
window.find();
```

#### location 对象

location 对象既是window 对象的属性，也是document 对象的属性；换句话说，window.location 和document.location 引用的是同一个对象。location 对象的用处不只表现在它保存着当前文档的信息，还表现在它将URL 解析为独立的片段。

![](http://7xvxmb.com1.z0.glb.clouddn.com/170412-2.png)

##### 查询字符串参数

下面函数用以解析查询字符串，然后返回包含所有参数的一个对象：

```javascript
function getQueryStringArgs(){
  //取得查询字符串并去掉开头的问号
  var qs = (location.search.length > 0 ? location.search.substring(1) : ""),
      //保存数据的对象
      args = {},
      //取得每一项
      items = qs.length ? qs.split("&") : [],
      item = null,
      name = null,
      value = null,
      //在for循环中使用
      i = 0,
      len = items.length;
  // 逐个将每一项添加到args 对象中
  for (i=0; i<len; i++){
    item = items[i].split("=");
    name = decodeURIComponent(item[0]);
    value = decodeURIComponent(item[1]);
    if (name.length){
      args[name] = value;
    }
  }
  return args;
}

//假设查询字符串是?q=javascript&num=10
var args = getQueryStringArgs();
alert(args["q"]); //"javascript"
alert(args["num"]); //"10"
```

##### 位置操作

使用location 对象可以通过很多方式来改变浏览器的位置：

```javascript
//最常用的方式
location.assign("http://www.baidu.com/");

//调用assign()
window.location = "http://www.baidu.com/";
location.href = "http://www.baidu.com/";  //最常用

//修改location 对象的其他属性也可以改变当前加载的页面。每次修改location 的属性(除hash外)，页面都会以新URL重新加载
location.hash = "#section1";
location.search = "?q=javascript";
location.hostname = "www.google.com";
location.pathname = "mydir";
location.port = 8080;

//不能后退
location.replace("http://www.baidu.com/");

//重新加载
location.reload();  //有可能从缓存中加载
location.reload(true);  //从服务器重新加载
```

#### navigator 对象

![](http://7xvxmb.com1.z0.glb.clouddn.com/170412-3.png)

#### history 对象

```javascript
//后退一页
history.go(-1);
history.back();

//前进一页
history.go(1);
history.forward();

//前进两页
history.go(2);

//条换到最近的baidu.com页面
history.go("baidu.com");
```

## 第9章 客户端检测

不到万不得已，就不要使用客户端检测。只要能找到更通用的方法，就应该先采用更通用的方法。 

### 能力检测

能力检测的目标不是识别特定的浏览器，而是识别浏览器的能力。基本模式：

```javascript
if (object.propertyInQuestion){
  //使用object.propertyInQuestion
}
```

举例，IE5.0 之前的版本不支持document.getElementById() 这个DOM 方法。可作下面的能力检测：

```javascript
function getElement(id){
  if (document.getElementById){
    return document.getElementById(id);
  } else if (document.all){
    return document.all[id];
  } else {
    throw new Error("No way to retrieve element!");
  }
}
```

能力检测两个重要概念：

- 先检测达成目的的最常用的特性，保证代码的最优化
- 必须测试实际要用到的特性

更可靠的能力检测：**尽量使用typeof 进行能力检测**。

如果要知道自己的应用程序需要使用某些特定的浏览器特性，最好一次性检测所有相关特性，而不是分别检测。

```javascript
//确定浏览器是否支持Netscape风格的插件
var hasNSPlugins = !!(navigator.plugins && navigator.plugins.length);

//确定浏览器是否具有DOM1 级规定的能力
var hasDOM1 = !!(document.getElementById && document.createElement && document.getElementsByTagName);
```

### 怪癖检测

怪癖检测的目标是识别浏览器的特殊行为。例如检测IE8 中如果某个实力属性与[[Enumerable]] 标记为false 的某个原型属性同名时，此实例属性将不会出现在for-in 循环中的bug：

```javascript
var hasDontEnumQuirk = function(){
  var o = { toString : function(){} };
  for (var prop in o){
    if (prop == "toString"){
      return false;
    }
  }
  return true;
}();
```

#### 用户代理检测

用户代理检测通过检测用户代理字符串来确定实际使用的浏览器。在每一次HTTP 请求过程中，用户代理字符串是作为响应首部发送的，而且该字符串可以通过JavaScript 的navigator.userAgent 属性访问。在服务器端，通过检测用户代理字符串来确定用户使用的浏览器是一种常用而且广为接受的做法。而在客户端，用户代理检测一般被当做一种万不得已才用的做法，其优先级排在能力检测和怪癖检测之后。

## 第10章 DOM

### 节点层次

每一段标记都可以通过树中的一个节点来表示：HTML 元素通过元素节点表示，特性通过特性节点表示，文档类型通过文档类型节点表示，而注释则通过注释节点表示。总共有12种节点类型，这些类型都继承自一个基类型。

#### Node 类型

JavaScript 中的所有节点类型都继承自Node 类型，因此所有节点类型都共享着相同的基本属性和方法。

每个节点都有一个nodeType 属性，用于表明节点的类型。节点类型由在Node 类型中定义的12个数值常量表示。

每个节点都有一个childNodes 属性，其中保存着一个NodeList 对象。包含在childNodes 列表中的每个节点相互之间都是同胞节点。通过使用列表中每个节点的previousSibling 和 nextSibling 属性，可以访问同一列表中的其他节点。

每个节点都有一个parentNode 属性，该属性指向文档树中的父节点。

父节点的firstChild 和 lastChild 属性分别指向其childNodes 列表中的第一个和最后一个节点。

![](http://7xvxmb.com1.z0.glb.clouddn.com/170412-4.png)

hasChildNodes() 在节点包含一或多个子节点的情况下返回true。

ownerDocument 属性指向表示整个文档的文档节点。

appendChild() 用于向childNodes 列表的末尾添加一个节点。添加节点后，childNodes 的新增节点、父节点及以前的最后一个子节点的关系指针都会相应地得到更新。

如果传入到appendChild() 中的节点已经是文档的一部分了，那结果就是将该节点从原来的位置转移到新位置。因此，如果在调用appendChild() 时传入了父节点的第一个子节点，那么该节点就会成为父节点的最后一个子节点。

insertBefore() 插入节点，该方法接收两个参数：要插入的节点和作为参照的节点。如果参照节点为null ，则相当于appendChild() 操作。

replaceChild() 接收两个参数：要插入的节点和要替换的节点。要替换的节点将由这个方法返回并从文档树中被移除，同时由要插入的节点占据其位置。

removeChild() 只移除节点。被移除的节点将作为方法的返回值。

cloneNode() 用于创建调用这个方法的节点的一个完全相同的副本。cloneNode() 方法接收一个布尔值参数，表示是否执行深复制。在参数为true 的情况下，执行深复制。

normalize() 处理文档树中的文本节点。

#### Document 类型

document.documentElement 属性指向HTML 页面中的`<html>`元素。

document.body 直接指向`<body>`元素。

document.doctype 取得对`<!DOCTYPE>` 的引用。

```javascript
//取得文档标题
var originalTitle = document.title;
//设置文档标题
document.title = "New page title";

//取得完整的URL
var url = document.URL;
//取得域名
var domain = document.domain;
//取得来源页面的URL
var referrer = document.referrer;
```

查找元素：

- getElementById()
- getElementsByTagName()

namedItem() 方法可以通过元素的name 特性取得集合中的项。

要想取得文档中的所有元素，可以向getElementsByTagName() 中传入“*”。

getElementsByName() 方法返回带有给定name 特性的所有元素。

特殊集合：

- document.anchors
- document.forms
- document.images
- document.links

文档写入：

- write()
- writeln()
- open()
- close()

#### Element 类型

Element 节点具有以下特征：

- nodeType 的值为1
- nodeName 的值为元素的标签名
- nodeValue 的值为null
- parentNode 可能是Document 或Element

要访问元素的标签名，可以使用nodeName 属性或tagName属性。

HTML 元素可访问或修改其属性：

- id
- title
- className

操作特性的DOM 方法：

- getAttribute()
- setAttribute(要设置的特性名,值)
- removeAttribute()

因为所有特性都是属性，所以直接给属性赋值可以设置特性的值。

document.createElement() 方法可以创建新元素。这个方法接收一个参数，即要创建元素的标签名。

```javascript
var div = document.createElement("div");
```

#### Text 类型

文本节点由Text 类型表示，包含的是可以照字面解释的纯文本内容。纯文本中可以包含转义后的HTML 字符，但不能包含HTML 代码。Text 节点具有以下特征：

- nodeType 的值为3
- nodeName 的值为“#text”
- nodeValue 的值为节点所包含的文本
- parentNode 是一个Element
- 不支持（没有）子节点

可以通过nodeValue 属性或data 属性访问Text 节点中包含的文本，这两个属性中包含的值相同。

使用下列方法可以操作节点中的文本：

- appendData(text)
- deleteData(offset, count)
- insertData(offset, text)
- replaceData(offset, count, text)
- splitText(offset)
- substringData(offset, count)

document.createTextNode() 用来创建新文本节点，接收一个参数——要插入节点中的文本。

创建元素且向其中添加文本的代码示例：

```javascript
var element = document.createElement("div");
element.className = "message";
var textNode = document.createTextNode("Hello world!");
element.appendChild(textNode);
document.body.appendChild(element);
```

如果在一个包含两个或多个文本节点的父元素上调用normalize() 方法，则会将所有文本节点合并成一个节点，结果节点的nodeValue 等于将合并前每个文本节点的nodeValue 值拼接起来的值。

分割文本节点splitText() ，将一个文本节点分成两个文本节点。原来的文本节点将包含从开始位置到指定位置之前的内容，新文本节点将包含剩下的文本。用于从文本节点中提取数据。

### DOM 操作技术

#### 动态脚本

动态加载外部JavaScript 文件：

```javascript
function loadScript(url){
  var script = document.createElement("script");
  script.type = "text/javascript";
  script.src = url;
  document.body.appendChild(script);
}
loadScript("client.js");
```

行内形式：

```javascript
function loadScriptString(code){
  var script = document.createElement("script");
  script.type = "text/javascript";
  try {
    script.appendChild(document.createTextNode(code));
  } catch(ex) {
    script.text = code;
  }
  document.body.appendChild(script);
}
loadScriptString("function sayHi(){alert('hi');}");
```

#### 动态样式

```javascript
function loadStyles(url){
  var link = document.createElement("link");
  link.rel = "stylesheet";
  link.type = "text/css";
  link.href = url;
  var head = document.getElementsByTagName("head")[0];
  head.appendChild(link);
}
loadStyles("styles.css");
```

```javascript
function loadStyleString(css){
  var style = document.createElement("style");
  style.type = "text/css";
  try{
    style.appendChild(document.createTextNode(css));
  } catch(ex){
    style.styleSheet.cssText = css;
  }
  var head = document.getElementsByTagName("head")[0];
  head.appendChild(style);
}
loadStyleString("body{background-color:red}");
```

#### 使用NodeList

理解NodeList 及其“近亲” NamedNodeMap 和 HTMLCollection，是从整体上透彻理解DOM 的关键所在。这三个集合都是“动态的”；换句话说，每当文档结构发生变化时，他们都会得到更新。因此，它们始终都会保存着最新、最准确的信息。从本质上说，所有NodeList 对象都是在访问DOM 文档时实时运行的查询。

一般来说，应该尽量减少访问NodeList 的次数。因为每次访问NodeList，都会运行一次基于文档的查询。所以，可以考虑将从NodeList 中取得的值缓存起来。

DOM 操作往往是JavaScript 程序中开销最大的部分，而因访问NodeList 导致的问题为最多。NodeList 对象都是“动态的”，这就意味着每次访问NodeList 对象，都会运行一次查询。有鉴于此，最好的办法就是尽量减少DOM 操作。

## 第11章 DOM 扩展

### 选择符API

querySelector() 方法接收一个CSS 选择符，返回与该模式匹配的第一个元素，如果没有找到匹配的元素，返回null。

```javascript
var body = document.querySelector("body");
var myDive = document.querySelector("#myDiv");
var selected = document.querySelector(".selected");
var img = document.querySelector("img.button");
```

通过Document 类型调用querySelector() 方法时，会在文档元素的范围内查找匹配的元素。而通过Element 类型调用querySelector() 方法时，只会在该元素后代元素的范围内查找匹配的元素。

querySelectorAll() 方法接收一个CSS 选择符，返回与该模式匹配的NodeList 实例。不会对文档进行动态搜索。

matchesSelector() 方法接收一个参数，即CSS 选择符，如果调用元素与该选择符匹配，返回true；否则返回false。

### 元素遍历

对于元素间的空格，IE9 及之前的版本不会返回文本节点，而其他所有浏览器都会返回文本节点。这样，就导致了在使用childNodes 和firstChild等属性时的行为不一致。Element Traversal API 为DOM 元素添加了以下5个属性：

- childElementCount：返回子元素（不包括文本节点和注释）的个数
- firstElementChild：指向第一个子元素；firstChild 的元素版
- lastElementChild：指向最后一个子元素；lastChild 的元素版
- previousElementSibling：指向前一个同辈元素；perviousSibling 的元素版
- nextElementSibling：指向后一个同辈元素；nextSibling 的元素版

过去要跨浏览器遍历某元素的所有子元素：

```javascript
var i,
    len,
    child = element.firstChild;
while (child != element.lastChild){
  if (child.nodeType == 1){ //检查是不是元素
    processChild(child);
  }
  child = child.nextSibling;
}
```

使用上面新增的元素后：

```javascript
var i,
    len,
    child = element.firstElementChild;
while (child != element.lastElementChild){
  processChild(child);  //已知其是元素
  child = child.nextElementSibling;
}
```

### HTML5

#### 与类相关的扩充

getElementsByclassName() 方法接收一个参数，即一个包含一或多个类名的字符串，返回带有指定类的所有元素的NodeList。传入多个类名时，类名的先后顺序不重要。

classList 属性

- add(value)
- contains(value)
- remove(value)
- toggle(value)

有了classList 属性，除非需要全部删除所有类名，或者完全重写元素的class 属性，否则也就用不到className 属性了。

#### 焦点管理

document.activeElement 属性始终会引用DOM 中当前获得了焦点的元素。元素获得焦点的方式有页面加载、用户输入（通常是通过按Tab 键）和在代码中调用focus() 方法。

文档刚刚加载完成时，document.activeElement 中保存的是 document.body 元素的引用。文档加载期间，document.activeElement 的值为null。

document.hasFocus() 方法用于确定文档是否获得了焦点。

```javascript
var button = document.getElementById("myButton");
button.focus();
alert(document.activeElement === button); //ture
alert(document.hasFocus()); //true
```

通过检测文档是否获得了焦点，可以知道用户是不是正在与页面交互。

#### HTMLDocument 的变化

document.readyState 属性有两个可能的值：

- loading，正在加载文档
- complete，已经加载完文档

```javascript
if (document.readyState == "complete"){
  //执行操作
}
```

兼容模式：document.compatMode

- 标准模式——CSS1Compat
- 混杂模式——BackCompat

document.head

```javascript
var head = document.head || document.getElementsByTagName("head")[0];
```

#### 字符集属性

document.charset

#### 自定义数据类型

HTML5 规定可以为元素添加非标准的属性，但要添加前缀data-。添加了自定义属性之后，可以通过元素的dataset 属性来访问自定义的值。

每个data-name 形式的属性，可以通过element.dataset.name 来访问。

#### 插入标记

在读模式下，innerHTML 属性返回与调用元素的所有子节点对应的HTML标记。在写模式下，innerHTML 会根据指导的值创建新的DOM 树，然后用这个DOM 树完全替换调用元素原先的所有子节点。

设置了innerHTML 之后，可以像访问文档中的其他节点一样访问新创建的节点。

在读模式下，outerHTML 返回调用它的元素及所有子节点的HTML 标签。在写模式下，outerHTML 会根据指定的HTML 字符串创建新的DOM 子树，然后用这个DOM 子树完全替换调用元素。

#### scrollIntoView() 方法

scrollIntoView() 可以在所有HTML 元素上调用，通过滚动浏览器窗口或某个容器元素，调用元素就可以出现在视口中。如果给这个方法传入true 作为参数，或者不传入任何参数，那么窗口滚动之后会让调用元素的顶部与视口顶部尽可能平齐。如果传入false 作为参数，调用参数会尽可能全部出现在视口中，不过顶部不一定平齐。

一直下拉至网页底部代码一：

```javascript
var end = document.createElement("p");
document.body.appendChild(end);
(function scrollDown(){
  end.scrollIntoView();
  setTimeout(scrollDown,1000);
})();
```

一直下拉至网页底部代码二：

```javascript
(function scrollDown(){
  scroll(0,document.body.scrollHeight);
  setTimeout(scrollDown,1000);
})();
```

## 第12章 DOM2 和 DOM3

### 样式

任何支持style 特性的HTML 元素在JavaScript 中都有一个对应的style 属性。

DOM2级新定义的属性和方法：

- cssText：通过它能够访问到style 特性中的CSS 代码
- length：应用给元素的CSS 属性的数量
- parentRule：表示CSS 信息的CSSRule 对象
- getPropertyCSSValue(propertyName)：返回包含给定属性值的CSSValue 对象
- getPropertyPriority(propertyName)：如果给定的属性使用了`!important`设置，则返回“important”，否则返回空字符串
- getPropertyValue(propertyName)：返回给定属性的字符串值
- item(index)：返回给定位置的CSS 属性的名称
- removeProperty(propertyName)：从样式中删除给定属性
- setProperty(propertyName, value, priority)：将给定属性设置为相应的值，并加上优先权标志

“DOM2 级样式”增强了document.defaultView ，提供了getComputedStype() 方法。这个方法接收两个参数：要取得计算样式的元素和一个伪元素字符串。如果不需要伪元素信息，第二个参数可以使null。getComputedStyle() 方法返回包含当前元素的所有计算的样式。（最终样式属性值）

#### 元素大小

偏移量，包括元素在屏幕上占用的所有可见的空间。元素的可见大小由其高度、宽度决定，包括所有内边距、滚动条和边框大小（注意，不包括外边距）。通过下列4个属性可以取得元素的偏移量。

- offsetHeight
- offsetWidth
- offsetLeft
- offsetTop

![](http://7xvxmb.com1.z0.glb.clouddn.com/170413-1.png)

客户区大小，指的是元素内容及其内边距所占的空间大小。

![](http://7xvxmb.com1.z0.glb.clouddn.com/170413-2.png)

有关客户区大小的属性有两个：

- clientWidth
- clientHeight

客户区大小就是元素内部的空间大小，因此滚动条占用的空间不计算在内。

滚动大小，指的是包含滚动内容的元素的大小。有些元素（例如`<html>`元素），即使没有执行任何代码也能自动地添加滚动条；但另外一些元素，则需要通过CSS 的overflow 属性进行设置才能滚动。以下是4个与滚动大小有关的属性：

- scrollHeight
- scrollWidth
- scrollLeft
- scrollTop

![](http://7xvxmb.com1.z0.glb.clouddn.com/170413-3.png)

通过scrollLeft 和scrollTop 属性既可以确定元素当前滚动的状态，也可以设置元素的滚动位置。

### 遍历

NodeIterator 和 TreeWalker 这两个类型能够基于给定的起点对DOM 结构执行**深度优先**的遍历操作。

## 第13章 事件

### 事件流

事件流描述的是从页面中接收事件的顺序。

IE 的事件流叫事件冒泡，即事件开始时由最具体的元素接收，然后逐级向上传播到较为不具体的节点。

事件捕获与事件冒泡相反。使用事件冒泡即可。

### 事件处理程序

#### DOM0 级事件处理程序

```javascript
var btn = document.getElementById("myBtn");
btn.onclick = function(){
  alert("Clicked");
};
```

使用DOM0 级方法指定的事件处理程序被认为是元素的方法。因此，这时候的事件处理程序是在元素的作用于中运行。

```javascript
btn.onclick = null; //删除事件处理程序
```

#### DOM2 级事件处理程序

- addEventListener()
- removeEventListener()

接收3个参数：要处理的事件名、作为事件处理程序的函数和一个布尔值。布尔值参数若为true，表示在捕获阶段调用事件处理程序；若为false，表示在冒泡阶段调用事件处理程序。通常都为false。

```javascript
var btn = document.getElementById("myBtn");
btn.addEventListener("click", function(){
  alert(this.id);
}, false);
btn.addEventListener("click", function(){
  alert("Hello world!");
}, false);
```

使用DOM2 级方法添加时间处理程序的主要好处是可以添加多个事件处理程序。会按照添加它们的顺序触发。

通过addEventListener() 添加的时间处理程序只能使用removeEventListener() 来移除；移除时传入的参数与添加处理程序时使用的参数相同。这也就意味着通过addEventListener() 添加的匿名函数将无法移除。

#### IE 事件处理程序

- attachEvent()
- detachEvent()

```javascript
var btn = document.getElementById("myBtn");
btn.attachEvent("onclick", function(){
  alert("clicked");
});
```

注意上面是“onclick”，且接收两个参数。

使用attachEvent() 方法，事件处理程序会在全局作用域下运行，因此this 等于window。

#### 跨浏览器的事件处理程序

创建方法addHandler()，职责是视情况分别使用DOM0 级方法、DOM2 级方法或IE 方法来添加事件。这个方法属于一个名叫EventUtil 的对象。

```javascript
var EventUtil = {
  addHandler : function(element, type, handler){
    if (element.addEventListener){
      element.addEventListener(type, handler, false);
    } else if (element.attachEvent){
      element.attachEvent("on" + type, handler);
    } else {
      element["on" + type] = handler;
    }
  },
  removeHandler : function(element, type, handler){
    if (element.removeEventListener){
      element.removeEventListener(type, handler, false);
    } else if (element.detachEvent){
      element.detachEvent("on" + type, handler);
    } else {
      element["on" + type] = null;
    }
  }
};
```

使用EventUtil 对象：

```javascript
var btn = document.getElementById("myBtn");
var handler = function(){
  alert("Clicked");
}
EventUtil.addHandler(btn, "click", handler);
//这里省略了其他代码
EventUtil.removeHandler(btn, "click", handler);
```

### 事件对象

在触发DOM 上的某个事件时，会产生一个事件对象event ，这个对象中包含着所有与事件有关的信息。

#### DOM 中的事件对象

兼容DOM 的浏览器会将一个event 对象传入到事件处理程序中。无论指定事件处理程序时使用什么方法，都会传入event 对象。示例：

```javascript
var btn = document.getElementById("myBtn");
btn.onclick = function(event){
  alert(event.type);
};
btn.addEventListener("click", function(event){
  alert(event.type);
}, false);
```

所有事件都会有下表列出的成员。

![](http://7xvxmb.com1.z0.glb.clouddn.com/170414-1.png)

在事件处理程序内部，对象this 始终等于currentTarget 的值，而target 则只包含事件的实际目标。

要阻止特定事件的默认行为，可以使用preventDefault() 方法。

stopPropagation() 方法用于立即停止事件在DOM 层次中的传播，即取消进一步的时间捕获或冒泡。例如，直接添加到一个按钮的事件处理程序可以调用stopPropagation() ，从而避免触发注册在document.body 上面的事件处理程序：

```javascript
var btn = document.getElementById("myBtn");
btn.onclick = function(event){
  alert("Clicked");
  event.stopPropagation();
};
document.body.onclick = function(event){
  alert("Body clicked");
};
```

只有在事件处理程序执行期间，event 对象才会存在；一旦事件处理程序执行完成，event 对象就会被销毁。

#### IE 中的事件对象

![](http://7xvxmb.com1.z0.glb.clouddn.com/170414-2.png)

#### 跨浏览器的事件对象

```javascript
var EventUtil = {
  addHandler : function(element, type, handler){
    //省略的代码
  },
  getEvent : function(event){
    return event ? event : window.event;
  },
  getTarget : function(event){
    return event.target || event.srcElement;
  },
  preventDefault : function(event){
    if (event.preventDefault){
      event.preventDefault();
    } else {
      event.returnValue = false;
    }
  },
  removeHandler : function(element, type, handler){
    //省略的代码
  },
  stopPropagation : function(event){
    if (event.stopPropagation){
      event.stopPropagation();
    } else {
      event.cancelBubble = true;
    }
  }
};
```

```javascript
//getEvent()
btn.onclick = function(event){
  event = EventUtil.getEvent(event);
}

//getTarget()
btn.onclick = function(event){
  event = EventUtil.getEvent(event);
  var target = EventUtil.getTarget(event);
}

//preventDefault()
var link = document.getElementById("myLink");
link.onclick = function(event){
  event = EventUtil.getEvent(event);
  EventUtil.preventDefault(event);
}

//stopPropagation()
var btn = document.getElementById("myBtn");
btn.onclick = function(event){
  alert("Clicked");
  event = EventUtil.getEvent(event);
  EventUtil.stopPropagation(event);
};
document.body.onclick = function(event){
  alert("Body clicked");
};
```

### 事件类型

#### UI 事件

那些不一定与用户操作有关的事件。

- load：当页面完全加载后在window 上面触发，当所有框架都加载完毕时在框架集上面触发，当图像加载完毕时在`<img>`元素上面触发，或者当嵌入的内容加载完毕时在`<object>`元素上面触发。
- unload：当页面完全卸载后在window 上面触发，当所有框架都卸载后在框架集上面触发，或者当嵌入的内容卸载完毕后在`<object>`元素上面触发。
- abort
- error
- select
- resize：当窗口或框架的大小变化时在window 或框架上面触发
- scroll：当用户滚动带滚动条的元素中的内容时，在该元素上面触发。`<body>`元素中包含所加载页面的滚动条。

##### load 事件

页面完全加载后就会触发window 上面的load 事件：

```javascript
EventUtil.addHandler(window, "load", function(event){
  alert("Loaded!");
});
```

图像加载完毕后：

```javascript
var image = document.getElementById("myImage");
EventUtil.addHandler(image, "load", function(event){
  event = EventUtil.getEvent(event);
  alert(EventUtil.getTarget(event).src);
})
```

##### unload 事件

利用这个事件最多的情况是消除引用，以避免内存泄露。

```javascript
EventUtil.addHandler(window, "unload", function(event){
  alert("Unloaded");
});
```

##### resize 事件

```javascript
EventUtil.addHandler(window, "resize", function(event){
  alert("Resized");
});
```

##### scroll 事件

```javascript
EventUtil.addHandler(window, "scroll", function(event){
  if (document.compatMode == "CSS1Compat"){
    alert(document.documentElement.scrollTop);
  } else {
    alert(document.body.scrollTop);
  }
});
```

#### 焦点事件

焦点事件会在页面元素获得或失去焦点时触发。利用这些事件并与document.hasFocus() 方法及document.activeElement 属性配合，可以知晓用户在页面上的行踪。

- blur：在元素失去焦点时触发。这个事件不会冒泡；所有浏览器都支持它。
- focus：在元素获得焦点时触发。这个事件不会冒泡；所有浏览器都支持它。
- focusin：在元素获得焦点时触发。冒泡。
- focusout：在元素失去焦点时触发。

#### 鼠标与滚轮事件

- click：在用户单击主鼠标按钮或者按下回车键时触发。
- dblclick：在用户双击主鼠标按钮时触发。
- mousedown：在用户按下了任意鼠标按钮时触发。不能通过键盘触发这个事件。
- mouseenter：在鼠标光标从元素外部首次移动到元素范围之内时触发。这个事件不冒泡，而且在光标移动到后代元素上不会触发。
- mouseleave：在位于元素上方的鼠标光标移动到元素范围之外时触发。这个事件不冒泡，而且在光标移动到后代元素上不会触发。
- mousemove：当鼠标指针在元素内部移动时重复地触发。不能通过键盘触发这个事件。
- mouseout：在鼠标指针位于一个元素上方，然后用户将其移入另一个元素时触发。又移入的另一个元素可能位于前一个元素的外部也可能是这个元素的子元素。不能通过键盘触发这个事件。
- mouseover：在鼠标指针位于一个元素外部，然后用户将其首次移入另一个元素边界之内时触发。不能通过键盘触发这个事件。
- mouseup：在用户释放鼠标按钮时触发。不能通过键盘触发这个事件。

只有在同一个元素上相继触发mousedown 和mouseup 事件，才会触发click 事件；如果mousedown 或mouseup 中的一个被取消，就不会触发click 事件。类似地，只有触发两次click 事件，才会触发一次dblclick 事件。如果有代码阻止了连续两次触发click 事件，那么就不会触发dblclick 事件。

客户区坐标位置：

- event.clientX
- event.clientY

页面坐标位置：

- event.pageX
- event.pageY

屏幕坐标位置：

- event.screenX
- event.screenY

修改键：

```javascript
var div = document.getElementById("myDiv");
EventUtil.addHandler(div, "click", function(event){
  event = EventUtil.getEvent(event);
  var keys = new Array();
  if (event.shiftKey){
    keys.push("shift");
  }
  if (event.ctrlKey){
    keys.push("ctrl");
  }
  if (event.altKey){
    keys.push("alt");
  }
  if (event.metaKey){
    keys.push("meta");
  }
  alert("Keys: " + keys.join(","));
});
```

触摸设备：

- 不支持dblclick
- 轻击可单击元素会触发mousemove 事件。如果此操作会导致内容变化，将不会有其他事件发生；如果屏幕没有因此变化，那么会依次发生mousedown、mouseup 和click 事件。
- mousemove 事件也会触发mouseover 和mouseout 事件。
- 两个手指放在屏幕上且页面随手指移动而滚动时会触发mousewheel 和scroll 事件。

#### 键盘与文本事件

- keydown：当用户按下键盘上的任意键时触发，而且如果按住不放的话，会重复触发此事件。
- keypress：当用户按下键盘上的字符键时触发，而且如果按住不放的话，会重复触发此事件。按下Esc 键也会触发这个事件。
- keyup：当用户释放键盘上的键时触发。

虽然所有元素都支持以上3个事件，但只有在用户通过文本框输入文本时才最常用到。

只有一个文本事件：textInput。这个事件是对keypress 的补充，用意是在将文本显示给用户之前更容易拦截文本。在文本插入文本框之前会触发textInput 事件。

**键码**

在发生keydown 和keyup 事件时，event 对象的keyCode 属性中会包含一个代码，与键盘上一个特定的键对应。

```javascript
var textbox = document.getElementById("myText");
EventUnit.addHandler(textbox, "keyup", function(event){
  event = EventUtil.getEvent(event);
  alert(event.keyCode);
});
```

**字符编码**

event 对象的charCode 属性，在发生keypress 事件后会包含此值，代表字符的ASCII 编码。

**DOM3 级变化**

DOM3 级事件中的键盘事件，不再包含charCode 属性，而是包含两个新属性：key 和 char。

**textInput 事件**

```javascript
var textbox = document.getElementById("myText");
EventUtil.addHandler(textbox, "textInput", function(event){
  event = EventUtil.getEvent(event);
  alert(event.data);
});
```

### 内存和性能

#### 事件委托

对“事件处理程序过多”问题的解决方案就是事件委托。事件委托利用了事件冒泡，只指定一个事件处理程序，就可以管理某一类型的所有事件。例如，click 事件会一直冒泡到document 层次。也就是说，我们可以为整个页面指定一个onclick 事件处理程序，而不必给每个可单击的元素分别添加事件处理程序。以下面的HTML 代码为例。

```html
<ul id="myLinks">
  <li id="goSomewhere">Go somewhere</li>
  <li id="doSomething">Do something</li>
  <li id="sayHi">Say hi</li>
</ul>
```

使用事件委托，只需在DOM 树中尽量最高的层次上添加一个事件处理程序，如下：

```javascript
var list = document.getElementById("myLinks");
EventUtil.addHandler(list, "click", function(event){
  event = EventUtil.getEvent(event);
  var target = EventUtil.getTarget(event);
  switch (target.id){
    case "doSomething":
      document.title = "I changed the document's title";
      break;
    case "goSomewhere":
      location.href = "http://www.baidu.com";
      break;
    case "sayHi":
      alert("hi");
      break;
  }
});
```

如果可行的话，可以考虑为document 对象添加一个事件处理程序，用以处理页面上发生的某种特定类型的事件。这样做与采取传统的做法相比具有如下优点。

- document 对象很快就可以访问，而且可以在页面生命周期的任何时点上为它添加事件处理程序。
- 在页面中设置事件处理程序所需的时间更少。只添加一个事件处理程序所需的DOM 引用更少，所花的时间也更少。
- 整个页面占用的内存空间更少，能够提升整体性能。

最适合采用事件委托技术的事件包括：

- click
- mousedown
- mouseup
- keydown
- keyup
- keypress

### 模拟事件

事件经常由用户操作或通过其他浏览器功能来触发。使用JavaScript 也可以在任意时刻来触发特定的事件，就如同浏览器创建的事件一样。

#### DOM 中的事件模拟

可以在document 对象上使用createEvent() 方法创建event 对象。这个方法接收一个参数，即表示要创建的事件类型的字符串。参数：

- UIEvents：一般化的UI 事件。鼠标事件和键盘事件都继承自UI时间。
- MouseEvents：一般化的鼠标事件。
- MutationEvents：一般化的DOM 变动事件。
- HTMLEvents：一般化的HTML 事件。

**模拟鼠标事件**

创建鼠标事件对象的方法是为createEvent() 传入字符串“MouseEvents”。返回的对象有一个名为initMouseEvent() 方法，用于指定与该鼠标事件有关的信息。这个方法接收15个参数，分别与鼠标事件中每个典型的属性一一对应：

- type：字符串，表示要触发的事件类型，例如“click”
- bubbles：布尔值，表示事件是否应该冒泡，一般设置为true
- cancelable：布尔值，表示事件是否可以取消，一般设置为true
- view：与事件关联的视图。设置为document.defaultView
- detail
- screenX
- screenY
- clientX
- clientY
- ctrlKey
- altKey
- shiftKey
- metaKey
- button
- relatedTarget

示例模拟对按钮的单击事件：

```javascript
var btn = document.getElementById("myBtn");
//创建事件对象
var event = document.createEvent("MouseEvents");
//初始化事件对象
event.initMouseEvent("click", true, true, document.defaultView, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
//触发事件
btn.dispatchEvent(event);
```

## 第14章 表单脚本

### 表单的基础知识

提交表单：将`<input>`或`<button>`的type 特性的值设置为“submit”。

以这种方式提交表单时，浏览器会将请求发送给服务器之前触发submit 事件。

下列代码会阻止表单提交：

```javascript
var form = document.getElementById("myForm");
EventUtil.addHandler(form, "submit", function(event){
  //取得事件对象
  event = EventUtil.getEvent(event);
  //阻止默认事件
  EventUtil.preventDefault(event);
});
```

也可直接编程调用submit() 方法提交表单。不会触发submit 事件。

```javascript
var form = document.getElementById("myForm");
//提交表单
form.submit();
```

重置表单：reset

每个表单都有elements 属性，该属性是表单中所有表单元素（字段）的集合。示例：

```javascript
var form = document.getElementById("form1");
//取得表单中的第一个字段
var field1 = form.elements[0];
//取得名为“textbox1”的字段
var field2 = form.elements["textbox1"];
//取得表单中包含的字段的数量
var fieldCount = form.elements.length;
```

共有的表单字段属性：

- disabled：布尔值，表示当前字段是否被禁用
- form：指向当前字段所属表单的指针；只读
- name：当前字段的名称
- readOnly：布尔值，表示当前字段是否只读
- tabIndex：表示当前字段的切换序号
- type：当前字段的类型
- value：当前字段将被提交给服务器的值

除了form 属性之外，可以通过JavaScript 动态修改其他任何属性。

共有的表单字段方法：

- focus()
- blur()

共有的表单字段事件：

- blur
- change
- focus

### 文本框脚本

两种方式表现文本框：

- `<input>`
- `<textarea>`

建议通过element.value 属性读取或设置文本框的值，不建议使用标准的DOM 方法。因为对value 属性的修改不一定要反映在DOM 中。

#### 选择文本

select() 方法用于选择文本框中的所有文本。

select 事件

#### 过滤输入

下列代码只允许用户输入数值：

```javascript
EventUnit.addHandler(textbox, "keypress", function(event){
  event = EventUtil.getEvent(event);
  var target = EventUtil.getTarget(event);
  var charCode = EventUtil.getCharCode(event);
  if (!/\d/.text(String.fromCharCode(charCode))){
    EventUtil.preventDefault(event);
  }
});
```

操作剪贴板

```javascript
var EventUtil = {
  //省略的代码
  getClipboardText: function(event){
    var clipboardData = (event.clipboardData || window.clipboardData);
    return clipboardData.getData("text");
  },
  //省略的代码
  setClipboardText: function(event, value){
    if (event.clipboardData){
      return event.clipboardData.setData("text/plain", value);
    } else if (window.clipboardData){
      return window.clipboardData.setData("text", value);
    }
  },
  //省略的代码
};
```

在paste 事件中，可以检查粘贴的字符串是否有效：

```javascript
EventUtil.addHandler(text, "paste", function(event){
  event = EventUtil.getEvent(event);
  var text = EventUtil.getClipboardText(event);
  if (!/^\d*$/.text(text)){
    EventUtil.preventDefault(event);
  }
});
```

#### 自动切换焦点

```javascript
(function(){
  function tabForward(event){
    event = EventUtil.getEvent(event);
    var target = EventUtil.getTarget(event);
    if (target.value.length == target.maxLength){
      var form =target.form;
      for (var i=0, len=form.elements.length; i<len; i++){
        if (form.elements[i] == target){
          if (form.elements[i+1]){
            form.elements[i+1].focus();
          }
          return;
        }
      }
    }
  }
  
  var textbox1 = document.getElementById("txtTel1");
  var textbox2 = document.getElementById("txtTel2");
  var textbox3 = document.getElementById("txtTel3");
  
  EventUtil.addHandler(textbox1, "keyup", tabForward);
  EventUtil.addHandler(textbox2, "keyup", tabForward);
  EventUtil.addHandler(textbox3, "keyup", tabForward);
})();
```

#### HTML5 约束验证API

在表单字段中指定了required 属性，表示必填字段。例如：

```html
<input type="text" name="username" required>
```

JavaScript 检查某个字段是否为必填字段：

```javascript
var isUsernameRequired = document.forms[0].elements["username"].required;
```

测试浏览器是否支持required 属性：

```javascript
var isRequiredSupported = "required" in document.createElement("input");
```

其他输入类型：

```html
<input type="email" name="email">
<input type="url" name="honepage">
```

测试浏览器是否支持新类型：

```javascript
var input = document.createElement("input");
input.type = "email";
var isEmailSupported = (input.type == "email");
```

输入模式：pattern 正则表达式

```html
<input type="text" pattern="\d+" name="count">
```

检测有效性：checkValidity()，如果字段值有效返回true，否则返回false。

validity 属性会告诉有效或无效的详细信息。

禁用验证：novalidate

### 选择框脚本

选择框是通过`<select>`和`<option>`元素创建的。

## 第20章 JSON

JSON 是一种数据格式，不是编程语言。JSON 并不从属与JavaScript。

### 语法

JSON 的语法可以表示以下三种类型的值。

- 简单值：字符串、数值、布尔值和null。注意不支持undefined
- 对象
- 数组

JSON 中的对象要求给属性加引号，如：

```json
{
  "name": "Nicholas",
  "age": 29
}
```

与JavaScript 的不同之处：

- 没有声明变量
- 末尾无分号

### 解析与序列化

早期的JSON 解析器基本上是使用JavaScript 的eval() 函数。

JSON 对象有两个方法：

- stringify()：把JavaScript 对象序列化为JSON 字符串
- parse()：把JSON 字符串解析为原生JavaScript 值

例如：

```javascript
var book = {
  title: "Professional JavaScript",
  authors: [
    "Nicholas C. Zakas"
  ],
  edition: 3,
  year: 2011
};
var jsonText = JSON.stringify(book);
```

保存在jsonText 中的字符串如下：

```json
{"title":"Professional JavaScript","authors":["Nicholas C. Zakas"],"edition":3,"year":2011}
```

再解析为JavaScript：

```javascript
var bookCopy = JSON.parse(jsonText);
```

JSON.stringify() 还可以接收两个参数，用于指定以不同的方式序列化JavaScript 对象。第一个参数是个过滤器，可以是一个数组，也可以是一个函数；第二个参数是一个选项，表示是否在JSON 字符中保留缩进。单独或组合使用这两个参数，可以更全面深入地控制JSON 的序列化。

如果过滤器参数是数组，那么JSON.stringify() 的结果中将只包含数组中列出的属性。

```javascript
var book = {
  title: "Professional JavaScript",
  authors: [
    "Nicholas C. Zakas"
  ],
  edition: 3,
  year: 2011
};
var jsonText = JSON.stringify(book, ["title", "edition"]);
```
此时返回的结果如下：

```json
{"title":"Professional JavaScript","edition":3}
```

过滤器为函数时：

```javascript
var book = {
  title: "Professional JavaScript",
  authors: [
    "Nicholas C. Zakas"
  ],
  edition: 3,
  year: 2011
};
var jsonText = JSON.stringify(book, function(key, value){
  switch (key){
    case "authors":
      return value.join(",");
    case "year":
      return 5000;
    case "edition":
      return undefined;
    default:
      return value;
  }
});
```
序列化后的JSON 字符串如下：

```json
{"title":"Professional JavaScript","authors":"Nicholas C. Zakas","year":5000}
```

JSON.stringify() 方法的第三个参数用于控制结果中的缩进和空白符。如果这个参数是一个数值，那它表示的是每个级别缩进的空格数。只要传入有效的控制缩进的参数值，结果字符串就会包含换行符。

如果缩进参数是一个字符串而非数值，则这个字符串将在JSON 字符串中被用作缩进字符。

假设把一个对象传入JSON.stringify() ，序列化该对象的顺序如下：

1. 如果存在toJSON() 方法而且能通过它取得有效的值，则调用该方法。否则，返回对象本身。
2. 如果提供了第二个参数，应用这个函数过滤器。传入函数过滤器的值是第1步返回的值。
3. 对第2步返回的每个值进行相应的序列化。
4. 如果提供了第三个参数，执行相应的格式化。

JSON.parse() 方法也可以接收另一个参数，该参数是一个函数，将在每个键值对上调用。

## 第21章 Ajax 与 Comet

### XMLHttpRequest 对象

Ajax 技术的核心是XMLHttpRequest 对象

```javascript
var xhr = new XMLHttpRequest();
```

在使用XHR 对象时，要调用的第一个方法是open() ，它接收3个参数：要发送的请求的类型、请求的URL 和表示是否异步发送请求的布尔值。

- true：异步——一般使用异步
- false：同步

之后发送特定的请求，必须调用send() 方法

```javascript
xhr.open("get", "example.php", true);
xhr.send(null);
```

在收到响应的数据会自动填充XHR 对象的属性，相关的属性简介如下：

- responseText：作为响应主体被返回的文本。
- responseXML：如果响应的内容类型是“text/xml”或“application/xml”，这个属性中将保存包含着响应数据的XML DOM 文档。
- status：响应的HTTP 状态。
- statusText：HTTP 状态的说明。

发送异步请求，让JavaScript 继续执行而不必等待相应。可以检测XHR 对象的readyState 属性，该属性表示请求/响应过程的当前活动阶段。这个属性可取的值如下：

- 0：未初始化。尚未调用open() 方法。
- 1：启动。已经调用open() 方法，但尚未调用send() 方法。
- 2：发送。已经调用send() 方法，但尚未接收到响应。
- 3：接收。已经接收到部分响应数据。
- 4：完成。已经接收到全部响应数据，而且已经可以在客户端使用了。

只要readyState 属性的值由一个值变成另一个值，都会触发一次readystatechange 事件。可以利用这个事件来检测每次状态变化后的readyState 的值。一般检测readyState 的值为4 的阶段即可，因为这时所有数据都应就绪。必须在调用open() 之前知道onreadystatechange 事件处理程序才能确保跨浏览器兼容性。示例：

```javascript
var xhr = new XMLHttpRequest();
xhr.onreadystatechange = function(){
  if (xhr.readyState == 4){
    if ((xhr.status >= 200 && xhr.status < 300) || xhr.status == 304){
      alert(xhr.responseText);
    } else {
      alert("Request was unsuccessful: " + xhr.status);
    }
  }
};
xhr.open("get", "example.txt", true);
xhr.send(null);
```

在接收到响应之前还可以调用abort() 方法来取消异步请求：

```javascript
xhr.abort();
```
使用setRequestHeader() 方法可以设置自定义的请求头部信息。这个方法接收两个参数：头部字段的名称和头部字段的值。要成功发送请求头部信息，必须在调用open() 方法之后且调用send() 方法之前调用setRequestHeader()。

调用XHR 对象的getRespnseHeader() 方法并传入头部字段名称，可以取得相应的响应头部信息。而调用getAllResponseHeaders() 方法则可以取得一个包含所有头部信息的长字符串。

GET 是最常见的请求类型。必要时，可以将查询字符串参数追加到URL 的末尾，以便将信息发送给服务器。对XHR 而言，位于传入open() 方法的URL 末尾的查询字符串必须经过正确的编码才行。使用encodeURIComponent() 进行编码。

POST 请求通常用于向服务器发送应该被保存的数据。POST 请求应该把数据作为请求的主体提交，请求的主体可以包含非常多的数据，而且格式不限。

### XMLHttpRequest 2级

FormData 为序列化表单以及创建与表单格式相同的数据提供了遍历。

```javascript
var data = new FormData();
data.append("name", "Nicholas");
```

append() 方法接收两个参数：键和值，分别对应表单字段的名字和字段中包含的值。

也可直接用表单元素的数据预先向其中填入键值对：

```javascript
var data = new FormData(document.forms[0]);
```

创建了FormData 实例后，可以将它直接传给XHR 的send() 方法：

```javascript
var form = document.getElementById("user-info");
xhr.send(new FormData(form));
```

timeout 属性，表示请求在等待响应多少毫秒之后就终止。在给timeout 设置一个数值后，如果在规定的时间内浏览器还没有收到响应，那么就会触发timeout 事件，今儿会调用ontimeout 事件处理程序。示例：

```javascript
xhr.open("get", "timeout.php", true);
xhr.timeout = 1000;
xhr.ontimeout = function(){
  alert("Request did not return in a second.");
};
xhr.send(null);
```

overrideMimeType() 方法用于重写XHR 响应的MIME 类型。

### 跨域资源共享

即使浏览器对CORS 的支持程度并不都一样，但所有浏览器都支持简单的请求，因此有必要实现一个跨浏览器的方案。检测XHR 是否支持CORS 的最简单方式，就是检查是否存在withCredentials 属性。再结合检测XDomainRequest 对象是否存在，就可以兼顾所有浏览器了。

```javascript
function createCORSRequest(method, url){
  var xhr = new XMLHttpRequest();
  if ("withCredentials" in xhr){
    xhr.open(method, url, true);
  } else if (typeof XDomainRequest != "undefined"){
    xhr = new XDomainRequest();
    xhr.open(method, url);
  } else {
    xhr = null;
  }
  return xhr;
}

var request = createCORSRequest("get", "http://www.somewhere-else.com/page/");
if (request){
  request.onload = function(){
    //对request.responseText 进行处理
  };
  request.send();
}
```

### 其他跨域技术

#### 图像Ping

通过图像Ping，浏览器得不到任何具体的数据，但通过侦听load 和 error 事件，它能知道响应是什么时候接收到的。示例：

```javascript
var img = new Image();
img.onload = img.onerror = function(){
  alert("Done!");
};
img.src = "http://www.example.com/test?name=Nicholas";
```

这里创建了一个Image 的实例，然后将onload 和 onerror 事件处理程序指定为同一个函数。这样无论是什么响应，只要请求完成，就能得到通知。请求从设置src 属性那一刻开始，而这个例子在请求中发送了一个name 参数。

图像Ping 最常用于跟踪用户点击页面或动态广告曝光次数。图像Ping 有两个主要的缺点，一是只能发送GET 请求，二十无法访问服务器的响应文本。因此，图像Ping 只能用于浏览器与服务器间的单向通信。