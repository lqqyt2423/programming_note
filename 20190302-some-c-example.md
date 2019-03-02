# c语言一些示例

`/1-导言/1.6.c`

``` c
#include <stdio.h>

// 1-6

main() {
  int c;
  while (c = getchar() != EOF)
    printf("%d\n", c);
  printf("%d - at EOF\n", c);
}

```

----------

`/1-导言/1.7.c`

``` c
#include <stdio.h>

// 1-7

main()
{
  printf("EOF is %d\n", EOF);
}

```

----------

`/1-导言/a.c`

``` c
#include <stdio.h>

// 打印华氏温度和摄氏温度对照表
// c = (5/9) * (f-32)

main()
{
  int fahr, celsius;
  int lower, upper, step;

  lower = 0;
  upper = 300;
  step = 20;

  fahr = lower;
  while (fahr <= upper) {
    celsius = 5 * (fahr-32) / 9;
    printf("%d\t%d\n", fahr, celsius);
    fahr = fahr + step;
  }
}

```

----------

`/1-导言/b.c`

``` c
#include <stdio.h>

// 打印华氏温度和摄氏温度对照表
// c = (5/9) * (f-32)
// 优化版本

main()
{
  // 浮点数
  float fahr, celsius;
  int lower, upper, step;

  lower = 0;
  upper = 300;
  step = 20;

  fahr = lower;
  while (fahr <= upper)
  {
    celsius = (5.0/9.0) * (fahr-32.0);
    // 输出美观
    // %3.0f 至少占3字符宽，不带小数点和小数部分
    // %6.1f 至少占6字符宽，小数点后面有1位数字
    printf("%3.0f %6.1f\n", fahr, celsius);
    fahr = fahr + step;
  }
}

```

----------

`/1-导言/c.c`

``` c
# include <stdio.h>

// 摄氏温度转华氏温度
// f = 9*c / 5 + 32

main()
{
  float fahr, celsius;
  int lower, upper, step;

  lower = 0;
  upper = 300;
  step = 20;

  printf("Celsius  Fahr\n");
  celsius = lower;
  while (celsius <= upper) {
    fahr = 9.0 * celsius / 5.0 + 32.0;
    printf("%3.0f     %6.1f\n", celsius, fahr);
    celsius = celsius + step;
  }
}

```

----------

`/1-导言/copy.c`

``` c
#include <stdio.h>

main() {
  int c;
  c = getchar();
  while(c != EOF){
    putchar(c);
    c = getchar();
  }
}

```

----------

`/1-导言/copy2.c`

``` c
#include <stdio.h>

main()
{
  int c;

  while ((c = getchar()) != EOF)
    putchar(c);
}

```

----------

`/1-导言/d.c`

``` c
#include <stdio.h>

// 打印华氏温度和摄氏温度对照表
// c = (5/9) * (f-32)
// 优化版本
// for

main()
{
  float fahr;

  for (fahr = 0; fahr <= 300; fahr = fahr + 20) {
    printf("%3.0f %6.1f\n", fahr, (5.0 / 9.0) * (fahr - 32.0));
  }
}

```

----------

`/1-导言/e.c`

``` c
#include <stdio.h>

// 打印华氏温度和摄氏温度对照表
// c = (5/9) * (f-32)
// 优化版本
// for
// 逆序

main()
{
  float fahr;

  for (fahr = 300; fahr >= 0; fahr = fahr - 20)
  {
    printf("%3.0f %6.1f\n", fahr, (5.0 / 9.0) * (fahr - 32.0));
  }
}

```

----------

`/1-导言/f.c`

``` c
#include <stdio.h>

#define LOWER 0
#define UPPER 300
#define STEP 20

// 打印华氏温度和摄氏温度对照表
// c = (5/9) * (f-32)
// 优化版本
// for

main()
{
  float fahr;

  for (fahr = LOWER; fahr <= UPPER; fahr = fahr + STEP)
  {
    printf("%3.0f %6.1f\n", fahr, (5.0 / 9.0) * (fahr - 32.0));
  }
}

```

----------

`/1-导言/hello.c`

``` c
#include <stdio.h>

main()
{
  printf("hello, world\n");
}

```

----------

`/deep/10/cpstdin.c`

``` c
#include <unistd.h>

// 使用 read 和 write 调用一次一个字节地从标准输入复制到标准输出

int main() {
  char c;

  while (read(STDIN_FILENO, &c, 1) != 0) {
    write(STDOUT_FILENO, &c, 1);
  }

  return 0;
}

```

----------

`/deep/10/csapp.c`

``` c
#include <unistd.h>
#define RIO_BUFSIZE 8192

typedef struct {
  int rio_fd; // Descriptor for this internal buf
  int rio_cnt; // Unread bytes in internal buf
  char *rio_bufptr; // Next unread byte in internal buf
  char rio_buf[RIO_BUFSIZE]; // Internal buffer
} rio_t;

ssize_t rio_readn(int fd, void *usrbuf, size_t n) {
  size_t nleft = n;
  ssize_t nread;
  char *bufp = usrbuf;

  while (nleft > 0) {
    if ((nread = read(fd, bufp, nleft)) < 0) {
      // Interrupted by sig handler return and call read() again
      // 被应用信号处理程序的返回终端，手动重启
      if (errno == EINTR) {
        nread = 0;
      } else {
        // errno set by read()
        return -1;
      }
    }
    else if (nread == 0) {
      // EOF
      break;
    }

    nleft -= nread;
    bufp += nread;
  }

  // Return >= 0
  return (n - nleft);
}

ssize_t rio_writen(int fd, void *usrbuf, size_t n) {
  size_t nleft = n;
  ssize_t nwritten;
  char *bufp = usrbuf;

  while (nleft > 0) {
    if ((nwritten = write(fd, bufp, nleft)) <= 0) {
      if (errno == EINTR) {
        nwritten = 0;
      } else {
        return -1;
      }
    }

    nleft -= nwritten;
    bufp += nwritten;
  }

  return n;
}

void rio_readinitb(rio_t *rp, int fd) {
  rp->rio_fd = fd;
  rp->rio_cnt = 0;
  rp->rio_bufptr = rp->rio_buf;
}

// 内部的 rio_read 函数
static ssize_t rio_read(rio_t *rp, char *usrbuf, size_t n) {
  int cnt;

  while (rp->rio_cnt <= 0) { // Refill if buf is empty
    rp->rio_cnt = read(rp->rio_fd, rp->rio_buf, sizeof(rp->rio_buf));
    if (rp->rio_cnt < 0) {
      if (errno != EINTR) {
        return -1;
      }
      else if (rp->rio_cnt == 0) { // EOF
        return 0;
      }
      else {
        rp->rio_bufptr = rp->rio_buf; // Reset buffer ptr
      }
    }
  }

  // Copy min(n, rp->rio_cnt) bytes from internal buf to user buf
  cnt = n;
  if (rp->rio_cnt < n)
    cnt = rp->rio_cnt;
  memcpy(usrbuf, rp->rio_bufptr, cnt);
  rp->rio_bufptr += cnt;
  rp->rio_cnt -= cnt;
  return cnt;
}

ssize_t rio_readlineb(rio_t *rp, void *usrbuf, size_t maxlen) {
  int n, rc;
  char c, *bufp = usrbuf;

  for (n = 1; n < maxlen; n++) {
    if ((rc = rio_read(rp, &c, 1)) == 1) {
      *bufp++ = c;
      if (c == '\n') {
        n++;
        break;
      }
    } else if (rc == 0) {
      if (n == 1)
        return 0; // EOF, no data read
      else
        break; // EOF, some data was read
    } else {
      return -1; // Error
    }
  }
  *bufp = 0;
  return n-1;
}

ssize_t rio_readnb(rio_t *rp, void *usrbuf, size_t n) {
  size_t nleft = n;
  ssize_t nread;
  char *bufp = usrbuf;

  while (nleft > 0) {
    if ((nread = rio_read(rp, bufp, nleft)) < 0)
      return -1;
    else if (nread == 0)
      break;
    nleft -= nread;
    bufp += nread;
  }
  return (n - nleft);
}

```

----------

`/deep/10/readme.md`

打开或关闭文件

```c
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int open(char *filename, int flags, mode_t mode);
// 返回：若成功则为新文件描述符，若出错为 -1
```

```c
#include <unistd.h>

int close(int fd);
// 返回：若成功则为 0，若出错则为 -1
```

读和写文件

size_t --- unsigned long
ssize_t --- long

```c
#include <unistd.h>

ssize_t read(int fd, void *buf, size_t n);
// 返回：若成功则为读的字节数，若 EOF 则为 0，若出错为 -1

ssize_t write(int fd, const void *buf, size_t n);
// 返回：若成功则为写的字节数，若出错则为 -1
```

RIO Robust I/O

RIO 的无缓冲的输入输出函数

```c
ssize_t rio_readn(int fd, void *usrbuf, size_t n);
ssize_t rio_writen(int fd, void *usrbuf, size_t n);
// 返回：若成功则为传送的字节数，若 EOF 则为 0，若出错则为 -1
```

RIO 的带缓冲的输入函数

```c
void rio_readinitb(rio_t *rp, int fd);

ssize_t rio_readlineb(rio_t *rp, void *usrbuf, size_t maxlen);
ssize_t rio_readnb(rio_t *rp, void *usrbuf, size_t n);
// 返回：若成功则为读的字节数，若 EOF 则为 0，若出错则为 -1
```


----------

`/deep/11/csapp.c`

``` c
#include "csapp.h"
#include <unistd.h>
#define RIO_BUFSIZE 8192

typedef struct {
  int rio_fd; // Descriptor for this internal buf
  int rio_cnt; // Unread bytes in internal buf
  char *rio_bufptr; // Next unread byte in internal buf
  char rio_buf[RIO_BUFSIZE]; // Internal buffer
} rio_t;

ssize_t rio_readn(int fd, void *usrbuf, size_t n) {
  size_t nleft = n;
  ssize_t nread;
  char *bufp = usrbuf;

  while (nleft > 0) {
    if ((nread = read(fd, bufp, nleft)) < 0) {
      // Interrupted by sig handler return and call read() again
      // 被应用信号处理程序的返回终端，手动重启
      if (errno == EINTR) {
        nread = 0;
      } else {
        // errno set by read()
        return -1;
      }
    }
    else if (nread == 0) {
      // EOF
      break;
    }

    nleft -= nread;
    bufp += nread;
  }

  // Return >= 0
  return (n - nleft);
}

ssize_t rio_writen(int fd, void *usrbuf, size_t n) {
  size_t nleft = n;
  ssize_t nwritten;
  char *bufp = usrbuf;

  while (nleft > 0) {
    if ((nwritten = write(fd, bufp, nleft)) <= 0) {
      if (errno == EINTR) {
        nwritten = 0;
      } else {
        return -1;
      }
    }

    nleft -= nwritten;
    bufp += nwritten;
  }

  return n;
}

void rio_readinitb(rio_t *rp, int fd) {
  rp->rio_fd = fd;
  rp->rio_cnt = 0;
  rp->rio_bufptr = rp->rio_buf;
}

// 内部的 rio_read 函数
static ssize_t rio_read(rio_t *rp, char *usrbuf, size_t n) {
  int cnt;

  while (rp->rio_cnt <= 0) { // Refill if buf is empty
    rp->rio_cnt = read(rp->rio_fd, rp->rio_buf, sizeof(rp->rio_buf));
    if (rp->rio_cnt < 0) {
      if (errno != EINTR) {
        return -1;
      }
      else if (rp->rio_cnt == 0) { // EOF
        return 0;
      }
      else {
        rp->rio_bufptr = rp->rio_buf; // Reset buffer ptr
      }
    }
  }

  // Copy min(n, rp->rio_cnt) bytes from internal buf to user buf
  cnt = n;
  if (rp->rio_cnt < n)
    cnt = rp->rio_cnt;
  memcpy(usrbuf, rp->rio_bufptr, cnt);
  rp->rio_bufptr += cnt;
  rp->rio_cnt -= cnt;
  return cnt;
}

ssize_t rio_readlineb(rio_t *rp, void *usrbuf, size_t maxlen) {
  int n, rc;
  char c, *bufp = usrbuf;

  for (n = 1; n < maxlen; n++) {
    if ((rc = rio_read(rp, &c, 1)) == 1) {
      *bufp++ = c;
      if (c == '\n') {
        n++;
        break;
      }
    } else if (rc == 0) {
      if (n == 1)
        return 0; // EOF, no data read
      else
        break; // EOF, some data was read
    } else {
      return -1; // Error
    }
  }
  *bufp = 0;
  return n-1;
}

ssize_t rio_readnb(rio_t *rp, void *usrbuf, size_t n) {
  size_t nleft = n;
  ssize_t nread;
  char *bufp = usrbuf;

  while (nleft > 0) {
    if ((nread = rio_read(rp, bufp, nleft)) < 0)
      return -1;
    else if (nread == 0)
      break;
    nleft -= nread;
    bufp += nread;
  }
  return (n - nleft);
}


// 11

int open_clientfd(char *hostname, char *port) {
  int clientfd;
  struct addrinfo hints, *listp, *p;

  // get a list of potential server addresses
  memset(&hints, 0, sizeof(struct addrinfo));
  hints.ai_socktype = SOCK_STREAM; // open a connection
  hints.ai_flags = AI_NUMERICSERV; // using a numeric port arg
  hints.ai_flags |= AI_ADDRCONFIG; // recommender for connections
  getaddrinfo(hostname, port, &hints, &listp);

  // walk the list for one that we can successfully connect to
  for (p = listp; p; p = p->ai_next) {
    // create a socket descriptor
    if ((clientfd = socket(p->ai_family, p->ai_socktype, p->ai_protocol)) < 0)
      continue; // socket failed, try the next

    // connect to the server
    if (connect(clientfd, p->ai_addr, p->ai_addrlen) != -1)
      break; // success

    close(clientfd); // connect failed, try another
  }

  // clean up
  freeaddrinfo(listp);
  if (!p) // all connects failed
    return -1;
  else // the last connect succeeded
    return clientfd;
}

int open_listenfd(char *port) {
  struct addrinfo hints, *listp, *p;
  int listenfd, optval = 1;

  // get a list of potential server addresses
  memset(&hints, 0, sizeof(struct addrinfo));
  hints.ai_socktype = SOCK_STREAM; // accept connection
  hints.ai_flags = AI_PASSIVE | AI_ADDRCONFIG; // on any IP address
  hints.ai_flags |= AI_NUMERICSERV; // using port number
  getaddrinfo(NULL, port, &hints, &listp);

  // walk the list for one that we can bind to
  for (p = listp ; p; p = p->ai_next) {
    // create a socket descriptor
    if ((listenfd = socket(p->ai_family, p->ai_socktype, p->ai_protocol)) < 0)
      continue; // socket failed, try the next

    // eliminates "address already in use" error from bind
    setsockopt(listenfd, SOL_SOCKET, SO_REUSEADDR, (const void *)&optval, sizeof(int));

    // bind the descriptor to the address
    if (bind(listenfd, p->ai_addr, p->ai_addrlen) == 0)
      break; // success

    close(listenfd); // bind failed, try the next
  }

  // clean up
  freeaddrinfo(listp);
  if (!p) // no address worked
    return -1;

  // make it a listening socket ready to accept connection requests
  if (listen(listenfd, LISTENQ) < 0) {
    close(listenfd);
    return -1;
  }
  return listenfd;
}

```

----------

`/deep/11/csapp.h`

``` c
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>

#define RIO_BUFSIZE 8192
#define MAXLINE 100
#define LISTENQ 1024

// Unix-style error
void unix_error(char *msg) {
  fprintf(stderr, "%s: %s\n", msg, strerror(errno));
  exit(0);
}

pid_t Fork(void) {
  pid_t pid;
  if ((pid = fork()) < 0)
    unix_error("Fork error");
  return pid;
}

typedef struct {
  int rio_fd; // Descriptor for this internal buf
  int rio_cnt; // Unread bytes in internal buf
  char *rio_bufptr; // Next unread byte in internal buf
  char rio_buf[RIO_BUFSIZE]; // Internal buffer
} rio_t;

ssize_t rio_readn(int fd, void *usrbuf, size_t n) {
  size_t nleft = n;
  ssize_t nread;
  char *bufp = usrbuf;

  while (nleft > 0) {
    if ((nread = read(fd, bufp, nleft)) < 0) {
      // Interrupted by sig handler return and call read() again
      // 被应用信号处理程序的返回终端，手动重启
      if (errno == EINTR) {
        nread = 0;
      } else {
        // errno set by read()
        return -1;
      }
    }
    else if (nread == 0) {
      // EOF
      break;
    }

    nleft -= nread;
    bufp += nread;
  }

  // Return >= 0
  return (n - nleft);
}

ssize_t rio_writen(int fd, void *usrbuf, size_t n) {
  size_t nleft = n;
  ssize_t nwritten;
  char *bufp = usrbuf;

  while (nleft > 0) {
    if ((nwritten = write(fd, bufp, nleft)) <= 0) {
      if (errno == EINTR) {
        nwritten = 0;
      } else {
        return -1;
      }
    }

    nleft -= nwritten;
    bufp += nwritten;
  }

  return n;
}

void rio_readinitb(rio_t *rp, int fd) {
  rp->rio_fd = fd;
  rp->rio_cnt = 0;
  rp->rio_bufptr = rp->rio_buf;
}

// 内部的 rio_read 函数
static ssize_t rio_read(rio_t *rp, char *usrbuf, size_t n) {
  int cnt;

  while (rp->rio_cnt <= 0) { // Refill if buf is empty
    rp->rio_cnt = read(rp->rio_fd, rp->rio_buf, sizeof(rp->rio_buf));
    if (rp->rio_cnt < 0) {
      if (errno != EINTR) {
        return -1;
      }
      else if (rp->rio_cnt == 0) { // EOF
        return 0;
      }
      else {
        rp->rio_bufptr = rp->rio_buf; // Reset buffer ptr
      }
    }
  }

  // Copy min(n, rp->rio_cnt) bytes from internal buf to user buf
  cnt = n;
  if (rp->rio_cnt < n)
    cnt = rp->rio_cnt;
  memcpy(usrbuf, rp->rio_bufptr, cnt);
  rp->rio_bufptr += cnt;
  rp->rio_cnt -= cnt;
  return cnt;
}

ssize_t rio_readlineb(rio_t *rp, void *usrbuf, size_t maxlen) {
  int n, rc;
  char c, *bufp = usrbuf;

  for (n = 1; n < maxlen; n++) {
    if ((rc = rio_read(rp, &c, 1)) == 1) {
      *bufp++ = c;
      if (c == '\n') {
        n++;
        break;
      }
    } else if (rc == 0) {
      if (n == 1)
        return 0; // EOF, no data read
      else
        break; // EOF, some data was read
    } else {
      return -1; // Error
    }
  }
  *bufp = 0;
  return n-1;
}

ssize_t rio_readnb(rio_t *rp, void *usrbuf, size_t n) {
  size_t nleft = n;
  ssize_t nread;
  char *bufp = usrbuf;

  while (nleft > 0) {
    if ((nread = rio_read(rp, bufp, nleft)) < 0)
      return -1;
    else if (nread == 0)
      break;
    nleft -= nread;
    bufp += nread;
  }
  return (n - nleft);
}


// 11

int open_clientfd(char *hostname, char *port) {
  int clientfd;
  struct addrinfo hints, *listp, *p;

  // get a list of potential server addresses
  memset(&hints, 0, sizeof(struct addrinfo));
  hints.ai_socktype = SOCK_STREAM; // open a connection
  hints.ai_flags = AI_NUMERICSERV; // using a numeric port arg
  hints.ai_flags |= AI_ADDRCONFIG; // recommender for connections
  getaddrinfo(hostname, port, &hints, &listp);

  // walk the list for one that we can successfully connect to
  for (p = listp; p; p = p->ai_next) {
    // create a socket descriptor
    if ((clientfd = socket(p->ai_family, p->ai_socktype, p->ai_protocol)) < 0)
      continue; // socket failed, try the next

    // connect to the server
    if (connect(clientfd, p->ai_addr, p->ai_addrlen) != -1)
      break; // success

    close(clientfd); // connect failed, try another
  }

  // clean up
  freeaddrinfo(listp);
  if (!p) // all connects failed
    return -1;
  else // the last connect succeeded
    return clientfd;
}

int open_listenfd(char *port) {
  struct addrinfo hints, *listp, *p;
  int listenfd, optval = 1;

  // get a list of potential server addresses
  memset(&hints, 0, sizeof(struct addrinfo));
  hints.ai_socktype = SOCK_STREAM; // accept connection
  hints.ai_flags = AI_PASSIVE | AI_ADDRCONFIG; // on any IP address
  hints.ai_flags |= AI_NUMERICSERV; // using port number
  getaddrinfo(NULL, port, &hints, &listp);

  // walk the list for one that we can bind to
  for (p = listp ; p; p = p->ai_next) {
    // create a socket descriptor
    if ((listenfd = socket(p->ai_family, p->ai_socktype, p->ai_protocol)) < 0)
      continue; // socket failed, try the next

    // eliminates "address already in use" error from bind
    setsockopt(listenfd, SOL_SOCKET, SO_REUSEADDR, (const void *)&optval, sizeof(int));

    // bind the descriptor to the address
    if (bind(listenfd, p->ai_addr, p->ai_addrlen) == 0)
      break; // success

    close(listenfd); // bind failed, try the next
  }

  // clean up
  freeaddrinfo(listp);
  if (!p) // no address worked
    return -1;

  // make it a listening socket ready to accept connection requests
  if (listen(listenfd, LISTENQ) < 0) {
    close(listenfd);
    return -1;
  }
  return listenfd;
}


void echo(int connfd) {
  size_t n;
  char buf[MAXLINE];
  rio_t rio;

  rio_readinitb(&rio, connfd);
  while((n = rio_readlineb(&rio, buf, MAXLINE)) != 0) {
    printf("server received %d bytes\n", (int)n);
    rio_writen(connfd, buf, n);
  }
}

```

----------

`/deep/11/echo.c`

``` c
#include "csapp.h"

void echo(int connfd) {
  size_t n;
  char buf[MAXLINE];
  rio_t rio;

  rio_readinitb(&rio, connfd);
  while((n = rio_readlineb(&rio, buf, MAXLINE)) != 0) {
    printf("server received %d bytes\n", (int)n);
    rio_writen(connfd, buf, n);
  }
}

```

----------

`/deep/11/echoclient.c`

``` c
#include "csapp.h"

int main(int argc, char **argv) {
  int clientfd;
  char *host, *port, buf[MAXLINE];
  rio_t rio;

  if (argc != 3) {
    fprintf(stderr, "usage: %s <host> <port>\n", argv[0]);
    exit(0);
  }
  host = argv[1];
  port = argv[2];

  clientfd = open_clientfd(host, port);
  rio_readinitb(&rio, clientfd);

  while (fgets(buf, MAXLINE, stdin) != NULL) {
    rio_writen(clientfd, buf, strlen(buf));
    rio_readlineb(&rio, buf, MAXLINE);
    fputs(buf, stdout);
  }
  close(clientfd);
  exit(0);
}

```

----------

`/deep/11/echoserveri.c`

``` c
#include "csapp.h"

void echo(int connfd);

int main(int argc, char **argv) {
  int listenfd, connfd;
  socklen_t clientlen;
  struct sockaddr_storage clientaddr; // enough space for any address
  char client_hostname[MAXLINE], client_port[MAXLINE];

  if (argc != 2) {
    fprintf(stderr, "usage: %s <port>\n", argv[0]);
    exit(0);
  }

  listenfd = open_listenfd(argv[1]);
  while (1) {
    clientlen = sizeof(struct sockaddr_storage);
    connfd = accept(listenfd, (struct sockaddr *) (&clientaddr), &clientlen);
    getnameinfo((struct sockaddr *) (&clientaddr), clientlen, client_hostname, MAXLINE, client_port, MAXLINE, 0);
    printf("Connected to (%s %s)\n", client_hostname, client_port);
    echo(connfd);
    close(connfd);
  }
  exit(0);
}

```

----------

`/deep/11/hostinfo.c`

``` c
#include "csapp.h"

int main(int argc, char **argv) {
  struct addrinfo *p, *listp, hints;
  char buf[MAXLINE];
  int rc, flags;

  if (argc != 2) {
    fprintf(stderr, "usage: %s <domain name>\n", argv[0]);
    exit(0);
  }

  // get a list of addrinfo records
  memset(&hints, 0, sizeof(struct addrinfo));
  hints.ai_family = AF_INET; // IPv4 only
  hints.ai_socktype = SOCK_STREAM; // Connections only
  if ((rc = getaddrinfo(argv[1], NULL, &hints, &listp)) != 0) {
    fprintf(stderr, "getaddrinfo error: %s\n", gai_strerror(rc));
    exit(1);
  }

  // Walk the list and display each IP address
  flags = NI_NUMERICHOST; // Display address string instead of domain name
  for (p = listp; p; p = p->ai_next) {
    getnameinfo(p->ai_addr, p->ai_addrlen, buf, MAXLINE, NULL, 0, flags);
    printf("%s\n", buf);
  }

  // Clean up
  freeaddrinfo(listp);

  exit(0);
}

```

----------

`/deep/11/readme.md`

IP 地址

```c
// IP address structure
struct in_addr {
  uint32_t s_addr; // Address in netword byte order (big-endian)
};
```

Unix 提供了下面这样的函数在网络和主机字节顺序间实现转换。

```c
#include <arpa/inet.h>

uint32_t htonl(uint32_t hostlong);
uint16_t htons(uint16_t hostshort);
// 返回：按照网络字节顺序的值

uint32_t ntohl(uint32_t netlong);
uint16_t ntohs(uint16_t netshort);
// 返回：按照主机字节顺序的值
```

套接字地址结构

```c
// IP socket address structure
struct sockaddr_in {
  uint16_t sin_family;
  uint16_t sin_port;
  struct in_addr sin_addr;
  unsigned char sin_zero[8];
};

// Generic socket address structure
struct sockaddr {
  uint16_t sa_family;
  char sa_data[14];
};
```

socket 函数

客户端和服务器使用 socket 函数来创建一个套接字描述符。

```c
#include <sys/types.h>
#include <sys/socket.h>

int socket(int domain, int type, int protocol);
// 返回：若成功则为非负描述符，若出错则为 -1
```

connect 函数

客户端通过调用 connect 函数来建立和服务器的连接。

```c
#include <sys/socket.h>

int connect(int clientfd, const struct sockaddr *addr, socklen_t addrlen);
// 返回：若成功则为 0，若出错则为 -1
```
connect 函数会阻塞

服务器：bind、listen 和 accept

```c
#include <sys/socket.h>

int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
// 返回：若成功则为 0，若出错则为 -1
```

```c
#include <sys/socket.h>

int listen(int sockfd, int backlog);
// 返回：若成功则为 0，若出错则为 -1
```

```c
#include <sys/socket.h>

int accept(int listenfd, struct sockaddr *addr, int *addrlen);
// 返回：若成功则为非负连接描述符，若出错则为 -1
```

getaddrinfo 函数

将主机名、主机地址、服务名和端口号的字符串表示转化成套接字地址结构。

```c
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>

int getaddrinfo(const char *host, const char *service, const struct addrinfo *hints, struct addrinfo **result);
// 返回：如果成功则为 0，如果错误则为非零的错误代码

void freeaddrinfo(struct addrinfo *result);
// 返回： 无

const char *gai_strerror(int errcode);
// 返回：错误消息
```

addrinfo 结构

```c
struct addrinfo {
  int ai_flags;
  int ai_family;
  int ai_socktype;
  int ai_protocol;
  char *ai_canonname;
  size_t ai_addrlen;
  struct sockaddr *ai_addr;
  struct addrinfo *ai_next;
};
```

getnameinfo 与 getaddrinfo 相反

```c
#include <sys/socket.h>
#include <netdb.h>

int getnameinfo(const struct sockaddr *sa, socklen_t salen, char *host, size_t hostlen, char * service, size_t servlen, int flags);
// 返回：如果成功则为 0，如果错误则为非零的错误代码
```

套接字接口辅助函数

```c
int open_clientfd(char *hostname, char *port);
int open_listenfd(char *port);
// 返回：若成功则为描述符，若出错则为 -1
```


----------

`/deep/7-link/main.c`

``` c
int sum(int *a, int n);

int array[2] = {1, 2};

int main()
{
  int val = sum(array, 2);
  return val;
}

```

----------

`/deep/7-link/readme.md`

gcc -Og -o prog main.c sum.c


----------

`/deep/7-link/sum.c`

``` c
int sum(int *a, int n)
{
  int i, s = 0;

  for (i = 0; i < n; i++) {
    s += a[i];
  }

  return s;
}

```

----------

`/deep/8/csapp.h`

``` c
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>

// Unix-style error
void unix_error(char *msg) {
  fprintf(stderr, "%s: %s\n", msg, strerror(errno));
  exit(0);
}

pid_t Fork(void) {
  pid_t pid;
  if ((pid = fork()) < 0)
    unix_error("Fork error");
  return pid;
}

```

----------

`/deep/8/fork.c`

``` c
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>

int main()
{
  pid_t pid;
  int x = 1;

  pid = fork();
  // 子进程
  if (pid == 0) {
    printf("child : x=%d\n", ++x);
    exit(0);
  }

  // 父进程
  printf("parent: x=%d\n", --x);
  exit(0);
}

```

----------

`/deep/8/get_pid.c`

``` c
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

int main() {
  // 当前进程
  pid_t p = getpid();
  printf("pid: %d\n", p);

  // 父进程
  p = getppid();
  printf("ppid: %d\n", p);

  // 进程组
  p = getpgrp();
  printf("pgrp: %d\n", p);

  return 0;
}

```

----------

`/deep/8/hello.c`

``` c
int main()
{
  write(1, "hello, world\n", 13);
  _exit(0);
}

```

----------

`/deep/8/kill.c`

``` c
#include "csapp.h"

int main() {
  pid_t pid;

  // Child sleeps until SIGKILL signal received, then dies
  if ((pid = Fork()) == 0) {
    // Wait for a signal to arrive
    pause();
    printf("control should never reach here!\n");
    exit(0);
  }

  // Parent sends a SIGKILL signal to a child
  kill(pid, SIGKILL);
  exit(0);
}

```

----------

`/deep/8/sigint.c`

``` c
#include "csapp.h"

// 捕获键盘 Ctrl+C 发送的 SIGINT 信号

// SIGINT handler
void sigint_handler(int sig) {
  printf("Caught SIGINT!\n");
  exit(0);
}

int main() {
  // Install the SIGINT handler
  if (signal(SIGINT, sigint_handler) == SIG_ERR)
    unix_error("signal error");

  // Wait for the receipt of a signal
  pause();

  return 0;
}

```

----------

`/deep/8/waitpid1.c`

``` c
#include "csapp.h"
#define N 10

int main()
{
  int status, i;
  pid_t pid;

  // 创建 N 个子进程
  for (i = 0; i < N; i++) {
    if ((pid = Fork()) == 0) {
      // 子进程退出
      exit(100+i);
    }
  }

  // 回收子进程，顺序不固定
  while ((pid = waitpid(-1, &status, 0)) > 0) {
    if (WIFEXITED(status)) {
      printf("child %d terminated normally with exit status=%d\n", pid, WEXITSTATUS(status));
    } else {
      printf("child %d terminated abnormally\n", pid);
    }
  }

  // 最后一次调用 waitpid 返回 -1，并设置 errno 为 ECHILD
  if (errno != ECHILD) {
    unix_error("waitpid error");
  }

  exit(0);
}

```

----------

`/deep/8/waitpid2.c`

``` c
#include "csapp.h"
#define N 10

int main()
{
  int status, i;
  pid_t pid[N], retpid;

  // 创建 N 个子进程
  for (i = 0; i < N; i++) {
    if ((pid[i] = Fork()) == 0) {
      // 子进程退出
      exit(100+i);
    }
  }

  // 回收子进程，顺序固定
  i = 0;
  while ((retpid = waitpid(pid[i++], &status, 0)) > 0) {
    if (WIFEXITED(status)) {
      printf("child %d terminated normally with exit status=%d\n", retpid, WEXITSTATUS(status));
    } else {
      printf("child %d terminated abnormally\n", retpid);
    }
  }

  // 最后一次调用 waitpid 返回 -1，并设置 errno 为 ECHILD
  if (errno != ECHILD) {
    unix_error("waitpid error");
  }

  exit(0);
}

```

----------

`/note.md`

# C程序设计语言

## 1 - 导言

编译：cc hello.c

执行：./a.out

`include <stdio.h>` 包含标准库的信息，告诉编译器在本程序中包含标准输入/输出库的信息。

程序的起点为 main 函数

main 函数不接收参数值

用双引号括起来的字符序列称为**字符串**或**字符常量**。

printf 函数不是C语言本身的一部分，仅是标准库函数中的一个函数。

- %3.0f 至少占3字符宽，不带小数点和小数部分
- %6.1f 至少占6字符宽，小数点后面有1位数字

- %d 十进制
- %f 浮点数
- %o 八进制
- %x 十六进制
- %c 字符
- %s 字符串
- %% %

`#define` 指令可以把符号名（符号变量）定义为一个特定的字符串：`#define 名字 替换文本`，指令末尾无分号。

getchar() 和 putchar()

- getchar 从文本流中读入下一个输入字符，作为结果返回
- putchar 将打印一个字符

EOF end of file 定义在头文件`<stdio.h>` 中，是一个**整型数**。与任何 char 类型的值都不相同。


----------

`/tmp/main.c`

``` c
#include <stdio.h>

void multstore(long, long, long *);

int main() {
  long d;
  multstore(2, 3, &d);
  printf("2 * 3 --> %ld\n", d);
  return 0;
}

long mult2(long a, long b) {
  long s = a * b;
  return s;
}

```

----------

`/tmp/mstore.c`

``` c
long mult2(long, long);

void multstore(long x, long y, long *dest) {
  long t = mult2(x, y);
  *dest = t;
}

```

----------

`/tmp/show_bytes.c`

``` c
#include <stdio.h>

// 使用强制类型转换来访问和打印不同程序对象的字节表示

typedef unsigned char *byte_pointer;

void show_bytes(byte_pointer start, size_t len) {
  // 因为 char 类型的指针每次是按照字节加 1
  // 所以可以打印出存储在相应地址的字节

  // pa[i] 与 *(pa+i) 是等价的
  // 一个通过数组和下标实现的表达式可等价地通过指针和偏移量实现
  for (size_t i = 0; i < len; i++) {
    // 数组形式
    // start[i] 表示读取以 start 指向的位置为起始的第 i 个位置处的字节
    printf(" %.2x", start[i]);

    // 指针形式
    // printf(" %.2x", *start++);
  }
  printf("\n");
}

void show_int(int x) {
  // 强制类型转换
  // 并不会改变真实的指针，而是告诉编译器以新的数据类型来看待被指向的数据
  show_bytes((byte_pointer) &x, sizeof(int));
}

void show_float(float x) {
  show_bytes((byte_pointer) &x, sizeof(float));
}

// 指向任何对象的指针都可以转换为 void * 类型，且不会丢失信息
// 如果将结果再转换为初始指针类型，则可以恢复初始指针
// ANSI C 使用类型 void * 代替 char * 作为通用指针的类型
void show_pointer(void *x) {
  show_bytes((byte_pointer) &x, sizeof(void *));
}

void test_show_bytes(int val) {
  int ival = val;
  // 39 30 00 00 => 小端法
  show_int(ival);
  show_float((float)ival);
  show_pointer(&ival);
}

int main() {
  // 0x00003039
  int val = 12345;
  test_show_bytes(val);
  show_bytes((byte_pointer) &"12345", 6);
  return 0;
}

```

----------

`/tmp.md`

`/1-导言/1.6.c`

``` c
#include <stdio.h>

// 1-6

main() {
  int c;
  while (c = getchar() != EOF)
    printf("%d\n", c);
  printf("%d - at EOF\n", c);
}

```

----------

`/1-导言/1.7.c`

``` c
#include <stdio.h>

// 1-7

main()
{
  printf("EOF is %d\n", EOF);
}

```

----------

`/1-导言/a.c`

``` c
#include <stdio.h>

// 打印华氏温度和摄氏温度对照表
// c = (5/9) * (f-32)

main()
{
  int fahr, celsius;
  int lower, upper, step;

  lower = 0;
  upper = 300;
  step = 20;

  fahr = lower;
  while (fahr <= upper) {
    celsius = 5 * (fahr-32) / 9;
    printf("%d\t%d\n", fahr, celsius);
    fahr = fahr + step;
  }
}

```

----------

`/1-导言/b.c`

``` c
#include <stdio.h>

// 打印华氏温度和摄氏温度对照表
// c = (5/9) * (f-32)
// 优化版本

main()
{
  // 浮点数
  float fahr, celsius;
  int lower, upper, step;

  lower = 0;
  upper = 300;
  step = 20;

  fahr = lower;
  while (fahr <= upper)
  {
    celsius = (5.0/9.0) * (fahr-32.0);
    // 输出美观
    // %3.0f 至少占3字符宽，不带小数点和小数部分
    // %6.1f 至少占6字符宽，小数点后面有1位数字
    printf("%3.0f %6.1f\n", fahr, celsius);
    fahr = fahr + step;
  }
}

```

----------

`/1-导言/c.c`

``` c
# include <stdio.h>

// 摄氏温度转华氏温度
// f = 9*c / 5 + 32

main()
{
  float fahr, celsius;
  int lower, upper, step;

  lower = 0;
  upper = 300;
  step = 20;

  printf("Celsius  Fahr\n");
  celsius = lower;
  while (celsius <= upper) {
    fahr = 9.0 * celsius / 5.0 + 32.0;
    printf("%3.0f     %6.1f\n", celsius, fahr);
    celsius = celsius + step;
  }
}

```

----------

`/1-导言/copy.c`

``` c
#include <stdio.h>

main() {
  int c;
  c = getchar();
  while(c != EOF){
    putchar(c);
    c = getchar();
  }
}

```

----------

`/1-导言/copy2.c`

``` c
#include <stdio.h>

main()
{
  int c;

  while ((c = getchar()) != EOF)
    putchar(c);
}

```

----------

`/1-导言/d.c`

``` c
#include <stdio.h>

// 打印华氏温度和摄氏温度对照表
// c = (5/9) * (f-32)
// 优化版本
// for

main()
{
  float fahr;

  for (fahr = 0; fahr <= 300; fahr = fahr + 20) {
    printf("%3.0f %6.1f\n", fahr, (5.0 / 9.0) * (fahr - 32.0));
  }
}

```

----------

`/1-导言/e.c`

``` c
#include <stdio.h>

// 打印华氏温度和摄氏温度对照表
// c = (5/9) * (f-32)
// 优化版本
// for
// 逆序

main()
{
  float fahr;

  for (fahr = 300; fahr >= 0; fahr = fahr - 20)
  {
    printf("%3.0f %6.1f\n", fahr, (5.0 / 9.0) * (fahr - 32.0));
  }
}

```

----------

`/1-导言/f.c`

``` c
#include <stdio.h>

#define LOWER 0
#define UPPER 300
#define STEP 20

// 打印华氏温度和摄氏温度对照表
// c = (5/9) * (f-32)
// 优化版本
// for

main()
{
  float fahr;

  for (fahr = LOWER; fahr <= UPPER; fahr = fahr + STEP)
  {
    printf("%3.0f %6.1f\n", fahr, (5.0 / 9.0) * (fahr - 32.0));
  }
}

```

----------

`/1-导言/hello.c`

``` c
#include <stdio.h>

main()
{
  printf("hello, world\n");
}

```

----------

`/deep/10/cpstdin.c`

``` c
#include <unistd.h>

// 使用 read 和 write 调用一次一个字节地从标准输入复制到标准输出

int main() {
  char c;

  while (read(STDIN_FILENO, &c, 1) != 0) {
    write(STDOUT_FILENO, &c, 1);
  }

  return 0;
}

```

----------

`/deep/10/csapp.c`

``` c
#include <unistd.h>
#define RIO_BUFSIZE 8192

typedef struct {
  int rio_fd; // Descriptor for this internal buf
  int rio_cnt; // Unread bytes in internal buf
  char *rio_bufptr; // Next unread byte in internal buf
  char rio_buf[RIO_BUFSIZE]; // Internal buffer
} rio_t;

ssize_t rio_readn(int fd, void *usrbuf, size_t n) {
  size_t nleft = n;
  ssize_t nread;
  char *bufp = usrbuf;

  while (nleft > 0) {
    if ((nread = read(fd, bufp, nleft)) < 0) {
      // Interrupted by sig handler return and call read() again
      // 被应用信号处理程序的返回终端，手动重启
      if (errno == EINTR) {
        nread = 0;
      } else {
        // errno set by read()
        return -1;
      }
    }
    else if (nread == 0) {
      // EOF
      break;
    }

    nleft -= nread;
    bufp += nread;
  }

  // Return >= 0
  return (n - nleft);
}

ssize_t rio_writen(int fd, void *usrbuf, size_t n) {
  size_t nleft = n;
  ssize_t nwritten;
  char *bufp = usrbuf;

  while (nleft > 0) {
    if ((nwritten = write(fd, bufp, nleft)) <= 0) {
      if (errno == EINTR) {
        nwritten = 0;
      } else {
        return -1;
      }
    }

    nleft -= nwritten;
    bufp += nwritten;
  }

  return n;
}

void rio_readinitb(rio_t *rp, int fd) {
  rp->rio_fd = fd;
  rp->rio_cnt = 0;
  rp->rio_bufptr = rp->rio_buf;
}

// 内部的 rio_read 函数
static ssize_t rio_read(rio_t *rp, char *usrbuf, size_t n) {
  int cnt;

  while (rp->rio_cnt <= 0) { // Refill if buf is empty
    rp->rio_cnt = read(rp->rio_fd, rp->rio_buf, sizeof(rp->rio_buf));
    if (rp->rio_cnt < 0) {
      if (errno != EINTR) {
        return -1;
      }
      else if (rp->rio_cnt == 0) { // EOF
        return 0;
      }
      else {
        rp->rio_bufptr = rp->rio_buf; // Reset buffer ptr
      }
    }
  }

  // Copy min(n, rp->rio_cnt) bytes from internal buf to user buf
  cnt = n;
  if (rp->rio_cnt < n)
    cnt = rp->rio_cnt;
  memcpy(usrbuf, rp->rio_bufptr, cnt);
  rp->rio_bufptr += cnt;
  rp->rio_cnt -= cnt;
  return cnt;
}

ssize_t rio_readlineb(rio_t *rp, void *usrbuf, size_t maxlen) {
  int n, rc;
  char c, *bufp = usrbuf;

  for (n = 1; n < maxlen; n++) {
    if ((rc = rio_read(rp, &c, 1)) == 1) {
      *bufp++ = c;
      if (c == '\n') {
        n++;
        break;
      }
    } else if (rc == 0) {
      if (n == 1)
        return 0; // EOF, no data read
      else
        break; // EOF, some data was read
    } else {
      return -1; // Error
    }
  }
  *bufp = 0;
  return n-1;
}

ssize_t rio_readnb(rio_t *rp, void *usrbuf, size_t n) {
  size_t nleft = n;
  ssize_t nread;
  char *bufp = usrbuf;

  while (nleft > 0) {
    if ((nread = rio_read(rp, bufp, nleft)) < 0)
      return -1;
    else if (nread == 0)
      break;
    nleft -= nread;
    bufp += nread;
  }
  return (n - nleft);
}

```

----------

`/deep/10/readme.md`

打开或关闭文件

```c
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int open(char *filename, int flags, mode_t mode);
// 返回：若成功则为新文件描述符，若出错为 -1
```

```c
#include <unistd.h>

int close(int fd);
// 返回：若成功则为 0，若出错则为 -1
```

读和写文件

size_t --- unsigned long
ssize_t --- long

```c
#include <unistd.h>

ssize_t read(int fd, void *buf, size_t n);
// 返回：若成功则为读的字节数，若 EOF 则为 0，若出错为 -1

ssize_t write(int fd, const void *buf, size_t n);
// 返回：若成功则为写的字节数，若出错则为 -1
```

RIO Robust I/O

RIO 的无缓冲的输入输出函数

```c
ssize_t rio_readn(int fd, void *usrbuf, size_t n);
ssize_t rio_writen(int fd, void *usrbuf, size_t n);
// 返回：若成功则为传送的字节数，若 EOF 则为 0，若出错则为 -1
```

RIO 的带缓冲的输入函数

```c
void rio_readinitb(rio_t *rp, int fd);

ssize_t rio_readlineb(rio_t *rp, void *usrbuf, size_t maxlen);
ssize_t rio_readnb(rio_t *rp, void *usrbuf, size_t n);
// 返回：若成功则为读的字节数，若 EOF 则为 0，若出错则为 -1
```


----------

`/deep/11/csapp.c`

``` c
#include "csapp.h"
#include <unistd.h>
#define RIO_BUFSIZE 8192

typedef struct {
  int rio_fd; // Descriptor for this internal buf
  int rio_cnt; // Unread bytes in internal buf
  char *rio_bufptr; // Next unread byte in internal buf
  char rio_buf[RIO_BUFSIZE]; // Internal buffer
} rio_t;

ssize_t rio_readn(int fd, void *usrbuf, size_t n) {
  size_t nleft = n;
  ssize_t nread;
  char *bufp = usrbuf;

  while (nleft > 0) {
    if ((nread = read(fd, bufp, nleft)) < 0) {
      // Interrupted by sig handler return and call read() again
      // 被应用信号处理程序的返回终端，手动重启
      if (errno == EINTR) {
        nread = 0;
      } else {
        // errno set by read()
        return -1;
      }
    }
    else if (nread == 0) {
      // EOF
      break;
    }

    nleft -= nread;
    bufp += nread;
  }

  // Return >= 0
  return (n - nleft);
}

ssize_t rio_writen(int fd, void *usrbuf, size_t n) {
  size_t nleft = n;
  ssize_t nwritten;
  char *bufp = usrbuf;

  while (nleft > 0) {
    if ((nwritten = write(fd, bufp, nleft)) <= 0) {
      if (errno == EINTR) {
        nwritten = 0;
      } else {
        return -1;
      }
    }

    nleft -= nwritten;
    bufp += nwritten;
  }

  return n;
}

void rio_readinitb(rio_t *rp, int fd) {
  rp->rio_fd = fd;
  rp->rio_cnt = 0;
  rp->rio_bufptr = rp->rio_buf;
}

// 内部的 rio_read 函数
static ssize_t rio_read(rio_t *rp, char *usrbuf, size_t n) {
  int cnt;

  while (rp->rio_cnt <= 0) { // Refill if buf is empty
    rp->rio_cnt = read(rp->rio_fd, rp->rio_buf, sizeof(rp->rio_buf));
    if (rp->rio_cnt < 0) {
      if (errno != EINTR) {
        return -1;
      }
      else if (rp->rio_cnt == 0) { // EOF
        return 0;
      }
      else {
        rp->rio_bufptr = rp->rio_buf; // Reset buffer ptr
      }
    }
  }

  // Copy min(n, rp->rio_cnt) bytes from internal buf to user buf
  cnt = n;
  if (rp->rio_cnt < n)
    cnt = rp->rio_cnt;
  memcpy(usrbuf, rp->rio_bufptr, cnt);
  rp->rio_bufptr += cnt;
  rp->rio_cnt -= cnt;
  return cnt;
}

ssize_t rio_readlineb(rio_t *rp, void *usrbuf, size_t maxlen) {
  int n, rc;
  char c, *bufp = usrbuf;

  for (n = 1; n < maxlen; n++) {
    if ((rc = rio_read(rp, &c, 1)) == 1) {
      *bufp++ = c;
      if (c == '\n') {
        n++;
        break;
      }
    } else if (rc == 0) {
      if (n == 1)
        return 0; // EOF, no data read
      else
        break; // EOF, some data was read
    } else {
      return -1; // Error
    }
  }
  *bufp = 0;
  return n-1;
}

ssize_t rio_readnb(rio_t *rp, void *usrbuf, size_t n) {
  size_t nleft = n;
  ssize_t nread;
  char *bufp = usrbuf;

  while (nleft > 0) {
    if ((nread = rio_read(rp, bufp, nleft)) < 0)
      return -1;
    else if (nread == 0)
      break;
    nleft -= nread;
    bufp += nread;
  }
  return (n - nleft);
}


// 11

int open_clientfd(char *hostname, char *port) {
  int clientfd;
  struct addrinfo hints, *listp, *p;

  // get a list of potential server addresses
  memset(&hints, 0, sizeof(struct addrinfo));
  hints.ai_socktype = SOCK_STREAM; // open a connection
  hints.ai_flags = AI_NUMERICSERV; // using a numeric port arg
  hints.ai_flags |= AI_ADDRCONFIG; // recommender for connections
  getaddrinfo(hostname, port, &hints, &listp);

  // walk the list for one that we can successfully connect to
  for (p = listp; p; p = p->ai_next) {
    // create a socket descriptor
    if ((clientfd = socket(p->ai_family, p->ai_socktype, p->ai_protocol)) < 0)
      continue; // socket failed, try the next

    // connect to the server
    if (connect(clientfd, p->ai_addr, p->ai_addrlen) != -1)
      break; // success

    close(clientfd); // connect failed, try another
  }

  // clean up
  freeaddrinfo(listp);
  if (!p) // all connects failed
    return -1;
  else // the last connect succeeded
    return clientfd;
}

int open_listenfd(char *port) {
  struct addrinfo hints, *listp, *p;
  int listenfd, optval = 1;

  // get a list of potential server addresses
  memset(&hints, 0, sizeof(struct addrinfo));
  hints.ai_socktype = SOCK_STREAM; // accept connection
  hints.ai_flags = AI_PASSIVE | AI_ADDRCONFIG; // on any IP address
  hints.ai_flags |= AI_NUMERICSERV; // using port number
  getaddrinfo(NULL, port, &hints, &listp);

  // walk the list for one that we can bind to
  for (p = listp ; p; p = p->ai_next) {
    // create a socket descriptor
    if ((listenfd = socket(p->ai_family, p->ai_socktype, p->ai_protocol)) < 0)
      continue; // socket failed, try the next

    // eliminates "address already in use" error from bind
    setsockopt(listenfd, SOL_SOCKET, SO_REUSEADDR, (const void *)&optval, sizeof(int));

    // bind the descriptor to the address
    if (bind(listenfd, p->ai_addr, p->ai_addrlen) == 0)
      break; // success

    close(listenfd); // bind failed, try the next
  }

  // clean up
  freeaddrinfo(listp);
  if (!p) // no address worked
    return -1;

  // make it a listening socket ready to accept connection requests
  if (listen(listenfd, LISTENQ) < 0) {
    close(listenfd);
    return -1;
  }
  return listenfd;
}

```

----------

`/deep/11/csapp.h`

``` c
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>

#define RIO_BUFSIZE 8192
#define MAXLINE 100
#define LISTENQ 1024

// Unix-style error
void unix_error(char *msg) {
  fprintf(stderr, "%s: %s\n", msg, strerror(errno));
  exit(0);
}

pid_t Fork(void) {
  pid_t pid;
  if ((pid = fork()) < 0)
    unix_error("Fork error");
  return pid;
}

typedef struct {
  int rio_fd; // Descriptor for this internal buf
  int rio_cnt; // Unread bytes in internal buf
  char *rio_bufptr; // Next unread byte in internal buf
  char rio_buf[RIO_BUFSIZE]; // Internal buffer
} rio_t;

ssize_t rio_readn(int fd, void *usrbuf, size_t n) {
  size_t nleft = n;
  ssize_t nread;
  char *bufp = usrbuf;

  while (nleft > 0) {
    if ((nread = read(fd, bufp, nleft)) < 0) {
      // Interrupted by sig handler return and call read() again
      // 被应用信号处理程序的返回终端，手动重启
      if (errno == EINTR) {
        nread = 0;
      } else {
        // errno set by read()
        return -1;
      }
    }
    else if (nread == 0) {
      // EOF
      break;
    }

    nleft -= nread;
    bufp += nread;
  }

  // Return >= 0
  return (n - nleft);
}

ssize_t rio_writen(int fd, void *usrbuf, size_t n) {
  size_t nleft = n;
  ssize_t nwritten;
  char *bufp = usrbuf;

  while (nleft > 0) {
    if ((nwritten = write(fd, bufp, nleft)) <= 0) {
      if (errno == EINTR) {
        nwritten = 0;
      } else {
        return -1;
      }
    }

    nleft -= nwritten;
    bufp += nwritten;
  }

  return n;
}

void rio_readinitb(rio_t *rp, int fd) {
  rp->rio_fd = fd;
  rp->rio_cnt = 0;
  rp->rio_bufptr = rp->rio_buf;
}

// 内部的 rio_read 函数
static ssize_t rio_read(rio_t *rp, char *usrbuf, size_t n) {
  int cnt;

  while (rp->rio_cnt <= 0) { // Refill if buf is empty
    rp->rio_cnt = read(rp->rio_fd, rp->rio_buf, sizeof(rp->rio_buf));
    if (rp->rio_cnt < 0) {
      if (errno != EINTR) {
        return -1;
      }
      else if (rp->rio_cnt == 0) { // EOF
        return 0;
      }
      else {
        rp->rio_bufptr = rp->rio_buf; // Reset buffer ptr
      }
    }
  }

  // Copy min(n, rp->rio_cnt) bytes from internal buf to user buf
  cnt = n;
  if (rp->rio_cnt < n)
    cnt = rp->rio_cnt;
  memcpy(usrbuf, rp->rio_bufptr, cnt);
  rp->rio_bufptr += cnt;
  rp->rio_cnt -= cnt;
  return cnt;
}

ssize_t rio_readlineb(rio_t *rp, void *usrbuf, size_t maxlen) {
  int n, rc;
  char c, *bufp = usrbuf;

  for (n = 1; n < maxlen; n++) {
    if ((rc = rio_read(rp, &c, 1)) == 1) {
      *bufp++ = c;
      if (c == '\n') {
        n++;
        break;
      }
    } else if (rc == 0) {
      if (n == 1)
        return 0; // EOF, no data read
      else
        break; // EOF, some data was read
    } else {
      return -1; // Error
    }
  }
  *bufp = 0;
  return n-1;
}

ssize_t rio_readnb(rio_t *rp, void *usrbuf, size_t n) {
  size_t nleft = n;
  ssize_t nread;
  char *bufp = usrbuf;

  while (nleft > 0) {
    if ((nread = rio_read(rp, bufp, nleft)) < 0)
      return -1;
    else if (nread == 0)
      break;
    nleft -= nread;
    bufp += nread;
  }
  return (n - nleft);
}


// 11

int open_clientfd(char *hostname, char *port) {
  int clientfd;
  struct addrinfo hints, *listp, *p;

  // get a list of potential server addresses
  memset(&hints, 0, sizeof(struct addrinfo));
  hints.ai_socktype = SOCK_STREAM; // open a connection
  hints.ai_flags = AI_NUMERICSERV; // using a numeric port arg
  hints.ai_flags |= AI_ADDRCONFIG; // recommender for connections
  getaddrinfo(hostname, port, &hints, &listp);

  // walk the list for one that we can successfully connect to
  for (p = listp; p; p = p->ai_next) {
    // create a socket descriptor
    if ((clientfd = socket(p->ai_family, p->ai_socktype, p->ai_protocol)) < 0)
      continue; // socket failed, try the next

    // connect to the server
    if (connect(clientfd, p->ai_addr, p->ai_addrlen) != -1)
      break; // success

    close(clientfd); // connect failed, try another
  }

  // clean up
  freeaddrinfo(listp);
  if (!p) // all connects failed
    return -1;
  else // the last connect succeeded
    return clientfd;
}

int open_listenfd(char *port) {
  struct addrinfo hints, *listp, *p;
  int listenfd, optval = 1;

  // get a list of potential server addresses
  memset(&hints, 0, sizeof(struct addrinfo));
  hints.ai_socktype = SOCK_STREAM; // accept connection
  hints.ai_flags = AI_PASSIVE | AI_ADDRCONFIG; // on any IP address
  hints.ai_flags |= AI_NUMERICSERV; // using port number
  getaddrinfo(NULL, port, &hints, &listp);

  // walk the list for one that we can bind to
  for (p = listp ; p; p = p->ai_next) {
    // create a socket descriptor
    if ((listenfd = socket(p->ai_family, p->ai_socktype, p->ai_protocol)) < 0)
      continue; // socket failed, try the next

    // eliminates "address already in use" error from bind
    setsockopt(listenfd, SOL_SOCKET, SO_REUSEADDR, (const void *)&optval, sizeof(int));

    // bind the descriptor to the address
    if (bind(listenfd, p->ai_addr, p->ai_addrlen) == 0)
      break; // success

    close(listenfd); // bind failed, try the next
  }

  // clean up
  freeaddrinfo(listp);
  if (!p) // no address worked
    return -1;

  // make it a listening socket ready to accept connection requests
  if (listen(listenfd, LISTENQ) < 0) {
    close(listenfd);
    return -1;
  }
  return listenfd;
}


void echo(int connfd) {
  size_t n;
  char buf[MAXLINE];
  rio_t rio;

  rio_readinitb(&rio, connfd);
  while((n = rio_readlineb(&rio, buf, MAXLINE)) != 0) {
    printf("server received %d bytes\n", (int)n);
    rio_writen(connfd, buf, n);
  }
}

```

----------

`/deep/11/echo.c`

``` c
#include "csapp.h"

void echo(int connfd) {
  size_t n;
  char buf[MAXLINE];
  rio_t rio;

  rio_readinitb(&rio, connfd);
  while((n = rio_readlineb(&rio, buf, MAXLINE)) != 0) {
    printf("server received %d bytes\n", (int)n);
    rio_writen(connfd, buf, n);
  }
}

```

----------

`/deep/11/echoclient.c`

``` c
#include "csapp.h"

int main(int argc, char **argv) {
  int clientfd;
  char *host, *port, buf[MAXLINE];
  rio_t rio;

  if (argc != 3) {
    fprintf(stderr, "usage: %s <host> <port>\n", argv[0]);
    exit(0);
  }
  host = argv[1];
  port = argv[2];

  clientfd = open_clientfd(host, port);
  rio_readinitb(&rio, clientfd);

  while (fgets(buf, MAXLINE, stdin) != NULL) {
    rio_writen(clientfd, buf, strlen(buf));
    rio_readlineb(&rio, buf, MAXLINE);
    fputs(buf, stdout);
  }
  close(clientfd);
  exit(0);
}

```

----------

`/deep/11/echoserveri.c`

``` c
#include "csapp.h"

void echo(int connfd);

int main(int argc, char **argv) {
  int listenfd, connfd;
  socklen_t clientlen;
  struct sockaddr_storage clientaddr; // enough space for any address
  char client_hostname[MAXLINE], client_port[MAXLINE];

  if (argc != 2) {
    fprintf(stderr, "usage: %s <port>\n", argv[0]);
    exit(0);
  }

  listenfd = open_listenfd(argv[1]);
  while (1) {
    clientlen = sizeof(struct sockaddr_storage);
    connfd = accept(listenfd, (struct sockaddr *) (&clientaddr), &clientlen);
    getnameinfo((struct sockaddr *) (&clientaddr), clientlen, client_hostname, MAXLINE, client_port, MAXLINE, 0);
    printf("Connected to (%s %s)\n", client_hostname, client_port);
    echo(connfd);
    close(connfd);
  }
  exit(0);
}

```

----------

`/deep/11/hostinfo.c`

``` c
#include "csapp.h"

int main(int argc, char **argv) {
  struct addrinfo *p, *listp, hints;
  char buf[MAXLINE];
  int rc, flags;

  if (argc != 2) {
    fprintf(stderr, "usage: %s <domain name>\n", argv[0]);
    exit(0);
  }

  // get a list of addrinfo records
  memset(&hints, 0, sizeof(struct addrinfo));
  hints.ai_family = AF_INET; // IPv4 only
  hints.ai_socktype = SOCK_STREAM; // Connections only
  if ((rc = getaddrinfo(argv[1], NULL, &hints, &listp)) != 0) {
    fprintf(stderr, "getaddrinfo error: %s\n", gai_strerror(rc));
    exit(1);
  }

  // Walk the list and display each IP address
  flags = NI_NUMERICHOST; // Display address string instead of domain name
  for (p = listp; p; p = p->ai_next) {
    getnameinfo(p->ai_addr, p->ai_addrlen, buf, MAXLINE, NULL, 0, flags);
    printf("%s\n", buf);
  }

  // Clean up
  freeaddrinfo(listp);

  exit(0);
}

```

----------

`/deep/11/readme.md`

IP 地址

```c
// IP address structure
struct in_addr {
  uint32_t s_addr; // Address in netword byte order (big-endian)
};
```

Unix 提供了下面这样的函数在网络和主机字节顺序间实现转换。

```c
#include <arpa/inet.h>

uint32_t htonl(uint32_t hostlong);
uint16_t htons(uint16_t hostshort);
// 返回：按照网络字节顺序的值

uint32_t ntohl(uint32_t netlong);
uint16_t ntohs(uint16_t netshort);
// 返回：按照主机字节顺序的值
```

套接字地址结构

```c
// IP socket address structure
struct sockaddr_in {
  uint16_t sin_family;
  uint16_t sin_port;
  struct in_addr sin_addr;
  unsigned char sin_zero[8];
};

// Generic socket address structure
struct sockaddr {
  uint16_t sa_family;
  char sa_data[14];
};
```

socket 函数

客户端和服务器使用 socket 函数来创建一个套接字描述符。

```c
#include <sys/types.h>
#include <sys/socket.h>

int socket(int domain, int type, int protocol);
// 返回：若成功则为非负描述符，若出错则为 -1
```

connect 函数

客户端通过调用 connect 函数来建立和服务器的连接。

```c
#include <sys/socket.h>

int connect(int clientfd, const struct sockaddr *addr, socklen_t addrlen);
// 返回：若成功则为 0，若出错则为 -1
```
connect 函数会阻塞

服务器：bind、listen 和 accept

```c
#include <sys/socket.h>

int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
// 返回：若成功则为 0，若出错则为 -1
```

```c
#include <sys/socket.h>

int listen(int sockfd, int backlog);
// 返回：若成功则为 0，若出错则为 -1
```

```c
#include <sys/socket.h>

int accept(int listenfd, struct sockaddr *addr, int *addrlen);
// 返回：若成功则为非负连接描述符，若出错则为 -1
```

getaddrinfo 函数

将主机名、主机地址、服务名和端口号的字符串表示转化成套接字地址结构。

```c
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>

int getaddrinfo(const char *host, const char *service, const struct addrinfo *hints, struct addrinfo **result);
// 返回：如果成功则为 0，如果错误则为非零的错误代码

void freeaddrinfo(struct addrinfo *result);
// 返回： 无

const char *gai_strerror(int errcode);
// 返回：错误消息
```

addrinfo 结构

```c
struct addrinfo {
  int ai_flags;
  int ai_family;
  int ai_socktype;
  int ai_protocol;
  char *ai_canonname;
  size_t ai_addrlen;
  struct sockaddr *ai_addr;
  struct addrinfo *ai_next;
};
```

getnameinfo 与 getaddrinfo 相反

```c
#include <sys/socket.h>
#include <netdb.h>

int getnameinfo(const struct sockaddr *sa, socklen_t salen, char *host, size_t hostlen, char * service, size_t servlen, int flags);
// 返回：如果成功则为 0，如果错误则为非零的错误代码
```

套接字接口辅助函数

```c
int open_clientfd(char *hostname, char *port);
int open_listenfd(char *port);
// 返回：若成功则为描述符，若出错则为 -1
```


----------

`/deep/7-link/main.c`

``` c
int sum(int *a, int n);

int array[2] = {1, 2};

int main()
{
  int val = sum(array, 2);
  return val;
}

```

----------

`/deep/7-link/readme.md`

gcc -Og -o prog main.c sum.c


----------

`/deep/7-link/sum.c`

``` c
int sum(int *a, int n)
{
  int i, s = 0;

  for (i = 0; i < n; i++) {
    s += a[i];
  }

  return s;
}

```

----------

`/deep/8/csapp.h`

``` c
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>

// Unix-style error
void unix_error(char *msg) {
  fprintf(stderr, "%s: %s\n", msg, strerror(errno));
  exit(0);
}

pid_t Fork(void) {
  pid_t pid;
  if ((pid = fork()) < 0)
    unix_error("Fork error");
  return pid;
}

```

----------

`/deep/8/fork.c`

``` c
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>

int main()
{
  pid_t pid;
  int x = 1;

  pid = fork();
  // 子进程
  if (pid == 0) {
    printf("child : x=%d\n", ++x);
    exit(0);
  }

  // 父进程
  printf("parent: x=%d\n", --x);
  exit(0);
}

```

----------

`/deep/8/get_pid.c`

``` c
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

int main() {
  // 当前进程
  pid_t p = getpid();
  printf("pid: %d\n", p);

  // 父进程
  p = getppid();
  printf("ppid: %d\n", p);

  // 进程组
  p = getpgrp();
  printf("pgrp: %d\n", p);

  return 0;
}

```

----------

`/deep/8/hello.c`

``` c
int main()
{
  write(1, "hello, world\n", 13);
  _exit(0);
}

```

----------

`/deep/8/kill.c`

``` c
#include "csapp.h"

int main() {
  pid_t pid;

  // Child sleeps until SIGKILL signal received, then dies
  if ((pid = Fork()) == 0) {
    // Wait for a signal to arrive
    pause();
    printf("control should never reach here!\n");
    exit(0);
  }

  // Parent sends a SIGKILL signal to a child
  kill(pid, SIGKILL);
  exit(0);
}

```

----------

`/deep/8/sigint.c`

``` c
#include "csapp.h"

// 捕获键盘 Ctrl+C 发送的 SIGINT 信号

// SIGINT handler
void sigint_handler(int sig) {
  printf("Caught SIGINT!\n");
  exit(0);
}

int main() {
  // Install the SIGINT handler
  if (signal(SIGINT, sigint_handler) == SIG_ERR)
    unix_error("signal error");

  // Wait for the receipt of a signal
  pause();

  return 0;
}

```

----------

`/deep/8/waitpid1.c`

``` c
#include "csapp.h"
#define N 10

int main()
{
  int status, i;
  pid_t pid;

  // 创建 N 个子进程
  for (i = 0; i < N; i++) {
    if ((pid = Fork()) == 0) {
      // 子进程退出
      exit(100+i);
    }
  }

  // 回收子进程，顺序不固定
  while ((pid = waitpid(-1, &status, 0)) > 0) {
    if (WIFEXITED(status)) {
      printf("child %d terminated normally with exit status=%d\n", pid, WEXITSTATUS(status));
    } else {
      printf("child %d terminated abnormally\n", pid);
    }
  }

  // 最后一次调用 waitpid 返回 -1，并设置 errno 为 ECHILD
  if (errno != ECHILD) {
    unix_error("waitpid error");
  }

  exit(0);
}

```

----------

`/deep/8/waitpid2.c`

``` c
#include "csapp.h"
#define N 10

int main()
{
  int status, i;
  pid_t pid[N], retpid;

  // 创建 N 个子进程
  for (i = 0; i < N; i++) {
    if ((pid[i] = Fork()) == 0) {
      // 子进程退出
      exit(100+i);
    }
  }

  // 回收子进程，顺序固定
  i = 0;
  while ((retpid = waitpid(pid[i++], &status, 0)) > 0) {
    if (WIFEXITED(status)) {
      printf("child %d terminated normally with exit status=%d\n", retpid, WEXITSTATUS(status));
    } else {
      printf("child %d terminated abnormally\n", retpid);
    }
  }

  // 最后一次调用 waitpid 返回 -1，并设置 errno 为 ECHILD
  if (errno != ECHILD) {
    unix_error("waitpid error");
  }

  exit(0);
}

```

----------

`/note.md`

# C程序设计语言

## 1 - 导言

编译：cc hello.c

执行：./a.out

`include <stdio.h>` 包含标准库的信息，告诉编译器在本程序中包含标准输入/输出库的信息。

程序的起点为 main 函数

main 函数不接收参数值

用双引号括起来的字符序列称为**字符串**或**字符常量**。

printf 函数不是C语言本身的一部分，仅是标准库函数中的一个函数。

- %3.0f 至少占3字符宽，不带小数点和小数部分
- %6.1f 至少占6字符宽，小数点后面有1位数字

- %d 十进制
- %f 浮点数
- %o 八进制
- %x 十六进制
- %c 字符
- %s 字符串
- %% %

`#define` 指令可以把符号名（符号变量）定义为一个特定的字符串：`#define 名字 替换文本`，指令末尾无分号。

getchar() 和 putchar()

- getchar 从文本流中读入下一个输入字符，作为结果返回
- putchar 将打印一个字符

EOF end of file 定义在头文件`<stdio.h>` 中，是一个**整型数**。与任何 char 类型的值都不相同。


----------

`/tmp/main.c`

``` c
#include <stdio.h>

void multstore(long, long, long *);

int main() {
  long d;
  multstore(2, 3, &d);
  printf("2 * 3 --> %ld\n", d);
  return 0;
}

long mult2(long a, long b) {
  long s = a * b;
  return s;
}

```

----------

`/tmp/mstore.c`

``` c
long mult2(long, long);

void multstore(long x, long y, long *dest) {
  long t = mult2(x, y);
  *dest = t;
}

```

----------

`/tmp/show_bytes.c`

``` c
#include <stdio.h>

// 使用强制类型转换来访问和打印不同程序对象的字节表示

typedef unsigned char *byte_pointer;

void show_bytes(byte_pointer start, size_t len) {
  // 因为 char 类型的指针每次是按照字节加 1
  // 所以可以打印出存储在相应地址的字节

  // pa[i] 与 *(pa+i) 是等价的
  // 一个通过数组和下标实现的表达式可等价地通过指针和偏移量实现
  for (size_t i = 0; i < len; i++) {
    // 数组形式
    // start[i] 表示读取以 start 指向的位置为起始的第 i 个位置处的字节
    printf(" %.2x", start[i]);

    // 指针形式
    // printf(" %.2x", *start++);
  }
  printf("\n");
}

void show_int(int x) {
  // 强制类型转换
  // 并不会改变真实的指针，而是告诉编译器以新的数据类型来看待被指向的数据
  show_bytes((byte_pointer) &x, sizeof(int));
}

void show_float(float x) {
  show_bytes((byte_pointer) &x, sizeof(float));
}

// 指向任何对象的指针都可以转换为 void * 类型，且不会丢失信息
// 如果将结果再转换为初始指针类型，则可以恢复初始指针
// ANSI C 使用类型 void * 代替 char * 作为通用指针的类型
void show_pointer(void *x) {
  show_bytes((byte_pointer) &x, sizeof(void *));
}

void test_show_bytes(int val) {
  int ival = val;
  // 39 30 00 00 => 小端法
  show_int(ival);
  show_float((float)ival);
  show_pointer(&ival);
}

int main() {
  // 0x00003039
  int val = 12345;
  test_show_bytes(val);
  show_bytes((byte_pointer) &"12345", 6);
  return 0;
}

```
