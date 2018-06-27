# 阿里云Linux服务器安装GraphicsMagick全过程

本次安装的出发点是需要解决一个需求：让node 后端可以处理图片，在图片上写入文字。

所以下面是整个程序的解决路径：

1. 寻找得知node 库gm 可用来处理图片，一般的修改尺寸和在图片上写入文字，尤其是中文文字，都是可以解决的。

2. 查看gm 其GitHub 地址得知，gm 是nodejs 对GraphicsMagick 和ImageMagick 的封装。所以得首先安装GraphicsMagick 才可。

3. 在本地Mac 电脑上安装很简单，且后续实现过程并没有碰到任何大的问题。只需要先在终端输入下面代码，然后再npm 安装gm 包即可：

   ```
   brew install graphicsmagick
   ```


4. 但是在阿里云Linux 服务器上安装后，运行程序的过程却出现了问题：程序可以运行，可以修改图片的尺寸，但是**唯独不能往图片上添加文字**。但这个功能是必须的，所以说还需要进一步的查找解决。当实现此功能时会报错如下：

   ```
   Command failed: gm convert: FreeType library is not available
   ```

5. 中文意思即FreeType 这个库不支持。不支持怎么办呢？安装呗！

6. 经过一系列的查找测试，发现下面这个方法可以安装成功，不过可能会碰到`Cannot allocate memory` （不能分配内存）的问题，此时需先停止占用内存较大的程序后（例如`service mysqld stop` ）再输入下面代码安装：

   ```
   yum install -y freetype freetype-devel
   ```

7. 之后便重新安装GraphicsMagick 程序。安装过程如下：

   - 下载GraphicsMagick 安装包并解压

   - `cd GraphicsMagick-1.3.23` 进入此目录

   - `./configure` 输入这个命令，然后终端会出现一大堆的乱七八糟的东西，但有一个是需要注意的`FreeType 2.0 --with-ttf=yes no/yes` ，找到这一行，如果后面是yes ，则可以接着进行安装。如果是no ，那看上面第6步先安装此依赖程序。

   - ```
     make
     make install
     ```

8. 安装好之后，接下来便是node 安装gm 包了，如果你是其他程序，看到此就不要看了。node 安装很简单了：

   ```
   npm install gm
   ```

9. node 程序中此时运行`drawText` 便不会报`Command failed: gm convert: FreeType library is not available` 这个错误了。

参考网址：

- [gm GitHub 地址](https://github.com/aheckmann/gm)
- [安装 gm - 简书](http://www.jianshu.com/p/a651258c9135)
- [GraphicsMagick安装及使用](http://www.cnblogs.com/javapro/archive/2013/04/28/3048393.html)
- [安装相关依赖](http://www.2cto.com/os/201704/635410.html)