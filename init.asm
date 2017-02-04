
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 14             	sub    $0x14,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
  11:	83 ec 08             	sub    $0x8,%esp
  14:	6a 02                	push   $0x2
  16:	68 5e 08 00 00       	push   $0x85e
  1b:	e8 5d 03 00 00       	call   37d <open>
  20:	83 c4 10             	add    $0x10,%esp
  23:	85 c0                	test   %eax,%eax
  25:	79 26                	jns    4d <main+0x4d>
    mknod("console", 1, 1);
  27:	83 ec 04             	sub    $0x4,%esp
  2a:	6a 01                	push   $0x1
  2c:	6a 01                	push   $0x1
  2e:	68 5e 08 00 00       	push   $0x85e
  33:	e8 4d 03 00 00       	call   385 <mknod>
  38:	83 c4 10             	add    $0x10,%esp
    open("console", O_RDWR);
  3b:	83 ec 08             	sub    $0x8,%esp
  3e:	6a 02                	push   $0x2
  40:	68 5e 08 00 00       	push   $0x85e
  45:	e8 33 03 00 00       	call   37d <open>
  4a:	83 c4 10             	add    $0x10,%esp
  }
  dup(0);  // stdout
  4d:	83 ec 0c             	sub    $0xc,%esp
  50:	6a 00                	push   $0x0
  52:	e8 5e 03 00 00       	call   3b5 <dup>
  57:	83 c4 10             	add    $0x10,%esp
  dup(0);  // stderr
  5a:	83 ec 0c             	sub    $0xc,%esp
  5d:	6a 00                	push   $0x0
  5f:	e8 51 03 00 00       	call   3b5 <dup>
  64:	83 c4 10             	add    $0x10,%esp

  for(;;){
    printf(1, "init: starting sh\n");
  67:	83 ec 08             	sub    $0x8,%esp
  6a:	68 66 08 00 00       	push   $0x866
  6f:	6a 01                	push   $0x1
  71:	e8 39 04 00 00       	call   4af <printf>
  76:	83 c4 10             	add    $0x10,%esp
    pid = fork();
  79:	e8 b7 02 00 00       	call   335 <fork>
  7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(pid < 0){
  81:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  85:	79 17                	jns    9e <main+0x9e>
      printf(1, "init: fork failed\n");
  87:	83 ec 08             	sub    $0x8,%esp
  8a:	68 79 08 00 00       	push   $0x879
  8f:	6a 01                	push   $0x1
  91:	e8 19 04 00 00       	call   4af <printf>
  96:	83 c4 10             	add    $0x10,%esp
      exit();
  99:	e8 9f 02 00 00       	call   33d <exit>
    }
    if(pid == 0){
  9e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  a2:	75 2c                	jne    d0 <main+0xd0>
      exec("sh", argv);
  a4:	83 ec 08             	sub    $0x8,%esp
  a7:	68 fc 0a 00 00       	push   $0xafc
  ac:	68 5b 08 00 00       	push   $0x85b
  b1:	e8 bf 02 00 00       	call   375 <exec>
  b6:	83 c4 10             	add    $0x10,%esp
      printf(1, "init: exec sh failed\n");
  b9:	83 ec 08             	sub    $0x8,%esp
  bc:	68 8c 08 00 00       	push   $0x88c
  c1:	6a 01                	push   $0x1
  c3:	e8 e7 03 00 00       	call   4af <printf>
  c8:	83 c4 10             	add    $0x10,%esp
      exit();
  cb:	e8 6d 02 00 00       	call   33d <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  d0:	eb 12                	jmp    e4 <main+0xe4>
      printf(1, "zombie!\n");
  d2:	83 ec 08             	sub    $0x8,%esp
  d5:	68 a2 08 00 00       	push   $0x8a2
  da:	6a 01                	push   $0x1
  dc:	e8 ce 03 00 00       	call   4af <printf>
  e1:	83 c4 10             	add    $0x10,%esp
    if(pid == 0){
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  e4:	e8 5c 02 00 00       	call   345 <wait>
  e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  f0:	78 08                	js     fa <main+0xfa>
  f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  f5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  f8:	75 d8                	jne    d2 <main+0xd2>
      printf(1, "zombie!\n");
  }
  fa:	e9 68 ff ff ff       	jmp    67 <main+0x67>

000000ff <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  ff:	55                   	push   %ebp
 100:	89 e5                	mov    %esp,%ebp
 102:	57                   	push   %edi
 103:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 104:	8b 4d 08             	mov    0x8(%ebp),%ecx
 107:	8b 55 10             	mov    0x10(%ebp),%edx
 10a:	8b 45 0c             	mov    0xc(%ebp),%eax
 10d:	89 cb                	mov    %ecx,%ebx
 10f:	89 df                	mov    %ebx,%edi
 111:	89 d1                	mov    %edx,%ecx
 113:	fc                   	cld    
 114:	f3 aa                	rep stos %al,%es:(%edi)
 116:	89 ca                	mov    %ecx,%edx
 118:	89 fb                	mov    %edi,%ebx
 11a:	89 5d 08             	mov    %ebx,0x8(%ebp)
 11d:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 120:	5b                   	pop    %ebx
 121:	5f                   	pop    %edi
 122:	5d                   	pop    %ebp
 123:	c3                   	ret    

00000124 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 124:	55                   	push   %ebp
 125:	89 e5                	mov    %esp,%ebp
 127:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 12a:	8b 45 08             	mov    0x8(%ebp),%eax
 12d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 130:	90                   	nop
 131:	8b 45 08             	mov    0x8(%ebp),%eax
 134:	8d 50 01             	lea    0x1(%eax),%edx
 137:	89 55 08             	mov    %edx,0x8(%ebp)
 13a:	8b 55 0c             	mov    0xc(%ebp),%edx
 13d:	8d 4a 01             	lea    0x1(%edx),%ecx
 140:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 143:	8a 12                	mov    (%edx),%dl
 145:	88 10                	mov    %dl,(%eax)
 147:	8a 00                	mov    (%eax),%al
 149:	84 c0                	test   %al,%al
 14b:	75 e4                	jne    131 <strcpy+0xd>
    ;
  return os;
 14d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 150:	c9                   	leave  
 151:	c3                   	ret    

00000152 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 152:	55                   	push   %ebp
 153:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 155:	eb 06                	jmp    15d <strcmp+0xb>
    p++, q++;
 157:	ff 45 08             	incl   0x8(%ebp)
 15a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 15d:	8b 45 08             	mov    0x8(%ebp),%eax
 160:	8a 00                	mov    (%eax),%al
 162:	84 c0                	test   %al,%al
 164:	74 0e                	je     174 <strcmp+0x22>
 166:	8b 45 08             	mov    0x8(%ebp),%eax
 169:	8a 10                	mov    (%eax),%dl
 16b:	8b 45 0c             	mov    0xc(%ebp),%eax
 16e:	8a 00                	mov    (%eax),%al
 170:	38 c2                	cmp    %al,%dl
 172:	74 e3                	je     157 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 174:	8b 45 08             	mov    0x8(%ebp),%eax
 177:	8a 00                	mov    (%eax),%al
 179:	0f b6 d0             	movzbl %al,%edx
 17c:	8b 45 0c             	mov    0xc(%ebp),%eax
 17f:	8a 00                	mov    (%eax),%al
 181:	0f b6 c0             	movzbl %al,%eax
 184:	29 c2                	sub    %eax,%edx
 186:	89 d0                	mov    %edx,%eax
}
 188:	5d                   	pop    %ebp
 189:	c3                   	ret    

0000018a <strlen>:

uint
strlen(char *s)
{
 18a:	55                   	push   %ebp
 18b:	89 e5                	mov    %esp,%ebp
 18d:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 190:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 197:	eb 03                	jmp    19c <strlen+0x12>
 199:	ff 45 fc             	incl   -0x4(%ebp)
 19c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 19f:	8b 45 08             	mov    0x8(%ebp),%eax
 1a2:	01 d0                	add    %edx,%eax
 1a4:	8a 00                	mov    (%eax),%al
 1a6:	84 c0                	test   %al,%al
 1a8:	75 ef                	jne    199 <strlen+0xf>
    ;
  return n;
 1aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1ad:	c9                   	leave  
 1ae:	c3                   	ret    

000001af <memset>:

void*
memset(void *dst, int c, uint n)
{
 1af:	55                   	push   %ebp
 1b0:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1b2:	8b 45 10             	mov    0x10(%ebp),%eax
 1b5:	50                   	push   %eax
 1b6:	ff 75 0c             	pushl  0xc(%ebp)
 1b9:	ff 75 08             	pushl  0x8(%ebp)
 1bc:	e8 3e ff ff ff       	call   ff <stosb>
 1c1:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1c4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1c7:	c9                   	leave  
 1c8:	c3                   	ret    

000001c9 <strchr>:

char*
strchr(const char *s, char c)
{
 1c9:	55                   	push   %ebp
 1ca:	89 e5                	mov    %esp,%ebp
 1cc:	83 ec 04             	sub    $0x4,%esp
 1cf:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d2:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1d5:	eb 12                	jmp    1e9 <strchr+0x20>
    if(*s == c)
 1d7:	8b 45 08             	mov    0x8(%ebp),%eax
 1da:	8a 00                	mov    (%eax),%al
 1dc:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1df:	75 05                	jne    1e6 <strchr+0x1d>
      return (char*)s;
 1e1:	8b 45 08             	mov    0x8(%ebp),%eax
 1e4:	eb 11                	jmp    1f7 <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1e6:	ff 45 08             	incl   0x8(%ebp)
 1e9:	8b 45 08             	mov    0x8(%ebp),%eax
 1ec:	8a 00                	mov    (%eax),%al
 1ee:	84 c0                	test   %al,%al
 1f0:	75 e5                	jne    1d7 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 1f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1f7:	c9                   	leave  
 1f8:	c3                   	ret    

000001f9 <gets>:

char*
gets(char *buf, int max)
{
 1f9:	55                   	push   %ebp
 1fa:	89 e5                	mov    %esp,%ebp
 1fc:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 206:	eb 41                	jmp    249 <gets+0x50>
    cc = read(0, &c, 1);
 208:	83 ec 04             	sub    $0x4,%esp
 20b:	6a 01                	push   $0x1
 20d:	8d 45 ef             	lea    -0x11(%ebp),%eax
 210:	50                   	push   %eax
 211:	6a 00                	push   $0x0
 213:	e8 3d 01 00 00       	call   355 <read>
 218:	83 c4 10             	add    $0x10,%esp
 21b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 21e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 222:	7f 02                	jg     226 <gets+0x2d>
      break;
 224:	eb 2c                	jmp    252 <gets+0x59>
    buf[i++] = c;
 226:	8b 45 f4             	mov    -0xc(%ebp),%eax
 229:	8d 50 01             	lea    0x1(%eax),%edx
 22c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 22f:	89 c2                	mov    %eax,%edx
 231:	8b 45 08             	mov    0x8(%ebp),%eax
 234:	01 c2                	add    %eax,%edx
 236:	8a 45 ef             	mov    -0x11(%ebp),%al
 239:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 23b:	8a 45 ef             	mov    -0x11(%ebp),%al
 23e:	3c 0a                	cmp    $0xa,%al
 240:	74 10                	je     252 <gets+0x59>
 242:	8a 45 ef             	mov    -0x11(%ebp),%al
 245:	3c 0d                	cmp    $0xd,%al
 247:	74 09                	je     252 <gets+0x59>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 249:	8b 45 f4             	mov    -0xc(%ebp),%eax
 24c:	40                   	inc    %eax
 24d:	3b 45 0c             	cmp    0xc(%ebp),%eax
 250:	7c b6                	jl     208 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 252:	8b 55 f4             	mov    -0xc(%ebp),%edx
 255:	8b 45 08             	mov    0x8(%ebp),%eax
 258:	01 d0                	add    %edx,%eax
 25a:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 25d:	8b 45 08             	mov    0x8(%ebp),%eax
}
 260:	c9                   	leave  
 261:	c3                   	ret    

00000262 <stat>:

int
stat(char *n, struct stat *st)
{
 262:	55                   	push   %ebp
 263:	89 e5                	mov    %esp,%ebp
 265:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 268:	83 ec 08             	sub    $0x8,%esp
 26b:	6a 00                	push   $0x0
 26d:	ff 75 08             	pushl  0x8(%ebp)
 270:	e8 08 01 00 00       	call   37d <open>
 275:	83 c4 10             	add    $0x10,%esp
 278:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 27b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 27f:	79 07                	jns    288 <stat+0x26>
    return -1;
 281:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 286:	eb 25                	jmp    2ad <stat+0x4b>
  r = fstat(fd, st);
 288:	83 ec 08             	sub    $0x8,%esp
 28b:	ff 75 0c             	pushl  0xc(%ebp)
 28e:	ff 75 f4             	pushl  -0xc(%ebp)
 291:	e8 ff 00 00 00       	call   395 <fstat>
 296:	83 c4 10             	add    $0x10,%esp
 299:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 29c:	83 ec 0c             	sub    $0xc,%esp
 29f:	ff 75 f4             	pushl  -0xc(%ebp)
 2a2:	e8 be 00 00 00       	call   365 <close>
 2a7:	83 c4 10             	add    $0x10,%esp
  return r;
 2aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2ad:	c9                   	leave  
 2ae:	c3                   	ret    

000002af <atoi>:

int
atoi(const char *s)
{
 2af:	55                   	push   %ebp
 2b0:	89 e5                	mov    %esp,%ebp
 2b2:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2b5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2bc:	eb 24                	jmp    2e2 <atoi+0x33>
    n = n*10 + *s++ - '0';
 2be:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2c1:	89 d0                	mov    %edx,%eax
 2c3:	c1 e0 02             	shl    $0x2,%eax
 2c6:	01 d0                	add    %edx,%eax
 2c8:	01 c0                	add    %eax,%eax
 2ca:	89 c1                	mov    %eax,%ecx
 2cc:	8b 45 08             	mov    0x8(%ebp),%eax
 2cf:	8d 50 01             	lea    0x1(%eax),%edx
 2d2:	89 55 08             	mov    %edx,0x8(%ebp)
 2d5:	8a 00                	mov    (%eax),%al
 2d7:	0f be c0             	movsbl %al,%eax
 2da:	01 c8                	add    %ecx,%eax
 2dc:	83 e8 30             	sub    $0x30,%eax
 2df:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2e2:	8b 45 08             	mov    0x8(%ebp),%eax
 2e5:	8a 00                	mov    (%eax),%al
 2e7:	3c 2f                	cmp    $0x2f,%al
 2e9:	7e 09                	jle    2f4 <atoi+0x45>
 2eb:	8b 45 08             	mov    0x8(%ebp),%eax
 2ee:	8a 00                	mov    (%eax),%al
 2f0:	3c 39                	cmp    $0x39,%al
 2f2:	7e ca                	jle    2be <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 2f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2f7:	c9                   	leave  
 2f8:	c3                   	ret    

000002f9 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2f9:	55                   	push   %ebp
 2fa:	89 e5                	mov    %esp,%ebp
 2fc:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2ff:	8b 45 08             	mov    0x8(%ebp),%eax
 302:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 305:	8b 45 0c             	mov    0xc(%ebp),%eax
 308:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 30b:	eb 16                	jmp    323 <memmove+0x2a>
    *dst++ = *src++;
 30d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 310:	8d 50 01             	lea    0x1(%eax),%edx
 313:	89 55 fc             	mov    %edx,-0x4(%ebp)
 316:	8b 55 f8             	mov    -0x8(%ebp),%edx
 319:	8d 4a 01             	lea    0x1(%edx),%ecx
 31c:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 31f:	8a 12                	mov    (%edx),%dl
 321:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 323:	8b 45 10             	mov    0x10(%ebp),%eax
 326:	8d 50 ff             	lea    -0x1(%eax),%edx
 329:	89 55 10             	mov    %edx,0x10(%ebp)
 32c:	85 c0                	test   %eax,%eax
 32e:	7f dd                	jg     30d <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 330:	8b 45 08             	mov    0x8(%ebp),%eax
}
 333:	c9                   	leave  
 334:	c3                   	ret    

00000335 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 335:	b8 01 00 00 00       	mov    $0x1,%eax
 33a:	cd 40                	int    $0x40
 33c:	c3                   	ret    

0000033d <exit>:
SYSCALL(exit)
 33d:	b8 02 00 00 00       	mov    $0x2,%eax
 342:	cd 40                	int    $0x40
 344:	c3                   	ret    

00000345 <wait>:
SYSCALL(wait)
 345:	b8 03 00 00 00       	mov    $0x3,%eax
 34a:	cd 40                	int    $0x40
 34c:	c3                   	ret    

0000034d <pipe>:
SYSCALL(pipe)
 34d:	b8 04 00 00 00       	mov    $0x4,%eax
 352:	cd 40                	int    $0x40
 354:	c3                   	ret    

00000355 <read>:
SYSCALL(read)
 355:	b8 05 00 00 00       	mov    $0x5,%eax
 35a:	cd 40                	int    $0x40
 35c:	c3                   	ret    

0000035d <write>:
SYSCALL(write)
 35d:	b8 10 00 00 00       	mov    $0x10,%eax
 362:	cd 40                	int    $0x40
 364:	c3                   	ret    

00000365 <close>:
SYSCALL(close)
 365:	b8 15 00 00 00       	mov    $0x15,%eax
 36a:	cd 40                	int    $0x40
 36c:	c3                   	ret    

0000036d <kill>:
SYSCALL(kill)
 36d:	b8 06 00 00 00       	mov    $0x6,%eax
 372:	cd 40                	int    $0x40
 374:	c3                   	ret    

00000375 <exec>:
SYSCALL(exec)
 375:	b8 07 00 00 00       	mov    $0x7,%eax
 37a:	cd 40                	int    $0x40
 37c:	c3                   	ret    

0000037d <open>:
SYSCALL(open)
 37d:	b8 0f 00 00 00       	mov    $0xf,%eax
 382:	cd 40                	int    $0x40
 384:	c3                   	ret    

00000385 <mknod>:
SYSCALL(mknod)
 385:	b8 11 00 00 00       	mov    $0x11,%eax
 38a:	cd 40                	int    $0x40
 38c:	c3                   	ret    

0000038d <unlink>:
SYSCALL(unlink)
 38d:	b8 12 00 00 00       	mov    $0x12,%eax
 392:	cd 40                	int    $0x40
 394:	c3                   	ret    

00000395 <fstat>:
SYSCALL(fstat)
 395:	b8 08 00 00 00       	mov    $0x8,%eax
 39a:	cd 40                	int    $0x40
 39c:	c3                   	ret    

0000039d <link>:
SYSCALL(link)
 39d:	b8 13 00 00 00       	mov    $0x13,%eax
 3a2:	cd 40                	int    $0x40
 3a4:	c3                   	ret    

000003a5 <mkdir>:
SYSCALL(mkdir)
 3a5:	b8 14 00 00 00       	mov    $0x14,%eax
 3aa:	cd 40                	int    $0x40
 3ac:	c3                   	ret    

000003ad <chdir>:
SYSCALL(chdir)
 3ad:	b8 09 00 00 00       	mov    $0x9,%eax
 3b2:	cd 40                	int    $0x40
 3b4:	c3                   	ret    

000003b5 <dup>:
SYSCALL(dup)
 3b5:	b8 0a 00 00 00       	mov    $0xa,%eax
 3ba:	cd 40                	int    $0x40
 3bc:	c3                   	ret    

000003bd <getpid>:
SYSCALL(getpid)
 3bd:	b8 0b 00 00 00       	mov    $0xb,%eax
 3c2:	cd 40                	int    $0x40
 3c4:	c3                   	ret    

000003c5 <sbrk>:
SYSCALL(sbrk)
 3c5:	b8 0c 00 00 00       	mov    $0xc,%eax
 3ca:	cd 40                	int    $0x40
 3cc:	c3                   	ret    

000003cd <sleep>:
SYSCALL(sleep)
 3cd:	b8 0d 00 00 00       	mov    $0xd,%eax
 3d2:	cd 40                	int    $0x40
 3d4:	c3                   	ret    

000003d5 <uptime>:
SYSCALL(uptime)
 3d5:	b8 0e 00 00 00       	mov    $0xe,%eax
 3da:	cd 40                	int    $0x40
 3dc:	c3                   	ret    

000003dd <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3dd:	55                   	push   %ebp
 3de:	89 e5                	mov    %esp,%ebp
 3e0:	83 ec 18             	sub    $0x18,%esp
 3e3:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e6:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3e9:	83 ec 04             	sub    $0x4,%esp
 3ec:	6a 01                	push   $0x1
 3ee:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3f1:	50                   	push   %eax
 3f2:	ff 75 08             	pushl  0x8(%ebp)
 3f5:	e8 63 ff ff ff       	call   35d <write>
 3fa:	83 c4 10             	add    $0x10,%esp
}
 3fd:	c9                   	leave  
 3fe:	c3                   	ret    

000003ff <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3ff:	55                   	push   %ebp
 400:	89 e5                	mov    %esp,%ebp
 402:	53                   	push   %ebx
 403:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 406:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 40d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 411:	74 17                	je     42a <printint+0x2b>
 413:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 417:	79 11                	jns    42a <printint+0x2b>
    neg = 1;
 419:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 420:	8b 45 0c             	mov    0xc(%ebp),%eax
 423:	f7 d8                	neg    %eax
 425:	89 45 ec             	mov    %eax,-0x14(%ebp)
 428:	eb 06                	jmp    430 <printint+0x31>
  } else {
    x = xx;
 42a:	8b 45 0c             	mov    0xc(%ebp),%eax
 42d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 430:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 437:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 43a:	8d 41 01             	lea    0x1(%ecx),%eax
 43d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 440:	8b 5d 10             	mov    0x10(%ebp),%ebx
 443:	8b 45 ec             	mov    -0x14(%ebp),%eax
 446:	ba 00 00 00 00       	mov    $0x0,%edx
 44b:	f7 f3                	div    %ebx
 44d:	89 d0                	mov    %edx,%eax
 44f:	8a 80 04 0b 00 00    	mov    0xb04(%eax),%al
 455:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 459:	8b 5d 10             	mov    0x10(%ebp),%ebx
 45c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 45f:	ba 00 00 00 00       	mov    $0x0,%edx
 464:	f7 f3                	div    %ebx
 466:	89 45 ec             	mov    %eax,-0x14(%ebp)
 469:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 46d:	75 c8                	jne    437 <printint+0x38>
  if(neg)
 46f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 473:	74 0e                	je     483 <printint+0x84>
    buf[i++] = '-';
 475:	8b 45 f4             	mov    -0xc(%ebp),%eax
 478:	8d 50 01             	lea    0x1(%eax),%edx
 47b:	89 55 f4             	mov    %edx,-0xc(%ebp)
 47e:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 483:	eb 1c                	jmp    4a1 <printint+0xa2>
    putc(fd, buf[i]);
 485:	8d 55 dc             	lea    -0x24(%ebp),%edx
 488:	8b 45 f4             	mov    -0xc(%ebp),%eax
 48b:	01 d0                	add    %edx,%eax
 48d:	8a 00                	mov    (%eax),%al
 48f:	0f be c0             	movsbl %al,%eax
 492:	83 ec 08             	sub    $0x8,%esp
 495:	50                   	push   %eax
 496:	ff 75 08             	pushl  0x8(%ebp)
 499:	e8 3f ff ff ff       	call   3dd <putc>
 49e:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4a1:	ff 4d f4             	decl   -0xc(%ebp)
 4a4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4a8:	79 db                	jns    485 <printint+0x86>
    putc(fd, buf[i]);
}
 4aa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4ad:	c9                   	leave  
 4ae:	c3                   	ret    

000004af <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4af:	55                   	push   %ebp
 4b0:	89 e5                	mov    %esp,%ebp
 4b2:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4b5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4bc:	8d 45 0c             	lea    0xc(%ebp),%eax
 4bf:	83 c0 04             	add    $0x4,%eax
 4c2:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4c5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4cc:	e9 54 01 00 00       	jmp    625 <printf+0x176>
    c = fmt[i] & 0xff;
 4d1:	8b 55 0c             	mov    0xc(%ebp),%edx
 4d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4d7:	01 d0                	add    %edx,%eax
 4d9:	8a 00                	mov    (%eax),%al
 4db:	0f be c0             	movsbl %al,%eax
 4de:	25 ff 00 00 00       	and    $0xff,%eax
 4e3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4e6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4ea:	75 2c                	jne    518 <printf+0x69>
      if(c == '%'){
 4ec:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4f0:	75 0c                	jne    4fe <printf+0x4f>
        state = '%';
 4f2:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4f9:	e9 24 01 00 00       	jmp    622 <printf+0x173>
      } else {
        putc(fd, c);
 4fe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 501:	0f be c0             	movsbl %al,%eax
 504:	83 ec 08             	sub    $0x8,%esp
 507:	50                   	push   %eax
 508:	ff 75 08             	pushl  0x8(%ebp)
 50b:	e8 cd fe ff ff       	call   3dd <putc>
 510:	83 c4 10             	add    $0x10,%esp
 513:	e9 0a 01 00 00       	jmp    622 <printf+0x173>
      }
    } else if(state == '%'){
 518:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 51c:	0f 85 00 01 00 00    	jne    622 <printf+0x173>
      if(c == 'd'){
 522:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 526:	75 1e                	jne    546 <printf+0x97>
        printint(fd, *ap, 10, 1);
 528:	8b 45 e8             	mov    -0x18(%ebp),%eax
 52b:	8b 00                	mov    (%eax),%eax
 52d:	6a 01                	push   $0x1
 52f:	6a 0a                	push   $0xa
 531:	50                   	push   %eax
 532:	ff 75 08             	pushl  0x8(%ebp)
 535:	e8 c5 fe ff ff       	call   3ff <printint>
 53a:	83 c4 10             	add    $0x10,%esp
        ap++;
 53d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 541:	e9 d5 00 00 00       	jmp    61b <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
 546:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 54a:	74 06                	je     552 <printf+0xa3>
 54c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 550:	75 1e                	jne    570 <printf+0xc1>
        printint(fd, *ap, 16, 0);
 552:	8b 45 e8             	mov    -0x18(%ebp),%eax
 555:	8b 00                	mov    (%eax),%eax
 557:	6a 00                	push   $0x0
 559:	6a 10                	push   $0x10
 55b:	50                   	push   %eax
 55c:	ff 75 08             	pushl  0x8(%ebp)
 55f:	e8 9b fe ff ff       	call   3ff <printint>
 564:	83 c4 10             	add    $0x10,%esp
        ap++;
 567:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 56b:	e9 ab 00 00 00       	jmp    61b <printf+0x16c>
      } else if(c == 's'){
 570:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 574:	75 40                	jne    5b6 <printf+0x107>
        s = (char*)*ap;
 576:	8b 45 e8             	mov    -0x18(%ebp),%eax
 579:	8b 00                	mov    (%eax),%eax
 57b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 57e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 582:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 586:	75 07                	jne    58f <printf+0xe0>
          s = "(null)";
 588:	c7 45 f4 ab 08 00 00 	movl   $0x8ab,-0xc(%ebp)
        while(*s != 0){
 58f:	eb 1a                	jmp    5ab <printf+0xfc>
          putc(fd, *s);
 591:	8b 45 f4             	mov    -0xc(%ebp),%eax
 594:	8a 00                	mov    (%eax),%al
 596:	0f be c0             	movsbl %al,%eax
 599:	83 ec 08             	sub    $0x8,%esp
 59c:	50                   	push   %eax
 59d:	ff 75 08             	pushl  0x8(%ebp)
 5a0:	e8 38 fe ff ff       	call   3dd <putc>
 5a5:	83 c4 10             	add    $0x10,%esp
          s++;
 5a8:	ff 45 f4             	incl   -0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ae:	8a 00                	mov    (%eax),%al
 5b0:	84 c0                	test   %al,%al
 5b2:	75 dd                	jne    591 <printf+0xe2>
 5b4:	eb 65                	jmp    61b <printf+0x16c>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5b6:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5ba:	75 1d                	jne    5d9 <printf+0x12a>
        putc(fd, *ap);
 5bc:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5bf:	8b 00                	mov    (%eax),%eax
 5c1:	0f be c0             	movsbl %al,%eax
 5c4:	83 ec 08             	sub    $0x8,%esp
 5c7:	50                   	push   %eax
 5c8:	ff 75 08             	pushl  0x8(%ebp)
 5cb:	e8 0d fe ff ff       	call   3dd <putc>
 5d0:	83 c4 10             	add    $0x10,%esp
        ap++;
 5d3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5d7:	eb 42                	jmp    61b <printf+0x16c>
      } else if(c == '%'){
 5d9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5dd:	75 17                	jne    5f6 <printf+0x147>
        putc(fd, c);
 5df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5e2:	0f be c0             	movsbl %al,%eax
 5e5:	83 ec 08             	sub    $0x8,%esp
 5e8:	50                   	push   %eax
 5e9:	ff 75 08             	pushl  0x8(%ebp)
 5ec:	e8 ec fd ff ff       	call   3dd <putc>
 5f1:	83 c4 10             	add    $0x10,%esp
 5f4:	eb 25                	jmp    61b <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5f6:	83 ec 08             	sub    $0x8,%esp
 5f9:	6a 25                	push   $0x25
 5fb:	ff 75 08             	pushl  0x8(%ebp)
 5fe:	e8 da fd ff ff       	call   3dd <putc>
 603:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 606:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 609:	0f be c0             	movsbl %al,%eax
 60c:	83 ec 08             	sub    $0x8,%esp
 60f:	50                   	push   %eax
 610:	ff 75 08             	pushl  0x8(%ebp)
 613:	e8 c5 fd ff ff       	call   3dd <putc>
 618:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 61b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 622:	ff 45 f0             	incl   -0x10(%ebp)
 625:	8b 55 0c             	mov    0xc(%ebp),%edx
 628:	8b 45 f0             	mov    -0x10(%ebp),%eax
 62b:	01 d0                	add    %edx,%eax
 62d:	8a 00                	mov    (%eax),%al
 62f:	84 c0                	test   %al,%al
 631:	0f 85 9a fe ff ff    	jne    4d1 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 637:	c9                   	leave  
 638:	c3                   	ret    

00000639 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 639:	55                   	push   %ebp
 63a:	89 e5                	mov    %esp,%ebp
 63c:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 63f:	8b 45 08             	mov    0x8(%ebp),%eax
 642:	83 e8 08             	sub    $0x8,%eax
 645:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 648:	a1 20 0b 00 00       	mov    0xb20,%eax
 64d:	89 45 fc             	mov    %eax,-0x4(%ebp)
 650:	eb 24                	jmp    676 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 652:	8b 45 fc             	mov    -0x4(%ebp),%eax
 655:	8b 00                	mov    (%eax),%eax
 657:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 65a:	77 12                	ja     66e <free+0x35>
 65c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 662:	77 24                	ja     688 <free+0x4f>
 664:	8b 45 fc             	mov    -0x4(%ebp),%eax
 667:	8b 00                	mov    (%eax),%eax
 669:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 66c:	77 1a                	ja     688 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 66e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 671:	8b 00                	mov    (%eax),%eax
 673:	89 45 fc             	mov    %eax,-0x4(%ebp)
 676:	8b 45 f8             	mov    -0x8(%ebp),%eax
 679:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 67c:	76 d4                	jbe    652 <free+0x19>
 67e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 681:	8b 00                	mov    (%eax),%eax
 683:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 686:	76 ca                	jbe    652 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 688:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68b:	8b 40 04             	mov    0x4(%eax),%eax
 68e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 695:	8b 45 f8             	mov    -0x8(%ebp),%eax
 698:	01 c2                	add    %eax,%edx
 69a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69d:	8b 00                	mov    (%eax),%eax
 69f:	39 c2                	cmp    %eax,%edx
 6a1:	75 24                	jne    6c7 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a6:	8b 50 04             	mov    0x4(%eax),%edx
 6a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ac:	8b 00                	mov    (%eax),%eax
 6ae:	8b 40 04             	mov    0x4(%eax),%eax
 6b1:	01 c2                	add    %eax,%edx
 6b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b6:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bc:	8b 00                	mov    (%eax),%eax
 6be:	8b 10                	mov    (%eax),%edx
 6c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c3:	89 10                	mov    %edx,(%eax)
 6c5:	eb 0a                	jmp    6d1 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ca:	8b 10                	mov    (%eax),%edx
 6cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6cf:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d4:	8b 40 04             	mov    0x4(%eax),%eax
 6d7:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6de:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e1:	01 d0                	add    %edx,%eax
 6e3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6e6:	75 20                	jne    708 <free+0xcf>
    p->s.size += bp->s.size;
 6e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6eb:	8b 50 04             	mov    0x4(%eax),%edx
 6ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f1:	8b 40 04             	mov    0x4(%eax),%eax
 6f4:	01 c2                	add    %eax,%edx
 6f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f9:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ff:	8b 10                	mov    (%eax),%edx
 701:	8b 45 fc             	mov    -0x4(%ebp),%eax
 704:	89 10                	mov    %edx,(%eax)
 706:	eb 08                	jmp    710 <free+0xd7>
  } else
    p->s.ptr = bp;
 708:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70b:	8b 55 f8             	mov    -0x8(%ebp),%edx
 70e:	89 10                	mov    %edx,(%eax)
  freep = p;
 710:	8b 45 fc             	mov    -0x4(%ebp),%eax
 713:	a3 20 0b 00 00       	mov    %eax,0xb20
}
 718:	c9                   	leave  
 719:	c3                   	ret    

0000071a <morecore>:

static Header*
morecore(uint nu)
{
 71a:	55                   	push   %ebp
 71b:	89 e5                	mov    %esp,%ebp
 71d:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 720:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 727:	77 07                	ja     730 <morecore+0x16>
    nu = 4096;
 729:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 730:	8b 45 08             	mov    0x8(%ebp),%eax
 733:	c1 e0 03             	shl    $0x3,%eax
 736:	83 ec 0c             	sub    $0xc,%esp
 739:	50                   	push   %eax
 73a:	e8 86 fc ff ff       	call   3c5 <sbrk>
 73f:	83 c4 10             	add    $0x10,%esp
 742:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 745:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 749:	75 07                	jne    752 <morecore+0x38>
    return 0;
 74b:	b8 00 00 00 00       	mov    $0x0,%eax
 750:	eb 26                	jmp    778 <morecore+0x5e>
  hp = (Header*)p;
 752:	8b 45 f4             	mov    -0xc(%ebp),%eax
 755:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 758:	8b 45 f0             	mov    -0x10(%ebp),%eax
 75b:	8b 55 08             	mov    0x8(%ebp),%edx
 75e:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 761:	8b 45 f0             	mov    -0x10(%ebp),%eax
 764:	83 c0 08             	add    $0x8,%eax
 767:	83 ec 0c             	sub    $0xc,%esp
 76a:	50                   	push   %eax
 76b:	e8 c9 fe ff ff       	call   639 <free>
 770:	83 c4 10             	add    $0x10,%esp
  return freep;
 773:	a1 20 0b 00 00       	mov    0xb20,%eax
}
 778:	c9                   	leave  
 779:	c3                   	ret    

0000077a <malloc>:

void*
malloc(uint nbytes)
{
 77a:	55                   	push   %ebp
 77b:	89 e5                	mov    %esp,%ebp
 77d:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 780:	8b 45 08             	mov    0x8(%ebp),%eax
 783:	83 c0 07             	add    $0x7,%eax
 786:	c1 e8 03             	shr    $0x3,%eax
 789:	40                   	inc    %eax
 78a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 78d:	a1 20 0b 00 00       	mov    0xb20,%eax
 792:	89 45 f0             	mov    %eax,-0x10(%ebp)
 795:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 799:	75 23                	jne    7be <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
 79b:	c7 45 f0 18 0b 00 00 	movl   $0xb18,-0x10(%ebp)
 7a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a5:	a3 20 0b 00 00       	mov    %eax,0xb20
 7aa:	a1 20 0b 00 00       	mov    0xb20,%eax
 7af:	a3 18 0b 00 00       	mov    %eax,0xb18
    base.s.size = 0;
 7b4:	c7 05 1c 0b 00 00 00 	movl   $0x0,0xb1c
 7bb:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7be:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c1:	8b 00                	mov    (%eax),%eax
 7c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c9:	8b 40 04             	mov    0x4(%eax),%eax
 7cc:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7cf:	72 4d                	jb     81e <malloc+0xa4>
      if(p->s.size == nunits)
 7d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d4:	8b 40 04             	mov    0x4(%eax),%eax
 7d7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7da:	75 0c                	jne    7e8 <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
 7dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7df:	8b 10                	mov    (%eax),%edx
 7e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e4:	89 10                	mov    %edx,(%eax)
 7e6:	eb 26                	jmp    80e <malloc+0x94>
      else {
        p->s.size -= nunits;
 7e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7eb:	8b 40 04             	mov    0x4(%eax),%eax
 7ee:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7f1:	89 c2                	mov    %eax,%edx
 7f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f6:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fc:	8b 40 04             	mov    0x4(%eax),%eax
 7ff:	c1 e0 03             	shl    $0x3,%eax
 802:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 805:	8b 45 f4             	mov    -0xc(%ebp),%eax
 808:	8b 55 ec             	mov    -0x14(%ebp),%edx
 80b:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 80e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 811:	a3 20 0b 00 00       	mov    %eax,0xb20
      return (void*)(p + 1);
 816:	8b 45 f4             	mov    -0xc(%ebp),%eax
 819:	83 c0 08             	add    $0x8,%eax
 81c:	eb 3b                	jmp    859 <malloc+0xdf>
    }
    if(p == freep)
 81e:	a1 20 0b 00 00       	mov    0xb20,%eax
 823:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 826:	75 1e                	jne    846 <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
 828:	83 ec 0c             	sub    $0xc,%esp
 82b:	ff 75 ec             	pushl  -0x14(%ebp)
 82e:	e8 e7 fe ff ff       	call   71a <morecore>
 833:	83 c4 10             	add    $0x10,%esp
 836:	89 45 f4             	mov    %eax,-0xc(%ebp)
 839:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 83d:	75 07                	jne    846 <malloc+0xcc>
        return 0;
 83f:	b8 00 00 00 00       	mov    $0x0,%eax
 844:	eb 13                	jmp    859 <malloc+0xdf>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 846:	8b 45 f4             	mov    -0xc(%ebp),%eax
 849:	89 45 f0             	mov    %eax,-0x10(%ebp)
 84c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84f:	8b 00                	mov    (%eax),%eax
 851:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 854:	e9 6d ff ff ff       	jmp    7c6 <malloc+0x4c>
}
 859:	c9                   	leave  
 85a:	c3                   	ret    
