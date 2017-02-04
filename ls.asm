
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 14             	sub    $0x14,%esp
  static char buf[DIRSIZ+1];
  char *p;
  
  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   7:	83 ec 0c             	sub    $0xc,%esp
   a:	ff 75 08             	pushl  0x8(%ebp)
   d:	e8 b3 03 00 00       	call   3c5 <strlen>
  12:	83 c4 10             	add    $0x10,%esp
  15:	8b 55 08             	mov    0x8(%ebp),%edx
  18:	01 d0                	add    %edx,%eax
  1a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1d:	eb 03                	jmp    22 <fmtname+0x22>
  1f:	ff 4d f4             	decl   -0xc(%ebp)
  22:	8b 45 f4             	mov    -0xc(%ebp),%eax
  25:	3b 45 08             	cmp    0x8(%ebp),%eax
  28:	72 09                	jb     33 <fmtname+0x33>
  2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  2d:	8a 00                	mov    (%eax),%al
  2f:	3c 2f                	cmp    $0x2f,%al
  31:	75 ec                	jne    1f <fmtname+0x1f>
    ;
  p++;
  33:	ff 45 f4             	incl   -0xc(%ebp)
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  36:	83 ec 0c             	sub    $0xc,%esp
  39:	ff 75 f4             	pushl  -0xc(%ebp)
  3c:	e8 84 03 00 00       	call   3c5 <strlen>
  41:	83 c4 10             	add    $0x10,%esp
  44:	83 f8 0d             	cmp    $0xd,%eax
  47:	76 05                	jbe    4e <fmtname+0x4e>
    return p;
  49:	8b 45 f4             	mov    -0xc(%ebp),%eax
  4c:	eb 60                	jmp    ae <fmtname+0xae>
  memmove(buf, p, strlen(p));
  4e:	83 ec 0c             	sub    $0xc,%esp
  51:	ff 75 f4             	pushl  -0xc(%ebp)
  54:	e8 6c 03 00 00       	call   3c5 <strlen>
  59:	83 c4 10             	add    $0x10,%esp
  5c:	83 ec 04             	sub    $0x4,%esp
  5f:	50                   	push   %eax
  60:	ff 75 f4             	pushl  -0xc(%ebp)
  63:	68 9c 0d 00 00       	push   $0xd9c
  68:	e8 c7 04 00 00       	call   534 <memmove>
  6d:	83 c4 10             	add    $0x10,%esp
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  70:	83 ec 0c             	sub    $0xc,%esp
  73:	ff 75 f4             	pushl  -0xc(%ebp)
  76:	e8 4a 03 00 00       	call   3c5 <strlen>
  7b:	83 c4 10             	add    $0x10,%esp
  7e:	ba 0e 00 00 00       	mov    $0xe,%edx
  83:	89 d3                	mov    %edx,%ebx
  85:	29 c3                	sub    %eax,%ebx
  87:	83 ec 0c             	sub    $0xc,%esp
  8a:	ff 75 f4             	pushl  -0xc(%ebp)
  8d:	e8 33 03 00 00       	call   3c5 <strlen>
  92:	83 c4 10             	add    $0x10,%esp
  95:	05 9c 0d 00 00       	add    $0xd9c,%eax
  9a:	83 ec 04             	sub    $0x4,%esp
  9d:	53                   	push   %ebx
  9e:	6a 20                	push   $0x20
  a0:	50                   	push   %eax
  a1:	e8 44 03 00 00       	call   3ea <memset>
  a6:	83 c4 10             	add    $0x10,%esp
  return buf;
  a9:	b8 9c 0d 00 00       	mov    $0xd9c,%eax
}
  ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  b1:	c9                   	leave  
  b2:	c3                   	ret    

000000b3 <ls>:

void
ls(char *path)
{
  b3:	55                   	push   %ebp
  b4:	89 e5                	mov    %esp,%ebp
  b6:	57                   	push   %edi
  b7:	56                   	push   %esi
  b8:	53                   	push   %ebx
  b9:	81 ec 3c 02 00 00    	sub    $0x23c,%esp
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
  bf:	83 ec 08             	sub    $0x8,%esp
  c2:	6a 00                	push   $0x0
  c4:	ff 75 08             	pushl  0x8(%ebp)
  c7:	e8 ec 04 00 00       	call   5b8 <open>
  cc:	83 c4 10             	add    $0x10,%esp
  cf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  d2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  d6:	79 1a                	jns    f2 <ls+0x3f>
    printf(2, "ls: cannot open %s\n", path);
  d8:	83 ec 04             	sub    $0x4,%esp
  db:	ff 75 08             	pushl  0x8(%ebp)
  de:	68 96 0a 00 00       	push   $0xa96
  e3:	6a 02                	push   $0x2
  e5:	e8 00 06 00 00       	call   6ea <printf>
  ea:	83 c4 10             	add    $0x10,%esp
    return;
  ed:	e9 dd 01 00 00       	jmp    2cf <ls+0x21c>
  }
  
  if(fstat(fd, &st) < 0){
  f2:	83 ec 08             	sub    $0x8,%esp
  f5:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
  fb:	50                   	push   %eax
  fc:	ff 75 e4             	pushl  -0x1c(%ebp)
  ff:	e8 cc 04 00 00       	call   5d0 <fstat>
 104:	83 c4 10             	add    $0x10,%esp
 107:	85 c0                	test   %eax,%eax
 109:	79 28                	jns    133 <ls+0x80>
    printf(2, "ls: cannot stat %s\n", path);
 10b:	83 ec 04             	sub    $0x4,%esp
 10e:	ff 75 08             	pushl  0x8(%ebp)
 111:	68 aa 0a 00 00       	push   $0xaaa
 116:	6a 02                	push   $0x2
 118:	e8 cd 05 00 00       	call   6ea <printf>
 11d:	83 c4 10             	add    $0x10,%esp
    close(fd);
 120:	83 ec 0c             	sub    $0xc,%esp
 123:	ff 75 e4             	pushl  -0x1c(%ebp)
 126:	e8 75 04 00 00       	call   5a0 <close>
 12b:	83 c4 10             	add    $0x10,%esp
    return;
 12e:	e9 9c 01 00 00       	jmp    2cf <ls+0x21c>
  }
  
  switch(st.type){
 133:	8b 85 bc fd ff ff    	mov    -0x244(%ebp),%eax
 139:	98                   	cwtl   
 13a:	83 f8 01             	cmp    $0x1,%eax
 13d:	74 47                	je     186 <ls+0xd3>
 13f:	83 f8 02             	cmp    $0x2,%eax
 142:	0f 85 79 01 00 00    	jne    2c1 <ls+0x20e>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 148:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
 14e:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
 154:	8b 85 bc fd ff ff    	mov    -0x244(%ebp),%eax
 15a:	0f bf d8             	movswl %ax,%ebx
 15d:	83 ec 0c             	sub    $0xc,%esp
 160:	ff 75 08             	pushl  0x8(%ebp)
 163:	e8 98 fe ff ff       	call   0 <fmtname>
 168:	83 c4 10             	add    $0x10,%esp
 16b:	83 ec 08             	sub    $0x8,%esp
 16e:	57                   	push   %edi
 16f:	56                   	push   %esi
 170:	53                   	push   %ebx
 171:	50                   	push   %eax
 172:	68 be 0a 00 00       	push   $0xabe
 177:	6a 01                	push   $0x1
 179:	e8 6c 05 00 00       	call   6ea <printf>
 17e:	83 c4 20             	add    $0x20,%esp
    break;
 181:	e9 3b 01 00 00       	jmp    2c1 <ls+0x20e>
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 186:	83 ec 0c             	sub    $0xc,%esp
 189:	ff 75 08             	pushl  0x8(%ebp)
 18c:	e8 34 02 00 00       	call   3c5 <strlen>
 191:	83 c4 10             	add    $0x10,%esp
 194:	83 c0 10             	add    $0x10,%eax
 197:	3d 00 02 00 00       	cmp    $0x200,%eax
 19c:	76 17                	jbe    1b5 <ls+0x102>
      printf(1, "ls: path too long\n");
 19e:	83 ec 08             	sub    $0x8,%esp
 1a1:	68 cb 0a 00 00       	push   $0xacb
 1a6:	6a 01                	push   $0x1
 1a8:	e8 3d 05 00 00       	call   6ea <printf>
 1ad:	83 c4 10             	add    $0x10,%esp
      break;
 1b0:	e9 0c 01 00 00       	jmp    2c1 <ls+0x20e>
    }
    strcpy(buf, path);
 1b5:	83 ec 08             	sub    $0x8,%esp
 1b8:	ff 75 08             	pushl  0x8(%ebp)
 1bb:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1c1:	50                   	push   %eax
 1c2:	e8 98 01 00 00       	call   35f <strcpy>
 1c7:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 1ca:	83 ec 0c             	sub    $0xc,%esp
 1cd:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1d3:	50                   	push   %eax
 1d4:	e8 ec 01 00 00       	call   3c5 <strlen>
 1d9:	83 c4 10             	add    $0x10,%esp
 1dc:	8d 95 e0 fd ff ff    	lea    -0x220(%ebp),%edx
 1e2:	01 d0                	add    %edx,%eax
 1e4:	89 45 e0             	mov    %eax,-0x20(%ebp)
    *p++ = '/';
 1e7:	8b 45 e0             	mov    -0x20(%ebp),%eax
 1ea:	8d 50 01             	lea    0x1(%eax),%edx
 1ed:	89 55 e0             	mov    %edx,-0x20(%ebp)
 1f0:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1f3:	e9 a8 00 00 00       	jmp    2a0 <ls+0x1ed>
      if(de.inum == 0)
 1f8:	8b 85 d0 fd ff ff    	mov    -0x230(%ebp),%eax
 1fe:	66 85 c0             	test   %ax,%ax
 201:	75 05                	jne    208 <ls+0x155>
        continue;
 203:	e9 98 00 00 00       	jmp    2a0 <ls+0x1ed>
      memmove(p, de.name, DIRSIZ);
 208:	83 ec 04             	sub    $0x4,%esp
 20b:	6a 0e                	push   $0xe
 20d:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 213:	83 c0 02             	add    $0x2,%eax
 216:	50                   	push   %eax
 217:	ff 75 e0             	pushl  -0x20(%ebp)
 21a:	e8 15 03 00 00       	call   534 <memmove>
 21f:	83 c4 10             	add    $0x10,%esp
      p[DIRSIZ] = 0;
 222:	8b 45 e0             	mov    -0x20(%ebp),%eax
 225:	83 c0 0e             	add    $0xe,%eax
 228:	c6 00 00             	movb   $0x0,(%eax)
      if(stat(buf, &st) < 0){
 22b:	83 ec 08             	sub    $0x8,%esp
 22e:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
 234:	50                   	push   %eax
 235:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 23b:	50                   	push   %eax
 23c:	e8 5c 02 00 00       	call   49d <stat>
 241:	83 c4 10             	add    $0x10,%esp
 244:	85 c0                	test   %eax,%eax
 246:	79 1b                	jns    263 <ls+0x1b0>
        printf(1, "ls: cannot stat %s\n", buf);
 248:	83 ec 04             	sub    $0x4,%esp
 24b:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 251:	50                   	push   %eax
 252:	68 aa 0a 00 00       	push   $0xaaa
 257:	6a 01                	push   $0x1
 259:	e8 8c 04 00 00       	call   6ea <printf>
 25e:	83 c4 10             	add    $0x10,%esp
        continue;
 261:	eb 3d                	jmp    2a0 <ls+0x1ed>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 263:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
 269:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
 26f:	8b 85 bc fd ff ff    	mov    -0x244(%ebp),%eax
 275:	0f bf d8             	movswl %ax,%ebx
 278:	83 ec 0c             	sub    $0xc,%esp
 27b:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 281:	50                   	push   %eax
 282:	e8 79 fd ff ff       	call   0 <fmtname>
 287:	83 c4 10             	add    $0x10,%esp
 28a:	83 ec 08             	sub    $0x8,%esp
 28d:	57                   	push   %edi
 28e:	56                   	push   %esi
 28f:	53                   	push   %ebx
 290:	50                   	push   %eax
 291:	68 be 0a 00 00       	push   $0xabe
 296:	6a 01                	push   $0x1
 298:	e8 4d 04 00 00       	call   6ea <printf>
 29d:	83 c4 20             	add    $0x20,%esp
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 2a0:	83 ec 04             	sub    $0x4,%esp
 2a3:	6a 10                	push   $0x10
 2a5:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 2ab:	50                   	push   %eax
 2ac:	ff 75 e4             	pushl  -0x1c(%ebp)
 2af:	e8 dc 02 00 00       	call   590 <read>
 2b4:	83 c4 10             	add    $0x10,%esp
 2b7:	83 f8 10             	cmp    $0x10,%eax
 2ba:	0f 84 38 ff ff ff    	je     1f8 <ls+0x145>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
 2c0:	90                   	nop
  }
  close(fd);
 2c1:	83 ec 0c             	sub    $0xc,%esp
 2c4:	ff 75 e4             	pushl  -0x1c(%ebp)
 2c7:	e8 d4 02 00 00       	call   5a0 <close>
 2cc:	83 c4 10             	add    $0x10,%esp
}
 2cf:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2d2:	5b                   	pop    %ebx
 2d3:	5e                   	pop    %esi
 2d4:	5f                   	pop    %edi
 2d5:	5d                   	pop    %ebp
 2d6:	c3                   	ret    

000002d7 <main>:

int
main(int argc, char *argv[])
{
 2d7:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 2db:	83 e4 f0             	and    $0xfffffff0,%esp
 2de:	ff 71 fc             	pushl  -0x4(%ecx)
 2e1:	55                   	push   %ebp
 2e2:	89 e5                	mov    %esp,%ebp
 2e4:	53                   	push   %ebx
 2e5:	51                   	push   %ecx
 2e6:	83 ec 10             	sub    $0x10,%esp
 2e9:	89 cb                	mov    %ecx,%ebx
  int i;

  if(argc < 2){
 2eb:	83 3b 01             	cmpl   $0x1,(%ebx)
 2ee:	7f 15                	jg     305 <main+0x2e>
    ls(".");
 2f0:	83 ec 0c             	sub    $0xc,%esp
 2f3:	68 de 0a 00 00       	push   $0xade
 2f8:	e8 b6 fd ff ff       	call   b3 <ls>
 2fd:	83 c4 10             	add    $0x10,%esp
    exit();
 300:	e8 73 02 00 00       	call   578 <exit>
  }
  for(i=1; i<argc; i++)
 305:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
 30c:	eb 20                	jmp    32e <main+0x57>
    ls(argv[i]);
 30e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 311:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 318:	8b 43 04             	mov    0x4(%ebx),%eax
 31b:	01 d0                	add    %edx,%eax
 31d:	8b 00                	mov    (%eax),%eax
 31f:	83 ec 0c             	sub    $0xc,%esp
 322:	50                   	push   %eax
 323:	e8 8b fd ff ff       	call   b3 <ls>
 328:	83 c4 10             	add    $0x10,%esp

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
 32b:	ff 45 f4             	incl   -0xc(%ebp)
 32e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 331:	3b 03                	cmp    (%ebx),%eax
 333:	7c d9                	jl     30e <main+0x37>
    ls(argv[i]);
  exit();
 335:	e8 3e 02 00 00       	call   578 <exit>

0000033a <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 33a:	55                   	push   %ebp
 33b:	89 e5                	mov    %esp,%ebp
 33d:	57                   	push   %edi
 33e:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 33f:	8b 4d 08             	mov    0x8(%ebp),%ecx
 342:	8b 55 10             	mov    0x10(%ebp),%edx
 345:	8b 45 0c             	mov    0xc(%ebp),%eax
 348:	89 cb                	mov    %ecx,%ebx
 34a:	89 df                	mov    %ebx,%edi
 34c:	89 d1                	mov    %edx,%ecx
 34e:	fc                   	cld    
 34f:	f3 aa                	rep stos %al,%es:(%edi)
 351:	89 ca                	mov    %ecx,%edx
 353:	89 fb                	mov    %edi,%ebx
 355:	89 5d 08             	mov    %ebx,0x8(%ebp)
 358:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 35b:	5b                   	pop    %ebx
 35c:	5f                   	pop    %edi
 35d:	5d                   	pop    %ebp
 35e:	c3                   	ret    

0000035f <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 35f:	55                   	push   %ebp
 360:	89 e5                	mov    %esp,%ebp
 362:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 365:	8b 45 08             	mov    0x8(%ebp),%eax
 368:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 36b:	90                   	nop
 36c:	8b 45 08             	mov    0x8(%ebp),%eax
 36f:	8d 50 01             	lea    0x1(%eax),%edx
 372:	89 55 08             	mov    %edx,0x8(%ebp)
 375:	8b 55 0c             	mov    0xc(%ebp),%edx
 378:	8d 4a 01             	lea    0x1(%edx),%ecx
 37b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 37e:	8a 12                	mov    (%edx),%dl
 380:	88 10                	mov    %dl,(%eax)
 382:	8a 00                	mov    (%eax),%al
 384:	84 c0                	test   %al,%al
 386:	75 e4                	jne    36c <strcpy+0xd>
    ;
  return os;
 388:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 38b:	c9                   	leave  
 38c:	c3                   	ret    

0000038d <strcmp>:

int
strcmp(const char *p, const char *q)
{
 38d:	55                   	push   %ebp
 38e:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 390:	eb 06                	jmp    398 <strcmp+0xb>
    p++, q++;
 392:	ff 45 08             	incl   0x8(%ebp)
 395:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 398:	8b 45 08             	mov    0x8(%ebp),%eax
 39b:	8a 00                	mov    (%eax),%al
 39d:	84 c0                	test   %al,%al
 39f:	74 0e                	je     3af <strcmp+0x22>
 3a1:	8b 45 08             	mov    0x8(%ebp),%eax
 3a4:	8a 10                	mov    (%eax),%dl
 3a6:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a9:	8a 00                	mov    (%eax),%al
 3ab:	38 c2                	cmp    %al,%dl
 3ad:	74 e3                	je     392 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3af:	8b 45 08             	mov    0x8(%ebp),%eax
 3b2:	8a 00                	mov    (%eax),%al
 3b4:	0f b6 d0             	movzbl %al,%edx
 3b7:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ba:	8a 00                	mov    (%eax),%al
 3bc:	0f b6 c0             	movzbl %al,%eax
 3bf:	29 c2                	sub    %eax,%edx
 3c1:	89 d0                	mov    %edx,%eax
}
 3c3:	5d                   	pop    %ebp
 3c4:	c3                   	ret    

000003c5 <strlen>:

uint
strlen(char *s)
{
 3c5:	55                   	push   %ebp
 3c6:	89 e5                	mov    %esp,%ebp
 3c8:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 3cb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3d2:	eb 03                	jmp    3d7 <strlen+0x12>
 3d4:	ff 45 fc             	incl   -0x4(%ebp)
 3d7:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3da:	8b 45 08             	mov    0x8(%ebp),%eax
 3dd:	01 d0                	add    %edx,%eax
 3df:	8a 00                	mov    (%eax),%al
 3e1:	84 c0                	test   %al,%al
 3e3:	75 ef                	jne    3d4 <strlen+0xf>
    ;
  return n;
 3e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3e8:	c9                   	leave  
 3e9:	c3                   	ret    

000003ea <memset>:

void*
memset(void *dst, int c, uint n)
{
 3ea:	55                   	push   %ebp
 3eb:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 3ed:	8b 45 10             	mov    0x10(%ebp),%eax
 3f0:	50                   	push   %eax
 3f1:	ff 75 0c             	pushl  0xc(%ebp)
 3f4:	ff 75 08             	pushl  0x8(%ebp)
 3f7:	e8 3e ff ff ff       	call   33a <stosb>
 3fc:	83 c4 0c             	add    $0xc,%esp
  return dst;
 3ff:	8b 45 08             	mov    0x8(%ebp),%eax
}
 402:	c9                   	leave  
 403:	c3                   	ret    

00000404 <strchr>:

char*
strchr(const char *s, char c)
{
 404:	55                   	push   %ebp
 405:	89 e5                	mov    %esp,%ebp
 407:	83 ec 04             	sub    $0x4,%esp
 40a:	8b 45 0c             	mov    0xc(%ebp),%eax
 40d:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 410:	eb 12                	jmp    424 <strchr+0x20>
    if(*s == c)
 412:	8b 45 08             	mov    0x8(%ebp),%eax
 415:	8a 00                	mov    (%eax),%al
 417:	3a 45 fc             	cmp    -0x4(%ebp),%al
 41a:	75 05                	jne    421 <strchr+0x1d>
      return (char*)s;
 41c:	8b 45 08             	mov    0x8(%ebp),%eax
 41f:	eb 11                	jmp    432 <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 421:	ff 45 08             	incl   0x8(%ebp)
 424:	8b 45 08             	mov    0x8(%ebp),%eax
 427:	8a 00                	mov    (%eax),%al
 429:	84 c0                	test   %al,%al
 42b:	75 e5                	jne    412 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 42d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 432:	c9                   	leave  
 433:	c3                   	ret    

00000434 <gets>:

char*
gets(char *buf, int max)
{
 434:	55                   	push   %ebp
 435:	89 e5                	mov    %esp,%ebp
 437:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 43a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 441:	eb 41                	jmp    484 <gets+0x50>
    cc = read(0, &c, 1);
 443:	83 ec 04             	sub    $0x4,%esp
 446:	6a 01                	push   $0x1
 448:	8d 45 ef             	lea    -0x11(%ebp),%eax
 44b:	50                   	push   %eax
 44c:	6a 00                	push   $0x0
 44e:	e8 3d 01 00 00       	call   590 <read>
 453:	83 c4 10             	add    $0x10,%esp
 456:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 459:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 45d:	7f 02                	jg     461 <gets+0x2d>
      break;
 45f:	eb 2c                	jmp    48d <gets+0x59>
    buf[i++] = c;
 461:	8b 45 f4             	mov    -0xc(%ebp),%eax
 464:	8d 50 01             	lea    0x1(%eax),%edx
 467:	89 55 f4             	mov    %edx,-0xc(%ebp)
 46a:	89 c2                	mov    %eax,%edx
 46c:	8b 45 08             	mov    0x8(%ebp),%eax
 46f:	01 c2                	add    %eax,%edx
 471:	8a 45 ef             	mov    -0x11(%ebp),%al
 474:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 476:	8a 45 ef             	mov    -0x11(%ebp),%al
 479:	3c 0a                	cmp    $0xa,%al
 47b:	74 10                	je     48d <gets+0x59>
 47d:	8a 45 ef             	mov    -0x11(%ebp),%al
 480:	3c 0d                	cmp    $0xd,%al
 482:	74 09                	je     48d <gets+0x59>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 484:	8b 45 f4             	mov    -0xc(%ebp),%eax
 487:	40                   	inc    %eax
 488:	3b 45 0c             	cmp    0xc(%ebp),%eax
 48b:	7c b6                	jl     443 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 48d:	8b 55 f4             	mov    -0xc(%ebp),%edx
 490:	8b 45 08             	mov    0x8(%ebp),%eax
 493:	01 d0                	add    %edx,%eax
 495:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 498:	8b 45 08             	mov    0x8(%ebp),%eax
}
 49b:	c9                   	leave  
 49c:	c3                   	ret    

0000049d <stat>:

int
stat(char *n, struct stat *st)
{
 49d:	55                   	push   %ebp
 49e:	89 e5                	mov    %esp,%ebp
 4a0:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4a3:	83 ec 08             	sub    $0x8,%esp
 4a6:	6a 00                	push   $0x0
 4a8:	ff 75 08             	pushl  0x8(%ebp)
 4ab:	e8 08 01 00 00       	call   5b8 <open>
 4b0:	83 c4 10             	add    $0x10,%esp
 4b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 4b6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4ba:	79 07                	jns    4c3 <stat+0x26>
    return -1;
 4bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4c1:	eb 25                	jmp    4e8 <stat+0x4b>
  r = fstat(fd, st);
 4c3:	83 ec 08             	sub    $0x8,%esp
 4c6:	ff 75 0c             	pushl  0xc(%ebp)
 4c9:	ff 75 f4             	pushl  -0xc(%ebp)
 4cc:	e8 ff 00 00 00       	call   5d0 <fstat>
 4d1:	83 c4 10             	add    $0x10,%esp
 4d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 4d7:	83 ec 0c             	sub    $0xc,%esp
 4da:	ff 75 f4             	pushl  -0xc(%ebp)
 4dd:	e8 be 00 00 00       	call   5a0 <close>
 4e2:	83 c4 10             	add    $0x10,%esp
  return r;
 4e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 4e8:	c9                   	leave  
 4e9:	c3                   	ret    

000004ea <atoi>:

int
atoi(const char *s)
{
 4ea:	55                   	push   %ebp
 4eb:	89 e5                	mov    %esp,%ebp
 4ed:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 4f0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 4f7:	eb 24                	jmp    51d <atoi+0x33>
    n = n*10 + *s++ - '0';
 4f9:	8b 55 fc             	mov    -0x4(%ebp),%edx
 4fc:	89 d0                	mov    %edx,%eax
 4fe:	c1 e0 02             	shl    $0x2,%eax
 501:	01 d0                	add    %edx,%eax
 503:	01 c0                	add    %eax,%eax
 505:	89 c1                	mov    %eax,%ecx
 507:	8b 45 08             	mov    0x8(%ebp),%eax
 50a:	8d 50 01             	lea    0x1(%eax),%edx
 50d:	89 55 08             	mov    %edx,0x8(%ebp)
 510:	8a 00                	mov    (%eax),%al
 512:	0f be c0             	movsbl %al,%eax
 515:	01 c8                	add    %ecx,%eax
 517:	83 e8 30             	sub    $0x30,%eax
 51a:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 51d:	8b 45 08             	mov    0x8(%ebp),%eax
 520:	8a 00                	mov    (%eax),%al
 522:	3c 2f                	cmp    $0x2f,%al
 524:	7e 09                	jle    52f <atoi+0x45>
 526:	8b 45 08             	mov    0x8(%ebp),%eax
 529:	8a 00                	mov    (%eax),%al
 52b:	3c 39                	cmp    $0x39,%al
 52d:	7e ca                	jle    4f9 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 52f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 532:	c9                   	leave  
 533:	c3                   	ret    

00000534 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 534:	55                   	push   %ebp
 535:	89 e5                	mov    %esp,%ebp
 537:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 53a:	8b 45 08             	mov    0x8(%ebp),%eax
 53d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 540:	8b 45 0c             	mov    0xc(%ebp),%eax
 543:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 546:	eb 16                	jmp    55e <memmove+0x2a>
    *dst++ = *src++;
 548:	8b 45 fc             	mov    -0x4(%ebp),%eax
 54b:	8d 50 01             	lea    0x1(%eax),%edx
 54e:	89 55 fc             	mov    %edx,-0x4(%ebp)
 551:	8b 55 f8             	mov    -0x8(%ebp),%edx
 554:	8d 4a 01             	lea    0x1(%edx),%ecx
 557:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 55a:	8a 12                	mov    (%edx),%dl
 55c:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 55e:	8b 45 10             	mov    0x10(%ebp),%eax
 561:	8d 50 ff             	lea    -0x1(%eax),%edx
 564:	89 55 10             	mov    %edx,0x10(%ebp)
 567:	85 c0                	test   %eax,%eax
 569:	7f dd                	jg     548 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 56b:	8b 45 08             	mov    0x8(%ebp),%eax
}
 56e:	c9                   	leave  
 56f:	c3                   	ret    

00000570 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 570:	b8 01 00 00 00       	mov    $0x1,%eax
 575:	cd 40                	int    $0x40
 577:	c3                   	ret    

00000578 <exit>:
SYSCALL(exit)
 578:	b8 02 00 00 00       	mov    $0x2,%eax
 57d:	cd 40                	int    $0x40
 57f:	c3                   	ret    

00000580 <wait>:
SYSCALL(wait)
 580:	b8 03 00 00 00       	mov    $0x3,%eax
 585:	cd 40                	int    $0x40
 587:	c3                   	ret    

00000588 <pipe>:
SYSCALL(pipe)
 588:	b8 04 00 00 00       	mov    $0x4,%eax
 58d:	cd 40                	int    $0x40
 58f:	c3                   	ret    

00000590 <read>:
SYSCALL(read)
 590:	b8 05 00 00 00       	mov    $0x5,%eax
 595:	cd 40                	int    $0x40
 597:	c3                   	ret    

00000598 <write>:
SYSCALL(write)
 598:	b8 10 00 00 00       	mov    $0x10,%eax
 59d:	cd 40                	int    $0x40
 59f:	c3                   	ret    

000005a0 <close>:
SYSCALL(close)
 5a0:	b8 15 00 00 00       	mov    $0x15,%eax
 5a5:	cd 40                	int    $0x40
 5a7:	c3                   	ret    

000005a8 <kill>:
SYSCALL(kill)
 5a8:	b8 06 00 00 00       	mov    $0x6,%eax
 5ad:	cd 40                	int    $0x40
 5af:	c3                   	ret    

000005b0 <exec>:
SYSCALL(exec)
 5b0:	b8 07 00 00 00       	mov    $0x7,%eax
 5b5:	cd 40                	int    $0x40
 5b7:	c3                   	ret    

000005b8 <open>:
SYSCALL(open)
 5b8:	b8 0f 00 00 00       	mov    $0xf,%eax
 5bd:	cd 40                	int    $0x40
 5bf:	c3                   	ret    

000005c0 <mknod>:
SYSCALL(mknod)
 5c0:	b8 11 00 00 00       	mov    $0x11,%eax
 5c5:	cd 40                	int    $0x40
 5c7:	c3                   	ret    

000005c8 <unlink>:
SYSCALL(unlink)
 5c8:	b8 12 00 00 00       	mov    $0x12,%eax
 5cd:	cd 40                	int    $0x40
 5cf:	c3                   	ret    

000005d0 <fstat>:
SYSCALL(fstat)
 5d0:	b8 08 00 00 00       	mov    $0x8,%eax
 5d5:	cd 40                	int    $0x40
 5d7:	c3                   	ret    

000005d8 <link>:
SYSCALL(link)
 5d8:	b8 13 00 00 00       	mov    $0x13,%eax
 5dd:	cd 40                	int    $0x40
 5df:	c3                   	ret    

000005e0 <mkdir>:
SYSCALL(mkdir)
 5e0:	b8 14 00 00 00       	mov    $0x14,%eax
 5e5:	cd 40                	int    $0x40
 5e7:	c3                   	ret    

000005e8 <chdir>:
SYSCALL(chdir)
 5e8:	b8 09 00 00 00       	mov    $0x9,%eax
 5ed:	cd 40                	int    $0x40
 5ef:	c3                   	ret    

000005f0 <dup>:
SYSCALL(dup)
 5f0:	b8 0a 00 00 00       	mov    $0xa,%eax
 5f5:	cd 40                	int    $0x40
 5f7:	c3                   	ret    

000005f8 <getpid>:
SYSCALL(getpid)
 5f8:	b8 0b 00 00 00       	mov    $0xb,%eax
 5fd:	cd 40                	int    $0x40
 5ff:	c3                   	ret    

00000600 <sbrk>:
SYSCALL(sbrk)
 600:	b8 0c 00 00 00       	mov    $0xc,%eax
 605:	cd 40                	int    $0x40
 607:	c3                   	ret    

00000608 <sleep>:
SYSCALL(sleep)
 608:	b8 0d 00 00 00       	mov    $0xd,%eax
 60d:	cd 40                	int    $0x40
 60f:	c3                   	ret    

00000610 <uptime>:
SYSCALL(uptime)
 610:	b8 0e 00 00 00       	mov    $0xe,%eax
 615:	cd 40                	int    $0x40
 617:	c3                   	ret    

00000618 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 618:	55                   	push   %ebp
 619:	89 e5                	mov    %esp,%ebp
 61b:	83 ec 18             	sub    $0x18,%esp
 61e:	8b 45 0c             	mov    0xc(%ebp),%eax
 621:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 624:	83 ec 04             	sub    $0x4,%esp
 627:	6a 01                	push   $0x1
 629:	8d 45 f4             	lea    -0xc(%ebp),%eax
 62c:	50                   	push   %eax
 62d:	ff 75 08             	pushl  0x8(%ebp)
 630:	e8 63 ff ff ff       	call   598 <write>
 635:	83 c4 10             	add    $0x10,%esp
}
 638:	c9                   	leave  
 639:	c3                   	ret    

0000063a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 63a:	55                   	push   %ebp
 63b:	89 e5                	mov    %esp,%ebp
 63d:	53                   	push   %ebx
 63e:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 641:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 648:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 64c:	74 17                	je     665 <printint+0x2b>
 64e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 652:	79 11                	jns    665 <printint+0x2b>
    neg = 1;
 654:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 65b:	8b 45 0c             	mov    0xc(%ebp),%eax
 65e:	f7 d8                	neg    %eax
 660:	89 45 ec             	mov    %eax,-0x14(%ebp)
 663:	eb 06                	jmp    66b <printint+0x31>
  } else {
    x = xx;
 665:	8b 45 0c             	mov    0xc(%ebp),%eax
 668:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 66b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 672:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 675:	8d 41 01             	lea    0x1(%ecx),%eax
 678:	89 45 f4             	mov    %eax,-0xc(%ebp)
 67b:	8b 5d 10             	mov    0x10(%ebp),%ebx
 67e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 681:	ba 00 00 00 00       	mov    $0x0,%edx
 686:	f7 f3                	div    %ebx
 688:	89 d0                	mov    %edx,%eax
 68a:	8a 80 88 0d 00 00    	mov    0xd88(%eax),%al
 690:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 694:	8b 5d 10             	mov    0x10(%ebp),%ebx
 697:	8b 45 ec             	mov    -0x14(%ebp),%eax
 69a:	ba 00 00 00 00       	mov    $0x0,%edx
 69f:	f7 f3                	div    %ebx
 6a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6a4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6a8:	75 c8                	jne    672 <printint+0x38>
  if(neg)
 6aa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6ae:	74 0e                	je     6be <printint+0x84>
    buf[i++] = '-';
 6b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6b3:	8d 50 01             	lea    0x1(%eax),%edx
 6b6:	89 55 f4             	mov    %edx,-0xc(%ebp)
 6b9:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 6be:	eb 1c                	jmp    6dc <printint+0xa2>
    putc(fd, buf[i]);
 6c0:	8d 55 dc             	lea    -0x24(%ebp),%edx
 6c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6c6:	01 d0                	add    %edx,%eax
 6c8:	8a 00                	mov    (%eax),%al
 6ca:	0f be c0             	movsbl %al,%eax
 6cd:	83 ec 08             	sub    $0x8,%esp
 6d0:	50                   	push   %eax
 6d1:	ff 75 08             	pushl  0x8(%ebp)
 6d4:	e8 3f ff ff ff       	call   618 <putc>
 6d9:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 6dc:	ff 4d f4             	decl   -0xc(%ebp)
 6df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6e3:	79 db                	jns    6c0 <printint+0x86>
    putc(fd, buf[i]);
}
 6e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6e8:	c9                   	leave  
 6e9:	c3                   	ret    

000006ea <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6ea:	55                   	push   %ebp
 6eb:	89 e5                	mov    %esp,%ebp
 6ed:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 6f0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 6f7:	8d 45 0c             	lea    0xc(%ebp),%eax
 6fa:	83 c0 04             	add    $0x4,%eax
 6fd:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 700:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 707:	e9 54 01 00 00       	jmp    860 <printf+0x176>
    c = fmt[i] & 0xff;
 70c:	8b 55 0c             	mov    0xc(%ebp),%edx
 70f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 712:	01 d0                	add    %edx,%eax
 714:	8a 00                	mov    (%eax),%al
 716:	0f be c0             	movsbl %al,%eax
 719:	25 ff 00 00 00       	and    $0xff,%eax
 71e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 721:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 725:	75 2c                	jne    753 <printf+0x69>
      if(c == '%'){
 727:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 72b:	75 0c                	jne    739 <printf+0x4f>
        state = '%';
 72d:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 734:	e9 24 01 00 00       	jmp    85d <printf+0x173>
      } else {
        putc(fd, c);
 739:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 73c:	0f be c0             	movsbl %al,%eax
 73f:	83 ec 08             	sub    $0x8,%esp
 742:	50                   	push   %eax
 743:	ff 75 08             	pushl  0x8(%ebp)
 746:	e8 cd fe ff ff       	call   618 <putc>
 74b:	83 c4 10             	add    $0x10,%esp
 74e:	e9 0a 01 00 00       	jmp    85d <printf+0x173>
      }
    } else if(state == '%'){
 753:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 757:	0f 85 00 01 00 00    	jne    85d <printf+0x173>
      if(c == 'd'){
 75d:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 761:	75 1e                	jne    781 <printf+0x97>
        printint(fd, *ap, 10, 1);
 763:	8b 45 e8             	mov    -0x18(%ebp),%eax
 766:	8b 00                	mov    (%eax),%eax
 768:	6a 01                	push   $0x1
 76a:	6a 0a                	push   $0xa
 76c:	50                   	push   %eax
 76d:	ff 75 08             	pushl  0x8(%ebp)
 770:	e8 c5 fe ff ff       	call   63a <printint>
 775:	83 c4 10             	add    $0x10,%esp
        ap++;
 778:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 77c:	e9 d5 00 00 00       	jmp    856 <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
 781:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 785:	74 06                	je     78d <printf+0xa3>
 787:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 78b:	75 1e                	jne    7ab <printf+0xc1>
        printint(fd, *ap, 16, 0);
 78d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 790:	8b 00                	mov    (%eax),%eax
 792:	6a 00                	push   $0x0
 794:	6a 10                	push   $0x10
 796:	50                   	push   %eax
 797:	ff 75 08             	pushl  0x8(%ebp)
 79a:	e8 9b fe ff ff       	call   63a <printint>
 79f:	83 c4 10             	add    $0x10,%esp
        ap++;
 7a2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7a6:	e9 ab 00 00 00       	jmp    856 <printf+0x16c>
      } else if(c == 's'){
 7ab:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 7af:	75 40                	jne    7f1 <printf+0x107>
        s = (char*)*ap;
 7b1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7b4:	8b 00                	mov    (%eax),%eax
 7b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 7b9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 7bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7c1:	75 07                	jne    7ca <printf+0xe0>
          s = "(null)";
 7c3:	c7 45 f4 e0 0a 00 00 	movl   $0xae0,-0xc(%ebp)
        while(*s != 0){
 7ca:	eb 1a                	jmp    7e6 <printf+0xfc>
          putc(fd, *s);
 7cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cf:	8a 00                	mov    (%eax),%al
 7d1:	0f be c0             	movsbl %al,%eax
 7d4:	83 ec 08             	sub    $0x8,%esp
 7d7:	50                   	push   %eax
 7d8:	ff 75 08             	pushl  0x8(%ebp)
 7db:	e8 38 fe ff ff       	call   618 <putc>
 7e0:	83 c4 10             	add    $0x10,%esp
          s++;
 7e3:	ff 45 f4             	incl   -0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e9:	8a 00                	mov    (%eax),%al
 7eb:	84 c0                	test   %al,%al
 7ed:	75 dd                	jne    7cc <printf+0xe2>
 7ef:	eb 65                	jmp    856 <printf+0x16c>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7f1:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 7f5:	75 1d                	jne    814 <printf+0x12a>
        putc(fd, *ap);
 7f7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7fa:	8b 00                	mov    (%eax),%eax
 7fc:	0f be c0             	movsbl %al,%eax
 7ff:	83 ec 08             	sub    $0x8,%esp
 802:	50                   	push   %eax
 803:	ff 75 08             	pushl  0x8(%ebp)
 806:	e8 0d fe ff ff       	call   618 <putc>
 80b:	83 c4 10             	add    $0x10,%esp
        ap++;
 80e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 812:	eb 42                	jmp    856 <printf+0x16c>
      } else if(c == '%'){
 814:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 818:	75 17                	jne    831 <printf+0x147>
        putc(fd, c);
 81a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 81d:	0f be c0             	movsbl %al,%eax
 820:	83 ec 08             	sub    $0x8,%esp
 823:	50                   	push   %eax
 824:	ff 75 08             	pushl  0x8(%ebp)
 827:	e8 ec fd ff ff       	call   618 <putc>
 82c:	83 c4 10             	add    $0x10,%esp
 82f:	eb 25                	jmp    856 <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 831:	83 ec 08             	sub    $0x8,%esp
 834:	6a 25                	push   $0x25
 836:	ff 75 08             	pushl  0x8(%ebp)
 839:	e8 da fd ff ff       	call   618 <putc>
 83e:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 841:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 844:	0f be c0             	movsbl %al,%eax
 847:	83 ec 08             	sub    $0x8,%esp
 84a:	50                   	push   %eax
 84b:	ff 75 08             	pushl  0x8(%ebp)
 84e:	e8 c5 fd ff ff       	call   618 <putc>
 853:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 856:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 85d:	ff 45 f0             	incl   -0x10(%ebp)
 860:	8b 55 0c             	mov    0xc(%ebp),%edx
 863:	8b 45 f0             	mov    -0x10(%ebp),%eax
 866:	01 d0                	add    %edx,%eax
 868:	8a 00                	mov    (%eax),%al
 86a:	84 c0                	test   %al,%al
 86c:	0f 85 9a fe ff ff    	jne    70c <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 872:	c9                   	leave  
 873:	c3                   	ret    

00000874 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 874:	55                   	push   %ebp
 875:	89 e5                	mov    %esp,%ebp
 877:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 87a:	8b 45 08             	mov    0x8(%ebp),%eax
 87d:	83 e8 08             	sub    $0x8,%eax
 880:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 883:	a1 b4 0d 00 00       	mov    0xdb4,%eax
 888:	89 45 fc             	mov    %eax,-0x4(%ebp)
 88b:	eb 24                	jmp    8b1 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 88d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 890:	8b 00                	mov    (%eax),%eax
 892:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 895:	77 12                	ja     8a9 <free+0x35>
 897:	8b 45 f8             	mov    -0x8(%ebp),%eax
 89a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 89d:	77 24                	ja     8c3 <free+0x4f>
 89f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8a2:	8b 00                	mov    (%eax),%eax
 8a4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8a7:	77 1a                	ja     8c3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ac:	8b 00                	mov    (%eax),%eax
 8ae:	89 45 fc             	mov    %eax,-0x4(%ebp)
 8b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8b4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8b7:	76 d4                	jbe    88d <free+0x19>
 8b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8bc:	8b 00                	mov    (%eax),%eax
 8be:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8c1:	76 ca                	jbe    88d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 8c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8c6:	8b 40 04             	mov    0x4(%eax),%eax
 8c9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8d3:	01 c2                	add    %eax,%edx
 8d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d8:	8b 00                	mov    (%eax),%eax
 8da:	39 c2                	cmp    %eax,%edx
 8dc:	75 24                	jne    902 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 8de:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8e1:	8b 50 04             	mov    0x4(%eax),%edx
 8e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e7:	8b 00                	mov    (%eax),%eax
 8e9:	8b 40 04             	mov    0x4(%eax),%eax
 8ec:	01 c2                	add    %eax,%edx
 8ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8f1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 8f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f7:	8b 00                	mov    (%eax),%eax
 8f9:	8b 10                	mov    (%eax),%edx
 8fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8fe:	89 10                	mov    %edx,(%eax)
 900:	eb 0a                	jmp    90c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 902:	8b 45 fc             	mov    -0x4(%ebp),%eax
 905:	8b 10                	mov    (%eax),%edx
 907:	8b 45 f8             	mov    -0x8(%ebp),%eax
 90a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 90c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 90f:	8b 40 04             	mov    0x4(%eax),%eax
 912:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 919:	8b 45 fc             	mov    -0x4(%ebp),%eax
 91c:	01 d0                	add    %edx,%eax
 91e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 921:	75 20                	jne    943 <free+0xcf>
    p->s.size += bp->s.size;
 923:	8b 45 fc             	mov    -0x4(%ebp),%eax
 926:	8b 50 04             	mov    0x4(%eax),%edx
 929:	8b 45 f8             	mov    -0x8(%ebp),%eax
 92c:	8b 40 04             	mov    0x4(%eax),%eax
 92f:	01 c2                	add    %eax,%edx
 931:	8b 45 fc             	mov    -0x4(%ebp),%eax
 934:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 937:	8b 45 f8             	mov    -0x8(%ebp),%eax
 93a:	8b 10                	mov    (%eax),%edx
 93c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 93f:	89 10                	mov    %edx,(%eax)
 941:	eb 08                	jmp    94b <free+0xd7>
  } else
    p->s.ptr = bp;
 943:	8b 45 fc             	mov    -0x4(%ebp),%eax
 946:	8b 55 f8             	mov    -0x8(%ebp),%edx
 949:	89 10                	mov    %edx,(%eax)
  freep = p;
 94b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 94e:	a3 b4 0d 00 00       	mov    %eax,0xdb4
}
 953:	c9                   	leave  
 954:	c3                   	ret    

00000955 <morecore>:

static Header*
morecore(uint nu)
{
 955:	55                   	push   %ebp
 956:	89 e5                	mov    %esp,%ebp
 958:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 95b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 962:	77 07                	ja     96b <morecore+0x16>
    nu = 4096;
 964:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 96b:	8b 45 08             	mov    0x8(%ebp),%eax
 96e:	c1 e0 03             	shl    $0x3,%eax
 971:	83 ec 0c             	sub    $0xc,%esp
 974:	50                   	push   %eax
 975:	e8 86 fc ff ff       	call   600 <sbrk>
 97a:	83 c4 10             	add    $0x10,%esp
 97d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 980:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 984:	75 07                	jne    98d <morecore+0x38>
    return 0;
 986:	b8 00 00 00 00       	mov    $0x0,%eax
 98b:	eb 26                	jmp    9b3 <morecore+0x5e>
  hp = (Header*)p;
 98d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 990:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 993:	8b 45 f0             	mov    -0x10(%ebp),%eax
 996:	8b 55 08             	mov    0x8(%ebp),%edx
 999:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 99c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 99f:	83 c0 08             	add    $0x8,%eax
 9a2:	83 ec 0c             	sub    $0xc,%esp
 9a5:	50                   	push   %eax
 9a6:	e8 c9 fe ff ff       	call   874 <free>
 9ab:	83 c4 10             	add    $0x10,%esp
  return freep;
 9ae:	a1 b4 0d 00 00       	mov    0xdb4,%eax
}
 9b3:	c9                   	leave  
 9b4:	c3                   	ret    

000009b5 <malloc>:

void*
malloc(uint nbytes)
{
 9b5:	55                   	push   %ebp
 9b6:	89 e5                	mov    %esp,%ebp
 9b8:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9bb:	8b 45 08             	mov    0x8(%ebp),%eax
 9be:	83 c0 07             	add    $0x7,%eax
 9c1:	c1 e8 03             	shr    $0x3,%eax
 9c4:	40                   	inc    %eax
 9c5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 9c8:	a1 b4 0d 00 00       	mov    0xdb4,%eax
 9cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9d0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 9d4:	75 23                	jne    9f9 <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
 9d6:	c7 45 f0 ac 0d 00 00 	movl   $0xdac,-0x10(%ebp)
 9dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9e0:	a3 b4 0d 00 00       	mov    %eax,0xdb4
 9e5:	a1 b4 0d 00 00       	mov    0xdb4,%eax
 9ea:	a3 ac 0d 00 00       	mov    %eax,0xdac
    base.s.size = 0;
 9ef:	c7 05 b0 0d 00 00 00 	movl   $0x0,0xdb0
 9f6:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9fc:	8b 00                	mov    (%eax),%eax
 9fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a01:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a04:	8b 40 04             	mov    0x4(%eax),%eax
 a07:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a0a:	72 4d                	jb     a59 <malloc+0xa4>
      if(p->s.size == nunits)
 a0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a0f:	8b 40 04             	mov    0x4(%eax),%eax
 a12:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a15:	75 0c                	jne    a23 <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
 a17:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a1a:	8b 10                	mov    (%eax),%edx
 a1c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a1f:	89 10                	mov    %edx,(%eax)
 a21:	eb 26                	jmp    a49 <malloc+0x94>
      else {
        p->s.size -= nunits;
 a23:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a26:	8b 40 04             	mov    0x4(%eax),%eax
 a29:	2b 45 ec             	sub    -0x14(%ebp),%eax
 a2c:	89 c2                	mov    %eax,%edx
 a2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a31:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 a34:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a37:	8b 40 04             	mov    0x4(%eax),%eax
 a3a:	c1 e0 03             	shl    $0x3,%eax
 a3d:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 a40:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a43:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a46:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 a49:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a4c:	a3 b4 0d 00 00       	mov    %eax,0xdb4
      return (void*)(p + 1);
 a51:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a54:	83 c0 08             	add    $0x8,%eax
 a57:	eb 3b                	jmp    a94 <malloc+0xdf>
    }
    if(p == freep)
 a59:	a1 b4 0d 00 00       	mov    0xdb4,%eax
 a5e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a61:	75 1e                	jne    a81 <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
 a63:	83 ec 0c             	sub    $0xc,%esp
 a66:	ff 75 ec             	pushl  -0x14(%ebp)
 a69:	e8 e7 fe ff ff       	call   955 <morecore>
 a6e:	83 c4 10             	add    $0x10,%esp
 a71:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a74:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a78:	75 07                	jne    a81 <malloc+0xcc>
        return 0;
 a7a:	b8 00 00 00 00       	mov    $0x0,%eax
 a7f:	eb 13                	jmp    a94 <malloc+0xdf>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a81:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a84:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a87:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a8a:	8b 00                	mov    (%eax),%eax
 a8c:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 a8f:	e9 6d ff ff ff       	jmp    a01 <malloc+0x4c>
}
 a94:	c9                   	leave  
 a95:	c3                   	ret    
