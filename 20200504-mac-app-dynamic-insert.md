# mac app 逆向之动态注入

跑通了一个最简单的动态注入的 demo，记录一下以防忘记。

### 原理相关

在 Mac 上，应用最终会 build 成可执行的二进制文件，而逆向就是为了改变应用原本的功能。这里实现的一种方法是：通过编写动态链接库将额外逻辑注入到应用中。
本文用到了 [insert_dylib](https://github.com/Tyilo/insert_dylib) 注入工具：

> Command line utility for inserting a dylib load command into a Mach-O binary.

这个工具应该是可以直接修改应用二进制文件，使应用加载时加载自己编写的动态库。
> Objective-C的首选hook方案为Method Swizzle。

### 步骤

#### 先用 objective-c 实现一个最简单的应用

`Person.h`

```objective-c
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSNumber *age;

@end

NS_ASSUME_NONNULL_END
```

`Person.m`

```objective-c
#import "Person.h"

@implementation Person

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %@>", self.name, self.age];
}

@end
```

`main.m`

```objective-c
#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"hello liqiang");
        
        Person *p = [[Person alloc] init];
        [p setName:@"liqiang"];
        [p setAge:@26];
        
        NSLog(@"person: %@", p);
    }
    return 0;
}
```

编译执行后会输出：

```
2020-05-04 17:09:19.146 hello[45102:759505] hello liqiang
2020-05-04 17:09:19.147 hello[45102:759505] person: <liqiang: 26>
```

#### hook 项目

新建 `Library` 类型的项目。下面的 `hookCommon` 相关代码实现的功能是替换应用中对应的方法为自己编写的方法，应该是 `Method Swizzl`。

`hookCommon.h`

```objective-c
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface hookCommon : NSObject

/**
 替换对象方法

 @param originalClass 原始类
 @param originalSelector 原始类的方法
 @param swizzledClass 替换类
 @param swizzledSelector 替换类的方法
 */
void hookMethod(Class originalClass, SEL originalSelector, Class swizzledClass, SEL swizzledSelector);

/**
 替换类方法
 
 @param originalClass 原始类
 @param originalSelector 原始类的类方法
 @param swizzledClass 替换类
 @param swizzledSelector 替换类的类方法
 */
void hookClassMethod(Class originalClass, SEL originalSelector, Class swizzledClass, SEL swizzledSelector);

@end
```

`hookCommon.m`

```objective-c
#import "hookCommon.h"

@implementation hookCommon

/**
 替换对象方法
 
 @param originalClass 原始类
 @param originalSelector 原始类的方法
 @param swizzledClass 替换类
 @param swizzledSelector 替换类的方法
 */
void hookMethod(Class originalClass, SEL originalSelector, Class swizzledClass, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(originalClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSelector);
    if (originalMethod && swizzledMethod) {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

/**
 替换类方法
 
 @param originalClass 原始类
 @param originalSelector 原始类的类方法
 @param swizzledClass 替换类
 @param swizzledSelector 替换类的类方法
 */
void hookClassMethod(Class originalClass, SEL originalSelector, Class swizzledClass, SEL swizzledSelector) {
    Method originalMethod = class_getClassMethod(originalClass, originalSelector);
    Method swizzledMethod = class_getClassMethod(swizzledClass, swizzledSelector);
    if (originalMethod && swizzledMethod) {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
```

然后替换掉 `Person` 类中的 `description` 方法，功能是调用原逻辑前先打印一行自己的逻辑代码。

`Person_hook.h`

```objective-c
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (PersonHook)

+ (void) hookPerson;

@end

NS_ASSUME_NONNULL_END

```

`Person_hook.m`

```
#import "Person_hook.h"
#import "hookCommon.h"

@implementation NSObject (PersonHook)

// hook person description
- (NSString *) personDescription
{
    NSLog(@"in personDescription");
    return [self personDescription];
}

+ (void) hookPerson
{
    NSLog(@"in hookPerson");
    hookMethod(objc_getClass("Person"), @selector(description), [self class], @selector(personDescription));
}

@end
```

`main.m`

```objective-c
#import <Foundation/Foundation.h>
#import "Person_hook.h"

static void __attribute__((constructor)) initialize(void) {
    NSLog(@"hook common inject success!");
    
    [NSObject hookPerson];
}

```

`__attribute__((constructor))` 修饰函数之后，便会在应用加载前执行，也就是相当于我们注入代码的逻辑入口。上面逻辑中会用方法 `personDescription` 替换 `Person` 类中的 `description` 方法，注意此方法中会调用自己，其实不会造成死循环，因为运行时两个方法已经交换了，所以是调用的原始逻辑。

#### 实验

将上面 hook 项目 build 之后，得到 `libhookCommon.dylib`，然后将此动态库和第一步应用二进制文件 `hello` 放在同一目录，加上用到 `insert_dylib` 注入工具，然后执行注入命令：

```bash
./insert_dylib libhookCommon.dylib hello
```

生成 `hello_patched` 程序，运行此程序：

```bash
./hello_patched
```

得到的输出为：

```
2020-05-04 17:23:18.461 hello_patched[45156:766500] hook common inject success!
2020-05-04 17:23:18.461 hello_patched[45156:766500] in hookPerson
2020-05-04 17:23:18.461 hello_patched[45156:766500] hello liqiang
2020-05-04 17:23:18.461 hello_patched[45156:766500] in personDescription
2020-05-04 17:23:18.462 hello_patched[45156:766500] in personDescription
2020-05-04 17:23:18.462 hello_patched[45156:766500] person: <liqiang: 26>
```

通过输出可以看出已经加入了自己的逻辑进来了。

### 思考

一般要想修改某个应用的逻辑功能，肯定是拿不到源代码的，所以通过二进制代码理解程序逻辑这一步，才是难点中的难点。必须要了解汇编，一些逆向的工具，还需要经验等等。而本文也仅是作为新手的我所能了解到的一些皮毛而已。

### 参考

- [Objective-C编程](https://book.douban.com/subject/19962787/)
- [macOS 逆向之生成动态注入 App](https://blog.nswebfrog.com/2018/02/09/make-injection-app-for-mac/)
- [动态注入 dylib到 Mac 应用](https://www.jianshu.com/p/d7a0ccc6a7e6)
- [insert_dylib](https://github.com/Tyilo/insert_dylib)
- [最简单的Hopper Disassembler玩转Mac逆向](https://www.jianshu.com/p/c04ac36c6641)
- [从hook到IOS黑魔法－Method Swizzling](http://yunlaiwu.github.io/blog/2017/05/22/ios%E4%BB%8Ehook%E5%88%B0methodSwizzling/)
- [微信 macOS 客户端拦截撤回功能实践](https://blog.sunnyyoung.net/wei-xin-macos-ke-hu-duan-lan-jie-che-hui-gong-neng-shi-jian/)
