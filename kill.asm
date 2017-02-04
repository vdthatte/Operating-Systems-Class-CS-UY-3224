
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	83 ec 10             	sub    $0x10,%esp
  12:	89 cb                	mov    %ecx,%ebx
  int i;

  if(argc < 2){
  14:	83 3b 01             	cmpl   $0x1,(%ebx)
  17:	7f 17                	jg     30 <main+0x30>
    printf(2, "usage: kill pid...\n");
  19:	83 ec 08             	sub    $0x8,%esp
  1c:	68 cd 07 00 00       	push   $0x7cd
  21:	6a 02                	push   $0x2
  23:	e8 f9 03 00 00       	call   421 <printf>
  28:	83 c4 10             	add    $0x10,%esp
    exit();
  2b:	e8 7f 02 00 00       	call   2af <exit>
  }
  for(i=1; i<argc; i++)
  30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  37:	eb 2c                	jmp    65 <main+0x65>
    kill(atoi(argv[i]));
  39:	8b 45 f4             	mov    -0xc(%ebp),%eax
  3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  43:	8b 43 04             	mov    0x4(%ebx),%eax
  46:	01 d0                	add    %edx,%eax
  48:	8b 00                	mov    (%eax),%eax
  4a:	83 ec 0c             	sub    $0xc,%esp
  4d:	50                   	push   %eax
  4e:	e8 ce 01 00 00       	call   221 <atoi>
  53:	83 c4 10             	add    $0x10,%esp
  56:	83 ec 0c             	sub    $0xc,%esp
  59:	50                   	push   %eax
  5a:	e8 80 02 00 00       	call   2df <kill>
  5f:	83 c4 10             	add    $0x10,%esp

  if(argc < 2){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  62:	ff 45 f4             	incl   -0xc(%ebp)
  65:	8b 45 f4             	mov    -0xc(%ebp),%eax
  68:	3b 03                	cmp    (%ebx),%eax
  6a:	7c cd                	jl     39 <main+0x39>
    kill(atoi(argv[i]));
  exit();
  6c:	e8 3e 02 00 00       	call   2af <exit>

00000071 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  71:	55                   	push   %ebp
  72:	89 e5                	mov    %esp,%ebp
  74:	57                   	push   %edi
  75:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  76:	8b 4d 08             	mov    0x8(%ebp),%ecx
  79:	8b 55 10             	mov    0x10(%ebp),%edx
  7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  7f:	89 cb                	mov    %ecx,%ebx
  81:	89 df                	mov    %ebx,%edi
  83:	89 d1                	mov    %edx,%ecx
  85:	fc                   	cld    
  86:	f3 aa                	rep stos %al,%es:(%edi)
  88:	89 ca                	mov    %ecx,%edx
  8a:	89 fb                	mov    %edi,%ebx
  8c:	89 5d 08             	mov    %ebx,0x8(%ebp)
  8f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  92:	5b                   	pop    %ebx
  93:	5f                   	pop    %edi
  94:	5d                   	pop    %ebp
  95:	c3                   	ret    

00000096 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  96:	55                   	push   %ebp
  97:	89 e5                	mov    %esp,%ebp
  99:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  9c:	8b 45 08             	mov    0x8(%ebp),%eax
  9f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  a2:	90                   	nop
  a3:	8b 45 08             	mov    0x8(%ebp),%eax
  a6:	8d 50 01             	lea    0x1(%eax),%edx
  a9:	89 55 08             	mov    %edx,0x8(%ebp)
  ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  af:	8d 4a 01             	lea    0x1(%edx),%ecx
  b2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  b5:	8a 12                	mov    (%edx),%dl
  b7:	88 10                	mov    %dl,(%eax)
  b9:	8a 00                	mov    (%eax),%al
  bb:	84 c0                	test   %al,%al
  bd:	75 e4                	jne    a3 <strcpy+0xd>
    ;
  return os;
  bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  c2:	c9                   	leave  
  c3:	c3                   	ret    

000000c4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c4:	55                   	push   %ebp
  c5:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  c7:	eb 06                	jmp    cf <strcmp+0xb>
    p++, q++;
  c9:	ff 45 08             	incl   0x8(%ebp)
  cc:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  cf:	8b 45 08             	mov    0x8(%ebp),%eax
  d2:	8a 00                	mov    (%eax),%al
  d4:	84 c0                	test   %al,%al
  d6:	74 0e                	je     e6 <strcmp+0x22>
  d8:	8b 45 08             	mov    0x8(%ebp),%eax
  db:	8a 10                	mov    (%eax),%dl
  dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  e0:	8a 00                	mov    (%eax),%al
  e2:	38 c2                	cmp    %al,%dl
  e4:	74 e3                	je     c9 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  e6:	8b 45 08             	mov    0x8(%ebp),%eax
  e9:	8a 00                	mov    (%eax),%al
  eb:	0f b6 d0             	movzbl %al,%edx
  ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  f1:	8a 00                	mov    (%eax),%al
  f3:	0f b6 c0             	movzbl %al,%eax
  f6:	29 c2                	sub    %eax,%edx
  f8:	89 d0                	mov    %edx,%eax
}
  fa:	5d                   	pop    %ebp
  fb:	c3                   	ret    

000000fc <strlen>:

uint
strlen(char *s)
{
  fc:	55                   	push   %ebp
  fd:	89 e5                	mov    %esp,%ebp
  ff:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 102:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 109:	eb 03                	jmp    10e <strlen+0x12>
 10b:	ff 45 fc             	incl   -0x4(%ebp)
 10e:	8b 55 fc             	mov    -0x4(%ebp),%edx
 111:	8b 45 08             	mov    0x8(%ebp),%eax
 114:	01 d0                	add    %edx,%eax
 116:	8a 00                	mov    (%eax),%al
 118:	84 c0                	test   %al,%al
 11a:	75 ef                	jne    10b <strlen+0xf>
    ;
  return n;
 11c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 11f:	c9                   	leave  
 120:	c3                   	ret    

00000121 <memset>:

void*
memset(void *dst, int c, uint n)
{
 121:	55                   	push   %ebp
 122:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 124:	8b 45 10             	mov    0x10(%ebp),%eax
 127:	50                   	push   %eax
 128:	ff 75 0c             	pushl  0xc(%ebp)
 12b:	ff 75 08             	pushl  0x8(%ebp)
 12e:	e8 3e ff ff ff       	call   71 <stosb>
 133:	83 c4 0c             	add    $0xc,%esp
  return dst;
 136:	8b 45 08             	mov    0x8(%ebp),%eax
}
 139:	c9                   	leave  
 13a:	c3                   	ret    

0000013b <strchr>:

char*
strchr(const char *s, char c)
{
 13b:	55                   	push   %ebp
 13c:	89 e5                	mov    %esp,%ebp
 13e:	83 ec 04             	sub    $0x4,%esp
 141:	8b 45 0c             	mov    0xc(%ebp),%eax
 144:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 147:	eb 12                	jmp    15b <strchr+0x20>
    if(*s == c)
 149:	8b 45 08             	mov    0x8(%ebp),%eax
 14c:	8a 00                	mov    (%eax),%al
 14e:	3a 45 fc             	cmp    -0x4(%ebp),%al
 151:	75 05                	jne    158 <strchr+0x1d>
      return (char*)s;
 153:	8b 45 08             	mov    0x8(%ebp),%eax
 156:	eb 11                	jmp    169 <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 158:	ff 45 08             	incl   0x8(%ebp)
 15b:	8b 45 08             	mov    0x8(%ebp),%eax
 15e:	8a 00                	mov    (%eax),%al
 160:	84 c0                	test   %al,%al
 162:	75 e5                	jne    149 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 164:	b8 00 00 00 00       	mov    $0x0,%eax
}
 169:	c9                   	leave  
 16a:	c3                   	ret    

0000016b <gets>:

char*
gets(char *buf, int max)
{
 16b:	55                   	push   %ebp
 16c:	89 e5                	mov    %esp,%ebp
 16e:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 171:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 178:	eb 41                	jmp    1bb <gets+0x50>
    cc = read(0, &c, 1);
 17a:	83 ec 04             	sub    $0x4,%esp
 17d:	6a 01                	push   $0x1
 17f:	8d 45 ef             	lea    -0x11(%ebp),%eax
 182:	50                   	push   %eax
 183:	6a 00                	push   $0x0
 185:	e8 3d 01 00 00       	call   2c7 <read>
 18a:	83 c4 10             	add    $0x10,%esp
 18d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 190:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 194:	7f 02                	jg     198 <gets+0x2d>
      break;
 196:	eb 2c                	jmp    1c4 <gets+0x59>
    buf[i++] = c;
 198:	8b 45 f4             	mov    -0xc(%ebp),%eax
 19b:	8d 50 01             	lea    0x1(%eax),%edx
 19e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1a1:	89 c2                	mov    %eax,%edx
 1a3:	8b 45 08             	mov    0x8(%ebp),%eax
 1a6:	01 c2                	add    %eax,%edx
 1a8:	8a 45 ef             	mov    -0x11(%ebp),%al
 1ab:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1ad:	8a 45 ef             	mov    -0x11(%ebp),%al
 1b0:	3c 0a                	cmp    $0xa,%al
 1b2:	74 10                	je     1c4 <gets+0x59>
 1b4:	8a 45 ef             	mov    -0x11(%ebp),%al
 1b7:	3c 0d                	cmp    $0xd,%al
 1b9:	74 09                	je     1c4 <gets+0x59>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1be:	40                   	inc    %eax
 1bf:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1c2:	7c b6                	jl     17a <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1c7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ca:	01 d0                	add    %edx,%eax
 1cc:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1cf:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1d2:	c9                   	leave  
 1d3:	c3                   	ret    

000001d4 <stat>:

int
stat(char *n, struct stat *st)
{
 1d4:	55                   	push   %ebp
 1d5:	89 e5                	mov    %esp,%ebp
 1d7:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1da:	83 ec 08             	sub    $0x8,%esp
 1dd:	6a 00                	push   $0x0
 1df:	ff 75 08             	pushl  0x8(%ebp)
 1e2:	e8 08 01 00 00       	call   2ef <open>
 1e7:	83 c4 10             	add    $0x10,%esp
 1ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1ed:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1f1:	79 07                	jns    1fa <stat+0x26>
    return -1;
 1f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1f8:	eb 25                	jmp    21f <stat+0x4b>
  r = fstat(fd, st);
 1fa:	83 ec 08             	sub    $0x8,%esp
 1fd:	ff 75 0c             	pushl  0xc(%ebp)
 200:	ff 75 f4             	pushl  -0xc(%ebp)
 203:	e8 ff 00 00 00       	call   307 <fstat>
 208:	83 c4 10             	add    $0x10,%esp
 20b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 20e:	83 ec 0c             	sub    $0xc,%esp
 211:	ff 75 f4             	pushl  -0xc(%ebp)
 214:	e8 be 00 00 00       	call   2d7 <close>
 219:	83 c4 10             	add    $0x10,%esp
  return r;
 21c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 21f:	c9                   	leave  
 220:	c3                   	ret    

00000221 <atoi>:

int
atoi(const char *s)
{
 221:	55                   	push   %ebp
 222:	89 e5                	mov    %esp,%ebp
 224:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 227:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 22e:	eb 24                	jmp    254 <atoi+0x33>
    n = n*10 + *s++ - '0';
 230:	8b 55 fc             	mov    -0x4(%ebp),%edx
 233:	89 d0                	mov    %edx,%eax
 235:	c1 e0 02             	shl    $0x2,%eax
 238:	01 d0                	add    %edx,%eax
 23a:	01 c0                	add    %eax,%eax
 23c:	89 c1                	mov    %eax,%ecx
 23e:	8b 45 08             	mov    0x8(%ebp),%eax
 241:	8d 50 01             	lea    0x1(%eax),%edx
 244:	89 55 08             	mov    %edx,0x8(%ebp)
 247:	8a 00                	mov    (%eax),%al
 249:	0f be c0             	movsbl %al,%eax
 24c:	01 c8                	add    %ecx,%eax
 24e:	83 e8 30             	sub    $0x30,%eax
 251:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 254:	8b 45 08             	mov    0x8(%ebp),%eax
 257:	8a 00                	mov    (%eax),%al
 259:	3c 2f                	cmp    $0x2f,%al
 25b:	7e 09                	jle    266 <atoi+0x45>
 25d:	8b 45 08             	mov    0x8(%ebp),%eax
 260:	8a 00                	mov    (%eax),%al
 262:	3c 39                	cmp    $0x39,%al
 264:	7e ca                	jle    230 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 266:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 269:	c9                   	leave  
 26a:	c3                   	ret    

0000026b <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 26b:	55                   	push   %ebp
 26c:	89 e5                	mov    %esp,%ebp
 26e:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 271:	8b 45 08             	mov    0x8(%ebp),%eax
 274:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 277:	8b 45 0c             	mov    0xc(%ebp),%eax
 27a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 27d:	eb 16                	jmp    295 <memmove+0x2a>
    *dst++ = *src++;
 27f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 282:	8d 50 01             	lea    0x1(%eax),%edx
 285:	89 55 fc             	mov    %edx,-0x4(%ebp)
 288:	8b 55 f8             	mov    -0x8(%ebp),%edx
 28b:	8d 4a 01             	lea    0x1(%edx),%ecx
 28e:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 291:	8a 12                	mov    (%edx),%dl
 293:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 295:	8b 45 10             	mov    0x10(%ebp),%eax
 298:	8d 50 ff             	lea    -0x1(%eax),%edx
 29b:	89 55 10             	mov    %edx,0x10(%ebp)
 29e:	85 c0                	test   %eax,%eax
 2a0:	7f dd                	jg     27f <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2a2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2a5:	c9                   	leave  
 2a6:	c3                   	ret    

000002a7 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2a7:	b8 01 00 00 00       	mov    $0x1,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret    

000002af <exit>:
SYSCALL(exit)
 2af:	b8 02 00 00 00       	mov    $0x2,%eax
 2b4:	cd 40                	int    $0x40
 2b6:	c3                   	ret    

000002b7 <wait>:
SYSCALL(wait)
 2b7:	b8 03 00 00 00       	mov    $0x3,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret    

000002bf <pipe>:
SYSCALL(pipe)
 2bf:	b8 04 00 00 00       	mov    $0x4,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret    

000002c7 <read>:
SYSCALL(read)
 2c7:	b8 05 00 00 00       	mov    $0x5,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <write>:
SYSCALL(write)
 2cf:	b8 10 00 00 00       	mov    $0x10,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <close>:
SYSCALL(close)
 2d7:	b8 15 00 00 00       	mov    $0x15,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <kill>:
SYSCALL(kill)
 2df:	b8 06 00 00 00       	mov    $0x6,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <exec>:
SYSCALL(exec)
 2e7:	b8 07 00 00 00       	mov    $0x7,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <open>:
SYSCALL(open)
 2ef:	b8 0f 00 00 00       	mov    $0xf,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <mknod>:
SYSCALL(mknod)
 2f7:	b8 11 00 00 00       	mov    $0x11,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <unlink>:
SYSCALL(unlink)
 2ff:	b8 12 00 00 00       	mov    $0x12,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <fstat>:
SYSCALL(fstat)
 307:	b8 08 00 00 00       	mov    $0x8,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <link>:
SYSCALL(link)
 30f:	b8 13 00 00 00       	mov    $0x13,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <mkdir>:
SYSCALL(mkdir)
 317:	b8 14 00 00 00       	mov    $0x14,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <chdir>:
SYSCALL(chdir)
 31f:	b8 09 00 00 00       	mov    $0x9,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <dup>:
SYSCALL(dup)
 327:	b8 0a 00 00 00       	mov    $0xa,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <getpid>:
SYSCALL(getpid)
 32f:	b8 0b 00 00 00       	mov    $0xb,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <sbrk>:
SYSCALL(sbrk)
 337:	b8 0c 00 00 00       	mov    $0xc,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <sleep>:
SYSCALL(sleep)
 33f:	b8 0d 00 00 00       	mov    $0xd,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <uptime>:
SYSCALL(uptime)
 347:	b8 0e 00 00 00       	mov    $0xe,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 34f:	55                   	push   %ebp
 350:	89 e5                	mov    %esp,%ebp
 352:	83 ec 18             	sub    $0x18,%esp
 355:	8b 45 0c             	mov    0xc(%ebp),%eax
 358:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 35b:	83 ec 04             	sub    $0x4,%esp
 35e:	6a 01                	push   $0x1
 360:	8d 45 f4             	lea    -0xc(%ebp),%eax
 363:	50                   	push   %eax
 364:	ff 75 08             	pushl  0x8(%ebp)
 367:	e8 63 ff ff ff       	call   2cf <write>
 36c:	83 c4 10             	add    $0x10,%esp
}
 36f:	c9                   	leave  
 370:	c3                   	ret    

00000371 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 371:	55                   	push   %ebp
 372:	89 e5                	mov    %esp,%ebp
 374:	53                   	push   %ebx
 375:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 378:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 37f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 383:	74 17                	je     39c <printint+0x2b>
 385:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 389:	79 11                	jns    39c <printint+0x2b>
    neg = 1;
 38b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 392:	8b 45 0c             	mov    0xc(%ebp),%eax
 395:	f7 d8                	neg    %eax
 397:	89 45 ec             	mov    %eax,-0x14(%ebp)
 39a:	eb 06                	jmp    3a2 <printint+0x31>
  } else {
    x = xx;
 39c:	8b 45 0c             	mov    0xc(%ebp),%eax
 39f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3a2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3a9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3ac:	8d 41 01             	lea    0x1(%ecx),%eax
 3af:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3b2:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3b5:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3b8:	ba 00 00 00 00       	mov    $0x0,%edx
 3bd:	f7 f3                	div    %ebx
 3bf:	89 d0                	mov    %edx,%eax
 3c1:	8a 80 34 0a 00 00    	mov    0xa34(%eax),%al
 3c7:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3cb:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3d1:	ba 00 00 00 00       	mov    $0x0,%edx
 3d6:	f7 f3                	div    %ebx
 3d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3db:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3df:	75 c8                	jne    3a9 <printint+0x38>
  if(neg)
 3e1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3e5:	74 0e                	je     3f5 <printint+0x84>
    buf[i++] = '-';
 3e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3ea:	8d 50 01             	lea    0x1(%eax),%edx
 3ed:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3f0:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3f5:	eb 1c                	jmp    413 <printint+0xa2>
    putc(fd, buf[i]);
 3f7:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3fd:	01 d0                	add    %edx,%eax
 3ff:	8a 00                	mov    (%eax),%al
 401:	0f be c0             	movsbl %al,%eax
 404:	83 ec 08             	sub    $0x8,%esp
 407:	50                   	push   %eax
 408:	ff 75 08             	pushl  0x8(%ebp)
 40b:	e8 3f ff ff ff       	call   34f <putc>
 410:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 413:	ff 4d f4             	decl   -0xc(%ebp)
 416:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 41a:	79 db                	jns    3f7 <printint+0x86>
    putc(fd, buf[i]);
}
 41c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 41f:	c9                   	leave  
 420:	c3                   	ret    

00000421 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 421:	55                   	push   %ebp
 422:	89 e5                	mov    %esp,%ebp
 424:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 427:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 42e:	8d 45 0c             	lea    0xc(%ebp),%eax
 431:	83 c0 04             	add    $0x4,%eax
 434:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 437:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 43e:	e9 54 01 00 00       	jmp    597 <printf+0x176>
    c = fmt[i] & 0xff;
 443:	8b 55 0c             	mov    0xc(%ebp),%edx
 446:	8b 45 f0             	mov    -0x10(%ebp),%eax
 449:	01 d0                	add    %edx,%eax
 44b:	8a 00                	mov    (%eax),%al
 44d:	0f be c0             	movsbl %al,%eax
 450:	25 ff 00 00 00       	and    $0xff,%eax
 455:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 458:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 45c:	75 2c                	jne    48a <printf+0x69>
      if(c == '%'){
 45e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 462:	75 0c                	jne    470 <printf+0x4f>
        state = '%';
 464:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 46b:	e9 24 01 00 00       	jmp    594 <printf+0x173>
      } else {
        putc(fd, c);
 470:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 473:	0f be c0             	movsbl %al,%eax
 476:	83 ec 08             	sub    $0x8,%esp
 479:	50                   	push   %eax
 47a:	ff 75 08             	pushl  0x8(%ebp)
 47d:	e8 cd fe ff ff       	call   34f <putc>
 482:	83 c4 10             	add    $0x10,%esp
 485:	e9 0a 01 00 00       	jmp    594 <printf+0x173>
      }
    } else if(state == '%'){
 48a:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 48e:	0f 85 00 01 00 00    	jne    594 <printf+0x173>
      if(c == 'd'){
 494:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 498:	75 1e                	jne    4b8 <printf+0x97>
        printint(fd, *ap, 10, 1);
 49a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 49d:	8b 00                	mov    (%eax),%eax
 49f:	6a 01                	push   $0x1
 4a1:	6a 0a                	push   $0xa
 4a3:	50                   	push   %eax
 4a4:	ff 75 08             	pushl  0x8(%ebp)
 4a7:	e8 c5 fe ff ff       	call   371 <printint>
 4ac:	83 c4 10             	add    $0x10,%esp
        ap++;
 4af:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4b3:	e9 d5 00 00 00       	jmp    58d <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
 4b8:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4bc:	74 06                	je     4c4 <printf+0xa3>
 4be:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4c2:	75 1e                	jne    4e2 <printf+0xc1>
        printint(fd, *ap, 16, 0);
 4c4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4c7:	8b 00                	mov    (%eax),%eax
 4c9:	6a 00                	push   $0x0
 4cb:	6a 10                	push   $0x10
 4cd:	50                   	push   %eax
 4ce:	ff 75 08             	pushl  0x8(%ebp)
 4d1:	e8 9b fe ff ff       	call   371 <printint>
 4d6:	83 c4 10             	add    $0x10,%esp
        ap++;
 4d9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4dd:	e9 ab 00 00 00       	jmp    58d <printf+0x16c>
      } else if(c == 's'){
 4e2:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4e6:	75 40                	jne    528 <printf+0x107>
        s = (char*)*ap;
 4e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4eb:	8b 00                	mov    (%eax),%eax
 4ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4f0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4f4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4f8:	75 07                	jne    501 <printf+0xe0>
          s = "(null)";
 4fa:	c7 45 f4 e1 07 00 00 	movl   $0x7e1,-0xc(%ebp)
        while(*s != 0){
 501:	eb 1a                	jmp    51d <printf+0xfc>
          putc(fd, *s);
 503:	8b 45 f4             	mov    -0xc(%ebp),%eax
 506:	8a 00                	mov    (%eax),%al
 508:	0f be c0             	movsbl %al,%eax
 50b:	83 ec 08             	sub    $0x8,%esp
 50e:	50                   	push   %eax
 50f:	ff 75 08             	pushl  0x8(%ebp)
 512:	e8 38 fe ff ff       	call   34f <putc>
 517:	83 c4 10             	add    $0x10,%esp
          s++;
 51a:	ff 45 f4             	incl   -0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 51d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 520:	8a 00                	mov    (%eax),%al
 522:	84 c0                	test   %al,%al
 524:	75 dd                	jne    503 <printf+0xe2>
 526:	eb 65                	jmp    58d <printf+0x16c>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 528:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 52c:	75 1d                	jne    54b <printf+0x12a>
        putc(fd, *ap);
 52e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 531:	8b 00                	mov    (%eax),%eax
 533:	0f be c0             	movsbl %al,%eax
 536:	83 ec 08             	sub    $0x8,%esp
 539:	50                   	push   %eax
 53a:	ff 75 08             	pushl  0x8(%ebp)
 53d:	e8 0d fe ff ff       	call   34f <putc>
 542:	83 c4 10             	add    $0x10,%esp
        ap++;
 545:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 549:	eb 42                	jmp    58d <printf+0x16c>
      } else if(c == '%'){
 54b:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 54f:	75 17                	jne    568 <printf+0x147>
        putc(fd, c);
 551:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 554:	0f be c0             	movsbl %al,%eax
 557:	83 ec 08             	sub    $0x8,%esp
 55a:	50                   	push   %eax
 55b:	ff 75 08             	pushl  0x8(%ebp)
 55e:	e8 ec fd ff ff       	call   34f <putc>
 563:	83 c4 10             	add    $0x10,%esp
 566:	eb 25                	jmp    58d <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 568:	83 ec 08             	sub    $0x8,%esp
 56b:	6a 25                	push   $0x25
 56d:	ff 75 08             	pushl  0x8(%ebp)
 570:	e8 da fd ff ff       	call   34f <putc>
 575:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 578:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 57b:	0f be c0             	movsbl %al,%eax
 57e:	83 ec 08             	sub    $0x8,%esp
 581:	50                   	push   %eax
 582:	ff 75 08             	pushl  0x8(%ebp)
 585:	e8 c5 fd ff ff       	call   34f <putc>
 58a:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 58d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 594:	ff 45 f0             	incl   -0x10(%ebp)
 597:	8b 55 0c             	mov    0xc(%ebp),%edx
 59a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 59d:	01 d0                	add    %edx,%eax
 59f:	8a 00                	mov    (%eax),%al
 5a1:	84 c0                	test   %al,%al
 5a3:	0f 85 9a fe ff ff    	jne    443 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5a9:	c9                   	leave  
 5aa:	c3                   	ret    

000005ab <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5ab:	55                   	push   %ebp
 5ac:	89 e5                	mov    %esp,%ebp
 5ae:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5b1:	8b 45 08             	mov    0x8(%ebp),%eax
 5b4:	83 e8 08             	sub    $0x8,%eax
 5b7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ba:	a1 50 0a 00 00       	mov    0xa50,%eax
 5bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5c2:	eb 24                	jmp    5e8 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5c7:	8b 00                	mov    (%eax),%eax
 5c9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5cc:	77 12                	ja     5e0 <free+0x35>
 5ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5d1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5d4:	77 24                	ja     5fa <free+0x4f>
 5d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5d9:	8b 00                	mov    (%eax),%eax
 5db:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5de:	77 1a                	ja     5fa <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e3:	8b 00                	mov    (%eax),%eax
 5e5:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5eb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5ee:	76 d4                	jbe    5c4 <free+0x19>
 5f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f3:	8b 00                	mov    (%eax),%eax
 5f5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5f8:	76 ca                	jbe    5c4 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5fd:	8b 40 04             	mov    0x4(%eax),%eax
 600:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 607:	8b 45 f8             	mov    -0x8(%ebp),%eax
 60a:	01 c2                	add    %eax,%edx
 60c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 60f:	8b 00                	mov    (%eax),%eax
 611:	39 c2                	cmp    %eax,%edx
 613:	75 24                	jne    639 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 615:	8b 45 f8             	mov    -0x8(%ebp),%eax
 618:	8b 50 04             	mov    0x4(%eax),%edx
 61b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 61e:	8b 00                	mov    (%eax),%eax
 620:	8b 40 04             	mov    0x4(%eax),%eax
 623:	01 c2                	add    %eax,%edx
 625:	8b 45 f8             	mov    -0x8(%ebp),%eax
 628:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 62b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62e:	8b 00                	mov    (%eax),%eax
 630:	8b 10                	mov    (%eax),%edx
 632:	8b 45 f8             	mov    -0x8(%ebp),%eax
 635:	89 10                	mov    %edx,(%eax)
 637:	eb 0a                	jmp    643 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 639:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63c:	8b 10                	mov    (%eax),%edx
 63e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 641:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 643:	8b 45 fc             	mov    -0x4(%ebp),%eax
 646:	8b 40 04             	mov    0x4(%eax),%eax
 649:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 650:	8b 45 fc             	mov    -0x4(%ebp),%eax
 653:	01 d0                	add    %edx,%eax
 655:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 658:	75 20                	jne    67a <free+0xcf>
    p->s.size += bp->s.size;
 65a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65d:	8b 50 04             	mov    0x4(%eax),%edx
 660:	8b 45 f8             	mov    -0x8(%ebp),%eax
 663:	8b 40 04             	mov    0x4(%eax),%eax
 666:	01 c2                	add    %eax,%edx
 668:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 66e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 671:	8b 10                	mov    (%eax),%edx
 673:	8b 45 fc             	mov    -0x4(%ebp),%eax
 676:	89 10                	mov    %edx,(%eax)
 678:	eb 08                	jmp    682 <free+0xd7>
  } else
    p->s.ptr = bp;
 67a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67d:	8b 55 f8             	mov    -0x8(%ebp),%edx
 680:	89 10                	mov    %edx,(%eax)
  freep = p;
 682:	8b 45 fc             	mov    -0x4(%ebp),%eax
 685:	a3 50 0a 00 00       	mov    %eax,0xa50
}
 68a:	c9                   	leave  
 68b:	c3                   	ret    

0000068c <morecore>:

static Header*
morecore(uint nu)
{
 68c:	55                   	push   %ebp
 68d:	89 e5                	mov    %esp,%ebp
 68f:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 692:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 699:	77 07                	ja     6a2 <morecore+0x16>
    nu = 4096;
 69b:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6a2:	8b 45 08             	mov    0x8(%ebp),%eax
 6a5:	c1 e0 03             	shl    $0x3,%eax
 6a8:	83 ec 0c             	sub    $0xc,%esp
 6ab:	50                   	push   %eax
 6ac:	e8 86 fc ff ff       	call   337 <sbrk>
 6b1:	83 c4 10             	add    $0x10,%esp
 6b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6b7:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6bb:	75 07                	jne    6c4 <morecore+0x38>
    return 0;
 6bd:	b8 00 00 00 00       	mov    $0x0,%eax
 6c2:	eb 26                	jmp    6ea <morecore+0x5e>
  hp = (Header*)p;
 6c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6cd:	8b 55 08             	mov    0x8(%ebp),%edx
 6d0:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6d6:	83 c0 08             	add    $0x8,%eax
 6d9:	83 ec 0c             	sub    $0xc,%esp
 6dc:	50                   	push   %eax
 6dd:	e8 c9 fe ff ff       	call   5ab <free>
 6e2:	83 c4 10             	add    $0x10,%esp
  return freep;
 6e5:	a1 50 0a 00 00       	mov    0xa50,%eax
}
 6ea:	c9                   	leave  
 6eb:	c3                   	ret    

000006ec <malloc>:

void*
malloc(uint nbytes)
{
 6ec:	55                   	push   %ebp
 6ed:	89 e5                	mov    %esp,%ebp
 6ef:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f2:	8b 45 08             	mov    0x8(%ebp),%eax
 6f5:	83 c0 07             	add    $0x7,%eax
 6f8:	c1 e8 03             	shr    $0x3,%eax
 6fb:	40                   	inc    %eax
 6fc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 6ff:	a1 50 0a 00 00       	mov    0xa50,%eax
 704:	89 45 f0             	mov    %eax,-0x10(%ebp)
 707:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 70b:	75 23                	jne    730 <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
 70d:	c7 45 f0 48 0a 00 00 	movl   $0xa48,-0x10(%ebp)
 714:	8b 45 f0             	mov    -0x10(%ebp),%eax
 717:	a3 50 0a 00 00       	mov    %eax,0xa50
 71c:	a1 50 0a 00 00       	mov    0xa50,%eax
 721:	a3 48 0a 00 00       	mov    %eax,0xa48
    base.s.size = 0;
 726:	c7 05 4c 0a 00 00 00 	movl   $0x0,0xa4c
 72d:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 730:	8b 45 f0             	mov    -0x10(%ebp),%eax
 733:	8b 00                	mov    (%eax),%eax
 735:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 738:	8b 45 f4             	mov    -0xc(%ebp),%eax
 73b:	8b 40 04             	mov    0x4(%eax),%eax
 73e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 741:	72 4d                	jb     790 <malloc+0xa4>
      if(p->s.size == nunits)
 743:	8b 45 f4             	mov    -0xc(%ebp),%eax
 746:	8b 40 04             	mov    0x4(%eax),%eax
 749:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 74c:	75 0c                	jne    75a <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
 74e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 751:	8b 10                	mov    (%eax),%edx
 753:	8b 45 f0             	mov    -0x10(%ebp),%eax
 756:	89 10                	mov    %edx,(%eax)
 758:	eb 26                	jmp    780 <malloc+0x94>
      else {
        p->s.size -= nunits;
 75a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75d:	8b 40 04             	mov    0x4(%eax),%eax
 760:	2b 45 ec             	sub    -0x14(%ebp),%eax
 763:	89 c2                	mov    %eax,%edx
 765:	8b 45 f4             	mov    -0xc(%ebp),%eax
 768:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 76b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76e:	8b 40 04             	mov    0x4(%eax),%eax
 771:	c1 e0 03             	shl    $0x3,%eax
 774:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 777:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77a:	8b 55 ec             	mov    -0x14(%ebp),%edx
 77d:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 780:	8b 45 f0             	mov    -0x10(%ebp),%eax
 783:	a3 50 0a 00 00       	mov    %eax,0xa50
      return (void*)(p + 1);
 788:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78b:	83 c0 08             	add    $0x8,%eax
 78e:	eb 3b                	jmp    7cb <malloc+0xdf>
    }
    if(p == freep)
 790:	a1 50 0a 00 00       	mov    0xa50,%eax
 795:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 798:	75 1e                	jne    7b8 <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
 79a:	83 ec 0c             	sub    $0xc,%esp
 79d:	ff 75 ec             	pushl  -0x14(%ebp)
 7a0:	e8 e7 fe ff ff       	call   68c <morecore>
 7a5:	83 c4 10             	add    $0x10,%esp
 7a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7ab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7af:	75 07                	jne    7b8 <malloc+0xcc>
        return 0;
 7b1:	b8 00 00 00 00       	mov    $0x0,%eax
 7b6:	eb 13                	jmp    7cb <malloc+0xdf>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7be:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c1:	8b 00                	mov    (%eax),%eax
 7c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7c6:	e9 6d ff ff ff       	jmp    738 <malloc+0x4c>
}
 7cb:	c9                   	leave  
 7cc:	c3                   	ret    
