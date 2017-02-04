
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  int n, m;
  char *p, *q;
  
  m = 0;
   6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
   d:	e9 b4 00 00 00       	jmp    c6 <grep+0xc6>
    m += n;
  12:	8b 45 ec             	mov    -0x14(%ebp),%eax
  15:	01 45 f4             	add    %eax,-0xc(%ebp)
    buf[m] = '\0';
  18:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1b:	05 c0 0d 00 00       	add    $0xdc0,%eax
  20:	c6 00 00             	movb   $0x0,(%eax)
    p = buf;
  23:	c7 45 f0 c0 0d 00 00 	movl   $0xdc0,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
  2a:	eb 46                	jmp    72 <grep+0x72>
      *q = 0;
  2c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  2f:	c6 00 00             	movb   $0x0,(%eax)
      if(match(pattern, p)){
  32:	83 ec 08             	sub    $0x8,%esp
  35:	ff 75 f0             	pushl  -0x10(%ebp)
  38:	ff 75 08             	pushl  0x8(%ebp)
  3b:	e8 95 01 00 00       	call   1d5 <match>
  40:	83 c4 10             	add    $0x10,%esp
  43:	85 c0                	test   %eax,%eax
  45:	74 24                	je     6b <grep+0x6b>
        *q = '\n';
  47:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4a:	c6 00 0a             	movb   $0xa,(%eax)
        write(1, p, q+1 - p);
  4d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  50:	40                   	inc    %eax
  51:	89 c2                	mov    %eax,%edx
  53:	8b 45 f0             	mov    -0x10(%ebp),%eax
  56:	29 c2                	sub    %eax,%edx
  58:	89 d0                	mov    %edx,%eax
  5a:	83 ec 04             	sub    $0x4,%esp
  5d:	50                   	push   %eax
  5e:	ff 75 f0             	pushl  -0x10(%ebp)
  61:	6a 01                	push   $0x1
  63:	e8 11 05 00 00       	call   579 <write>
  68:	83 c4 10             	add    $0x10,%esp
      }
      p = q+1;
  6b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  6e:	40                   	inc    %eax
  6f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    m += n;
    buf[m] = '\0';
    p = buf;
    while((q = strchr(p, '\n')) != 0){
  72:	83 ec 08             	sub    $0x8,%esp
  75:	6a 0a                	push   $0xa
  77:	ff 75 f0             	pushl  -0x10(%ebp)
  7a:	e8 66 03 00 00       	call   3e5 <strchr>
  7f:	83 c4 10             	add    $0x10,%esp
  82:	89 45 e8             	mov    %eax,-0x18(%ebp)
  85:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  89:	75 a1                	jne    2c <grep+0x2c>
        *q = '\n';
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
  8b:	81 7d f0 c0 0d 00 00 	cmpl   $0xdc0,-0x10(%ebp)
  92:	75 07                	jne    9b <grep+0x9b>
      m = 0;
  94:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
  9b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  9f:	7e 25                	jle    c6 <grep+0xc6>
      m -= p - buf;
  a1:	ba c0 0d 00 00       	mov    $0xdc0,%edx
  a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  a9:	29 c2                	sub    %eax,%edx
  ab:	89 d0                	mov    %edx,%eax
  ad:	01 45 f4             	add    %eax,-0xc(%ebp)
      memmove(buf, p, m);
  b0:	83 ec 04             	sub    $0x4,%esp
  b3:	ff 75 f4             	pushl  -0xc(%ebp)
  b6:	ff 75 f0             	pushl  -0x10(%ebp)
  b9:	68 c0 0d 00 00       	push   $0xdc0
  be:	e8 52 04 00 00       	call   515 <memmove>
  c3:	83 c4 10             	add    $0x10,%esp
{
  int n, m;
  char *p, *q;
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
  c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  c9:	ba ff 03 00 00       	mov    $0x3ff,%edx
  ce:	29 c2                	sub    %eax,%edx
  d0:	89 d0                	mov    %edx,%eax
  d2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  d5:	81 c2 c0 0d 00 00    	add    $0xdc0,%edx
  db:	83 ec 04             	sub    $0x4,%esp
  de:	50                   	push   %eax
  df:	52                   	push   %edx
  e0:	ff 75 0c             	pushl  0xc(%ebp)
  e3:	e8 89 04 00 00       	call   571 <read>
  e8:	83 c4 10             	add    $0x10,%esp
  eb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  ee:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  f2:	0f 8f 1a ff ff ff    	jg     12 <grep+0x12>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
  f8:	c9                   	leave  
  f9:	c3                   	ret    

000000fa <main>:

int
main(int argc, char *argv[])
{
  fa:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  fe:	83 e4 f0             	and    $0xfffffff0,%esp
 101:	ff 71 fc             	pushl  -0x4(%ecx)
 104:	55                   	push   %ebp
 105:	89 e5                	mov    %esp,%ebp
 107:	53                   	push   %ebx
 108:	51                   	push   %ecx
 109:	83 ec 10             	sub    $0x10,%esp
 10c:	89 cb                	mov    %ecx,%ebx
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
 10e:	83 3b 01             	cmpl   $0x1,(%ebx)
 111:	7f 17                	jg     12a <main+0x30>
    printf(2, "usage: grep pattern [file ...]\n");
 113:	83 ec 08             	sub    $0x8,%esp
 116:	68 78 0a 00 00       	push   $0xa78
 11b:	6a 02                	push   $0x2
 11d:	e8 a9 05 00 00       	call   6cb <printf>
 122:	83 c4 10             	add    $0x10,%esp
    exit();
 125:	e8 2f 04 00 00       	call   559 <exit>
  }
  pattern = argv[1];
 12a:	8b 43 04             	mov    0x4(%ebx),%eax
 12d:	8b 40 04             	mov    0x4(%eax),%eax
 130:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  if(argc <= 2){
 133:	83 3b 02             	cmpl   $0x2,(%ebx)
 136:	7f 15                	jg     14d <main+0x53>
    grep(pattern, 0);
 138:	83 ec 08             	sub    $0x8,%esp
 13b:	6a 00                	push   $0x0
 13d:	ff 75 f0             	pushl  -0x10(%ebp)
 140:	e8 bb fe ff ff       	call   0 <grep>
 145:	83 c4 10             	add    $0x10,%esp
    exit();
 148:	e8 0c 04 00 00       	call   559 <exit>
  }

  for(i = 2; i < argc; i++){
 14d:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
 154:	eb 73                	jmp    1c9 <main+0xcf>
    if((fd = open(argv[i], 0)) < 0){
 156:	8b 45 f4             	mov    -0xc(%ebp),%eax
 159:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 160:	8b 43 04             	mov    0x4(%ebx),%eax
 163:	01 d0                	add    %edx,%eax
 165:	8b 00                	mov    (%eax),%eax
 167:	83 ec 08             	sub    $0x8,%esp
 16a:	6a 00                	push   $0x0
 16c:	50                   	push   %eax
 16d:	e8 27 04 00 00       	call   599 <open>
 172:	83 c4 10             	add    $0x10,%esp
 175:	89 45 ec             	mov    %eax,-0x14(%ebp)
 178:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 17c:	79 29                	jns    1a7 <main+0xad>
      printf(1, "grep: cannot open %s\n", argv[i]);
 17e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 181:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 188:	8b 43 04             	mov    0x4(%ebx),%eax
 18b:	01 d0                	add    %edx,%eax
 18d:	8b 00                	mov    (%eax),%eax
 18f:	83 ec 04             	sub    $0x4,%esp
 192:	50                   	push   %eax
 193:	68 98 0a 00 00       	push   $0xa98
 198:	6a 01                	push   $0x1
 19a:	e8 2c 05 00 00       	call   6cb <printf>
 19f:	83 c4 10             	add    $0x10,%esp
      exit();
 1a2:	e8 b2 03 00 00       	call   559 <exit>
    }
    grep(pattern, fd);
 1a7:	83 ec 08             	sub    $0x8,%esp
 1aa:	ff 75 ec             	pushl  -0x14(%ebp)
 1ad:	ff 75 f0             	pushl  -0x10(%ebp)
 1b0:	e8 4b fe ff ff       	call   0 <grep>
 1b5:	83 c4 10             	add    $0x10,%esp
    close(fd);
 1b8:	83 ec 0c             	sub    $0xc,%esp
 1bb:	ff 75 ec             	pushl  -0x14(%ebp)
 1be:	e8 be 03 00 00       	call   581 <close>
 1c3:	83 c4 10             	add    $0x10,%esp
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
 1c6:	ff 45 f4             	incl   -0xc(%ebp)
 1c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1cc:	3b 03                	cmp    (%ebx),%eax
 1ce:	7c 86                	jl     156 <main+0x5c>
      exit();
    }
    grep(pattern, fd);
    close(fd);
  }
  exit();
 1d0:	e8 84 03 00 00       	call   559 <exit>

000001d5 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 1d5:	55                   	push   %ebp
 1d6:	89 e5                	mov    %esp,%ebp
 1d8:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '^')
 1db:	8b 45 08             	mov    0x8(%ebp),%eax
 1de:	8a 00                	mov    (%eax),%al
 1e0:	3c 5e                	cmp    $0x5e,%al
 1e2:	75 15                	jne    1f9 <match+0x24>
    return matchhere(re+1, text);
 1e4:	8b 45 08             	mov    0x8(%ebp),%eax
 1e7:	40                   	inc    %eax
 1e8:	83 ec 08             	sub    $0x8,%esp
 1eb:	ff 75 0c             	pushl  0xc(%ebp)
 1ee:	50                   	push   %eax
 1ef:	e8 37 00 00 00       	call   22b <matchhere>
 1f4:	83 c4 10             	add    $0x10,%esp
 1f7:	eb 30                	jmp    229 <match+0x54>
  do{  // must look at empty string
    if(matchhere(re, text))
 1f9:	83 ec 08             	sub    $0x8,%esp
 1fc:	ff 75 0c             	pushl  0xc(%ebp)
 1ff:	ff 75 08             	pushl  0x8(%ebp)
 202:	e8 24 00 00 00       	call   22b <matchhere>
 207:	83 c4 10             	add    $0x10,%esp
 20a:	85 c0                	test   %eax,%eax
 20c:	74 07                	je     215 <match+0x40>
      return 1;
 20e:	b8 01 00 00 00       	mov    $0x1,%eax
 213:	eb 14                	jmp    229 <match+0x54>
  }while(*text++ != '\0');
 215:	8b 45 0c             	mov    0xc(%ebp),%eax
 218:	8d 50 01             	lea    0x1(%eax),%edx
 21b:	89 55 0c             	mov    %edx,0xc(%ebp)
 21e:	8a 00                	mov    (%eax),%al
 220:	84 c0                	test   %al,%al
 222:	75 d5                	jne    1f9 <match+0x24>
  return 0;
 224:	b8 00 00 00 00       	mov    $0x0,%eax
}
 229:	c9                   	leave  
 22a:	c3                   	ret    

0000022b <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
 22b:	55                   	push   %ebp
 22c:	89 e5                	mov    %esp,%ebp
 22e:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '\0')
 231:	8b 45 08             	mov    0x8(%ebp),%eax
 234:	8a 00                	mov    (%eax),%al
 236:	84 c0                	test   %al,%al
 238:	75 0a                	jne    244 <matchhere+0x19>
    return 1;
 23a:	b8 01 00 00 00       	mov    $0x1,%eax
 23f:	e9 8a 00 00 00       	jmp    2ce <matchhere+0xa3>
  if(re[1] == '*')
 244:	8b 45 08             	mov    0x8(%ebp),%eax
 247:	40                   	inc    %eax
 248:	8a 00                	mov    (%eax),%al
 24a:	3c 2a                	cmp    $0x2a,%al
 24c:	75 20                	jne    26e <matchhere+0x43>
    return matchstar(re[0], re+2, text);
 24e:	8b 45 08             	mov    0x8(%ebp),%eax
 251:	8d 50 02             	lea    0x2(%eax),%edx
 254:	8b 45 08             	mov    0x8(%ebp),%eax
 257:	8a 00                	mov    (%eax),%al
 259:	0f be c0             	movsbl %al,%eax
 25c:	83 ec 04             	sub    $0x4,%esp
 25f:	ff 75 0c             	pushl  0xc(%ebp)
 262:	52                   	push   %edx
 263:	50                   	push   %eax
 264:	e8 67 00 00 00       	call   2d0 <matchstar>
 269:	83 c4 10             	add    $0x10,%esp
 26c:	eb 60                	jmp    2ce <matchhere+0xa3>
  if(re[0] == '$' && re[1] == '\0')
 26e:	8b 45 08             	mov    0x8(%ebp),%eax
 271:	8a 00                	mov    (%eax),%al
 273:	3c 24                	cmp    $0x24,%al
 275:	75 19                	jne    290 <matchhere+0x65>
 277:	8b 45 08             	mov    0x8(%ebp),%eax
 27a:	40                   	inc    %eax
 27b:	8a 00                	mov    (%eax),%al
 27d:	84 c0                	test   %al,%al
 27f:	75 0f                	jne    290 <matchhere+0x65>
    return *text == '\0';
 281:	8b 45 0c             	mov    0xc(%ebp),%eax
 284:	8a 00                	mov    (%eax),%al
 286:	84 c0                	test   %al,%al
 288:	0f 94 c0             	sete   %al
 28b:	0f b6 c0             	movzbl %al,%eax
 28e:	eb 3e                	jmp    2ce <matchhere+0xa3>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 290:	8b 45 0c             	mov    0xc(%ebp),%eax
 293:	8a 00                	mov    (%eax),%al
 295:	84 c0                	test   %al,%al
 297:	74 30                	je     2c9 <matchhere+0x9e>
 299:	8b 45 08             	mov    0x8(%ebp),%eax
 29c:	8a 00                	mov    (%eax),%al
 29e:	3c 2e                	cmp    $0x2e,%al
 2a0:	74 0e                	je     2b0 <matchhere+0x85>
 2a2:	8b 45 08             	mov    0x8(%ebp),%eax
 2a5:	8a 10                	mov    (%eax),%dl
 2a7:	8b 45 0c             	mov    0xc(%ebp),%eax
 2aa:	8a 00                	mov    (%eax),%al
 2ac:	38 c2                	cmp    %al,%dl
 2ae:	75 19                	jne    2c9 <matchhere+0x9e>
    return matchhere(re+1, text+1);
 2b0:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b3:	8d 50 01             	lea    0x1(%eax),%edx
 2b6:	8b 45 08             	mov    0x8(%ebp),%eax
 2b9:	40                   	inc    %eax
 2ba:	83 ec 08             	sub    $0x8,%esp
 2bd:	52                   	push   %edx
 2be:	50                   	push   %eax
 2bf:	e8 67 ff ff ff       	call   22b <matchhere>
 2c4:	83 c4 10             	add    $0x10,%esp
 2c7:	eb 05                	jmp    2ce <matchhere+0xa3>
  return 0;
 2c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2ce:	c9                   	leave  
 2cf:	c3                   	ret    

000002d0 <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	83 ec 08             	sub    $0x8,%esp
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
 2d6:	83 ec 08             	sub    $0x8,%esp
 2d9:	ff 75 10             	pushl  0x10(%ebp)
 2dc:	ff 75 0c             	pushl  0xc(%ebp)
 2df:	e8 47 ff ff ff       	call   22b <matchhere>
 2e4:	83 c4 10             	add    $0x10,%esp
 2e7:	85 c0                	test   %eax,%eax
 2e9:	74 07                	je     2f2 <matchstar+0x22>
      return 1;
 2eb:	b8 01 00 00 00       	mov    $0x1,%eax
 2f0:	eb 27                	jmp    319 <matchstar+0x49>
  }while(*text!='\0' && (*text++==c || c=='.'));
 2f2:	8b 45 10             	mov    0x10(%ebp),%eax
 2f5:	8a 00                	mov    (%eax),%al
 2f7:	84 c0                	test   %al,%al
 2f9:	74 19                	je     314 <matchstar+0x44>
 2fb:	8b 45 10             	mov    0x10(%ebp),%eax
 2fe:	8d 50 01             	lea    0x1(%eax),%edx
 301:	89 55 10             	mov    %edx,0x10(%ebp)
 304:	8a 00                	mov    (%eax),%al
 306:	0f be c0             	movsbl %al,%eax
 309:	3b 45 08             	cmp    0x8(%ebp),%eax
 30c:	74 c8                	je     2d6 <matchstar+0x6>
 30e:	83 7d 08 2e          	cmpl   $0x2e,0x8(%ebp)
 312:	74 c2                	je     2d6 <matchstar+0x6>
  return 0;
 314:	b8 00 00 00 00       	mov    $0x0,%eax
}
 319:	c9                   	leave  
 31a:	c3                   	ret    

0000031b <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 31b:	55                   	push   %ebp
 31c:	89 e5                	mov    %esp,%ebp
 31e:	57                   	push   %edi
 31f:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 320:	8b 4d 08             	mov    0x8(%ebp),%ecx
 323:	8b 55 10             	mov    0x10(%ebp),%edx
 326:	8b 45 0c             	mov    0xc(%ebp),%eax
 329:	89 cb                	mov    %ecx,%ebx
 32b:	89 df                	mov    %ebx,%edi
 32d:	89 d1                	mov    %edx,%ecx
 32f:	fc                   	cld    
 330:	f3 aa                	rep stos %al,%es:(%edi)
 332:	89 ca                	mov    %ecx,%edx
 334:	89 fb                	mov    %edi,%ebx
 336:	89 5d 08             	mov    %ebx,0x8(%ebp)
 339:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 33c:	5b                   	pop    %ebx
 33d:	5f                   	pop    %edi
 33e:	5d                   	pop    %ebp
 33f:	c3                   	ret    

00000340 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 346:	8b 45 08             	mov    0x8(%ebp),%eax
 349:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 34c:	90                   	nop
 34d:	8b 45 08             	mov    0x8(%ebp),%eax
 350:	8d 50 01             	lea    0x1(%eax),%edx
 353:	89 55 08             	mov    %edx,0x8(%ebp)
 356:	8b 55 0c             	mov    0xc(%ebp),%edx
 359:	8d 4a 01             	lea    0x1(%edx),%ecx
 35c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 35f:	8a 12                	mov    (%edx),%dl
 361:	88 10                	mov    %dl,(%eax)
 363:	8a 00                	mov    (%eax),%al
 365:	84 c0                	test   %al,%al
 367:	75 e4                	jne    34d <strcpy+0xd>
    ;
  return os;
 369:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 36c:	c9                   	leave  
 36d:	c3                   	ret    

0000036e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 36e:	55                   	push   %ebp
 36f:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 371:	eb 06                	jmp    379 <strcmp+0xb>
    p++, q++;
 373:	ff 45 08             	incl   0x8(%ebp)
 376:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 379:	8b 45 08             	mov    0x8(%ebp),%eax
 37c:	8a 00                	mov    (%eax),%al
 37e:	84 c0                	test   %al,%al
 380:	74 0e                	je     390 <strcmp+0x22>
 382:	8b 45 08             	mov    0x8(%ebp),%eax
 385:	8a 10                	mov    (%eax),%dl
 387:	8b 45 0c             	mov    0xc(%ebp),%eax
 38a:	8a 00                	mov    (%eax),%al
 38c:	38 c2                	cmp    %al,%dl
 38e:	74 e3                	je     373 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 390:	8b 45 08             	mov    0x8(%ebp),%eax
 393:	8a 00                	mov    (%eax),%al
 395:	0f b6 d0             	movzbl %al,%edx
 398:	8b 45 0c             	mov    0xc(%ebp),%eax
 39b:	8a 00                	mov    (%eax),%al
 39d:	0f b6 c0             	movzbl %al,%eax
 3a0:	29 c2                	sub    %eax,%edx
 3a2:	89 d0                	mov    %edx,%eax
}
 3a4:	5d                   	pop    %ebp
 3a5:	c3                   	ret    

000003a6 <strlen>:

uint
strlen(char *s)
{
 3a6:	55                   	push   %ebp
 3a7:	89 e5                	mov    %esp,%ebp
 3a9:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 3ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3b3:	eb 03                	jmp    3b8 <strlen+0x12>
 3b5:	ff 45 fc             	incl   -0x4(%ebp)
 3b8:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3bb:	8b 45 08             	mov    0x8(%ebp),%eax
 3be:	01 d0                	add    %edx,%eax
 3c0:	8a 00                	mov    (%eax),%al
 3c2:	84 c0                	test   %al,%al
 3c4:	75 ef                	jne    3b5 <strlen+0xf>
    ;
  return n;
 3c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3c9:	c9                   	leave  
 3ca:	c3                   	ret    

000003cb <memset>:

void*
memset(void *dst, int c, uint n)
{
 3cb:	55                   	push   %ebp
 3cc:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 3ce:	8b 45 10             	mov    0x10(%ebp),%eax
 3d1:	50                   	push   %eax
 3d2:	ff 75 0c             	pushl  0xc(%ebp)
 3d5:	ff 75 08             	pushl  0x8(%ebp)
 3d8:	e8 3e ff ff ff       	call   31b <stosb>
 3dd:	83 c4 0c             	add    $0xc,%esp
  return dst;
 3e0:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3e3:	c9                   	leave  
 3e4:	c3                   	ret    

000003e5 <strchr>:

char*
strchr(const char *s, char c)
{
 3e5:	55                   	push   %ebp
 3e6:	89 e5                	mov    %esp,%ebp
 3e8:	83 ec 04             	sub    $0x4,%esp
 3eb:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ee:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 3f1:	eb 12                	jmp    405 <strchr+0x20>
    if(*s == c)
 3f3:	8b 45 08             	mov    0x8(%ebp),%eax
 3f6:	8a 00                	mov    (%eax),%al
 3f8:	3a 45 fc             	cmp    -0x4(%ebp),%al
 3fb:	75 05                	jne    402 <strchr+0x1d>
      return (char*)s;
 3fd:	8b 45 08             	mov    0x8(%ebp),%eax
 400:	eb 11                	jmp    413 <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 402:	ff 45 08             	incl   0x8(%ebp)
 405:	8b 45 08             	mov    0x8(%ebp),%eax
 408:	8a 00                	mov    (%eax),%al
 40a:	84 c0                	test   %al,%al
 40c:	75 e5                	jne    3f3 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 40e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 413:	c9                   	leave  
 414:	c3                   	ret    

00000415 <gets>:

char*
gets(char *buf, int max)
{
 415:	55                   	push   %ebp
 416:	89 e5                	mov    %esp,%ebp
 418:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 41b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 422:	eb 41                	jmp    465 <gets+0x50>
    cc = read(0, &c, 1);
 424:	83 ec 04             	sub    $0x4,%esp
 427:	6a 01                	push   $0x1
 429:	8d 45 ef             	lea    -0x11(%ebp),%eax
 42c:	50                   	push   %eax
 42d:	6a 00                	push   $0x0
 42f:	e8 3d 01 00 00       	call   571 <read>
 434:	83 c4 10             	add    $0x10,%esp
 437:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 43a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 43e:	7f 02                	jg     442 <gets+0x2d>
      break;
 440:	eb 2c                	jmp    46e <gets+0x59>
    buf[i++] = c;
 442:	8b 45 f4             	mov    -0xc(%ebp),%eax
 445:	8d 50 01             	lea    0x1(%eax),%edx
 448:	89 55 f4             	mov    %edx,-0xc(%ebp)
 44b:	89 c2                	mov    %eax,%edx
 44d:	8b 45 08             	mov    0x8(%ebp),%eax
 450:	01 c2                	add    %eax,%edx
 452:	8a 45 ef             	mov    -0x11(%ebp),%al
 455:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 457:	8a 45 ef             	mov    -0x11(%ebp),%al
 45a:	3c 0a                	cmp    $0xa,%al
 45c:	74 10                	je     46e <gets+0x59>
 45e:	8a 45 ef             	mov    -0x11(%ebp),%al
 461:	3c 0d                	cmp    $0xd,%al
 463:	74 09                	je     46e <gets+0x59>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 465:	8b 45 f4             	mov    -0xc(%ebp),%eax
 468:	40                   	inc    %eax
 469:	3b 45 0c             	cmp    0xc(%ebp),%eax
 46c:	7c b6                	jl     424 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 46e:	8b 55 f4             	mov    -0xc(%ebp),%edx
 471:	8b 45 08             	mov    0x8(%ebp),%eax
 474:	01 d0                	add    %edx,%eax
 476:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 479:	8b 45 08             	mov    0x8(%ebp),%eax
}
 47c:	c9                   	leave  
 47d:	c3                   	ret    

0000047e <stat>:

int
stat(char *n, struct stat *st)
{
 47e:	55                   	push   %ebp
 47f:	89 e5                	mov    %esp,%ebp
 481:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 484:	83 ec 08             	sub    $0x8,%esp
 487:	6a 00                	push   $0x0
 489:	ff 75 08             	pushl  0x8(%ebp)
 48c:	e8 08 01 00 00       	call   599 <open>
 491:	83 c4 10             	add    $0x10,%esp
 494:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 497:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 49b:	79 07                	jns    4a4 <stat+0x26>
    return -1;
 49d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4a2:	eb 25                	jmp    4c9 <stat+0x4b>
  r = fstat(fd, st);
 4a4:	83 ec 08             	sub    $0x8,%esp
 4a7:	ff 75 0c             	pushl  0xc(%ebp)
 4aa:	ff 75 f4             	pushl  -0xc(%ebp)
 4ad:	e8 ff 00 00 00       	call   5b1 <fstat>
 4b2:	83 c4 10             	add    $0x10,%esp
 4b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 4b8:	83 ec 0c             	sub    $0xc,%esp
 4bb:	ff 75 f4             	pushl  -0xc(%ebp)
 4be:	e8 be 00 00 00       	call   581 <close>
 4c3:	83 c4 10             	add    $0x10,%esp
  return r;
 4c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 4c9:	c9                   	leave  
 4ca:	c3                   	ret    

000004cb <atoi>:

int
atoi(const char *s)
{
 4cb:	55                   	push   %ebp
 4cc:	89 e5                	mov    %esp,%ebp
 4ce:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 4d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 4d8:	eb 24                	jmp    4fe <atoi+0x33>
    n = n*10 + *s++ - '0';
 4da:	8b 55 fc             	mov    -0x4(%ebp),%edx
 4dd:	89 d0                	mov    %edx,%eax
 4df:	c1 e0 02             	shl    $0x2,%eax
 4e2:	01 d0                	add    %edx,%eax
 4e4:	01 c0                	add    %eax,%eax
 4e6:	89 c1                	mov    %eax,%ecx
 4e8:	8b 45 08             	mov    0x8(%ebp),%eax
 4eb:	8d 50 01             	lea    0x1(%eax),%edx
 4ee:	89 55 08             	mov    %edx,0x8(%ebp)
 4f1:	8a 00                	mov    (%eax),%al
 4f3:	0f be c0             	movsbl %al,%eax
 4f6:	01 c8                	add    %ecx,%eax
 4f8:	83 e8 30             	sub    $0x30,%eax
 4fb:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4fe:	8b 45 08             	mov    0x8(%ebp),%eax
 501:	8a 00                	mov    (%eax),%al
 503:	3c 2f                	cmp    $0x2f,%al
 505:	7e 09                	jle    510 <atoi+0x45>
 507:	8b 45 08             	mov    0x8(%ebp),%eax
 50a:	8a 00                	mov    (%eax),%al
 50c:	3c 39                	cmp    $0x39,%al
 50e:	7e ca                	jle    4da <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 510:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 513:	c9                   	leave  
 514:	c3                   	ret    

00000515 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 515:	55                   	push   %ebp
 516:	89 e5                	mov    %esp,%ebp
 518:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 51b:	8b 45 08             	mov    0x8(%ebp),%eax
 51e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 521:	8b 45 0c             	mov    0xc(%ebp),%eax
 524:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 527:	eb 16                	jmp    53f <memmove+0x2a>
    *dst++ = *src++;
 529:	8b 45 fc             	mov    -0x4(%ebp),%eax
 52c:	8d 50 01             	lea    0x1(%eax),%edx
 52f:	89 55 fc             	mov    %edx,-0x4(%ebp)
 532:	8b 55 f8             	mov    -0x8(%ebp),%edx
 535:	8d 4a 01             	lea    0x1(%edx),%ecx
 538:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 53b:	8a 12                	mov    (%edx),%dl
 53d:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 53f:	8b 45 10             	mov    0x10(%ebp),%eax
 542:	8d 50 ff             	lea    -0x1(%eax),%edx
 545:	89 55 10             	mov    %edx,0x10(%ebp)
 548:	85 c0                	test   %eax,%eax
 54a:	7f dd                	jg     529 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 54c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 54f:	c9                   	leave  
 550:	c3                   	ret    

00000551 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 551:	b8 01 00 00 00       	mov    $0x1,%eax
 556:	cd 40                	int    $0x40
 558:	c3                   	ret    

00000559 <exit>:
SYSCALL(exit)
 559:	b8 02 00 00 00       	mov    $0x2,%eax
 55e:	cd 40                	int    $0x40
 560:	c3                   	ret    

00000561 <wait>:
SYSCALL(wait)
 561:	b8 03 00 00 00       	mov    $0x3,%eax
 566:	cd 40                	int    $0x40
 568:	c3                   	ret    

00000569 <pipe>:
SYSCALL(pipe)
 569:	b8 04 00 00 00       	mov    $0x4,%eax
 56e:	cd 40                	int    $0x40
 570:	c3                   	ret    

00000571 <read>:
SYSCALL(read)
 571:	b8 05 00 00 00       	mov    $0x5,%eax
 576:	cd 40                	int    $0x40
 578:	c3                   	ret    

00000579 <write>:
SYSCALL(write)
 579:	b8 10 00 00 00       	mov    $0x10,%eax
 57e:	cd 40                	int    $0x40
 580:	c3                   	ret    

00000581 <close>:
SYSCALL(close)
 581:	b8 15 00 00 00       	mov    $0x15,%eax
 586:	cd 40                	int    $0x40
 588:	c3                   	ret    

00000589 <kill>:
SYSCALL(kill)
 589:	b8 06 00 00 00       	mov    $0x6,%eax
 58e:	cd 40                	int    $0x40
 590:	c3                   	ret    

00000591 <exec>:
SYSCALL(exec)
 591:	b8 07 00 00 00       	mov    $0x7,%eax
 596:	cd 40                	int    $0x40
 598:	c3                   	ret    

00000599 <open>:
SYSCALL(open)
 599:	b8 0f 00 00 00       	mov    $0xf,%eax
 59e:	cd 40                	int    $0x40
 5a0:	c3                   	ret    

000005a1 <mknod>:
SYSCALL(mknod)
 5a1:	b8 11 00 00 00       	mov    $0x11,%eax
 5a6:	cd 40                	int    $0x40
 5a8:	c3                   	ret    

000005a9 <unlink>:
SYSCALL(unlink)
 5a9:	b8 12 00 00 00       	mov    $0x12,%eax
 5ae:	cd 40                	int    $0x40
 5b0:	c3                   	ret    

000005b1 <fstat>:
SYSCALL(fstat)
 5b1:	b8 08 00 00 00       	mov    $0x8,%eax
 5b6:	cd 40                	int    $0x40
 5b8:	c3                   	ret    

000005b9 <link>:
SYSCALL(link)
 5b9:	b8 13 00 00 00       	mov    $0x13,%eax
 5be:	cd 40                	int    $0x40
 5c0:	c3                   	ret    

000005c1 <mkdir>:
SYSCALL(mkdir)
 5c1:	b8 14 00 00 00       	mov    $0x14,%eax
 5c6:	cd 40                	int    $0x40
 5c8:	c3                   	ret    

000005c9 <chdir>:
SYSCALL(chdir)
 5c9:	b8 09 00 00 00       	mov    $0x9,%eax
 5ce:	cd 40                	int    $0x40
 5d0:	c3                   	ret    

000005d1 <dup>:
SYSCALL(dup)
 5d1:	b8 0a 00 00 00       	mov    $0xa,%eax
 5d6:	cd 40                	int    $0x40
 5d8:	c3                   	ret    

000005d9 <getpid>:
SYSCALL(getpid)
 5d9:	b8 0b 00 00 00       	mov    $0xb,%eax
 5de:	cd 40                	int    $0x40
 5e0:	c3                   	ret    

000005e1 <sbrk>:
SYSCALL(sbrk)
 5e1:	b8 0c 00 00 00       	mov    $0xc,%eax
 5e6:	cd 40                	int    $0x40
 5e8:	c3                   	ret    

000005e9 <sleep>:
SYSCALL(sleep)
 5e9:	b8 0d 00 00 00       	mov    $0xd,%eax
 5ee:	cd 40                	int    $0x40
 5f0:	c3                   	ret    

000005f1 <uptime>:
SYSCALL(uptime)
 5f1:	b8 0e 00 00 00       	mov    $0xe,%eax
 5f6:	cd 40                	int    $0x40
 5f8:	c3                   	ret    

000005f9 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 5f9:	55                   	push   %ebp
 5fa:	89 e5                	mov    %esp,%ebp
 5fc:	83 ec 18             	sub    $0x18,%esp
 5ff:	8b 45 0c             	mov    0xc(%ebp),%eax
 602:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 605:	83 ec 04             	sub    $0x4,%esp
 608:	6a 01                	push   $0x1
 60a:	8d 45 f4             	lea    -0xc(%ebp),%eax
 60d:	50                   	push   %eax
 60e:	ff 75 08             	pushl  0x8(%ebp)
 611:	e8 63 ff ff ff       	call   579 <write>
 616:	83 c4 10             	add    $0x10,%esp
}
 619:	c9                   	leave  
 61a:	c3                   	ret    

0000061b <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 61b:	55                   	push   %ebp
 61c:	89 e5                	mov    %esp,%ebp
 61e:	53                   	push   %ebx
 61f:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 622:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 629:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 62d:	74 17                	je     646 <printint+0x2b>
 62f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 633:	79 11                	jns    646 <printint+0x2b>
    neg = 1;
 635:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 63c:	8b 45 0c             	mov    0xc(%ebp),%eax
 63f:	f7 d8                	neg    %eax
 641:	89 45 ec             	mov    %eax,-0x14(%ebp)
 644:	eb 06                	jmp    64c <printint+0x31>
  } else {
    x = xx;
 646:	8b 45 0c             	mov    0xc(%ebp),%eax
 649:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 64c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 653:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 656:	8d 41 01             	lea    0x1(%ecx),%eax
 659:	89 45 f4             	mov    %eax,-0xc(%ebp)
 65c:	8b 5d 10             	mov    0x10(%ebp),%ebx
 65f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 662:	ba 00 00 00 00       	mov    $0x0,%edx
 667:	f7 f3                	div    %ebx
 669:	89 d0                	mov    %edx,%eax
 66b:	8a 80 84 0d 00 00    	mov    0xd84(%eax),%al
 671:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 675:	8b 5d 10             	mov    0x10(%ebp),%ebx
 678:	8b 45 ec             	mov    -0x14(%ebp),%eax
 67b:	ba 00 00 00 00       	mov    $0x0,%edx
 680:	f7 f3                	div    %ebx
 682:	89 45 ec             	mov    %eax,-0x14(%ebp)
 685:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 689:	75 c8                	jne    653 <printint+0x38>
  if(neg)
 68b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 68f:	74 0e                	je     69f <printint+0x84>
    buf[i++] = '-';
 691:	8b 45 f4             	mov    -0xc(%ebp),%eax
 694:	8d 50 01             	lea    0x1(%eax),%edx
 697:	89 55 f4             	mov    %edx,-0xc(%ebp)
 69a:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 69f:	eb 1c                	jmp    6bd <printint+0xa2>
    putc(fd, buf[i]);
 6a1:	8d 55 dc             	lea    -0x24(%ebp),%edx
 6a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6a7:	01 d0                	add    %edx,%eax
 6a9:	8a 00                	mov    (%eax),%al
 6ab:	0f be c0             	movsbl %al,%eax
 6ae:	83 ec 08             	sub    $0x8,%esp
 6b1:	50                   	push   %eax
 6b2:	ff 75 08             	pushl  0x8(%ebp)
 6b5:	e8 3f ff ff ff       	call   5f9 <putc>
 6ba:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 6bd:	ff 4d f4             	decl   -0xc(%ebp)
 6c0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6c4:	79 db                	jns    6a1 <printint+0x86>
    putc(fd, buf[i]);
}
 6c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6c9:	c9                   	leave  
 6ca:	c3                   	ret    

000006cb <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6cb:	55                   	push   %ebp
 6cc:	89 e5                	mov    %esp,%ebp
 6ce:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 6d1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 6d8:	8d 45 0c             	lea    0xc(%ebp),%eax
 6db:	83 c0 04             	add    $0x4,%eax
 6de:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 6e1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 6e8:	e9 54 01 00 00       	jmp    841 <printf+0x176>
    c = fmt[i] & 0xff;
 6ed:	8b 55 0c             	mov    0xc(%ebp),%edx
 6f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f3:	01 d0                	add    %edx,%eax
 6f5:	8a 00                	mov    (%eax),%al
 6f7:	0f be c0             	movsbl %al,%eax
 6fa:	25 ff 00 00 00       	and    $0xff,%eax
 6ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 702:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 706:	75 2c                	jne    734 <printf+0x69>
      if(c == '%'){
 708:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 70c:	75 0c                	jne    71a <printf+0x4f>
        state = '%';
 70e:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 715:	e9 24 01 00 00       	jmp    83e <printf+0x173>
      } else {
        putc(fd, c);
 71a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 71d:	0f be c0             	movsbl %al,%eax
 720:	83 ec 08             	sub    $0x8,%esp
 723:	50                   	push   %eax
 724:	ff 75 08             	pushl  0x8(%ebp)
 727:	e8 cd fe ff ff       	call   5f9 <putc>
 72c:	83 c4 10             	add    $0x10,%esp
 72f:	e9 0a 01 00 00       	jmp    83e <printf+0x173>
      }
    } else if(state == '%'){
 734:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 738:	0f 85 00 01 00 00    	jne    83e <printf+0x173>
      if(c == 'd'){
 73e:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 742:	75 1e                	jne    762 <printf+0x97>
        printint(fd, *ap, 10, 1);
 744:	8b 45 e8             	mov    -0x18(%ebp),%eax
 747:	8b 00                	mov    (%eax),%eax
 749:	6a 01                	push   $0x1
 74b:	6a 0a                	push   $0xa
 74d:	50                   	push   %eax
 74e:	ff 75 08             	pushl  0x8(%ebp)
 751:	e8 c5 fe ff ff       	call   61b <printint>
 756:	83 c4 10             	add    $0x10,%esp
        ap++;
 759:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 75d:	e9 d5 00 00 00       	jmp    837 <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
 762:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 766:	74 06                	je     76e <printf+0xa3>
 768:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 76c:	75 1e                	jne    78c <printf+0xc1>
        printint(fd, *ap, 16, 0);
 76e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 771:	8b 00                	mov    (%eax),%eax
 773:	6a 00                	push   $0x0
 775:	6a 10                	push   $0x10
 777:	50                   	push   %eax
 778:	ff 75 08             	pushl  0x8(%ebp)
 77b:	e8 9b fe ff ff       	call   61b <printint>
 780:	83 c4 10             	add    $0x10,%esp
        ap++;
 783:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 787:	e9 ab 00 00 00       	jmp    837 <printf+0x16c>
      } else if(c == 's'){
 78c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 790:	75 40                	jne    7d2 <printf+0x107>
        s = (char*)*ap;
 792:	8b 45 e8             	mov    -0x18(%ebp),%eax
 795:	8b 00                	mov    (%eax),%eax
 797:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 79a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 79e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7a2:	75 07                	jne    7ab <printf+0xe0>
          s = "(null)";
 7a4:	c7 45 f4 ae 0a 00 00 	movl   $0xaae,-0xc(%ebp)
        while(*s != 0){
 7ab:	eb 1a                	jmp    7c7 <printf+0xfc>
          putc(fd, *s);
 7ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b0:	8a 00                	mov    (%eax),%al
 7b2:	0f be c0             	movsbl %al,%eax
 7b5:	83 ec 08             	sub    $0x8,%esp
 7b8:	50                   	push   %eax
 7b9:	ff 75 08             	pushl  0x8(%ebp)
 7bc:	e8 38 fe ff ff       	call   5f9 <putc>
 7c1:	83 c4 10             	add    $0x10,%esp
          s++;
 7c4:	ff 45 f4             	incl   -0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ca:	8a 00                	mov    (%eax),%al
 7cc:	84 c0                	test   %al,%al
 7ce:	75 dd                	jne    7ad <printf+0xe2>
 7d0:	eb 65                	jmp    837 <printf+0x16c>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7d2:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 7d6:	75 1d                	jne    7f5 <printf+0x12a>
        putc(fd, *ap);
 7d8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7db:	8b 00                	mov    (%eax),%eax
 7dd:	0f be c0             	movsbl %al,%eax
 7e0:	83 ec 08             	sub    $0x8,%esp
 7e3:	50                   	push   %eax
 7e4:	ff 75 08             	pushl  0x8(%ebp)
 7e7:	e8 0d fe ff ff       	call   5f9 <putc>
 7ec:	83 c4 10             	add    $0x10,%esp
        ap++;
 7ef:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7f3:	eb 42                	jmp    837 <printf+0x16c>
      } else if(c == '%'){
 7f5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7f9:	75 17                	jne    812 <printf+0x147>
        putc(fd, c);
 7fb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7fe:	0f be c0             	movsbl %al,%eax
 801:	83 ec 08             	sub    $0x8,%esp
 804:	50                   	push   %eax
 805:	ff 75 08             	pushl  0x8(%ebp)
 808:	e8 ec fd ff ff       	call   5f9 <putc>
 80d:	83 c4 10             	add    $0x10,%esp
 810:	eb 25                	jmp    837 <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 812:	83 ec 08             	sub    $0x8,%esp
 815:	6a 25                	push   $0x25
 817:	ff 75 08             	pushl  0x8(%ebp)
 81a:	e8 da fd ff ff       	call   5f9 <putc>
 81f:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 822:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 825:	0f be c0             	movsbl %al,%eax
 828:	83 ec 08             	sub    $0x8,%esp
 82b:	50                   	push   %eax
 82c:	ff 75 08             	pushl  0x8(%ebp)
 82f:	e8 c5 fd ff ff       	call   5f9 <putc>
 834:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 837:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 83e:	ff 45 f0             	incl   -0x10(%ebp)
 841:	8b 55 0c             	mov    0xc(%ebp),%edx
 844:	8b 45 f0             	mov    -0x10(%ebp),%eax
 847:	01 d0                	add    %edx,%eax
 849:	8a 00                	mov    (%eax),%al
 84b:	84 c0                	test   %al,%al
 84d:	0f 85 9a fe ff ff    	jne    6ed <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 853:	c9                   	leave  
 854:	c3                   	ret    

00000855 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 855:	55                   	push   %ebp
 856:	89 e5                	mov    %esp,%ebp
 858:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 85b:	8b 45 08             	mov    0x8(%ebp),%eax
 85e:	83 e8 08             	sub    $0x8,%eax
 861:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 864:	a1 a8 0d 00 00       	mov    0xda8,%eax
 869:	89 45 fc             	mov    %eax,-0x4(%ebp)
 86c:	eb 24                	jmp    892 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 86e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 871:	8b 00                	mov    (%eax),%eax
 873:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 876:	77 12                	ja     88a <free+0x35>
 878:	8b 45 f8             	mov    -0x8(%ebp),%eax
 87b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 87e:	77 24                	ja     8a4 <free+0x4f>
 880:	8b 45 fc             	mov    -0x4(%ebp),%eax
 883:	8b 00                	mov    (%eax),%eax
 885:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 888:	77 1a                	ja     8a4 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 88a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 88d:	8b 00                	mov    (%eax),%eax
 88f:	89 45 fc             	mov    %eax,-0x4(%ebp)
 892:	8b 45 f8             	mov    -0x8(%ebp),%eax
 895:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 898:	76 d4                	jbe    86e <free+0x19>
 89a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 89d:	8b 00                	mov    (%eax),%eax
 89f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8a2:	76 ca                	jbe    86e <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 8a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8a7:	8b 40 04             	mov    0x4(%eax),%eax
 8aa:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8b4:	01 c2                	add    %eax,%edx
 8b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8b9:	8b 00                	mov    (%eax),%eax
 8bb:	39 c2                	cmp    %eax,%edx
 8bd:	75 24                	jne    8e3 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 8bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8c2:	8b 50 04             	mov    0x4(%eax),%edx
 8c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c8:	8b 00                	mov    (%eax),%eax
 8ca:	8b 40 04             	mov    0x4(%eax),%eax
 8cd:	01 c2                	add    %eax,%edx
 8cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8d2:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 8d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d8:	8b 00                	mov    (%eax),%eax
 8da:	8b 10                	mov    (%eax),%edx
 8dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8df:	89 10                	mov    %edx,(%eax)
 8e1:	eb 0a                	jmp    8ed <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 8e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e6:	8b 10                	mov    (%eax),%edx
 8e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8eb:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 8ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f0:	8b 40 04             	mov    0x4(%eax),%eax
 8f3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8fd:	01 d0                	add    %edx,%eax
 8ff:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 902:	75 20                	jne    924 <free+0xcf>
    p->s.size += bp->s.size;
 904:	8b 45 fc             	mov    -0x4(%ebp),%eax
 907:	8b 50 04             	mov    0x4(%eax),%edx
 90a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 90d:	8b 40 04             	mov    0x4(%eax),%eax
 910:	01 c2                	add    %eax,%edx
 912:	8b 45 fc             	mov    -0x4(%ebp),%eax
 915:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 918:	8b 45 f8             	mov    -0x8(%ebp),%eax
 91b:	8b 10                	mov    (%eax),%edx
 91d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 920:	89 10                	mov    %edx,(%eax)
 922:	eb 08                	jmp    92c <free+0xd7>
  } else
    p->s.ptr = bp;
 924:	8b 45 fc             	mov    -0x4(%ebp),%eax
 927:	8b 55 f8             	mov    -0x8(%ebp),%edx
 92a:	89 10                	mov    %edx,(%eax)
  freep = p;
 92c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 92f:	a3 a8 0d 00 00       	mov    %eax,0xda8
}
 934:	c9                   	leave  
 935:	c3                   	ret    

00000936 <morecore>:

static Header*
morecore(uint nu)
{
 936:	55                   	push   %ebp
 937:	89 e5                	mov    %esp,%ebp
 939:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 93c:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 943:	77 07                	ja     94c <morecore+0x16>
    nu = 4096;
 945:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 94c:	8b 45 08             	mov    0x8(%ebp),%eax
 94f:	c1 e0 03             	shl    $0x3,%eax
 952:	83 ec 0c             	sub    $0xc,%esp
 955:	50                   	push   %eax
 956:	e8 86 fc ff ff       	call   5e1 <sbrk>
 95b:	83 c4 10             	add    $0x10,%esp
 95e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 961:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 965:	75 07                	jne    96e <morecore+0x38>
    return 0;
 967:	b8 00 00 00 00       	mov    $0x0,%eax
 96c:	eb 26                	jmp    994 <morecore+0x5e>
  hp = (Header*)p;
 96e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 971:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 974:	8b 45 f0             	mov    -0x10(%ebp),%eax
 977:	8b 55 08             	mov    0x8(%ebp),%edx
 97a:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 97d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 980:	83 c0 08             	add    $0x8,%eax
 983:	83 ec 0c             	sub    $0xc,%esp
 986:	50                   	push   %eax
 987:	e8 c9 fe ff ff       	call   855 <free>
 98c:	83 c4 10             	add    $0x10,%esp
  return freep;
 98f:	a1 a8 0d 00 00       	mov    0xda8,%eax
}
 994:	c9                   	leave  
 995:	c3                   	ret    

00000996 <malloc>:

void*
malloc(uint nbytes)
{
 996:	55                   	push   %ebp
 997:	89 e5                	mov    %esp,%ebp
 999:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 99c:	8b 45 08             	mov    0x8(%ebp),%eax
 99f:	83 c0 07             	add    $0x7,%eax
 9a2:	c1 e8 03             	shr    $0x3,%eax
 9a5:	40                   	inc    %eax
 9a6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 9a9:	a1 a8 0d 00 00       	mov    0xda8,%eax
 9ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9b1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 9b5:	75 23                	jne    9da <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
 9b7:	c7 45 f0 a0 0d 00 00 	movl   $0xda0,-0x10(%ebp)
 9be:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9c1:	a3 a8 0d 00 00       	mov    %eax,0xda8
 9c6:	a1 a8 0d 00 00       	mov    0xda8,%eax
 9cb:	a3 a0 0d 00 00       	mov    %eax,0xda0
    base.s.size = 0;
 9d0:	c7 05 a4 0d 00 00 00 	movl   $0x0,0xda4
 9d7:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9da:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9dd:	8b 00                	mov    (%eax),%eax
 9df:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e5:	8b 40 04             	mov    0x4(%eax),%eax
 9e8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9eb:	72 4d                	jb     a3a <malloc+0xa4>
      if(p->s.size == nunits)
 9ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f0:	8b 40 04             	mov    0x4(%eax),%eax
 9f3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9f6:	75 0c                	jne    a04 <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
 9f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9fb:	8b 10                	mov    (%eax),%edx
 9fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a00:	89 10                	mov    %edx,(%eax)
 a02:	eb 26                	jmp    a2a <malloc+0x94>
      else {
        p->s.size -= nunits;
 a04:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a07:	8b 40 04             	mov    0x4(%eax),%eax
 a0a:	2b 45 ec             	sub    -0x14(%ebp),%eax
 a0d:	89 c2                	mov    %eax,%edx
 a0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a12:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 a15:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a18:	8b 40 04             	mov    0x4(%eax),%eax
 a1b:	c1 e0 03             	shl    $0x3,%eax
 a1e:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 a21:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a24:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a27:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 a2a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a2d:	a3 a8 0d 00 00       	mov    %eax,0xda8
      return (void*)(p + 1);
 a32:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a35:	83 c0 08             	add    $0x8,%eax
 a38:	eb 3b                	jmp    a75 <malloc+0xdf>
    }
    if(p == freep)
 a3a:	a1 a8 0d 00 00       	mov    0xda8,%eax
 a3f:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a42:	75 1e                	jne    a62 <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
 a44:	83 ec 0c             	sub    $0xc,%esp
 a47:	ff 75 ec             	pushl  -0x14(%ebp)
 a4a:	e8 e7 fe ff ff       	call   936 <morecore>
 a4f:	83 c4 10             	add    $0x10,%esp
 a52:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a55:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a59:	75 07                	jne    a62 <malloc+0xcc>
        return 0;
 a5b:	b8 00 00 00 00       	mov    $0x0,%eax
 a60:	eb 13                	jmp    a75 <malloc+0xdf>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a62:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a65:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a68:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a6b:	8b 00                	mov    (%eax),%eax
 a6d:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 a70:	e9 6d ff ff ff       	jmp    9e2 <malloc+0x4c>
}
 a75:	c9                   	leave  
 a76:	c3                   	ret    
