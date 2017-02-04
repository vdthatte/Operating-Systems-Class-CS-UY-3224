
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <printf>:

#define N  1000

void
printf(int fd, char *s, ...)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 08             	sub    $0x8,%esp
  write(fd, s, strlen(s));
   6:	83 ec 0c             	sub    $0xc,%esp
   9:	ff 75 0c             	pushl  0xc(%ebp)
   c:	e8 8a 01 00 00       	call   19b <strlen>
  11:	83 c4 10             	add    $0x10,%esp
  14:	83 ec 04             	sub    $0x4,%esp
  17:	50                   	push   %eax
  18:	ff 75 0c             	pushl  0xc(%ebp)
  1b:	ff 75 08             	pushl  0x8(%ebp)
  1e:	e8 4b 03 00 00       	call   36e <write>
  23:	83 c4 10             	add    $0x10,%esp
}
  26:	c9                   	leave  
  27:	c3                   	ret    

00000028 <forktest>:

void
forktest(void)
{
  28:	55                   	push   %ebp
  29:	89 e5                	mov    %esp,%ebp
  2b:	83 ec 18             	sub    $0x18,%esp
  int n, pid;

  printf(1, "fork test\n");
  2e:	83 ec 08             	sub    $0x8,%esp
  31:	68 f0 03 00 00       	push   $0x3f0
  36:	6a 01                	push   $0x1
  38:	e8 c3 ff ff ff       	call   0 <printf>
  3d:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<N; n++){
  40:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  47:	eb 1e                	jmp    67 <forktest+0x3f>
    pid = fork();
  49:	e8 f8 02 00 00       	call   346 <fork>
  4e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0)
  51:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  55:	79 02                	jns    59 <forktest+0x31>
      break;
  57:	eb 17                	jmp    70 <forktest+0x48>
    if(pid == 0)
  59:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  5d:	75 05                	jne    64 <forktest+0x3c>
      exit();
  5f:	e8 ea 02 00 00       	call   34e <exit>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<N; n++){
  64:	ff 45 f4             	incl   -0xc(%ebp)
  67:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
  6e:	7e d9                	jle    49 <forktest+0x21>
      break;
    if(pid == 0)
      exit();
  }
  
  if(n == N){
  70:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
  77:	75 1c                	jne    95 <forktest+0x6d>
    printf(1, "fork claimed to work N times!\n", N);
  79:	83 ec 04             	sub    $0x4,%esp
  7c:	68 e8 03 00 00       	push   $0x3e8
  81:	68 fc 03 00 00       	push   $0x3fc
  86:	6a 01                	push   $0x1
  88:	e8 73 ff ff ff       	call   0 <printf>
  8d:	83 c4 10             	add    $0x10,%esp
    exit();
  90:	e8 b9 02 00 00       	call   34e <exit>
  }
  
  for(; n > 0; n--){
  95:	eb 23                	jmp    ba <forktest+0x92>
    if(wait() < 0){
  97:	e8 ba 02 00 00       	call   356 <wait>
  9c:	85 c0                	test   %eax,%eax
  9e:	79 17                	jns    b7 <forktest+0x8f>
      printf(1, "wait stopped early\n");
  a0:	83 ec 08             	sub    $0x8,%esp
  a3:	68 1b 04 00 00       	push   $0x41b
  a8:	6a 01                	push   $0x1
  aa:	e8 51 ff ff ff       	call   0 <printf>
  af:	83 c4 10             	add    $0x10,%esp
      exit();
  b2:	e8 97 02 00 00       	call   34e <exit>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit();
  }
  
  for(; n > 0; n--){
  b7:	ff 4d f4             	decl   -0xc(%ebp)
  ba:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  be:	7f d7                	jg     97 <forktest+0x6f>
      printf(1, "wait stopped early\n");
      exit();
    }
  }
  
  if(wait() != -1){
  c0:	e8 91 02 00 00       	call   356 <wait>
  c5:	83 f8 ff             	cmp    $0xffffffff,%eax
  c8:	74 17                	je     e1 <forktest+0xb9>
    printf(1, "wait got too many\n");
  ca:	83 ec 08             	sub    $0x8,%esp
  cd:	68 2f 04 00 00       	push   $0x42f
  d2:	6a 01                	push   $0x1
  d4:	e8 27 ff ff ff       	call   0 <printf>
  d9:	83 c4 10             	add    $0x10,%esp
    exit();
  dc:	e8 6d 02 00 00       	call   34e <exit>
  }
  
  printf(1, "fork test OK\n");
  e1:	83 ec 08             	sub    $0x8,%esp
  e4:	68 42 04 00 00       	push   $0x442
  e9:	6a 01                	push   $0x1
  eb:	e8 10 ff ff ff       	call   0 <printf>
  f0:	83 c4 10             	add    $0x10,%esp
}
  f3:	c9                   	leave  
  f4:	c3                   	ret    

000000f5 <main>:

int
main(void)
{
  f5:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  f9:	83 e4 f0             	and    $0xfffffff0,%esp
  fc:	ff 71 fc             	pushl  -0x4(%ecx)
  ff:	55                   	push   %ebp
 100:	89 e5                	mov    %esp,%ebp
 102:	51                   	push   %ecx
 103:	83 ec 04             	sub    $0x4,%esp
  forktest();
 106:	e8 1d ff ff ff       	call   28 <forktest>
  exit();
 10b:	e8 3e 02 00 00       	call   34e <exit>

00000110 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 115:	8b 4d 08             	mov    0x8(%ebp),%ecx
 118:	8b 55 10             	mov    0x10(%ebp),%edx
 11b:	8b 45 0c             	mov    0xc(%ebp),%eax
 11e:	89 cb                	mov    %ecx,%ebx
 120:	89 df                	mov    %ebx,%edi
 122:	89 d1                	mov    %edx,%ecx
 124:	fc                   	cld    
 125:	f3 aa                	rep stos %al,%es:(%edi)
 127:	89 ca                	mov    %ecx,%edx
 129:	89 fb                	mov    %edi,%ebx
 12b:	89 5d 08             	mov    %ebx,0x8(%ebp)
 12e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 131:	5b                   	pop    %ebx
 132:	5f                   	pop    %edi
 133:	5d                   	pop    %ebp
 134:	c3                   	ret    

00000135 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 135:	55                   	push   %ebp
 136:	89 e5                	mov    %esp,%ebp
 138:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 13b:	8b 45 08             	mov    0x8(%ebp),%eax
 13e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 141:	90                   	nop
 142:	8b 45 08             	mov    0x8(%ebp),%eax
 145:	8d 50 01             	lea    0x1(%eax),%edx
 148:	89 55 08             	mov    %edx,0x8(%ebp)
 14b:	8b 55 0c             	mov    0xc(%ebp),%edx
 14e:	8d 4a 01             	lea    0x1(%edx),%ecx
 151:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 154:	8a 12                	mov    (%edx),%dl
 156:	88 10                	mov    %dl,(%eax)
 158:	8a 00                	mov    (%eax),%al
 15a:	84 c0                	test   %al,%al
 15c:	75 e4                	jne    142 <strcpy+0xd>
    ;
  return os;
 15e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 161:	c9                   	leave  
 162:	c3                   	ret    

00000163 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 163:	55                   	push   %ebp
 164:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 166:	eb 06                	jmp    16e <strcmp+0xb>
    p++, q++;
 168:	ff 45 08             	incl   0x8(%ebp)
 16b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 16e:	8b 45 08             	mov    0x8(%ebp),%eax
 171:	8a 00                	mov    (%eax),%al
 173:	84 c0                	test   %al,%al
 175:	74 0e                	je     185 <strcmp+0x22>
 177:	8b 45 08             	mov    0x8(%ebp),%eax
 17a:	8a 10                	mov    (%eax),%dl
 17c:	8b 45 0c             	mov    0xc(%ebp),%eax
 17f:	8a 00                	mov    (%eax),%al
 181:	38 c2                	cmp    %al,%dl
 183:	74 e3                	je     168 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 185:	8b 45 08             	mov    0x8(%ebp),%eax
 188:	8a 00                	mov    (%eax),%al
 18a:	0f b6 d0             	movzbl %al,%edx
 18d:	8b 45 0c             	mov    0xc(%ebp),%eax
 190:	8a 00                	mov    (%eax),%al
 192:	0f b6 c0             	movzbl %al,%eax
 195:	29 c2                	sub    %eax,%edx
 197:	89 d0                	mov    %edx,%eax
}
 199:	5d                   	pop    %ebp
 19a:	c3                   	ret    

0000019b <strlen>:

uint
strlen(char *s)
{
 19b:	55                   	push   %ebp
 19c:	89 e5                	mov    %esp,%ebp
 19e:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1a8:	eb 03                	jmp    1ad <strlen+0x12>
 1aa:	ff 45 fc             	incl   -0x4(%ebp)
 1ad:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1b0:	8b 45 08             	mov    0x8(%ebp),%eax
 1b3:	01 d0                	add    %edx,%eax
 1b5:	8a 00                	mov    (%eax),%al
 1b7:	84 c0                	test   %al,%al
 1b9:	75 ef                	jne    1aa <strlen+0xf>
    ;
  return n;
 1bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1be:	c9                   	leave  
 1bf:	c3                   	ret    

000001c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1c3:	8b 45 10             	mov    0x10(%ebp),%eax
 1c6:	50                   	push   %eax
 1c7:	ff 75 0c             	pushl  0xc(%ebp)
 1ca:	ff 75 08             	pushl  0x8(%ebp)
 1cd:	e8 3e ff ff ff       	call   110 <stosb>
 1d2:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1d5:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1d8:	c9                   	leave  
 1d9:	c3                   	ret    

000001da <strchr>:

char*
strchr(const char *s, char c)
{
 1da:	55                   	push   %ebp
 1db:	89 e5                	mov    %esp,%ebp
 1dd:	83 ec 04             	sub    $0x4,%esp
 1e0:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e3:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1e6:	eb 12                	jmp    1fa <strchr+0x20>
    if(*s == c)
 1e8:	8b 45 08             	mov    0x8(%ebp),%eax
 1eb:	8a 00                	mov    (%eax),%al
 1ed:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1f0:	75 05                	jne    1f7 <strchr+0x1d>
      return (char*)s;
 1f2:	8b 45 08             	mov    0x8(%ebp),%eax
 1f5:	eb 11                	jmp    208 <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1f7:	ff 45 08             	incl   0x8(%ebp)
 1fa:	8b 45 08             	mov    0x8(%ebp),%eax
 1fd:	8a 00                	mov    (%eax),%al
 1ff:	84 c0                	test   %al,%al
 201:	75 e5                	jne    1e8 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 203:	b8 00 00 00 00       	mov    $0x0,%eax
}
 208:	c9                   	leave  
 209:	c3                   	ret    

0000020a <gets>:

char*
gets(char *buf, int max)
{
 20a:	55                   	push   %ebp
 20b:	89 e5                	mov    %esp,%ebp
 20d:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 210:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 217:	eb 41                	jmp    25a <gets+0x50>
    cc = read(0, &c, 1);
 219:	83 ec 04             	sub    $0x4,%esp
 21c:	6a 01                	push   $0x1
 21e:	8d 45 ef             	lea    -0x11(%ebp),%eax
 221:	50                   	push   %eax
 222:	6a 00                	push   $0x0
 224:	e8 3d 01 00 00       	call   366 <read>
 229:	83 c4 10             	add    $0x10,%esp
 22c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 22f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 233:	7f 02                	jg     237 <gets+0x2d>
      break;
 235:	eb 2c                	jmp    263 <gets+0x59>
    buf[i++] = c;
 237:	8b 45 f4             	mov    -0xc(%ebp),%eax
 23a:	8d 50 01             	lea    0x1(%eax),%edx
 23d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 240:	89 c2                	mov    %eax,%edx
 242:	8b 45 08             	mov    0x8(%ebp),%eax
 245:	01 c2                	add    %eax,%edx
 247:	8a 45 ef             	mov    -0x11(%ebp),%al
 24a:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 24c:	8a 45 ef             	mov    -0x11(%ebp),%al
 24f:	3c 0a                	cmp    $0xa,%al
 251:	74 10                	je     263 <gets+0x59>
 253:	8a 45 ef             	mov    -0x11(%ebp),%al
 256:	3c 0d                	cmp    $0xd,%al
 258:	74 09                	je     263 <gets+0x59>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 25a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 25d:	40                   	inc    %eax
 25e:	3b 45 0c             	cmp    0xc(%ebp),%eax
 261:	7c b6                	jl     219 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 263:	8b 55 f4             	mov    -0xc(%ebp),%edx
 266:	8b 45 08             	mov    0x8(%ebp),%eax
 269:	01 d0                	add    %edx,%eax
 26b:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 26e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 271:	c9                   	leave  
 272:	c3                   	ret    

00000273 <stat>:

int
stat(char *n, struct stat *st)
{
 273:	55                   	push   %ebp
 274:	89 e5                	mov    %esp,%ebp
 276:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 279:	83 ec 08             	sub    $0x8,%esp
 27c:	6a 00                	push   $0x0
 27e:	ff 75 08             	pushl  0x8(%ebp)
 281:	e8 08 01 00 00       	call   38e <open>
 286:	83 c4 10             	add    $0x10,%esp
 289:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 28c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 290:	79 07                	jns    299 <stat+0x26>
    return -1;
 292:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 297:	eb 25                	jmp    2be <stat+0x4b>
  r = fstat(fd, st);
 299:	83 ec 08             	sub    $0x8,%esp
 29c:	ff 75 0c             	pushl  0xc(%ebp)
 29f:	ff 75 f4             	pushl  -0xc(%ebp)
 2a2:	e8 ff 00 00 00       	call   3a6 <fstat>
 2a7:	83 c4 10             	add    $0x10,%esp
 2aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2ad:	83 ec 0c             	sub    $0xc,%esp
 2b0:	ff 75 f4             	pushl  -0xc(%ebp)
 2b3:	e8 be 00 00 00       	call   376 <close>
 2b8:	83 c4 10             	add    $0x10,%esp
  return r;
 2bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2be:	c9                   	leave  
 2bf:	c3                   	ret    

000002c0 <atoi>:

int
atoi(const char *s)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2cd:	eb 24                	jmp    2f3 <atoi+0x33>
    n = n*10 + *s++ - '0';
 2cf:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2d2:	89 d0                	mov    %edx,%eax
 2d4:	c1 e0 02             	shl    $0x2,%eax
 2d7:	01 d0                	add    %edx,%eax
 2d9:	01 c0                	add    %eax,%eax
 2db:	89 c1                	mov    %eax,%ecx
 2dd:	8b 45 08             	mov    0x8(%ebp),%eax
 2e0:	8d 50 01             	lea    0x1(%eax),%edx
 2e3:	89 55 08             	mov    %edx,0x8(%ebp)
 2e6:	8a 00                	mov    (%eax),%al
 2e8:	0f be c0             	movsbl %al,%eax
 2eb:	01 c8                	add    %ecx,%eax
 2ed:	83 e8 30             	sub    $0x30,%eax
 2f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2f3:	8b 45 08             	mov    0x8(%ebp),%eax
 2f6:	8a 00                	mov    (%eax),%al
 2f8:	3c 2f                	cmp    $0x2f,%al
 2fa:	7e 09                	jle    305 <atoi+0x45>
 2fc:	8b 45 08             	mov    0x8(%ebp),%eax
 2ff:	8a 00                	mov    (%eax),%al
 301:	3c 39                	cmp    $0x39,%al
 303:	7e ca                	jle    2cf <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 305:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 308:	c9                   	leave  
 309:	c3                   	ret    

0000030a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 30a:	55                   	push   %ebp
 30b:	89 e5                	mov    %esp,%ebp
 30d:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 310:	8b 45 08             	mov    0x8(%ebp),%eax
 313:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 316:	8b 45 0c             	mov    0xc(%ebp),%eax
 319:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 31c:	eb 16                	jmp    334 <memmove+0x2a>
    *dst++ = *src++;
 31e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 321:	8d 50 01             	lea    0x1(%eax),%edx
 324:	89 55 fc             	mov    %edx,-0x4(%ebp)
 327:	8b 55 f8             	mov    -0x8(%ebp),%edx
 32a:	8d 4a 01             	lea    0x1(%edx),%ecx
 32d:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 330:	8a 12                	mov    (%edx),%dl
 332:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 334:	8b 45 10             	mov    0x10(%ebp),%eax
 337:	8d 50 ff             	lea    -0x1(%eax),%edx
 33a:	89 55 10             	mov    %edx,0x10(%ebp)
 33d:	85 c0                	test   %eax,%eax
 33f:	7f dd                	jg     31e <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 341:	8b 45 08             	mov    0x8(%ebp),%eax
}
 344:	c9                   	leave  
 345:	c3                   	ret    

00000346 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 346:	b8 01 00 00 00       	mov    $0x1,%eax
 34b:	cd 40                	int    $0x40
 34d:	c3                   	ret    

0000034e <exit>:
SYSCALL(exit)
 34e:	b8 02 00 00 00       	mov    $0x2,%eax
 353:	cd 40                	int    $0x40
 355:	c3                   	ret    

00000356 <wait>:
SYSCALL(wait)
 356:	b8 03 00 00 00       	mov    $0x3,%eax
 35b:	cd 40                	int    $0x40
 35d:	c3                   	ret    

0000035e <pipe>:
SYSCALL(pipe)
 35e:	b8 04 00 00 00       	mov    $0x4,%eax
 363:	cd 40                	int    $0x40
 365:	c3                   	ret    

00000366 <read>:
SYSCALL(read)
 366:	b8 05 00 00 00       	mov    $0x5,%eax
 36b:	cd 40                	int    $0x40
 36d:	c3                   	ret    

0000036e <write>:
SYSCALL(write)
 36e:	b8 10 00 00 00       	mov    $0x10,%eax
 373:	cd 40                	int    $0x40
 375:	c3                   	ret    

00000376 <close>:
SYSCALL(close)
 376:	b8 15 00 00 00       	mov    $0x15,%eax
 37b:	cd 40                	int    $0x40
 37d:	c3                   	ret    

0000037e <kill>:
SYSCALL(kill)
 37e:	b8 06 00 00 00       	mov    $0x6,%eax
 383:	cd 40                	int    $0x40
 385:	c3                   	ret    

00000386 <exec>:
SYSCALL(exec)
 386:	b8 07 00 00 00       	mov    $0x7,%eax
 38b:	cd 40                	int    $0x40
 38d:	c3                   	ret    

0000038e <open>:
SYSCALL(open)
 38e:	b8 0f 00 00 00       	mov    $0xf,%eax
 393:	cd 40                	int    $0x40
 395:	c3                   	ret    

00000396 <mknod>:
SYSCALL(mknod)
 396:	b8 11 00 00 00       	mov    $0x11,%eax
 39b:	cd 40                	int    $0x40
 39d:	c3                   	ret    

0000039e <unlink>:
SYSCALL(unlink)
 39e:	b8 12 00 00 00       	mov    $0x12,%eax
 3a3:	cd 40                	int    $0x40
 3a5:	c3                   	ret    

000003a6 <fstat>:
SYSCALL(fstat)
 3a6:	b8 08 00 00 00       	mov    $0x8,%eax
 3ab:	cd 40                	int    $0x40
 3ad:	c3                   	ret    

000003ae <link>:
SYSCALL(link)
 3ae:	b8 13 00 00 00       	mov    $0x13,%eax
 3b3:	cd 40                	int    $0x40
 3b5:	c3                   	ret    

000003b6 <mkdir>:
SYSCALL(mkdir)
 3b6:	b8 14 00 00 00       	mov    $0x14,%eax
 3bb:	cd 40                	int    $0x40
 3bd:	c3                   	ret    

000003be <chdir>:
SYSCALL(chdir)
 3be:	b8 09 00 00 00       	mov    $0x9,%eax
 3c3:	cd 40                	int    $0x40
 3c5:	c3                   	ret    

000003c6 <dup>:
SYSCALL(dup)
 3c6:	b8 0a 00 00 00       	mov    $0xa,%eax
 3cb:	cd 40                	int    $0x40
 3cd:	c3                   	ret    

000003ce <getpid>:
SYSCALL(getpid)
 3ce:	b8 0b 00 00 00       	mov    $0xb,%eax
 3d3:	cd 40                	int    $0x40
 3d5:	c3                   	ret    

000003d6 <sbrk>:
SYSCALL(sbrk)
 3d6:	b8 0c 00 00 00       	mov    $0xc,%eax
 3db:	cd 40                	int    $0x40
 3dd:	c3                   	ret    

000003de <sleep>:
SYSCALL(sleep)
 3de:	b8 0d 00 00 00       	mov    $0xd,%eax
 3e3:	cd 40                	int    $0x40
 3e5:	c3                   	ret    

000003e6 <uptime>:
SYSCALL(uptime)
 3e6:	b8 0e 00 00 00       	mov    $0xe,%eax
 3eb:	cd 40                	int    $0x40
 3ed:	c3                   	ret    
