
_tail:     file format elf32-i386


Disassembly of section .text:

00000000 <countlines>:

char buf[512];

int
countlines(int fd, char *name)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  int i, n;
  int l, c;

  l = c = 0;
   6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
   d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  13:	eb 28                	jmp    3d <countlines+0x3d>
    for(i=0; i<n; i++){
  15:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1c:	eb 17                	jmp    35 <countlines+0x35>
      c++;
  1e:	ff 45 ec             	incl   -0x14(%ebp)
      if(buf[i] == '\n'){
  21:	8b 45 f4             	mov    -0xc(%ebp),%eax
  24:	05 a0 0d 00 00       	add    $0xda0,%eax
  29:	8a 00                	mov    (%eax),%al
  2b:	3c 0a                	cmp    $0xa,%al
  2d:	75 03                	jne    32 <countlines+0x32>
        l++;
  2f:	ff 45 f0             	incl   -0x10(%ebp)
  int i, n;
  int l, c;

  l = c = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  32:	ff 45 f4             	incl   -0xc(%ebp)
  35:	8b 45 f4             	mov    -0xc(%ebp),%eax
  38:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  3b:	7c e1                	jl     1e <countlines+0x1e>
{
  int i, n;
  int l, c;

  l = c = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
  3d:	83 ec 04             	sub    $0x4,%esp
  40:	68 00 02 00 00       	push   $0x200
  45:	68 a0 0d 00 00       	push   $0xda0
  4a:	ff 75 08             	pushl  0x8(%ebp)
  4d:	e8 1e 05 00 00       	call   570 <read>
  52:	83 c4 10             	add    $0x10,%esp
  55:	89 45 e8             	mov    %eax,-0x18(%ebp)
  58:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  5c:	7f b7                	jg     15 <countlines+0x15>
      if(buf[i] == '\n'){
        l++;
      }
    }
  }
  if(n < 0){
  5e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  62:	79 17                	jns    7b <countlines+0x7b>
    printf(1, "tail: read error\n");
  64:	83 ec 08             	sub    $0x8,%esp
  67:	68 76 0a 00 00       	push   $0xa76
  6c:	6a 01                	push   $0x1
  6e:	e8 57 06 00 00       	call   6ca <printf>
  73:	83 c4 10             	add    $0x10,%esp
    exit();
  76:	e8 dd 04 00 00       	call   558 <exit>
  }
  return l;
  7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  7e:	c9                   	leave  
  7f:	c3                   	ret    

00000080 <pc>:

int
pc(int fd, char *name, int numberOfLines, int num)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	83 ec 18             	sub    $0x18,%esp
  int i, n;
  int l;


  l = 0;
  86:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  8d:	eb 7d                	jmp    10c <pc+0x8c>
    for(i=0; i<n; i++){
  8f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  96:	eb 6c                	jmp    104 <pc+0x84>
      if(buf[i] == '\n'){
  98:	8b 45 f4             	mov    -0xc(%ebp),%eax
  9b:	05 a0 0d 00 00       	add    $0xda0,%eax
  a0:	8a 00                	mov    (%eax),%al
  a2:	3c 0a                	cmp    $0xa,%al
  a4:	75 30                	jne    d6 <pc+0x56>
        if(l > (numberOfLines - num)){
  a6:	8b 45 10             	mov    0x10(%ebp),%eax
  a9:	2b 45 14             	sub    0x14(%ebp),%eax
  ac:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  af:	7d 20                	jge    d1 <pc+0x51>
          printf(1, "\n", buf[i]);
  b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  b4:	05 a0 0d 00 00       	add    $0xda0,%eax
  b9:	8a 00                	mov    (%eax),%al
  bb:	0f be c0             	movsbl %al,%eax
  be:	83 ec 04             	sub    $0x4,%esp
  c1:	50                   	push   %eax
  c2:	68 88 0a 00 00       	push   $0xa88
  c7:	6a 01                	push   $0x1
  c9:	e8 fc 05 00 00       	call   6ca <printf>
  ce:	83 c4 10             	add    $0x10,%esp
        }
      l++;
  d1:	ff 45 f0             	incl   -0x10(%ebp)
  d4:	eb 2b                	jmp    101 <pc+0x81>
      }
      else{
        if(l > (numberOfLines - num)){
  d6:	8b 45 10             	mov    0x10(%ebp),%eax
  d9:	2b 45 14             	sub    0x14(%ebp),%eax
  dc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  df:	7d 20                	jge    101 <pc+0x81>
          printf(1, "%c", buf[i]);
  e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  e4:	05 a0 0d 00 00       	add    $0xda0,%eax
  e9:	8a 00                	mov    (%eax),%al
  eb:	0f be c0             	movsbl %al,%eax
  ee:	83 ec 04             	sub    $0x4,%esp
  f1:	50                   	push   %eax
  f2:	68 8a 0a 00 00       	push   $0xa8a
  f7:	6a 01                	push   $0x1
  f9:	e8 cc 05 00 00       	call   6ca <printf>
  fe:	83 c4 10             	add    $0x10,%esp
  int l;


  l = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
 101:	ff 45 f4             	incl   -0xc(%ebp)
 104:	8b 45 f4             	mov    -0xc(%ebp),%eax
 107:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 10a:	7c 8c                	jl     98 <pc+0x18>
  int i, n;
  int l;


  l = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
 10c:	83 ec 04             	sub    $0x4,%esp
 10f:	68 00 02 00 00       	push   $0x200
 114:	68 a0 0d 00 00       	push   $0xda0
 119:	ff 75 08             	pushl  0x8(%ebp)
 11c:	e8 4f 04 00 00       	call   570 <read>
 121:	83 c4 10             	add    $0x10,%esp
 124:	89 45 ec             	mov    %eax,-0x14(%ebp)
 127:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 12b:	0f 8f 5e ff ff ff    	jg     8f <pc+0xf>
        }
      }
      
    }
  }
  if(n < 0){
 131:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 135:	79 17                	jns    14e <pc+0xce>
    printf(1, "wc: read error\n");
 137:	83 ec 08             	sub    $0x8,%esp
 13a:	68 8d 0a 00 00       	push   $0xa8d
 13f:	6a 01                	push   $0x1
 141:	e8 84 05 00 00       	call   6ca <printf>
 146:	83 c4 10             	add    $0x10,%esp
    exit();
 149:	e8 0a 04 00 00       	call   558 <exit>
  }
  return l;
 14e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 151:	c9                   	leave  
 152:	c3                   	ret    

00000153 <main>:

int
main(int argc, char *argv[])
{
 153:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 157:	83 e4 f0             	and    $0xfffffff0,%esp
 15a:	ff 71 fc             	pushl  -0x4(%ecx)
 15d:	55                   	push   %ebp
 15e:	89 e5                	mov    %esp,%ebp
 160:	53                   	push   %ebx
 161:	51                   	push   %ecx
 162:	83 ec 20             	sub    $0x20,%esp
 165:	89 cb                	mov    %ecx,%ebx
  int fd1, fd;
  char num = atoi("10");
 167:	83 ec 0c             	sub    $0xc,%esp
 16a:	68 9d 0a 00 00       	push   $0xa9d
 16f:	e8 56 03 00 00       	call   4ca <atoi>
 174:	83 c4 10             	add    $0x10,%esp
 177:	88 45 f7             	mov    %al,-0x9(%ebp)
  int filePos = 1;
 17a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)

  if(argc <= 1){
 181:	83 3b 01             	cmpl   $0x1,(%ebx)
 184:	7f 17                	jg     19d <main+0x4a>
    countlines(0, "");
 186:	83 ec 08             	sub    $0x8,%esp
 189:	68 a0 0a 00 00       	push   $0xaa0
 18e:	6a 00                	push   $0x0
 190:	e8 6b fe ff ff       	call   0 <countlines>
 195:	83 c4 10             	add    $0x10,%esp
    exit();
 198:	e8 bb 03 00 00       	call   558 <exit>
  }
  
  if(argc == 3){
 19d:	83 3b 03             	cmpl   $0x3,(%ebx)
 1a0:	75 5a                	jne    1fc <main+0xa9>
    if(argv[2][0] == '-'){
 1a2:	8b 43 04             	mov    0x4(%ebx),%eax
 1a5:	83 c0 08             	add    $0x8,%eax
 1a8:	8b 00                	mov    (%eax),%eax
 1aa:	8a 00                	mov    (%eax),%al
 1ac:	3c 2d                	cmp    $0x2d,%al
 1ae:	75 1f                	jne    1cf <main+0x7c>
      num = atoi(&(argv[2][1]));
 1b0:	8b 43 04             	mov    0x4(%ebx),%eax
 1b3:	83 c0 08             	add    $0x8,%eax
 1b6:	8b 00                	mov    (%eax),%eax
 1b8:	40                   	inc    %eax
 1b9:	83 ec 0c             	sub    $0xc,%esp
 1bc:	50                   	push   %eax
 1bd:	e8 08 03 00 00       	call   4ca <atoi>
 1c2:	83 c4 10             	add    $0x10,%esp
 1c5:	88 45 f7             	mov    %al,-0x9(%ebp)
      filePos = 1;
 1c8:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    }
    if(argv[1][0] == '-'){
 1cf:	8b 43 04             	mov    0x4(%ebx),%eax
 1d2:	83 c0 04             	add    $0x4,%eax
 1d5:	8b 00                	mov    (%eax),%eax
 1d7:	8a 00                	mov    (%eax),%al
 1d9:	3c 2d                	cmp    $0x2d,%al
 1db:	75 1f                	jne    1fc <main+0xa9>
      num = atoi(&(argv[1][1]));
 1dd:	8b 43 04             	mov    0x4(%ebx),%eax
 1e0:	83 c0 04             	add    $0x4,%eax
 1e3:	8b 00                	mov    (%eax),%eax
 1e5:	40                   	inc    %eax
 1e6:	83 ec 0c             	sub    $0xc,%esp
 1e9:	50                   	push   %eax
 1ea:	e8 db 02 00 00       	call   4ca <atoi>
 1ef:	83 c4 10             	add    $0x10,%esp
 1f2:	88 45 f7             	mov    %al,-0x9(%ebp)
      filePos = 2;
 1f5:	c7 45 f0 02 00 00 00 	movl   $0x2,-0x10(%ebp)
    }
  }

  if((fd = open(argv[filePos], 0)) < 0){
 1fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 1ff:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 206:	8b 43 04             	mov    0x4(%ebx),%eax
 209:	01 d0                	add    %edx,%eax
 20b:	8b 00                	mov    (%eax),%eax
 20d:	83 ec 08             	sub    $0x8,%esp
 210:	6a 00                	push   $0x0
 212:	50                   	push   %eax
 213:	e8 80 03 00 00       	call   598 <open>
 218:	83 c4 10             	add    $0x10,%esp
 21b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 21e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 222:	79 29                	jns    24d <main+0xfa>
    printf(1, "tail: cannot open %s\n", argv[filePos]);
 224:	8b 45 f0             	mov    -0x10(%ebp),%eax
 227:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 22e:	8b 43 04             	mov    0x4(%ebx),%eax
 231:	01 d0                	add    %edx,%eax
 233:	8b 00                	mov    (%eax),%eax
 235:	83 ec 04             	sub    $0x4,%esp
 238:	50                   	push   %eax
 239:	68 a1 0a 00 00       	push   $0xaa1
 23e:	6a 01                	push   $0x1
 240:	e8 85 04 00 00       	call   6ca <printf>
 245:	83 c4 10             	add    $0x10,%esp
    exit();
 248:	e8 0b 03 00 00       	call   558 <exit>
  }
  if((fd1 = open(argv[filePos], 0)) < 0){
 24d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 250:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 257:	8b 43 04             	mov    0x4(%ebx),%eax
 25a:	01 d0                	add    %edx,%eax
 25c:	8b 00                	mov    (%eax),%eax
 25e:	83 ec 08             	sub    $0x8,%esp
 261:	6a 00                	push   $0x0
 263:	50                   	push   %eax
 264:	e8 2f 03 00 00       	call   598 <open>
 269:	83 c4 10             	add    $0x10,%esp
 26c:	89 45 e8             	mov    %eax,-0x18(%ebp)
 26f:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
 273:	79 29                	jns    29e <main+0x14b>
    printf(1, "tail: cannot open %s\n", argv[filePos]);
 275:	8b 45 f0             	mov    -0x10(%ebp),%eax
 278:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 27f:	8b 43 04             	mov    0x4(%ebx),%eax
 282:	01 d0                	add    %edx,%eax
 284:	8b 00                	mov    (%eax),%eax
 286:	83 ec 04             	sub    $0x4,%esp
 289:	50                   	push   %eax
 28a:	68 a1 0a 00 00       	push   $0xaa1
 28f:	6a 01                	push   $0x1
 291:	e8 34 04 00 00       	call   6ca <printf>
 296:	83 c4 10             	add    $0x10,%esp
    exit();
 299:	e8 ba 02 00 00       	call   558 <exit>
  }
  int numOfL = countlines(fd, argv[filePos]);
 29e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 2a1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 2a8:	8b 43 04             	mov    0x4(%ebx),%eax
 2ab:	01 d0                	add    %edx,%eax
 2ad:	8b 00                	mov    (%eax),%eax
 2af:	83 ec 08             	sub    $0x8,%esp
 2b2:	50                   	push   %eax
 2b3:	ff 75 ec             	pushl  -0x14(%ebp)
 2b6:	e8 45 fd ff ff       	call   0 <countlines>
 2bb:	83 c4 10             	add    $0x10,%esp
 2be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  printf(1, "%d\n",pc(fd1, argv[filePos], numOfL, num));
 2c1:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
 2c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 2c8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
 2cf:	8b 43 04             	mov    0x4(%ebx),%eax
 2d2:	01 c8                	add    %ecx,%eax
 2d4:	8b 00                	mov    (%eax),%eax
 2d6:	52                   	push   %edx
 2d7:	ff 75 e4             	pushl  -0x1c(%ebp)
 2da:	50                   	push   %eax
 2db:	ff 75 e8             	pushl  -0x18(%ebp)
 2de:	e8 9d fd ff ff       	call   80 <pc>
 2e3:	83 c4 10             	add    $0x10,%esp
 2e6:	83 ec 04             	sub    $0x4,%esp
 2e9:	50                   	push   %eax
 2ea:	68 b7 0a 00 00       	push   $0xab7
 2ef:	6a 01                	push   $0x1
 2f1:	e8 d4 03 00 00       	call   6ca <printf>
 2f6:	83 c4 10             	add    $0x10,%esp
  close(fd1);
 2f9:	83 ec 0c             	sub    $0xc,%esp
 2fc:	ff 75 e8             	pushl  -0x18(%ebp)
 2ff:	e8 7c 02 00 00       	call   580 <close>
 304:	83 c4 10             	add    $0x10,%esp
  close(fd);
 307:	83 ec 0c             	sub    $0xc,%esp
 30a:	ff 75 ec             	pushl  -0x14(%ebp)
 30d:	e8 6e 02 00 00       	call   580 <close>
 312:	83 c4 10             	add    $0x10,%esp
      
     
  
  exit();
 315:	e8 3e 02 00 00       	call   558 <exit>

0000031a <stosb>:
 31a:	55                   	push   %ebp
 31b:	89 e5                	mov    %esp,%ebp
 31d:	57                   	push   %edi
 31e:	53                   	push   %ebx
 31f:	8b 4d 08             	mov    0x8(%ebp),%ecx
 322:	8b 55 10             	mov    0x10(%ebp),%edx
 325:	8b 45 0c             	mov    0xc(%ebp),%eax
 328:	89 cb                	mov    %ecx,%ebx
 32a:	89 df                	mov    %ebx,%edi
 32c:	89 d1                	mov    %edx,%ecx
 32e:	fc                   	cld    
 32f:	f3 aa                	rep stos %al,%es:(%edi)
 331:	89 ca                	mov    %ecx,%edx
 333:	89 fb                	mov    %edi,%ebx
 335:	89 5d 08             	mov    %ebx,0x8(%ebp)
 338:	89 55 10             	mov    %edx,0x10(%ebp)
 33b:	5b                   	pop    %ebx
 33c:	5f                   	pop    %edi
 33d:	5d                   	pop    %ebp
 33e:	c3                   	ret    

0000033f <strcpy>:
 33f:	55                   	push   %ebp
 340:	89 e5                	mov    %esp,%ebp
 342:	83 ec 10             	sub    $0x10,%esp
 345:	8b 45 08             	mov    0x8(%ebp),%eax
 348:	89 45 fc             	mov    %eax,-0x4(%ebp)
 34b:	90                   	nop
 34c:	8b 45 08             	mov    0x8(%ebp),%eax
 34f:	8d 50 01             	lea    0x1(%eax),%edx
 352:	89 55 08             	mov    %edx,0x8(%ebp)
 355:	8b 55 0c             	mov    0xc(%ebp),%edx
 358:	8d 4a 01             	lea    0x1(%edx),%ecx
 35b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 35e:	8a 12                	mov    (%edx),%dl
 360:	88 10                	mov    %dl,(%eax)
 362:	8a 00                	mov    (%eax),%al
 364:	84 c0                	test   %al,%al
 366:	75 e4                	jne    34c <strcpy+0xd>
 368:	8b 45 fc             	mov    -0x4(%ebp),%eax
 36b:	c9                   	leave  
 36c:	c3                   	ret    

0000036d <strcmp>:
 36d:	55                   	push   %ebp
 36e:	89 e5                	mov    %esp,%ebp
 370:	eb 06                	jmp    378 <strcmp+0xb>
 372:	ff 45 08             	incl   0x8(%ebp)
 375:	ff 45 0c             	incl   0xc(%ebp)
 378:	8b 45 08             	mov    0x8(%ebp),%eax
 37b:	8a 00                	mov    (%eax),%al
 37d:	84 c0                	test   %al,%al
 37f:	74 0e                	je     38f <strcmp+0x22>
 381:	8b 45 08             	mov    0x8(%ebp),%eax
 384:	8a 10                	mov    (%eax),%dl
 386:	8b 45 0c             	mov    0xc(%ebp),%eax
 389:	8a 00                	mov    (%eax),%al
 38b:	38 c2                	cmp    %al,%dl
 38d:	74 e3                	je     372 <strcmp+0x5>
 38f:	8b 45 08             	mov    0x8(%ebp),%eax
 392:	8a 00                	mov    (%eax),%al
 394:	0f b6 d0             	movzbl %al,%edx
 397:	8b 45 0c             	mov    0xc(%ebp),%eax
 39a:	8a 00                	mov    (%eax),%al
 39c:	0f b6 c0             	movzbl %al,%eax
 39f:	29 c2                	sub    %eax,%edx
 3a1:	89 d0                	mov    %edx,%eax
 3a3:	5d                   	pop    %ebp
 3a4:	c3                   	ret    

000003a5 <strlen>:
 3a5:	55                   	push   %ebp
 3a6:	89 e5                	mov    %esp,%ebp
 3a8:	83 ec 10             	sub    $0x10,%esp
 3ab:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3b2:	eb 03                	jmp    3b7 <strlen+0x12>
 3b4:	ff 45 fc             	incl   -0x4(%ebp)
 3b7:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3ba:	8b 45 08             	mov    0x8(%ebp),%eax
 3bd:	01 d0                	add    %edx,%eax
 3bf:	8a 00                	mov    (%eax),%al
 3c1:	84 c0                	test   %al,%al
 3c3:	75 ef                	jne    3b4 <strlen+0xf>
 3c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3c8:	c9                   	leave  
 3c9:	c3                   	ret    

000003ca <memset>:
 3ca:	55                   	push   %ebp
 3cb:	89 e5                	mov    %esp,%ebp
 3cd:	8b 45 10             	mov    0x10(%ebp),%eax
 3d0:	50                   	push   %eax
 3d1:	ff 75 0c             	pushl  0xc(%ebp)
 3d4:	ff 75 08             	pushl  0x8(%ebp)
 3d7:	e8 3e ff ff ff       	call   31a <stosb>
 3dc:	83 c4 0c             	add    $0xc,%esp
 3df:	8b 45 08             	mov    0x8(%ebp),%eax
 3e2:	c9                   	leave  
 3e3:	c3                   	ret    

000003e4 <strchr>:
 3e4:	55                   	push   %ebp
 3e5:	89 e5                	mov    %esp,%ebp
 3e7:	83 ec 04             	sub    $0x4,%esp
 3ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ed:	88 45 fc             	mov    %al,-0x4(%ebp)
 3f0:	eb 12                	jmp    404 <strchr+0x20>
 3f2:	8b 45 08             	mov    0x8(%ebp),%eax
 3f5:	8a 00                	mov    (%eax),%al
 3f7:	3a 45 fc             	cmp    -0x4(%ebp),%al
 3fa:	75 05                	jne    401 <strchr+0x1d>
 3fc:	8b 45 08             	mov    0x8(%ebp),%eax
 3ff:	eb 11                	jmp    412 <strchr+0x2e>
 401:	ff 45 08             	incl   0x8(%ebp)
 404:	8b 45 08             	mov    0x8(%ebp),%eax
 407:	8a 00                	mov    (%eax),%al
 409:	84 c0                	test   %al,%al
 40b:	75 e5                	jne    3f2 <strchr+0xe>
 40d:	b8 00 00 00 00       	mov    $0x0,%eax
 412:	c9                   	leave  
 413:	c3                   	ret    

00000414 <gets>:
 414:	55                   	push   %ebp
 415:	89 e5                	mov    %esp,%ebp
 417:	83 ec 18             	sub    $0x18,%esp
 41a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 421:	eb 41                	jmp    464 <gets+0x50>
 423:	83 ec 04             	sub    $0x4,%esp
 426:	6a 01                	push   $0x1
 428:	8d 45 ef             	lea    -0x11(%ebp),%eax
 42b:	50                   	push   %eax
 42c:	6a 00                	push   $0x0
 42e:	e8 3d 01 00 00       	call   570 <read>
 433:	83 c4 10             	add    $0x10,%esp
 436:	89 45 f0             	mov    %eax,-0x10(%ebp)
 439:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 43d:	7f 02                	jg     441 <gets+0x2d>
 43f:	eb 2c                	jmp    46d <gets+0x59>
 441:	8b 45 f4             	mov    -0xc(%ebp),%eax
 444:	8d 50 01             	lea    0x1(%eax),%edx
 447:	89 55 f4             	mov    %edx,-0xc(%ebp)
 44a:	89 c2                	mov    %eax,%edx
 44c:	8b 45 08             	mov    0x8(%ebp),%eax
 44f:	01 c2                	add    %eax,%edx
 451:	8a 45 ef             	mov    -0x11(%ebp),%al
 454:	88 02                	mov    %al,(%edx)
 456:	8a 45 ef             	mov    -0x11(%ebp),%al
 459:	3c 0a                	cmp    $0xa,%al
 45b:	74 10                	je     46d <gets+0x59>
 45d:	8a 45 ef             	mov    -0x11(%ebp),%al
 460:	3c 0d                	cmp    $0xd,%al
 462:	74 09                	je     46d <gets+0x59>
 464:	8b 45 f4             	mov    -0xc(%ebp),%eax
 467:	40                   	inc    %eax
 468:	3b 45 0c             	cmp    0xc(%ebp),%eax
 46b:	7c b6                	jl     423 <gets+0xf>
 46d:	8b 55 f4             	mov    -0xc(%ebp),%edx
 470:	8b 45 08             	mov    0x8(%ebp),%eax
 473:	01 d0                	add    %edx,%eax
 475:	c6 00 00             	movb   $0x0,(%eax)
 478:	8b 45 08             	mov    0x8(%ebp),%eax
 47b:	c9                   	leave  
 47c:	c3                   	ret    

0000047d <stat>:
 47d:	55                   	push   %ebp
 47e:	89 e5                	mov    %esp,%ebp
 480:	83 ec 18             	sub    $0x18,%esp
 483:	83 ec 08             	sub    $0x8,%esp
 486:	6a 00                	push   $0x0
 488:	ff 75 08             	pushl  0x8(%ebp)
 48b:	e8 08 01 00 00       	call   598 <open>
 490:	83 c4 10             	add    $0x10,%esp
 493:	89 45 f4             	mov    %eax,-0xc(%ebp)
 496:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 49a:	79 07                	jns    4a3 <stat+0x26>
 49c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4a1:	eb 25                	jmp    4c8 <stat+0x4b>
 4a3:	83 ec 08             	sub    $0x8,%esp
 4a6:	ff 75 0c             	pushl  0xc(%ebp)
 4a9:	ff 75 f4             	pushl  -0xc(%ebp)
 4ac:	e8 ff 00 00 00       	call   5b0 <fstat>
 4b1:	83 c4 10             	add    $0x10,%esp
 4b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
 4b7:	83 ec 0c             	sub    $0xc,%esp
 4ba:	ff 75 f4             	pushl  -0xc(%ebp)
 4bd:	e8 be 00 00 00       	call   580 <close>
 4c2:	83 c4 10             	add    $0x10,%esp
 4c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4c8:	c9                   	leave  
 4c9:	c3                   	ret    

000004ca <atoi>:
 4ca:	55                   	push   %ebp
 4cb:	89 e5                	mov    %esp,%ebp
 4cd:	83 ec 10             	sub    $0x10,%esp
 4d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 4d7:	eb 24                	jmp    4fd <atoi+0x33>
 4d9:	8b 55 fc             	mov    -0x4(%ebp),%edx
 4dc:	89 d0                	mov    %edx,%eax
 4de:	c1 e0 02             	shl    $0x2,%eax
 4e1:	01 d0                	add    %edx,%eax
 4e3:	01 c0                	add    %eax,%eax
 4e5:	89 c1                	mov    %eax,%ecx
 4e7:	8b 45 08             	mov    0x8(%ebp),%eax
 4ea:	8d 50 01             	lea    0x1(%eax),%edx
 4ed:	89 55 08             	mov    %edx,0x8(%ebp)
 4f0:	8a 00                	mov    (%eax),%al
 4f2:	0f be c0             	movsbl %al,%eax
 4f5:	01 c8                	add    %ecx,%eax
 4f7:	83 e8 30             	sub    $0x30,%eax
 4fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
 4fd:	8b 45 08             	mov    0x8(%ebp),%eax
 500:	8a 00                	mov    (%eax),%al
 502:	3c 2f                	cmp    $0x2f,%al
 504:	7e 09                	jle    50f <atoi+0x45>
 506:	8b 45 08             	mov    0x8(%ebp),%eax
 509:	8a 00                	mov    (%eax),%al
 50b:	3c 39                	cmp    $0x39,%al
 50d:	7e ca                	jle    4d9 <atoi+0xf>
 50f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 512:	c9                   	leave  
 513:	c3                   	ret    

00000514 <memmove>:
 514:	55                   	push   %ebp
 515:	89 e5                	mov    %esp,%ebp
 517:	83 ec 10             	sub    $0x10,%esp
 51a:	8b 45 08             	mov    0x8(%ebp),%eax
 51d:	89 45 fc             	mov    %eax,-0x4(%ebp)
 520:	8b 45 0c             	mov    0xc(%ebp),%eax
 523:	89 45 f8             	mov    %eax,-0x8(%ebp)
 526:	eb 16                	jmp    53e <memmove+0x2a>
 528:	8b 45 fc             	mov    -0x4(%ebp),%eax
 52b:	8d 50 01             	lea    0x1(%eax),%edx
 52e:	89 55 fc             	mov    %edx,-0x4(%ebp)
 531:	8b 55 f8             	mov    -0x8(%ebp),%edx
 534:	8d 4a 01             	lea    0x1(%edx),%ecx
 537:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 53a:	8a 12                	mov    (%edx),%dl
 53c:	88 10                	mov    %dl,(%eax)
 53e:	8b 45 10             	mov    0x10(%ebp),%eax
 541:	8d 50 ff             	lea    -0x1(%eax),%edx
 544:	89 55 10             	mov    %edx,0x10(%ebp)
 547:	85 c0                	test   %eax,%eax
 549:	7f dd                	jg     528 <memmove+0x14>
 54b:	8b 45 08             	mov    0x8(%ebp),%eax
 54e:	c9                   	leave  
 54f:	c3                   	ret    

00000550 <fork>:
 550:	b8 01 00 00 00       	mov    $0x1,%eax
 555:	cd 40                	int    $0x40
 557:	c3                   	ret    

00000558 <exit>:
 558:	b8 02 00 00 00       	mov    $0x2,%eax
 55d:	cd 40                	int    $0x40
 55f:	c3                   	ret    

00000560 <wait>:
 560:	b8 03 00 00 00       	mov    $0x3,%eax
 565:	cd 40                	int    $0x40
 567:	c3                   	ret    

00000568 <pipe>:
 568:	b8 04 00 00 00       	mov    $0x4,%eax
 56d:	cd 40                	int    $0x40
 56f:	c3                   	ret    

00000570 <read>:
 570:	b8 05 00 00 00       	mov    $0x5,%eax
 575:	cd 40                	int    $0x40
 577:	c3                   	ret    

00000578 <write>:
 578:	b8 10 00 00 00       	mov    $0x10,%eax
 57d:	cd 40                	int    $0x40
 57f:	c3                   	ret    

00000580 <close>:
 580:	b8 15 00 00 00       	mov    $0x15,%eax
 585:	cd 40                	int    $0x40
 587:	c3                   	ret    

00000588 <kill>:
 588:	b8 06 00 00 00       	mov    $0x6,%eax
 58d:	cd 40                	int    $0x40
 58f:	c3                   	ret    

00000590 <exec>:
 590:	b8 07 00 00 00       	mov    $0x7,%eax
 595:	cd 40                	int    $0x40
 597:	c3                   	ret    

00000598 <open>:
 598:	b8 0f 00 00 00       	mov    $0xf,%eax
 59d:	cd 40                	int    $0x40
 59f:	c3                   	ret    

000005a0 <mknod>:
 5a0:	b8 11 00 00 00       	mov    $0x11,%eax
 5a5:	cd 40                	int    $0x40
 5a7:	c3                   	ret    

000005a8 <unlink>:
 5a8:	b8 12 00 00 00       	mov    $0x12,%eax
 5ad:	cd 40                	int    $0x40
 5af:	c3                   	ret    

000005b0 <fstat>:
 5b0:	b8 08 00 00 00       	mov    $0x8,%eax
 5b5:	cd 40                	int    $0x40
 5b7:	c3                   	ret    

000005b8 <link>:
 5b8:	b8 13 00 00 00       	mov    $0x13,%eax
 5bd:	cd 40                	int    $0x40
 5bf:	c3                   	ret    

000005c0 <mkdir>:
 5c0:	b8 14 00 00 00       	mov    $0x14,%eax
 5c5:	cd 40                	int    $0x40
 5c7:	c3                   	ret    

000005c8 <chdir>:
 5c8:	b8 09 00 00 00       	mov    $0x9,%eax
 5cd:	cd 40                	int    $0x40
 5cf:	c3                   	ret    

000005d0 <dup>:
 5d0:	b8 0a 00 00 00       	mov    $0xa,%eax
 5d5:	cd 40                	int    $0x40
 5d7:	c3                   	ret    

000005d8 <getpid>:
 5d8:	b8 0b 00 00 00       	mov    $0xb,%eax
 5dd:	cd 40                	int    $0x40
 5df:	c3                   	ret    

000005e0 <sbrk>:
 5e0:	b8 0c 00 00 00       	mov    $0xc,%eax
 5e5:	cd 40                	int    $0x40
 5e7:	c3                   	ret    

000005e8 <sleep>:
 5e8:	b8 0d 00 00 00       	mov    $0xd,%eax
 5ed:	cd 40                	int    $0x40
 5ef:	c3                   	ret    

000005f0 <uptime>:
 5f0:	b8 0e 00 00 00       	mov    $0xe,%eax
 5f5:	cd 40                	int    $0x40
 5f7:	c3                   	ret    

000005f8 <putc>:
 5f8:	55                   	push   %ebp
 5f9:	89 e5                	mov    %esp,%ebp
 5fb:	83 ec 18             	sub    $0x18,%esp
 5fe:	8b 45 0c             	mov    0xc(%ebp),%eax
 601:	88 45 f4             	mov    %al,-0xc(%ebp)
 604:	83 ec 04             	sub    $0x4,%esp
 607:	6a 01                	push   $0x1
 609:	8d 45 f4             	lea    -0xc(%ebp),%eax
 60c:	50                   	push   %eax
 60d:	ff 75 08             	pushl  0x8(%ebp)
 610:	e8 63 ff ff ff       	call   578 <write>
 615:	83 c4 10             	add    $0x10,%esp
 618:	c9                   	leave  
 619:	c3                   	ret    

0000061a <printint>:
 61a:	55                   	push   %ebp
 61b:	89 e5                	mov    %esp,%ebp
 61d:	53                   	push   %ebx
 61e:	83 ec 24             	sub    $0x24,%esp
 621:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 628:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 62c:	74 17                	je     645 <printint+0x2b>
 62e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 632:	79 11                	jns    645 <printint+0x2b>
 634:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 63b:	8b 45 0c             	mov    0xc(%ebp),%eax
 63e:	f7 d8                	neg    %eax
 640:	89 45 ec             	mov    %eax,-0x14(%ebp)
 643:	eb 06                	jmp    64b <printint+0x31>
 645:	8b 45 0c             	mov    0xc(%ebp),%eax
 648:	89 45 ec             	mov    %eax,-0x14(%ebp)
 64b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 652:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 655:	8d 41 01             	lea    0x1(%ecx),%eax
 658:	89 45 f4             	mov    %eax,-0xc(%ebp)
 65b:	8b 5d 10             	mov    0x10(%ebp),%ebx
 65e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 661:	ba 00 00 00 00       	mov    $0x0,%edx
 666:	f7 f3                	div    %ebx
 668:	89 d0                	mov    %edx,%eax
 66a:	8a 80 50 0d 00 00    	mov    0xd50(%eax),%al
 670:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
 674:	8b 5d 10             	mov    0x10(%ebp),%ebx
 677:	8b 45 ec             	mov    -0x14(%ebp),%eax
 67a:	ba 00 00 00 00       	mov    $0x0,%edx
 67f:	f7 f3                	div    %ebx
 681:	89 45 ec             	mov    %eax,-0x14(%ebp)
 684:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 688:	75 c8                	jne    652 <printint+0x38>
 68a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 68e:	74 0e                	je     69e <printint+0x84>
 690:	8b 45 f4             	mov    -0xc(%ebp),%eax
 693:	8d 50 01             	lea    0x1(%eax),%edx
 696:	89 55 f4             	mov    %edx,-0xc(%ebp)
 699:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
 69e:	eb 1c                	jmp    6bc <printint+0xa2>
 6a0:	8d 55 dc             	lea    -0x24(%ebp),%edx
 6a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6a6:	01 d0                	add    %edx,%eax
 6a8:	8a 00                	mov    (%eax),%al
 6aa:	0f be c0             	movsbl %al,%eax
 6ad:	83 ec 08             	sub    $0x8,%esp
 6b0:	50                   	push   %eax
 6b1:	ff 75 08             	pushl  0x8(%ebp)
 6b4:	e8 3f ff ff ff       	call   5f8 <putc>
 6b9:	83 c4 10             	add    $0x10,%esp
 6bc:	ff 4d f4             	decl   -0xc(%ebp)
 6bf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6c3:	79 db                	jns    6a0 <printint+0x86>
 6c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6c8:	c9                   	leave  
 6c9:	c3                   	ret    

000006ca <printf>:
 6ca:	55                   	push   %ebp
 6cb:	89 e5                	mov    %esp,%ebp
 6cd:	83 ec 28             	sub    $0x28,%esp
 6d0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 6d7:	8d 45 0c             	lea    0xc(%ebp),%eax
 6da:	83 c0 04             	add    $0x4,%eax
 6dd:	89 45 e8             	mov    %eax,-0x18(%ebp)
 6e0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 6e7:	e9 54 01 00 00       	jmp    840 <printf+0x176>
 6ec:	8b 55 0c             	mov    0xc(%ebp),%edx
 6ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f2:	01 d0                	add    %edx,%eax
 6f4:	8a 00                	mov    (%eax),%al
 6f6:	0f be c0             	movsbl %al,%eax
 6f9:	25 ff 00 00 00       	and    $0xff,%eax
 6fe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 701:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 705:	75 2c                	jne    733 <printf+0x69>
 707:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 70b:	75 0c                	jne    719 <printf+0x4f>
 70d:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 714:	e9 24 01 00 00       	jmp    83d <printf+0x173>
 719:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 71c:	0f be c0             	movsbl %al,%eax
 71f:	83 ec 08             	sub    $0x8,%esp
 722:	50                   	push   %eax
 723:	ff 75 08             	pushl  0x8(%ebp)
 726:	e8 cd fe ff ff       	call   5f8 <putc>
 72b:	83 c4 10             	add    $0x10,%esp
 72e:	e9 0a 01 00 00       	jmp    83d <printf+0x173>
 733:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 737:	0f 85 00 01 00 00    	jne    83d <printf+0x173>
 73d:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 741:	75 1e                	jne    761 <printf+0x97>
 743:	8b 45 e8             	mov    -0x18(%ebp),%eax
 746:	8b 00                	mov    (%eax),%eax
 748:	6a 01                	push   $0x1
 74a:	6a 0a                	push   $0xa
 74c:	50                   	push   %eax
 74d:	ff 75 08             	pushl  0x8(%ebp)
 750:	e8 c5 fe ff ff       	call   61a <printint>
 755:	83 c4 10             	add    $0x10,%esp
 758:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 75c:	e9 d5 00 00 00       	jmp    836 <printf+0x16c>
 761:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 765:	74 06                	je     76d <printf+0xa3>
 767:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 76b:	75 1e                	jne    78b <printf+0xc1>
 76d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 770:	8b 00                	mov    (%eax),%eax
 772:	6a 00                	push   $0x0
 774:	6a 10                	push   $0x10
 776:	50                   	push   %eax
 777:	ff 75 08             	pushl  0x8(%ebp)
 77a:	e8 9b fe ff ff       	call   61a <printint>
 77f:	83 c4 10             	add    $0x10,%esp
 782:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 786:	e9 ab 00 00 00       	jmp    836 <printf+0x16c>
 78b:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 78f:	75 40                	jne    7d1 <printf+0x107>
 791:	8b 45 e8             	mov    -0x18(%ebp),%eax
 794:	8b 00                	mov    (%eax),%eax
 796:	89 45 f4             	mov    %eax,-0xc(%ebp)
 799:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 79d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7a1:	75 07                	jne    7aa <printf+0xe0>
 7a3:	c7 45 f4 bb 0a 00 00 	movl   $0xabb,-0xc(%ebp)
 7aa:	eb 1a                	jmp    7c6 <printf+0xfc>
 7ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7af:	8a 00                	mov    (%eax),%al
 7b1:	0f be c0             	movsbl %al,%eax
 7b4:	83 ec 08             	sub    $0x8,%esp
 7b7:	50                   	push   %eax
 7b8:	ff 75 08             	pushl  0x8(%ebp)
 7bb:	e8 38 fe ff ff       	call   5f8 <putc>
 7c0:	83 c4 10             	add    $0x10,%esp
 7c3:	ff 45 f4             	incl   -0xc(%ebp)
 7c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c9:	8a 00                	mov    (%eax),%al
 7cb:	84 c0                	test   %al,%al
 7cd:	75 dd                	jne    7ac <printf+0xe2>
 7cf:	eb 65                	jmp    836 <printf+0x16c>
 7d1:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 7d5:	75 1d                	jne    7f4 <printf+0x12a>
 7d7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7da:	8b 00                	mov    (%eax),%eax
 7dc:	0f be c0             	movsbl %al,%eax
 7df:	83 ec 08             	sub    $0x8,%esp
 7e2:	50                   	push   %eax
 7e3:	ff 75 08             	pushl  0x8(%ebp)
 7e6:	e8 0d fe ff ff       	call   5f8 <putc>
 7eb:	83 c4 10             	add    $0x10,%esp
 7ee:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7f2:	eb 42                	jmp    836 <printf+0x16c>
 7f4:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7f8:	75 17                	jne    811 <printf+0x147>
 7fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7fd:	0f be c0             	movsbl %al,%eax
 800:	83 ec 08             	sub    $0x8,%esp
 803:	50                   	push   %eax
 804:	ff 75 08             	pushl  0x8(%ebp)
 807:	e8 ec fd ff ff       	call   5f8 <putc>
 80c:	83 c4 10             	add    $0x10,%esp
 80f:	eb 25                	jmp    836 <printf+0x16c>
 811:	83 ec 08             	sub    $0x8,%esp
 814:	6a 25                	push   $0x25
 816:	ff 75 08             	pushl  0x8(%ebp)
 819:	e8 da fd ff ff       	call   5f8 <putc>
 81e:	83 c4 10             	add    $0x10,%esp
 821:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 824:	0f be c0             	movsbl %al,%eax
 827:	83 ec 08             	sub    $0x8,%esp
 82a:	50                   	push   %eax
 82b:	ff 75 08             	pushl  0x8(%ebp)
 82e:	e8 c5 fd ff ff       	call   5f8 <putc>
 833:	83 c4 10             	add    $0x10,%esp
 836:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 83d:	ff 45 f0             	incl   -0x10(%ebp)
 840:	8b 55 0c             	mov    0xc(%ebp),%edx
 843:	8b 45 f0             	mov    -0x10(%ebp),%eax
 846:	01 d0                	add    %edx,%eax
 848:	8a 00                	mov    (%eax),%al
 84a:	84 c0                	test   %al,%al
 84c:	0f 85 9a fe ff ff    	jne    6ec <printf+0x22>
 852:	c9                   	leave  
 853:	c3                   	ret    

00000854 <free>:
 854:	55                   	push   %ebp
 855:	89 e5                	mov    %esp,%ebp
 857:	83 ec 10             	sub    $0x10,%esp
 85a:	8b 45 08             	mov    0x8(%ebp),%eax
 85d:	83 e8 08             	sub    $0x8,%eax
 860:	89 45 f8             	mov    %eax,-0x8(%ebp)
 863:	a1 88 0d 00 00       	mov    0xd88,%eax
 868:	89 45 fc             	mov    %eax,-0x4(%ebp)
 86b:	eb 24                	jmp    891 <free+0x3d>
 86d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 870:	8b 00                	mov    (%eax),%eax
 872:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 875:	77 12                	ja     889 <free+0x35>
 877:	8b 45 f8             	mov    -0x8(%ebp),%eax
 87a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 87d:	77 24                	ja     8a3 <free+0x4f>
 87f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 882:	8b 00                	mov    (%eax),%eax
 884:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 887:	77 1a                	ja     8a3 <free+0x4f>
 889:	8b 45 fc             	mov    -0x4(%ebp),%eax
 88c:	8b 00                	mov    (%eax),%eax
 88e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 891:	8b 45 f8             	mov    -0x8(%ebp),%eax
 894:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 897:	76 d4                	jbe    86d <free+0x19>
 899:	8b 45 fc             	mov    -0x4(%ebp),%eax
 89c:	8b 00                	mov    (%eax),%eax
 89e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8a1:	76 ca                	jbe    86d <free+0x19>
 8a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8a6:	8b 40 04             	mov    0x4(%eax),%eax
 8a9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8b3:	01 c2                	add    %eax,%edx
 8b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8b8:	8b 00                	mov    (%eax),%eax
 8ba:	39 c2                	cmp    %eax,%edx
 8bc:	75 24                	jne    8e2 <free+0x8e>
 8be:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8c1:	8b 50 04             	mov    0x4(%eax),%edx
 8c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c7:	8b 00                	mov    (%eax),%eax
 8c9:	8b 40 04             	mov    0x4(%eax),%eax
 8cc:	01 c2                	add    %eax,%edx
 8ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8d1:	89 50 04             	mov    %edx,0x4(%eax)
 8d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d7:	8b 00                	mov    (%eax),%eax
 8d9:	8b 10                	mov    (%eax),%edx
 8db:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8de:	89 10                	mov    %edx,(%eax)
 8e0:	eb 0a                	jmp    8ec <free+0x98>
 8e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e5:	8b 10                	mov    (%eax),%edx
 8e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8ea:	89 10                	mov    %edx,(%eax)
 8ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ef:	8b 40 04             	mov    0x4(%eax),%eax
 8f2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8fc:	01 d0                	add    %edx,%eax
 8fe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 901:	75 20                	jne    923 <free+0xcf>
 903:	8b 45 fc             	mov    -0x4(%ebp),%eax
 906:	8b 50 04             	mov    0x4(%eax),%edx
 909:	8b 45 f8             	mov    -0x8(%ebp),%eax
 90c:	8b 40 04             	mov    0x4(%eax),%eax
 90f:	01 c2                	add    %eax,%edx
 911:	8b 45 fc             	mov    -0x4(%ebp),%eax
 914:	89 50 04             	mov    %edx,0x4(%eax)
 917:	8b 45 f8             	mov    -0x8(%ebp),%eax
 91a:	8b 10                	mov    (%eax),%edx
 91c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 91f:	89 10                	mov    %edx,(%eax)
 921:	eb 08                	jmp    92b <free+0xd7>
 923:	8b 45 fc             	mov    -0x4(%ebp),%eax
 926:	8b 55 f8             	mov    -0x8(%ebp),%edx
 929:	89 10                	mov    %edx,(%eax)
 92b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 92e:	a3 88 0d 00 00       	mov    %eax,0xd88
 933:	c9                   	leave  
 934:	c3                   	ret    

00000935 <morecore>:
 935:	55                   	push   %ebp
 936:	89 e5                	mov    %esp,%ebp
 938:	83 ec 18             	sub    $0x18,%esp
 93b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 942:	77 07                	ja     94b <morecore+0x16>
 944:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 94b:	8b 45 08             	mov    0x8(%ebp),%eax
 94e:	c1 e0 03             	shl    $0x3,%eax
 951:	83 ec 0c             	sub    $0xc,%esp
 954:	50                   	push   %eax
 955:	e8 86 fc ff ff       	call   5e0 <sbrk>
 95a:	83 c4 10             	add    $0x10,%esp
 95d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 960:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 964:	75 07                	jne    96d <morecore+0x38>
 966:	b8 00 00 00 00       	mov    $0x0,%eax
 96b:	eb 26                	jmp    993 <morecore+0x5e>
 96d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 970:	89 45 f0             	mov    %eax,-0x10(%ebp)
 973:	8b 45 f0             	mov    -0x10(%ebp),%eax
 976:	8b 55 08             	mov    0x8(%ebp),%edx
 979:	89 50 04             	mov    %edx,0x4(%eax)
 97c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 97f:	83 c0 08             	add    $0x8,%eax
 982:	83 ec 0c             	sub    $0xc,%esp
 985:	50                   	push   %eax
 986:	e8 c9 fe ff ff       	call   854 <free>
 98b:	83 c4 10             	add    $0x10,%esp
 98e:	a1 88 0d 00 00       	mov    0xd88,%eax
 993:	c9                   	leave  
 994:	c3                   	ret    

00000995 <malloc>:
 995:	55                   	push   %ebp
 996:	89 e5                	mov    %esp,%ebp
 998:	83 ec 18             	sub    $0x18,%esp
 99b:	8b 45 08             	mov    0x8(%ebp),%eax
 99e:	83 c0 07             	add    $0x7,%eax
 9a1:	c1 e8 03             	shr    $0x3,%eax
 9a4:	40                   	inc    %eax
 9a5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 9a8:	a1 88 0d 00 00       	mov    0xd88,%eax
 9ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9b0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 9b4:	75 23                	jne    9d9 <malloc+0x44>
 9b6:	c7 45 f0 80 0d 00 00 	movl   $0xd80,-0x10(%ebp)
 9bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9c0:	a3 88 0d 00 00       	mov    %eax,0xd88
 9c5:	a1 88 0d 00 00       	mov    0xd88,%eax
 9ca:	a3 80 0d 00 00       	mov    %eax,0xd80
 9cf:	c7 05 84 0d 00 00 00 	movl   $0x0,0xd84
 9d6:	00 00 00 
 9d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9dc:	8b 00                	mov    (%eax),%eax
 9de:	89 45 f4             	mov    %eax,-0xc(%ebp)
 9e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e4:	8b 40 04             	mov    0x4(%eax),%eax
 9e7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9ea:	72 4d                	jb     a39 <malloc+0xa4>
 9ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ef:	8b 40 04             	mov    0x4(%eax),%eax
 9f2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9f5:	75 0c                	jne    a03 <malloc+0x6e>
 9f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9fa:	8b 10                	mov    (%eax),%edx
 9fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9ff:	89 10                	mov    %edx,(%eax)
 a01:	eb 26                	jmp    a29 <malloc+0x94>
 a03:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a06:	8b 40 04             	mov    0x4(%eax),%eax
 a09:	2b 45 ec             	sub    -0x14(%ebp),%eax
 a0c:	89 c2                	mov    %eax,%edx
 a0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a11:	89 50 04             	mov    %edx,0x4(%eax)
 a14:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a17:	8b 40 04             	mov    0x4(%eax),%eax
 a1a:	c1 e0 03             	shl    $0x3,%eax
 a1d:	01 45 f4             	add    %eax,-0xc(%ebp)
 a20:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a23:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a26:	89 50 04             	mov    %edx,0x4(%eax)
 a29:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a2c:	a3 88 0d 00 00       	mov    %eax,0xd88
 a31:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a34:	83 c0 08             	add    $0x8,%eax
 a37:	eb 3b                	jmp    a74 <malloc+0xdf>
 a39:	a1 88 0d 00 00       	mov    0xd88,%eax
 a3e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a41:	75 1e                	jne    a61 <malloc+0xcc>
 a43:	83 ec 0c             	sub    $0xc,%esp
 a46:	ff 75 ec             	pushl  -0x14(%ebp)
 a49:	e8 e7 fe ff ff       	call   935 <morecore>
 a4e:	83 c4 10             	add    $0x10,%esp
 a51:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a54:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a58:	75 07                	jne    a61 <malloc+0xcc>
 a5a:	b8 00 00 00 00       	mov    $0x0,%eax
 a5f:	eb 13                	jmp    a74 <malloc+0xdf>
 a61:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a64:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a67:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a6a:	8b 00                	mov    (%eax),%eax
 a6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a6f:	e9 6d ff ff ff       	jmp    9e1 <malloc+0x4c>
 a74:	c9                   	leave  
 a75:	c3                   	ret    
