
_tail:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

#include "types.h"
#include "user.h"

int main(int argc, char *argv[]){
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  11:	89 c8                	mov    %ecx,%eax
	printf(1, argv[0]);
  13:	8b 40 04             	mov    0x4(%eax),%eax
  16:	8b 00                	mov    (%eax),%eax
  18:	83 ec 08             	sub    $0x8,%esp
  1b:	50                   	push   %eax
  1c:	6a 01                	push   $0x1
  1e:	e8 c0 03 00 00       	call   3e3 <printf>
  23:	83 c4 10             	add    $0x10,%esp
	return 0;	
  26:	b8 00 00 00 00       	mov    $0x0,%eax
  2b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  2e:	c9                   	leave  
  2f:	8d 61 fc             	lea    -0x4(%ecx),%esp
  32:	c3                   	ret    

00000033 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  33:	55                   	push   %ebp
  34:	89 e5                	mov    %esp,%ebp
  36:	57                   	push   %edi
  37:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  38:	8b 4d 08             	mov    0x8(%ebp),%ecx
  3b:	8b 55 10             	mov    0x10(%ebp),%edx
  3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  41:	89 cb                	mov    %ecx,%ebx
  43:	89 df                	mov    %ebx,%edi
  45:	89 d1                	mov    %edx,%ecx
  47:	fc                   	cld    
  48:	f3 aa                	rep stos %al,%es:(%edi)
  4a:	89 ca                	mov    %ecx,%edx
  4c:	89 fb                	mov    %edi,%ebx
  4e:	89 5d 08             	mov    %ebx,0x8(%ebp)
  51:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  54:	5b                   	pop    %ebx
  55:	5f                   	pop    %edi
  56:	5d                   	pop    %ebp
  57:	c3                   	ret    

00000058 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  58:	55                   	push   %ebp
  59:	89 e5                	mov    %esp,%ebp
  5b:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  5e:	8b 45 08             	mov    0x8(%ebp),%eax
  61:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  64:	90                   	nop
  65:	8b 45 08             	mov    0x8(%ebp),%eax
  68:	8d 50 01             	lea    0x1(%eax),%edx
  6b:	89 55 08             	mov    %edx,0x8(%ebp)
  6e:	8b 55 0c             	mov    0xc(%ebp),%edx
  71:	8d 4a 01             	lea    0x1(%edx),%ecx
  74:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  77:	8a 12                	mov    (%edx),%dl
  79:	88 10                	mov    %dl,(%eax)
  7b:	8a 00                	mov    (%eax),%al
  7d:	84 c0                	test   %al,%al
  7f:	75 e4                	jne    65 <strcpy+0xd>
    ;
  return os;
  81:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  84:	c9                   	leave  
  85:	c3                   	ret    

00000086 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  86:	55                   	push   %ebp
  87:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  89:	eb 06                	jmp    91 <strcmp+0xb>
    p++, q++;
  8b:	ff 45 08             	incl   0x8(%ebp)
  8e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  91:	8b 45 08             	mov    0x8(%ebp),%eax
  94:	8a 00                	mov    (%eax),%al
  96:	84 c0                	test   %al,%al
  98:	74 0e                	je     a8 <strcmp+0x22>
  9a:	8b 45 08             	mov    0x8(%ebp),%eax
  9d:	8a 10                	mov    (%eax),%dl
  9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  a2:	8a 00                	mov    (%eax),%al
  a4:	38 c2                	cmp    %al,%dl
  a6:	74 e3                	je     8b <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  a8:	8b 45 08             	mov    0x8(%ebp),%eax
  ab:	8a 00                	mov    (%eax),%al
  ad:	0f b6 d0             	movzbl %al,%edx
  b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  b3:	8a 00                	mov    (%eax),%al
  b5:	0f b6 c0             	movzbl %al,%eax
  b8:	29 c2                	sub    %eax,%edx
  ba:	89 d0                	mov    %edx,%eax
}
  bc:	5d                   	pop    %ebp
  bd:	c3                   	ret    

000000be <strlen>:

uint
strlen(char *s)
{
  be:	55                   	push   %ebp
  bf:	89 e5                	mov    %esp,%ebp
  c1:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  cb:	eb 03                	jmp    d0 <strlen+0x12>
  cd:	ff 45 fc             	incl   -0x4(%ebp)
  d0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  d3:	8b 45 08             	mov    0x8(%ebp),%eax
  d6:	01 d0                	add    %edx,%eax
  d8:	8a 00                	mov    (%eax),%al
  da:	84 c0                	test   %al,%al
  dc:	75 ef                	jne    cd <strlen+0xf>
    ;
  return n;
  de:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e1:	c9                   	leave  
  e2:	c3                   	ret    

000000e3 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e3:	55                   	push   %ebp
  e4:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
  e6:	8b 45 10             	mov    0x10(%ebp),%eax
  e9:	50                   	push   %eax
  ea:	ff 75 0c             	pushl  0xc(%ebp)
  ed:	ff 75 08             	pushl  0x8(%ebp)
  f0:	e8 3e ff ff ff       	call   33 <stosb>
  f5:	83 c4 0c             	add    $0xc,%esp
  return dst;
  f8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  fb:	c9                   	leave  
  fc:	c3                   	ret    

000000fd <strchr>:

char*
strchr(const char *s, char c)
{
  fd:	55                   	push   %ebp
  fe:	89 e5                	mov    %esp,%ebp
 100:	83 ec 04             	sub    $0x4,%esp
 103:	8b 45 0c             	mov    0xc(%ebp),%eax
 106:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 109:	eb 12                	jmp    11d <strchr+0x20>
    if(*s == c)
 10b:	8b 45 08             	mov    0x8(%ebp),%eax
 10e:	8a 00                	mov    (%eax),%al
 110:	3a 45 fc             	cmp    -0x4(%ebp),%al
 113:	75 05                	jne    11a <strchr+0x1d>
      return (char*)s;
 115:	8b 45 08             	mov    0x8(%ebp),%eax
 118:	eb 11                	jmp    12b <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 11a:	ff 45 08             	incl   0x8(%ebp)
 11d:	8b 45 08             	mov    0x8(%ebp),%eax
 120:	8a 00                	mov    (%eax),%al
 122:	84 c0                	test   %al,%al
 124:	75 e5                	jne    10b <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 126:	b8 00 00 00 00       	mov    $0x0,%eax
}
 12b:	c9                   	leave  
 12c:	c3                   	ret    

0000012d <gets>:

char*
gets(char *buf, int max)
{
 12d:	55                   	push   %ebp
 12e:	89 e5                	mov    %esp,%ebp
 130:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 133:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 13a:	eb 41                	jmp    17d <gets+0x50>
    cc = read(0, &c, 1);
 13c:	83 ec 04             	sub    $0x4,%esp
 13f:	6a 01                	push   $0x1
 141:	8d 45 ef             	lea    -0x11(%ebp),%eax
 144:	50                   	push   %eax
 145:	6a 00                	push   $0x0
 147:	e8 3d 01 00 00       	call   289 <read>
 14c:	83 c4 10             	add    $0x10,%esp
 14f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 152:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 156:	7f 02                	jg     15a <gets+0x2d>
      break;
 158:	eb 2c                	jmp    186 <gets+0x59>
    buf[i++] = c;
 15a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 15d:	8d 50 01             	lea    0x1(%eax),%edx
 160:	89 55 f4             	mov    %edx,-0xc(%ebp)
 163:	89 c2                	mov    %eax,%edx
 165:	8b 45 08             	mov    0x8(%ebp),%eax
 168:	01 c2                	add    %eax,%edx
 16a:	8a 45 ef             	mov    -0x11(%ebp),%al
 16d:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 16f:	8a 45 ef             	mov    -0x11(%ebp),%al
 172:	3c 0a                	cmp    $0xa,%al
 174:	74 10                	je     186 <gets+0x59>
 176:	8a 45 ef             	mov    -0x11(%ebp),%al
 179:	3c 0d                	cmp    $0xd,%al
 17b:	74 09                	je     186 <gets+0x59>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 17d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 180:	40                   	inc    %eax
 181:	3b 45 0c             	cmp    0xc(%ebp),%eax
 184:	7c b6                	jl     13c <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 186:	8b 55 f4             	mov    -0xc(%ebp),%edx
 189:	8b 45 08             	mov    0x8(%ebp),%eax
 18c:	01 d0                	add    %edx,%eax
 18e:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 191:	8b 45 08             	mov    0x8(%ebp),%eax
}
 194:	c9                   	leave  
 195:	c3                   	ret    

00000196 <stat>:

int
stat(char *n, struct stat *st)
{
 196:	55                   	push   %ebp
 197:	89 e5                	mov    %esp,%ebp
 199:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 19c:	83 ec 08             	sub    $0x8,%esp
 19f:	6a 00                	push   $0x0
 1a1:	ff 75 08             	pushl  0x8(%ebp)
 1a4:	e8 08 01 00 00       	call   2b1 <open>
 1a9:	83 c4 10             	add    $0x10,%esp
 1ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1af:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1b3:	79 07                	jns    1bc <stat+0x26>
    return -1;
 1b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1ba:	eb 25                	jmp    1e1 <stat+0x4b>
  r = fstat(fd, st);
 1bc:	83 ec 08             	sub    $0x8,%esp
 1bf:	ff 75 0c             	pushl  0xc(%ebp)
 1c2:	ff 75 f4             	pushl  -0xc(%ebp)
 1c5:	e8 ff 00 00 00       	call   2c9 <fstat>
 1ca:	83 c4 10             	add    $0x10,%esp
 1cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1d0:	83 ec 0c             	sub    $0xc,%esp
 1d3:	ff 75 f4             	pushl  -0xc(%ebp)
 1d6:	e8 be 00 00 00       	call   299 <close>
 1db:	83 c4 10             	add    $0x10,%esp
  return r;
 1de:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1e1:	c9                   	leave  
 1e2:	c3                   	ret    

000001e3 <atoi>:

int
atoi(const char *s)
{
 1e3:	55                   	push   %ebp
 1e4:	89 e5                	mov    %esp,%ebp
 1e6:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 1e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 1f0:	eb 24                	jmp    216 <atoi+0x33>
    n = n*10 + *s++ - '0';
 1f2:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1f5:	89 d0                	mov    %edx,%eax
 1f7:	c1 e0 02             	shl    $0x2,%eax
 1fa:	01 d0                	add    %edx,%eax
 1fc:	01 c0                	add    %eax,%eax
 1fe:	89 c1                	mov    %eax,%ecx
 200:	8b 45 08             	mov    0x8(%ebp),%eax
 203:	8d 50 01             	lea    0x1(%eax),%edx
 206:	89 55 08             	mov    %edx,0x8(%ebp)
 209:	8a 00                	mov    (%eax),%al
 20b:	0f be c0             	movsbl %al,%eax
 20e:	01 c8                	add    %ecx,%eax
 210:	83 e8 30             	sub    $0x30,%eax
 213:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 216:	8b 45 08             	mov    0x8(%ebp),%eax
 219:	8a 00                	mov    (%eax),%al
 21b:	3c 2f                	cmp    $0x2f,%al
 21d:	7e 09                	jle    228 <atoi+0x45>
 21f:	8b 45 08             	mov    0x8(%ebp),%eax
 222:	8a 00                	mov    (%eax),%al
 224:	3c 39                	cmp    $0x39,%al
 226:	7e ca                	jle    1f2 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 228:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 22b:	c9                   	leave  
 22c:	c3                   	ret    

0000022d <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 22d:	55                   	push   %ebp
 22e:	89 e5                	mov    %esp,%ebp
 230:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 233:	8b 45 08             	mov    0x8(%ebp),%eax
 236:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 239:	8b 45 0c             	mov    0xc(%ebp),%eax
 23c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 23f:	eb 16                	jmp    257 <memmove+0x2a>
    *dst++ = *src++;
 241:	8b 45 fc             	mov    -0x4(%ebp),%eax
 244:	8d 50 01             	lea    0x1(%eax),%edx
 247:	89 55 fc             	mov    %edx,-0x4(%ebp)
 24a:	8b 55 f8             	mov    -0x8(%ebp),%edx
 24d:	8d 4a 01             	lea    0x1(%edx),%ecx
 250:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 253:	8a 12                	mov    (%edx),%dl
 255:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 257:	8b 45 10             	mov    0x10(%ebp),%eax
 25a:	8d 50 ff             	lea    -0x1(%eax),%edx
 25d:	89 55 10             	mov    %edx,0x10(%ebp)
 260:	85 c0                	test   %eax,%eax
 262:	7f dd                	jg     241 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 264:	8b 45 08             	mov    0x8(%ebp),%eax
}
 267:	c9                   	leave  
 268:	c3                   	ret    

00000269 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 269:	b8 01 00 00 00       	mov    $0x1,%eax
 26e:	cd 40                	int    $0x40
 270:	c3                   	ret    

00000271 <exit>:
SYSCALL(exit)
 271:	b8 02 00 00 00       	mov    $0x2,%eax
 276:	cd 40                	int    $0x40
 278:	c3                   	ret    

00000279 <wait>:
SYSCALL(wait)
 279:	b8 03 00 00 00       	mov    $0x3,%eax
 27e:	cd 40                	int    $0x40
 280:	c3                   	ret    

00000281 <pipe>:
SYSCALL(pipe)
 281:	b8 04 00 00 00       	mov    $0x4,%eax
 286:	cd 40                	int    $0x40
 288:	c3                   	ret    

00000289 <read>:
SYSCALL(read)
 289:	b8 05 00 00 00       	mov    $0x5,%eax
 28e:	cd 40                	int    $0x40
 290:	c3                   	ret    

00000291 <write>:
SYSCALL(write)
 291:	b8 10 00 00 00       	mov    $0x10,%eax
 296:	cd 40                	int    $0x40
 298:	c3                   	ret    

00000299 <close>:
SYSCALL(close)
 299:	b8 15 00 00 00       	mov    $0x15,%eax
 29e:	cd 40                	int    $0x40
 2a0:	c3                   	ret    

000002a1 <kill>:
SYSCALL(kill)
 2a1:	b8 06 00 00 00       	mov    $0x6,%eax
 2a6:	cd 40                	int    $0x40
 2a8:	c3                   	ret    

000002a9 <exec>:
SYSCALL(exec)
 2a9:	b8 07 00 00 00       	mov    $0x7,%eax
 2ae:	cd 40                	int    $0x40
 2b0:	c3                   	ret    

000002b1 <open>:
SYSCALL(open)
 2b1:	b8 0f 00 00 00       	mov    $0xf,%eax
 2b6:	cd 40                	int    $0x40
 2b8:	c3                   	ret    

000002b9 <mknod>:
SYSCALL(mknod)
 2b9:	b8 11 00 00 00       	mov    $0x11,%eax
 2be:	cd 40                	int    $0x40
 2c0:	c3                   	ret    

000002c1 <unlink>:
SYSCALL(unlink)
 2c1:	b8 12 00 00 00       	mov    $0x12,%eax
 2c6:	cd 40                	int    $0x40
 2c8:	c3                   	ret    

000002c9 <fstat>:
SYSCALL(fstat)
 2c9:	b8 08 00 00 00       	mov    $0x8,%eax
 2ce:	cd 40                	int    $0x40
 2d0:	c3                   	ret    

000002d1 <link>:
SYSCALL(link)
 2d1:	b8 13 00 00 00       	mov    $0x13,%eax
 2d6:	cd 40                	int    $0x40
 2d8:	c3                   	ret    

000002d9 <mkdir>:
SYSCALL(mkdir)
 2d9:	b8 14 00 00 00       	mov    $0x14,%eax
 2de:	cd 40                	int    $0x40
 2e0:	c3                   	ret    

000002e1 <chdir>:
SYSCALL(chdir)
 2e1:	b8 09 00 00 00       	mov    $0x9,%eax
 2e6:	cd 40                	int    $0x40
 2e8:	c3                   	ret    

000002e9 <dup>:
SYSCALL(dup)
 2e9:	b8 0a 00 00 00       	mov    $0xa,%eax
 2ee:	cd 40                	int    $0x40
 2f0:	c3                   	ret    

000002f1 <getpid>:
SYSCALL(getpid)
 2f1:	b8 0b 00 00 00       	mov    $0xb,%eax
 2f6:	cd 40                	int    $0x40
 2f8:	c3                   	ret    

000002f9 <sbrk>:
SYSCALL(sbrk)
 2f9:	b8 0c 00 00 00       	mov    $0xc,%eax
 2fe:	cd 40                	int    $0x40
 300:	c3                   	ret    

00000301 <sleep>:
SYSCALL(sleep)
 301:	b8 0d 00 00 00       	mov    $0xd,%eax
 306:	cd 40                	int    $0x40
 308:	c3                   	ret    

00000309 <uptime>:
SYSCALL(uptime)
 309:	b8 0e 00 00 00       	mov    $0xe,%eax
 30e:	cd 40                	int    $0x40
 310:	c3                   	ret    

00000311 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 311:	55                   	push   %ebp
 312:	89 e5                	mov    %esp,%ebp
 314:	83 ec 18             	sub    $0x18,%esp
 317:	8b 45 0c             	mov    0xc(%ebp),%eax
 31a:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 31d:	83 ec 04             	sub    $0x4,%esp
 320:	6a 01                	push   $0x1
 322:	8d 45 f4             	lea    -0xc(%ebp),%eax
 325:	50                   	push   %eax
 326:	ff 75 08             	pushl  0x8(%ebp)
 329:	e8 63 ff ff ff       	call   291 <write>
 32e:	83 c4 10             	add    $0x10,%esp
}
 331:	c9                   	leave  
 332:	c3                   	ret    

00000333 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 333:	55                   	push   %ebp
 334:	89 e5                	mov    %esp,%ebp
 336:	53                   	push   %ebx
 337:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 33a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 341:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 345:	74 17                	je     35e <printint+0x2b>
 347:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 34b:	79 11                	jns    35e <printint+0x2b>
    neg = 1;
 34d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 354:	8b 45 0c             	mov    0xc(%ebp),%eax
 357:	f7 d8                	neg    %eax
 359:	89 45 ec             	mov    %eax,-0x14(%ebp)
 35c:	eb 06                	jmp    364 <printint+0x31>
  } else {
    x = xx;
 35e:	8b 45 0c             	mov    0xc(%ebp),%eax
 361:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 364:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 36b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 36e:	8d 41 01             	lea    0x1(%ecx),%eax
 371:	89 45 f4             	mov    %eax,-0xc(%ebp)
 374:	8b 5d 10             	mov    0x10(%ebp),%ebx
 377:	8b 45 ec             	mov    -0x14(%ebp),%eax
 37a:	ba 00 00 00 00       	mov    $0x0,%edx
 37f:	f7 f3                	div    %ebx
 381:	89 d0                	mov    %edx,%eax
 383:	8a 80 e8 09 00 00    	mov    0x9e8(%eax),%al
 389:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 38d:	8b 5d 10             	mov    0x10(%ebp),%ebx
 390:	8b 45 ec             	mov    -0x14(%ebp),%eax
 393:	ba 00 00 00 00       	mov    $0x0,%edx
 398:	f7 f3                	div    %ebx
 39a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 39d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3a1:	75 c8                	jne    36b <printint+0x38>
  if(neg)
 3a3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3a7:	74 0e                	je     3b7 <printint+0x84>
    buf[i++] = '-';
 3a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3ac:	8d 50 01             	lea    0x1(%eax),%edx
 3af:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3b2:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3b7:	eb 1c                	jmp    3d5 <printint+0xa2>
    putc(fd, buf[i]);
 3b9:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3bf:	01 d0                	add    %edx,%eax
 3c1:	8a 00                	mov    (%eax),%al
 3c3:	0f be c0             	movsbl %al,%eax
 3c6:	83 ec 08             	sub    $0x8,%esp
 3c9:	50                   	push   %eax
 3ca:	ff 75 08             	pushl  0x8(%ebp)
 3cd:	e8 3f ff ff ff       	call   311 <putc>
 3d2:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3d5:	ff 4d f4             	decl   -0xc(%ebp)
 3d8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 3dc:	79 db                	jns    3b9 <printint+0x86>
    putc(fd, buf[i]);
}
 3de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3e1:	c9                   	leave  
 3e2:	c3                   	ret    

000003e3 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3e3:	55                   	push   %ebp
 3e4:	89 e5                	mov    %esp,%ebp
 3e6:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 3e9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 3f0:	8d 45 0c             	lea    0xc(%ebp),%eax
 3f3:	83 c0 04             	add    $0x4,%eax
 3f6:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 3f9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 400:	e9 54 01 00 00       	jmp    559 <printf+0x176>
    c = fmt[i] & 0xff;
 405:	8b 55 0c             	mov    0xc(%ebp),%edx
 408:	8b 45 f0             	mov    -0x10(%ebp),%eax
 40b:	01 d0                	add    %edx,%eax
 40d:	8a 00                	mov    (%eax),%al
 40f:	0f be c0             	movsbl %al,%eax
 412:	25 ff 00 00 00       	and    $0xff,%eax
 417:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 41a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 41e:	75 2c                	jne    44c <printf+0x69>
      if(c == '%'){
 420:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 424:	75 0c                	jne    432 <printf+0x4f>
        state = '%';
 426:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 42d:	e9 24 01 00 00       	jmp    556 <printf+0x173>
      } else {
        putc(fd, c);
 432:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 435:	0f be c0             	movsbl %al,%eax
 438:	83 ec 08             	sub    $0x8,%esp
 43b:	50                   	push   %eax
 43c:	ff 75 08             	pushl  0x8(%ebp)
 43f:	e8 cd fe ff ff       	call   311 <putc>
 444:	83 c4 10             	add    $0x10,%esp
 447:	e9 0a 01 00 00       	jmp    556 <printf+0x173>
      }
    } else if(state == '%'){
 44c:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 450:	0f 85 00 01 00 00    	jne    556 <printf+0x173>
      if(c == 'd'){
 456:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 45a:	75 1e                	jne    47a <printf+0x97>
        printint(fd, *ap, 10, 1);
 45c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 45f:	8b 00                	mov    (%eax),%eax
 461:	6a 01                	push   $0x1
 463:	6a 0a                	push   $0xa
 465:	50                   	push   %eax
 466:	ff 75 08             	pushl  0x8(%ebp)
 469:	e8 c5 fe ff ff       	call   333 <printint>
 46e:	83 c4 10             	add    $0x10,%esp
        ap++;
 471:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 475:	e9 d5 00 00 00       	jmp    54f <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
 47a:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 47e:	74 06                	je     486 <printf+0xa3>
 480:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 484:	75 1e                	jne    4a4 <printf+0xc1>
        printint(fd, *ap, 16, 0);
 486:	8b 45 e8             	mov    -0x18(%ebp),%eax
 489:	8b 00                	mov    (%eax),%eax
 48b:	6a 00                	push   $0x0
 48d:	6a 10                	push   $0x10
 48f:	50                   	push   %eax
 490:	ff 75 08             	pushl  0x8(%ebp)
 493:	e8 9b fe ff ff       	call   333 <printint>
 498:	83 c4 10             	add    $0x10,%esp
        ap++;
 49b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 49f:	e9 ab 00 00 00       	jmp    54f <printf+0x16c>
      } else if(c == 's'){
 4a4:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4a8:	75 40                	jne    4ea <printf+0x107>
        s = (char*)*ap;
 4aa:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ad:	8b 00                	mov    (%eax),%eax
 4af:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4b2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4b6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4ba:	75 07                	jne    4c3 <printf+0xe0>
          s = "(null)";
 4bc:	c7 45 f4 8f 07 00 00 	movl   $0x78f,-0xc(%ebp)
        while(*s != 0){
 4c3:	eb 1a                	jmp    4df <printf+0xfc>
          putc(fd, *s);
 4c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4c8:	8a 00                	mov    (%eax),%al
 4ca:	0f be c0             	movsbl %al,%eax
 4cd:	83 ec 08             	sub    $0x8,%esp
 4d0:	50                   	push   %eax
 4d1:	ff 75 08             	pushl  0x8(%ebp)
 4d4:	e8 38 fe ff ff       	call   311 <putc>
 4d9:	83 c4 10             	add    $0x10,%esp
          s++;
 4dc:	ff 45 f4             	incl   -0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4e2:	8a 00                	mov    (%eax),%al
 4e4:	84 c0                	test   %al,%al
 4e6:	75 dd                	jne    4c5 <printf+0xe2>
 4e8:	eb 65                	jmp    54f <printf+0x16c>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4ea:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 4ee:	75 1d                	jne    50d <printf+0x12a>
        putc(fd, *ap);
 4f0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4f3:	8b 00                	mov    (%eax),%eax
 4f5:	0f be c0             	movsbl %al,%eax
 4f8:	83 ec 08             	sub    $0x8,%esp
 4fb:	50                   	push   %eax
 4fc:	ff 75 08             	pushl  0x8(%ebp)
 4ff:	e8 0d fe ff ff       	call   311 <putc>
 504:	83 c4 10             	add    $0x10,%esp
        ap++;
 507:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 50b:	eb 42                	jmp    54f <printf+0x16c>
      } else if(c == '%'){
 50d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 511:	75 17                	jne    52a <printf+0x147>
        putc(fd, c);
 513:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 516:	0f be c0             	movsbl %al,%eax
 519:	83 ec 08             	sub    $0x8,%esp
 51c:	50                   	push   %eax
 51d:	ff 75 08             	pushl  0x8(%ebp)
 520:	e8 ec fd ff ff       	call   311 <putc>
 525:	83 c4 10             	add    $0x10,%esp
 528:	eb 25                	jmp    54f <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 52a:	83 ec 08             	sub    $0x8,%esp
 52d:	6a 25                	push   $0x25
 52f:	ff 75 08             	pushl  0x8(%ebp)
 532:	e8 da fd ff ff       	call   311 <putc>
 537:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 53a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 53d:	0f be c0             	movsbl %al,%eax
 540:	83 ec 08             	sub    $0x8,%esp
 543:	50                   	push   %eax
 544:	ff 75 08             	pushl  0x8(%ebp)
 547:	e8 c5 fd ff ff       	call   311 <putc>
 54c:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 54f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 556:	ff 45 f0             	incl   -0x10(%ebp)
 559:	8b 55 0c             	mov    0xc(%ebp),%edx
 55c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 55f:	01 d0                	add    %edx,%eax
 561:	8a 00                	mov    (%eax),%al
 563:	84 c0                	test   %al,%al
 565:	0f 85 9a fe ff ff    	jne    405 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 56b:	c9                   	leave  
 56c:	c3                   	ret    

0000056d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 56d:	55                   	push   %ebp
 56e:	89 e5                	mov    %esp,%ebp
 570:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 573:	8b 45 08             	mov    0x8(%ebp),%eax
 576:	83 e8 08             	sub    $0x8,%eax
 579:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 57c:	a1 04 0a 00 00       	mov    0xa04,%eax
 581:	89 45 fc             	mov    %eax,-0x4(%ebp)
 584:	eb 24                	jmp    5aa <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 586:	8b 45 fc             	mov    -0x4(%ebp),%eax
 589:	8b 00                	mov    (%eax),%eax
 58b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 58e:	77 12                	ja     5a2 <free+0x35>
 590:	8b 45 f8             	mov    -0x8(%ebp),%eax
 593:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 596:	77 24                	ja     5bc <free+0x4f>
 598:	8b 45 fc             	mov    -0x4(%ebp),%eax
 59b:	8b 00                	mov    (%eax),%eax
 59d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5a0:	77 1a                	ja     5bc <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5a5:	8b 00                	mov    (%eax),%eax
 5a7:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5ad:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5b0:	76 d4                	jbe    586 <free+0x19>
 5b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5b5:	8b 00                	mov    (%eax),%eax
 5b7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5ba:	76 ca                	jbe    586 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5bf:	8b 40 04             	mov    0x4(%eax),%eax
 5c2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 5c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5cc:	01 c2                	add    %eax,%edx
 5ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5d1:	8b 00                	mov    (%eax),%eax
 5d3:	39 c2                	cmp    %eax,%edx
 5d5:	75 24                	jne    5fb <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 5d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5da:	8b 50 04             	mov    0x4(%eax),%edx
 5dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e0:	8b 00                	mov    (%eax),%eax
 5e2:	8b 40 04             	mov    0x4(%eax),%eax
 5e5:	01 c2                	add    %eax,%edx
 5e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5ea:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 5ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f0:	8b 00                	mov    (%eax),%eax
 5f2:	8b 10                	mov    (%eax),%edx
 5f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f7:	89 10                	mov    %edx,(%eax)
 5f9:	eb 0a                	jmp    605 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 5fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5fe:	8b 10                	mov    (%eax),%edx
 600:	8b 45 f8             	mov    -0x8(%ebp),%eax
 603:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 605:	8b 45 fc             	mov    -0x4(%ebp),%eax
 608:	8b 40 04             	mov    0x4(%eax),%eax
 60b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 612:	8b 45 fc             	mov    -0x4(%ebp),%eax
 615:	01 d0                	add    %edx,%eax
 617:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 61a:	75 20                	jne    63c <free+0xcf>
    p->s.size += bp->s.size;
 61c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 61f:	8b 50 04             	mov    0x4(%eax),%edx
 622:	8b 45 f8             	mov    -0x8(%ebp),%eax
 625:	8b 40 04             	mov    0x4(%eax),%eax
 628:	01 c2                	add    %eax,%edx
 62a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62d:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 630:	8b 45 f8             	mov    -0x8(%ebp),%eax
 633:	8b 10                	mov    (%eax),%edx
 635:	8b 45 fc             	mov    -0x4(%ebp),%eax
 638:	89 10                	mov    %edx,(%eax)
 63a:	eb 08                	jmp    644 <free+0xd7>
  } else
    p->s.ptr = bp;
 63c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 642:	89 10                	mov    %edx,(%eax)
  freep = p;
 644:	8b 45 fc             	mov    -0x4(%ebp),%eax
 647:	a3 04 0a 00 00       	mov    %eax,0xa04
}
 64c:	c9                   	leave  
 64d:	c3                   	ret    

0000064e <morecore>:

static Header*
morecore(uint nu)
{
 64e:	55                   	push   %ebp
 64f:	89 e5                	mov    %esp,%ebp
 651:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 654:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 65b:	77 07                	ja     664 <morecore+0x16>
    nu = 4096;
 65d:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 664:	8b 45 08             	mov    0x8(%ebp),%eax
 667:	c1 e0 03             	shl    $0x3,%eax
 66a:	83 ec 0c             	sub    $0xc,%esp
 66d:	50                   	push   %eax
 66e:	e8 86 fc ff ff       	call   2f9 <sbrk>
 673:	83 c4 10             	add    $0x10,%esp
 676:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 679:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 67d:	75 07                	jne    686 <morecore+0x38>
    return 0;
 67f:	b8 00 00 00 00       	mov    $0x0,%eax
 684:	eb 26                	jmp    6ac <morecore+0x5e>
  hp = (Header*)p;
 686:	8b 45 f4             	mov    -0xc(%ebp),%eax
 689:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 68c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 68f:	8b 55 08             	mov    0x8(%ebp),%edx
 692:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 695:	8b 45 f0             	mov    -0x10(%ebp),%eax
 698:	83 c0 08             	add    $0x8,%eax
 69b:	83 ec 0c             	sub    $0xc,%esp
 69e:	50                   	push   %eax
 69f:	e8 c9 fe ff ff       	call   56d <free>
 6a4:	83 c4 10             	add    $0x10,%esp
  return freep;
 6a7:	a1 04 0a 00 00       	mov    0xa04,%eax
}
 6ac:	c9                   	leave  
 6ad:	c3                   	ret    

000006ae <malloc>:

void*
malloc(uint nbytes)
{
 6ae:	55                   	push   %ebp
 6af:	89 e5                	mov    %esp,%ebp
 6b1:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6b4:	8b 45 08             	mov    0x8(%ebp),%eax
 6b7:	83 c0 07             	add    $0x7,%eax
 6ba:	c1 e8 03             	shr    $0x3,%eax
 6bd:	40                   	inc    %eax
 6be:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 6c1:	a1 04 0a 00 00       	mov    0xa04,%eax
 6c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
 6c9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6cd:	75 23                	jne    6f2 <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
 6cf:	c7 45 f0 fc 09 00 00 	movl   $0x9fc,-0x10(%ebp)
 6d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6d9:	a3 04 0a 00 00       	mov    %eax,0xa04
 6de:	a1 04 0a 00 00       	mov    0xa04,%eax
 6e3:	a3 fc 09 00 00       	mov    %eax,0x9fc
    base.s.size = 0;
 6e8:	c7 05 00 0a 00 00 00 	movl   $0x0,0xa00
 6ef:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f5:	8b 00                	mov    (%eax),%eax
 6f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 6fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6fd:	8b 40 04             	mov    0x4(%eax),%eax
 700:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 703:	72 4d                	jb     752 <malloc+0xa4>
      if(p->s.size == nunits)
 705:	8b 45 f4             	mov    -0xc(%ebp),%eax
 708:	8b 40 04             	mov    0x4(%eax),%eax
 70b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 70e:	75 0c                	jne    71c <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
 710:	8b 45 f4             	mov    -0xc(%ebp),%eax
 713:	8b 10                	mov    (%eax),%edx
 715:	8b 45 f0             	mov    -0x10(%ebp),%eax
 718:	89 10                	mov    %edx,(%eax)
 71a:	eb 26                	jmp    742 <malloc+0x94>
      else {
        p->s.size -= nunits;
 71c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 71f:	8b 40 04             	mov    0x4(%eax),%eax
 722:	2b 45 ec             	sub    -0x14(%ebp),%eax
 725:	89 c2                	mov    %eax,%edx
 727:	8b 45 f4             	mov    -0xc(%ebp),%eax
 72a:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 72d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 730:	8b 40 04             	mov    0x4(%eax),%eax
 733:	c1 e0 03             	shl    $0x3,%eax
 736:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 739:	8b 45 f4             	mov    -0xc(%ebp),%eax
 73c:	8b 55 ec             	mov    -0x14(%ebp),%edx
 73f:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 742:	8b 45 f0             	mov    -0x10(%ebp),%eax
 745:	a3 04 0a 00 00       	mov    %eax,0xa04
      return (void*)(p + 1);
 74a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 74d:	83 c0 08             	add    $0x8,%eax
 750:	eb 3b                	jmp    78d <malloc+0xdf>
    }
    if(p == freep)
 752:	a1 04 0a 00 00       	mov    0xa04,%eax
 757:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 75a:	75 1e                	jne    77a <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
 75c:	83 ec 0c             	sub    $0xc,%esp
 75f:	ff 75 ec             	pushl  -0x14(%ebp)
 762:	e8 e7 fe ff ff       	call   64e <morecore>
 767:	83 c4 10             	add    $0x10,%esp
 76a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 76d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 771:	75 07                	jne    77a <malloc+0xcc>
        return 0;
 773:	b8 00 00 00 00       	mov    $0x0,%eax
 778:	eb 13                	jmp    78d <malloc+0xdf>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 77a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 780:	8b 45 f4             	mov    -0xc(%ebp),%eax
 783:	8b 00                	mov    (%eax),%eax
 785:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 788:	e9 6d ff ff ff       	jmp    6fa <malloc+0x4c>
}
 78d:	c9                   	leave  
 78e:	c3                   	ret    
