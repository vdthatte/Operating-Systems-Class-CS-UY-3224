
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
  31:	05 20 0c 00 00       	add    $0xc20,%eax
  36:	8a 00                	mov    (%eax),%al
  38:	3c 0a                	cmp    $0xa,%al
  3a:	75 03                	jne    3f <wc+0x3f>
        l++;
  3c:	ff 45 f0             	incl   -0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
  3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  42:	05 20 0c 00 00       	add    $0xc20,%eax
  47:	8a 00                	mov    (%eax),%al
  49:	0f be c0             	movsbl %al,%eax
  4c:	83 ec 08             	sub    $0x8,%esp
  4f:	50                   	push   %eax
  50:	68 30 09 00 00       	push   $0x930
  55:	e8 44 02 00 00       	call   29e <strchr>
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
  8d:	68 20 0c 00 00       	push   $0xc20
  92:	ff 75 08             	pushl  0x8(%ebp)
  95:	e8 90 03 00 00       	call   42a <read>
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
  b3:	68 36 09 00 00       	push   $0x936
  b8:	6a 01                	push   $0x1
  ba:	e8 c5 04 00 00       	call   584 <printf>
  bf:	83 c4 10             	add    $0x10,%esp
    exit();
  c2:	e8 4b 03 00 00       	call   412 <exit>
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
  c7:	83 ec 08             	sub    $0x8,%esp
  ca:	ff 75 0c             	pushl  0xc(%ebp)
  cd:	ff 75 e8             	pushl  -0x18(%ebp)
  d0:	ff 75 ec             	pushl  -0x14(%ebp)
  d3:	ff 75 f0             	pushl  -0x10(%ebp)
  d6:	68 46 09 00 00       	push   $0x946
  db:	6a 01                	push   $0x1
  dd:	e8 a2 04 00 00       	call   584 <printf>
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
 103:	68 53 09 00 00       	push   $0x953
 108:	6a 00                	push   $0x0
 10a:	e8 f1 fe ff ff       	call   0 <wc>
 10f:	83 c4 10             	add    $0x10,%esp
    exit();
 112:	e8 fb 02 00 00       	call   412 <exit>
  }

  for(i = 1; i < argc; i++){
 117:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
 11e:	e9 a1 00 00 00       	jmp    1c4 <main+0xdd>
    printf(1,argv[i]);
 123:	8b 45 f4             	mov    -0xc(%ebp),%eax
 126:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 12d:	8b 43 04             	mov    0x4(%ebx),%eax
 130:	01 d0                	add    %edx,%eax
 132:	8b 00                	mov    (%eax),%eax
 134:	83 ec 08             	sub    $0x8,%esp
 137:	50                   	push   %eax
 138:	6a 01                	push   $0x1
 13a:	e8 45 04 00 00       	call   584 <printf>
 13f:	83 c4 10             	add    $0x10,%esp
    if((fd = open(argv[i], 0)) < 0){
 142:	8b 45 f4             	mov    -0xc(%ebp),%eax
 145:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 14c:	8b 43 04             	mov    0x4(%ebx),%eax
 14f:	01 d0                	add    %edx,%eax
 151:	8b 00                	mov    (%eax),%eax
 153:	83 ec 08             	sub    $0x8,%esp
 156:	6a 00                	push   $0x0
 158:	50                   	push   %eax
 159:	e8 f4 02 00 00       	call   452 <open>
 15e:	83 c4 10             	add    $0x10,%esp
 161:	89 45 f0             	mov    %eax,-0x10(%ebp)
 164:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 168:	79 29                	jns    193 <main+0xac>
      printf(1, "wc: cannot open %s\n", argv[i]);
 16a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 16d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 174:	8b 43 04             	mov    0x4(%ebx),%eax
 177:	01 d0                	add    %edx,%eax
 179:	8b 00                	mov    (%eax),%eax
 17b:	83 ec 04             	sub    $0x4,%esp
 17e:	50                   	push   %eax
 17f:	68 54 09 00 00       	push   $0x954
 184:	6a 01                	push   $0x1
 186:	e8 f9 03 00 00       	call   584 <printf>
 18b:	83 c4 10             	add    $0x10,%esp
      exit();
 18e:	e8 7f 02 00 00       	call   412 <exit>
    }
    wc(fd, argv[i]);
 193:	8b 45 f4             	mov    -0xc(%ebp),%eax
 196:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 19d:	8b 43 04             	mov    0x4(%ebx),%eax
 1a0:	01 d0                	add    %edx,%eax
 1a2:	8b 00                	mov    (%eax),%eax
 1a4:	83 ec 08             	sub    $0x8,%esp
 1a7:	50                   	push   %eax
 1a8:	ff 75 f0             	pushl  -0x10(%ebp)
 1ab:	e8 50 fe ff ff       	call   0 <wc>
 1b0:	83 c4 10             	add    $0x10,%esp
    close(fd);
 1b3:	83 ec 0c             	sub    $0xc,%esp
 1b6:	ff 75 f0             	pushl  -0x10(%ebp)
 1b9:	e8 7c 02 00 00       	call   43a <close>
 1be:	83 c4 10             	add    $0x10,%esp
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
 1c1:	ff 45 f4             	incl   -0xc(%ebp)
 1c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c7:	3b 03                	cmp    (%ebx),%eax
 1c9:	0f 8c 54 ff ff ff    	jl     123 <main+0x3c>
      exit();
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit();
 1cf:	e8 3e 02 00 00       	call   412 <exit>

000001d4 <stosb>:
 1d4:	55                   	push   %ebp
 1d5:	89 e5                	mov    %esp,%ebp
 1d7:	57                   	push   %edi
 1d8:	53                   	push   %ebx
 1d9:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1dc:	8b 55 10             	mov    0x10(%ebp),%edx
 1df:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e2:	89 cb                	mov    %ecx,%ebx
 1e4:	89 df                	mov    %ebx,%edi
 1e6:	89 d1                	mov    %edx,%ecx
 1e8:	fc                   	cld    
 1e9:	f3 aa                	rep stos %al,%es:(%edi)
 1eb:	89 ca                	mov    %ecx,%edx
 1ed:	89 fb                	mov    %edi,%ebx
 1ef:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1f2:	89 55 10             	mov    %edx,0x10(%ebp)
 1f5:	5b                   	pop    %ebx
 1f6:	5f                   	pop    %edi
 1f7:	5d                   	pop    %ebp
 1f8:	c3                   	ret    

000001f9 <strcpy>:
 1f9:	55                   	push   %ebp
 1fa:	89 e5                	mov    %esp,%ebp
 1fc:	83 ec 10             	sub    $0x10,%esp
 1ff:	8b 45 08             	mov    0x8(%ebp),%eax
 202:	89 45 fc             	mov    %eax,-0x4(%ebp)
 205:	90                   	nop
 206:	8b 45 08             	mov    0x8(%ebp),%eax
 209:	8d 50 01             	lea    0x1(%eax),%edx
 20c:	89 55 08             	mov    %edx,0x8(%ebp)
 20f:	8b 55 0c             	mov    0xc(%ebp),%edx
 212:	8d 4a 01             	lea    0x1(%edx),%ecx
 215:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 218:	8a 12                	mov    (%edx),%dl
 21a:	88 10                	mov    %dl,(%eax)
 21c:	8a 00                	mov    (%eax),%al
 21e:	84 c0                	test   %al,%al
 220:	75 e4                	jne    206 <strcpy+0xd>
 222:	8b 45 fc             	mov    -0x4(%ebp),%eax
 225:	c9                   	leave  
 226:	c3                   	ret    

00000227 <strcmp>:
 227:	55                   	push   %ebp
 228:	89 e5                	mov    %esp,%ebp
 22a:	eb 06                	jmp    232 <strcmp+0xb>
 22c:	ff 45 08             	incl   0x8(%ebp)
 22f:	ff 45 0c             	incl   0xc(%ebp)
 232:	8b 45 08             	mov    0x8(%ebp),%eax
 235:	8a 00                	mov    (%eax),%al
 237:	84 c0                	test   %al,%al
 239:	74 0e                	je     249 <strcmp+0x22>
 23b:	8b 45 08             	mov    0x8(%ebp),%eax
 23e:	8a 10                	mov    (%eax),%dl
 240:	8b 45 0c             	mov    0xc(%ebp),%eax
 243:	8a 00                	mov    (%eax),%al
 245:	38 c2                	cmp    %al,%dl
 247:	74 e3                	je     22c <strcmp+0x5>
 249:	8b 45 08             	mov    0x8(%ebp),%eax
 24c:	8a 00                	mov    (%eax),%al
 24e:	0f b6 d0             	movzbl %al,%edx
 251:	8b 45 0c             	mov    0xc(%ebp),%eax
 254:	8a 00                	mov    (%eax),%al
 256:	0f b6 c0             	movzbl %al,%eax
 259:	29 c2                	sub    %eax,%edx
 25b:	89 d0                	mov    %edx,%eax
 25d:	5d                   	pop    %ebp
 25e:	c3                   	ret    

0000025f <strlen>:
 25f:	55                   	push   %ebp
 260:	89 e5                	mov    %esp,%ebp
 262:	83 ec 10             	sub    $0x10,%esp
 265:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 26c:	eb 03                	jmp    271 <strlen+0x12>
 26e:	ff 45 fc             	incl   -0x4(%ebp)
 271:	8b 55 fc             	mov    -0x4(%ebp),%edx
 274:	8b 45 08             	mov    0x8(%ebp),%eax
 277:	01 d0                	add    %edx,%eax
 279:	8a 00                	mov    (%eax),%al
 27b:	84 c0                	test   %al,%al
 27d:	75 ef                	jne    26e <strlen+0xf>
 27f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 282:	c9                   	leave  
 283:	c3                   	ret    

00000284 <memset>:
 284:	55                   	push   %ebp
 285:	89 e5                	mov    %esp,%ebp
 287:	8b 45 10             	mov    0x10(%ebp),%eax
 28a:	50                   	push   %eax
 28b:	ff 75 0c             	pushl  0xc(%ebp)
 28e:	ff 75 08             	pushl  0x8(%ebp)
 291:	e8 3e ff ff ff       	call   1d4 <stosb>
 296:	83 c4 0c             	add    $0xc,%esp
 299:	8b 45 08             	mov    0x8(%ebp),%eax
 29c:	c9                   	leave  
 29d:	c3                   	ret    

0000029e <strchr>:
 29e:	55                   	push   %ebp
 29f:	89 e5                	mov    %esp,%ebp
 2a1:	83 ec 04             	sub    $0x4,%esp
 2a4:	8b 45 0c             	mov    0xc(%ebp),%eax
 2a7:	88 45 fc             	mov    %al,-0x4(%ebp)
 2aa:	eb 12                	jmp    2be <strchr+0x20>
 2ac:	8b 45 08             	mov    0x8(%ebp),%eax
 2af:	8a 00                	mov    (%eax),%al
 2b1:	3a 45 fc             	cmp    -0x4(%ebp),%al
 2b4:	75 05                	jne    2bb <strchr+0x1d>
 2b6:	8b 45 08             	mov    0x8(%ebp),%eax
 2b9:	eb 11                	jmp    2cc <strchr+0x2e>
 2bb:	ff 45 08             	incl   0x8(%ebp)
 2be:	8b 45 08             	mov    0x8(%ebp),%eax
 2c1:	8a 00                	mov    (%eax),%al
 2c3:	84 c0                	test   %al,%al
 2c5:	75 e5                	jne    2ac <strchr+0xe>
 2c7:	b8 00 00 00 00       	mov    $0x0,%eax
 2cc:	c9                   	leave  
 2cd:	c3                   	ret    

000002ce <gets>:
 2ce:	55                   	push   %ebp
 2cf:	89 e5                	mov    %esp,%ebp
 2d1:	83 ec 18             	sub    $0x18,%esp
 2d4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2db:	eb 41                	jmp    31e <gets+0x50>
 2dd:	83 ec 04             	sub    $0x4,%esp
 2e0:	6a 01                	push   $0x1
 2e2:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2e5:	50                   	push   %eax
 2e6:	6a 00                	push   $0x0
 2e8:	e8 3d 01 00 00       	call   42a <read>
 2ed:	83 c4 10             	add    $0x10,%esp
 2f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
 2f3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2f7:	7f 02                	jg     2fb <gets+0x2d>
 2f9:	eb 2c                	jmp    327 <gets+0x59>
 2fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2fe:	8d 50 01             	lea    0x1(%eax),%edx
 301:	89 55 f4             	mov    %edx,-0xc(%ebp)
 304:	89 c2                	mov    %eax,%edx
 306:	8b 45 08             	mov    0x8(%ebp),%eax
 309:	01 c2                	add    %eax,%edx
 30b:	8a 45 ef             	mov    -0x11(%ebp),%al
 30e:	88 02                	mov    %al,(%edx)
 310:	8a 45 ef             	mov    -0x11(%ebp),%al
 313:	3c 0a                	cmp    $0xa,%al
 315:	74 10                	je     327 <gets+0x59>
 317:	8a 45 ef             	mov    -0x11(%ebp),%al
 31a:	3c 0d                	cmp    $0xd,%al
 31c:	74 09                	je     327 <gets+0x59>
 31e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 321:	40                   	inc    %eax
 322:	3b 45 0c             	cmp    0xc(%ebp),%eax
 325:	7c b6                	jl     2dd <gets+0xf>
 327:	8b 55 f4             	mov    -0xc(%ebp),%edx
 32a:	8b 45 08             	mov    0x8(%ebp),%eax
 32d:	01 d0                	add    %edx,%eax
 32f:	c6 00 00             	movb   $0x0,(%eax)
 332:	8b 45 08             	mov    0x8(%ebp),%eax
 335:	c9                   	leave  
 336:	c3                   	ret    

00000337 <stat>:
 337:	55                   	push   %ebp
 338:	89 e5                	mov    %esp,%ebp
 33a:	83 ec 18             	sub    $0x18,%esp
 33d:	83 ec 08             	sub    $0x8,%esp
 340:	6a 00                	push   $0x0
 342:	ff 75 08             	pushl  0x8(%ebp)
 345:	e8 08 01 00 00       	call   452 <open>
 34a:	83 c4 10             	add    $0x10,%esp
 34d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 350:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 354:	79 07                	jns    35d <stat+0x26>
 356:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 35b:	eb 25                	jmp    382 <stat+0x4b>
 35d:	83 ec 08             	sub    $0x8,%esp
 360:	ff 75 0c             	pushl  0xc(%ebp)
 363:	ff 75 f4             	pushl  -0xc(%ebp)
 366:	e8 ff 00 00 00       	call   46a <fstat>
 36b:	83 c4 10             	add    $0x10,%esp
 36e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 371:	83 ec 0c             	sub    $0xc,%esp
 374:	ff 75 f4             	pushl  -0xc(%ebp)
 377:	e8 be 00 00 00       	call   43a <close>
 37c:	83 c4 10             	add    $0x10,%esp
 37f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 382:	c9                   	leave  
 383:	c3                   	ret    

00000384 <atoi>:
 384:	55                   	push   %ebp
 385:	89 e5                	mov    %esp,%ebp
 387:	83 ec 10             	sub    $0x10,%esp
 38a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 391:	eb 24                	jmp    3b7 <atoi+0x33>
 393:	8b 55 fc             	mov    -0x4(%ebp),%edx
 396:	89 d0                	mov    %edx,%eax
 398:	c1 e0 02             	shl    $0x2,%eax
 39b:	01 d0                	add    %edx,%eax
 39d:	01 c0                	add    %eax,%eax
 39f:	89 c1                	mov    %eax,%ecx
 3a1:	8b 45 08             	mov    0x8(%ebp),%eax
 3a4:	8d 50 01             	lea    0x1(%eax),%edx
 3a7:	89 55 08             	mov    %edx,0x8(%ebp)
 3aa:	8a 00                	mov    (%eax),%al
 3ac:	0f be c0             	movsbl %al,%eax
 3af:	01 c8                	add    %ecx,%eax
 3b1:	83 e8 30             	sub    $0x30,%eax
 3b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
 3b7:	8b 45 08             	mov    0x8(%ebp),%eax
 3ba:	8a 00                	mov    (%eax),%al
 3bc:	3c 2f                	cmp    $0x2f,%al
 3be:	7e 09                	jle    3c9 <atoi+0x45>
 3c0:	8b 45 08             	mov    0x8(%ebp),%eax
 3c3:	8a 00                	mov    (%eax),%al
 3c5:	3c 39                	cmp    $0x39,%al
 3c7:	7e ca                	jle    393 <atoi+0xf>
 3c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3cc:	c9                   	leave  
 3cd:	c3                   	ret    

000003ce <memmove>:
 3ce:	55                   	push   %ebp
 3cf:	89 e5                	mov    %esp,%ebp
 3d1:	83 ec 10             	sub    $0x10,%esp
 3d4:	8b 45 08             	mov    0x8(%ebp),%eax
 3d7:	89 45 fc             	mov    %eax,-0x4(%ebp)
 3da:	8b 45 0c             	mov    0xc(%ebp),%eax
 3dd:	89 45 f8             	mov    %eax,-0x8(%ebp)
 3e0:	eb 16                	jmp    3f8 <memmove+0x2a>
 3e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3e5:	8d 50 01             	lea    0x1(%eax),%edx
 3e8:	89 55 fc             	mov    %edx,-0x4(%ebp)
 3eb:	8b 55 f8             	mov    -0x8(%ebp),%edx
 3ee:	8d 4a 01             	lea    0x1(%edx),%ecx
 3f1:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 3f4:	8a 12                	mov    (%edx),%dl
 3f6:	88 10                	mov    %dl,(%eax)
 3f8:	8b 45 10             	mov    0x10(%ebp),%eax
 3fb:	8d 50 ff             	lea    -0x1(%eax),%edx
 3fe:	89 55 10             	mov    %edx,0x10(%ebp)
 401:	85 c0                	test   %eax,%eax
 403:	7f dd                	jg     3e2 <memmove+0x14>
 405:	8b 45 08             	mov    0x8(%ebp),%eax
 408:	c9                   	leave  
 409:	c3                   	ret    

0000040a <fork>:
 40a:	b8 01 00 00 00       	mov    $0x1,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <exit>:
 412:	b8 02 00 00 00       	mov    $0x2,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <wait>:
 41a:	b8 03 00 00 00       	mov    $0x3,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <pipe>:
 422:	b8 04 00 00 00       	mov    $0x4,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <read>:
 42a:	b8 05 00 00 00       	mov    $0x5,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <write>:
 432:	b8 10 00 00 00       	mov    $0x10,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <close>:
 43a:	b8 15 00 00 00       	mov    $0x15,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <kill>:
 442:	b8 06 00 00 00       	mov    $0x6,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <exec>:
 44a:	b8 07 00 00 00       	mov    $0x7,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <open>:
 452:	b8 0f 00 00 00       	mov    $0xf,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <mknod>:
 45a:	b8 11 00 00 00       	mov    $0x11,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <unlink>:
 462:	b8 12 00 00 00       	mov    $0x12,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <fstat>:
 46a:	b8 08 00 00 00       	mov    $0x8,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <link>:
 472:	b8 13 00 00 00       	mov    $0x13,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <mkdir>:
 47a:	b8 14 00 00 00       	mov    $0x14,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <chdir>:
 482:	b8 09 00 00 00       	mov    $0x9,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <dup>:
 48a:	b8 0a 00 00 00       	mov    $0xa,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <getpid>:
 492:	b8 0b 00 00 00       	mov    $0xb,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <sbrk>:
 49a:	b8 0c 00 00 00       	mov    $0xc,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <sleep>:
 4a2:	b8 0d 00 00 00       	mov    $0xd,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <uptime>:
 4aa:	b8 0e 00 00 00       	mov    $0xe,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <putc>:
 4b2:	55                   	push   %ebp
 4b3:	89 e5                	mov    %esp,%ebp
 4b5:	83 ec 18             	sub    $0x18,%esp
 4b8:	8b 45 0c             	mov    0xc(%ebp),%eax
 4bb:	88 45 f4             	mov    %al,-0xc(%ebp)
 4be:	83 ec 04             	sub    $0x4,%esp
 4c1:	6a 01                	push   $0x1
 4c3:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4c6:	50                   	push   %eax
 4c7:	ff 75 08             	pushl  0x8(%ebp)
 4ca:	e8 63 ff ff ff       	call   432 <write>
 4cf:	83 c4 10             	add    $0x10,%esp
 4d2:	c9                   	leave  
 4d3:	c3                   	ret    

000004d4 <printint>:
 4d4:	55                   	push   %ebp
 4d5:	89 e5                	mov    %esp,%ebp
 4d7:	53                   	push   %ebx
 4d8:	83 ec 24             	sub    $0x24,%esp
 4db:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4e2:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4e6:	74 17                	je     4ff <printint+0x2b>
 4e8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4ec:	79 11                	jns    4ff <printint+0x2b>
 4ee:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 4f5:	8b 45 0c             	mov    0xc(%ebp),%eax
 4f8:	f7 d8                	neg    %eax
 4fa:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4fd:	eb 06                	jmp    505 <printint+0x31>
 4ff:	8b 45 0c             	mov    0xc(%ebp),%eax
 502:	89 45 ec             	mov    %eax,-0x14(%ebp)
 505:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 50c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 50f:	8d 41 01             	lea    0x1(%ecx),%eax
 512:	89 45 f4             	mov    %eax,-0xc(%ebp)
 515:	8b 5d 10             	mov    0x10(%ebp),%ebx
 518:	8b 45 ec             	mov    -0x14(%ebp),%eax
 51b:	ba 00 00 00 00       	mov    $0x0,%edx
 520:	f7 f3                	div    %ebx
 522:	89 d0                	mov    %edx,%eax
 524:	8a 80 dc 0b 00 00    	mov    0xbdc(%eax),%al
 52a:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
 52e:	8b 5d 10             	mov    0x10(%ebp),%ebx
 531:	8b 45 ec             	mov    -0x14(%ebp),%eax
 534:	ba 00 00 00 00       	mov    $0x0,%edx
 539:	f7 f3                	div    %ebx
 53b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 53e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 542:	75 c8                	jne    50c <printint+0x38>
 544:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 548:	74 0e                	je     558 <printint+0x84>
 54a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 54d:	8d 50 01             	lea    0x1(%eax),%edx
 550:	89 55 f4             	mov    %edx,-0xc(%ebp)
 553:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
 558:	eb 1c                	jmp    576 <printint+0xa2>
 55a:	8d 55 dc             	lea    -0x24(%ebp),%edx
 55d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 560:	01 d0                	add    %edx,%eax
 562:	8a 00                	mov    (%eax),%al
 564:	0f be c0             	movsbl %al,%eax
 567:	83 ec 08             	sub    $0x8,%esp
 56a:	50                   	push   %eax
 56b:	ff 75 08             	pushl  0x8(%ebp)
 56e:	e8 3f ff ff ff       	call   4b2 <putc>
 573:	83 c4 10             	add    $0x10,%esp
 576:	ff 4d f4             	decl   -0xc(%ebp)
 579:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 57d:	79 db                	jns    55a <printint+0x86>
 57f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 582:	c9                   	leave  
 583:	c3                   	ret    

00000584 <printf>:
 584:	55                   	push   %ebp
 585:	89 e5                	mov    %esp,%ebp
 587:	83 ec 28             	sub    $0x28,%esp
 58a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 591:	8d 45 0c             	lea    0xc(%ebp),%eax
 594:	83 c0 04             	add    $0x4,%eax
 597:	89 45 e8             	mov    %eax,-0x18(%ebp)
 59a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5a1:	e9 54 01 00 00       	jmp    6fa <printf+0x176>
 5a6:	8b 55 0c             	mov    0xc(%ebp),%edx
 5a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5ac:	01 d0                	add    %edx,%eax
 5ae:	8a 00                	mov    (%eax),%al
 5b0:	0f be c0             	movsbl %al,%eax
 5b3:	25 ff 00 00 00       	and    $0xff,%eax
 5b8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 5bb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5bf:	75 2c                	jne    5ed <printf+0x69>
 5c1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5c5:	75 0c                	jne    5d3 <printf+0x4f>
 5c7:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5ce:	e9 24 01 00 00       	jmp    6f7 <printf+0x173>
 5d3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5d6:	0f be c0             	movsbl %al,%eax
 5d9:	83 ec 08             	sub    $0x8,%esp
 5dc:	50                   	push   %eax
 5dd:	ff 75 08             	pushl  0x8(%ebp)
 5e0:	e8 cd fe ff ff       	call   4b2 <putc>
 5e5:	83 c4 10             	add    $0x10,%esp
 5e8:	e9 0a 01 00 00       	jmp    6f7 <printf+0x173>
 5ed:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5f1:	0f 85 00 01 00 00    	jne    6f7 <printf+0x173>
 5f7:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5fb:	75 1e                	jne    61b <printf+0x97>
 5fd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 600:	8b 00                	mov    (%eax),%eax
 602:	6a 01                	push   $0x1
 604:	6a 0a                	push   $0xa
 606:	50                   	push   %eax
 607:	ff 75 08             	pushl  0x8(%ebp)
 60a:	e8 c5 fe ff ff       	call   4d4 <printint>
 60f:	83 c4 10             	add    $0x10,%esp
 612:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 616:	e9 d5 00 00 00       	jmp    6f0 <printf+0x16c>
 61b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 61f:	74 06                	je     627 <printf+0xa3>
 621:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 625:	75 1e                	jne    645 <printf+0xc1>
 627:	8b 45 e8             	mov    -0x18(%ebp),%eax
 62a:	8b 00                	mov    (%eax),%eax
 62c:	6a 00                	push   $0x0
 62e:	6a 10                	push   $0x10
 630:	50                   	push   %eax
 631:	ff 75 08             	pushl  0x8(%ebp)
 634:	e8 9b fe ff ff       	call   4d4 <printint>
 639:	83 c4 10             	add    $0x10,%esp
 63c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 640:	e9 ab 00 00 00       	jmp    6f0 <printf+0x16c>
 645:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 649:	75 40                	jne    68b <printf+0x107>
 64b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 64e:	8b 00                	mov    (%eax),%eax
 650:	89 45 f4             	mov    %eax,-0xc(%ebp)
 653:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 657:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 65b:	75 07                	jne    664 <printf+0xe0>
 65d:	c7 45 f4 68 09 00 00 	movl   $0x968,-0xc(%ebp)
 664:	eb 1a                	jmp    680 <printf+0xfc>
 666:	8b 45 f4             	mov    -0xc(%ebp),%eax
 669:	8a 00                	mov    (%eax),%al
 66b:	0f be c0             	movsbl %al,%eax
 66e:	83 ec 08             	sub    $0x8,%esp
 671:	50                   	push   %eax
 672:	ff 75 08             	pushl  0x8(%ebp)
 675:	e8 38 fe ff ff       	call   4b2 <putc>
 67a:	83 c4 10             	add    $0x10,%esp
 67d:	ff 45 f4             	incl   -0xc(%ebp)
 680:	8b 45 f4             	mov    -0xc(%ebp),%eax
 683:	8a 00                	mov    (%eax),%al
 685:	84 c0                	test   %al,%al
 687:	75 dd                	jne    666 <printf+0xe2>
 689:	eb 65                	jmp    6f0 <printf+0x16c>
 68b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 68f:	75 1d                	jne    6ae <printf+0x12a>
 691:	8b 45 e8             	mov    -0x18(%ebp),%eax
 694:	8b 00                	mov    (%eax),%eax
 696:	0f be c0             	movsbl %al,%eax
 699:	83 ec 08             	sub    $0x8,%esp
 69c:	50                   	push   %eax
 69d:	ff 75 08             	pushl  0x8(%ebp)
 6a0:	e8 0d fe ff ff       	call   4b2 <putc>
 6a5:	83 c4 10             	add    $0x10,%esp
 6a8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6ac:	eb 42                	jmp    6f0 <printf+0x16c>
 6ae:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6b2:	75 17                	jne    6cb <printf+0x147>
 6b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6b7:	0f be c0             	movsbl %al,%eax
 6ba:	83 ec 08             	sub    $0x8,%esp
 6bd:	50                   	push   %eax
 6be:	ff 75 08             	pushl  0x8(%ebp)
 6c1:	e8 ec fd ff ff       	call   4b2 <putc>
 6c6:	83 c4 10             	add    $0x10,%esp
 6c9:	eb 25                	jmp    6f0 <printf+0x16c>
 6cb:	83 ec 08             	sub    $0x8,%esp
 6ce:	6a 25                	push   $0x25
 6d0:	ff 75 08             	pushl  0x8(%ebp)
 6d3:	e8 da fd ff ff       	call   4b2 <putc>
 6d8:	83 c4 10             	add    $0x10,%esp
 6db:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6de:	0f be c0             	movsbl %al,%eax
 6e1:	83 ec 08             	sub    $0x8,%esp
 6e4:	50                   	push   %eax
 6e5:	ff 75 08             	pushl  0x8(%ebp)
 6e8:	e8 c5 fd ff ff       	call   4b2 <putc>
 6ed:	83 c4 10             	add    $0x10,%esp
 6f0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 6f7:	ff 45 f0             	incl   -0x10(%ebp)
 6fa:	8b 55 0c             	mov    0xc(%ebp),%edx
 6fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 700:	01 d0                	add    %edx,%eax
 702:	8a 00                	mov    (%eax),%al
 704:	84 c0                	test   %al,%al
 706:	0f 85 9a fe ff ff    	jne    5a6 <printf+0x22>
 70c:	c9                   	leave  
 70d:	c3                   	ret    

0000070e <free>:
 70e:	55                   	push   %ebp
 70f:	89 e5                	mov    %esp,%ebp
 711:	83 ec 10             	sub    $0x10,%esp
 714:	8b 45 08             	mov    0x8(%ebp),%eax
 717:	83 e8 08             	sub    $0x8,%eax
 71a:	89 45 f8             	mov    %eax,-0x8(%ebp)
 71d:	a1 08 0c 00 00       	mov    0xc08,%eax
 722:	89 45 fc             	mov    %eax,-0x4(%ebp)
 725:	eb 24                	jmp    74b <free+0x3d>
 727:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72a:	8b 00                	mov    (%eax),%eax
 72c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 72f:	77 12                	ja     743 <free+0x35>
 731:	8b 45 f8             	mov    -0x8(%ebp),%eax
 734:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 737:	77 24                	ja     75d <free+0x4f>
 739:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73c:	8b 00                	mov    (%eax),%eax
 73e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 741:	77 1a                	ja     75d <free+0x4f>
 743:	8b 45 fc             	mov    -0x4(%ebp),%eax
 746:	8b 00                	mov    (%eax),%eax
 748:	89 45 fc             	mov    %eax,-0x4(%ebp)
 74b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 74e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 751:	76 d4                	jbe    727 <free+0x19>
 753:	8b 45 fc             	mov    -0x4(%ebp),%eax
 756:	8b 00                	mov    (%eax),%eax
 758:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 75b:	76 ca                	jbe    727 <free+0x19>
 75d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 760:	8b 40 04             	mov    0x4(%eax),%eax
 763:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 76a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 76d:	01 c2                	add    %eax,%edx
 76f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 772:	8b 00                	mov    (%eax),%eax
 774:	39 c2                	cmp    %eax,%edx
 776:	75 24                	jne    79c <free+0x8e>
 778:	8b 45 f8             	mov    -0x8(%ebp),%eax
 77b:	8b 50 04             	mov    0x4(%eax),%edx
 77e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 781:	8b 00                	mov    (%eax),%eax
 783:	8b 40 04             	mov    0x4(%eax),%eax
 786:	01 c2                	add    %eax,%edx
 788:	8b 45 f8             	mov    -0x8(%ebp),%eax
 78b:	89 50 04             	mov    %edx,0x4(%eax)
 78e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 791:	8b 00                	mov    (%eax),%eax
 793:	8b 10                	mov    (%eax),%edx
 795:	8b 45 f8             	mov    -0x8(%ebp),%eax
 798:	89 10                	mov    %edx,(%eax)
 79a:	eb 0a                	jmp    7a6 <free+0x98>
 79c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 79f:	8b 10                	mov    (%eax),%edx
 7a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7a4:	89 10                	mov    %edx,(%eax)
 7a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a9:	8b 40 04             	mov    0x4(%eax),%eax
 7ac:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b6:	01 d0                	add    %edx,%eax
 7b8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7bb:	75 20                	jne    7dd <free+0xcf>
 7bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c0:	8b 50 04             	mov    0x4(%eax),%edx
 7c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c6:	8b 40 04             	mov    0x4(%eax),%eax
 7c9:	01 c2                	add    %eax,%edx
 7cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ce:	89 50 04             	mov    %edx,0x4(%eax)
 7d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d4:	8b 10                	mov    (%eax),%edx
 7d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d9:	89 10                	mov    %edx,(%eax)
 7db:	eb 08                	jmp    7e5 <free+0xd7>
 7dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7e0:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7e3:	89 10                	mov    %edx,(%eax)
 7e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7e8:	a3 08 0c 00 00       	mov    %eax,0xc08
 7ed:	c9                   	leave  
 7ee:	c3                   	ret    

000007ef <morecore>:
 7ef:	55                   	push   %ebp
 7f0:	89 e5                	mov    %esp,%ebp
 7f2:	83 ec 18             	sub    $0x18,%esp
 7f5:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7fc:	77 07                	ja     805 <morecore+0x16>
 7fe:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 805:	8b 45 08             	mov    0x8(%ebp),%eax
 808:	c1 e0 03             	shl    $0x3,%eax
 80b:	83 ec 0c             	sub    $0xc,%esp
 80e:	50                   	push   %eax
 80f:	e8 86 fc ff ff       	call   49a <sbrk>
 814:	83 c4 10             	add    $0x10,%esp
 817:	89 45 f4             	mov    %eax,-0xc(%ebp)
 81a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 81e:	75 07                	jne    827 <morecore+0x38>
 820:	b8 00 00 00 00       	mov    $0x0,%eax
 825:	eb 26                	jmp    84d <morecore+0x5e>
 827:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82a:	89 45 f0             	mov    %eax,-0x10(%ebp)
 82d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 830:	8b 55 08             	mov    0x8(%ebp),%edx
 833:	89 50 04             	mov    %edx,0x4(%eax)
 836:	8b 45 f0             	mov    -0x10(%ebp),%eax
 839:	83 c0 08             	add    $0x8,%eax
 83c:	83 ec 0c             	sub    $0xc,%esp
 83f:	50                   	push   %eax
 840:	e8 c9 fe ff ff       	call   70e <free>
 845:	83 c4 10             	add    $0x10,%esp
 848:	a1 08 0c 00 00       	mov    0xc08,%eax
 84d:	c9                   	leave  
 84e:	c3                   	ret    

0000084f <malloc>:
 84f:	55                   	push   %ebp
 850:	89 e5                	mov    %esp,%ebp
 852:	83 ec 18             	sub    $0x18,%esp
 855:	8b 45 08             	mov    0x8(%ebp),%eax
 858:	83 c0 07             	add    $0x7,%eax
 85b:	c1 e8 03             	shr    $0x3,%eax
 85e:	40                   	inc    %eax
 85f:	89 45 ec             	mov    %eax,-0x14(%ebp)
 862:	a1 08 0c 00 00       	mov    0xc08,%eax
 867:	89 45 f0             	mov    %eax,-0x10(%ebp)
 86a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 86e:	75 23                	jne    893 <malloc+0x44>
 870:	c7 45 f0 00 0c 00 00 	movl   $0xc00,-0x10(%ebp)
 877:	8b 45 f0             	mov    -0x10(%ebp),%eax
 87a:	a3 08 0c 00 00       	mov    %eax,0xc08
 87f:	a1 08 0c 00 00       	mov    0xc08,%eax
 884:	a3 00 0c 00 00       	mov    %eax,0xc00
 889:	c7 05 04 0c 00 00 00 	movl   $0x0,0xc04
 890:	00 00 00 
 893:	8b 45 f0             	mov    -0x10(%ebp),%eax
 896:	8b 00                	mov    (%eax),%eax
 898:	89 45 f4             	mov    %eax,-0xc(%ebp)
 89b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89e:	8b 40 04             	mov    0x4(%eax),%eax
 8a1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8a4:	72 4d                	jb     8f3 <malloc+0xa4>
 8a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a9:	8b 40 04             	mov    0x4(%eax),%eax
 8ac:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8af:	75 0c                	jne    8bd <malloc+0x6e>
 8b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b4:	8b 10                	mov    (%eax),%edx
 8b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b9:	89 10                	mov    %edx,(%eax)
 8bb:	eb 26                	jmp    8e3 <malloc+0x94>
 8bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c0:	8b 40 04             	mov    0x4(%eax),%eax
 8c3:	2b 45 ec             	sub    -0x14(%ebp),%eax
 8c6:	89 c2                	mov    %eax,%edx
 8c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8cb:	89 50 04             	mov    %edx,0x4(%eax)
 8ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d1:	8b 40 04             	mov    0x4(%eax),%eax
 8d4:	c1 e0 03             	shl    $0x3,%eax
 8d7:	01 45 f4             	add    %eax,-0xc(%ebp)
 8da:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8dd:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8e0:	89 50 04             	mov    %edx,0x4(%eax)
 8e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8e6:	a3 08 0c 00 00       	mov    %eax,0xc08
 8eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ee:	83 c0 08             	add    $0x8,%eax
 8f1:	eb 3b                	jmp    92e <malloc+0xdf>
 8f3:	a1 08 0c 00 00       	mov    0xc08,%eax
 8f8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8fb:	75 1e                	jne    91b <malloc+0xcc>
 8fd:	83 ec 0c             	sub    $0xc,%esp
 900:	ff 75 ec             	pushl  -0x14(%ebp)
 903:	e8 e7 fe ff ff       	call   7ef <morecore>
 908:	83 c4 10             	add    $0x10,%esp
 90b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 90e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 912:	75 07                	jne    91b <malloc+0xcc>
 914:	b8 00 00 00 00       	mov    $0x0,%eax
 919:	eb 13                	jmp    92e <malloc+0xdf>
 91b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 91e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 921:	8b 45 f4             	mov    -0xc(%ebp),%eax
 924:	8b 00                	mov    (%eax),%eax
 926:	89 45 f4             	mov    %eax,-0xc(%ebp)
 929:	e9 6d ff ff ff       	jmp    89b <malloc+0x4c>
 92e:	c9                   	leave  
 92f:	c3                   	ret    
