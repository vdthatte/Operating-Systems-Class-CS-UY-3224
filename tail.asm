
_tail:     file format elf32-i386


Disassembly of section .text:

00000000 <countlines>:

char buf[1024];

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
  40:	68 00 04 00 00       	push   $0x400
  45:	68 a0 0d 00 00       	push   $0xda0
  4a:	ff 75 08             	pushl  0x8(%ebp)
  4d:	e8 1f 05 00 00       	call   571 <read>
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
  67:	68 77 0a 00 00       	push   $0xa77
  6c:	6a 01                	push   $0x1
  6e:	e8 58 06 00 00       	call   6cb <printf>
  73:	83 c4 10             	add    $0x10,%esp
    exit();
  76:	e8 de 04 00 00       	call   559 <exit>
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
  c2:	68 89 0a 00 00       	push   $0xa89
  c7:	6a 01                	push   $0x1
  c9:	e8 fd 05 00 00       	call   6cb <printf>
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
  f2:	68 8b 0a 00 00       	push   $0xa8b
  f7:	6a 01                	push   $0x1
  f9:	e8 cd 05 00 00       	call   6cb <printf>
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
 10f:	68 00 04 00 00       	push   $0x400
 114:	68 a0 0d 00 00       	push   $0xda0
 119:	ff 75 08             	pushl  0x8(%ebp)
 11c:	e8 50 04 00 00       	call   571 <read>
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
 13a:	68 8e 0a 00 00       	push   $0xa8e
 13f:	6a 01                	push   $0x1
 141:	e8 85 05 00 00       	call   6cb <printf>
 146:	83 c4 10             	add    $0x10,%esp
    exit();
 149:	e8 0b 04 00 00       	call   559 <exit>
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
 16a:	68 9e 0a 00 00       	push   $0xa9e
 16f:	e8 57 03 00 00       	call   4cb <atoi>
 174:	83 c4 10             	add    $0x10,%esp
 177:	88 45 f7             	mov    %al,-0x9(%ebp)
  int filePos = 1;
 17a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)

  if(argc <= 1){
 181:	83 3b 01             	cmpl   $0x1,(%ebx)
 184:	7f 18                	jg     19e <main+0x4b>
    pc(0, "", 0,0);
 186:	6a 00                	push   $0x0
 188:	6a 00                	push   $0x0
 18a:	68 a1 0a 00 00       	push   $0xaa1
 18f:	6a 00                	push   $0x0
 191:	e8 ea fe ff ff       	call   80 <pc>
 196:	83 c4 10             	add    $0x10,%esp
    exit();
 199:	e8 bb 03 00 00       	call   559 <exit>
  }
  
  if(argc == 3){
 19e:	83 3b 03             	cmpl   $0x3,(%ebx)
 1a1:	75 5a                	jne    1fd <main+0xaa>
    if(argv[2][0] == '-'){
 1a3:	8b 43 04             	mov    0x4(%ebx),%eax
 1a6:	83 c0 08             	add    $0x8,%eax
 1a9:	8b 00                	mov    (%eax),%eax
 1ab:	8a 00                	mov    (%eax),%al
 1ad:	3c 2d                	cmp    $0x2d,%al
 1af:	75 1f                	jne    1d0 <main+0x7d>
      num = atoi(&(argv[2][1]));
 1b1:	8b 43 04             	mov    0x4(%ebx),%eax
 1b4:	83 c0 08             	add    $0x8,%eax
 1b7:	8b 00                	mov    (%eax),%eax
 1b9:	40                   	inc    %eax
 1ba:	83 ec 0c             	sub    $0xc,%esp
 1bd:	50                   	push   %eax
 1be:	e8 08 03 00 00       	call   4cb <atoi>
 1c3:	83 c4 10             	add    $0x10,%esp
 1c6:	88 45 f7             	mov    %al,-0x9(%ebp)
      filePos = 1;
 1c9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    }
    if(argv[1][0] == '-'){
 1d0:	8b 43 04             	mov    0x4(%ebx),%eax
 1d3:	83 c0 04             	add    $0x4,%eax
 1d6:	8b 00                	mov    (%eax),%eax
 1d8:	8a 00                	mov    (%eax),%al
 1da:	3c 2d                	cmp    $0x2d,%al
 1dc:	75 1f                	jne    1fd <main+0xaa>
      num = atoi(&(argv[1][1]));
 1de:	8b 43 04             	mov    0x4(%ebx),%eax
 1e1:	83 c0 04             	add    $0x4,%eax
 1e4:	8b 00                	mov    (%eax),%eax
 1e6:	40                   	inc    %eax
 1e7:	83 ec 0c             	sub    $0xc,%esp
 1ea:	50                   	push   %eax
 1eb:	e8 db 02 00 00       	call   4cb <atoi>
 1f0:	83 c4 10             	add    $0x10,%esp
 1f3:	88 45 f7             	mov    %al,-0x9(%ebp)
      filePos = 2;
 1f6:	c7 45 f0 02 00 00 00 	movl   $0x2,-0x10(%ebp)
    }
  }

  if((fd = open(argv[filePos], 0)) < 0){
 1fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 200:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 207:	8b 43 04             	mov    0x4(%ebx),%eax
 20a:	01 d0                	add    %edx,%eax
 20c:	8b 00                	mov    (%eax),%eax
 20e:	83 ec 08             	sub    $0x8,%esp
 211:	6a 00                	push   $0x0
 213:	50                   	push   %eax
 214:	e8 80 03 00 00       	call   599 <open>
 219:	83 c4 10             	add    $0x10,%esp
 21c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 21f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 223:	79 29                	jns    24e <main+0xfb>
    printf(1, "tail: cannot open %s\n", argv[filePos]);
 225:	8b 45 f0             	mov    -0x10(%ebp),%eax
 228:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 22f:	8b 43 04             	mov    0x4(%ebx),%eax
 232:	01 d0                	add    %edx,%eax
 234:	8b 00                	mov    (%eax),%eax
 236:	83 ec 04             	sub    $0x4,%esp
 239:	50                   	push   %eax
 23a:	68 a2 0a 00 00       	push   $0xaa2
 23f:	6a 01                	push   $0x1
 241:	e8 85 04 00 00       	call   6cb <printf>
 246:	83 c4 10             	add    $0x10,%esp
    exit();
 249:	e8 0b 03 00 00       	call   559 <exit>
  }
  if((fd1 = open(argv[filePos], 0)) < 0){
 24e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 251:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 258:	8b 43 04             	mov    0x4(%ebx),%eax
 25b:	01 d0                	add    %edx,%eax
 25d:	8b 00                	mov    (%eax),%eax
 25f:	83 ec 08             	sub    $0x8,%esp
 262:	6a 00                	push   $0x0
 264:	50                   	push   %eax
 265:	e8 2f 03 00 00       	call   599 <open>
 26a:	83 c4 10             	add    $0x10,%esp
 26d:	89 45 e8             	mov    %eax,-0x18(%ebp)
 270:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
 274:	79 29                	jns    29f <main+0x14c>
    printf(1, "tail: cannot open %s\n", argv[filePos]);
 276:	8b 45 f0             	mov    -0x10(%ebp),%eax
 279:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 280:	8b 43 04             	mov    0x4(%ebx),%eax
 283:	01 d0                	add    %edx,%eax
 285:	8b 00                	mov    (%eax),%eax
 287:	83 ec 04             	sub    $0x4,%esp
 28a:	50                   	push   %eax
 28b:	68 a2 0a 00 00       	push   $0xaa2
 290:	6a 01                	push   $0x1
 292:	e8 34 04 00 00       	call   6cb <printf>
 297:	83 c4 10             	add    $0x10,%esp
    exit();
 29a:	e8 ba 02 00 00       	call   559 <exit>
  }
  int numOfL = countlines(fd, argv[filePos]);
 29f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 2a2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 2a9:	8b 43 04             	mov    0x4(%ebx),%eax
 2ac:	01 d0                	add    %edx,%eax
 2ae:	8b 00                	mov    (%eax),%eax
 2b0:	83 ec 08             	sub    $0x8,%esp
 2b3:	50                   	push   %eax
 2b4:	ff 75 ec             	pushl  -0x14(%ebp)
 2b7:	e8 44 fd ff ff       	call   0 <countlines>
 2bc:	83 c4 10             	add    $0x10,%esp
 2bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  printf(1, "%d\n",pc(fd1, argv[filePos], numOfL, num));
 2c2:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
 2c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 2c9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
 2d0:	8b 43 04             	mov    0x4(%ebx),%eax
 2d3:	01 c8                	add    %ecx,%eax
 2d5:	8b 00                	mov    (%eax),%eax
 2d7:	52                   	push   %edx
 2d8:	ff 75 e4             	pushl  -0x1c(%ebp)
 2db:	50                   	push   %eax
 2dc:	ff 75 e8             	pushl  -0x18(%ebp)
 2df:	e8 9c fd ff ff       	call   80 <pc>
 2e4:	83 c4 10             	add    $0x10,%esp
 2e7:	83 ec 04             	sub    $0x4,%esp
 2ea:	50                   	push   %eax
 2eb:	68 b8 0a 00 00       	push   $0xab8
 2f0:	6a 01                	push   $0x1
 2f2:	e8 d4 03 00 00       	call   6cb <printf>
 2f7:	83 c4 10             	add    $0x10,%esp
  close(fd1);
 2fa:	83 ec 0c             	sub    $0xc,%esp
 2fd:	ff 75 e8             	pushl  -0x18(%ebp)
 300:	e8 7c 02 00 00       	call   581 <close>
 305:	83 c4 10             	add    $0x10,%esp
  close(fd);
 308:	83 ec 0c             	sub    $0xc,%esp
 30b:	ff 75 ec             	pushl  -0x14(%ebp)
 30e:	e8 6e 02 00 00       	call   581 <close>
 313:	83 c4 10             	add    $0x10,%esp
      
     
  
  exit();
 316:	e8 3e 02 00 00       	call   559 <exit>

0000031b <stosb>:
 31b:	55                   	push   %ebp
 31c:	89 e5                	mov    %esp,%ebp
 31e:	57                   	push   %edi
 31f:	53                   	push   %ebx
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
 33c:	5b                   	pop    %ebx
 33d:	5f                   	pop    %edi
 33e:	5d                   	pop    %ebp
 33f:	c3                   	ret    

00000340 <strcpy>:
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	83 ec 10             	sub    $0x10,%esp
 346:	8b 45 08             	mov    0x8(%ebp),%eax
 349:	89 45 fc             	mov    %eax,-0x4(%ebp)
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
 369:	8b 45 fc             	mov    -0x4(%ebp),%eax
 36c:	c9                   	leave  
 36d:	c3                   	ret    

0000036e <strcmp>:
 36e:	55                   	push   %ebp
 36f:	89 e5                	mov    %esp,%ebp
 371:	eb 06                	jmp    379 <strcmp+0xb>
 373:	ff 45 08             	incl   0x8(%ebp)
 376:	ff 45 0c             	incl   0xc(%ebp)
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
 390:	8b 45 08             	mov    0x8(%ebp),%eax
 393:	8a 00                	mov    (%eax),%al
 395:	0f b6 d0             	movzbl %al,%edx
 398:	8b 45 0c             	mov    0xc(%ebp),%eax
 39b:	8a 00                	mov    (%eax),%al
 39d:	0f b6 c0             	movzbl %al,%eax
 3a0:	29 c2                	sub    %eax,%edx
 3a2:	89 d0                	mov    %edx,%eax
 3a4:	5d                   	pop    %ebp
 3a5:	c3                   	ret    

000003a6 <strlen>:
 3a6:	55                   	push   %ebp
 3a7:	89 e5                	mov    %esp,%ebp
 3a9:	83 ec 10             	sub    $0x10,%esp
 3ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3b3:	eb 03                	jmp    3b8 <strlen+0x12>
 3b5:	ff 45 fc             	incl   -0x4(%ebp)
 3b8:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3bb:	8b 45 08             	mov    0x8(%ebp),%eax
 3be:	01 d0                	add    %edx,%eax
 3c0:	8a 00                	mov    (%eax),%al
 3c2:	84 c0                	test   %al,%al
 3c4:	75 ef                	jne    3b5 <strlen+0xf>
 3c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3c9:	c9                   	leave  
 3ca:	c3                   	ret    

000003cb <memset>:
 3cb:	55                   	push   %ebp
 3cc:	89 e5                	mov    %esp,%ebp
 3ce:	8b 45 10             	mov    0x10(%ebp),%eax
 3d1:	50                   	push   %eax
 3d2:	ff 75 0c             	pushl  0xc(%ebp)
 3d5:	ff 75 08             	pushl  0x8(%ebp)
 3d8:	e8 3e ff ff ff       	call   31b <stosb>
 3dd:	83 c4 0c             	add    $0xc,%esp
 3e0:	8b 45 08             	mov    0x8(%ebp),%eax
 3e3:	c9                   	leave  
 3e4:	c3                   	ret    

000003e5 <strchr>:
 3e5:	55                   	push   %ebp
 3e6:	89 e5                	mov    %esp,%ebp
 3e8:	83 ec 04             	sub    $0x4,%esp
 3eb:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ee:	88 45 fc             	mov    %al,-0x4(%ebp)
 3f1:	eb 12                	jmp    405 <strchr+0x20>
 3f3:	8b 45 08             	mov    0x8(%ebp),%eax
 3f6:	8a 00                	mov    (%eax),%al
 3f8:	3a 45 fc             	cmp    -0x4(%ebp),%al
 3fb:	75 05                	jne    402 <strchr+0x1d>
 3fd:	8b 45 08             	mov    0x8(%ebp),%eax
 400:	eb 11                	jmp    413 <strchr+0x2e>
 402:	ff 45 08             	incl   0x8(%ebp)
 405:	8b 45 08             	mov    0x8(%ebp),%eax
 408:	8a 00                	mov    (%eax),%al
 40a:	84 c0                	test   %al,%al
 40c:	75 e5                	jne    3f3 <strchr+0xe>
 40e:	b8 00 00 00 00       	mov    $0x0,%eax
 413:	c9                   	leave  
 414:	c3                   	ret    

00000415 <gets>:
 415:	55                   	push   %ebp
 416:	89 e5                	mov    %esp,%ebp
 418:	83 ec 18             	sub    $0x18,%esp
 41b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 422:	eb 41                	jmp    465 <gets+0x50>
 424:	83 ec 04             	sub    $0x4,%esp
 427:	6a 01                	push   $0x1
 429:	8d 45 ef             	lea    -0x11(%ebp),%eax
 42c:	50                   	push   %eax
 42d:	6a 00                	push   $0x0
 42f:	e8 3d 01 00 00       	call   571 <read>
 434:	83 c4 10             	add    $0x10,%esp
 437:	89 45 f0             	mov    %eax,-0x10(%ebp)
 43a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 43e:	7f 02                	jg     442 <gets+0x2d>
 440:	eb 2c                	jmp    46e <gets+0x59>
 442:	8b 45 f4             	mov    -0xc(%ebp),%eax
 445:	8d 50 01             	lea    0x1(%eax),%edx
 448:	89 55 f4             	mov    %edx,-0xc(%ebp)
 44b:	89 c2                	mov    %eax,%edx
 44d:	8b 45 08             	mov    0x8(%ebp),%eax
 450:	01 c2                	add    %eax,%edx
 452:	8a 45 ef             	mov    -0x11(%ebp),%al
 455:	88 02                	mov    %al,(%edx)
 457:	8a 45 ef             	mov    -0x11(%ebp),%al
 45a:	3c 0a                	cmp    $0xa,%al
 45c:	74 10                	je     46e <gets+0x59>
 45e:	8a 45 ef             	mov    -0x11(%ebp),%al
 461:	3c 0d                	cmp    $0xd,%al
 463:	74 09                	je     46e <gets+0x59>
 465:	8b 45 f4             	mov    -0xc(%ebp),%eax
 468:	40                   	inc    %eax
 469:	3b 45 0c             	cmp    0xc(%ebp),%eax
 46c:	7c b6                	jl     424 <gets+0xf>
 46e:	8b 55 f4             	mov    -0xc(%ebp),%edx
 471:	8b 45 08             	mov    0x8(%ebp),%eax
 474:	01 d0                	add    %edx,%eax
 476:	c6 00 00             	movb   $0x0,(%eax)
 479:	8b 45 08             	mov    0x8(%ebp),%eax
 47c:	c9                   	leave  
 47d:	c3                   	ret    

0000047e <stat>:
 47e:	55                   	push   %ebp
 47f:	89 e5                	mov    %esp,%ebp
 481:	83 ec 18             	sub    $0x18,%esp
 484:	83 ec 08             	sub    $0x8,%esp
 487:	6a 00                	push   $0x0
 489:	ff 75 08             	pushl  0x8(%ebp)
 48c:	e8 08 01 00 00       	call   599 <open>
 491:	83 c4 10             	add    $0x10,%esp
 494:	89 45 f4             	mov    %eax,-0xc(%ebp)
 497:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 49b:	79 07                	jns    4a4 <stat+0x26>
 49d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4a2:	eb 25                	jmp    4c9 <stat+0x4b>
 4a4:	83 ec 08             	sub    $0x8,%esp
 4a7:	ff 75 0c             	pushl  0xc(%ebp)
 4aa:	ff 75 f4             	pushl  -0xc(%ebp)
 4ad:	e8 ff 00 00 00       	call   5b1 <fstat>
 4b2:	83 c4 10             	add    $0x10,%esp
 4b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 4b8:	83 ec 0c             	sub    $0xc,%esp
 4bb:	ff 75 f4             	pushl  -0xc(%ebp)
 4be:	e8 be 00 00 00       	call   581 <close>
 4c3:	83 c4 10             	add    $0x10,%esp
 4c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4c9:	c9                   	leave  
 4ca:	c3                   	ret    

000004cb <atoi>:
 4cb:	55                   	push   %ebp
 4cc:	89 e5                	mov    %esp,%ebp
 4ce:	83 ec 10             	sub    $0x10,%esp
 4d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 4d8:	eb 24                	jmp    4fe <atoi+0x33>
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
 4fe:	8b 45 08             	mov    0x8(%ebp),%eax
 501:	8a 00                	mov    (%eax),%al
 503:	3c 2f                	cmp    $0x2f,%al
 505:	7e 09                	jle    510 <atoi+0x45>
 507:	8b 45 08             	mov    0x8(%ebp),%eax
 50a:	8a 00                	mov    (%eax),%al
 50c:	3c 39                	cmp    $0x39,%al
 50e:	7e ca                	jle    4da <atoi+0xf>
 510:	8b 45 fc             	mov    -0x4(%ebp),%eax
 513:	c9                   	leave  
 514:	c3                   	ret    

00000515 <memmove>:
 515:	55                   	push   %ebp
 516:	89 e5                	mov    %esp,%ebp
 518:	83 ec 10             	sub    $0x10,%esp
 51b:	8b 45 08             	mov    0x8(%ebp),%eax
 51e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 521:	8b 45 0c             	mov    0xc(%ebp),%eax
 524:	89 45 f8             	mov    %eax,-0x8(%ebp)
 527:	eb 16                	jmp    53f <memmove+0x2a>
 529:	8b 45 fc             	mov    -0x4(%ebp),%eax
 52c:	8d 50 01             	lea    0x1(%eax),%edx
 52f:	89 55 fc             	mov    %edx,-0x4(%ebp)
 532:	8b 55 f8             	mov    -0x8(%ebp),%edx
 535:	8d 4a 01             	lea    0x1(%edx),%ecx
 538:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 53b:	8a 12                	mov    (%edx),%dl
 53d:	88 10                	mov    %dl,(%eax)
 53f:	8b 45 10             	mov    0x10(%ebp),%eax
 542:	8d 50 ff             	lea    -0x1(%eax),%edx
 545:	89 55 10             	mov    %edx,0x10(%ebp)
 548:	85 c0                	test   %eax,%eax
 54a:	7f dd                	jg     529 <memmove+0x14>
 54c:	8b 45 08             	mov    0x8(%ebp),%eax
 54f:	c9                   	leave  
 550:	c3                   	ret    

00000551 <fork>:
 551:	b8 01 00 00 00       	mov    $0x1,%eax
 556:	cd 40                	int    $0x40
 558:	c3                   	ret    

00000559 <exit>:
 559:	b8 02 00 00 00       	mov    $0x2,%eax
 55e:	cd 40                	int    $0x40
 560:	c3                   	ret    

00000561 <wait>:
 561:	b8 03 00 00 00       	mov    $0x3,%eax
 566:	cd 40                	int    $0x40
 568:	c3                   	ret    

00000569 <pipe>:
 569:	b8 04 00 00 00       	mov    $0x4,%eax
 56e:	cd 40                	int    $0x40
 570:	c3                   	ret    

00000571 <read>:
 571:	b8 05 00 00 00       	mov    $0x5,%eax
 576:	cd 40                	int    $0x40
 578:	c3                   	ret    

00000579 <write>:
 579:	b8 10 00 00 00       	mov    $0x10,%eax
 57e:	cd 40                	int    $0x40
 580:	c3                   	ret    

00000581 <close>:
 581:	b8 15 00 00 00       	mov    $0x15,%eax
 586:	cd 40                	int    $0x40
 588:	c3                   	ret    

00000589 <kill>:
 589:	b8 06 00 00 00       	mov    $0x6,%eax
 58e:	cd 40                	int    $0x40
 590:	c3                   	ret    

00000591 <exec>:
 591:	b8 07 00 00 00       	mov    $0x7,%eax
 596:	cd 40                	int    $0x40
 598:	c3                   	ret    

00000599 <open>:
 599:	b8 0f 00 00 00       	mov    $0xf,%eax
 59e:	cd 40                	int    $0x40
 5a0:	c3                   	ret    

000005a1 <mknod>:
 5a1:	b8 11 00 00 00       	mov    $0x11,%eax
 5a6:	cd 40                	int    $0x40
 5a8:	c3                   	ret    

000005a9 <unlink>:
 5a9:	b8 12 00 00 00       	mov    $0x12,%eax
 5ae:	cd 40                	int    $0x40
 5b0:	c3                   	ret    

000005b1 <fstat>:
 5b1:	b8 08 00 00 00       	mov    $0x8,%eax
 5b6:	cd 40                	int    $0x40
 5b8:	c3                   	ret    

000005b9 <link>:
 5b9:	b8 13 00 00 00       	mov    $0x13,%eax
 5be:	cd 40                	int    $0x40
 5c0:	c3                   	ret    

000005c1 <mkdir>:
 5c1:	b8 14 00 00 00       	mov    $0x14,%eax
 5c6:	cd 40                	int    $0x40
 5c8:	c3                   	ret    

000005c9 <chdir>:
 5c9:	b8 09 00 00 00       	mov    $0x9,%eax
 5ce:	cd 40                	int    $0x40
 5d0:	c3                   	ret    

000005d1 <dup>:
 5d1:	b8 0a 00 00 00       	mov    $0xa,%eax
 5d6:	cd 40                	int    $0x40
 5d8:	c3                   	ret    

000005d9 <getpid>:
 5d9:	b8 0b 00 00 00       	mov    $0xb,%eax
 5de:	cd 40                	int    $0x40
 5e0:	c3                   	ret    

000005e1 <sbrk>:
 5e1:	b8 0c 00 00 00       	mov    $0xc,%eax
 5e6:	cd 40                	int    $0x40
 5e8:	c3                   	ret    

000005e9 <sleep>:
 5e9:	b8 0d 00 00 00       	mov    $0xd,%eax
 5ee:	cd 40                	int    $0x40
 5f0:	c3                   	ret    

000005f1 <uptime>:
 5f1:	b8 0e 00 00 00       	mov    $0xe,%eax
 5f6:	cd 40                	int    $0x40
 5f8:	c3                   	ret    

000005f9 <putc>:
 5f9:	55                   	push   %ebp
 5fa:	89 e5                	mov    %esp,%ebp
 5fc:	83 ec 18             	sub    $0x18,%esp
 5ff:	8b 45 0c             	mov    0xc(%ebp),%eax
 602:	88 45 f4             	mov    %al,-0xc(%ebp)
 605:	83 ec 04             	sub    $0x4,%esp
 608:	6a 01                	push   $0x1
 60a:	8d 45 f4             	lea    -0xc(%ebp),%eax
 60d:	50                   	push   %eax
 60e:	ff 75 08             	pushl  0x8(%ebp)
 611:	e8 63 ff ff ff       	call   579 <write>
 616:	83 c4 10             	add    $0x10,%esp
 619:	c9                   	leave  
 61a:	c3                   	ret    

0000061b <printint>:
 61b:	55                   	push   %ebp
 61c:	89 e5                	mov    %esp,%ebp
 61e:	53                   	push   %ebx
 61f:	83 ec 24             	sub    $0x24,%esp
 622:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 629:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 62d:	74 17                	je     646 <printint+0x2b>
 62f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 633:	79 11                	jns    646 <printint+0x2b>
 635:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 63c:	8b 45 0c             	mov    0xc(%ebp),%eax
 63f:	f7 d8                	neg    %eax
 641:	89 45 ec             	mov    %eax,-0x14(%ebp)
 644:	eb 06                	jmp    64c <printint+0x31>
 646:	8b 45 0c             	mov    0xc(%ebp),%eax
 649:	89 45 ec             	mov    %eax,-0x14(%ebp)
 64c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 653:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 656:	8d 41 01             	lea    0x1(%ecx),%eax
 659:	89 45 f4             	mov    %eax,-0xc(%ebp)
 65c:	8b 5d 10             	mov    0x10(%ebp),%ebx
 65f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 662:	ba 00 00 00 00       	mov    $0x0,%edx
 667:	f7 f3                	div    %ebx
 669:	89 d0                	mov    %edx,%eax
 66b:	8a 80 50 0d 00 00    	mov    0xd50(%eax),%al
 671:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
 675:	8b 5d 10             	mov    0x10(%ebp),%ebx
 678:	8b 45 ec             	mov    -0x14(%ebp),%eax
 67b:	ba 00 00 00 00       	mov    $0x0,%edx
 680:	f7 f3                	div    %ebx
 682:	89 45 ec             	mov    %eax,-0x14(%ebp)
 685:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 689:	75 c8                	jne    653 <printint+0x38>
 68b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 68f:	74 0e                	je     69f <printint+0x84>
 691:	8b 45 f4             	mov    -0xc(%ebp),%eax
 694:	8d 50 01             	lea    0x1(%eax),%edx
 697:	89 55 f4             	mov    %edx,-0xc(%ebp)
 69a:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
 69f:	eb 1c                	jmp    6bd <printint+0xa2>
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
 6bd:	ff 4d f4             	decl   -0xc(%ebp)
 6c0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6c4:	79 db                	jns    6a1 <printint+0x86>
 6c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6c9:	c9                   	leave  
 6ca:	c3                   	ret    

000006cb <printf>:
 6cb:	55                   	push   %ebp
 6cc:	89 e5                	mov    %esp,%ebp
 6ce:	83 ec 28             	sub    $0x28,%esp
 6d1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 6d8:	8d 45 0c             	lea    0xc(%ebp),%eax
 6db:	83 c0 04             	add    $0x4,%eax
 6de:	89 45 e8             	mov    %eax,-0x18(%ebp)
 6e1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 6e8:	e9 54 01 00 00       	jmp    841 <printf+0x176>
 6ed:	8b 55 0c             	mov    0xc(%ebp),%edx
 6f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f3:	01 d0                	add    %edx,%eax
 6f5:	8a 00                	mov    (%eax),%al
 6f7:	0f be c0             	movsbl %al,%eax
 6fa:	25 ff 00 00 00       	and    $0xff,%eax
 6ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 702:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 706:	75 2c                	jne    734 <printf+0x69>
 708:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 70c:	75 0c                	jne    71a <printf+0x4f>
 70e:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 715:	e9 24 01 00 00       	jmp    83e <printf+0x173>
 71a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 71d:	0f be c0             	movsbl %al,%eax
 720:	83 ec 08             	sub    $0x8,%esp
 723:	50                   	push   %eax
 724:	ff 75 08             	pushl  0x8(%ebp)
 727:	e8 cd fe ff ff       	call   5f9 <putc>
 72c:	83 c4 10             	add    $0x10,%esp
 72f:	e9 0a 01 00 00       	jmp    83e <printf+0x173>
 734:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 738:	0f 85 00 01 00 00    	jne    83e <printf+0x173>
 73e:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 742:	75 1e                	jne    762 <printf+0x97>
 744:	8b 45 e8             	mov    -0x18(%ebp),%eax
 747:	8b 00                	mov    (%eax),%eax
 749:	6a 01                	push   $0x1
 74b:	6a 0a                	push   $0xa
 74d:	50                   	push   %eax
 74e:	ff 75 08             	pushl  0x8(%ebp)
 751:	e8 c5 fe ff ff       	call   61b <printint>
 756:	83 c4 10             	add    $0x10,%esp
 759:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 75d:	e9 d5 00 00 00       	jmp    837 <printf+0x16c>
 762:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 766:	74 06                	je     76e <printf+0xa3>
 768:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 76c:	75 1e                	jne    78c <printf+0xc1>
 76e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 771:	8b 00                	mov    (%eax),%eax
 773:	6a 00                	push   $0x0
 775:	6a 10                	push   $0x10
 777:	50                   	push   %eax
 778:	ff 75 08             	pushl  0x8(%ebp)
 77b:	e8 9b fe ff ff       	call   61b <printint>
 780:	83 c4 10             	add    $0x10,%esp
 783:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 787:	e9 ab 00 00 00       	jmp    837 <printf+0x16c>
 78c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 790:	75 40                	jne    7d2 <printf+0x107>
 792:	8b 45 e8             	mov    -0x18(%ebp),%eax
 795:	8b 00                	mov    (%eax),%eax
 797:	89 45 f4             	mov    %eax,-0xc(%ebp)
 79a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 79e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7a2:	75 07                	jne    7ab <printf+0xe0>
 7a4:	c7 45 f4 bc 0a 00 00 	movl   $0xabc,-0xc(%ebp)
 7ab:	eb 1a                	jmp    7c7 <printf+0xfc>
 7ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b0:	8a 00                	mov    (%eax),%al
 7b2:	0f be c0             	movsbl %al,%eax
 7b5:	83 ec 08             	sub    $0x8,%esp
 7b8:	50                   	push   %eax
 7b9:	ff 75 08             	pushl  0x8(%ebp)
 7bc:	e8 38 fe ff ff       	call   5f9 <putc>
 7c1:	83 c4 10             	add    $0x10,%esp
 7c4:	ff 45 f4             	incl   -0xc(%ebp)
 7c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ca:	8a 00                	mov    (%eax),%al
 7cc:	84 c0                	test   %al,%al
 7ce:	75 dd                	jne    7ad <printf+0xe2>
 7d0:	eb 65                	jmp    837 <printf+0x16c>
 7d2:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 7d6:	75 1d                	jne    7f5 <printf+0x12a>
 7d8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7db:	8b 00                	mov    (%eax),%eax
 7dd:	0f be c0             	movsbl %al,%eax
 7e0:	83 ec 08             	sub    $0x8,%esp
 7e3:	50                   	push   %eax
 7e4:	ff 75 08             	pushl  0x8(%ebp)
 7e7:	e8 0d fe ff ff       	call   5f9 <putc>
 7ec:	83 c4 10             	add    $0x10,%esp
 7ef:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7f3:	eb 42                	jmp    837 <printf+0x16c>
 7f5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7f9:	75 17                	jne    812 <printf+0x147>
 7fb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7fe:	0f be c0             	movsbl %al,%eax
 801:	83 ec 08             	sub    $0x8,%esp
 804:	50                   	push   %eax
 805:	ff 75 08             	pushl  0x8(%ebp)
 808:	e8 ec fd ff ff       	call   5f9 <putc>
 80d:	83 c4 10             	add    $0x10,%esp
 810:	eb 25                	jmp    837 <printf+0x16c>
 812:	83 ec 08             	sub    $0x8,%esp
 815:	6a 25                	push   $0x25
 817:	ff 75 08             	pushl  0x8(%ebp)
 81a:	e8 da fd ff ff       	call   5f9 <putc>
 81f:	83 c4 10             	add    $0x10,%esp
 822:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 825:	0f be c0             	movsbl %al,%eax
 828:	83 ec 08             	sub    $0x8,%esp
 82b:	50                   	push   %eax
 82c:	ff 75 08             	pushl  0x8(%ebp)
 82f:	e8 c5 fd ff ff       	call   5f9 <putc>
 834:	83 c4 10             	add    $0x10,%esp
 837:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 83e:	ff 45 f0             	incl   -0x10(%ebp)
 841:	8b 55 0c             	mov    0xc(%ebp),%edx
 844:	8b 45 f0             	mov    -0x10(%ebp),%eax
 847:	01 d0                	add    %edx,%eax
 849:	8a 00                	mov    (%eax),%al
 84b:	84 c0                	test   %al,%al
 84d:	0f 85 9a fe ff ff    	jne    6ed <printf+0x22>
 853:	c9                   	leave  
 854:	c3                   	ret    

00000855 <free>:
 855:	55                   	push   %ebp
 856:	89 e5                	mov    %esp,%ebp
 858:	83 ec 10             	sub    $0x10,%esp
 85b:	8b 45 08             	mov    0x8(%ebp),%eax
 85e:	83 e8 08             	sub    $0x8,%eax
 861:	89 45 f8             	mov    %eax,-0x8(%ebp)
 864:	a1 88 0d 00 00       	mov    0xd88,%eax
 869:	89 45 fc             	mov    %eax,-0x4(%ebp)
 86c:	eb 24                	jmp    892 <free+0x3d>
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
 8a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8a7:	8b 40 04             	mov    0x4(%eax),%eax
 8aa:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8b4:	01 c2                	add    %eax,%edx
 8b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8b9:	8b 00                	mov    (%eax),%eax
 8bb:	39 c2                	cmp    %eax,%edx
 8bd:	75 24                	jne    8e3 <free+0x8e>
 8bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8c2:	8b 50 04             	mov    0x4(%eax),%edx
 8c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c8:	8b 00                	mov    (%eax),%eax
 8ca:	8b 40 04             	mov    0x4(%eax),%eax
 8cd:	01 c2                	add    %eax,%edx
 8cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8d2:	89 50 04             	mov    %edx,0x4(%eax)
 8d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d8:	8b 00                	mov    (%eax),%eax
 8da:	8b 10                	mov    (%eax),%edx
 8dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8df:	89 10                	mov    %edx,(%eax)
 8e1:	eb 0a                	jmp    8ed <free+0x98>
 8e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e6:	8b 10                	mov    (%eax),%edx
 8e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8eb:	89 10                	mov    %edx,(%eax)
 8ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f0:	8b 40 04             	mov    0x4(%eax),%eax
 8f3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8fd:	01 d0                	add    %edx,%eax
 8ff:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 902:	75 20                	jne    924 <free+0xcf>
 904:	8b 45 fc             	mov    -0x4(%ebp),%eax
 907:	8b 50 04             	mov    0x4(%eax),%edx
 90a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 90d:	8b 40 04             	mov    0x4(%eax),%eax
 910:	01 c2                	add    %eax,%edx
 912:	8b 45 fc             	mov    -0x4(%ebp),%eax
 915:	89 50 04             	mov    %edx,0x4(%eax)
 918:	8b 45 f8             	mov    -0x8(%ebp),%eax
 91b:	8b 10                	mov    (%eax),%edx
 91d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 920:	89 10                	mov    %edx,(%eax)
 922:	eb 08                	jmp    92c <free+0xd7>
 924:	8b 45 fc             	mov    -0x4(%ebp),%eax
 927:	8b 55 f8             	mov    -0x8(%ebp),%edx
 92a:	89 10                	mov    %edx,(%eax)
 92c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 92f:	a3 88 0d 00 00       	mov    %eax,0xd88
 934:	c9                   	leave  
 935:	c3                   	ret    

00000936 <morecore>:
 936:	55                   	push   %ebp
 937:	89 e5                	mov    %esp,%ebp
 939:	83 ec 18             	sub    $0x18,%esp
 93c:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 943:	77 07                	ja     94c <morecore+0x16>
 945:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 94c:	8b 45 08             	mov    0x8(%ebp),%eax
 94f:	c1 e0 03             	shl    $0x3,%eax
 952:	83 ec 0c             	sub    $0xc,%esp
 955:	50                   	push   %eax
 956:	e8 86 fc ff ff       	call   5e1 <sbrk>
 95b:	83 c4 10             	add    $0x10,%esp
 95e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 961:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 965:	75 07                	jne    96e <morecore+0x38>
 967:	b8 00 00 00 00       	mov    $0x0,%eax
 96c:	eb 26                	jmp    994 <morecore+0x5e>
 96e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 971:	89 45 f0             	mov    %eax,-0x10(%ebp)
 974:	8b 45 f0             	mov    -0x10(%ebp),%eax
 977:	8b 55 08             	mov    0x8(%ebp),%edx
 97a:	89 50 04             	mov    %edx,0x4(%eax)
 97d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 980:	83 c0 08             	add    $0x8,%eax
 983:	83 ec 0c             	sub    $0xc,%esp
 986:	50                   	push   %eax
 987:	e8 c9 fe ff ff       	call   855 <free>
 98c:	83 c4 10             	add    $0x10,%esp
 98f:	a1 88 0d 00 00       	mov    0xd88,%eax
 994:	c9                   	leave  
 995:	c3                   	ret    

00000996 <malloc>:
 996:	55                   	push   %ebp
 997:	89 e5                	mov    %esp,%ebp
 999:	83 ec 18             	sub    $0x18,%esp
 99c:	8b 45 08             	mov    0x8(%ebp),%eax
 99f:	83 c0 07             	add    $0x7,%eax
 9a2:	c1 e8 03             	shr    $0x3,%eax
 9a5:	40                   	inc    %eax
 9a6:	89 45 ec             	mov    %eax,-0x14(%ebp)
 9a9:	a1 88 0d 00 00       	mov    0xd88,%eax
 9ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9b1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 9b5:	75 23                	jne    9da <malloc+0x44>
 9b7:	c7 45 f0 80 0d 00 00 	movl   $0xd80,-0x10(%ebp)
 9be:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9c1:	a3 88 0d 00 00       	mov    %eax,0xd88
 9c6:	a1 88 0d 00 00       	mov    0xd88,%eax
 9cb:	a3 80 0d 00 00       	mov    %eax,0xd80
 9d0:	c7 05 84 0d 00 00 00 	movl   $0x0,0xd84
 9d7:	00 00 00 
 9da:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9dd:	8b 00                	mov    (%eax),%eax
 9df:	89 45 f4             	mov    %eax,-0xc(%ebp)
 9e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e5:	8b 40 04             	mov    0x4(%eax),%eax
 9e8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9eb:	72 4d                	jb     a3a <malloc+0xa4>
 9ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f0:	8b 40 04             	mov    0x4(%eax),%eax
 9f3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 9f6:	75 0c                	jne    a04 <malloc+0x6e>
 9f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9fb:	8b 10                	mov    (%eax),%edx
 9fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a00:	89 10                	mov    %edx,(%eax)
 a02:	eb 26                	jmp    a2a <malloc+0x94>
 a04:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a07:	8b 40 04             	mov    0x4(%eax),%eax
 a0a:	2b 45 ec             	sub    -0x14(%ebp),%eax
 a0d:	89 c2                	mov    %eax,%edx
 a0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a12:	89 50 04             	mov    %edx,0x4(%eax)
 a15:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a18:	8b 40 04             	mov    0x4(%eax),%eax
 a1b:	c1 e0 03             	shl    $0x3,%eax
 a1e:	01 45 f4             	add    %eax,-0xc(%ebp)
 a21:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a24:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a27:	89 50 04             	mov    %edx,0x4(%eax)
 a2a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a2d:	a3 88 0d 00 00       	mov    %eax,0xd88
 a32:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a35:	83 c0 08             	add    $0x8,%eax
 a38:	eb 3b                	jmp    a75 <malloc+0xdf>
 a3a:	a1 88 0d 00 00       	mov    0xd88,%eax
 a3f:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a42:	75 1e                	jne    a62 <malloc+0xcc>
 a44:	83 ec 0c             	sub    $0xc,%esp
 a47:	ff 75 ec             	pushl  -0x14(%ebp)
 a4a:	e8 e7 fe ff ff       	call   936 <morecore>
 a4f:	83 c4 10             	add    $0x10,%esp
 a52:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a55:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a59:	75 07                	jne    a62 <malloc+0xcc>
 a5b:	b8 00 00 00 00       	mov    $0x0,%eax
 a60:	eb 13                	jmp    a75 <malloc+0xdf>
 a62:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a65:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a68:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a6b:	8b 00                	mov    (%eax),%eax
 a6d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a70:	e9 6d ff ff ff       	jmp    9e2 <malloc+0x4c>
 a75:	c9                   	leave  
 a76:	c3                   	ret    
