
_rm:     file format elf32-i386


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

  if(argc < 2){
  14:	83 3b 01             	cmpl   $0x1,(%ebx)
  17:	7f 17                	jg     30 <main+0x30>
    printf(2, "Usage: rm files...\n");
  19:	83 ec 08             	sub    $0x8,%esp
  1c:	68 eb 07 00 00       	push   $0x7eb
  21:	6a 02                	push   $0x2
  23:	e8 17 04 00 00       	call   43f <printf>
  28:	83 c4 10             	add    $0x10,%esp
    exit();
  2b:	e8 9d 02 00 00       	call   2cd <exit>
  }

  for(i = 1; i < argc; i++){
  30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  37:	eb 4a                	jmp    83 <main+0x83>
    if(unlink(argv[i]) < 0){
  39:	8b 45 f4             	mov    -0xc(%ebp),%eax
  3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  43:	8b 43 04             	mov    0x4(%ebx),%eax
  46:	01 d0                	add    %edx,%eax
  48:	8b 00                	mov    (%eax),%eax
  4a:	83 ec 0c             	sub    $0xc,%esp
  4d:	50                   	push   %eax
  4e:	e8 ca 02 00 00       	call   31d <unlink>
  53:	83 c4 10             	add    $0x10,%esp
  56:	85 c0                	test   %eax,%eax
  58:	79 26                	jns    80 <main+0x80>
      printf(2, "rm: %s failed to delete\n", argv[i]);
  5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  5d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  64:	8b 43 04             	mov    0x4(%ebx),%eax
  67:	01 d0                	add    %edx,%eax
  69:	8b 00                	mov    (%eax),%eax
  6b:	83 ec 04             	sub    $0x4,%esp
  6e:	50                   	push   %eax
  6f:	68 ff 07 00 00       	push   $0x7ff
  74:	6a 02                	push   $0x2
  76:	e8 c4 03 00 00       	call   43f <printf>
  7b:	83 c4 10             	add    $0x10,%esp
      break;
  7e:	eb 0a                	jmp    8a <main+0x8a>
  if(argc < 2){
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  80:	ff 45 f4             	incl   -0xc(%ebp)
  83:	8b 45 f4             	mov    -0xc(%ebp),%eax
  86:	3b 03                	cmp    (%ebx),%eax
  88:	7c af                	jl     39 <main+0x39>
      printf(2, "rm: %s failed to delete\n", argv[i]);
      break;
    }
  }

  exit();
  8a:	e8 3e 02 00 00       	call   2cd <exit>

0000008f <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  8f:	55                   	push   %ebp
  90:	89 e5                	mov    %esp,%ebp
  92:	57                   	push   %edi
  93:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  94:	8b 4d 08             	mov    0x8(%ebp),%ecx
  97:	8b 55 10             	mov    0x10(%ebp),%edx
  9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  9d:	89 cb                	mov    %ecx,%ebx
  9f:	89 df                	mov    %ebx,%edi
  a1:	89 d1                	mov    %edx,%ecx
  a3:	fc                   	cld    
  a4:	f3 aa                	rep stos %al,%es:(%edi)
  a6:	89 ca                	mov    %ecx,%edx
  a8:	89 fb                	mov    %edi,%ebx
  aa:	89 5d 08             	mov    %ebx,0x8(%ebp)
  ad:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  b0:	5b                   	pop    %ebx
  b1:	5f                   	pop    %edi
  b2:	5d                   	pop    %ebp
  b3:	c3                   	ret    

000000b4 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  b4:	55                   	push   %ebp
  b5:	89 e5                	mov    %esp,%ebp
  b7:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  ba:	8b 45 08             	mov    0x8(%ebp),%eax
  bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  c0:	90                   	nop
  c1:	8b 45 08             	mov    0x8(%ebp),%eax
  c4:	8d 50 01             	lea    0x1(%eax),%edx
  c7:	89 55 08             	mov    %edx,0x8(%ebp)
  ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  cd:	8d 4a 01             	lea    0x1(%edx),%ecx
  d0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  d3:	8a 12                	mov    (%edx),%dl
  d5:	88 10                	mov    %dl,(%eax)
  d7:	8a 00                	mov    (%eax),%al
  d9:	84 c0                	test   %al,%al
  db:	75 e4                	jne    c1 <strcpy+0xd>
    ;
  return os;
  dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e0:	c9                   	leave  
  e1:	c3                   	ret    

000000e2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e2:	55                   	push   %ebp
  e3:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  e5:	eb 06                	jmp    ed <strcmp+0xb>
    p++, q++;
  e7:	ff 45 08             	incl   0x8(%ebp)
  ea:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ed:	8b 45 08             	mov    0x8(%ebp),%eax
  f0:	8a 00                	mov    (%eax),%al
  f2:	84 c0                	test   %al,%al
  f4:	74 0e                	je     104 <strcmp+0x22>
  f6:	8b 45 08             	mov    0x8(%ebp),%eax
  f9:	8a 10                	mov    (%eax),%dl
  fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  fe:	8a 00                	mov    (%eax),%al
 100:	38 c2                	cmp    %al,%dl
 102:	74 e3                	je     e7 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 104:	8b 45 08             	mov    0x8(%ebp),%eax
 107:	8a 00                	mov    (%eax),%al
 109:	0f b6 d0             	movzbl %al,%edx
 10c:	8b 45 0c             	mov    0xc(%ebp),%eax
 10f:	8a 00                	mov    (%eax),%al
 111:	0f b6 c0             	movzbl %al,%eax
 114:	29 c2                	sub    %eax,%edx
 116:	89 d0                	mov    %edx,%eax
}
 118:	5d                   	pop    %ebp
 119:	c3                   	ret    

0000011a <strlen>:

uint
strlen(char *s)
{
 11a:	55                   	push   %ebp
 11b:	89 e5                	mov    %esp,%ebp
 11d:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 120:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 127:	eb 03                	jmp    12c <strlen+0x12>
 129:	ff 45 fc             	incl   -0x4(%ebp)
 12c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 12f:	8b 45 08             	mov    0x8(%ebp),%eax
 132:	01 d0                	add    %edx,%eax
 134:	8a 00                	mov    (%eax),%al
 136:	84 c0                	test   %al,%al
 138:	75 ef                	jne    129 <strlen+0xf>
    ;
  return n;
 13a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 13d:	c9                   	leave  
 13e:	c3                   	ret    

0000013f <memset>:

void*
memset(void *dst, int c, uint n)
{
 13f:	55                   	push   %ebp
 140:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 142:	8b 45 10             	mov    0x10(%ebp),%eax
 145:	50                   	push   %eax
 146:	ff 75 0c             	pushl  0xc(%ebp)
 149:	ff 75 08             	pushl  0x8(%ebp)
 14c:	e8 3e ff ff ff       	call   8f <stosb>
 151:	83 c4 0c             	add    $0xc,%esp
  return dst;
 154:	8b 45 08             	mov    0x8(%ebp),%eax
}
 157:	c9                   	leave  
 158:	c3                   	ret    

00000159 <strchr>:

char*
strchr(const char *s, char c)
{
 159:	55                   	push   %ebp
 15a:	89 e5                	mov    %esp,%ebp
 15c:	83 ec 04             	sub    $0x4,%esp
 15f:	8b 45 0c             	mov    0xc(%ebp),%eax
 162:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 165:	eb 12                	jmp    179 <strchr+0x20>
    if(*s == c)
 167:	8b 45 08             	mov    0x8(%ebp),%eax
 16a:	8a 00                	mov    (%eax),%al
 16c:	3a 45 fc             	cmp    -0x4(%ebp),%al
 16f:	75 05                	jne    176 <strchr+0x1d>
      return (char*)s;
 171:	8b 45 08             	mov    0x8(%ebp),%eax
 174:	eb 11                	jmp    187 <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 176:	ff 45 08             	incl   0x8(%ebp)
 179:	8b 45 08             	mov    0x8(%ebp),%eax
 17c:	8a 00                	mov    (%eax),%al
 17e:	84 c0                	test   %al,%al
 180:	75 e5                	jne    167 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 182:	b8 00 00 00 00       	mov    $0x0,%eax
}
 187:	c9                   	leave  
 188:	c3                   	ret    

00000189 <gets>:

char*
gets(char *buf, int max)
{
 189:	55                   	push   %ebp
 18a:	89 e5                	mov    %esp,%ebp
 18c:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 18f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 196:	eb 41                	jmp    1d9 <gets+0x50>
    cc = read(0, &c, 1);
 198:	83 ec 04             	sub    $0x4,%esp
 19b:	6a 01                	push   $0x1
 19d:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1a0:	50                   	push   %eax
 1a1:	6a 00                	push   $0x0
 1a3:	e8 3d 01 00 00       	call   2e5 <read>
 1a8:	83 c4 10             	add    $0x10,%esp
 1ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1ae:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1b2:	7f 02                	jg     1b6 <gets+0x2d>
      break;
 1b4:	eb 2c                	jmp    1e2 <gets+0x59>
    buf[i++] = c;
 1b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b9:	8d 50 01             	lea    0x1(%eax),%edx
 1bc:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1bf:	89 c2                	mov    %eax,%edx
 1c1:	8b 45 08             	mov    0x8(%ebp),%eax
 1c4:	01 c2                	add    %eax,%edx
 1c6:	8a 45 ef             	mov    -0x11(%ebp),%al
 1c9:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1cb:	8a 45 ef             	mov    -0x11(%ebp),%al
 1ce:	3c 0a                	cmp    $0xa,%al
 1d0:	74 10                	je     1e2 <gets+0x59>
 1d2:	8a 45 ef             	mov    -0x11(%ebp),%al
 1d5:	3c 0d                	cmp    $0xd,%al
 1d7:	74 09                	je     1e2 <gets+0x59>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1dc:	40                   	inc    %eax
 1dd:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1e0:	7c b6                	jl     198 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1e2:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1e5:	8b 45 08             	mov    0x8(%ebp),%eax
 1e8:	01 d0                	add    %edx,%eax
 1ea:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1ed:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1f0:	c9                   	leave  
 1f1:	c3                   	ret    

000001f2 <stat>:

int
stat(char *n, struct stat *st)
{
 1f2:	55                   	push   %ebp
 1f3:	89 e5                	mov    %esp,%ebp
 1f5:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f8:	83 ec 08             	sub    $0x8,%esp
 1fb:	6a 00                	push   $0x0
 1fd:	ff 75 08             	pushl  0x8(%ebp)
 200:	e8 08 01 00 00       	call   30d <open>
 205:	83 c4 10             	add    $0x10,%esp
 208:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 20b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 20f:	79 07                	jns    218 <stat+0x26>
    return -1;
 211:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 216:	eb 25                	jmp    23d <stat+0x4b>
  r = fstat(fd, st);
 218:	83 ec 08             	sub    $0x8,%esp
 21b:	ff 75 0c             	pushl  0xc(%ebp)
 21e:	ff 75 f4             	pushl  -0xc(%ebp)
 221:	e8 ff 00 00 00       	call   325 <fstat>
 226:	83 c4 10             	add    $0x10,%esp
 229:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 22c:	83 ec 0c             	sub    $0xc,%esp
 22f:	ff 75 f4             	pushl  -0xc(%ebp)
 232:	e8 be 00 00 00       	call   2f5 <close>
 237:	83 c4 10             	add    $0x10,%esp
  return r;
 23a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 23d:	c9                   	leave  
 23e:	c3                   	ret    

0000023f <atoi>:

int
atoi(const char *s)
{
 23f:	55                   	push   %ebp
 240:	89 e5                	mov    %esp,%ebp
 242:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 245:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 24c:	eb 24                	jmp    272 <atoi+0x33>
    n = n*10 + *s++ - '0';
 24e:	8b 55 fc             	mov    -0x4(%ebp),%edx
 251:	89 d0                	mov    %edx,%eax
 253:	c1 e0 02             	shl    $0x2,%eax
 256:	01 d0                	add    %edx,%eax
 258:	01 c0                	add    %eax,%eax
 25a:	89 c1                	mov    %eax,%ecx
 25c:	8b 45 08             	mov    0x8(%ebp),%eax
 25f:	8d 50 01             	lea    0x1(%eax),%edx
 262:	89 55 08             	mov    %edx,0x8(%ebp)
 265:	8a 00                	mov    (%eax),%al
 267:	0f be c0             	movsbl %al,%eax
 26a:	01 c8                	add    %ecx,%eax
 26c:	83 e8 30             	sub    $0x30,%eax
 26f:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 272:	8b 45 08             	mov    0x8(%ebp),%eax
 275:	8a 00                	mov    (%eax),%al
 277:	3c 2f                	cmp    $0x2f,%al
 279:	7e 09                	jle    284 <atoi+0x45>
 27b:	8b 45 08             	mov    0x8(%ebp),%eax
 27e:	8a 00                	mov    (%eax),%al
 280:	3c 39                	cmp    $0x39,%al
 282:	7e ca                	jle    24e <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 284:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 287:	c9                   	leave  
 288:	c3                   	ret    

00000289 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 289:	55                   	push   %ebp
 28a:	89 e5                	mov    %esp,%ebp
 28c:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 28f:	8b 45 08             	mov    0x8(%ebp),%eax
 292:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 295:	8b 45 0c             	mov    0xc(%ebp),%eax
 298:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 29b:	eb 16                	jmp    2b3 <memmove+0x2a>
    *dst++ = *src++;
 29d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2a0:	8d 50 01             	lea    0x1(%eax),%edx
 2a3:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2a6:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2a9:	8d 4a 01             	lea    0x1(%edx),%ecx
 2ac:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2af:	8a 12                	mov    (%edx),%dl
 2b1:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2b3:	8b 45 10             	mov    0x10(%ebp),%eax
 2b6:	8d 50 ff             	lea    -0x1(%eax),%edx
 2b9:	89 55 10             	mov    %edx,0x10(%ebp)
 2bc:	85 c0                	test   %eax,%eax
 2be:	7f dd                	jg     29d <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2c0:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2c3:	c9                   	leave  
 2c4:	c3                   	ret    

000002c5 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2c5:	b8 01 00 00 00       	mov    $0x1,%eax
 2ca:	cd 40                	int    $0x40
 2cc:	c3                   	ret    

000002cd <exit>:
SYSCALL(exit)
 2cd:	b8 02 00 00 00       	mov    $0x2,%eax
 2d2:	cd 40                	int    $0x40
 2d4:	c3                   	ret    

000002d5 <wait>:
SYSCALL(wait)
 2d5:	b8 03 00 00 00       	mov    $0x3,%eax
 2da:	cd 40                	int    $0x40
 2dc:	c3                   	ret    

000002dd <pipe>:
SYSCALL(pipe)
 2dd:	b8 04 00 00 00       	mov    $0x4,%eax
 2e2:	cd 40                	int    $0x40
 2e4:	c3                   	ret    

000002e5 <read>:
SYSCALL(read)
 2e5:	b8 05 00 00 00       	mov    $0x5,%eax
 2ea:	cd 40                	int    $0x40
 2ec:	c3                   	ret    

000002ed <write>:
SYSCALL(write)
 2ed:	b8 10 00 00 00       	mov    $0x10,%eax
 2f2:	cd 40                	int    $0x40
 2f4:	c3                   	ret    

000002f5 <close>:
SYSCALL(close)
 2f5:	b8 15 00 00 00       	mov    $0x15,%eax
 2fa:	cd 40                	int    $0x40
 2fc:	c3                   	ret    

000002fd <kill>:
SYSCALL(kill)
 2fd:	b8 06 00 00 00       	mov    $0x6,%eax
 302:	cd 40                	int    $0x40
 304:	c3                   	ret    

00000305 <exec>:
SYSCALL(exec)
 305:	b8 07 00 00 00       	mov    $0x7,%eax
 30a:	cd 40                	int    $0x40
 30c:	c3                   	ret    

0000030d <open>:
SYSCALL(open)
 30d:	b8 0f 00 00 00       	mov    $0xf,%eax
 312:	cd 40                	int    $0x40
 314:	c3                   	ret    

00000315 <mknod>:
SYSCALL(mknod)
 315:	b8 11 00 00 00       	mov    $0x11,%eax
 31a:	cd 40                	int    $0x40
 31c:	c3                   	ret    

0000031d <unlink>:
SYSCALL(unlink)
 31d:	b8 12 00 00 00       	mov    $0x12,%eax
 322:	cd 40                	int    $0x40
 324:	c3                   	ret    

00000325 <fstat>:
SYSCALL(fstat)
 325:	b8 08 00 00 00       	mov    $0x8,%eax
 32a:	cd 40                	int    $0x40
 32c:	c3                   	ret    

0000032d <link>:
SYSCALL(link)
 32d:	b8 13 00 00 00       	mov    $0x13,%eax
 332:	cd 40                	int    $0x40
 334:	c3                   	ret    

00000335 <mkdir>:
SYSCALL(mkdir)
 335:	b8 14 00 00 00       	mov    $0x14,%eax
 33a:	cd 40                	int    $0x40
 33c:	c3                   	ret    

0000033d <chdir>:
SYSCALL(chdir)
 33d:	b8 09 00 00 00       	mov    $0x9,%eax
 342:	cd 40                	int    $0x40
 344:	c3                   	ret    

00000345 <dup>:
SYSCALL(dup)
 345:	b8 0a 00 00 00       	mov    $0xa,%eax
 34a:	cd 40                	int    $0x40
 34c:	c3                   	ret    

0000034d <getpid>:
SYSCALL(getpid)
 34d:	b8 0b 00 00 00       	mov    $0xb,%eax
 352:	cd 40                	int    $0x40
 354:	c3                   	ret    

00000355 <sbrk>:
SYSCALL(sbrk)
 355:	b8 0c 00 00 00       	mov    $0xc,%eax
 35a:	cd 40                	int    $0x40
 35c:	c3                   	ret    

0000035d <sleep>:
SYSCALL(sleep)
 35d:	b8 0d 00 00 00       	mov    $0xd,%eax
 362:	cd 40                	int    $0x40
 364:	c3                   	ret    

00000365 <uptime>:
SYSCALL(uptime)
 365:	b8 0e 00 00 00       	mov    $0xe,%eax
 36a:	cd 40                	int    $0x40
 36c:	c3                   	ret    

0000036d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 36d:	55                   	push   %ebp
 36e:	89 e5                	mov    %esp,%ebp
 370:	83 ec 18             	sub    $0x18,%esp
 373:	8b 45 0c             	mov    0xc(%ebp),%eax
 376:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 379:	83 ec 04             	sub    $0x4,%esp
 37c:	6a 01                	push   $0x1
 37e:	8d 45 f4             	lea    -0xc(%ebp),%eax
 381:	50                   	push   %eax
 382:	ff 75 08             	pushl  0x8(%ebp)
 385:	e8 63 ff ff ff       	call   2ed <write>
 38a:	83 c4 10             	add    $0x10,%esp
}
 38d:	c9                   	leave  
 38e:	c3                   	ret    

0000038f <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 38f:	55                   	push   %ebp
 390:	89 e5                	mov    %esp,%ebp
 392:	53                   	push   %ebx
 393:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 396:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 39d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3a1:	74 17                	je     3ba <printint+0x2b>
 3a3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3a7:	79 11                	jns    3ba <printint+0x2b>
    neg = 1;
 3a9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3b0:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b3:	f7 d8                	neg    %eax
 3b5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3b8:	eb 06                	jmp    3c0 <printint+0x31>
  } else {
    x = xx;
 3ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 3bd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3c7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3ca:	8d 41 01             	lea    0x1(%ecx),%eax
 3cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3d0:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3d6:	ba 00 00 00 00       	mov    $0x0,%edx
 3db:	f7 f3                	div    %ebx
 3dd:	89 d0                	mov    %edx,%eax
 3df:	8a 80 6c 0a 00 00    	mov    0xa6c(%eax),%al
 3e5:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3e9:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3ef:	ba 00 00 00 00       	mov    $0x0,%edx
 3f4:	f7 f3                	div    %ebx
 3f6:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3f9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3fd:	75 c8                	jne    3c7 <printint+0x38>
  if(neg)
 3ff:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 403:	74 0e                	je     413 <printint+0x84>
    buf[i++] = '-';
 405:	8b 45 f4             	mov    -0xc(%ebp),%eax
 408:	8d 50 01             	lea    0x1(%eax),%edx
 40b:	89 55 f4             	mov    %edx,-0xc(%ebp)
 40e:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 413:	eb 1c                	jmp    431 <printint+0xa2>
    putc(fd, buf[i]);
 415:	8d 55 dc             	lea    -0x24(%ebp),%edx
 418:	8b 45 f4             	mov    -0xc(%ebp),%eax
 41b:	01 d0                	add    %edx,%eax
 41d:	8a 00                	mov    (%eax),%al
 41f:	0f be c0             	movsbl %al,%eax
 422:	83 ec 08             	sub    $0x8,%esp
 425:	50                   	push   %eax
 426:	ff 75 08             	pushl  0x8(%ebp)
 429:	e8 3f ff ff ff       	call   36d <putc>
 42e:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 431:	ff 4d f4             	decl   -0xc(%ebp)
 434:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 438:	79 db                	jns    415 <printint+0x86>
    putc(fd, buf[i]);
}
 43a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 43d:	c9                   	leave  
 43e:	c3                   	ret    

0000043f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 43f:	55                   	push   %ebp
 440:	89 e5                	mov    %esp,%ebp
 442:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 445:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 44c:	8d 45 0c             	lea    0xc(%ebp),%eax
 44f:	83 c0 04             	add    $0x4,%eax
 452:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 455:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 45c:	e9 54 01 00 00       	jmp    5b5 <printf+0x176>
    c = fmt[i] & 0xff;
 461:	8b 55 0c             	mov    0xc(%ebp),%edx
 464:	8b 45 f0             	mov    -0x10(%ebp),%eax
 467:	01 d0                	add    %edx,%eax
 469:	8a 00                	mov    (%eax),%al
 46b:	0f be c0             	movsbl %al,%eax
 46e:	25 ff 00 00 00       	and    $0xff,%eax
 473:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 476:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 47a:	75 2c                	jne    4a8 <printf+0x69>
      if(c == '%'){
 47c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 480:	75 0c                	jne    48e <printf+0x4f>
        state = '%';
 482:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 489:	e9 24 01 00 00       	jmp    5b2 <printf+0x173>
      } else {
        putc(fd, c);
 48e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 491:	0f be c0             	movsbl %al,%eax
 494:	83 ec 08             	sub    $0x8,%esp
 497:	50                   	push   %eax
 498:	ff 75 08             	pushl  0x8(%ebp)
 49b:	e8 cd fe ff ff       	call   36d <putc>
 4a0:	83 c4 10             	add    $0x10,%esp
 4a3:	e9 0a 01 00 00       	jmp    5b2 <printf+0x173>
      }
    } else if(state == '%'){
 4a8:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4ac:	0f 85 00 01 00 00    	jne    5b2 <printf+0x173>
      if(c == 'd'){
 4b2:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4b6:	75 1e                	jne    4d6 <printf+0x97>
        printint(fd, *ap, 10, 1);
 4b8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4bb:	8b 00                	mov    (%eax),%eax
 4bd:	6a 01                	push   $0x1
 4bf:	6a 0a                	push   $0xa
 4c1:	50                   	push   %eax
 4c2:	ff 75 08             	pushl  0x8(%ebp)
 4c5:	e8 c5 fe ff ff       	call   38f <printint>
 4ca:	83 c4 10             	add    $0x10,%esp
        ap++;
 4cd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4d1:	e9 d5 00 00 00       	jmp    5ab <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
 4d6:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4da:	74 06                	je     4e2 <printf+0xa3>
 4dc:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4e0:	75 1e                	jne    500 <printf+0xc1>
        printint(fd, *ap, 16, 0);
 4e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e5:	8b 00                	mov    (%eax),%eax
 4e7:	6a 00                	push   $0x0
 4e9:	6a 10                	push   $0x10
 4eb:	50                   	push   %eax
 4ec:	ff 75 08             	pushl  0x8(%ebp)
 4ef:	e8 9b fe ff ff       	call   38f <printint>
 4f4:	83 c4 10             	add    $0x10,%esp
        ap++;
 4f7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4fb:	e9 ab 00 00 00       	jmp    5ab <printf+0x16c>
      } else if(c == 's'){
 500:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 504:	75 40                	jne    546 <printf+0x107>
        s = (char*)*ap;
 506:	8b 45 e8             	mov    -0x18(%ebp),%eax
 509:	8b 00                	mov    (%eax),%eax
 50b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 50e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 512:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 516:	75 07                	jne    51f <printf+0xe0>
          s = "(null)";
 518:	c7 45 f4 18 08 00 00 	movl   $0x818,-0xc(%ebp)
        while(*s != 0){
 51f:	eb 1a                	jmp    53b <printf+0xfc>
          putc(fd, *s);
 521:	8b 45 f4             	mov    -0xc(%ebp),%eax
 524:	8a 00                	mov    (%eax),%al
 526:	0f be c0             	movsbl %al,%eax
 529:	83 ec 08             	sub    $0x8,%esp
 52c:	50                   	push   %eax
 52d:	ff 75 08             	pushl  0x8(%ebp)
 530:	e8 38 fe ff ff       	call   36d <putc>
 535:	83 c4 10             	add    $0x10,%esp
          s++;
 538:	ff 45 f4             	incl   -0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 53b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 53e:	8a 00                	mov    (%eax),%al
 540:	84 c0                	test   %al,%al
 542:	75 dd                	jne    521 <printf+0xe2>
 544:	eb 65                	jmp    5ab <printf+0x16c>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 546:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 54a:	75 1d                	jne    569 <printf+0x12a>
        putc(fd, *ap);
 54c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 54f:	8b 00                	mov    (%eax),%eax
 551:	0f be c0             	movsbl %al,%eax
 554:	83 ec 08             	sub    $0x8,%esp
 557:	50                   	push   %eax
 558:	ff 75 08             	pushl  0x8(%ebp)
 55b:	e8 0d fe ff ff       	call   36d <putc>
 560:	83 c4 10             	add    $0x10,%esp
        ap++;
 563:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 567:	eb 42                	jmp    5ab <printf+0x16c>
      } else if(c == '%'){
 569:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 56d:	75 17                	jne    586 <printf+0x147>
        putc(fd, c);
 56f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 572:	0f be c0             	movsbl %al,%eax
 575:	83 ec 08             	sub    $0x8,%esp
 578:	50                   	push   %eax
 579:	ff 75 08             	pushl  0x8(%ebp)
 57c:	e8 ec fd ff ff       	call   36d <putc>
 581:	83 c4 10             	add    $0x10,%esp
 584:	eb 25                	jmp    5ab <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 586:	83 ec 08             	sub    $0x8,%esp
 589:	6a 25                	push   $0x25
 58b:	ff 75 08             	pushl  0x8(%ebp)
 58e:	e8 da fd ff ff       	call   36d <putc>
 593:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 596:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 599:	0f be c0             	movsbl %al,%eax
 59c:	83 ec 08             	sub    $0x8,%esp
 59f:	50                   	push   %eax
 5a0:	ff 75 08             	pushl  0x8(%ebp)
 5a3:	e8 c5 fd ff ff       	call   36d <putc>
 5a8:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5ab:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5b2:	ff 45 f0             	incl   -0x10(%ebp)
 5b5:	8b 55 0c             	mov    0xc(%ebp),%edx
 5b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5bb:	01 d0                	add    %edx,%eax
 5bd:	8a 00                	mov    (%eax),%al
 5bf:	84 c0                	test   %al,%al
 5c1:	0f 85 9a fe ff ff    	jne    461 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5c7:	c9                   	leave  
 5c8:	c3                   	ret    

000005c9 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5c9:	55                   	push   %ebp
 5ca:	89 e5                	mov    %esp,%ebp
 5cc:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5cf:	8b 45 08             	mov    0x8(%ebp),%eax
 5d2:	83 e8 08             	sub    $0x8,%eax
 5d5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d8:	a1 88 0a 00 00       	mov    0xa88,%eax
 5dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5e0:	eb 24                	jmp    606 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e5:	8b 00                	mov    (%eax),%eax
 5e7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5ea:	77 12                	ja     5fe <free+0x35>
 5ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5ef:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5f2:	77 24                	ja     618 <free+0x4f>
 5f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f7:	8b 00                	mov    (%eax),%eax
 5f9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5fc:	77 1a                	ja     618 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
 601:	8b 00                	mov    (%eax),%eax
 603:	89 45 fc             	mov    %eax,-0x4(%ebp)
 606:	8b 45 f8             	mov    -0x8(%ebp),%eax
 609:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 60c:	76 d4                	jbe    5e2 <free+0x19>
 60e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 611:	8b 00                	mov    (%eax),%eax
 613:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 616:	76 ca                	jbe    5e2 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 618:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61b:	8b 40 04             	mov    0x4(%eax),%eax
 61e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 625:	8b 45 f8             	mov    -0x8(%ebp),%eax
 628:	01 c2                	add    %eax,%edx
 62a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62d:	8b 00                	mov    (%eax),%eax
 62f:	39 c2                	cmp    %eax,%edx
 631:	75 24                	jne    657 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 633:	8b 45 f8             	mov    -0x8(%ebp),%eax
 636:	8b 50 04             	mov    0x4(%eax),%edx
 639:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63c:	8b 00                	mov    (%eax),%eax
 63e:	8b 40 04             	mov    0x4(%eax),%eax
 641:	01 c2                	add    %eax,%edx
 643:	8b 45 f8             	mov    -0x8(%ebp),%eax
 646:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 649:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64c:	8b 00                	mov    (%eax),%eax
 64e:	8b 10                	mov    (%eax),%edx
 650:	8b 45 f8             	mov    -0x8(%ebp),%eax
 653:	89 10                	mov    %edx,(%eax)
 655:	eb 0a                	jmp    661 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 657:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65a:	8b 10                	mov    (%eax),%edx
 65c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65f:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 661:	8b 45 fc             	mov    -0x4(%ebp),%eax
 664:	8b 40 04             	mov    0x4(%eax),%eax
 667:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 66e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 671:	01 d0                	add    %edx,%eax
 673:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 676:	75 20                	jne    698 <free+0xcf>
    p->s.size += bp->s.size;
 678:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67b:	8b 50 04             	mov    0x4(%eax),%edx
 67e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 681:	8b 40 04             	mov    0x4(%eax),%eax
 684:	01 c2                	add    %eax,%edx
 686:	8b 45 fc             	mov    -0x4(%ebp),%eax
 689:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 68c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68f:	8b 10                	mov    (%eax),%edx
 691:	8b 45 fc             	mov    -0x4(%ebp),%eax
 694:	89 10                	mov    %edx,(%eax)
 696:	eb 08                	jmp    6a0 <free+0xd7>
  } else
    p->s.ptr = bp;
 698:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69b:	8b 55 f8             	mov    -0x8(%ebp),%edx
 69e:	89 10                	mov    %edx,(%eax)
  freep = p;
 6a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a3:	a3 88 0a 00 00       	mov    %eax,0xa88
}
 6a8:	c9                   	leave  
 6a9:	c3                   	ret    

000006aa <morecore>:

static Header*
morecore(uint nu)
{
 6aa:	55                   	push   %ebp
 6ab:	89 e5                	mov    %esp,%ebp
 6ad:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6b0:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6b7:	77 07                	ja     6c0 <morecore+0x16>
    nu = 4096;
 6b9:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6c0:	8b 45 08             	mov    0x8(%ebp),%eax
 6c3:	c1 e0 03             	shl    $0x3,%eax
 6c6:	83 ec 0c             	sub    $0xc,%esp
 6c9:	50                   	push   %eax
 6ca:	e8 86 fc ff ff       	call   355 <sbrk>
 6cf:	83 c4 10             	add    $0x10,%esp
 6d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6d5:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6d9:	75 07                	jne    6e2 <morecore+0x38>
    return 0;
 6db:	b8 00 00 00 00       	mov    $0x0,%eax
 6e0:	eb 26                	jmp    708 <morecore+0x5e>
  hp = (Header*)p;
 6e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6eb:	8b 55 08             	mov    0x8(%ebp),%edx
 6ee:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f4:	83 c0 08             	add    $0x8,%eax
 6f7:	83 ec 0c             	sub    $0xc,%esp
 6fa:	50                   	push   %eax
 6fb:	e8 c9 fe ff ff       	call   5c9 <free>
 700:	83 c4 10             	add    $0x10,%esp
  return freep;
 703:	a1 88 0a 00 00       	mov    0xa88,%eax
}
 708:	c9                   	leave  
 709:	c3                   	ret    

0000070a <malloc>:

void*
malloc(uint nbytes)
{
 70a:	55                   	push   %ebp
 70b:	89 e5                	mov    %esp,%ebp
 70d:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 710:	8b 45 08             	mov    0x8(%ebp),%eax
 713:	83 c0 07             	add    $0x7,%eax
 716:	c1 e8 03             	shr    $0x3,%eax
 719:	40                   	inc    %eax
 71a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 71d:	a1 88 0a 00 00       	mov    0xa88,%eax
 722:	89 45 f0             	mov    %eax,-0x10(%ebp)
 725:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 729:	75 23                	jne    74e <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
 72b:	c7 45 f0 80 0a 00 00 	movl   $0xa80,-0x10(%ebp)
 732:	8b 45 f0             	mov    -0x10(%ebp),%eax
 735:	a3 88 0a 00 00       	mov    %eax,0xa88
 73a:	a1 88 0a 00 00       	mov    0xa88,%eax
 73f:	a3 80 0a 00 00       	mov    %eax,0xa80
    base.s.size = 0;
 744:	c7 05 84 0a 00 00 00 	movl   $0x0,0xa84
 74b:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 74e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 751:	8b 00                	mov    (%eax),%eax
 753:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 756:	8b 45 f4             	mov    -0xc(%ebp),%eax
 759:	8b 40 04             	mov    0x4(%eax),%eax
 75c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 75f:	72 4d                	jb     7ae <malloc+0xa4>
      if(p->s.size == nunits)
 761:	8b 45 f4             	mov    -0xc(%ebp),%eax
 764:	8b 40 04             	mov    0x4(%eax),%eax
 767:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 76a:	75 0c                	jne    778 <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
 76c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76f:	8b 10                	mov    (%eax),%edx
 771:	8b 45 f0             	mov    -0x10(%ebp),%eax
 774:	89 10                	mov    %edx,(%eax)
 776:	eb 26                	jmp    79e <malloc+0x94>
      else {
        p->s.size -= nunits;
 778:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77b:	8b 40 04             	mov    0x4(%eax),%eax
 77e:	2b 45 ec             	sub    -0x14(%ebp),%eax
 781:	89 c2                	mov    %eax,%edx
 783:	8b 45 f4             	mov    -0xc(%ebp),%eax
 786:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 789:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78c:	8b 40 04             	mov    0x4(%eax),%eax
 78f:	c1 e0 03             	shl    $0x3,%eax
 792:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 795:	8b 45 f4             	mov    -0xc(%ebp),%eax
 798:	8b 55 ec             	mov    -0x14(%ebp),%edx
 79b:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 79e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a1:	a3 88 0a 00 00       	mov    %eax,0xa88
      return (void*)(p + 1);
 7a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a9:	83 c0 08             	add    $0x8,%eax
 7ac:	eb 3b                	jmp    7e9 <malloc+0xdf>
    }
    if(p == freep)
 7ae:	a1 88 0a 00 00       	mov    0xa88,%eax
 7b3:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7b6:	75 1e                	jne    7d6 <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
 7b8:	83 ec 0c             	sub    $0xc,%esp
 7bb:	ff 75 ec             	pushl  -0x14(%ebp)
 7be:	e8 e7 fe ff ff       	call   6aa <morecore>
 7c3:	83 c4 10             	add    $0x10,%esp
 7c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7c9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7cd:	75 07                	jne    7d6 <malloc+0xcc>
        return 0;
 7cf:	b8 00 00 00 00       	mov    $0x0,%eax
 7d4:	eb 13                	jmp    7e9 <malloc+0xdf>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7df:	8b 00                	mov    (%eax),%eax
 7e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7e4:	e9 6d ff ff ff       	jmp    756 <malloc+0x4c>
}
 7e9:	c9                   	leave  
 7ea:	c3                   	ret    
