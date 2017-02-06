
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
   6:	eb 15                	jmp    1d <cat+0x1d>
    write(1, buf, n);
   8:	83 ec 04             	sub    $0x4,%esp
   b:	ff 75 f4             	pushl  -0xc(%ebp)
   e:	68 40 0b 00 00       	push   $0xb40
  13:	6a 01                	push   $0x1
  15:	e8 51 03 00 00       	call   36b <write>
  1a:	83 c4 10             	add    $0x10,%esp
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
  1d:	83 ec 04             	sub    $0x4,%esp
  20:	68 00 02 00 00       	push   $0x200
  25:	68 40 0b 00 00       	push   $0xb40
  2a:	ff 75 08             	pushl  0x8(%ebp)
  2d:	e8 31 03 00 00       	call   363 <read>
  32:	83 c4 10             	add    $0x10,%esp
  35:	89 45 f4             	mov    %eax,-0xc(%ebp)
  38:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  3c:	7f ca                	jg     8 <cat+0x8>
    write(1, buf, n);
  if(n < 0){
  3e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  42:	79 17                	jns    5b <cat+0x5b>
    printf(1, "cat: read error\n");
  44:	83 ec 08             	sub    $0x8,%esp
  47:	68 69 08 00 00       	push   $0x869
  4c:	6a 01                	push   $0x1
  4e:	e8 6a 04 00 00       	call   4bd <printf>
  53:	83 c4 10             	add    $0x10,%esp
    exit();
  56:	e8 f0 02 00 00       	call   34b <exit>
  }
}
  5b:	c9                   	leave  
  5c:	c3                   	ret    

0000005d <main>:

int
main(int argc, char *argv[])
{
  5d:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  61:	83 e4 f0             	and    $0xfffffff0,%esp
  64:	ff 71 fc             	pushl  -0x4(%ecx)
  67:	55                   	push   %ebp
  68:	89 e5                	mov    %esp,%ebp
  6a:	53                   	push   %ebx
  6b:	51                   	push   %ecx
  6c:	83 ec 10             	sub    $0x10,%esp
  6f:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
  71:	83 3b 01             	cmpl   $0x1,(%ebx)
  74:	7f 12                	jg     88 <main+0x2b>
    cat(0);
  76:	83 ec 0c             	sub    $0xc,%esp
  79:	6a 00                	push   $0x0
  7b:	e8 80 ff ff ff       	call   0 <cat>
  80:	83 c4 10             	add    $0x10,%esp
    exit();
  83:	e8 c3 02 00 00       	call   34b <exit>
  }

  for(i = 1; i < argc; i++){
  88:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  8f:	eb 70                	jmp    101 <main+0xa4>
    if((fd = open(argv[i], 0)) < 0){
  91:	8b 45 f4             	mov    -0xc(%ebp),%eax
  94:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  9b:	8b 43 04             	mov    0x4(%ebx),%eax
  9e:	01 d0                	add    %edx,%eax
  a0:	8b 00                	mov    (%eax),%eax
  a2:	83 ec 08             	sub    $0x8,%esp
  a5:	6a 00                	push   $0x0
  a7:	50                   	push   %eax
  a8:	e8 de 02 00 00       	call   38b <open>
  ad:	83 c4 10             	add    $0x10,%esp
  b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  b3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  b7:	79 29                	jns    e2 <main+0x85>
      printf(1, "cat: cannot open %s\n", argv[i]);
  b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  c3:	8b 43 04             	mov    0x4(%ebx),%eax
  c6:	01 d0                	add    %edx,%eax
  c8:	8b 00                	mov    (%eax),%eax
  ca:	83 ec 04             	sub    $0x4,%esp
  cd:	50                   	push   %eax
  ce:	68 7a 08 00 00       	push   $0x87a
  d3:	6a 01                	push   $0x1
  d5:	e8 e3 03 00 00       	call   4bd <printf>
  da:	83 c4 10             	add    $0x10,%esp
      exit();
  dd:	e8 69 02 00 00       	call   34b <exit>
    }
    cat(fd);
  e2:	83 ec 0c             	sub    $0xc,%esp
  e5:	ff 75 f0             	pushl  -0x10(%ebp)
  e8:	e8 13 ff ff ff       	call   0 <cat>
  ed:	83 c4 10             	add    $0x10,%esp
    close(fd);
  f0:	83 ec 0c             	sub    $0xc,%esp
  f3:	ff 75 f0             	pushl  -0x10(%ebp)
  f6:	e8 78 02 00 00       	call   373 <close>
  fb:	83 c4 10             	add    $0x10,%esp
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  fe:	ff 45 f4             	incl   -0xc(%ebp)
 101:	8b 45 f4             	mov    -0xc(%ebp),%eax
 104:	3b 03                	cmp    (%ebx),%eax
 106:	7c 89                	jl     91 <main+0x34>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
 108:	e8 3e 02 00 00       	call   34b <exit>

0000010d <stosb>:
 10d:	55                   	push   %ebp
 10e:	89 e5                	mov    %esp,%ebp
 110:	57                   	push   %edi
 111:	53                   	push   %ebx
 112:	8b 4d 08             	mov    0x8(%ebp),%ecx
 115:	8b 55 10             	mov    0x10(%ebp),%edx
 118:	8b 45 0c             	mov    0xc(%ebp),%eax
 11b:	89 cb                	mov    %ecx,%ebx
 11d:	89 df                	mov    %ebx,%edi
 11f:	89 d1                	mov    %edx,%ecx
 121:	fc                   	cld    
 122:	f3 aa                	rep stos %al,%es:(%edi)
 124:	89 ca                	mov    %ecx,%edx
 126:	89 fb                	mov    %edi,%ebx
 128:	89 5d 08             	mov    %ebx,0x8(%ebp)
 12b:	89 55 10             	mov    %edx,0x10(%ebp)
 12e:	5b                   	pop    %ebx
 12f:	5f                   	pop    %edi
 130:	5d                   	pop    %ebp
 131:	c3                   	ret    

00000132 <strcpy>:
 132:	55                   	push   %ebp
 133:	89 e5                	mov    %esp,%ebp
 135:	83 ec 10             	sub    $0x10,%esp
 138:	8b 45 08             	mov    0x8(%ebp),%eax
 13b:	89 45 fc             	mov    %eax,-0x4(%ebp)
 13e:	90                   	nop
 13f:	8b 45 08             	mov    0x8(%ebp),%eax
 142:	8d 50 01             	lea    0x1(%eax),%edx
 145:	89 55 08             	mov    %edx,0x8(%ebp)
 148:	8b 55 0c             	mov    0xc(%ebp),%edx
 14b:	8d 4a 01             	lea    0x1(%edx),%ecx
 14e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 151:	8a 12                	mov    (%edx),%dl
 153:	88 10                	mov    %dl,(%eax)
 155:	8a 00                	mov    (%eax),%al
 157:	84 c0                	test   %al,%al
 159:	75 e4                	jne    13f <strcpy+0xd>
 15b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 15e:	c9                   	leave  
 15f:	c3                   	ret    

00000160 <strcmp>:
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	eb 06                	jmp    16b <strcmp+0xb>
 165:	ff 45 08             	incl   0x8(%ebp)
 168:	ff 45 0c             	incl   0xc(%ebp)
 16b:	8b 45 08             	mov    0x8(%ebp),%eax
 16e:	8a 00                	mov    (%eax),%al
 170:	84 c0                	test   %al,%al
 172:	74 0e                	je     182 <strcmp+0x22>
 174:	8b 45 08             	mov    0x8(%ebp),%eax
 177:	8a 10                	mov    (%eax),%dl
 179:	8b 45 0c             	mov    0xc(%ebp),%eax
 17c:	8a 00                	mov    (%eax),%al
 17e:	38 c2                	cmp    %al,%dl
 180:	74 e3                	je     165 <strcmp+0x5>
 182:	8b 45 08             	mov    0x8(%ebp),%eax
 185:	8a 00                	mov    (%eax),%al
 187:	0f b6 d0             	movzbl %al,%edx
 18a:	8b 45 0c             	mov    0xc(%ebp),%eax
 18d:	8a 00                	mov    (%eax),%al
 18f:	0f b6 c0             	movzbl %al,%eax
 192:	29 c2                	sub    %eax,%edx
 194:	89 d0                	mov    %edx,%eax
 196:	5d                   	pop    %ebp
 197:	c3                   	ret    

00000198 <strlen>:
 198:	55                   	push   %ebp
 199:	89 e5                	mov    %esp,%ebp
 19b:	83 ec 10             	sub    $0x10,%esp
 19e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1a5:	eb 03                	jmp    1aa <strlen+0x12>
 1a7:	ff 45 fc             	incl   -0x4(%ebp)
 1aa:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1ad:	8b 45 08             	mov    0x8(%ebp),%eax
 1b0:	01 d0                	add    %edx,%eax
 1b2:	8a 00                	mov    (%eax),%al
 1b4:	84 c0                	test   %al,%al
 1b6:	75 ef                	jne    1a7 <strlen+0xf>
 1b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 1bb:	c9                   	leave  
 1bc:	c3                   	ret    

000001bd <memset>:
 1bd:	55                   	push   %ebp
 1be:	89 e5                	mov    %esp,%ebp
 1c0:	8b 45 10             	mov    0x10(%ebp),%eax
 1c3:	50                   	push   %eax
 1c4:	ff 75 0c             	pushl  0xc(%ebp)
 1c7:	ff 75 08             	pushl  0x8(%ebp)
 1ca:	e8 3e ff ff ff       	call   10d <stosb>
 1cf:	83 c4 0c             	add    $0xc,%esp
 1d2:	8b 45 08             	mov    0x8(%ebp),%eax
 1d5:	c9                   	leave  
 1d6:	c3                   	ret    

000001d7 <strchr>:
 1d7:	55                   	push   %ebp
 1d8:	89 e5                	mov    %esp,%ebp
 1da:	83 ec 04             	sub    $0x4,%esp
 1dd:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e0:	88 45 fc             	mov    %al,-0x4(%ebp)
 1e3:	eb 12                	jmp    1f7 <strchr+0x20>
 1e5:	8b 45 08             	mov    0x8(%ebp),%eax
 1e8:	8a 00                	mov    (%eax),%al
 1ea:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1ed:	75 05                	jne    1f4 <strchr+0x1d>
 1ef:	8b 45 08             	mov    0x8(%ebp),%eax
 1f2:	eb 11                	jmp    205 <strchr+0x2e>
 1f4:	ff 45 08             	incl   0x8(%ebp)
 1f7:	8b 45 08             	mov    0x8(%ebp),%eax
 1fa:	8a 00                	mov    (%eax),%al
 1fc:	84 c0                	test   %al,%al
 1fe:	75 e5                	jne    1e5 <strchr+0xe>
 200:	b8 00 00 00 00       	mov    $0x0,%eax
 205:	c9                   	leave  
 206:	c3                   	ret    

00000207 <gets>:
 207:	55                   	push   %ebp
 208:	89 e5                	mov    %esp,%ebp
 20a:	83 ec 18             	sub    $0x18,%esp
 20d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 214:	eb 41                	jmp    257 <gets+0x50>
 216:	83 ec 04             	sub    $0x4,%esp
 219:	6a 01                	push   $0x1
 21b:	8d 45 ef             	lea    -0x11(%ebp),%eax
 21e:	50                   	push   %eax
 21f:	6a 00                	push   $0x0
 221:	e8 3d 01 00 00       	call   363 <read>
 226:	83 c4 10             	add    $0x10,%esp
 229:	89 45 f0             	mov    %eax,-0x10(%ebp)
 22c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 230:	7f 02                	jg     234 <gets+0x2d>
 232:	eb 2c                	jmp    260 <gets+0x59>
 234:	8b 45 f4             	mov    -0xc(%ebp),%eax
 237:	8d 50 01             	lea    0x1(%eax),%edx
 23a:	89 55 f4             	mov    %edx,-0xc(%ebp)
 23d:	89 c2                	mov    %eax,%edx
 23f:	8b 45 08             	mov    0x8(%ebp),%eax
 242:	01 c2                	add    %eax,%edx
 244:	8a 45 ef             	mov    -0x11(%ebp),%al
 247:	88 02                	mov    %al,(%edx)
 249:	8a 45 ef             	mov    -0x11(%ebp),%al
 24c:	3c 0a                	cmp    $0xa,%al
 24e:	74 10                	je     260 <gets+0x59>
 250:	8a 45 ef             	mov    -0x11(%ebp),%al
 253:	3c 0d                	cmp    $0xd,%al
 255:	74 09                	je     260 <gets+0x59>
 257:	8b 45 f4             	mov    -0xc(%ebp),%eax
 25a:	40                   	inc    %eax
 25b:	3b 45 0c             	cmp    0xc(%ebp),%eax
 25e:	7c b6                	jl     216 <gets+0xf>
 260:	8b 55 f4             	mov    -0xc(%ebp),%edx
 263:	8b 45 08             	mov    0x8(%ebp),%eax
 266:	01 d0                	add    %edx,%eax
 268:	c6 00 00             	movb   $0x0,(%eax)
 26b:	8b 45 08             	mov    0x8(%ebp),%eax
 26e:	c9                   	leave  
 26f:	c3                   	ret    

00000270 <stat>:
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	83 ec 18             	sub    $0x18,%esp
 276:	83 ec 08             	sub    $0x8,%esp
 279:	6a 00                	push   $0x0
 27b:	ff 75 08             	pushl  0x8(%ebp)
 27e:	e8 08 01 00 00       	call   38b <open>
 283:	83 c4 10             	add    $0x10,%esp
 286:	89 45 f4             	mov    %eax,-0xc(%ebp)
 289:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 28d:	79 07                	jns    296 <stat+0x26>
 28f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 294:	eb 25                	jmp    2bb <stat+0x4b>
 296:	83 ec 08             	sub    $0x8,%esp
 299:	ff 75 0c             	pushl  0xc(%ebp)
 29c:	ff 75 f4             	pushl  -0xc(%ebp)
 29f:	e8 ff 00 00 00       	call   3a3 <fstat>
 2a4:	83 c4 10             	add    $0x10,%esp
 2a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
 2aa:	83 ec 0c             	sub    $0xc,%esp
 2ad:	ff 75 f4             	pushl  -0xc(%ebp)
 2b0:	e8 be 00 00 00       	call   373 <close>
 2b5:	83 c4 10             	add    $0x10,%esp
 2b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 2bb:	c9                   	leave  
 2bc:	c3                   	ret    

000002bd <atoi>:
 2bd:	55                   	push   %ebp
 2be:	89 e5                	mov    %esp,%ebp
 2c0:	83 ec 10             	sub    $0x10,%esp
 2c3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 2ca:	eb 24                	jmp    2f0 <atoi+0x33>
 2cc:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2cf:	89 d0                	mov    %edx,%eax
 2d1:	c1 e0 02             	shl    $0x2,%eax
 2d4:	01 d0                	add    %edx,%eax
 2d6:	01 c0                	add    %eax,%eax
 2d8:	89 c1                	mov    %eax,%ecx
 2da:	8b 45 08             	mov    0x8(%ebp),%eax
 2dd:	8d 50 01             	lea    0x1(%eax),%edx
 2e0:	89 55 08             	mov    %edx,0x8(%ebp)
 2e3:	8a 00                	mov    (%eax),%al
 2e5:	0f be c0             	movsbl %al,%eax
 2e8:	01 c8                	add    %ecx,%eax
 2ea:	83 e8 30             	sub    $0x30,%eax
 2ed:	89 45 fc             	mov    %eax,-0x4(%ebp)
 2f0:	8b 45 08             	mov    0x8(%ebp),%eax
 2f3:	8a 00                	mov    (%eax),%al
 2f5:	3c 2f                	cmp    $0x2f,%al
 2f7:	7e 09                	jle    302 <atoi+0x45>
 2f9:	8b 45 08             	mov    0x8(%ebp),%eax
 2fc:	8a 00                	mov    (%eax),%al
 2fe:	3c 39                	cmp    $0x39,%al
 300:	7e ca                	jle    2cc <atoi+0xf>
 302:	8b 45 fc             	mov    -0x4(%ebp),%eax
 305:	c9                   	leave  
 306:	c3                   	ret    

00000307 <memmove>:
 307:	55                   	push   %ebp
 308:	89 e5                	mov    %esp,%ebp
 30a:	83 ec 10             	sub    $0x10,%esp
 30d:	8b 45 08             	mov    0x8(%ebp),%eax
 310:	89 45 fc             	mov    %eax,-0x4(%ebp)
 313:	8b 45 0c             	mov    0xc(%ebp),%eax
 316:	89 45 f8             	mov    %eax,-0x8(%ebp)
 319:	eb 16                	jmp    331 <memmove+0x2a>
 31b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 31e:	8d 50 01             	lea    0x1(%eax),%edx
 321:	89 55 fc             	mov    %edx,-0x4(%ebp)
 324:	8b 55 f8             	mov    -0x8(%ebp),%edx
 327:	8d 4a 01             	lea    0x1(%edx),%ecx
 32a:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 32d:	8a 12                	mov    (%edx),%dl
 32f:	88 10                	mov    %dl,(%eax)
 331:	8b 45 10             	mov    0x10(%ebp),%eax
 334:	8d 50 ff             	lea    -0x1(%eax),%edx
 337:	89 55 10             	mov    %edx,0x10(%ebp)
 33a:	85 c0                	test   %eax,%eax
 33c:	7f dd                	jg     31b <memmove+0x14>
 33e:	8b 45 08             	mov    0x8(%ebp),%eax
 341:	c9                   	leave  
 342:	c3                   	ret    

00000343 <fork>:
 343:	b8 01 00 00 00       	mov    $0x1,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <exit>:
 34b:	b8 02 00 00 00       	mov    $0x2,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <wait>:
 353:	b8 03 00 00 00       	mov    $0x3,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <pipe>:
 35b:	b8 04 00 00 00       	mov    $0x4,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <read>:
 363:	b8 05 00 00 00       	mov    $0x5,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <write>:
 36b:	b8 10 00 00 00       	mov    $0x10,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <close>:
 373:	b8 15 00 00 00       	mov    $0x15,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <kill>:
 37b:	b8 06 00 00 00       	mov    $0x6,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <exec>:
 383:	b8 07 00 00 00       	mov    $0x7,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <open>:
 38b:	b8 0f 00 00 00       	mov    $0xf,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <mknod>:
 393:	b8 11 00 00 00       	mov    $0x11,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <unlink>:
 39b:	b8 12 00 00 00       	mov    $0x12,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <fstat>:
 3a3:	b8 08 00 00 00       	mov    $0x8,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <link>:
 3ab:	b8 13 00 00 00       	mov    $0x13,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <mkdir>:
 3b3:	b8 14 00 00 00       	mov    $0x14,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <chdir>:
 3bb:	b8 09 00 00 00       	mov    $0x9,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <dup>:
 3c3:	b8 0a 00 00 00       	mov    $0xa,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <getpid>:
 3cb:	b8 0b 00 00 00       	mov    $0xb,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <sbrk>:
 3d3:	b8 0c 00 00 00       	mov    $0xc,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <sleep>:
 3db:	b8 0d 00 00 00       	mov    $0xd,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <uptime>:
 3e3:	b8 0e 00 00 00       	mov    $0xe,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <putc>:
 3eb:	55                   	push   %ebp
 3ec:	89 e5                	mov    %esp,%ebp
 3ee:	83 ec 18             	sub    $0x18,%esp
 3f1:	8b 45 0c             	mov    0xc(%ebp),%eax
 3f4:	88 45 f4             	mov    %al,-0xc(%ebp)
 3f7:	83 ec 04             	sub    $0x4,%esp
 3fa:	6a 01                	push   $0x1
 3fc:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3ff:	50                   	push   %eax
 400:	ff 75 08             	pushl  0x8(%ebp)
 403:	e8 63 ff ff ff       	call   36b <write>
 408:	83 c4 10             	add    $0x10,%esp
 40b:	c9                   	leave  
 40c:	c3                   	ret    

0000040d <printint>:
 40d:	55                   	push   %ebp
 40e:	89 e5                	mov    %esp,%ebp
 410:	53                   	push   %ebx
 411:	83 ec 24             	sub    $0x24,%esp
 414:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 41b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 41f:	74 17                	je     438 <printint+0x2b>
 421:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 425:	79 11                	jns    438 <printint+0x2b>
 427:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 42e:	8b 45 0c             	mov    0xc(%ebp),%eax
 431:	f7 d8                	neg    %eax
 433:	89 45 ec             	mov    %eax,-0x14(%ebp)
 436:	eb 06                	jmp    43e <printint+0x31>
 438:	8b 45 0c             	mov    0xc(%ebp),%eax
 43b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 43e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 445:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 448:	8d 41 01             	lea    0x1(%ecx),%eax
 44b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 44e:	8b 5d 10             	mov    0x10(%ebp),%ebx
 451:	8b 45 ec             	mov    -0x14(%ebp),%eax
 454:	ba 00 00 00 00       	mov    $0x0,%edx
 459:	f7 f3                	div    %ebx
 45b:	89 d0                	mov    %edx,%eax
 45d:	8a 80 04 0b 00 00    	mov    0xb04(%eax),%al
 463:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
 467:	8b 5d 10             	mov    0x10(%ebp),%ebx
 46a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 46d:	ba 00 00 00 00       	mov    $0x0,%edx
 472:	f7 f3                	div    %ebx
 474:	89 45 ec             	mov    %eax,-0x14(%ebp)
 477:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 47b:	75 c8                	jne    445 <printint+0x38>
 47d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 481:	74 0e                	je     491 <printint+0x84>
 483:	8b 45 f4             	mov    -0xc(%ebp),%eax
 486:	8d 50 01             	lea    0x1(%eax),%edx
 489:	89 55 f4             	mov    %edx,-0xc(%ebp)
 48c:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
 491:	eb 1c                	jmp    4af <printint+0xa2>
 493:	8d 55 dc             	lea    -0x24(%ebp),%edx
 496:	8b 45 f4             	mov    -0xc(%ebp),%eax
 499:	01 d0                	add    %edx,%eax
 49b:	8a 00                	mov    (%eax),%al
 49d:	0f be c0             	movsbl %al,%eax
 4a0:	83 ec 08             	sub    $0x8,%esp
 4a3:	50                   	push   %eax
 4a4:	ff 75 08             	pushl  0x8(%ebp)
 4a7:	e8 3f ff ff ff       	call   3eb <putc>
 4ac:	83 c4 10             	add    $0x10,%esp
 4af:	ff 4d f4             	decl   -0xc(%ebp)
 4b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4b6:	79 db                	jns    493 <printint+0x86>
 4b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4bb:	c9                   	leave  
 4bc:	c3                   	ret    

000004bd <printf>:
 4bd:	55                   	push   %ebp
 4be:	89 e5                	mov    %esp,%ebp
 4c0:	83 ec 28             	sub    $0x28,%esp
 4c3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 4ca:	8d 45 0c             	lea    0xc(%ebp),%eax
 4cd:	83 c0 04             	add    $0x4,%eax
 4d0:	89 45 e8             	mov    %eax,-0x18(%ebp)
 4d3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4da:	e9 54 01 00 00       	jmp    633 <printf+0x176>
 4df:	8b 55 0c             	mov    0xc(%ebp),%edx
 4e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4e5:	01 d0                	add    %edx,%eax
 4e7:	8a 00                	mov    (%eax),%al
 4e9:	0f be c0             	movsbl %al,%eax
 4ec:	25 ff 00 00 00       	and    $0xff,%eax
 4f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 4f4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4f8:	75 2c                	jne    526 <printf+0x69>
 4fa:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4fe:	75 0c                	jne    50c <printf+0x4f>
 500:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 507:	e9 24 01 00 00       	jmp    630 <printf+0x173>
 50c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 50f:	0f be c0             	movsbl %al,%eax
 512:	83 ec 08             	sub    $0x8,%esp
 515:	50                   	push   %eax
 516:	ff 75 08             	pushl  0x8(%ebp)
 519:	e8 cd fe ff ff       	call   3eb <putc>
 51e:	83 c4 10             	add    $0x10,%esp
 521:	e9 0a 01 00 00       	jmp    630 <printf+0x173>
 526:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 52a:	0f 85 00 01 00 00    	jne    630 <printf+0x173>
 530:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 534:	75 1e                	jne    554 <printf+0x97>
 536:	8b 45 e8             	mov    -0x18(%ebp),%eax
 539:	8b 00                	mov    (%eax),%eax
 53b:	6a 01                	push   $0x1
 53d:	6a 0a                	push   $0xa
 53f:	50                   	push   %eax
 540:	ff 75 08             	pushl  0x8(%ebp)
 543:	e8 c5 fe ff ff       	call   40d <printint>
 548:	83 c4 10             	add    $0x10,%esp
 54b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 54f:	e9 d5 00 00 00       	jmp    629 <printf+0x16c>
 554:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 558:	74 06                	je     560 <printf+0xa3>
 55a:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 55e:	75 1e                	jne    57e <printf+0xc1>
 560:	8b 45 e8             	mov    -0x18(%ebp),%eax
 563:	8b 00                	mov    (%eax),%eax
 565:	6a 00                	push   $0x0
 567:	6a 10                	push   $0x10
 569:	50                   	push   %eax
 56a:	ff 75 08             	pushl  0x8(%ebp)
 56d:	e8 9b fe ff ff       	call   40d <printint>
 572:	83 c4 10             	add    $0x10,%esp
 575:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 579:	e9 ab 00 00 00       	jmp    629 <printf+0x16c>
 57e:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 582:	75 40                	jne    5c4 <printf+0x107>
 584:	8b 45 e8             	mov    -0x18(%ebp),%eax
 587:	8b 00                	mov    (%eax),%eax
 589:	89 45 f4             	mov    %eax,-0xc(%ebp)
 58c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 590:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 594:	75 07                	jne    59d <printf+0xe0>
 596:	c7 45 f4 8f 08 00 00 	movl   $0x88f,-0xc(%ebp)
 59d:	eb 1a                	jmp    5b9 <printf+0xfc>
 59f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5a2:	8a 00                	mov    (%eax),%al
 5a4:	0f be c0             	movsbl %al,%eax
 5a7:	83 ec 08             	sub    $0x8,%esp
 5aa:	50                   	push   %eax
 5ab:	ff 75 08             	pushl  0x8(%ebp)
 5ae:	e8 38 fe ff ff       	call   3eb <putc>
 5b3:	83 c4 10             	add    $0x10,%esp
 5b6:	ff 45 f4             	incl   -0xc(%ebp)
 5b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5bc:	8a 00                	mov    (%eax),%al
 5be:	84 c0                	test   %al,%al
 5c0:	75 dd                	jne    59f <printf+0xe2>
 5c2:	eb 65                	jmp    629 <printf+0x16c>
 5c4:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5c8:	75 1d                	jne    5e7 <printf+0x12a>
 5ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5cd:	8b 00                	mov    (%eax),%eax
 5cf:	0f be c0             	movsbl %al,%eax
 5d2:	83 ec 08             	sub    $0x8,%esp
 5d5:	50                   	push   %eax
 5d6:	ff 75 08             	pushl  0x8(%ebp)
 5d9:	e8 0d fe ff ff       	call   3eb <putc>
 5de:	83 c4 10             	add    $0x10,%esp
 5e1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5e5:	eb 42                	jmp    629 <printf+0x16c>
 5e7:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5eb:	75 17                	jne    604 <printf+0x147>
 5ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5f0:	0f be c0             	movsbl %al,%eax
 5f3:	83 ec 08             	sub    $0x8,%esp
 5f6:	50                   	push   %eax
 5f7:	ff 75 08             	pushl  0x8(%ebp)
 5fa:	e8 ec fd ff ff       	call   3eb <putc>
 5ff:	83 c4 10             	add    $0x10,%esp
 602:	eb 25                	jmp    629 <printf+0x16c>
 604:	83 ec 08             	sub    $0x8,%esp
 607:	6a 25                	push   $0x25
 609:	ff 75 08             	pushl  0x8(%ebp)
 60c:	e8 da fd ff ff       	call   3eb <putc>
 611:	83 c4 10             	add    $0x10,%esp
 614:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 617:	0f be c0             	movsbl %al,%eax
 61a:	83 ec 08             	sub    $0x8,%esp
 61d:	50                   	push   %eax
 61e:	ff 75 08             	pushl  0x8(%ebp)
 621:	e8 c5 fd ff ff       	call   3eb <putc>
 626:	83 c4 10             	add    $0x10,%esp
 629:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 630:	ff 45 f0             	incl   -0x10(%ebp)
 633:	8b 55 0c             	mov    0xc(%ebp),%edx
 636:	8b 45 f0             	mov    -0x10(%ebp),%eax
 639:	01 d0                	add    %edx,%eax
 63b:	8a 00                	mov    (%eax),%al
 63d:	84 c0                	test   %al,%al
 63f:	0f 85 9a fe ff ff    	jne    4df <printf+0x22>
 645:	c9                   	leave  
 646:	c3                   	ret    

00000647 <free>:
 647:	55                   	push   %ebp
 648:	89 e5                	mov    %esp,%ebp
 64a:	83 ec 10             	sub    $0x10,%esp
 64d:	8b 45 08             	mov    0x8(%ebp),%eax
 650:	83 e8 08             	sub    $0x8,%eax
 653:	89 45 f8             	mov    %eax,-0x8(%ebp)
 656:	a1 28 0b 00 00       	mov    0xb28,%eax
 65b:	89 45 fc             	mov    %eax,-0x4(%ebp)
 65e:	eb 24                	jmp    684 <free+0x3d>
 660:	8b 45 fc             	mov    -0x4(%ebp),%eax
 663:	8b 00                	mov    (%eax),%eax
 665:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 668:	77 12                	ja     67c <free+0x35>
 66a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 66d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 670:	77 24                	ja     696 <free+0x4f>
 672:	8b 45 fc             	mov    -0x4(%ebp),%eax
 675:	8b 00                	mov    (%eax),%eax
 677:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 67a:	77 1a                	ja     696 <free+0x4f>
 67c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67f:	8b 00                	mov    (%eax),%eax
 681:	89 45 fc             	mov    %eax,-0x4(%ebp)
 684:	8b 45 f8             	mov    -0x8(%ebp),%eax
 687:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 68a:	76 d4                	jbe    660 <free+0x19>
 68c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68f:	8b 00                	mov    (%eax),%eax
 691:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 694:	76 ca                	jbe    660 <free+0x19>
 696:	8b 45 f8             	mov    -0x8(%ebp),%eax
 699:	8b 40 04             	mov    0x4(%eax),%eax
 69c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a6:	01 c2                	add    %eax,%edx
 6a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ab:	8b 00                	mov    (%eax),%eax
 6ad:	39 c2                	cmp    %eax,%edx
 6af:	75 24                	jne    6d5 <free+0x8e>
 6b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b4:	8b 50 04             	mov    0x4(%eax),%edx
 6b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ba:	8b 00                	mov    (%eax),%eax
 6bc:	8b 40 04             	mov    0x4(%eax),%eax
 6bf:	01 c2                	add    %eax,%edx
 6c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c4:	89 50 04             	mov    %edx,0x4(%eax)
 6c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ca:	8b 00                	mov    (%eax),%eax
 6cc:	8b 10                	mov    (%eax),%edx
 6ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d1:	89 10                	mov    %edx,(%eax)
 6d3:	eb 0a                	jmp    6df <free+0x98>
 6d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d8:	8b 10                	mov    (%eax),%edx
 6da:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6dd:	89 10                	mov    %edx,(%eax)
 6df:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e2:	8b 40 04             	mov    0x4(%eax),%eax
 6e5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ef:	01 d0                	add    %edx,%eax
 6f1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6f4:	75 20                	jne    716 <free+0xcf>
 6f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f9:	8b 50 04             	mov    0x4(%eax),%edx
 6fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ff:	8b 40 04             	mov    0x4(%eax),%eax
 702:	01 c2                	add    %eax,%edx
 704:	8b 45 fc             	mov    -0x4(%ebp),%eax
 707:	89 50 04             	mov    %edx,0x4(%eax)
 70a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70d:	8b 10                	mov    (%eax),%edx
 70f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 712:	89 10                	mov    %edx,(%eax)
 714:	eb 08                	jmp    71e <free+0xd7>
 716:	8b 45 fc             	mov    -0x4(%ebp),%eax
 719:	8b 55 f8             	mov    -0x8(%ebp),%edx
 71c:	89 10                	mov    %edx,(%eax)
 71e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 721:	a3 28 0b 00 00       	mov    %eax,0xb28
 726:	c9                   	leave  
 727:	c3                   	ret    

00000728 <morecore>:
 728:	55                   	push   %ebp
 729:	89 e5                	mov    %esp,%ebp
 72b:	83 ec 18             	sub    $0x18,%esp
 72e:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 735:	77 07                	ja     73e <morecore+0x16>
 737:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 73e:	8b 45 08             	mov    0x8(%ebp),%eax
 741:	c1 e0 03             	shl    $0x3,%eax
 744:	83 ec 0c             	sub    $0xc,%esp
 747:	50                   	push   %eax
 748:	e8 86 fc ff ff       	call   3d3 <sbrk>
 74d:	83 c4 10             	add    $0x10,%esp
 750:	89 45 f4             	mov    %eax,-0xc(%ebp)
 753:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 757:	75 07                	jne    760 <morecore+0x38>
 759:	b8 00 00 00 00       	mov    $0x0,%eax
 75e:	eb 26                	jmp    786 <morecore+0x5e>
 760:	8b 45 f4             	mov    -0xc(%ebp),%eax
 763:	89 45 f0             	mov    %eax,-0x10(%ebp)
 766:	8b 45 f0             	mov    -0x10(%ebp),%eax
 769:	8b 55 08             	mov    0x8(%ebp),%edx
 76c:	89 50 04             	mov    %edx,0x4(%eax)
 76f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 772:	83 c0 08             	add    $0x8,%eax
 775:	83 ec 0c             	sub    $0xc,%esp
 778:	50                   	push   %eax
 779:	e8 c9 fe ff ff       	call   647 <free>
 77e:	83 c4 10             	add    $0x10,%esp
 781:	a1 28 0b 00 00       	mov    0xb28,%eax
 786:	c9                   	leave  
 787:	c3                   	ret    

00000788 <malloc>:
 788:	55                   	push   %ebp
 789:	89 e5                	mov    %esp,%ebp
 78b:	83 ec 18             	sub    $0x18,%esp
 78e:	8b 45 08             	mov    0x8(%ebp),%eax
 791:	83 c0 07             	add    $0x7,%eax
 794:	c1 e8 03             	shr    $0x3,%eax
 797:	40                   	inc    %eax
 798:	89 45 ec             	mov    %eax,-0x14(%ebp)
 79b:	a1 28 0b 00 00       	mov    0xb28,%eax
 7a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7a3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7a7:	75 23                	jne    7cc <malloc+0x44>
 7a9:	c7 45 f0 20 0b 00 00 	movl   $0xb20,-0x10(%ebp)
 7b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b3:	a3 28 0b 00 00       	mov    %eax,0xb28
 7b8:	a1 28 0b 00 00       	mov    0xb28,%eax
 7bd:	a3 20 0b 00 00       	mov    %eax,0xb20
 7c2:	c7 05 24 0b 00 00 00 	movl   $0x0,0xb24
 7c9:	00 00 00 
 7cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7cf:	8b 00                	mov    (%eax),%eax
 7d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d7:	8b 40 04             	mov    0x4(%eax),%eax
 7da:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7dd:	72 4d                	jb     82c <malloc+0xa4>
 7df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e2:	8b 40 04             	mov    0x4(%eax),%eax
 7e5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7e8:	75 0c                	jne    7f6 <malloc+0x6e>
 7ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ed:	8b 10                	mov    (%eax),%edx
 7ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f2:	89 10                	mov    %edx,(%eax)
 7f4:	eb 26                	jmp    81c <malloc+0x94>
 7f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f9:	8b 40 04             	mov    0x4(%eax),%eax
 7fc:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7ff:	89 c2                	mov    %eax,%edx
 801:	8b 45 f4             	mov    -0xc(%ebp),%eax
 804:	89 50 04             	mov    %edx,0x4(%eax)
 807:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80a:	8b 40 04             	mov    0x4(%eax),%eax
 80d:	c1 e0 03             	shl    $0x3,%eax
 810:	01 45 f4             	add    %eax,-0xc(%ebp)
 813:	8b 45 f4             	mov    -0xc(%ebp),%eax
 816:	8b 55 ec             	mov    -0x14(%ebp),%edx
 819:	89 50 04             	mov    %edx,0x4(%eax)
 81c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 81f:	a3 28 0b 00 00       	mov    %eax,0xb28
 824:	8b 45 f4             	mov    -0xc(%ebp),%eax
 827:	83 c0 08             	add    $0x8,%eax
 82a:	eb 3b                	jmp    867 <malloc+0xdf>
 82c:	a1 28 0b 00 00       	mov    0xb28,%eax
 831:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 834:	75 1e                	jne    854 <malloc+0xcc>
 836:	83 ec 0c             	sub    $0xc,%esp
 839:	ff 75 ec             	pushl  -0x14(%ebp)
 83c:	e8 e7 fe ff ff       	call   728 <morecore>
 841:	83 c4 10             	add    $0x10,%esp
 844:	89 45 f4             	mov    %eax,-0xc(%ebp)
 847:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 84b:	75 07                	jne    854 <malloc+0xcc>
 84d:	b8 00 00 00 00       	mov    $0x0,%eax
 852:	eb 13                	jmp    867 <malloc+0xdf>
 854:	8b 45 f4             	mov    -0xc(%ebp),%eax
 857:	89 45 f0             	mov    %eax,-0x10(%ebp)
 85a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85d:	8b 00                	mov    (%eax),%eax
 85f:	89 45 f4             	mov    %eax,-0xc(%ebp)
 862:	e9 6d ff ff ff       	jmp    7d4 <malloc+0x4c>
 867:	c9                   	leave  
 868:	c3                   	ret    
