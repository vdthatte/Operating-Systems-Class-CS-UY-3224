
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	89 cb                	mov    %ecx,%ebx
  if(argc != 3){
  11:	83 3b 03             	cmpl   $0x3,(%ebx)
  14:	74 17                	je     2d <main+0x2d>
    printf(2, "Usage: ln old new\n");
  16:	83 ec 08             	sub    $0x8,%esp
  19:	68 d0 07 00 00       	push   $0x7d0
  1e:	6a 02                	push   $0x2
  20:	e8 ff 03 00 00       	call   424 <printf>
  25:	83 c4 10             	add    $0x10,%esp
    exit();
  28:	e8 85 02 00 00       	call   2b2 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  2d:	8b 43 04             	mov    0x4(%ebx),%eax
  30:	83 c0 08             	add    $0x8,%eax
  33:	8b 10                	mov    (%eax),%edx
  35:	8b 43 04             	mov    0x4(%ebx),%eax
  38:	83 c0 04             	add    $0x4,%eax
  3b:	8b 00                	mov    (%eax),%eax
  3d:	83 ec 08             	sub    $0x8,%esp
  40:	52                   	push   %edx
  41:	50                   	push   %eax
  42:	e8 cb 02 00 00       	call   312 <link>
  47:	83 c4 10             	add    $0x10,%esp
  4a:	85 c0                	test   %eax,%eax
  4c:	79 21                	jns    6f <main+0x6f>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  4e:	8b 43 04             	mov    0x4(%ebx),%eax
  51:	83 c0 08             	add    $0x8,%eax
  54:	8b 10                	mov    (%eax),%edx
  56:	8b 43 04             	mov    0x4(%ebx),%eax
  59:	83 c0 04             	add    $0x4,%eax
  5c:	8b 00                	mov    (%eax),%eax
  5e:	52                   	push   %edx
  5f:	50                   	push   %eax
  60:	68 e3 07 00 00       	push   $0x7e3
  65:	6a 02                	push   $0x2
  67:	e8 b8 03 00 00       	call   424 <printf>
  6c:	83 c4 10             	add    $0x10,%esp
  exit();
  6f:	e8 3e 02 00 00       	call   2b2 <exit>

00000074 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  74:	55                   	push   %ebp
  75:	89 e5                	mov    %esp,%ebp
  77:	57                   	push   %edi
  78:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  79:	8b 4d 08             	mov    0x8(%ebp),%ecx
  7c:	8b 55 10             	mov    0x10(%ebp),%edx
  7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  82:	89 cb                	mov    %ecx,%ebx
  84:	89 df                	mov    %ebx,%edi
  86:	89 d1                	mov    %edx,%ecx
  88:	fc                   	cld    
  89:	f3 aa                	rep stos %al,%es:(%edi)
  8b:	89 ca                	mov    %ecx,%edx
  8d:	89 fb                	mov    %edi,%ebx
  8f:	89 5d 08             	mov    %ebx,0x8(%ebp)
  92:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  95:	5b                   	pop    %ebx
  96:	5f                   	pop    %edi
  97:	5d                   	pop    %ebp
  98:	c3                   	ret    

00000099 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  99:	55                   	push   %ebp
  9a:	89 e5                	mov    %esp,%ebp
  9c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  9f:	8b 45 08             	mov    0x8(%ebp),%eax
  a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  a5:	90                   	nop
  a6:	8b 45 08             	mov    0x8(%ebp),%eax
  a9:	8d 50 01             	lea    0x1(%eax),%edx
  ac:	89 55 08             	mov    %edx,0x8(%ebp)
  af:	8b 55 0c             	mov    0xc(%ebp),%edx
  b2:	8d 4a 01             	lea    0x1(%edx),%ecx
  b5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  b8:	8a 12                	mov    (%edx),%dl
  ba:	88 10                	mov    %dl,(%eax)
  bc:	8a 00                	mov    (%eax),%al
  be:	84 c0                	test   %al,%al
  c0:	75 e4                	jne    a6 <strcpy+0xd>
    ;
  return os;
  c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  c5:	c9                   	leave  
  c6:	c3                   	ret    

000000c7 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c7:	55                   	push   %ebp
  c8:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  ca:	eb 06                	jmp    d2 <strcmp+0xb>
    p++, q++;
  cc:	ff 45 08             	incl   0x8(%ebp)
  cf:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  d2:	8b 45 08             	mov    0x8(%ebp),%eax
  d5:	8a 00                	mov    (%eax),%al
  d7:	84 c0                	test   %al,%al
  d9:	74 0e                	je     e9 <strcmp+0x22>
  db:	8b 45 08             	mov    0x8(%ebp),%eax
  de:	8a 10                	mov    (%eax),%dl
  e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  e3:	8a 00                	mov    (%eax),%al
  e5:	38 c2                	cmp    %al,%dl
  e7:	74 e3                	je     cc <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  e9:	8b 45 08             	mov    0x8(%ebp),%eax
  ec:	8a 00                	mov    (%eax),%al
  ee:	0f b6 d0             	movzbl %al,%edx
  f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  f4:	8a 00                	mov    (%eax),%al
  f6:	0f b6 c0             	movzbl %al,%eax
  f9:	29 c2                	sub    %eax,%edx
  fb:	89 d0                	mov    %edx,%eax
}
  fd:	5d                   	pop    %ebp
  fe:	c3                   	ret    

000000ff <strlen>:

uint
strlen(char *s)
{
  ff:	55                   	push   %ebp
 100:	89 e5                	mov    %esp,%ebp
 102:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 105:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 10c:	eb 03                	jmp    111 <strlen+0x12>
 10e:	ff 45 fc             	incl   -0x4(%ebp)
 111:	8b 55 fc             	mov    -0x4(%ebp),%edx
 114:	8b 45 08             	mov    0x8(%ebp),%eax
 117:	01 d0                	add    %edx,%eax
 119:	8a 00                	mov    (%eax),%al
 11b:	84 c0                	test   %al,%al
 11d:	75 ef                	jne    10e <strlen+0xf>
    ;
  return n;
 11f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 122:	c9                   	leave  
 123:	c3                   	ret    

00000124 <memset>:

void*
memset(void *dst, int c, uint n)
{
 124:	55                   	push   %ebp
 125:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 127:	8b 45 10             	mov    0x10(%ebp),%eax
 12a:	50                   	push   %eax
 12b:	ff 75 0c             	pushl  0xc(%ebp)
 12e:	ff 75 08             	pushl  0x8(%ebp)
 131:	e8 3e ff ff ff       	call   74 <stosb>
 136:	83 c4 0c             	add    $0xc,%esp
  return dst;
 139:	8b 45 08             	mov    0x8(%ebp),%eax
}
 13c:	c9                   	leave  
 13d:	c3                   	ret    

0000013e <strchr>:

char*
strchr(const char *s, char c)
{
 13e:	55                   	push   %ebp
 13f:	89 e5                	mov    %esp,%ebp
 141:	83 ec 04             	sub    $0x4,%esp
 144:	8b 45 0c             	mov    0xc(%ebp),%eax
 147:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 14a:	eb 12                	jmp    15e <strchr+0x20>
    if(*s == c)
 14c:	8b 45 08             	mov    0x8(%ebp),%eax
 14f:	8a 00                	mov    (%eax),%al
 151:	3a 45 fc             	cmp    -0x4(%ebp),%al
 154:	75 05                	jne    15b <strchr+0x1d>
      return (char*)s;
 156:	8b 45 08             	mov    0x8(%ebp),%eax
 159:	eb 11                	jmp    16c <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 15b:	ff 45 08             	incl   0x8(%ebp)
 15e:	8b 45 08             	mov    0x8(%ebp),%eax
 161:	8a 00                	mov    (%eax),%al
 163:	84 c0                	test   %al,%al
 165:	75 e5                	jne    14c <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 167:	b8 00 00 00 00       	mov    $0x0,%eax
}
 16c:	c9                   	leave  
 16d:	c3                   	ret    

0000016e <gets>:

char*
gets(char *buf, int max)
{
 16e:	55                   	push   %ebp
 16f:	89 e5                	mov    %esp,%ebp
 171:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 174:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 17b:	eb 41                	jmp    1be <gets+0x50>
    cc = read(0, &c, 1);
 17d:	83 ec 04             	sub    $0x4,%esp
 180:	6a 01                	push   $0x1
 182:	8d 45 ef             	lea    -0x11(%ebp),%eax
 185:	50                   	push   %eax
 186:	6a 00                	push   $0x0
 188:	e8 3d 01 00 00       	call   2ca <read>
 18d:	83 c4 10             	add    $0x10,%esp
 190:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 193:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 197:	7f 02                	jg     19b <gets+0x2d>
      break;
 199:	eb 2c                	jmp    1c7 <gets+0x59>
    buf[i++] = c;
 19b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 19e:	8d 50 01             	lea    0x1(%eax),%edx
 1a1:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1a4:	89 c2                	mov    %eax,%edx
 1a6:	8b 45 08             	mov    0x8(%ebp),%eax
 1a9:	01 c2                	add    %eax,%edx
 1ab:	8a 45 ef             	mov    -0x11(%ebp),%al
 1ae:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1b0:	8a 45 ef             	mov    -0x11(%ebp),%al
 1b3:	3c 0a                	cmp    $0xa,%al
 1b5:	74 10                	je     1c7 <gets+0x59>
 1b7:	8a 45 ef             	mov    -0x11(%ebp),%al
 1ba:	3c 0d                	cmp    $0xd,%al
 1bc:	74 09                	je     1c7 <gets+0x59>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1be:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c1:	40                   	inc    %eax
 1c2:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1c5:	7c b6                	jl     17d <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1ca:	8b 45 08             	mov    0x8(%ebp),%eax
 1cd:	01 d0                	add    %edx,%eax
 1cf:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1d2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1d5:	c9                   	leave  
 1d6:	c3                   	ret    

000001d7 <stat>:

int
stat(char *n, struct stat *st)
{
 1d7:	55                   	push   %ebp
 1d8:	89 e5                	mov    %esp,%ebp
 1da:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1dd:	83 ec 08             	sub    $0x8,%esp
 1e0:	6a 00                	push   $0x0
 1e2:	ff 75 08             	pushl  0x8(%ebp)
 1e5:	e8 08 01 00 00       	call   2f2 <open>
 1ea:	83 c4 10             	add    $0x10,%esp
 1ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1f0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1f4:	79 07                	jns    1fd <stat+0x26>
    return -1;
 1f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1fb:	eb 25                	jmp    222 <stat+0x4b>
  r = fstat(fd, st);
 1fd:	83 ec 08             	sub    $0x8,%esp
 200:	ff 75 0c             	pushl  0xc(%ebp)
 203:	ff 75 f4             	pushl  -0xc(%ebp)
 206:	e8 ff 00 00 00       	call   30a <fstat>
 20b:	83 c4 10             	add    $0x10,%esp
 20e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 211:	83 ec 0c             	sub    $0xc,%esp
 214:	ff 75 f4             	pushl  -0xc(%ebp)
 217:	e8 be 00 00 00       	call   2da <close>
 21c:	83 c4 10             	add    $0x10,%esp
  return r;
 21f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 222:	c9                   	leave  
 223:	c3                   	ret    

00000224 <atoi>:

int
atoi(const char *s)
{
 224:	55                   	push   %ebp
 225:	89 e5                	mov    %esp,%ebp
 227:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 22a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 231:	eb 24                	jmp    257 <atoi+0x33>
    n = n*10 + *s++ - '0';
 233:	8b 55 fc             	mov    -0x4(%ebp),%edx
 236:	89 d0                	mov    %edx,%eax
 238:	c1 e0 02             	shl    $0x2,%eax
 23b:	01 d0                	add    %edx,%eax
 23d:	01 c0                	add    %eax,%eax
 23f:	89 c1                	mov    %eax,%ecx
 241:	8b 45 08             	mov    0x8(%ebp),%eax
 244:	8d 50 01             	lea    0x1(%eax),%edx
 247:	89 55 08             	mov    %edx,0x8(%ebp)
 24a:	8a 00                	mov    (%eax),%al
 24c:	0f be c0             	movsbl %al,%eax
 24f:	01 c8                	add    %ecx,%eax
 251:	83 e8 30             	sub    $0x30,%eax
 254:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 257:	8b 45 08             	mov    0x8(%ebp),%eax
 25a:	8a 00                	mov    (%eax),%al
 25c:	3c 2f                	cmp    $0x2f,%al
 25e:	7e 09                	jle    269 <atoi+0x45>
 260:	8b 45 08             	mov    0x8(%ebp),%eax
 263:	8a 00                	mov    (%eax),%al
 265:	3c 39                	cmp    $0x39,%al
 267:	7e ca                	jle    233 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 269:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 26c:	c9                   	leave  
 26d:	c3                   	ret    

0000026e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 26e:	55                   	push   %ebp
 26f:	89 e5                	mov    %esp,%ebp
 271:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 274:	8b 45 08             	mov    0x8(%ebp),%eax
 277:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 27a:	8b 45 0c             	mov    0xc(%ebp),%eax
 27d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 280:	eb 16                	jmp    298 <memmove+0x2a>
    *dst++ = *src++;
 282:	8b 45 fc             	mov    -0x4(%ebp),%eax
 285:	8d 50 01             	lea    0x1(%eax),%edx
 288:	89 55 fc             	mov    %edx,-0x4(%ebp)
 28b:	8b 55 f8             	mov    -0x8(%ebp),%edx
 28e:	8d 4a 01             	lea    0x1(%edx),%ecx
 291:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 294:	8a 12                	mov    (%edx),%dl
 296:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 298:	8b 45 10             	mov    0x10(%ebp),%eax
 29b:	8d 50 ff             	lea    -0x1(%eax),%edx
 29e:	89 55 10             	mov    %edx,0x10(%ebp)
 2a1:	85 c0                	test   %eax,%eax
 2a3:	7f dd                	jg     282 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2a5:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2a8:	c9                   	leave  
 2a9:	c3                   	ret    

000002aa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2aa:	b8 01 00 00 00       	mov    $0x1,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <exit>:
SYSCALL(exit)
 2b2:	b8 02 00 00 00       	mov    $0x2,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <wait>:
SYSCALL(wait)
 2ba:	b8 03 00 00 00       	mov    $0x3,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <pipe>:
SYSCALL(pipe)
 2c2:	b8 04 00 00 00       	mov    $0x4,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <read>:
SYSCALL(read)
 2ca:	b8 05 00 00 00       	mov    $0x5,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <write>:
SYSCALL(write)
 2d2:	b8 10 00 00 00       	mov    $0x10,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <close>:
SYSCALL(close)
 2da:	b8 15 00 00 00       	mov    $0x15,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <kill>:
SYSCALL(kill)
 2e2:	b8 06 00 00 00       	mov    $0x6,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <exec>:
SYSCALL(exec)
 2ea:	b8 07 00 00 00       	mov    $0x7,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <open>:
SYSCALL(open)
 2f2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <mknod>:
SYSCALL(mknod)
 2fa:	b8 11 00 00 00       	mov    $0x11,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <unlink>:
SYSCALL(unlink)
 302:	b8 12 00 00 00       	mov    $0x12,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <fstat>:
SYSCALL(fstat)
 30a:	b8 08 00 00 00       	mov    $0x8,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <link>:
SYSCALL(link)
 312:	b8 13 00 00 00       	mov    $0x13,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <mkdir>:
SYSCALL(mkdir)
 31a:	b8 14 00 00 00       	mov    $0x14,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <chdir>:
SYSCALL(chdir)
 322:	b8 09 00 00 00       	mov    $0x9,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <dup>:
SYSCALL(dup)
 32a:	b8 0a 00 00 00       	mov    $0xa,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <getpid>:
SYSCALL(getpid)
 332:	b8 0b 00 00 00       	mov    $0xb,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <sbrk>:
SYSCALL(sbrk)
 33a:	b8 0c 00 00 00       	mov    $0xc,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <sleep>:
SYSCALL(sleep)
 342:	b8 0d 00 00 00       	mov    $0xd,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <uptime>:
SYSCALL(uptime)
 34a:	b8 0e 00 00 00       	mov    $0xe,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 352:	55                   	push   %ebp
 353:	89 e5                	mov    %esp,%ebp
 355:	83 ec 18             	sub    $0x18,%esp
 358:	8b 45 0c             	mov    0xc(%ebp),%eax
 35b:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 35e:	83 ec 04             	sub    $0x4,%esp
 361:	6a 01                	push   $0x1
 363:	8d 45 f4             	lea    -0xc(%ebp),%eax
 366:	50                   	push   %eax
 367:	ff 75 08             	pushl  0x8(%ebp)
 36a:	e8 63 ff ff ff       	call   2d2 <write>
 36f:	83 c4 10             	add    $0x10,%esp
}
 372:	c9                   	leave  
 373:	c3                   	ret    

00000374 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 374:	55                   	push   %ebp
 375:	89 e5                	mov    %esp,%ebp
 377:	53                   	push   %ebx
 378:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 37b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 382:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 386:	74 17                	je     39f <printint+0x2b>
 388:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 38c:	79 11                	jns    39f <printint+0x2b>
    neg = 1;
 38e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 395:	8b 45 0c             	mov    0xc(%ebp),%eax
 398:	f7 d8                	neg    %eax
 39a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 39d:	eb 06                	jmp    3a5 <printint+0x31>
  } else {
    x = xx;
 39f:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3a5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3ac:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3af:	8d 41 01             	lea    0x1(%ecx),%eax
 3b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3b5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3bb:	ba 00 00 00 00       	mov    $0x0,%edx
 3c0:	f7 f3                	div    %ebx
 3c2:	89 d0                	mov    %edx,%eax
 3c4:	8a 80 4c 0a 00 00    	mov    0xa4c(%eax),%al
 3ca:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3ce:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3d4:	ba 00 00 00 00       	mov    $0x0,%edx
 3d9:	f7 f3                	div    %ebx
 3db:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3de:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3e2:	75 c8                	jne    3ac <printint+0x38>
  if(neg)
 3e4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3e8:	74 0e                	je     3f8 <printint+0x84>
    buf[i++] = '-';
 3ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3ed:	8d 50 01             	lea    0x1(%eax),%edx
 3f0:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3f3:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3f8:	eb 1c                	jmp    416 <printint+0xa2>
    putc(fd, buf[i]);
 3fa:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 400:	01 d0                	add    %edx,%eax
 402:	8a 00                	mov    (%eax),%al
 404:	0f be c0             	movsbl %al,%eax
 407:	83 ec 08             	sub    $0x8,%esp
 40a:	50                   	push   %eax
 40b:	ff 75 08             	pushl  0x8(%ebp)
 40e:	e8 3f ff ff ff       	call   352 <putc>
 413:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 416:	ff 4d f4             	decl   -0xc(%ebp)
 419:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 41d:	79 db                	jns    3fa <printint+0x86>
    putc(fd, buf[i]);
}
 41f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 422:	c9                   	leave  
 423:	c3                   	ret    

00000424 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 424:	55                   	push   %ebp
 425:	89 e5                	mov    %esp,%ebp
 427:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 42a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 431:	8d 45 0c             	lea    0xc(%ebp),%eax
 434:	83 c0 04             	add    $0x4,%eax
 437:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 43a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 441:	e9 54 01 00 00       	jmp    59a <printf+0x176>
    c = fmt[i] & 0xff;
 446:	8b 55 0c             	mov    0xc(%ebp),%edx
 449:	8b 45 f0             	mov    -0x10(%ebp),%eax
 44c:	01 d0                	add    %edx,%eax
 44e:	8a 00                	mov    (%eax),%al
 450:	0f be c0             	movsbl %al,%eax
 453:	25 ff 00 00 00       	and    $0xff,%eax
 458:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 45b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 45f:	75 2c                	jne    48d <printf+0x69>
      if(c == '%'){
 461:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 465:	75 0c                	jne    473 <printf+0x4f>
        state = '%';
 467:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 46e:	e9 24 01 00 00       	jmp    597 <printf+0x173>
      } else {
        putc(fd, c);
 473:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 476:	0f be c0             	movsbl %al,%eax
 479:	83 ec 08             	sub    $0x8,%esp
 47c:	50                   	push   %eax
 47d:	ff 75 08             	pushl  0x8(%ebp)
 480:	e8 cd fe ff ff       	call   352 <putc>
 485:	83 c4 10             	add    $0x10,%esp
 488:	e9 0a 01 00 00       	jmp    597 <printf+0x173>
      }
    } else if(state == '%'){
 48d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 491:	0f 85 00 01 00 00    	jne    597 <printf+0x173>
      if(c == 'd'){
 497:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 49b:	75 1e                	jne    4bb <printf+0x97>
        printint(fd, *ap, 10, 1);
 49d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4a0:	8b 00                	mov    (%eax),%eax
 4a2:	6a 01                	push   $0x1
 4a4:	6a 0a                	push   $0xa
 4a6:	50                   	push   %eax
 4a7:	ff 75 08             	pushl  0x8(%ebp)
 4aa:	e8 c5 fe ff ff       	call   374 <printint>
 4af:	83 c4 10             	add    $0x10,%esp
        ap++;
 4b2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4b6:	e9 d5 00 00 00       	jmp    590 <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
 4bb:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4bf:	74 06                	je     4c7 <printf+0xa3>
 4c1:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4c5:	75 1e                	jne    4e5 <printf+0xc1>
        printint(fd, *ap, 16, 0);
 4c7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ca:	8b 00                	mov    (%eax),%eax
 4cc:	6a 00                	push   $0x0
 4ce:	6a 10                	push   $0x10
 4d0:	50                   	push   %eax
 4d1:	ff 75 08             	pushl  0x8(%ebp)
 4d4:	e8 9b fe ff ff       	call   374 <printint>
 4d9:	83 c4 10             	add    $0x10,%esp
        ap++;
 4dc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4e0:	e9 ab 00 00 00       	jmp    590 <printf+0x16c>
      } else if(c == 's'){
 4e5:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4e9:	75 40                	jne    52b <printf+0x107>
        s = (char*)*ap;
 4eb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ee:	8b 00                	mov    (%eax),%eax
 4f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4f3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4f7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4fb:	75 07                	jne    504 <printf+0xe0>
          s = "(null)";
 4fd:	c7 45 f4 f7 07 00 00 	movl   $0x7f7,-0xc(%ebp)
        while(*s != 0){
 504:	eb 1a                	jmp    520 <printf+0xfc>
          putc(fd, *s);
 506:	8b 45 f4             	mov    -0xc(%ebp),%eax
 509:	8a 00                	mov    (%eax),%al
 50b:	0f be c0             	movsbl %al,%eax
 50e:	83 ec 08             	sub    $0x8,%esp
 511:	50                   	push   %eax
 512:	ff 75 08             	pushl  0x8(%ebp)
 515:	e8 38 fe ff ff       	call   352 <putc>
 51a:	83 c4 10             	add    $0x10,%esp
          s++;
 51d:	ff 45 f4             	incl   -0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 520:	8b 45 f4             	mov    -0xc(%ebp),%eax
 523:	8a 00                	mov    (%eax),%al
 525:	84 c0                	test   %al,%al
 527:	75 dd                	jne    506 <printf+0xe2>
 529:	eb 65                	jmp    590 <printf+0x16c>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 52b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 52f:	75 1d                	jne    54e <printf+0x12a>
        putc(fd, *ap);
 531:	8b 45 e8             	mov    -0x18(%ebp),%eax
 534:	8b 00                	mov    (%eax),%eax
 536:	0f be c0             	movsbl %al,%eax
 539:	83 ec 08             	sub    $0x8,%esp
 53c:	50                   	push   %eax
 53d:	ff 75 08             	pushl  0x8(%ebp)
 540:	e8 0d fe ff ff       	call   352 <putc>
 545:	83 c4 10             	add    $0x10,%esp
        ap++;
 548:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 54c:	eb 42                	jmp    590 <printf+0x16c>
      } else if(c == '%'){
 54e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 552:	75 17                	jne    56b <printf+0x147>
        putc(fd, c);
 554:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 557:	0f be c0             	movsbl %al,%eax
 55a:	83 ec 08             	sub    $0x8,%esp
 55d:	50                   	push   %eax
 55e:	ff 75 08             	pushl  0x8(%ebp)
 561:	e8 ec fd ff ff       	call   352 <putc>
 566:	83 c4 10             	add    $0x10,%esp
 569:	eb 25                	jmp    590 <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 56b:	83 ec 08             	sub    $0x8,%esp
 56e:	6a 25                	push   $0x25
 570:	ff 75 08             	pushl  0x8(%ebp)
 573:	e8 da fd ff ff       	call   352 <putc>
 578:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 57b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 57e:	0f be c0             	movsbl %al,%eax
 581:	83 ec 08             	sub    $0x8,%esp
 584:	50                   	push   %eax
 585:	ff 75 08             	pushl  0x8(%ebp)
 588:	e8 c5 fd ff ff       	call   352 <putc>
 58d:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 590:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 597:	ff 45 f0             	incl   -0x10(%ebp)
 59a:	8b 55 0c             	mov    0xc(%ebp),%edx
 59d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5a0:	01 d0                	add    %edx,%eax
 5a2:	8a 00                	mov    (%eax),%al
 5a4:	84 c0                	test   %al,%al
 5a6:	0f 85 9a fe ff ff    	jne    446 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5ac:	c9                   	leave  
 5ad:	c3                   	ret    

000005ae <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5ae:	55                   	push   %ebp
 5af:	89 e5                	mov    %esp,%ebp
 5b1:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5b4:	8b 45 08             	mov    0x8(%ebp),%eax
 5b7:	83 e8 08             	sub    $0x8,%eax
 5ba:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5bd:	a1 68 0a 00 00       	mov    0xa68,%eax
 5c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5c5:	eb 24                	jmp    5eb <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5ca:	8b 00                	mov    (%eax),%eax
 5cc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5cf:	77 12                	ja     5e3 <free+0x35>
 5d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5d4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5d7:	77 24                	ja     5fd <free+0x4f>
 5d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5dc:	8b 00                	mov    (%eax),%eax
 5de:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5e1:	77 1a                	ja     5fd <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e6:	8b 00                	mov    (%eax),%eax
 5e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5ee:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5f1:	76 d4                	jbe    5c7 <free+0x19>
 5f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f6:	8b 00                	mov    (%eax),%eax
 5f8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5fb:	76 ca                	jbe    5c7 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 600:	8b 40 04             	mov    0x4(%eax),%eax
 603:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 60a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 60d:	01 c2                	add    %eax,%edx
 60f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 612:	8b 00                	mov    (%eax),%eax
 614:	39 c2                	cmp    %eax,%edx
 616:	75 24                	jne    63c <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 618:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61b:	8b 50 04             	mov    0x4(%eax),%edx
 61e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 621:	8b 00                	mov    (%eax),%eax
 623:	8b 40 04             	mov    0x4(%eax),%eax
 626:	01 c2                	add    %eax,%edx
 628:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62b:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 62e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 631:	8b 00                	mov    (%eax),%eax
 633:	8b 10                	mov    (%eax),%edx
 635:	8b 45 f8             	mov    -0x8(%ebp),%eax
 638:	89 10                	mov    %edx,(%eax)
 63a:	eb 0a                	jmp    646 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 63c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63f:	8b 10                	mov    (%eax),%edx
 641:	8b 45 f8             	mov    -0x8(%ebp),%eax
 644:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 646:	8b 45 fc             	mov    -0x4(%ebp),%eax
 649:	8b 40 04             	mov    0x4(%eax),%eax
 64c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 653:	8b 45 fc             	mov    -0x4(%ebp),%eax
 656:	01 d0                	add    %edx,%eax
 658:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 65b:	75 20                	jne    67d <free+0xcf>
    p->s.size += bp->s.size;
 65d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 660:	8b 50 04             	mov    0x4(%eax),%edx
 663:	8b 45 f8             	mov    -0x8(%ebp),%eax
 666:	8b 40 04             	mov    0x4(%eax),%eax
 669:	01 c2                	add    %eax,%edx
 66b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 671:	8b 45 f8             	mov    -0x8(%ebp),%eax
 674:	8b 10                	mov    (%eax),%edx
 676:	8b 45 fc             	mov    -0x4(%ebp),%eax
 679:	89 10                	mov    %edx,(%eax)
 67b:	eb 08                	jmp    685 <free+0xd7>
  } else
    p->s.ptr = bp;
 67d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 680:	8b 55 f8             	mov    -0x8(%ebp),%edx
 683:	89 10                	mov    %edx,(%eax)
  freep = p;
 685:	8b 45 fc             	mov    -0x4(%ebp),%eax
 688:	a3 68 0a 00 00       	mov    %eax,0xa68
}
 68d:	c9                   	leave  
 68e:	c3                   	ret    

0000068f <morecore>:

static Header*
morecore(uint nu)
{
 68f:	55                   	push   %ebp
 690:	89 e5                	mov    %esp,%ebp
 692:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 695:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 69c:	77 07                	ja     6a5 <morecore+0x16>
    nu = 4096;
 69e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6a5:	8b 45 08             	mov    0x8(%ebp),%eax
 6a8:	c1 e0 03             	shl    $0x3,%eax
 6ab:	83 ec 0c             	sub    $0xc,%esp
 6ae:	50                   	push   %eax
 6af:	e8 86 fc ff ff       	call   33a <sbrk>
 6b4:	83 c4 10             	add    $0x10,%esp
 6b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6ba:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6be:	75 07                	jne    6c7 <morecore+0x38>
    return 0;
 6c0:	b8 00 00 00 00       	mov    $0x0,%eax
 6c5:	eb 26                	jmp    6ed <morecore+0x5e>
  hp = (Header*)p;
 6c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6d0:	8b 55 08             	mov    0x8(%ebp),%edx
 6d3:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6d9:	83 c0 08             	add    $0x8,%eax
 6dc:	83 ec 0c             	sub    $0xc,%esp
 6df:	50                   	push   %eax
 6e0:	e8 c9 fe ff ff       	call   5ae <free>
 6e5:	83 c4 10             	add    $0x10,%esp
  return freep;
 6e8:	a1 68 0a 00 00       	mov    0xa68,%eax
}
 6ed:	c9                   	leave  
 6ee:	c3                   	ret    

000006ef <malloc>:

void*
malloc(uint nbytes)
{
 6ef:	55                   	push   %ebp
 6f0:	89 e5                	mov    %esp,%ebp
 6f2:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f5:	8b 45 08             	mov    0x8(%ebp),%eax
 6f8:	83 c0 07             	add    $0x7,%eax
 6fb:	c1 e8 03             	shr    $0x3,%eax
 6fe:	40                   	inc    %eax
 6ff:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 702:	a1 68 0a 00 00       	mov    0xa68,%eax
 707:	89 45 f0             	mov    %eax,-0x10(%ebp)
 70a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 70e:	75 23                	jne    733 <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
 710:	c7 45 f0 60 0a 00 00 	movl   $0xa60,-0x10(%ebp)
 717:	8b 45 f0             	mov    -0x10(%ebp),%eax
 71a:	a3 68 0a 00 00       	mov    %eax,0xa68
 71f:	a1 68 0a 00 00       	mov    0xa68,%eax
 724:	a3 60 0a 00 00       	mov    %eax,0xa60
    base.s.size = 0;
 729:	c7 05 64 0a 00 00 00 	movl   $0x0,0xa64
 730:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 733:	8b 45 f0             	mov    -0x10(%ebp),%eax
 736:	8b 00                	mov    (%eax),%eax
 738:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 73b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 73e:	8b 40 04             	mov    0x4(%eax),%eax
 741:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 744:	72 4d                	jb     793 <malloc+0xa4>
      if(p->s.size == nunits)
 746:	8b 45 f4             	mov    -0xc(%ebp),%eax
 749:	8b 40 04             	mov    0x4(%eax),%eax
 74c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 74f:	75 0c                	jne    75d <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
 751:	8b 45 f4             	mov    -0xc(%ebp),%eax
 754:	8b 10                	mov    (%eax),%edx
 756:	8b 45 f0             	mov    -0x10(%ebp),%eax
 759:	89 10                	mov    %edx,(%eax)
 75b:	eb 26                	jmp    783 <malloc+0x94>
      else {
        p->s.size -= nunits;
 75d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 760:	8b 40 04             	mov    0x4(%eax),%eax
 763:	2b 45 ec             	sub    -0x14(%ebp),%eax
 766:	89 c2                	mov    %eax,%edx
 768:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 76e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 771:	8b 40 04             	mov    0x4(%eax),%eax
 774:	c1 e0 03             	shl    $0x3,%eax
 777:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 77a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77d:	8b 55 ec             	mov    -0x14(%ebp),%edx
 780:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 783:	8b 45 f0             	mov    -0x10(%ebp),%eax
 786:	a3 68 0a 00 00       	mov    %eax,0xa68
      return (void*)(p + 1);
 78b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78e:	83 c0 08             	add    $0x8,%eax
 791:	eb 3b                	jmp    7ce <malloc+0xdf>
    }
    if(p == freep)
 793:	a1 68 0a 00 00       	mov    0xa68,%eax
 798:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 79b:	75 1e                	jne    7bb <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
 79d:	83 ec 0c             	sub    $0xc,%esp
 7a0:	ff 75 ec             	pushl  -0x14(%ebp)
 7a3:	e8 e7 fe ff ff       	call   68f <morecore>
 7a8:	83 c4 10             	add    $0x10,%esp
 7ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7ae:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7b2:	75 07                	jne    7bb <malloc+0xcc>
        return 0;
 7b4:	b8 00 00 00 00       	mov    $0x0,%eax
 7b9:	eb 13                	jmp    7ce <malloc+0xdf>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7be:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c4:	8b 00                	mov    (%eax),%eax
 7c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7c9:	e9 6d ff ff ff       	jmp    73b <malloc+0x4c>
}
 7ce:	c9                   	leave  
 7cf:	c3                   	ret    
