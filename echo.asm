
_echo:     file format elf32-i386


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
   f:	83 ec 10             	sub    $0x10,%esp
  12:	89 cb                	mov    %ecx,%ebx
  int i;

  for(i = 1; i < argc; i++)
  14:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  1b:	eb 39                	jmp    56 <main+0x56>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  20:	40                   	inc    %eax
  21:	3b 03                	cmp    (%ebx),%eax
  23:	7d 07                	jge    2c <main+0x2c>
  25:	b8 be 07 00 00       	mov    $0x7be,%eax
  2a:	eb 05                	jmp    31 <main+0x31>
  2c:	b8 c0 07 00 00       	mov    $0x7c0,%eax
  31:	8b 55 f4             	mov    -0xc(%ebp),%edx
  34:	8d 0c 95 00 00 00 00 	lea    0x0(,%edx,4),%ecx
  3b:	8b 53 04             	mov    0x4(%ebx),%edx
  3e:	01 ca                	add    %ecx,%edx
  40:	8b 12                	mov    (%edx),%edx
  42:	50                   	push   %eax
  43:	52                   	push   %edx
  44:	68 c2 07 00 00       	push   $0x7c2
  49:	6a 01                	push   $0x1
  4b:	e8 c2 03 00 00       	call   412 <printf>
  50:	83 c4 10             	add    $0x10,%esp
int
main(int argc, char *argv[])
{
  int i;

  for(i = 1; i < argc; i++)
  53:	ff 45 f4             	incl   -0xc(%ebp)
  56:	8b 45 f4             	mov    -0xc(%ebp),%eax
  59:	3b 03                	cmp    (%ebx),%eax
  5b:	7c c0                	jl     1d <main+0x1d>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  exit();
  5d:	e8 3e 02 00 00       	call   2a0 <exit>

00000062 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  62:	55                   	push   %ebp
  63:	89 e5                	mov    %esp,%ebp
  65:	57                   	push   %edi
  66:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  67:	8b 4d 08             	mov    0x8(%ebp),%ecx
  6a:	8b 55 10             	mov    0x10(%ebp),%edx
  6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  70:	89 cb                	mov    %ecx,%ebx
  72:	89 df                	mov    %ebx,%edi
  74:	89 d1                	mov    %edx,%ecx
  76:	fc                   	cld    
  77:	f3 aa                	rep stos %al,%es:(%edi)
  79:	89 ca                	mov    %ecx,%edx
  7b:	89 fb                	mov    %edi,%ebx
  7d:	89 5d 08             	mov    %ebx,0x8(%ebp)
  80:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  83:	5b                   	pop    %ebx
  84:	5f                   	pop    %edi
  85:	5d                   	pop    %ebp
  86:	c3                   	ret    

00000087 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  87:	55                   	push   %ebp
  88:	89 e5                	mov    %esp,%ebp
  8a:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  8d:	8b 45 08             	mov    0x8(%ebp),%eax
  90:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  93:	90                   	nop
  94:	8b 45 08             	mov    0x8(%ebp),%eax
  97:	8d 50 01             	lea    0x1(%eax),%edx
  9a:	89 55 08             	mov    %edx,0x8(%ebp)
  9d:	8b 55 0c             	mov    0xc(%ebp),%edx
  a0:	8d 4a 01             	lea    0x1(%edx),%ecx
  a3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  a6:	8a 12                	mov    (%edx),%dl
  a8:	88 10                	mov    %dl,(%eax)
  aa:	8a 00                	mov    (%eax),%al
  ac:	84 c0                	test   %al,%al
  ae:	75 e4                	jne    94 <strcpy+0xd>
    ;
  return os;
  b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  b3:	c9                   	leave  
  b4:	c3                   	ret    

000000b5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b5:	55                   	push   %ebp
  b6:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  b8:	eb 06                	jmp    c0 <strcmp+0xb>
    p++, q++;
  ba:	ff 45 08             	incl   0x8(%ebp)
  bd:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  c0:	8b 45 08             	mov    0x8(%ebp),%eax
  c3:	8a 00                	mov    (%eax),%al
  c5:	84 c0                	test   %al,%al
  c7:	74 0e                	je     d7 <strcmp+0x22>
  c9:	8b 45 08             	mov    0x8(%ebp),%eax
  cc:	8a 10                	mov    (%eax),%dl
  ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  d1:	8a 00                	mov    (%eax),%al
  d3:	38 c2                	cmp    %al,%dl
  d5:	74 e3                	je     ba <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  d7:	8b 45 08             	mov    0x8(%ebp),%eax
  da:	8a 00                	mov    (%eax),%al
  dc:	0f b6 d0             	movzbl %al,%edx
  df:	8b 45 0c             	mov    0xc(%ebp),%eax
  e2:	8a 00                	mov    (%eax),%al
  e4:	0f b6 c0             	movzbl %al,%eax
  e7:	29 c2                	sub    %eax,%edx
  e9:	89 d0                	mov    %edx,%eax
}
  eb:	5d                   	pop    %ebp
  ec:	c3                   	ret    

000000ed <strlen>:

uint
strlen(char *s)
{
  ed:	55                   	push   %ebp
  ee:	89 e5                	mov    %esp,%ebp
  f0:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  fa:	eb 03                	jmp    ff <strlen+0x12>
  fc:	ff 45 fc             	incl   -0x4(%ebp)
  ff:	8b 55 fc             	mov    -0x4(%ebp),%edx
 102:	8b 45 08             	mov    0x8(%ebp),%eax
 105:	01 d0                	add    %edx,%eax
 107:	8a 00                	mov    (%eax),%al
 109:	84 c0                	test   %al,%al
 10b:	75 ef                	jne    fc <strlen+0xf>
    ;
  return n;
 10d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 110:	c9                   	leave  
 111:	c3                   	ret    

00000112 <memset>:

void*
memset(void *dst, int c, uint n)
{
 112:	55                   	push   %ebp
 113:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 115:	8b 45 10             	mov    0x10(%ebp),%eax
 118:	50                   	push   %eax
 119:	ff 75 0c             	pushl  0xc(%ebp)
 11c:	ff 75 08             	pushl  0x8(%ebp)
 11f:	e8 3e ff ff ff       	call   62 <stosb>
 124:	83 c4 0c             	add    $0xc,%esp
  return dst;
 127:	8b 45 08             	mov    0x8(%ebp),%eax
}
 12a:	c9                   	leave  
 12b:	c3                   	ret    

0000012c <strchr>:

char*
strchr(const char *s, char c)
{
 12c:	55                   	push   %ebp
 12d:	89 e5                	mov    %esp,%ebp
 12f:	83 ec 04             	sub    $0x4,%esp
 132:	8b 45 0c             	mov    0xc(%ebp),%eax
 135:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 138:	eb 12                	jmp    14c <strchr+0x20>
    if(*s == c)
 13a:	8b 45 08             	mov    0x8(%ebp),%eax
 13d:	8a 00                	mov    (%eax),%al
 13f:	3a 45 fc             	cmp    -0x4(%ebp),%al
 142:	75 05                	jne    149 <strchr+0x1d>
      return (char*)s;
 144:	8b 45 08             	mov    0x8(%ebp),%eax
 147:	eb 11                	jmp    15a <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 149:	ff 45 08             	incl   0x8(%ebp)
 14c:	8b 45 08             	mov    0x8(%ebp),%eax
 14f:	8a 00                	mov    (%eax),%al
 151:	84 c0                	test   %al,%al
 153:	75 e5                	jne    13a <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 155:	b8 00 00 00 00       	mov    $0x0,%eax
}
 15a:	c9                   	leave  
 15b:	c3                   	ret    

0000015c <gets>:

char*
gets(char *buf, int max)
{
 15c:	55                   	push   %ebp
 15d:	89 e5                	mov    %esp,%ebp
 15f:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 162:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 169:	eb 41                	jmp    1ac <gets+0x50>
    cc = read(0, &c, 1);
 16b:	83 ec 04             	sub    $0x4,%esp
 16e:	6a 01                	push   $0x1
 170:	8d 45 ef             	lea    -0x11(%ebp),%eax
 173:	50                   	push   %eax
 174:	6a 00                	push   $0x0
 176:	e8 3d 01 00 00       	call   2b8 <read>
 17b:	83 c4 10             	add    $0x10,%esp
 17e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 181:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 185:	7f 02                	jg     189 <gets+0x2d>
      break;
 187:	eb 2c                	jmp    1b5 <gets+0x59>
    buf[i++] = c;
 189:	8b 45 f4             	mov    -0xc(%ebp),%eax
 18c:	8d 50 01             	lea    0x1(%eax),%edx
 18f:	89 55 f4             	mov    %edx,-0xc(%ebp)
 192:	89 c2                	mov    %eax,%edx
 194:	8b 45 08             	mov    0x8(%ebp),%eax
 197:	01 c2                	add    %eax,%edx
 199:	8a 45 ef             	mov    -0x11(%ebp),%al
 19c:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 19e:	8a 45 ef             	mov    -0x11(%ebp),%al
 1a1:	3c 0a                	cmp    $0xa,%al
 1a3:	74 10                	je     1b5 <gets+0x59>
 1a5:	8a 45 ef             	mov    -0x11(%ebp),%al
 1a8:	3c 0d                	cmp    $0xd,%al
 1aa:	74 09                	je     1b5 <gets+0x59>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1af:	40                   	inc    %eax
 1b0:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1b3:	7c b6                	jl     16b <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1b8:	8b 45 08             	mov    0x8(%ebp),%eax
 1bb:	01 d0                	add    %edx,%eax
 1bd:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1c0:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1c3:	c9                   	leave  
 1c4:	c3                   	ret    

000001c5 <stat>:

int
stat(char *n, struct stat *st)
{
 1c5:	55                   	push   %ebp
 1c6:	89 e5                	mov    %esp,%ebp
 1c8:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1cb:	83 ec 08             	sub    $0x8,%esp
 1ce:	6a 00                	push   $0x0
 1d0:	ff 75 08             	pushl  0x8(%ebp)
 1d3:	e8 08 01 00 00       	call   2e0 <open>
 1d8:	83 c4 10             	add    $0x10,%esp
 1db:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1e2:	79 07                	jns    1eb <stat+0x26>
    return -1;
 1e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1e9:	eb 25                	jmp    210 <stat+0x4b>
  r = fstat(fd, st);
 1eb:	83 ec 08             	sub    $0x8,%esp
 1ee:	ff 75 0c             	pushl  0xc(%ebp)
 1f1:	ff 75 f4             	pushl  -0xc(%ebp)
 1f4:	e8 ff 00 00 00       	call   2f8 <fstat>
 1f9:	83 c4 10             	add    $0x10,%esp
 1fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1ff:	83 ec 0c             	sub    $0xc,%esp
 202:	ff 75 f4             	pushl  -0xc(%ebp)
 205:	e8 be 00 00 00       	call   2c8 <close>
 20a:	83 c4 10             	add    $0x10,%esp
  return r;
 20d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 210:	c9                   	leave  
 211:	c3                   	ret    

00000212 <atoi>:

int
atoi(const char *s)
{
 212:	55                   	push   %ebp
 213:	89 e5                	mov    %esp,%ebp
 215:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 218:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 21f:	eb 24                	jmp    245 <atoi+0x33>
    n = n*10 + *s++ - '0';
 221:	8b 55 fc             	mov    -0x4(%ebp),%edx
 224:	89 d0                	mov    %edx,%eax
 226:	c1 e0 02             	shl    $0x2,%eax
 229:	01 d0                	add    %edx,%eax
 22b:	01 c0                	add    %eax,%eax
 22d:	89 c1                	mov    %eax,%ecx
 22f:	8b 45 08             	mov    0x8(%ebp),%eax
 232:	8d 50 01             	lea    0x1(%eax),%edx
 235:	89 55 08             	mov    %edx,0x8(%ebp)
 238:	8a 00                	mov    (%eax),%al
 23a:	0f be c0             	movsbl %al,%eax
 23d:	01 c8                	add    %ecx,%eax
 23f:	83 e8 30             	sub    $0x30,%eax
 242:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 245:	8b 45 08             	mov    0x8(%ebp),%eax
 248:	8a 00                	mov    (%eax),%al
 24a:	3c 2f                	cmp    $0x2f,%al
 24c:	7e 09                	jle    257 <atoi+0x45>
 24e:	8b 45 08             	mov    0x8(%ebp),%eax
 251:	8a 00                	mov    (%eax),%al
 253:	3c 39                	cmp    $0x39,%al
 255:	7e ca                	jle    221 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 257:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 25a:	c9                   	leave  
 25b:	c3                   	ret    

0000025c <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 25c:	55                   	push   %ebp
 25d:	89 e5                	mov    %esp,%ebp
 25f:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 262:	8b 45 08             	mov    0x8(%ebp),%eax
 265:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 268:	8b 45 0c             	mov    0xc(%ebp),%eax
 26b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 26e:	eb 16                	jmp    286 <memmove+0x2a>
    *dst++ = *src++;
 270:	8b 45 fc             	mov    -0x4(%ebp),%eax
 273:	8d 50 01             	lea    0x1(%eax),%edx
 276:	89 55 fc             	mov    %edx,-0x4(%ebp)
 279:	8b 55 f8             	mov    -0x8(%ebp),%edx
 27c:	8d 4a 01             	lea    0x1(%edx),%ecx
 27f:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 282:	8a 12                	mov    (%edx),%dl
 284:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 286:	8b 45 10             	mov    0x10(%ebp),%eax
 289:	8d 50 ff             	lea    -0x1(%eax),%edx
 28c:	89 55 10             	mov    %edx,0x10(%ebp)
 28f:	85 c0                	test   %eax,%eax
 291:	7f dd                	jg     270 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 293:	8b 45 08             	mov    0x8(%ebp),%eax
}
 296:	c9                   	leave  
 297:	c3                   	ret    

00000298 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 298:	b8 01 00 00 00       	mov    $0x1,%eax
 29d:	cd 40                	int    $0x40
 29f:	c3                   	ret    

000002a0 <exit>:
SYSCALL(exit)
 2a0:	b8 02 00 00 00       	mov    $0x2,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <wait>:
SYSCALL(wait)
 2a8:	b8 03 00 00 00       	mov    $0x3,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <pipe>:
SYSCALL(pipe)
 2b0:	b8 04 00 00 00       	mov    $0x4,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <read>:
SYSCALL(read)
 2b8:	b8 05 00 00 00       	mov    $0x5,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <write>:
SYSCALL(write)
 2c0:	b8 10 00 00 00       	mov    $0x10,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <close>:
SYSCALL(close)
 2c8:	b8 15 00 00 00       	mov    $0x15,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <kill>:
SYSCALL(kill)
 2d0:	b8 06 00 00 00       	mov    $0x6,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <exec>:
SYSCALL(exec)
 2d8:	b8 07 00 00 00       	mov    $0x7,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <open>:
SYSCALL(open)
 2e0:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <mknod>:
SYSCALL(mknod)
 2e8:	b8 11 00 00 00       	mov    $0x11,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <unlink>:
SYSCALL(unlink)
 2f0:	b8 12 00 00 00       	mov    $0x12,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <fstat>:
SYSCALL(fstat)
 2f8:	b8 08 00 00 00       	mov    $0x8,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <link>:
SYSCALL(link)
 300:	b8 13 00 00 00       	mov    $0x13,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <mkdir>:
SYSCALL(mkdir)
 308:	b8 14 00 00 00       	mov    $0x14,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <chdir>:
SYSCALL(chdir)
 310:	b8 09 00 00 00       	mov    $0x9,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <dup>:
SYSCALL(dup)
 318:	b8 0a 00 00 00       	mov    $0xa,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <getpid>:
SYSCALL(getpid)
 320:	b8 0b 00 00 00       	mov    $0xb,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <sbrk>:
SYSCALL(sbrk)
 328:	b8 0c 00 00 00       	mov    $0xc,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <sleep>:
SYSCALL(sleep)
 330:	b8 0d 00 00 00       	mov    $0xd,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <uptime>:
SYSCALL(uptime)
 338:	b8 0e 00 00 00       	mov    $0xe,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	83 ec 18             	sub    $0x18,%esp
 346:	8b 45 0c             	mov    0xc(%ebp),%eax
 349:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 34c:	83 ec 04             	sub    $0x4,%esp
 34f:	6a 01                	push   $0x1
 351:	8d 45 f4             	lea    -0xc(%ebp),%eax
 354:	50                   	push   %eax
 355:	ff 75 08             	pushl  0x8(%ebp)
 358:	e8 63 ff ff ff       	call   2c0 <write>
 35d:	83 c4 10             	add    $0x10,%esp
}
 360:	c9                   	leave  
 361:	c3                   	ret    

00000362 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 362:	55                   	push   %ebp
 363:	89 e5                	mov    %esp,%ebp
 365:	53                   	push   %ebx
 366:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 369:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 370:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 374:	74 17                	je     38d <printint+0x2b>
 376:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 37a:	79 11                	jns    38d <printint+0x2b>
    neg = 1;
 37c:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 383:	8b 45 0c             	mov    0xc(%ebp),%eax
 386:	f7 d8                	neg    %eax
 388:	89 45 ec             	mov    %eax,-0x14(%ebp)
 38b:	eb 06                	jmp    393 <printint+0x31>
  } else {
    x = xx;
 38d:	8b 45 0c             	mov    0xc(%ebp),%eax
 390:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 393:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 39a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 39d:	8d 41 01             	lea    0x1(%ecx),%eax
 3a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3a3:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3a9:	ba 00 00 00 00       	mov    $0x0,%edx
 3ae:	f7 f3                	div    %ebx
 3b0:	89 d0                	mov    %edx,%eax
 3b2:	8a 80 1c 0a 00 00    	mov    0xa1c(%eax),%al
 3b8:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3bc:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3c2:	ba 00 00 00 00       	mov    $0x0,%edx
 3c7:	f7 f3                	div    %ebx
 3c9:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3cc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3d0:	75 c8                	jne    39a <printint+0x38>
  if(neg)
 3d2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3d6:	74 0e                	je     3e6 <printint+0x84>
    buf[i++] = '-';
 3d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3db:	8d 50 01             	lea    0x1(%eax),%edx
 3de:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3e1:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3e6:	eb 1c                	jmp    404 <printint+0xa2>
    putc(fd, buf[i]);
 3e8:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3ee:	01 d0                	add    %edx,%eax
 3f0:	8a 00                	mov    (%eax),%al
 3f2:	0f be c0             	movsbl %al,%eax
 3f5:	83 ec 08             	sub    $0x8,%esp
 3f8:	50                   	push   %eax
 3f9:	ff 75 08             	pushl  0x8(%ebp)
 3fc:	e8 3f ff ff ff       	call   340 <putc>
 401:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 404:	ff 4d f4             	decl   -0xc(%ebp)
 407:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 40b:	79 db                	jns    3e8 <printint+0x86>
    putc(fd, buf[i]);
}
 40d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 410:	c9                   	leave  
 411:	c3                   	ret    

00000412 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 412:	55                   	push   %ebp
 413:	89 e5                	mov    %esp,%ebp
 415:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 418:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 41f:	8d 45 0c             	lea    0xc(%ebp),%eax
 422:	83 c0 04             	add    $0x4,%eax
 425:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 428:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 42f:	e9 54 01 00 00       	jmp    588 <printf+0x176>
    c = fmt[i] & 0xff;
 434:	8b 55 0c             	mov    0xc(%ebp),%edx
 437:	8b 45 f0             	mov    -0x10(%ebp),%eax
 43a:	01 d0                	add    %edx,%eax
 43c:	8a 00                	mov    (%eax),%al
 43e:	0f be c0             	movsbl %al,%eax
 441:	25 ff 00 00 00       	and    $0xff,%eax
 446:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 449:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 44d:	75 2c                	jne    47b <printf+0x69>
      if(c == '%'){
 44f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 453:	75 0c                	jne    461 <printf+0x4f>
        state = '%';
 455:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 45c:	e9 24 01 00 00       	jmp    585 <printf+0x173>
      } else {
        putc(fd, c);
 461:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 464:	0f be c0             	movsbl %al,%eax
 467:	83 ec 08             	sub    $0x8,%esp
 46a:	50                   	push   %eax
 46b:	ff 75 08             	pushl  0x8(%ebp)
 46e:	e8 cd fe ff ff       	call   340 <putc>
 473:	83 c4 10             	add    $0x10,%esp
 476:	e9 0a 01 00 00       	jmp    585 <printf+0x173>
      }
    } else if(state == '%'){
 47b:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 47f:	0f 85 00 01 00 00    	jne    585 <printf+0x173>
      if(c == 'd'){
 485:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 489:	75 1e                	jne    4a9 <printf+0x97>
        printint(fd, *ap, 10, 1);
 48b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 48e:	8b 00                	mov    (%eax),%eax
 490:	6a 01                	push   $0x1
 492:	6a 0a                	push   $0xa
 494:	50                   	push   %eax
 495:	ff 75 08             	pushl  0x8(%ebp)
 498:	e8 c5 fe ff ff       	call   362 <printint>
 49d:	83 c4 10             	add    $0x10,%esp
        ap++;
 4a0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4a4:	e9 d5 00 00 00       	jmp    57e <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
 4a9:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4ad:	74 06                	je     4b5 <printf+0xa3>
 4af:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4b3:	75 1e                	jne    4d3 <printf+0xc1>
        printint(fd, *ap, 16, 0);
 4b5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4b8:	8b 00                	mov    (%eax),%eax
 4ba:	6a 00                	push   $0x0
 4bc:	6a 10                	push   $0x10
 4be:	50                   	push   %eax
 4bf:	ff 75 08             	pushl  0x8(%ebp)
 4c2:	e8 9b fe ff ff       	call   362 <printint>
 4c7:	83 c4 10             	add    $0x10,%esp
        ap++;
 4ca:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4ce:	e9 ab 00 00 00       	jmp    57e <printf+0x16c>
      } else if(c == 's'){
 4d3:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4d7:	75 40                	jne    519 <printf+0x107>
        s = (char*)*ap;
 4d9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4dc:	8b 00                	mov    (%eax),%eax
 4de:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4e1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4e5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4e9:	75 07                	jne    4f2 <printf+0xe0>
          s = "(null)";
 4eb:	c7 45 f4 c7 07 00 00 	movl   $0x7c7,-0xc(%ebp)
        while(*s != 0){
 4f2:	eb 1a                	jmp    50e <printf+0xfc>
          putc(fd, *s);
 4f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4f7:	8a 00                	mov    (%eax),%al
 4f9:	0f be c0             	movsbl %al,%eax
 4fc:	83 ec 08             	sub    $0x8,%esp
 4ff:	50                   	push   %eax
 500:	ff 75 08             	pushl  0x8(%ebp)
 503:	e8 38 fe ff ff       	call   340 <putc>
 508:	83 c4 10             	add    $0x10,%esp
          s++;
 50b:	ff 45 f4             	incl   -0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 50e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 511:	8a 00                	mov    (%eax),%al
 513:	84 c0                	test   %al,%al
 515:	75 dd                	jne    4f4 <printf+0xe2>
 517:	eb 65                	jmp    57e <printf+0x16c>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 519:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 51d:	75 1d                	jne    53c <printf+0x12a>
        putc(fd, *ap);
 51f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 522:	8b 00                	mov    (%eax),%eax
 524:	0f be c0             	movsbl %al,%eax
 527:	83 ec 08             	sub    $0x8,%esp
 52a:	50                   	push   %eax
 52b:	ff 75 08             	pushl  0x8(%ebp)
 52e:	e8 0d fe ff ff       	call   340 <putc>
 533:	83 c4 10             	add    $0x10,%esp
        ap++;
 536:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 53a:	eb 42                	jmp    57e <printf+0x16c>
      } else if(c == '%'){
 53c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 540:	75 17                	jne    559 <printf+0x147>
        putc(fd, c);
 542:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 545:	0f be c0             	movsbl %al,%eax
 548:	83 ec 08             	sub    $0x8,%esp
 54b:	50                   	push   %eax
 54c:	ff 75 08             	pushl  0x8(%ebp)
 54f:	e8 ec fd ff ff       	call   340 <putc>
 554:	83 c4 10             	add    $0x10,%esp
 557:	eb 25                	jmp    57e <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 559:	83 ec 08             	sub    $0x8,%esp
 55c:	6a 25                	push   $0x25
 55e:	ff 75 08             	pushl  0x8(%ebp)
 561:	e8 da fd ff ff       	call   340 <putc>
 566:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 569:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 56c:	0f be c0             	movsbl %al,%eax
 56f:	83 ec 08             	sub    $0x8,%esp
 572:	50                   	push   %eax
 573:	ff 75 08             	pushl  0x8(%ebp)
 576:	e8 c5 fd ff ff       	call   340 <putc>
 57b:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 57e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 585:	ff 45 f0             	incl   -0x10(%ebp)
 588:	8b 55 0c             	mov    0xc(%ebp),%edx
 58b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 58e:	01 d0                	add    %edx,%eax
 590:	8a 00                	mov    (%eax),%al
 592:	84 c0                	test   %al,%al
 594:	0f 85 9a fe ff ff    	jne    434 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 59a:	c9                   	leave  
 59b:	c3                   	ret    

0000059c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 59c:	55                   	push   %ebp
 59d:	89 e5                	mov    %esp,%ebp
 59f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5a2:	8b 45 08             	mov    0x8(%ebp),%eax
 5a5:	83 e8 08             	sub    $0x8,%eax
 5a8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ab:	a1 38 0a 00 00       	mov    0xa38,%eax
 5b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5b3:	eb 24                	jmp    5d9 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5b8:	8b 00                	mov    (%eax),%eax
 5ba:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5bd:	77 12                	ja     5d1 <free+0x35>
 5bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5c2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5c5:	77 24                	ja     5eb <free+0x4f>
 5c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5ca:	8b 00                	mov    (%eax),%eax
 5cc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5cf:	77 1a                	ja     5eb <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5d4:	8b 00                	mov    (%eax),%eax
 5d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5dc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5df:	76 d4                	jbe    5b5 <free+0x19>
 5e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e4:	8b 00                	mov    (%eax),%eax
 5e6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5e9:	76 ca                	jbe    5b5 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5ee:	8b 40 04             	mov    0x4(%eax),%eax
 5f1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 5f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5fb:	01 c2                	add    %eax,%edx
 5fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 600:	8b 00                	mov    (%eax),%eax
 602:	39 c2                	cmp    %eax,%edx
 604:	75 24                	jne    62a <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 606:	8b 45 f8             	mov    -0x8(%ebp),%eax
 609:	8b 50 04             	mov    0x4(%eax),%edx
 60c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 60f:	8b 00                	mov    (%eax),%eax
 611:	8b 40 04             	mov    0x4(%eax),%eax
 614:	01 c2                	add    %eax,%edx
 616:	8b 45 f8             	mov    -0x8(%ebp),%eax
 619:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 61c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 61f:	8b 00                	mov    (%eax),%eax
 621:	8b 10                	mov    (%eax),%edx
 623:	8b 45 f8             	mov    -0x8(%ebp),%eax
 626:	89 10                	mov    %edx,(%eax)
 628:	eb 0a                	jmp    634 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 62a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62d:	8b 10                	mov    (%eax),%edx
 62f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 632:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 634:	8b 45 fc             	mov    -0x4(%ebp),%eax
 637:	8b 40 04             	mov    0x4(%eax),%eax
 63a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 641:	8b 45 fc             	mov    -0x4(%ebp),%eax
 644:	01 d0                	add    %edx,%eax
 646:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 649:	75 20                	jne    66b <free+0xcf>
    p->s.size += bp->s.size;
 64b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64e:	8b 50 04             	mov    0x4(%eax),%edx
 651:	8b 45 f8             	mov    -0x8(%ebp),%eax
 654:	8b 40 04             	mov    0x4(%eax),%eax
 657:	01 c2                	add    %eax,%edx
 659:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65c:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 65f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 662:	8b 10                	mov    (%eax),%edx
 664:	8b 45 fc             	mov    -0x4(%ebp),%eax
 667:	89 10                	mov    %edx,(%eax)
 669:	eb 08                	jmp    673 <free+0xd7>
  } else
    p->s.ptr = bp;
 66b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 671:	89 10                	mov    %edx,(%eax)
  freep = p;
 673:	8b 45 fc             	mov    -0x4(%ebp),%eax
 676:	a3 38 0a 00 00       	mov    %eax,0xa38
}
 67b:	c9                   	leave  
 67c:	c3                   	ret    

0000067d <morecore>:

static Header*
morecore(uint nu)
{
 67d:	55                   	push   %ebp
 67e:	89 e5                	mov    %esp,%ebp
 680:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 683:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 68a:	77 07                	ja     693 <morecore+0x16>
    nu = 4096;
 68c:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 693:	8b 45 08             	mov    0x8(%ebp),%eax
 696:	c1 e0 03             	shl    $0x3,%eax
 699:	83 ec 0c             	sub    $0xc,%esp
 69c:	50                   	push   %eax
 69d:	e8 86 fc ff ff       	call   328 <sbrk>
 6a2:	83 c4 10             	add    $0x10,%esp
 6a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6a8:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6ac:	75 07                	jne    6b5 <morecore+0x38>
    return 0;
 6ae:	b8 00 00 00 00       	mov    $0x0,%eax
 6b3:	eb 26                	jmp    6db <morecore+0x5e>
  hp = (Header*)p;
 6b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6be:	8b 55 08             	mov    0x8(%ebp),%edx
 6c1:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6c7:	83 c0 08             	add    $0x8,%eax
 6ca:	83 ec 0c             	sub    $0xc,%esp
 6cd:	50                   	push   %eax
 6ce:	e8 c9 fe ff ff       	call   59c <free>
 6d3:	83 c4 10             	add    $0x10,%esp
  return freep;
 6d6:	a1 38 0a 00 00       	mov    0xa38,%eax
}
 6db:	c9                   	leave  
 6dc:	c3                   	ret    

000006dd <malloc>:

void*
malloc(uint nbytes)
{
 6dd:	55                   	push   %ebp
 6de:	89 e5                	mov    %esp,%ebp
 6e0:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e3:	8b 45 08             	mov    0x8(%ebp),%eax
 6e6:	83 c0 07             	add    $0x7,%eax
 6e9:	c1 e8 03             	shr    $0x3,%eax
 6ec:	40                   	inc    %eax
 6ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 6f0:	a1 38 0a 00 00       	mov    0xa38,%eax
 6f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 6f8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6fc:	75 23                	jne    721 <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
 6fe:	c7 45 f0 30 0a 00 00 	movl   $0xa30,-0x10(%ebp)
 705:	8b 45 f0             	mov    -0x10(%ebp),%eax
 708:	a3 38 0a 00 00       	mov    %eax,0xa38
 70d:	a1 38 0a 00 00       	mov    0xa38,%eax
 712:	a3 30 0a 00 00       	mov    %eax,0xa30
    base.s.size = 0;
 717:	c7 05 34 0a 00 00 00 	movl   $0x0,0xa34
 71e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 721:	8b 45 f0             	mov    -0x10(%ebp),%eax
 724:	8b 00                	mov    (%eax),%eax
 726:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 729:	8b 45 f4             	mov    -0xc(%ebp),%eax
 72c:	8b 40 04             	mov    0x4(%eax),%eax
 72f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 732:	72 4d                	jb     781 <malloc+0xa4>
      if(p->s.size == nunits)
 734:	8b 45 f4             	mov    -0xc(%ebp),%eax
 737:	8b 40 04             	mov    0x4(%eax),%eax
 73a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 73d:	75 0c                	jne    74b <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
 73f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 742:	8b 10                	mov    (%eax),%edx
 744:	8b 45 f0             	mov    -0x10(%ebp),%eax
 747:	89 10                	mov    %edx,(%eax)
 749:	eb 26                	jmp    771 <malloc+0x94>
      else {
        p->s.size -= nunits;
 74b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 74e:	8b 40 04             	mov    0x4(%eax),%eax
 751:	2b 45 ec             	sub    -0x14(%ebp),%eax
 754:	89 c2                	mov    %eax,%edx
 756:	8b 45 f4             	mov    -0xc(%ebp),%eax
 759:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 75c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75f:	8b 40 04             	mov    0x4(%eax),%eax
 762:	c1 e0 03             	shl    $0x3,%eax
 765:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 768:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76b:	8b 55 ec             	mov    -0x14(%ebp),%edx
 76e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 771:	8b 45 f0             	mov    -0x10(%ebp),%eax
 774:	a3 38 0a 00 00       	mov    %eax,0xa38
      return (void*)(p + 1);
 779:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77c:	83 c0 08             	add    $0x8,%eax
 77f:	eb 3b                	jmp    7bc <malloc+0xdf>
    }
    if(p == freep)
 781:	a1 38 0a 00 00       	mov    0xa38,%eax
 786:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 789:	75 1e                	jne    7a9 <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
 78b:	83 ec 0c             	sub    $0xc,%esp
 78e:	ff 75 ec             	pushl  -0x14(%ebp)
 791:	e8 e7 fe ff ff       	call   67d <morecore>
 796:	83 c4 10             	add    $0x10,%esp
 799:	89 45 f4             	mov    %eax,-0xc(%ebp)
 79c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7a0:	75 07                	jne    7a9 <malloc+0xcc>
        return 0;
 7a2:	b8 00 00 00 00       	mov    $0x0,%eax
 7a7:	eb 13                	jmp    7bc <malloc+0xdf>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7af:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b2:	8b 00                	mov    (%eax),%eax
 7b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7b7:	e9 6d ff ff ff       	jmp    729 <malloc+0x4c>
}
 7bc:	c9                   	leave  
 7bd:	c3                   	ret    
