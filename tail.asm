
_tail:     file format elf32-i386


Disassembly of section .text:

00000000 <wc>:

char buf[512];

int
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
  31:	05 60 0d 00 00       	add    $0xd60,%eax
  36:	8a 00                	mov    (%eax),%al
  38:	3c 0a                	cmp    $0xa,%al
  3a:	75 03                	jne    3f <wc+0x3f>
        l++;
  3c:	ff 45 f0             	incl   -0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
  3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  42:	05 60 0d 00 00       	add    $0xd60,%eax
  47:	8a 00                	mov    (%eax),%al
  49:	0f be c0             	movsbl %al,%eax
  4c:	83 ec 08             	sub    $0x8,%esp
  4f:	50                   	push   %eax
  50:	68 61 0a 00 00       	push   $0xa61
  55:	e8 75 03 00 00       	call   3cf <strchr>
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
  8d:	68 60 0d 00 00       	push   $0xd60
  92:	ff 75 08             	pushl  0x8(%ebp)
  95:	e8 c1 04 00 00       	call   55b <read>
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
  b3:	68 67 0a 00 00       	push   $0xa67
  b8:	6a 01                	push   $0x1
  ba:	e8 f6 05 00 00       	call   6b5 <printf>
  bf:	83 c4 10             	add    $0x10,%esp
    exit();
  c2:	e8 7c 04 00 00       	call   543 <exit>
  }
  return l;
  c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  ca:	c9                   	leave  
  cb:	c3                   	ret    

000000cc <pc>:

int
pc(int fd, char *name, int numberOfLines)
{
  cc:	55                   	push   %ebp
  cd:	89 e5                	mov    %esp,%ebp
  cf:	83 ec 18             	sub    $0x18,%esp
  int i, n;
  int l;


  l = 0;
  d2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  d9:	eb 7d                	jmp    158 <pc+0x8c>
    for(i=0; i<n; i++){
  db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  e2:	eb 6c                	jmp    150 <pc+0x84>
      if(buf[i] == '\n'){
  e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  e7:	05 60 0d 00 00       	add    $0xd60,%eax
  ec:	8a 00                	mov    (%eax),%al
  ee:	3c 0a                	cmp    $0xa,%al
  f0:	75 30                	jne    122 <pc+0x56>
      	if(l > (numberOfLines - 10)){
  f2:	8b 45 10             	mov    0x10(%ebp),%eax
  f5:	83 e8 0a             	sub    $0xa,%eax
  f8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  fb:	7d 20                	jge    11d <pc+0x51>
      		printf(1, "\n", buf[i]);
  fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 100:	05 60 0d 00 00       	add    $0xd60,%eax
 105:	8a 00                	mov    (%eax),%al
 107:	0f be c0             	movsbl %al,%eax
 10a:	83 ec 04             	sub    $0x4,%esp
 10d:	50                   	push   %eax
 10e:	68 77 0a 00 00       	push   $0xa77
 113:	6a 01                	push   $0x1
 115:	e8 9b 05 00 00       	call   6b5 <printf>
 11a:	83 c4 10             	add    $0x10,%esp
      	}
   		l++;
 11d:	ff 45 f0             	incl   -0x10(%ebp)
 120:	eb 2b                	jmp    14d <pc+0x81>
      }
      else{
      	if(l > (numberOfLines - 10)){
 122:	8b 45 10             	mov    0x10(%ebp),%eax
 125:	83 e8 0a             	sub    $0xa,%eax
 128:	3b 45 f0             	cmp    -0x10(%ebp),%eax
 12b:	7d 20                	jge    14d <pc+0x81>
      		printf(1, "%c", buf[i]);
 12d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 130:	05 60 0d 00 00       	add    $0xd60,%eax
 135:	8a 00                	mov    (%eax),%al
 137:	0f be c0             	movsbl %al,%eax
 13a:	83 ec 04             	sub    $0x4,%esp
 13d:	50                   	push   %eax
 13e:	68 79 0a 00 00       	push   $0xa79
 143:	6a 01                	push   $0x1
 145:	e8 6b 05 00 00       	call   6b5 <printf>
 14a:	83 c4 10             	add    $0x10,%esp
  int l;


  l = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
 14d:	ff 45 f4             	incl   -0xc(%ebp)
 150:	8b 45 f4             	mov    -0xc(%ebp),%eax
 153:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 156:	7c 8c                	jl     e4 <pc+0x18>
  int i, n;
  int l;


  l = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
 158:	83 ec 04             	sub    $0x4,%esp
 15b:	68 00 02 00 00       	push   $0x200
 160:	68 60 0d 00 00       	push   $0xd60
 165:	ff 75 08             	pushl  0x8(%ebp)
 168:	e8 ee 03 00 00       	call   55b <read>
 16d:	83 c4 10             	add    $0x10,%esp
 170:	89 45 ec             	mov    %eax,-0x14(%ebp)
 173:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 177:	0f 8f 5e ff ff ff    	jg     db <pc+0xf>
      	}
      }
      
    }
  }
  if(n < 0){
 17d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 181:	79 17                	jns    19a <pc+0xce>
    printf(1, "wc: read error\n");
 183:	83 ec 08             	sub    $0x8,%esp
 186:	68 67 0a 00 00       	push   $0xa67
 18b:	6a 01                	push   $0x1
 18d:	e8 23 05 00 00       	call   6b5 <printf>
 192:	83 c4 10             	add    $0x10,%esp
    exit();
 195:	e8 a9 03 00 00       	call   543 <exit>
  }
  return l;
 19a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 19d:	c9                   	leave  
 19e:	c3                   	ret    

0000019f <main>:

int
main(int argc, char *argv[])
{
 19f:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 1a3:	83 e4 f0             	and    $0xfffffff0,%esp
 1a6:	ff 71 fc             	pushl  -0x4(%ecx)
 1a9:	55                   	push   %ebp
 1aa:	89 e5                	mov    %esp,%ebp
 1ac:	53                   	push   %ebx
 1ad:	51                   	push   %ecx
 1ae:	83 ec 10             	sub    $0x10,%esp
 1b1:	89 cb                	mov    %ecx,%ebx
  int fd1, fd, i;

  if(argc <= 1){
 1b3:	83 3b 01             	cmpl   $0x1,(%ebx)
 1b6:	7f 17                	jg     1cf <main+0x30>
  	wc(0, "");
 1b8:	83 ec 08             	sub    $0x8,%esp
 1bb:	68 7c 0a 00 00       	push   $0xa7c
 1c0:	6a 00                	push   $0x0
 1c2:	e8 39 fe ff ff       	call   0 <wc>
 1c7:	83 c4 10             	add    $0x10,%esp
    exit();
 1ca:	e8 74 03 00 00       	call   543 <exit>
  }

  for(i = 1; i < argc; i++){
 1cf:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
 1d6:	e9 1a 01 00 00       	jmp    2f5 <main+0x156>
    if((fd = open(argv[i], 0)) < 0){
 1db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1de:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 1e5:	8b 43 04             	mov    0x4(%ebx),%eax
 1e8:	01 d0                	add    %edx,%eax
 1ea:	8b 00                	mov    (%eax),%eax
 1ec:	83 ec 08             	sub    $0x8,%esp
 1ef:	6a 00                	push   $0x0
 1f1:	50                   	push   %eax
 1f2:	e8 8c 03 00 00       	call   583 <open>
 1f7:	83 c4 10             	add    $0x10,%esp
 1fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
 1fd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 201:	79 29                	jns    22c <main+0x8d>
      printf(1, "cat: cannot open %s\n", argv[i]);
 203:	8b 45 f4             	mov    -0xc(%ebp),%eax
 206:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 20d:	8b 43 04             	mov    0x4(%ebx),%eax
 210:	01 d0                	add    %edx,%eax
 212:	8b 00                	mov    (%eax),%eax
 214:	83 ec 04             	sub    $0x4,%esp
 217:	50                   	push   %eax
 218:	68 7d 0a 00 00       	push   $0xa7d
 21d:	6a 01                	push   $0x1
 21f:	e8 91 04 00 00       	call   6b5 <printf>
 224:	83 c4 10             	add    $0x10,%esp
      exit();
 227:	e8 17 03 00 00       	call   543 <exit>
    }
    if((fd1 = open(argv[i], 0)) < 0){
 22c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 22f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 236:	8b 43 04             	mov    0x4(%ebx),%eax
 239:	01 d0                	add    %edx,%eax
 23b:	8b 00                	mov    (%eax),%eax
 23d:	83 ec 08             	sub    $0x8,%esp
 240:	6a 00                	push   $0x0
 242:	50                   	push   %eax
 243:	e8 3b 03 00 00       	call   583 <open>
 248:	83 c4 10             	add    $0x10,%esp
 24b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 24e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 252:	79 29                	jns    27d <main+0xde>
      printf(1, "cat: cannot open %s\n", argv[i]);
 254:	8b 45 f4             	mov    -0xc(%ebp),%eax
 257:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 25e:	8b 43 04             	mov    0x4(%ebx),%eax
 261:	01 d0                	add    %edx,%eax
 263:	8b 00                	mov    (%eax),%eax
 265:	83 ec 04             	sub    $0x4,%esp
 268:	50                   	push   %eax
 269:	68 7d 0a 00 00       	push   $0xa7d
 26e:	6a 01                	push   $0x1
 270:	e8 40 04 00 00       	call   6b5 <printf>
 275:	83 c4 10             	add    $0x10,%esp
      exit();
 278:	e8 c6 02 00 00       	call   543 <exit>
    }
    int numOfL = wc(fd, argv[i]);
 27d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 280:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 287:	8b 43 04             	mov    0x4(%ebx),%eax
 28a:	01 d0                	add    %edx,%eax
 28c:	8b 00                	mov    (%eax),%eax
 28e:	83 ec 08             	sub    $0x8,%esp
 291:	50                   	push   %eax
 292:	ff 75 f0             	pushl  -0x10(%ebp)
 295:	e8 66 fd ff ff       	call   0 <wc>
 29a:	83 c4 10             	add    $0x10,%esp
 29d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    printf(1, "%d\n",pc(fd1, argv[i], numOfL));
 2a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2a3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 2aa:	8b 43 04             	mov    0x4(%ebx),%eax
 2ad:	01 d0                	add    %edx,%eax
 2af:	8b 00                	mov    (%eax),%eax
 2b1:	83 ec 04             	sub    $0x4,%esp
 2b4:	ff 75 e8             	pushl  -0x18(%ebp)
 2b7:	50                   	push   %eax
 2b8:	ff 75 ec             	pushl  -0x14(%ebp)
 2bb:	e8 0c fe ff ff       	call   cc <pc>
 2c0:	83 c4 10             	add    $0x10,%esp
 2c3:	83 ec 04             	sub    $0x4,%esp
 2c6:	50                   	push   %eax
 2c7:	68 92 0a 00 00       	push   $0xa92
 2cc:	6a 01                	push   $0x1
 2ce:	e8 e2 03 00 00       	call   6b5 <printf>
 2d3:	83 c4 10             	add    $0x10,%esp
    close(fd1);
 2d6:	83 ec 0c             	sub    $0xc,%esp
 2d9:	ff 75 ec             	pushl  -0x14(%ebp)
 2dc:	e8 8a 02 00 00       	call   56b <close>
 2e1:	83 c4 10             	add    $0x10,%esp
    close(fd);
 2e4:	83 ec 0c             	sub    $0xc,%esp
 2e7:	ff 75 f0             	pushl  -0x10(%ebp)
 2ea:	e8 7c 02 00 00       	call   56b <close>
 2ef:	83 c4 10             	add    $0x10,%esp
  if(argc <= 1){
  	wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
 2f2:	ff 45 f4             	incl   -0xc(%ebp)
 2f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2f8:	3b 03                	cmp    (%ebx),%eax
 2fa:	0f 8c db fe ff ff    	jl     1db <main+0x3c>
    int numOfL = wc(fd, argv[i]);
    printf(1, "%d\n",pc(fd1, argv[i], numOfL));
    close(fd1);
    close(fd);
  }
  exit();
 300:	e8 3e 02 00 00       	call   543 <exit>

00000305 <stosb>:
 305:	55                   	push   %ebp
 306:	89 e5                	mov    %esp,%ebp
 308:	57                   	push   %edi
 309:	53                   	push   %ebx
 30a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 30d:	8b 55 10             	mov    0x10(%ebp),%edx
 310:	8b 45 0c             	mov    0xc(%ebp),%eax
 313:	89 cb                	mov    %ecx,%ebx
 315:	89 df                	mov    %ebx,%edi
 317:	89 d1                	mov    %edx,%ecx
 319:	fc                   	cld    
 31a:	f3 aa                	rep stos %al,%es:(%edi)
 31c:	89 ca                	mov    %ecx,%edx
 31e:	89 fb                	mov    %edi,%ebx
 320:	89 5d 08             	mov    %ebx,0x8(%ebp)
 323:	89 55 10             	mov    %edx,0x10(%ebp)
 326:	5b                   	pop    %ebx
 327:	5f                   	pop    %edi
 328:	5d                   	pop    %ebp
 329:	c3                   	ret    

0000032a <strcpy>:
 32a:	55                   	push   %ebp
 32b:	89 e5                	mov    %esp,%ebp
 32d:	83 ec 10             	sub    $0x10,%esp
 330:	8b 45 08             	mov    0x8(%ebp),%eax
 333:	89 45 fc             	mov    %eax,-0x4(%ebp)
 336:	90                   	nop
 337:	8b 45 08             	mov    0x8(%ebp),%eax
 33a:	8d 50 01             	lea    0x1(%eax),%edx
 33d:	89 55 08             	mov    %edx,0x8(%ebp)
 340:	8b 55 0c             	mov    0xc(%ebp),%edx
 343:	8d 4a 01             	lea    0x1(%edx),%ecx
 346:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 349:	8a 12                	mov    (%edx),%dl
 34b:	88 10                	mov    %dl,(%eax)
 34d:	8a 00                	mov    (%eax),%al
 34f:	84 c0                	test   %al,%al
 351:	75 e4                	jne    337 <strcpy+0xd>
 353:	8b 45 fc             	mov    -0x4(%ebp),%eax
 356:	c9                   	leave  
 357:	c3                   	ret    

00000358 <strcmp>:
 358:	55                   	push   %ebp
 359:	89 e5                	mov    %esp,%ebp
 35b:	eb 06                	jmp    363 <strcmp+0xb>
 35d:	ff 45 08             	incl   0x8(%ebp)
 360:	ff 45 0c             	incl   0xc(%ebp)
 363:	8b 45 08             	mov    0x8(%ebp),%eax
 366:	8a 00                	mov    (%eax),%al
 368:	84 c0                	test   %al,%al
 36a:	74 0e                	je     37a <strcmp+0x22>
 36c:	8b 45 08             	mov    0x8(%ebp),%eax
 36f:	8a 10                	mov    (%eax),%dl
 371:	8b 45 0c             	mov    0xc(%ebp),%eax
 374:	8a 00                	mov    (%eax),%al
 376:	38 c2                	cmp    %al,%dl
 378:	74 e3                	je     35d <strcmp+0x5>
 37a:	8b 45 08             	mov    0x8(%ebp),%eax
 37d:	8a 00                	mov    (%eax),%al
 37f:	0f b6 d0             	movzbl %al,%edx
 382:	8b 45 0c             	mov    0xc(%ebp),%eax
 385:	8a 00                	mov    (%eax),%al
 387:	0f b6 c0             	movzbl %al,%eax
 38a:	29 c2                	sub    %eax,%edx
 38c:	89 d0                	mov    %edx,%eax
 38e:	5d                   	pop    %ebp
 38f:	c3                   	ret    

00000390 <strlen>:
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	83 ec 10             	sub    $0x10,%esp
 396:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 39d:	eb 03                	jmp    3a2 <strlen+0x12>
 39f:	ff 45 fc             	incl   -0x4(%ebp)
 3a2:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3a5:	8b 45 08             	mov    0x8(%ebp),%eax
 3a8:	01 d0                	add    %edx,%eax
 3aa:	8a 00                	mov    (%eax),%al
 3ac:	84 c0                	test   %al,%al
 3ae:	75 ef                	jne    39f <strlen+0xf>
 3b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3b3:	c9                   	leave  
 3b4:	c3                   	ret    

000003b5 <memset>:
 3b5:	55                   	push   %ebp
 3b6:	89 e5                	mov    %esp,%ebp
 3b8:	8b 45 10             	mov    0x10(%ebp),%eax
 3bb:	50                   	push   %eax
 3bc:	ff 75 0c             	pushl  0xc(%ebp)
 3bf:	ff 75 08             	pushl  0x8(%ebp)
 3c2:	e8 3e ff ff ff       	call   305 <stosb>
 3c7:	83 c4 0c             	add    $0xc,%esp
 3ca:	8b 45 08             	mov    0x8(%ebp),%eax
 3cd:	c9                   	leave  
 3ce:	c3                   	ret    

000003cf <strchr>:
 3cf:	55                   	push   %ebp
 3d0:	89 e5                	mov    %esp,%ebp
 3d2:	83 ec 04             	sub    $0x4,%esp
 3d5:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d8:	88 45 fc             	mov    %al,-0x4(%ebp)
 3db:	eb 12                	jmp    3ef <strchr+0x20>
 3dd:	8b 45 08             	mov    0x8(%ebp),%eax
 3e0:	8a 00                	mov    (%eax),%al
 3e2:	3a 45 fc             	cmp    -0x4(%ebp),%al
 3e5:	75 05                	jne    3ec <strchr+0x1d>
 3e7:	8b 45 08             	mov    0x8(%ebp),%eax
 3ea:	eb 11                	jmp    3fd <strchr+0x2e>
 3ec:	ff 45 08             	incl   0x8(%ebp)
 3ef:	8b 45 08             	mov    0x8(%ebp),%eax
 3f2:	8a 00                	mov    (%eax),%al
 3f4:	84 c0                	test   %al,%al
 3f6:	75 e5                	jne    3dd <strchr+0xe>
 3f8:	b8 00 00 00 00       	mov    $0x0,%eax
 3fd:	c9                   	leave  
 3fe:	c3                   	ret    

000003ff <gets>:
 3ff:	55                   	push   %ebp
 400:	89 e5                	mov    %esp,%ebp
 402:	83 ec 18             	sub    $0x18,%esp
 405:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 40c:	eb 41                	jmp    44f <gets+0x50>
 40e:	83 ec 04             	sub    $0x4,%esp
 411:	6a 01                	push   $0x1
 413:	8d 45 ef             	lea    -0x11(%ebp),%eax
 416:	50                   	push   %eax
 417:	6a 00                	push   $0x0
 419:	e8 3d 01 00 00       	call   55b <read>
 41e:	83 c4 10             	add    $0x10,%esp
 421:	89 45 f0             	mov    %eax,-0x10(%ebp)
 424:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 428:	7f 02                	jg     42c <gets+0x2d>
 42a:	eb 2c                	jmp    458 <gets+0x59>
 42c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 42f:	8d 50 01             	lea    0x1(%eax),%edx
 432:	89 55 f4             	mov    %edx,-0xc(%ebp)
 435:	89 c2                	mov    %eax,%edx
 437:	8b 45 08             	mov    0x8(%ebp),%eax
 43a:	01 c2                	add    %eax,%edx
 43c:	8a 45 ef             	mov    -0x11(%ebp),%al
 43f:	88 02                	mov    %al,(%edx)
 441:	8a 45 ef             	mov    -0x11(%ebp),%al
 444:	3c 0a                	cmp    $0xa,%al
 446:	74 10                	je     458 <gets+0x59>
 448:	8a 45 ef             	mov    -0x11(%ebp),%al
 44b:	3c 0d                	cmp    $0xd,%al
 44d:	74 09                	je     458 <gets+0x59>
 44f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 452:	40                   	inc    %eax
 453:	3b 45 0c             	cmp    0xc(%ebp),%eax
 456:	7c b6                	jl     40e <gets+0xf>
 458:	8b 55 f4             	mov    -0xc(%ebp),%edx
 45b:	8b 45 08             	mov    0x8(%ebp),%eax
 45e:	01 d0                	add    %edx,%eax
 460:	c6 00 00             	movb   $0x0,(%eax)
 463:	8b 45 08             	mov    0x8(%ebp),%eax
 466:	c9                   	leave  
 467:	c3                   	ret    

00000468 <stat>:
 468:	55                   	push   %ebp
 469:	89 e5                	mov    %esp,%ebp
 46b:	83 ec 18             	sub    $0x18,%esp
 46e:	83 ec 08             	sub    $0x8,%esp
 471:	6a 00                	push   $0x0
 473:	ff 75 08             	pushl  0x8(%ebp)
 476:	e8 08 01 00 00       	call   583 <open>
 47b:	83 c4 10             	add    $0x10,%esp
 47e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 481:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 485:	79 07                	jns    48e <stat+0x26>
 487:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 48c:	eb 25                	jmp    4b3 <stat+0x4b>
 48e:	83 ec 08             	sub    $0x8,%esp
 491:	ff 75 0c             	pushl  0xc(%ebp)
 494:	ff 75 f4             	pushl  -0xc(%ebp)
 497:	e8 ff 00 00 00       	call   59b <fstat>
 49c:	83 c4 10             	add    $0x10,%esp
 49f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 4a2:	83 ec 0c             	sub    $0xc,%esp
 4a5:	ff 75 f4             	pushl  -0xc(%ebp)
 4a8:	e8 be 00 00 00       	call   56b <close>
 4ad:	83 c4 10             	add    $0x10,%esp
 4b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4b3:	c9                   	leave  
 4b4:	c3                   	ret    

000004b5 <atoi>:
 4b5:	55                   	push   %ebp
 4b6:	89 e5                	mov    %esp,%ebp
 4b8:	83 ec 10             	sub    $0x10,%esp
 4bb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 4c2:	eb 24                	jmp    4e8 <atoi+0x33>
 4c4:	8b 55 fc             	mov    -0x4(%ebp),%edx
 4c7:	89 d0                	mov    %edx,%eax
 4c9:	c1 e0 02             	shl    $0x2,%eax
 4cc:	01 d0                	add    %edx,%eax
 4ce:	01 c0                	add    %eax,%eax
 4d0:	89 c1                	mov    %eax,%ecx
 4d2:	8b 45 08             	mov    0x8(%ebp),%eax
 4d5:	8d 50 01             	lea    0x1(%eax),%edx
 4d8:	89 55 08             	mov    %edx,0x8(%ebp)
 4db:	8a 00                	mov    (%eax),%al
 4dd:	0f be c0             	movsbl %al,%eax
 4e0:	01 c8                	add    %ecx,%eax
 4e2:	83 e8 30             	sub    $0x30,%eax
 4e5:	89 45 fc             	mov    %eax,-0x4(%ebp)
 4e8:	8b 45 08             	mov    0x8(%ebp),%eax
 4eb:	8a 00                	mov    (%eax),%al
 4ed:	3c 2f                	cmp    $0x2f,%al
 4ef:	7e 09                	jle    4fa <atoi+0x45>
 4f1:	8b 45 08             	mov    0x8(%ebp),%eax
 4f4:	8a 00                	mov    (%eax),%al
 4f6:	3c 39                	cmp    $0x39,%al
 4f8:	7e ca                	jle    4c4 <atoi+0xf>
 4fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 4fd:	c9                   	leave  
 4fe:	c3                   	ret    

000004ff <memmove>:
 4ff:	55                   	push   %ebp
 500:	89 e5                	mov    %esp,%ebp
 502:	83 ec 10             	sub    $0x10,%esp
 505:	8b 45 08             	mov    0x8(%ebp),%eax
 508:	89 45 fc             	mov    %eax,-0x4(%ebp)
 50b:	8b 45 0c             	mov    0xc(%ebp),%eax
 50e:	89 45 f8             	mov    %eax,-0x8(%ebp)
 511:	eb 16                	jmp    529 <memmove+0x2a>
 513:	8b 45 fc             	mov    -0x4(%ebp),%eax
 516:	8d 50 01             	lea    0x1(%eax),%edx
 519:	89 55 fc             	mov    %edx,-0x4(%ebp)
 51c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 51f:	8d 4a 01             	lea    0x1(%edx),%ecx
 522:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 525:	8a 12                	mov    (%edx),%dl
 527:	88 10                	mov    %dl,(%eax)
 529:	8b 45 10             	mov    0x10(%ebp),%eax
 52c:	8d 50 ff             	lea    -0x1(%eax),%edx
 52f:	89 55 10             	mov    %edx,0x10(%ebp)
 532:	85 c0                	test   %eax,%eax
 534:	7f dd                	jg     513 <memmove+0x14>
 536:	8b 45 08             	mov    0x8(%ebp),%eax
 539:	c9                   	leave  
 53a:	c3                   	ret    

0000053b <fork>:
 53b:	b8 01 00 00 00       	mov    $0x1,%eax
 540:	cd 40                	int    $0x40
 542:	c3                   	ret    

00000543 <exit>:
 543:	b8 02 00 00 00       	mov    $0x2,%eax
 548:	cd 40                	int    $0x40
 54a:	c3                   	ret    

0000054b <wait>:
 54b:	b8 03 00 00 00       	mov    $0x3,%eax
 550:	cd 40                	int    $0x40
 552:	c3                   	ret    

00000553 <pipe>:
 553:	b8 04 00 00 00       	mov    $0x4,%eax
 558:	cd 40                	int    $0x40
 55a:	c3                   	ret    

0000055b <read>:
 55b:	b8 05 00 00 00       	mov    $0x5,%eax
 560:	cd 40                	int    $0x40
 562:	c3                   	ret    

00000563 <write>:
 563:	b8 10 00 00 00       	mov    $0x10,%eax
 568:	cd 40                	int    $0x40
 56a:	c3                   	ret    

0000056b <close>:
 56b:	b8 15 00 00 00       	mov    $0x15,%eax
 570:	cd 40                	int    $0x40
 572:	c3                   	ret    

00000573 <kill>:
 573:	b8 06 00 00 00       	mov    $0x6,%eax
 578:	cd 40                	int    $0x40
 57a:	c3                   	ret    

0000057b <exec>:
 57b:	b8 07 00 00 00       	mov    $0x7,%eax
 580:	cd 40                	int    $0x40
 582:	c3                   	ret    

00000583 <open>:
 583:	b8 0f 00 00 00       	mov    $0xf,%eax
 588:	cd 40                	int    $0x40
 58a:	c3                   	ret    

0000058b <mknod>:
 58b:	b8 11 00 00 00       	mov    $0x11,%eax
 590:	cd 40                	int    $0x40
 592:	c3                   	ret    

00000593 <unlink>:
 593:	b8 12 00 00 00       	mov    $0x12,%eax
 598:	cd 40                	int    $0x40
 59a:	c3                   	ret    

0000059b <fstat>:
 59b:	b8 08 00 00 00       	mov    $0x8,%eax
 5a0:	cd 40                	int    $0x40
 5a2:	c3                   	ret    

000005a3 <link>:
 5a3:	b8 13 00 00 00       	mov    $0x13,%eax
 5a8:	cd 40                	int    $0x40
 5aa:	c3                   	ret    

000005ab <mkdir>:
 5ab:	b8 14 00 00 00       	mov    $0x14,%eax
 5b0:	cd 40                	int    $0x40
 5b2:	c3                   	ret    

000005b3 <chdir>:
 5b3:	b8 09 00 00 00       	mov    $0x9,%eax
 5b8:	cd 40                	int    $0x40
 5ba:	c3                   	ret    

000005bb <dup>:
 5bb:	b8 0a 00 00 00       	mov    $0xa,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret    

000005c3 <getpid>:
 5c3:	b8 0b 00 00 00       	mov    $0xb,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret    

000005cb <sbrk>:
 5cb:	b8 0c 00 00 00       	mov    $0xc,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret    

000005d3 <sleep>:
 5d3:	b8 0d 00 00 00       	mov    $0xd,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret    

000005db <uptime>:
 5db:	b8 0e 00 00 00       	mov    $0xe,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret    

000005e3 <putc>:
 5e3:	55                   	push   %ebp
 5e4:	89 e5                	mov    %esp,%ebp
 5e6:	83 ec 18             	sub    $0x18,%esp
 5e9:	8b 45 0c             	mov    0xc(%ebp),%eax
 5ec:	88 45 f4             	mov    %al,-0xc(%ebp)
 5ef:	83 ec 04             	sub    $0x4,%esp
 5f2:	6a 01                	push   $0x1
 5f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
 5f7:	50                   	push   %eax
 5f8:	ff 75 08             	pushl  0x8(%ebp)
 5fb:	e8 63 ff ff ff       	call   563 <write>
 600:	83 c4 10             	add    $0x10,%esp
 603:	c9                   	leave  
 604:	c3                   	ret    

00000605 <printint>:
 605:	55                   	push   %ebp
 606:	89 e5                	mov    %esp,%ebp
 608:	53                   	push   %ebx
 609:	83 ec 24             	sub    $0x24,%esp
 60c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 613:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 617:	74 17                	je     630 <printint+0x2b>
 619:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 61d:	79 11                	jns    630 <printint+0x2b>
 61f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 626:	8b 45 0c             	mov    0xc(%ebp),%eax
 629:	f7 d8                	neg    %eax
 62b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 62e:	eb 06                	jmp    636 <printint+0x31>
 630:	8b 45 0c             	mov    0xc(%ebp),%eax
 633:	89 45 ec             	mov    %eax,-0x14(%ebp)
 636:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 63d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 640:	8d 41 01             	lea    0x1(%ecx),%eax
 643:	89 45 f4             	mov    %eax,-0xc(%ebp)
 646:	8b 5d 10             	mov    0x10(%ebp),%ebx
 649:	8b 45 ec             	mov    -0x14(%ebp),%eax
 64c:	ba 00 00 00 00       	mov    $0x0,%edx
 651:	f7 f3                	div    %ebx
 653:	89 d0                	mov    %edx,%eax
 655:	8a 80 2c 0d 00 00    	mov    0xd2c(%eax),%al
 65b:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
 65f:	8b 5d 10             	mov    0x10(%ebp),%ebx
 662:	8b 45 ec             	mov    -0x14(%ebp),%eax
 665:	ba 00 00 00 00       	mov    $0x0,%edx
 66a:	f7 f3                	div    %ebx
 66c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 66f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 673:	75 c8                	jne    63d <printint+0x38>
 675:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 679:	74 0e                	je     689 <printint+0x84>
 67b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 67e:	8d 50 01             	lea    0x1(%eax),%edx
 681:	89 55 f4             	mov    %edx,-0xc(%ebp)
 684:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
 689:	eb 1c                	jmp    6a7 <printint+0xa2>
 68b:	8d 55 dc             	lea    -0x24(%ebp),%edx
 68e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 691:	01 d0                	add    %edx,%eax
 693:	8a 00                	mov    (%eax),%al
 695:	0f be c0             	movsbl %al,%eax
 698:	83 ec 08             	sub    $0x8,%esp
 69b:	50                   	push   %eax
 69c:	ff 75 08             	pushl  0x8(%ebp)
 69f:	e8 3f ff ff ff       	call   5e3 <putc>
 6a4:	83 c4 10             	add    $0x10,%esp
 6a7:	ff 4d f4             	decl   -0xc(%ebp)
 6aa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6ae:	79 db                	jns    68b <printint+0x86>
 6b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6b3:	c9                   	leave  
 6b4:	c3                   	ret    

000006b5 <printf>:
 6b5:	55                   	push   %ebp
 6b6:	89 e5                	mov    %esp,%ebp
 6b8:	83 ec 28             	sub    $0x28,%esp
 6bb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 6c2:	8d 45 0c             	lea    0xc(%ebp),%eax
 6c5:	83 c0 04             	add    $0x4,%eax
 6c8:	89 45 e8             	mov    %eax,-0x18(%ebp)
 6cb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 6d2:	e9 54 01 00 00       	jmp    82b <printf+0x176>
 6d7:	8b 55 0c             	mov    0xc(%ebp),%edx
 6da:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6dd:	01 d0                	add    %edx,%eax
 6df:	8a 00                	mov    (%eax),%al
 6e1:	0f be c0             	movsbl %al,%eax
 6e4:	25 ff 00 00 00       	and    $0xff,%eax
 6e9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 6ec:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6f0:	75 2c                	jne    71e <printf+0x69>
 6f2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6f6:	75 0c                	jne    704 <printf+0x4f>
 6f8:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 6ff:	e9 24 01 00 00       	jmp    828 <printf+0x173>
 704:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 707:	0f be c0             	movsbl %al,%eax
 70a:	83 ec 08             	sub    $0x8,%esp
 70d:	50                   	push   %eax
 70e:	ff 75 08             	pushl  0x8(%ebp)
 711:	e8 cd fe ff ff       	call   5e3 <putc>
 716:	83 c4 10             	add    $0x10,%esp
 719:	e9 0a 01 00 00       	jmp    828 <printf+0x173>
 71e:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 722:	0f 85 00 01 00 00    	jne    828 <printf+0x173>
 728:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 72c:	75 1e                	jne    74c <printf+0x97>
 72e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 731:	8b 00                	mov    (%eax),%eax
 733:	6a 01                	push   $0x1
 735:	6a 0a                	push   $0xa
 737:	50                   	push   %eax
 738:	ff 75 08             	pushl  0x8(%ebp)
 73b:	e8 c5 fe ff ff       	call   605 <printint>
 740:	83 c4 10             	add    $0x10,%esp
 743:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 747:	e9 d5 00 00 00       	jmp    821 <printf+0x16c>
 74c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 750:	74 06                	je     758 <printf+0xa3>
 752:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 756:	75 1e                	jne    776 <printf+0xc1>
 758:	8b 45 e8             	mov    -0x18(%ebp),%eax
 75b:	8b 00                	mov    (%eax),%eax
 75d:	6a 00                	push   $0x0
 75f:	6a 10                	push   $0x10
 761:	50                   	push   %eax
 762:	ff 75 08             	pushl  0x8(%ebp)
 765:	e8 9b fe ff ff       	call   605 <printint>
 76a:	83 c4 10             	add    $0x10,%esp
 76d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 771:	e9 ab 00 00 00       	jmp    821 <printf+0x16c>
 776:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 77a:	75 40                	jne    7bc <printf+0x107>
 77c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 77f:	8b 00                	mov    (%eax),%eax
 781:	89 45 f4             	mov    %eax,-0xc(%ebp)
 784:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 788:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 78c:	75 07                	jne    795 <printf+0xe0>
 78e:	c7 45 f4 96 0a 00 00 	movl   $0xa96,-0xc(%ebp)
 795:	eb 1a                	jmp    7b1 <printf+0xfc>
 797:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79a:	8a 00                	mov    (%eax),%al
 79c:	0f be c0             	movsbl %al,%eax
 79f:	83 ec 08             	sub    $0x8,%esp
 7a2:	50                   	push   %eax
 7a3:	ff 75 08             	pushl  0x8(%ebp)
 7a6:	e8 38 fe ff ff       	call   5e3 <putc>
 7ab:	83 c4 10             	add    $0x10,%esp
 7ae:	ff 45 f4             	incl   -0xc(%ebp)
 7b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b4:	8a 00                	mov    (%eax),%al
 7b6:	84 c0                	test   %al,%al
 7b8:	75 dd                	jne    797 <printf+0xe2>
 7ba:	eb 65                	jmp    821 <printf+0x16c>
 7bc:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 7c0:	75 1d                	jne    7df <printf+0x12a>
 7c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7c5:	8b 00                	mov    (%eax),%eax
 7c7:	0f be c0             	movsbl %al,%eax
 7ca:	83 ec 08             	sub    $0x8,%esp
 7cd:	50                   	push   %eax
 7ce:	ff 75 08             	pushl  0x8(%ebp)
 7d1:	e8 0d fe ff ff       	call   5e3 <putc>
 7d6:	83 c4 10             	add    $0x10,%esp
 7d9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7dd:	eb 42                	jmp    821 <printf+0x16c>
 7df:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7e3:	75 17                	jne    7fc <printf+0x147>
 7e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7e8:	0f be c0             	movsbl %al,%eax
 7eb:	83 ec 08             	sub    $0x8,%esp
 7ee:	50                   	push   %eax
 7ef:	ff 75 08             	pushl  0x8(%ebp)
 7f2:	e8 ec fd ff ff       	call   5e3 <putc>
 7f7:	83 c4 10             	add    $0x10,%esp
 7fa:	eb 25                	jmp    821 <printf+0x16c>
 7fc:	83 ec 08             	sub    $0x8,%esp
 7ff:	6a 25                	push   $0x25
 801:	ff 75 08             	pushl  0x8(%ebp)
 804:	e8 da fd ff ff       	call   5e3 <putc>
 809:	83 c4 10             	add    $0x10,%esp
 80c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 80f:	0f be c0             	movsbl %al,%eax
 812:	83 ec 08             	sub    $0x8,%esp
 815:	50                   	push   %eax
 816:	ff 75 08             	pushl  0x8(%ebp)
 819:	e8 c5 fd ff ff       	call   5e3 <putc>
 81e:	83 c4 10             	add    $0x10,%esp
 821:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 828:	ff 45 f0             	incl   -0x10(%ebp)
 82b:	8b 55 0c             	mov    0xc(%ebp),%edx
 82e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 831:	01 d0                	add    %edx,%eax
 833:	8a 00                	mov    (%eax),%al
 835:	84 c0                	test   %al,%al
 837:	0f 85 9a fe ff ff    	jne    6d7 <printf+0x22>
 83d:	c9                   	leave  
 83e:	c3                   	ret    

0000083f <free>:
 83f:	55                   	push   %ebp
 840:	89 e5                	mov    %esp,%ebp
 842:	83 ec 10             	sub    $0x10,%esp
 845:	8b 45 08             	mov    0x8(%ebp),%eax
 848:	83 e8 08             	sub    $0x8,%eax
 84b:	89 45 f8             	mov    %eax,-0x8(%ebp)
 84e:	a1 48 0d 00 00       	mov    0xd48,%eax
 853:	89 45 fc             	mov    %eax,-0x4(%ebp)
 856:	eb 24                	jmp    87c <free+0x3d>
 858:	8b 45 fc             	mov    -0x4(%ebp),%eax
 85b:	8b 00                	mov    (%eax),%eax
 85d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 860:	77 12                	ja     874 <free+0x35>
 862:	8b 45 f8             	mov    -0x8(%ebp),%eax
 865:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 868:	77 24                	ja     88e <free+0x4f>
 86a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 86d:	8b 00                	mov    (%eax),%eax
 86f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 872:	77 1a                	ja     88e <free+0x4f>
 874:	8b 45 fc             	mov    -0x4(%ebp),%eax
 877:	8b 00                	mov    (%eax),%eax
 879:	89 45 fc             	mov    %eax,-0x4(%ebp)
 87c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 87f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 882:	76 d4                	jbe    858 <free+0x19>
 884:	8b 45 fc             	mov    -0x4(%ebp),%eax
 887:	8b 00                	mov    (%eax),%eax
 889:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 88c:	76 ca                	jbe    858 <free+0x19>
 88e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 891:	8b 40 04             	mov    0x4(%eax),%eax
 894:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 89b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 89e:	01 c2                	add    %eax,%edx
 8a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8a3:	8b 00                	mov    (%eax),%eax
 8a5:	39 c2                	cmp    %eax,%edx
 8a7:	75 24                	jne    8cd <free+0x8e>
 8a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8ac:	8b 50 04             	mov    0x4(%eax),%edx
 8af:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8b2:	8b 00                	mov    (%eax),%eax
 8b4:	8b 40 04             	mov    0x4(%eax),%eax
 8b7:	01 c2                	add    %eax,%edx
 8b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8bc:	89 50 04             	mov    %edx,0x4(%eax)
 8bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c2:	8b 00                	mov    (%eax),%eax
 8c4:	8b 10                	mov    (%eax),%edx
 8c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8c9:	89 10                	mov    %edx,(%eax)
 8cb:	eb 0a                	jmp    8d7 <free+0x98>
 8cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d0:	8b 10                	mov    (%eax),%edx
 8d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8d5:	89 10                	mov    %edx,(%eax)
 8d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8da:	8b 40 04             	mov    0x4(%eax),%eax
 8dd:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e7:	01 d0                	add    %edx,%eax
 8e9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8ec:	75 20                	jne    90e <free+0xcf>
 8ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f1:	8b 50 04             	mov    0x4(%eax),%edx
 8f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8f7:	8b 40 04             	mov    0x4(%eax),%eax
 8fa:	01 c2                	add    %eax,%edx
 8fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ff:	89 50 04             	mov    %edx,0x4(%eax)
 902:	8b 45 f8             	mov    -0x8(%ebp),%eax
 905:	8b 10                	mov    (%eax),%edx
 907:	8b 45 fc             	mov    -0x4(%ebp),%eax
 90a:	89 10                	mov    %edx,(%eax)
 90c:	eb 08                	jmp    916 <free+0xd7>
 90e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 911:	8b 55 f8             	mov    -0x8(%ebp),%edx
 914:	89 10                	mov    %edx,(%eax)
 916:	8b 45 fc             	mov    -0x4(%ebp),%eax
 919:	a3 48 0d 00 00       	mov    %eax,0xd48
 91e:	c9                   	leave  
 91f:	c3                   	ret    

00000920 <morecore>:
 920:	55                   	push   %ebp
 921:	89 e5                	mov    %esp,%ebp
 923:	83 ec 18             	sub    $0x18,%esp
 926:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 92d:	77 07                	ja     936 <morecore+0x16>
 92f:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 936:	8b 45 08             	mov    0x8(%ebp),%eax
 939:	c1 e0 03             	shl    $0x3,%eax
 93c:	83 ec 0c             	sub    $0xc,%esp
 93f:	50                   	push   %eax
 940:	e8 86 fc ff ff       	call   5cb <sbrk>
 945:	83 c4 10             	add    $0x10,%esp
 948:	89 45 f4             	mov    %eax,-0xc(%ebp)
 94b:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 94f:	75 07                	jne    958 <morecore+0x38>
 951:	b8 00 00 00 00       	mov    $0x0,%eax
 956:	eb 26                	jmp    97e <morecore+0x5e>
 958:	8b 45 f4             	mov    -0xc(%ebp),%eax
 95b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 95e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 961:	8b 55 08             	mov    0x8(%ebp),%edx
 964:	89 50 04             	mov    %edx,0x4(%eax)
 967:	8b 45 f0             	mov    -0x10(%ebp),%eax
 96a:	83 c0 08             	add    $0x8,%eax
 96d:	83 ec 0c             	sub    $0xc,%esp
 970:	50                   	push   %eax
 971:	e8 c9 fe ff ff       	call   83f <free>
 976:	83 c4 10             	add    $0x10,%esp
 979:	a1 48 0d 00 00       	mov    0xd48,%eax
 97e:	c9                   	leave  
 97f:	c3                   	ret    

00000980 <malloc>:
 980:	55                   	push   %ebp
 981:	89 e5                	mov    %esp,%ebp
 983:	83 ec 18             	sub    $0x18,%esp
 986:	8b 45 08             	mov    0x8(%ebp),%eax
 989:	83 c0 07             	add    $0x7,%eax
 98c:	c1 e8 03             	shr    $0x3,%eax
 98f:	40                   	inc    %eax
 990:	89 45 ec             	mov    %eax,-0x14(%ebp)
 993:	a1 48 0d 00 00       	mov    0xd48,%eax
 998:	89 45 f0             	mov    %eax,-0x10(%ebp)
 99b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 99f:	75 23                	jne    9c4 <malloc+0x44>
 9a1:	c7 45 f0 40 0d 00 00 	movl   $0xd40,-0x10(%ebp)
 9a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9ab:	a3 48 0d 00 00       	mov    %eax,0xd48
 9b0:	a1 48 0d 00 00       	mov    0xd48,%eax
 9b5:	a3 40 0d 00 00       	mov    %eax,0xd40
 9ba:	c7 05 44 0d 00 00 00 	movl   $0x0,0xd44
 9c1:	00 00 00 
 9c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9c7:	8b 00                	mov    (%eax),%eax
 9c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
 9cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9cf:	8b 40 04             	mov    0x4(%eax),%eax
 9d2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9d5:	72 4d                	jb     a24 <malloc+0xa4>
 9d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9da:	8b 40 04             	mov    0x4(%eax),%eax
 9dd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9e0:	75 0c                	jne    9ee <malloc+0x6e>
 9e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e5:	8b 10                	mov    (%eax),%edx
 9e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9ea:	89 10                	mov    %edx,(%eax)
 9ec:	eb 26                	jmp    a14 <malloc+0x94>
 9ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f1:	8b 40 04             	mov    0x4(%eax),%eax
 9f4:	2b 45 ec             	sub    -0x14(%ebp),%eax
 9f7:	89 c2                	mov    %eax,%edx
 9f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9fc:	89 50 04             	mov    %edx,0x4(%eax)
 9ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a02:	8b 40 04             	mov    0x4(%eax),%eax
 a05:	c1 e0 03             	shl    $0x3,%eax
 a08:	01 45 f4             	add    %eax,-0xc(%ebp)
 a0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a0e:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a11:	89 50 04             	mov    %edx,0x4(%eax)
 a14:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a17:	a3 48 0d 00 00       	mov    %eax,0xd48
 a1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a1f:	83 c0 08             	add    $0x8,%eax
 a22:	eb 3b                	jmp    a5f <malloc+0xdf>
 a24:	a1 48 0d 00 00       	mov    0xd48,%eax
 a29:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a2c:	75 1e                	jne    a4c <malloc+0xcc>
 a2e:	83 ec 0c             	sub    $0xc,%esp
 a31:	ff 75 ec             	pushl  -0x14(%ebp)
 a34:	e8 e7 fe ff ff       	call   920 <morecore>
 a39:	83 c4 10             	add    $0x10,%esp
 a3c:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a3f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a43:	75 07                	jne    a4c <malloc+0xcc>
 a45:	b8 00 00 00 00       	mov    $0x0,%eax
 a4a:	eb 13                	jmp    a5f <malloc+0xdf>
 a4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a4f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a52:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a55:	8b 00                	mov    (%eax),%eax
 a57:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a5a:	e9 6d ff ff ff       	jmp    9cc <malloc+0x4c>
 a5f:	c9                   	leave  
 a60:	c3                   	ret    
