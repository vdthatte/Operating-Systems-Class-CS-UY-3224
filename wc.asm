
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 28             	sub    $0x28,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
   6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
   d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10:	89 45 ec             	mov    %eax,-0x14(%ebp)
  13:	8b 45 ec             	mov    -0x14(%ebp),%eax
  16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  inword = 0;
  19:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  20:	eb 63                	jmp    85 <wc+0x85>
    for(i=0; i<n; i++){
  22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  29:	eb 52                	jmp    7d <wc+0x7d>
      c++;
  2b:	ff 45 e8             	incl   -0x18(%ebp)
      if(buf[i] == '\n')
  2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  31:	05 00 0c 00 00       	add    $0xc00,%eax
  36:	8a 00                	mov    (%eax),%al
  38:	3c 0a                	cmp    $0xa,%al
  3a:	75 03                	jne    3f <wc+0x3f>
        l++;
  3c:	ff 45 f0             	incl   -0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
  3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  42:	05 00 0c 00 00       	add    $0xc00,%eax
  47:	8a 00                	mov    (%eax),%al
  49:	0f be c0             	movsbl %al,%eax
  4c:	83 ec 08             	sub    $0x8,%esp
  4f:	50                   	push   %eax
  50:	68 11 09 00 00       	push   $0x911
  55:	e8 25 02 00 00       	call   27f <strchr>
  5a:	83 c4 10             	add    $0x10,%esp
  5d:	85 c0                	test   %eax,%eax
  5f:	74 09                	je     6a <wc+0x6a>
        inword = 0;
  61:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  68:	eb 10                	jmp    7a <wc+0x7a>
      else if(!inword){
  6a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  6e:	75 0a                	jne    7a <wc+0x7a>
        w++;
  70:	ff 45 ec             	incl   -0x14(%ebp)
        inword = 1;
  73:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  7a:	ff 45 f4             	incl   -0xc(%ebp)
  7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  83:	7c a6                	jl     2b <wc+0x2b>
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
  85:	83 ec 04             	sub    $0x4,%esp
  88:	68 00 02 00 00       	push   $0x200
  8d:	68 00 0c 00 00       	push   $0xc00
  92:	ff 75 08             	pushl  0x8(%ebp)
  95:	e8 71 03 00 00       	call   40b <read>
  9a:	83 c4 10             	add    $0x10,%esp
  9d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  a0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  a4:	0f 8f 78 ff ff ff    	jg     22 <wc+0x22>
        w++;
        inword = 1;
      }
    }
  }
  if(n < 0){
  aa:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  ae:	79 17                	jns    c7 <wc+0xc7>
    printf(1, "wc: read error\n");
  b0:	83 ec 08             	sub    $0x8,%esp
  b3:	68 17 09 00 00       	push   $0x917
  b8:	6a 01                	push   $0x1
  ba:	e8 a6 04 00 00       	call   565 <printf>
  bf:	83 c4 10             	add    $0x10,%esp
    exit();
  c2:	e8 2c 03 00 00       	call   3f3 <exit>
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
  c7:	83 ec 08             	sub    $0x8,%esp
  ca:	ff 75 0c             	pushl  0xc(%ebp)
  cd:	ff 75 e8             	pushl  -0x18(%ebp)
  d0:	ff 75 ec             	pushl  -0x14(%ebp)
  d3:	ff 75 f0             	pushl  -0x10(%ebp)
  d6:	68 27 09 00 00       	push   $0x927
  db:	6a 01                	push   $0x1
  dd:	e8 83 04 00 00       	call   565 <printf>
  e2:	83 c4 20             	add    $0x20,%esp
}
  e5:	c9                   	leave  
  e6:	c3                   	ret    

000000e7 <main>:

int
main(int argc, char *argv[])
{
  e7:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  eb:	83 e4 f0             	and    $0xfffffff0,%esp
  ee:	ff 71 fc             	pushl  -0x4(%ecx)
  f1:	55                   	push   %ebp
  f2:	89 e5                	mov    %esp,%ebp
  f4:	53                   	push   %ebx
  f5:	51                   	push   %ecx
  f6:	83 ec 10             	sub    $0x10,%esp
  f9:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
  fb:	83 3b 01             	cmpl   $0x1,(%ebx)
  fe:	7f 17                	jg     117 <main+0x30>
    wc(0, "");
 100:	83 ec 08             	sub    $0x8,%esp
 103:	68 34 09 00 00       	push   $0x934
 108:	6a 00                	push   $0x0
 10a:	e8 f1 fe ff ff       	call   0 <wc>
 10f:	83 c4 10             	add    $0x10,%esp
    exit();
 112:	e8 dc 02 00 00       	call   3f3 <exit>
  }

  for(i = 1; i < argc; i++){
 117:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
 11e:	e9 82 00 00 00       	jmp    1a5 <main+0xbe>
    if((fd = open(argv[i], 0)) < 0){
 123:	8b 45 f4             	mov    -0xc(%ebp),%eax
 126:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 12d:	8b 43 04             	mov    0x4(%ebx),%eax
 130:	01 d0                	add    %edx,%eax
 132:	8b 00                	mov    (%eax),%eax
 134:	83 ec 08             	sub    $0x8,%esp
 137:	6a 00                	push   $0x0
 139:	50                   	push   %eax
 13a:	e8 f4 02 00 00       	call   433 <open>
 13f:	83 c4 10             	add    $0x10,%esp
 142:	89 45 f0             	mov    %eax,-0x10(%ebp)
 145:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 149:	79 29                	jns    174 <main+0x8d>
      printf(1, "wc: cannot open %s\n", argv[i]);
 14b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 14e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 155:	8b 43 04             	mov    0x4(%ebx),%eax
 158:	01 d0                	add    %edx,%eax
 15a:	8b 00                	mov    (%eax),%eax
 15c:	83 ec 04             	sub    $0x4,%esp
 15f:	50                   	push   %eax
 160:	68 35 09 00 00       	push   $0x935
 165:	6a 01                	push   $0x1
 167:	e8 f9 03 00 00       	call   565 <printf>
 16c:	83 c4 10             	add    $0x10,%esp
      exit();
 16f:	e8 7f 02 00 00       	call   3f3 <exit>
    }
    wc(fd, argv[i]);
 174:	8b 45 f4             	mov    -0xc(%ebp),%eax
 177:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 17e:	8b 43 04             	mov    0x4(%ebx),%eax
 181:	01 d0                	add    %edx,%eax
 183:	8b 00                	mov    (%eax),%eax
 185:	83 ec 08             	sub    $0x8,%esp
 188:	50                   	push   %eax
 189:	ff 75 f0             	pushl  -0x10(%ebp)
 18c:	e8 6f fe ff ff       	call   0 <wc>
 191:	83 c4 10             	add    $0x10,%esp
    close(fd);
 194:	83 ec 0c             	sub    $0xc,%esp
 197:	ff 75 f0             	pushl  -0x10(%ebp)
 19a:	e8 7c 02 00 00       	call   41b <close>
 19f:	83 c4 10             	add    $0x10,%esp
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
 1a2:	ff 45 f4             	incl   -0xc(%ebp)
 1a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1a8:	3b 03                	cmp    (%ebx),%eax
 1aa:	0f 8c 73 ff ff ff    	jl     123 <main+0x3c>
      exit();
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit();
 1b0:	e8 3e 02 00 00       	call   3f3 <exit>

000001b5 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1b5:	55                   	push   %ebp
 1b6:	89 e5                	mov    %esp,%ebp
 1b8:	57                   	push   %edi
 1b9:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1ba:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1bd:	8b 55 10             	mov    0x10(%ebp),%edx
 1c0:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c3:	89 cb                	mov    %ecx,%ebx
 1c5:	89 df                	mov    %ebx,%edi
 1c7:	89 d1                	mov    %edx,%ecx
 1c9:	fc                   	cld    
 1ca:	f3 aa                	rep stos %al,%es:(%edi)
 1cc:	89 ca                	mov    %ecx,%edx
 1ce:	89 fb                	mov    %edi,%ebx
 1d0:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1d3:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1d6:	5b                   	pop    %ebx
 1d7:	5f                   	pop    %edi
 1d8:	5d                   	pop    %ebp
 1d9:	c3                   	ret    

000001da <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1da:	55                   	push   %ebp
 1db:	89 e5                	mov    %esp,%ebp
 1dd:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1e0:	8b 45 08             	mov    0x8(%ebp),%eax
 1e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 1e6:	90                   	nop
 1e7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ea:	8d 50 01             	lea    0x1(%eax),%edx
 1ed:	89 55 08             	mov    %edx,0x8(%ebp)
 1f0:	8b 55 0c             	mov    0xc(%ebp),%edx
 1f3:	8d 4a 01             	lea    0x1(%edx),%ecx
 1f6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 1f9:	8a 12                	mov    (%edx),%dl
 1fb:	88 10                	mov    %dl,(%eax)
 1fd:	8a 00                	mov    (%eax),%al
 1ff:	84 c0                	test   %al,%al
 201:	75 e4                	jne    1e7 <strcpy+0xd>
    ;
  return os;
 203:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 206:	c9                   	leave  
 207:	c3                   	ret    

00000208 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 208:	55                   	push   %ebp
 209:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 20b:	eb 06                	jmp    213 <strcmp+0xb>
    p++, q++;
 20d:	ff 45 08             	incl   0x8(%ebp)
 210:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 213:	8b 45 08             	mov    0x8(%ebp),%eax
 216:	8a 00                	mov    (%eax),%al
 218:	84 c0                	test   %al,%al
 21a:	74 0e                	je     22a <strcmp+0x22>
 21c:	8b 45 08             	mov    0x8(%ebp),%eax
 21f:	8a 10                	mov    (%eax),%dl
 221:	8b 45 0c             	mov    0xc(%ebp),%eax
 224:	8a 00                	mov    (%eax),%al
 226:	38 c2                	cmp    %al,%dl
 228:	74 e3                	je     20d <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 22a:	8b 45 08             	mov    0x8(%ebp),%eax
 22d:	8a 00                	mov    (%eax),%al
 22f:	0f b6 d0             	movzbl %al,%edx
 232:	8b 45 0c             	mov    0xc(%ebp),%eax
 235:	8a 00                	mov    (%eax),%al
 237:	0f b6 c0             	movzbl %al,%eax
 23a:	29 c2                	sub    %eax,%edx
 23c:	89 d0                	mov    %edx,%eax
}
 23e:	5d                   	pop    %ebp
 23f:	c3                   	ret    

00000240 <strlen>:

uint
strlen(char *s)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 246:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 24d:	eb 03                	jmp    252 <strlen+0x12>
 24f:	ff 45 fc             	incl   -0x4(%ebp)
 252:	8b 55 fc             	mov    -0x4(%ebp),%edx
 255:	8b 45 08             	mov    0x8(%ebp),%eax
 258:	01 d0                	add    %edx,%eax
 25a:	8a 00                	mov    (%eax),%al
 25c:	84 c0                	test   %al,%al
 25e:	75 ef                	jne    24f <strlen+0xf>
    ;
  return n;
 260:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 263:	c9                   	leave  
 264:	c3                   	ret    

00000265 <memset>:

void*
memset(void *dst, int c, uint n)
{
 265:	55                   	push   %ebp
 266:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 268:	8b 45 10             	mov    0x10(%ebp),%eax
 26b:	50                   	push   %eax
 26c:	ff 75 0c             	pushl  0xc(%ebp)
 26f:	ff 75 08             	pushl  0x8(%ebp)
 272:	e8 3e ff ff ff       	call   1b5 <stosb>
 277:	83 c4 0c             	add    $0xc,%esp
  return dst;
 27a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 27d:	c9                   	leave  
 27e:	c3                   	ret    

0000027f <strchr>:

char*
strchr(const char *s, char c)
{
 27f:	55                   	push   %ebp
 280:	89 e5                	mov    %esp,%ebp
 282:	83 ec 04             	sub    $0x4,%esp
 285:	8b 45 0c             	mov    0xc(%ebp),%eax
 288:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 28b:	eb 12                	jmp    29f <strchr+0x20>
    if(*s == c)
 28d:	8b 45 08             	mov    0x8(%ebp),%eax
 290:	8a 00                	mov    (%eax),%al
 292:	3a 45 fc             	cmp    -0x4(%ebp),%al
 295:	75 05                	jne    29c <strchr+0x1d>
      return (char*)s;
 297:	8b 45 08             	mov    0x8(%ebp),%eax
 29a:	eb 11                	jmp    2ad <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 29c:	ff 45 08             	incl   0x8(%ebp)
 29f:	8b 45 08             	mov    0x8(%ebp),%eax
 2a2:	8a 00                	mov    (%eax),%al
 2a4:	84 c0                	test   %al,%al
 2a6:	75 e5                	jne    28d <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 2a8:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2ad:	c9                   	leave  
 2ae:	c3                   	ret    

000002af <gets>:

char*
gets(char *buf, int max)
{
 2af:	55                   	push   %ebp
 2b0:	89 e5                	mov    %esp,%ebp
 2b2:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2bc:	eb 41                	jmp    2ff <gets+0x50>
    cc = read(0, &c, 1);
 2be:	83 ec 04             	sub    $0x4,%esp
 2c1:	6a 01                	push   $0x1
 2c3:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2c6:	50                   	push   %eax
 2c7:	6a 00                	push   $0x0
 2c9:	e8 3d 01 00 00       	call   40b <read>
 2ce:	83 c4 10             	add    $0x10,%esp
 2d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2d4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2d8:	7f 02                	jg     2dc <gets+0x2d>
      break;
 2da:	eb 2c                	jmp    308 <gets+0x59>
    buf[i++] = c;
 2dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2df:	8d 50 01             	lea    0x1(%eax),%edx
 2e2:	89 55 f4             	mov    %edx,-0xc(%ebp)
 2e5:	89 c2                	mov    %eax,%edx
 2e7:	8b 45 08             	mov    0x8(%ebp),%eax
 2ea:	01 c2                	add    %eax,%edx
 2ec:	8a 45 ef             	mov    -0x11(%ebp),%al
 2ef:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 2f1:	8a 45 ef             	mov    -0x11(%ebp),%al
 2f4:	3c 0a                	cmp    $0xa,%al
 2f6:	74 10                	je     308 <gets+0x59>
 2f8:	8a 45 ef             	mov    -0x11(%ebp),%al
 2fb:	3c 0d                	cmp    $0xd,%al
 2fd:	74 09                	je     308 <gets+0x59>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 302:	40                   	inc    %eax
 303:	3b 45 0c             	cmp    0xc(%ebp),%eax
 306:	7c b6                	jl     2be <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 308:	8b 55 f4             	mov    -0xc(%ebp),%edx
 30b:	8b 45 08             	mov    0x8(%ebp),%eax
 30e:	01 d0                	add    %edx,%eax
 310:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 313:	8b 45 08             	mov    0x8(%ebp),%eax
}
 316:	c9                   	leave  
 317:	c3                   	ret    

00000318 <stat>:

int
stat(char *n, struct stat *st)
{
 318:	55                   	push   %ebp
 319:	89 e5                	mov    %esp,%ebp
 31b:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 31e:	83 ec 08             	sub    $0x8,%esp
 321:	6a 00                	push   $0x0
 323:	ff 75 08             	pushl  0x8(%ebp)
 326:	e8 08 01 00 00       	call   433 <open>
 32b:	83 c4 10             	add    $0x10,%esp
 32e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 331:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 335:	79 07                	jns    33e <stat+0x26>
    return -1;
 337:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 33c:	eb 25                	jmp    363 <stat+0x4b>
  r = fstat(fd, st);
 33e:	83 ec 08             	sub    $0x8,%esp
 341:	ff 75 0c             	pushl  0xc(%ebp)
 344:	ff 75 f4             	pushl  -0xc(%ebp)
 347:	e8 ff 00 00 00       	call   44b <fstat>
 34c:	83 c4 10             	add    $0x10,%esp
 34f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 352:	83 ec 0c             	sub    $0xc,%esp
 355:	ff 75 f4             	pushl  -0xc(%ebp)
 358:	e8 be 00 00 00       	call   41b <close>
 35d:	83 c4 10             	add    $0x10,%esp
  return r;
 360:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 363:	c9                   	leave  
 364:	c3                   	ret    

00000365 <atoi>:

int
atoi(const char *s)
{
 365:	55                   	push   %ebp
 366:	89 e5                	mov    %esp,%ebp
 368:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 36b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 372:	eb 24                	jmp    398 <atoi+0x33>
    n = n*10 + *s++ - '0';
 374:	8b 55 fc             	mov    -0x4(%ebp),%edx
 377:	89 d0                	mov    %edx,%eax
 379:	c1 e0 02             	shl    $0x2,%eax
 37c:	01 d0                	add    %edx,%eax
 37e:	01 c0                	add    %eax,%eax
 380:	89 c1                	mov    %eax,%ecx
 382:	8b 45 08             	mov    0x8(%ebp),%eax
 385:	8d 50 01             	lea    0x1(%eax),%edx
 388:	89 55 08             	mov    %edx,0x8(%ebp)
 38b:	8a 00                	mov    (%eax),%al
 38d:	0f be c0             	movsbl %al,%eax
 390:	01 c8                	add    %ecx,%eax
 392:	83 e8 30             	sub    $0x30,%eax
 395:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 398:	8b 45 08             	mov    0x8(%ebp),%eax
 39b:	8a 00                	mov    (%eax),%al
 39d:	3c 2f                	cmp    $0x2f,%al
 39f:	7e 09                	jle    3aa <atoi+0x45>
 3a1:	8b 45 08             	mov    0x8(%ebp),%eax
 3a4:	8a 00                	mov    (%eax),%al
 3a6:	3c 39                	cmp    $0x39,%al
 3a8:	7e ca                	jle    374 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 3aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3ad:	c9                   	leave  
 3ae:	c3                   	ret    

000003af <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3af:	55                   	push   %ebp
 3b0:	89 e5                	mov    %esp,%ebp
 3b2:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 3b5:	8b 45 08             	mov    0x8(%ebp),%eax
 3b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3bb:	8b 45 0c             	mov    0xc(%ebp),%eax
 3be:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3c1:	eb 16                	jmp    3d9 <memmove+0x2a>
    *dst++ = *src++;
 3c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3c6:	8d 50 01             	lea    0x1(%eax),%edx
 3c9:	89 55 fc             	mov    %edx,-0x4(%ebp)
 3cc:	8b 55 f8             	mov    -0x8(%ebp),%edx
 3cf:	8d 4a 01             	lea    0x1(%edx),%ecx
 3d2:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 3d5:	8a 12                	mov    (%edx),%dl
 3d7:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3d9:	8b 45 10             	mov    0x10(%ebp),%eax
 3dc:	8d 50 ff             	lea    -0x1(%eax),%edx
 3df:	89 55 10             	mov    %edx,0x10(%ebp)
 3e2:	85 c0                	test   %eax,%eax
 3e4:	7f dd                	jg     3c3 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 3e6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3e9:	c9                   	leave  
 3ea:	c3                   	ret    

000003eb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3eb:	b8 01 00 00 00       	mov    $0x1,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <exit>:
SYSCALL(exit)
 3f3:	b8 02 00 00 00       	mov    $0x2,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <wait>:
SYSCALL(wait)
 3fb:	b8 03 00 00 00       	mov    $0x3,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <pipe>:
SYSCALL(pipe)
 403:	b8 04 00 00 00       	mov    $0x4,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <read>:
SYSCALL(read)
 40b:	b8 05 00 00 00       	mov    $0x5,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <write>:
SYSCALL(write)
 413:	b8 10 00 00 00       	mov    $0x10,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <close>:
SYSCALL(close)
 41b:	b8 15 00 00 00       	mov    $0x15,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <kill>:
SYSCALL(kill)
 423:	b8 06 00 00 00       	mov    $0x6,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <exec>:
SYSCALL(exec)
 42b:	b8 07 00 00 00       	mov    $0x7,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <open>:
SYSCALL(open)
 433:	b8 0f 00 00 00       	mov    $0xf,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <mknod>:
SYSCALL(mknod)
 43b:	b8 11 00 00 00       	mov    $0x11,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <unlink>:
SYSCALL(unlink)
 443:	b8 12 00 00 00       	mov    $0x12,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <fstat>:
SYSCALL(fstat)
 44b:	b8 08 00 00 00       	mov    $0x8,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <link>:
SYSCALL(link)
 453:	b8 13 00 00 00       	mov    $0x13,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <mkdir>:
SYSCALL(mkdir)
 45b:	b8 14 00 00 00       	mov    $0x14,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <chdir>:
SYSCALL(chdir)
 463:	b8 09 00 00 00       	mov    $0x9,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <dup>:
SYSCALL(dup)
 46b:	b8 0a 00 00 00       	mov    $0xa,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <getpid>:
SYSCALL(getpid)
 473:	b8 0b 00 00 00       	mov    $0xb,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <sbrk>:
SYSCALL(sbrk)
 47b:	b8 0c 00 00 00       	mov    $0xc,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <sleep>:
SYSCALL(sleep)
 483:	b8 0d 00 00 00       	mov    $0xd,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <uptime>:
SYSCALL(uptime)
 48b:	b8 0e 00 00 00       	mov    $0xe,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 493:	55                   	push   %ebp
 494:	89 e5                	mov    %esp,%ebp
 496:	83 ec 18             	sub    $0x18,%esp
 499:	8b 45 0c             	mov    0xc(%ebp),%eax
 49c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 49f:	83 ec 04             	sub    $0x4,%esp
 4a2:	6a 01                	push   $0x1
 4a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4a7:	50                   	push   %eax
 4a8:	ff 75 08             	pushl  0x8(%ebp)
 4ab:	e8 63 ff ff ff       	call   413 <write>
 4b0:	83 c4 10             	add    $0x10,%esp
}
 4b3:	c9                   	leave  
 4b4:	c3                   	ret    

000004b5 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4b5:	55                   	push   %ebp
 4b6:	89 e5                	mov    %esp,%ebp
 4b8:	53                   	push   %ebx
 4b9:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4bc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4c3:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4c7:	74 17                	je     4e0 <printint+0x2b>
 4c9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4cd:	79 11                	jns    4e0 <printint+0x2b>
    neg = 1;
 4cf:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4d6:	8b 45 0c             	mov    0xc(%ebp),%eax
 4d9:	f7 d8                	neg    %eax
 4db:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4de:	eb 06                	jmp    4e6 <printint+0x31>
  } else {
    x = xx;
 4e0:	8b 45 0c             	mov    0xc(%ebp),%eax
 4e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4e6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4ed:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 4f0:	8d 41 01             	lea    0x1(%ecx),%eax
 4f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4f6:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4fc:	ba 00 00 00 00       	mov    $0x0,%edx
 501:	f7 f3                	div    %ebx
 503:	89 d0                	mov    %edx,%eax
 505:	8a 80 bc 0b 00 00    	mov    0xbbc(%eax),%al
 50b:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 50f:	8b 5d 10             	mov    0x10(%ebp),%ebx
 512:	8b 45 ec             	mov    -0x14(%ebp),%eax
 515:	ba 00 00 00 00       	mov    $0x0,%edx
 51a:	f7 f3                	div    %ebx
 51c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 51f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 523:	75 c8                	jne    4ed <printint+0x38>
  if(neg)
 525:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 529:	74 0e                	je     539 <printint+0x84>
    buf[i++] = '-';
 52b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 52e:	8d 50 01             	lea    0x1(%eax),%edx
 531:	89 55 f4             	mov    %edx,-0xc(%ebp)
 534:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 539:	eb 1c                	jmp    557 <printint+0xa2>
    putc(fd, buf[i]);
 53b:	8d 55 dc             	lea    -0x24(%ebp),%edx
 53e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 541:	01 d0                	add    %edx,%eax
 543:	8a 00                	mov    (%eax),%al
 545:	0f be c0             	movsbl %al,%eax
 548:	83 ec 08             	sub    $0x8,%esp
 54b:	50                   	push   %eax
 54c:	ff 75 08             	pushl  0x8(%ebp)
 54f:	e8 3f ff ff ff       	call   493 <putc>
 554:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 557:	ff 4d f4             	decl   -0xc(%ebp)
 55a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 55e:	79 db                	jns    53b <printint+0x86>
    putc(fd, buf[i]);
}
 560:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 563:	c9                   	leave  
 564:	c3                   	ret    

00000565 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 565:	55                   	push   %ebp
 566:	89 e5                	mov    %esp,%ebp
 568:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 56b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 572:	8d 45 0c             	lea    0xc(%ebp),%eax
 575:	83 c0 04             	add    $0x4,%eax
 578:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 57b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 582:	e9 54 01 00 00       	jmp    6db <printf+0x176>
    c = fmt[i] & 0xff;
 587:	8b 55 0c             	mov    0xc(%ebp),%edx
 58a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 58d:	01 d0                	add    %edx,%eax
 58f:	8a 00                	mov    (%eax),%al
 591:	0f be c0             	movsbl %al,%eax
 594:	25 ff 00 00 00       	and    $0xff,%eax
 599:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 59c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5a0:	75 2c                	jne    5ce <printf+0x69>
      if(c == '%'){
 5a2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5a6:	75 0c                	jne    5b4 <printf+0x4f>
        state = '%';
 5a8:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5af:	e9 24 01 00 00       	jmp    6d8 <printf+0x173>
      } else {
        putc(fd, c);
 5b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5b7:	0f be c0             	movsbl %al,%eax
 5ba:	83 ec 08             	sub    $0x8,%esp
 5bd:	50                   	push   %eax
 5be:	ff 75 08             	pushl  0x8(%ebp)
 5c1:	e8 cd fe ff ff       	call   493 <putc>
 5c6:	83 c4 10             	add    $0x10,%esp
 5c9:	e9 0a 01 00 00       	jmp    6d8 <printf+0x173>
      }
    } else if(state == '%'){
 5ce:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5d2:	0f 85 00 01 00 00    	jne    6d8 <printf+0x173>
      if(c == 'd'){
 5d8:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5dc:	75 1e                	jne    5fc <printf+0x97>
        printint(fd, *ap, 10, 1);
 5de:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5e1:	8b 00                	mov    (%eax),%eax
 5e3:	6a 01                	push   $0x1
 5e5:	6a 0a                	push   $0xa
 5e7:	50                   	push   %eax
 5e8:	ff 75 08             	pushl  0x8(%ebp)
 5eb:	e8 c5 fe ff ff       	call   4b5 <printint>
 5f0:	83 c4 10             	add    $0x10,%esp
        ap++;
 5f3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5f7:	e9 d5 00 00 00       	jmp    6d1 <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
 5fc:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 600:	74 06                	je     608 <printf+0xa3>
 602:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 606:	75 1e                	jne    626 <printf+0xc1>
        printint(fd, *ap, 16, 0);
 608:	8b 45 e8             	mov    -0x18(%ebp),%eax
 60b:	8b 00                	mov    (%eax),%eax
 60d:	6a 00                	push   $0x0
 60f:	6a 10                	push   $0x10
 611:	50                   	push   %eax
 612:	ff 75 08             	pushl  0x8(%ebp)
 615:	e8 9b fe ff ff       	call   4b5 <printint>
 61a:	83 c4 10             	add    $0x10,%esp
        ap++;
 61d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 621:	e9 ab 00 00 00       	jmp    6d1 <printf+0x16c>
      } else if(c == 's'){
 626:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 62a:	75 40                	jne    66c <printf+0x107>
        s = (char*)*ap;
 62c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 62f:	8b 00                	mov    (%eax),%eax
 631:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 634:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 638:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 63c:	75 07                	jne    645 <printf+0xe0>
          s = "(null)";
 63e:	c7 45 f4 49 09 00 00 	movl   $0x949,-0xc(%ebp)
        while(*s != 0){
 645:	eb 1a                	jmp    661 <printf+0xfc>
          putc(fd, *s);
 647:	8b 45 f4             	mov    -0xc(%ebp),%eax
 64a:	8a 00                	mov    (%eax),%al
 64c:	0f be c0             	movsbl %al,%eax
 64f:	83 ec 08             	sub    $0x8,%esp
 652:	50                   	push   %eax
 653:	ff 75 08             	pushl  0x8(%ebp)
 656:	e8 38 fe ff ff       	call   493 <putc>
 65b:	83 c4 10             	add    $0x10,%esp
          s++;
 65e:	ff 45 f4             	incl   -0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 661:	8b 45 f4             	mov    -0xc(%ebp),%eax
 664:	8a 00                	mov    (%eax),%al
 666:	84 c0                	test   %al,%al
 668:	75 dd                	jne    647 <printf+0xe2>
 66a:	eb 65                	jmp    6d1 <printf+0x16c>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 66c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 670:	75 1d                	jne    68f <printf+0x12a>
        putc(fd, *ap);
 672:	8b 45 e8             	mov    -0x18(%ebp),%eax
 675:	8b 00                	mov    (%eax),%eax
 677:	0f be c0             	movsbl %al,%eax
 67a:	83 ec 08             	sub    $0x8,%esp
 67d:	50                   	push   %eax
 67e:	ff 75 08             	pushl  0x8(%ebp)
 681:	e8 0d fe ff ff       	call   493 <putc>
 686:	83 c4 10             	add    $0x10,%esp
        ap++;
 689:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 68d:	eb 42                	jmp    6d1 <printf+0x16c>
      } else if(c == '%'){
 68f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 693:	75 17                	jne    6ac <printf+0x147>
        putc(fd, c);
 695:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 698:	0f be c0             	movsbl %al,%eax
 69b:	83 ec 08             	sub    $0x8,%esp
 69e:	50                   	push   %eax
 69f:	ff 75 08             	pushl  0x8(%ebp)
 6a2:	e8 ec fd ff ff       	call   493 <putc>
 6a7:	83 c4 10             	add    $0x10,%esp
 6aa:	eb 25                	jmp    6d1 <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6ac:	83 ec 08             	sub    $0x8,%esp
 6af:	6a 25                	push   $0x25
 6b1:	ff 75 08             	pushl  0x8(%ebp)
 6b4:	e8 da fd ff ff       	call   493 <putc>
 6b9:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 6bc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6bf:	0f be c0             	movsbl %al,%eax
 6c2:	83 ec 08             	sub    $0x8,%esp
 6c5:	50                   	push   %eax
 6c6:	ff 75 08             	pushl  0x8(%ebp)
 6c9:	e8 c5 fd ff ff       	call   493 <putc>
 6ce:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 6d1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6d8:	ff 45 f0             	incl   -0x10(%ebp)
 6db:	8b 55 0c             	mov    0xc(%ebp),%edx
 6de:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6e1:	01 d0                	add    %edx,%eax
 6e3:	8a 00                	mov    (%eax),%al
 6e5:	84 c0                	test   %al,%al
 6e7:	0f 85 9a fe ff ff    	jne    587 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6ed:	c9                   	leave  
 6ee:	c3                   	ret    

000006ef <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6ef:	55                   	push   %ebp
 6f0:	89 e5                	mov    %esp,%ebp
 6f2:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6f5:	8b 45 08             	mov    0x8(%ebp),%eax
 6f8:	83 e8 08             	sub    $0x8,%eax
 6fb:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6fe:	a1 e8 0b 00 00       	mov    0xbe8,%eax
 703:	89 45 fc             	mov    %eax,-0x4(%ebp)
 706:	eb 24                	jmp    72c <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 708:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70b:	8b 00                	mov    (%eax),%eax
 70d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 710:	77 12                	ja     724 <free+0x35>
 712:	8b 45 f8             	mov    -0x8(%ebp),%eax
 715:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 718:	77 24                	ja     73e <free+0x4f>
 71a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71d:	8b 00                	mov    (%eax),%eax
 71f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 722:	77 1a                	ja     73e <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 724:	8b 45 fc             	mov    -0x4(%ebp),%eax
 727:	8b 00                	mov    (%eax),%eax
 729:	89 45 fc             	mov    %eax,-0x4(%ebp)
 72c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 72f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 732:	76 d4                	jbe    708 <free+0x19>
 734:	8b 45 fc             	mov    -0x4(%ebp),%eax
 737:	8b 00                	mov    (%eax),%eax
 739:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 73c:	76 ca                	jbe    708 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 73e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 741:	8b 40 04             	mov    0x4(%eax),%eax
 744:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 74b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 74e:	01 c2                	add    %eax,%edx
 750:	8b 45 fc             	mov    -0x4(%ebp),%eax
 753:	8b 00                	mov    (%eax),%eax
 755:	39 c2                	cmp    %eax,%edx
 757:	75 24                	jne    77d <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 759:	8b 45 f8             	mov    -0x8(%ebp),%eax
 75c:	8b 50 04             	mov    0x4(%eax),%edx
 75f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 762:	8b 00                	mov    (%eax),%eax
 764:	8b 40 04             	mov    0x4(%eax),%eax
 767:	01 c2                	add    %eax,%edx
 769:	8b 45 f8             	mov    -0x8(%ebp),%eax
 76c:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 76f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 772:	8b 00                	mov    (%eax),%eax
 774:	8b 10                	mov    (%eax),%edx
 776:	8b 45 f8             	mov    -0x8(%ebp),%eax
 779:	89 10                	mov    %edx,(%eax)
 77b:	eb 0a                	jmp    787 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 77d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 780:	8b 10                	mov    (%eax),%edx
 782:	8b 45 f8             	mov    -0x8(%ebp),%eax
 785:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 787:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78a:	8b 40 04             	mov    0x4(%eax),%eax
 78d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 794:	8b 45 fc             	mov    -0x4(%ebp),%eax
 797:	01 d0                	add    %edx,%eax
 799:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 79c:	75 20                	jne    7be <free+0xcf>
    p->s.size += bp->s.size;
 79e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a1:	8b 50 04             	mov    0x4(%eax),%edx
 7a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7a7:	8b 40 04             	mov    0x4(%eax),%eax
 7aa:	01 c2                	add    %eax,%edx
 7ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7af:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b5:	8b 10                	mov    (%eax),%edx
 7b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ba:	89 10                	mov    %edx,(%eax)
 7bc:	eb 08                	jmp    7c6 <free+0xd7>
  } else
    p->s.ptr = bp;
 7be:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c1:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7c4:	89 10                	mov    %edx,(%eax)
  freep = p;
 7c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c9:	a3 e8 0b 00 00       	mov    %eax,0xbe8
}
 7ce:	c9                   	leave  
 7cf:	c3                   	ret    

000007d0 <morecore>:

static Header*
morecore(uint nu)
{
 7d0:	55                   	push   %ebp
 7d1:	89 e5                	mov    %esp,%ebp
 7d3:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7d6:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7dd:	77 07                	ja     7e6 <morecore+0x16>
    nu = 4096;
 7df:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7e6:	8b 45 08             	mov    0x8(%ebp),%eax
 7e9:	c1 e0 03             	shl    $0x3,%eax
 7ec:	83 ec 0c             	sub    $0xc,%esp
 7ef:	50                   	push   %eax
 7f0:	e8 86 fc ff ff       	call   47b <sbrk>
 7f5:	83 c4 10             	add    $0x10,%esp
 7f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7fb:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7ff:	75 07                	jne    808 <morecore+0x38>
    return 0;
 801:	b8 00 00 00 00       	mov    $0x0,%eax
 806:	eb 26                	jmp    82e <morecore+0x5e>
  hp = (Header*)p;
 808:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 80e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 811:	8b 55 08             	mov    0x8(%ebp),%edx
 814:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 817:	8b 45 f0             	mov    -0x10(%ebp),%eax
 81a:	83 c0 08             	add    $0x8,%eax
 81d:	83 ec 0c             	sub    $0xc,%esp
 820:	50                   	push   %eax
 821:	e8 c9 fe ff ff       	call   6ef <free>
 826:	83 c4 10             	add    $0x10,%esp
  return freep;
 829:	a1 e8 0b 00 00       	mov    0xbe8,%eax
}
 82e:	c9                   	leave  
 82f:	c3                   	ret    

00000830 <malloc>:

void*
malloc(uint nbytes)
{
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 836:	8b 45 08             	mov    0x8(%ebp),%eax
 839:	83 c0 07             	add    $0x7,%eax
 83c:	c1 e8 03             	shr    $0x3,%eax
 83f:	40                   	inc    %eax
 840:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 843:	a1 e8 0b 00 00       	mov    0xbe8,%eax
 848:	89 45 f0             	mov    %eax,-0x10(%ebp)
 84b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 84f:	75 23                	jne    874 <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
 851:	c7 45 f0 e0 0b 00 00 	movl   $0xbe0,-0x10(%ebp)
 858:	8b 45 f0             	mov    -0x10(%ebp),%eax
 85b:	a3 e8 0b 00 00       	mov    %eax,0xbe8
 860:	a1 e8 0b 00 00       	mov    0xbe8,%eax
 865:	a3 e0 0b 00 00       	mov    %eax,0xbe0
    base.s.size = 0;
 86a:	c7 05 e4 0b 00 00 00 	movl   $0x0,0xbe4
 871:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 874:	8b 45 f0             	mov    -0x10(%ebp),%eax
 877:	8b 00                	mov    (%eax),%eax
 879:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 87c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87f:	8b 40 04             	mov    0x4(%eax),%eax
 882:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 885:	72 4d                	jb     8d4 <malloc+0xa4>
      if(p->s.size == nunits)
 887:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88a:	8b 40 04             	mov    0x4(%eax),%eax
 88d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 890:	75 0c                	jne    89e <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
 892:	8b 45 f4             	mov    -0xc(%ebp),%eax
 895:	8b 10                	mov    (%eax),%edx
 897:	8b 45 f0             	mov    -0x10(%ebp),%eax
 89a:	89 10                	mov    %edx,(%eax)
 89c:	eb 26                	jmp    8c4 <malloc+0x94>
      else {
        p->s.size -= nunits;
 89e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a1:	8b 40 04             	mov    0x4(%eax),%eax
 8a4:	2b 45 ec             	sub    -0x14(%ebp),%eax
 8a7:	89 c2                	mov    %eax,%edx
 8a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ac:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8af:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b2:	8b 40 04             	mov    0x4(%eax),%eax
 8b5:	c1 e0 03             	shl    $0x3,%eax
 8b8:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8be:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8c1:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c7:	a3 e8 0b 00 00       	mov    %eax,0xbe8
      return (void*)(p + 1);
 8cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8cf:	83 c0 08             	add    $0x8,%eax
 8d2:	eb 3b                	jmp    90f <malloc+0xdf>
    }
    if(p == freep)
 8d4:	a1 e8 0b 00 00       	mov    0xbe8,%eax
 8d9:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8dc:	75 1e                	jne    8fc <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
 8de:	83 ec 0c             	sub    $0xc,%esp
 8e1:	ff 75 ec             	pushl  -0x14(%ebp)
 8e4:	e8 e7 fe ff ff       	call   7d0 <morecore>
 8e9:	83 c4 10             	add    $0x10,%esp
 8ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8ef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8f3:	75 07                	jne    8fc <malloc+0xcc>
        return 0;
 8f5:	b8 00 00 00 00       	mov    $0x0,%eax
 8fa:	eb 13                	jmp    90f <malloc+0xdf>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
 902:	8b 45 f4             	mov    -0xc(%ebp),%eax
 905:	8b 00                	mov    (%eax),%eax
 907:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 90a:	e9 6d ff ff ff       	jmp    87c <malloc+0x4c>
}
 90f:	c9                   	leave  
 910:	c3                   	ret    
