
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
  11:	e8 4c 02 00 00       	call   262 <fork>
  16:	85 c0                	test   %eax,%eax
  18:	7e 0d                	jle    27 <main+0x27>
    sleep(5);  // Let child exit before parent.
  1a:	83 ec 0c             	sub    $0xc,%esp
  1d:	6a 05                	push   $0x5
  1f:	e8 d6 02 00 00       	call   2fa <sleep>
  24:	83 c4 10             	add    $0x10,%esp
  exit();
  27:	e8 3e 02 00 00       	call   26a <exit>

0000002c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  2c:	55                   	push   %ebp
  2d:	89 e5                	mov    %esp,%ebp
  2f:	57                   	push   %edi
  30:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  31:	8b 4d 08             	mov    0x8(%ebp),%ecx
  34:	8b 55 10             	mov    0x10(%ebp),%edx
  37:	8b 45 0c             	mov    0xc(%ebp),%eax
  3a:	89 cb                	mov    %ecx,%ebx
  3c:	89 df                	mov    %ebx,%edi
  3e:	89 d1                	mov    %edx,%ecx
  40:	fc                   	cld    
  41:	f3 aa                	rep stos %al,%es:(%edi)
  43:	89 ca                	mov    %ecx,%edx
  45:	89 fb                	mov    %edi,%ebx
  47:	89 5d 08             	mov    %ebx,0x8(%ebp)
  4a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  4d:	5b                   	pop    %ebx
  4e:	5f                   	pop    %edi
  4f:	5d                   	pop    %ebp
  50:	c3                   	ret    

00000051 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  51:	55                   	push   %ebp
  52:	89 e5                	mov    %esp,%ebp
  54:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  57:	8b 45 08             	mov    0x8(%ebp),%eax
  5a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  5d:	90                   	nop
  5e:	8b 45 08             	mov    0x8(%ebp),%eax
  61:	8d 50 01             	lea    0x1(%eax),%edx
  64:	89 55 08             	mov    %edx,0x8(%ebp)
  67:	8b 55 0c             	mov    0xc(%ebp),%edx
  6a:	8d 4a 01             	lea    0x1(%edx),%ecx
  6d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  70:	8a 12                	mov    (%edx),%dl
  72:	88 10                	mov    %dl,(%eax)
  74:	8a 00                	mov    (%eax),%al
  76:	84 c0                	test   %al,%al
  78:	75 e4                	jne    5e <strcpy+0xd>
    ;
  return os;
  7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  7d:	c9                   	leave  
  7e:	c3                   	ret    

0000007f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  7f:	55                   	push   %ebp
  80:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  82:	eb 06                	jmp    8a <strcmp+0xb>
    p++, q++;
  84:	ff 45 08             	incl   0x8(%ebp)
  87:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  8a:	8b 45 08             	mov    0x8(%ebp),%eax
  8d:	8a 00                	mov    (%eax),%al
  8f:	84 c0                	test   %al,%al
  91:	74 0e                	je     a1 <strcmp+0x22>
  93:	8b 45 08             	mov    0x8(%ebp),%eax
  96:	8a 10                	mov    (%eax),%dl
  98:	8b 45 0c             	mov    0xc(%ebp),%eax
  9b:	8a 00                	mov    (%eax),%al
  9d:	38 c2                	cmp    %al,%dl
  9f:	74 e3                	je     84 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  a1:	8b 45 08             	mov    0x8(%ebp),%eax
  a4:	8a 00                	mov    (%eax),%al
  a6:	0f b6 d0             	movzbl %al,%edx
  a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  ac:	8a 00                	mov    (%eax),%al
  ae:	0f b6 c0             	movzbl %al,%eax
  b1:	29 c2                	sub    %eax,%edx
  b3:	89 d0                	mov    %edx,%eax
}
  b5:	5d                   	pop    %ebp
  b6:	c3                   	ret    

000000b7 <strlen>:

uint
strlen(char *s)
{
  b7:	55                   	push   %ebp
  b8:	89 e5                	mov    %esp,%ebp
  ba:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  c4:	eb 03                	jmp    c9 <strlen+0x12>
  c6:	ff 45 fc             	incl   -0x4(%ebp)
  c9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  cc:	8b 45 08             	mov    0x8(%ebp),%eax
  cf:	01 d0                	add    %edx,%eax
  d1:	8a 00                	mov    (%eax),%al
  d3:	84 c0                	test   %al,%al
  d5:	75 ef                	jne    c6 <strlen+0xf>
    ;
  return n;
  d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  da:	c9                   	leave  
  db:	c3                   	ret    

000000dc <memset>:

void*
memset(void *dst, int c, uint n)
{
  dc:	55                   	push   %ebp
  dd:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
  df:	8b 45 10             	mov    0x10(%ebp),%eax
  e2:	50                   	push   %eax
  e3:	ff 75 0c             	pushl  0xc(%ebp)
  e6:	ff 75 08             	pushl  0x8(%ebp)
  e9:	e8 3e ff ff ff       	call   2c <stosb>
  ee:	83 c4 0c             	add    $0xc,%esp
  return dst;
  f1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  f4:	c9                   	leave  
  f5:	c3                   	ret    

000000f6 <strchr>:

char*
strchr(const char *s, char c)
{
  f6:	55                   	push   %ebp
  f7:	89 e5                	mov    %esp,%ebp
  f9:	83 ec 04             	sub    $0x4,%esp
  fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  ff:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 102:	eb 12                	jmp    116 <strchr+0x20>
    if(*s == c)
 104:	8b 45 08             	mov    0x8(%ebp),%eax
 107:	8a 00                	mov    (%eax),%al
 109:	3a 45 fc             	cmp    -0x4(%ebp),%al
 10c:	75 05                	jne    113 <strchr+0x1d>
      return (char*)s;
 10e:	8b 45 08             	mov    0x8(%ebp),%eax
 111:	eb 11                	jmp    124 <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 113:	ff 45 08             	incl   0x8(%ebp)
 116:	8b 45 08             	mov    0x8(%ebp),%eax
 119:	8a 00                	mov    (%eax),%al
 11b:	84 c0                	test   %al,%al
 11d:	75 e5                	jne    104 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 11f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 124:	c9                   	leave  
 125:	c3                   	ret    

00000126 <gets>:

char*
gets(char *buf, int max)
{
 126:	55                   	push   %ebp
 127:	89 e5                	mov    %esp,%ebp
 129:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 12c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 133:	eb 41                	jmp    176 <gets+0x50>
    cc = read(0, &c, 1);
 135:	83 ec 04             	sub    $0x4,%esp
 138:	6a 01                	push   $0x1
 13a:	8d 45 ef             	lea    -0x11(%ebp),%eax
 13d:	50                   	push   %eax
 13e:	6a 00                	push   $0x0
 140:	e8 3d 01 00 00       	call   282 <read>
 145:	83 c4 10             	add    $0x10,%esp
 148:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 14b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 14f:	7f 02                	jg     153 <gets+0x2d>
      break;
 151:	eb 2c                	jmp    17f <gets+0x59>
    buf[i++] = c;
 153:	8b 45 f4             	mov    -0xc(%ebp),%eax
 156:	8d 50 01             	lea    0x1(%eax),%edx
 159:	89 55 f4             	mov    %edx,-0xc(%ebp)
 15c:	89 c2                	mov    %eax,%edx
 15e:	8b 45 08             	mov    0x8(%ebp),%eax
 161:	01 c2                	add    %eax,%edx
 163:	8a 45 ef             	mov    -0x11(%ebp),%al
 166:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 168:	8a 45 ef             	mov    -0x11(%ebp),%al
 16b:	3c 0a                	cmp    $0xa,%al
 16d:	74 10                	je     17f <gets+0x59>
 16f:	8a 45 ef             	mov    -0x11(%ebp),%al
 172:	3c 0d                	cmp    $0xd,%al
 174:	74 09                	je     17f <gets+0x59>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 176:	8b 45 f4             	mov    -0xc(%ebp),%eax
 179:	40                   	inc    %eax
 17a:	3b 45 0c             	cmp    0xc(%ebp),%eax
 17d:	7c b6                	jl     135 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 17f:	8b 55 f4             	mov    -0xc(%ebp),%edx
 182:	8b 45 08             	mov    0x8(%ebp),%eax
 185:	01 d0                	add    %edx,%eax
 187:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 18a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 18d:	c9                   	leave  
 18e:	c3                   	ret    

0000018f <stat>:

int
stat(char *n, struct stat *st)
{
 18f:	55                   	push   %ebp
 190:	89 e5                	mov    %esp,%ebp
 192:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 195:	83 ec 08             	sub    $0x8,%esp
 198:	6a 00                	push   $0x0
 19a:	ff 75 08             	pushl  0x8(%ebp)
 19d:	e8 08 01 00 00       	call   2aa <open>
 1a2:	83 c4 10             	add    $0x10,%esp
 1a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1a8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1ac:	79 07                	jns    1b5 <stat+0x26>
    return -1;
 1ae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1b3:	eb 25                	jmp    1da <stat+0x4b>
  r = fstat(fd, st);
 1b5:	83 ec 08             	sub    $0x8,%esp
 1b8:	ff 75 0c             	pushl  0xc(%ebp)
 1bb:	ff 75 f4             	pushl  -0xc(%ebp)
 1be:	e8 ff 00 00 00       	call   2c2 <fstat>
 1c3:	83 c4 10             	add    $0x10,%esp
 1c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1c9:	83 ec 0c             	sub    $0xc,%esp
 1cc:	ff 75 f4             	pushl  -0xc(%ebp)
 1cf:	e8 be 00 00 00       	call   292 <close>
 1d4:	83 c4 10             	add    $0x10,%esp
  return r;
 1d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1da:	c9                   	leave  
 1db:	c3                   	ret    

000001dc <atoi>:

int
atoi(const char *s)
{
 1dc:	55                   	push   %ebp
 1dd:	89 e5                	mov    %esp,%ebp
 1df:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 1e2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 1e9:	eb 24                	jmp    20f <atoi+0x33>
    n = n*10 + *s++ - '0';
 1eb:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1ee:	89 d0                	mov    %edx,%eax
 1f0:	c1 e0 02             	shl    $0x2,%eax
 1f3:	01 d0                	add    %edx,%eax
 1f5:	01 c0                	add    %eax,%eax
 1f7:	89 c1                	mov    %eax,%ecx
 1f9:	8b 45 08             	mov    0x8(%ebp),%eax
 1fc:	8d 50 01             	lea    0x1(%eax),%edx
 1ff:	89 55 08             	mov    %edx,0x8(%ebp)
 202:	8a 00                	mov    (%eax),%al
 204:	0f be c0             	movsbl %al,%eax
 207:	01 c8                	add    %ecx,%eax
 209:	83 e8 30             	sub    $0x30,%eax
 20c:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 20f:	8b 45 08             	mov    0x8(%ebp),%eax
 212:	8a 00                	mov    (%eax),%al
 214:	3c 2f                	cmp    $0x2f,%al
 216:	7e 09                	jle    221 <atoi+0x45>
 218:	8b 45 08             	mov    0x8(%ebp),%eax
 21b:	8a 00                	mov    (%eax),%al
 21d:	3c 39                	cmp    $0x39,%al
 21f:	7e ca                	jle    1eb <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 221:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 224:	c9                   	leave  
 225:	c3                   	ret    

00000226 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 226:	55                   	push   %ebp
 227:	89 e5                	mov    %esp,%ebp
 229:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 22c:	8b 45 08             	mov    0x8(%ebp),%eax
 22f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 232:	8b 45 0c             	mov    0xc(%ebp),%eax
 235:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 238:	eb 16                	jmp    250 <memmove+0x2a>
    *dst++ = *src++;
 23a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 23d:	8d 50 01             	lea    0x1(%eax),%edx
 240:	89 55 fc             	mov    %edx,-0x4(%ebp)
 243:	8b 55 f8             	mov    -0x8(%ebp),%edx
 246:	8d 4a 01             	lea    0x1(%edx),%ecx
 249:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 24c:	8a 12                	mov    (%edx),%dl
 24e:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 250:	8b 45 10             	mov    0x10(%ebp),%eax
 253:	8d 50 ff             	lea    -0x1(%eax),%edx
 256:	89 55 10             	mov    %edx,0x10(%ebp)
 259:	85 c0                	test   %eax,%eax
 25b:	7f dd                	jg     23a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 25d:	8b 45 08             	mov    0x8(%ebp),%eax
}
 260:	c9                   	leave  
 261:	c3                   	ret    

00000262 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 262:	b8 01 00 00 00       	mov    $0x1,%eax
 267:	cd 40                	int    $0x40
 269:	c3                   	ret    

0000026a <exit>:
SYSCALL(exit)
 26a:	b8 02 00 00 00       	mov    $0x2,%eax
 26f:	cd 40                	int    $0x40
 271:	c3                   	ret    

00000272 <wait>:
SYSCALL(wait)
 272:	b8 03 00 00 00       	mov    $0x3,%eax
 277:	cd 40                	int    $0x40
 279:	c3                   	ret    

0000027a <pipe>:
SYSCALL(pipe)
 27a:	b8 04 00 00 00       	mov    $0x4,%eax
 27f:	cd 40                	int    $0x40
 281:	c3                   	ret    

00000282 <read>:
SYSCALL(read)
 282:	b8 05 00 00 00       	mov    $0x5,%eax
 287:	cd 40                	int    $0x40
 289:	c3                   	ret    

0000028a <write>:
SYSCALL(write)
 28a:	b8 10 00 00 00       	mov    $0x10,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <close>:
SYSCALL(close)
 292:	b8 15 00 00 00       	mov    $0x15,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <kill>:
SYSCALL(kill)
 29a:	b8 06 00 00 00       	mov    $0x6,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <exec>:
SYSCALL(exec)
 2a2:	b8 07 00 00 00       	mov    $0x7,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <open>:
SYSCALL(open)
 2aa:	b8 0f 00 00 00       	mov    $0xf,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <mknod>:
SYSCALL(mknod)
 2b2:	b8 11 00 00 00       	mov    $0x11,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <unlink>:
SYSCALL(unlink)
 2ba:	b8 12 00 00 00       	mov    $0x12,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <fstat>:
SYSCALL(fstat)
 2c2:	b8 08 00 00 00       	mov    $0x8,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <link>:
SYSCALL(link)
 2ca:	b8 13 00 00 00       	mov    $0x13,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <mkdir>:
SYSCALL(mkdir)
 2d2:	b8 14 00 00 00       	mov    $0x14,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <chdir>:
SYSCALL(chdir)
 2da:	b8 09 00 00 00       	mov    $0x9,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <dup>:
SYSCALL(dup)
 2e2:	b8 0a 00 00 00       	mov    $0xa,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <getpid>:
SYSCALL(getpid)
 2ea:	b8 0b 00 00 00       	mov    $0xb,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <sbrk>:
SYSCALL(sbrk)
 2f2:	b8 0c 00 00 00       	mov    $0xc,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <sleep>:
SYSCALL(sleep)
 2fa:	b8 0d 00 00 00       	mov    $0xd,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <uptime>:
SYSCALL(uptime)
 302:	b8 0e 00 00 00       	mov    $0xe,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 30a:	55                   	push   %ebp
 30b:	89 e5                	mov    %esp,%ebp
 30d:	83 ec 18             	sub    $0x18,%esp
 310:	8b 45 0c             	mov    0xc(%ebp),%eax
 313:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 316:	83 ec 04             	sub    $0x4,%esp
 319:	6a 01                	push   $0x1
 31b:	8d 45 f4             	lea    -0xc(%ebp),%eax
 31e:	50                   	push   %eax
 31f:	ff 75 08             	pushl  0x8(%ebp)
 322:	e8 63 ff ff ff       	call   28a <write>
 327:	83 c4 10             	add    $0x10,%esp
}
 32a:	c9                   	leave  
 32b:	c3                   	ret    

0000032c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 32c:	55                   	push   %ebp
 32d:	89 e5                	mov    %esp,%ebp
 32f:	53                   	push   %ebx
 330:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 333:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 33a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 33e:	74 17                	je     357 <printint+0x2b>
 340:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 344:	79 11                	jns    357 <printint+0x2b>
    neg = 1;
 346:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 34d:	8b 45 0c             	mov    0xc(%ebp),%eax
 350:	f7 d8                	neg    %eax
 352:	89 45 ec             	mov    %eax,-0x14(%ebp)
 355:	eb 06                	jmp    35d <printint+0x31>
  } else {
    x = xx;
 357:	8b 45 0c             	mov    0xc(%ebp),%eax
 35a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 35d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 364:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 367:	8d 41 01             	lea    0x1(%ecx),%eax
 36a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 36d:	8b 5d 10             	mov    0x10(%ebp),%ebx
 370:	8b 45 ec             	mov    -0x14(%ebp),%eax
 373:	ba 00 00 00 00       	mov    $0x0,%edx
 378:	f7 f3                	div    %ebx
 37a:	89 d0                	mov    %edx,%eax
 37c:	8a 80 d8 09 00 00    	mov    0x9d8(%eax),%al
 382:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 386:	8b 5d 10             	mov    0x10(%ebp),%ebx
 389:	8b 45 ec             	mov    -0x14(%ebp),%eax
 38c:	ba 00 00 00 00       	mov    $0x0,%edx
 391:	f7 f3                	div    %ebx
 393:	89 45 ec             	mov    %eax,-0x14(%ebp)
 396:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 39a:	75 c8                	jne    364 <printint+0x38>
  if(neg)
 39c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3a0:	74 0e                	je     3b0 <printint+0x84>
    buf[i++] = '-';
 3a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3a5:	8d 50 01             	lea    0x1(%eax),%edx
 3a8:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3ab:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3b0:	eb 1c                	jmp    3ce <printint+0xa2>
    putc(fd, buf[i]);
 3b2:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3b8:	01 d0                	add    %edx,%eax
 3ba:	8a 00                	mov    (%eax),%al
 3bc:	0f be c0             	movsbl %al,%eax
 3bf:	83 ec 08             	sub    $0x8,%esp
 3c2:	50                   	push   %eax
 3c3:	ff 75 08             	pushl  0x8(%ebp)
 3c6:	e8 3f ff ff ff       	call   30a <putc>
 3cb:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3ce:	ff 4d f4             	decl   -0xc(%ebp)
 3d1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 3d5:	79 db                	jns    3b2 <printint+0x86>
    putc(fd, buf[i]);
}
 3d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3da:	c9                   	leave  
 3db:	c3                   	ret    

000003dc <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3dc:	55                   	push   %ebp
 3dd:	89 e5                	mov    %esp,%ebp
 3df:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 3e2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 3e9:	8d 45 0c             	lea    0xc(%ebp),%eax
 3ec:	83 c0 04             	add    $0x4,%eax
 3ef:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 3f2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 3f9:	e9 54 01 00 00       	jmp    552 <printf+0x176>
    c = fmt[i] & 0xff;
 3fe:	8b 55 0c             	mov    0xc(%ebp),%edx
 401:	8b 45 f0             	mov    -0x10(%ebp),%eax
 404:	01 d0                	add    %edx,%eax
 406:	8a 00                	mov    (%eax),%al
 408:	0f be c0             	movsbl %al,%eax
 40b:	25 ff 00 00 00       	and    $0xff,%eax
 410:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 413:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 417:	75 2c                	jne    445 <printf+0x69>
      if(c == '%'){
 419:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 41d:	75 0c                	jne    42b <printf+0x4f>
        state = '%';
 41f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 426:	e9 24 01 00 00       	jmp    54f <printf+0x173>
      } else {
        putc(fd, c);
 42b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 42e:	0f be c0             	movsbl %al,%eax
 431:	83 ec 08             	sub    $0x8,%esp
 434:	50                   	push   %eax
 435:	ff 75 08             	pushl  0x8(%ebp)
 438:	e8 cd fe ff ff       	call   30a <putc>
 43d:	83 c4 10             	add    $0x10,%esp
 440:	e9 0a 01 00 00       	jmp    54f <printf+0x173>
      }
    } else if(state == '%'){
 445:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 449:	0f 85 00 01 00 00    	jne    54f <printf+0x173>
      if(c == 'd'){
 44f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 453:	75 1e                	jne    473 <printf+0x97>
        printint(fd, *ap, 10, 1);
 455:	8b 45 e8             	mov    -0x18(%ebp),%eax
 458:	8b 00                	mov    (%eax),%eax
 45a:	6a 01                	push   $0x1
 45c:	6a 0a                	push   $0xa
 45e:	50                   	push   %eax
 45f:	ff 75 08             	pushl  0x8(%ebp)
 462:	e8 c5 fe ff ff       	call   32c <printint>
 467:	83 c4 10             	add    $0x10,%esp
        ap++;
 46a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 46e:	e9 d5 00 00 00       	jmp    548 <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
 473:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 477:	74 06                	je     47f <printf+0xa3>
 479:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 47d:	75 1e                	jne    49d <printf+0xc1>
        printint(fd, *ap, 16, 0);
 47f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 482:	8b 00                	mov    (%eax),%eax
 484:	6a 00                	push   $0x0
 486:	6a 10                	push   $0x10
 488:	50                   	push   %eax
 489:	ff 75 08             	pushl  0x8(%ebp)
 48c:	e8 9b fe ff ff       	call   32c <printint>
 491:	83 c4 10             	add    $0x10,%esp
        ap++;
 494:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 498:	e9 ab 00 00 00       	jmp    548 <printf+0x16c>
      } else if(c == 's'){
 49d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4a1:	75 40                	jne    4e3 <printf+0x107>
        s = (char*)*ap;
 4a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4a6:	8b 00                	mov    (%eax),%eax
 4a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4ab:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4af:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4b3:	75 07                	jne    4bc <printf+0xe0>
          s = "(null)";
 4b5:	c7 45 f4 88 07 00 00 	movl   $0x788,-0xc(%ebp)
        while(*s != 0){
 4bc:	eb 1a                	jmp    4d8 <printf+0xfc>
          putc(fd, *s);
 4be:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4c1:	8a 00                	mov    (%eax),%al
 4c3:	0f be c0             	movsbl %al,%eax
 4c6:	83 ec 08             	sub    $0x8,%esp
 4c9:	50                   	push   %eax
 4ca:	ff 75 08             	pushl  0x8(%ebp)
 4cd:	e8 38 fe ff ff       	call   30a <putc>
 4d2:	83 c4 10             	add    $0x10,%esp
          s++;
 4d5:	ff 45 f4             	incl   -0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4db:	8a 00                	mov    (%eax),%al
 4dd:	84 c0                	test   %al,%al
 4df:	75 dd                	jne    4be <printf+0xe2>
 4e1:	eb 65                	jmp    548 <printf+0x16c>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4e3:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 4e7:	75 1d                	jne    506 <printf+0x12a>
        putc(fd, *ap);
 4e9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ec:	8b 00                	mov    (%eax),%eax
 4ee:	0f be c0             	movsbl %al,%eax
 4f1:	83 ec 08             	sub    $0x8,%esp
 4f4:	50                   	push   %eax
 4f5:	ff 75 08             	pushl  0x8(%ebp)
 4f8:	e8 0d fe ff ff       	call   30a <putc>
 4fd:	83 c4 10             	add    $0x10,%esp
        ap++;
 500:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 504:	eb 42                	jmp    548 <printf+0x16c>
      } else if(c == '%'){
 506:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 50a:	75 17                	jne    523 <printf+0x147>
        putc(fd, c);
 50c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 50f:	0f be c0             	movsbl %al,%eax
 512:	83 ec 08             	sub    $0x8,%esp
 515:	50                   	push   %eax
 516:	ff 75 08             	pushl  0x8(%ebp)
 519:	e8 ec fd ff ff       	call   30a <putc>
 51e:	83 c4 10             	add    $0x10,%esp
 521:	eb 25                	jmp    548 <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 523:	83 ec 08             	sub    $0x8,%esp
 526:	6a 25                	push   $0x25
 528:	ff 75 08             	pushl  0x8(%ebp)
 52b:	e8 da fd ff ff       	call   30a <putc>
 530:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 533:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 536:	0f be c0             	movsbl %al,%eax
 539:	83 ec 08             	sub    $0x8,%esp
 53c:	50                   	push   %eax
 53d:	ff 75 08             	pushl  0x8(%ebp)
 540:	e8 c5 fd ff ff       	call   30a <putc>
 545:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 548:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 54f:	ff 45 f0             	incl   -0x10(%ebp)
 552:	8b 55 0c             	mov    0xc(%ebp),%edx
 555:	8b 45 f0             	mov    -0x10(%ebp),%eax
 558:	01 d0                	add    %edx,%eax
 55a:	8a 00                	mov    (%eax),%al
 55c:	84 c0                	test   %al,%al
 55e:	0f 85 9a fe ff ff    	jne    3fe <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 564:	c9                   	leave  
 565:	c3                   	ret    

00000566 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 566:	55                   	push   %ebp
 567:	89 e5                	mov    %esp,%ebp
 569:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 56c:	8b 45 08             	mov    0x8(%ebp),%eax
 56f:	83 e8 08             	sub    $0x8,%eax
 572:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 575:	a1 f4 09 00 00       	mov    0x9f4,%eax
 57a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 57d:	eb 24                	jmp    5a3 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 57f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 582:	8b 00                	mov    (%eax),%eax
 584:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 587:	77 12                	ja     59b <free+0x35>
 589:	8b 45 f8             	mov    -0x8(%ebp),%eax
 58c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 58f:	77 24                	ja     5b5 <free+0x4f>
 591:	8b 45 fc             	mov    -0x4(%ebp),%eax
 594:	8b 00                	mov    (%eax),%eax
 596:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 599:	77 1a                	ja     5b5 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 59b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 59e:	8b 00                	mov    (%eax),%eax
 5a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5a6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5a9:	76 d4                	jbe    57f <free+0x19>
 5ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5ae:	8b 00                	mov    (%eax),%eax
 5b0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5b3:	76 ca                	jbe    57f <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5b8:	8b 40 04             	mov    0x4(%eax),%eax
 5bb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 5c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5c5:	01 c2                	add    %eax,%edx
 5c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5ca:	8b 00                	mov    (%eax),%eax
 5cc:	39 c2                	cmp    %eax,%edx
 5ce:	75 24                	jne    5f4 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 5d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5d3:	8b 50 04             	mov    0x4(%eax),%edx
 5d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5d9:	8b 00                	mov    (%eax),%eax
 5db:	8b 40 04             	mov    0x4(%eax),%eax
 5de:	01 c2                	add    %eax,%edx
 5e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5e3:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 5e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e9:	8b 00                	mov    (%eax),%eax
 5eb:	8b 10                	mov    (%eax),%edx
 5ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f0:	89 10                	mov    %edx,(%eax)
 5f2:	eb 0a                	jmp    5fe <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 5f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f7:	8b 10                	mov    (%eax),%edx
 5f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5fc:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 5fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
 601:	8b 40 04             	mov    0x4(%eax),%eax
 604:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 60b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 60e:	01 d0                	add    %edx,%eax
 610:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 613:	75 20                	jne    635 <free+0xcf>
    p->s.size += bp->s.size;
 615:	8b 45 fc             	mov    -0x4(%ebp),%eax
 618:	8b 50 04             	mov    0x4(%eax),%edx
 61b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61e:	8b 40 04             	mov    0x4(%eax),%eax
 621:	01 c2                	add    %eax,%edx
 623:	8b 45 fc             	mov    -0x4(%ebp),%eax
 626:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 629:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62c:	8b 10                	mov    (%eax),%edx
 62e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 631:	89 10                	mov    %edx,(%eax)
 633:	eb 08                	jmp    63d <free+0xd7>
  } else
    p->s.ptr = bp;
 635:	8b 45 fc             	mov    -0x4(%ebp),%eax
 638:	8b 55 f8             	mov    -0x8(%ebp),%edx
 63b:	89 10                	mov    %edx,(%eax)
  freep = p;
 63d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 640:	a3 f4 09 00 00       	mov    %eax,0x9f4
}
 645:	c9                   	leave  
 646:	c3                   	ret    

00000647 <morecore>:

static Header*
morecore(uint nu)
{
 647:	55                   	push   %ebp
 648:	89 e5                	mov    %esp,%ebp
 64a:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 64d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 654:	77 07                	ja     65d <morecore+0x16>
    nu = 4096;
 656:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 65d:	8b 45 08             	mov    0x8(%ebp),%eax
 660:	c1 e0 03             	shl    $0x3,%eax
 663:	83 ec 0c             	sub    $0xc,%esp
 666:	50                   	push   %eax
 667:	e8 86 fc ff ff       	call   2f2 <sbrk>
 66c:	83 c4 10             	add    $0x10,%esp
 66f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 672:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 676:	75 07                	jne    67f <morecore+0x38>
    return 0;
 678:	b8 00 00 00 00       	mov    $0x0,%eax
 67d:	eb 26                	jmp    6a5 <morecore+0x5e>
  hp = (Header*)p;
 67f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 682:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 685:	8b 45 f0             	mov    -0x10(%ebp),%eax
 688:	8b 55 08             	mov    0x8(%ebp),%edx
 68b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 68e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 691:	83 c0 08             	add    $0x8,%eax
 694:	83 ec 0c             	sub    $0xc,%esp
 697:	50                   	push   %eax
 698:	e8 c9 fe ff ff       	call   566 <free>
 69d:	83 c4 10             	add    $0x10,%esp
  return freep;
 6a0:	a1 f4 09 00 00       	mov    0x9f4,%eax
}
 6a5:	c9                   	leave  
 6a6:	c3                   	ret    

000006a7 <malloc>:

void*
malloc(uint nbytes)
{
 6a7:	55                   	push   %ebp
 6a8:	89 e5                	mov    %esp,%ebp
 6aa:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6ad:	8b 45 08             	mov    0x8(%ebp),%eax
 6b0:	83 c0 07             	add    $0x7,%eax
 6b3:	c1 e8 03             	shr    $0x3,%eax
 6b6:	40                   	inc    %eax
 6b7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 6ba:	a1 f4 09 00 00       	mov    0x9f4,%eax
 6bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
 6c2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6c6:	75 23                	jne    6eb <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
 6c8:	c7 45 f0 ec 09 00 00 	movl   $0x9ec,-0x10(%ebp)
 6cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6d2:	a3 f4 09 00 00       	mov    %eax,0x9f4
 6d7:	a1 f4 09 00 00       	mov    0x9f4,%eax
 6dc:	a3 ec 09 00 00       	mov    %eax,0x9ec
    base.s.size = 0;
 6e1:	c7 05 f0 09 00 00 00 	movl   $0x0,0x9f0
 6e8:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6ee:	8b 00                	mov    (%eax),%eax
 6f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 6f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6f6:	8b 40 04             	mov    0x4(%eax),%eax
 6f9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 6fc:	72 4d                	jb     74b <malloc+0xa4>
      if(p->s.size == nunits)
 6fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 701:	8b 40 04             	mov    0x4(%eax),%eax
 704:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 707:	75 0c                	jne    715 <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
 709:	8b 45 f4             	mov    -0xc(%ebp),%eax
 70c:	8b 10                	mov    (%eax),%edx
 70e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 711:	89 10                	mov    %edx,(%eax)
 713:	eb 26                	jmp    73b <malloc+0x94>
      else {
        p->s.size -= nunits;
 715:	8b 45 f4             	mov    -0xc(%ebp),%eax
 718:	8b 40 04             	mov    0x4(%eax),%eax
 71b:	2b 45 ec             	sub    -0x14(%ebp),%eax
 71e:	89 c2                	mov    %eax,%edx
 720:	8b 45 f4             	mov    -0xc(%ebp),%eax
 723:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 726:	8b 45 f4             	mov    -0xc(%ebp),%eax
 729:	8b 40 04             	mov    0x4(%eax),%eax
 72c:	c1 e0 03             	shl    $0x3,%eax
 72f:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 732:	8b 45 f4             	mov    -0xc(%ebp),%eax
 735:	8b 55 ec             	mov    -0x14(%ebp),%edx
 738:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 73b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 73e:	a3 f4 09 00 00       	mov    %eax,0x9f4
      return (void*)(p + 1);
 743:	8b 45 f4             	mov    -0xc(%ebp),%eax
 746:	83 c0 08             	add    $0x8,%eax
 749:	eb 3b                	jmp    786 <malloc+0xdf>
    }
    if(p == freep)
 74b:	a1 f4 09 00 00       	mov    0x9f4,%eax
 750:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 753:	75 1e                	jne    773 <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
 755:	83 ec 0c             	sub    $0xc,%esp
 758:	ff 75 ec             	pushl  -0x14(%ebp)
 75b:	e8 e7 fe ff ff       	call   647 <morecore>
 760:	83 c4 10             	add    $0x10,%esp
 763:	89 45 f4             	mov    %eax,-0xc(%ebp)
 766:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 76a:	75 07                	jne    773 <malloc+0xcc>
        return 0;
 76c:	b8 00 00 00 00       	mov    $0x0,%eax
 771:	eb 13                	jmp    786 <malloc+0xdf>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 773:	8b 45 f4             	mov    -0xc(%ebp),%eax
 776:	89 45 f0             	mov    %eax,-0x10(%ebp)
 779:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77c:	8b 00                	mov    (%eax),%eax
 77e:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 781:	e9 6d ff ff ff       	jmp    6f3 <malloc+0x4c>
}
 786:	c9                   	leave  
 787:	c3                   	ret    
