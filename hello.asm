
_hello:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

#include "types.h"
#include "user.h"

int main(){
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
	printf(1, "Hello World \n");
  11:	83 ec 08             	sub    $0x8,%esp
  14:	68 84 07 00 00       	push   $0x784
  19:	6a 01                	push   $0x1
  1b:	e8 b8 03 00 00       	call   3d8 <printf>
  20:	83 c4 10             	add    $0x10,%esp
	exit();
  23:	e8 3e 02 00 00       	call   266 <exit>

00000028 <stosb>:
  28:	55                   	push   %ebp
  29:	89 e5                	mov    %esp,%ebp
  2b:	57                   	push   %edi
  2c:	53                   	push   %ebx
  2d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  30:	8b 55 10             	mov    0x10(%ebp),%edx
  33:	8b 45 0c             	mov    0xc(%ebp),%eax
  36:	89 cb                	mov    %ecx,%ebx
  38:	89 df                	mov    %ebx,%edi
  3a:	89 d1                	mov    %edx,%ecx
  3c:	fc                   	cld    
  3d:	f3 aa                	rep stos %al,%es:(%edi)
  3f:	89 ca                	mov    %ecx,%edx
  41:	89 fb                	mov    %edi,%ebx
  43:	89 5d 08             	mov    %ebx,0x8(%ebp)
  46:	89 55 10             	mov    %edx,0x10(%ebp)
  49:	5b                   	pop    %ebx
  4a:	5f                   	pop    %edi
  4b:	5d                   	pop    %ebp
  4c:	c3                   	ret    

0000004d <strcpy>:
  4d:	55                   	push   %ebp
  4e:	89 e5                	mov    %esp,%ebp
  50:	83 ec 10             	sub    $0x10,%esp
  53:	8b 45 08             	mov    0x8(%ebp),%eax
  56:	89 45 fc             	mov    %eax,-0x4(%ebp)
  59:	90                   	nop
  5a:	8b 45 08             	mov    0x8(%ebp),%eax
  5d:	8d 50 01             	lea    0x1(%eax),%edx
  60:	89 55 08             	mov    %edx,0x8(%ebp)
  63:	8b 55 0c             	mov    0xc(%ebp),%edx
  66:	8d 4a 01             	lea    0x1(%edx),%ecx
  69:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  6c:	8a 12                	mov    (%edx),%dl
  6e:	88 10                	mov    %dl,(%eax)
  70:	8a 00                	mov    (%eax),%al
  72:	84 c0                	test   %al,%al
  74:	75 e4                	jne    5a <strcpy+0xd>
  76:	8b 45 fc             	mov    -0x4(%ebp),%eax
  79:	c9                   	leave  
  7a:	c3                   	ret    

0000007b <strcmp>:
  7b:	55                   	push   %ebp
  7c:	89 e5                	mov    %esp,%ebp
  7e:	eb 06                	jmp    86 <strcmp+0xb>
  80:	ff 45 08             	incl   0x8(%ebp)
  83:	ff 45 0c             	incl   0xc(%ebp)
  86:	8b 45 08             	mov    0x8(%ebp),%eax
  89:	8a 00                	mov    (%eax),%al
  8b:	84 c0                	test   %al,%al
  8d:	74 0e                	je     9d <strcmp+0x22>
  8f:	8b 45 08             	mov    0x8(%ebp),%eax
  92:	8a 10                	mov    (%eax),%dl
  94:	8b 45 0c             	mov    0xc(%ebp),%eax
  97:	8a 00                	mov    (%eax),%al
  99:	38 c2                	cmp    %al,%dl
  9b:	74 e3                	je     80 <strcmp+0x5>
  9d:	8b 45 08             	mov    0x8(%ebp),%eax
  a0:	8a 00                	mov    (%eax),%al
  a2:	0f b6 d0             	movzbl %al,%edx
  a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  a8:	8a 00                	mov    (%eax),%al
  aa:	0f b6 c0             	movzbl %al,%eax
  ad:	29 c2                	sub    %eax,%edx
  af:	89 d0                	mov    %edx,%eax
  b1:	5d                   	pop    %ebp
  b2:	c3                   	ret    

000000b3 <strlen>:
  b3:	55                   	push   %ebp
  b4:	89 e5                	mov    %esp,%ebp
  b6:	83 ec 10             	sub    $0x10,%esp
  b9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  c0:	eb 03                	jmp    c5 <strlen+0x12>
  c2:	ff 45 fc             	incl   -0x4(%ebp)
  c5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  c8:	8b 45 08             	mov    0x8(%ebp),%eax
  cb:	01 d0                	add    %edx,%eax
  cd:	8a 00                	mov    (%eax),%al
  cf:	84 c0                	test   %al,%al
  d1:	75 ef                	jne    c2 <strlen+0xf>
  d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  d6:	c9                   	leave  
  d7:	c3                   	ret    

000000d8 <memset>:
  d8:	55                   	push   %ebp
  d9:	89 e5                	mov    %esp,%ebp
  db:	8b 45 10             	mov    0x10(%ebp),%eax
  de:	50                   	push   %eax
  df:	ff 75 0c             	pushl  0xc(%ebp)
  e2:	ff 75 08             	pushl  0x8(%ebp)
  e5:	e8 3e ff ff ff       	call   28 <stosb>
  ea:	83 c4 0c             	add    $0xc,%esp
  ed:	8b 45 08             	mov    0x8(%ebp),%eax
  f0:	c9                   	leave  
  f1:	c3                   	ret    

000000f2 <strchr>:
  f2:	55                   	push   %ebp
  f3:	89 e5                	mov    %esp,%ebp
  f5:	83 ec 04             	sub    $0x4,%esp
  f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  fb:	88 45 fc             	mov    %al,-0x4(%ebp)
  fe:	eb 12                	jmp    112 <strchr+0x20>
 100:	8b 45 08             	mov    0x8(%ebp),%eax
 103:	8a 00                	mov    (%eax),%al
 105:	3a 45 fc             	cmp    -0x4(%ebp),%al
 108:	75 05                	jne    10f <strchr+0x1d>
 10a:	8b 45 08             	mov    0x8(%ebp),%eax
 10d:	eb 11                	jmp    120 <strchr+0x2e>
 10f:	ff 45 08             	incl   0x8(%ebp)
 112:	8b 45 08             	mov    0x8(%ebp),%eax
 115:	8a 00                	mov    (%eax),%al
 117:	84 c0                	test   %al,%al
 119:	75 e5                	jne    100 <strchr+0xe>
 11b:	b8 00 00 00 00       	mov    $0x0,%eax
 120:	c9                   	leave  
 121:	c3                   	ret    

00000122 <gets>:
 122:	55                   	push   %ebp
 123:	89 e5                	mov    %esp,%ebp
 125:	83 ec 18             	sub    $0x18,%esp
 128:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 12f:	eb 41                	jmp    172 <gets+0x50>
 131:	83 ec 04             	sub    $0x4,%esp
 134:	6a 01                	push   $0x1
 136:	8d 45 ef             	lea    -0x11(%ebp),%eax
 139:	50                   	push   %eax
 13a:	6a 00                	push   $0x0
 13c:	e8 3d 01 00 00       	call   27e <read>
 141:	83 c4 10             	add    $0x10,%esp
 144:	89 45 f0             	mov    %eax,-0x10(%ebp)
 147:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 14b:	7f 02                	jg     14f <gets+0x2d>
 14d:	eb 2c                	jmp    17b <gets+0x59>
 14f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 152:	8d 50 01             	lea    0x1(%eax),%edx
 155:	89 55 f4             	mov    %edx,-0xc(%ebp)
 158:	89 c2                	mov    %eax,%edx
 15a:	8b 45 08             	mov    0x8(%ebp),%eax
 15d:	01 c2                	add    %eax,%edx
 15f:	8a 45 ef             	mov    -0x11(%ebp),%al
 162:	88 02                	mov    %al,(%edx)
 164:	8a 45 ef             	mov    -0x11(%ebp),%al
 167:	3c 0a                	cmp    $0xa,%al
 169:	74 10                	je     17b <gets+0x59>
 16b:	8a 45 ef             	mov    -0x11(%ebp),%al
 16e:	3c 0d                	cmp    $0xd,%al
 170:	74 09                	je     17b <gets+0x59>
 172:	8b 45 f4             	mov    -0xc(%ebp),%eax
 175:	40                   	inc    %eax
 176:	3b 45 0c             	cmp    0xc(%ebp),%eax
 179:	7c b6                	jl     131 <gets+0xf>
 17b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 17e:	8b 45 08             	mov    0x8(%ebp),%eax
 181:	01 d0                	add    %edx,%eax
 183:	c6 00 00             	movb   $0x0,(%eax)
 186:	8b 45 08             	mov    0x8(%ebp),%eax
 189:	c9                   	leave  
 18a:	c3                   	ret    

0000018b <stat>:
 18b:	55                   	push   %ebp
 18c:	89 e5                	mov    %esp,%ebp
 18e:	83 ec 18             	sub    $0x18,%esp
 191:	83 ec 08             	sub    $0x8,%esp
 194:	6a 00                	push   $0x0
 196:	ff 75 08             	pushl  0x8(%ebp)
 199:	e8 08 01 00 00       	call   2a6 <open>
 19e:	83 c4 10             	add    $0x10,%esp
 1a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
 1a4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1a8:	79 07                	jns    1b1 <stat+0x26>
 1aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1af:	eb 25                	jmp    1d6 <stat+0x4b>
 1b1:	83 ec 08             	sub    $0x8,%esp
 1b4:	ff 75 0c             	pushl  0xc(%ebp)
 1b7:	ff 75 f4             	pushl  -0xc(%ebp)
 1ba:	e8 ff 00 00 00       	call   2be <fstat>
 1bf:	83 c4 10             	add    $0x10,%esp
 1c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
 1c5:	83 ec 0c             	sub    $0xc,%esp
 1c8:	ff 75 f4             	pushl  -0xc(%ebp)
 1cb:	e8 be 00 00 00       	call   28e <close>
 1d0:	83 c4 10             	add    $0x10,%esp
 1d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 1d6:	c9                   	leave  
 1d7:	c3                   	ret    

000001d8 <atoi>:
 1d8:	55                   	push   %ebp
 1d9:	89 e5                	mov    %esp,%ebp
 1db:	83 ec 10             	sub    $0x10,%esp
 1de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1e5:	eb 24                	jmp    20b <atoi+0x33>
 1e7:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1ea:	89 d0                	mov    %edx,%eax
 1ec:	c1 e0 02             	shl    $0x2,%eax
 1ef:	01 d0                	add    %edx,%eax
 1f1:	01 c0                	add    %eax,%eax
 1f3:	89 c1                	mov    %eax,%ecx
 1f5:	8b 45 08             	mov    0x8(%ebp),%eax
 1f8:	8d 50 01             	lea    0x1(%eax),%edx
 1fb:	89 55 08             	mov    %edx,0x8(%ebp)
 1fe:	8a 00                	mov    (%eax),%al
 200:	0f be c0             	movsbl %al,%eax
 203:	01 c8                	add    %ecx,%eax
 205:	83 e8 30             	sub    $0x30,%eax
 208:	89 45 fc             	mov    %eax,-0x4(%ebp)
 20b:	8b 45 08             	mov    0x8(%ebp),%eax
 20e:	8a 00                	mov    (%eax),%al
 210:	3c 2f                	cmp    $0x2f,%al
 212:	7e 09                	jle    21d <atoi+0x45>
 214:	8b 45 08             	mov    0x8(%ebp),%eax
 217:	8a 00                	mov    (%eax),%al
 219:	3c 39                	cmp    $0x39,%al
 21b:	7e ca                	jle    1e7 <atoi+0xf>
 21d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 220:	c9                   	leave  
 221:	c3                   	ret    

00000222 <memmove>:
 222:	55                   	push   %ebp
 223:	89 e5                	mov    %esp,%ebp
 225:	83 ec 10             	sub    $0x10,%esp
 228:	8b 45 08             	mov    0x8(%ebp),%eax
 22b:	89 45 fc             	mov    %eax,-0x4(%ebp)
 22e:	8b 45 0c             	mov    0xc(%ebp),%eax
 231:	89 45 f8             	mov    %eax,-0x8(%ebp)
 234:	eb 16                	jmp    24c <memmove+0x2a>
 236:	8b 45 fc             	mov    -0x4(%ebp),%eax
 239:	8d 50 01             	lea    0x1(%eax),%edx
 23c:	89 55 fc             	mov    %edx,-0x4(%ebp)
 23f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 242:	8d 4a 01             	lea    0x1(%edx),%ecx
 245:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 248:	8a 12                	mov    (%edx),%dl
 24a:	88 10                	mov    %dl,(%eax)
 24c:	8b 45 10             	mov    0x10(%ebp),%eax
 24f:	8d 50 ff             	lea    -0x1(%eax),%edx
 252:	89 55 10             	mov    %edx,0x10(%ebp)
 255:	85 c0                	test   %eax,%eax
 257:	7f dd                	jg     236 <memmove+0x14>
 259:	8b 45 08             	mov    0x8(%ebp),%eax
 25c:	c9                   	leave  
 25d:	c3                   	ret    

0000025e <fork>:
 25e:	b8 01 00 00 00       	mov    $0x1,%eax
 263:	cd 40                	int    $0x40
 265:	c3                   	ret    

00000266 <exit>:
 266:	b8 02 00 00 00       	mov    $0x2,%eax
 26b:	cd 40                	int    $0x40
 26d:	c3                   	ret    

0000026e <wait>:
 26e:	b8 03 00 00 00       	mov    $0x3,%eax
 273:	cd 40                	int    $0x40
 275:	c3                   	ret    

00000276 <pipe>:
 276:	b8 04 00 00 00       	mov    $0x4,%eax
 27b:	cd 40                	int    $0x40
 27d:	c3                   	ret    

0000027e <read>:
 27e:	b8 05 00 00 00       	mov    $0x5,%eax
 283:	cd 40                	int    $0x40
 285:	c3                   	ret    

00000286 <write>:
 286:	b8 10 00 00 00       	mov    $0x10,%eax
 28b:	cd 40                	int    $0x40
 28d:	c3                   	ret    

0000028e <close>:
 28e:	b8 15 00 00 00       	mov    $0x15,%eax
 293:	cd 40                	int    $0x40
 295:	c3                   	ret    

00000296 <kill>:
 296:	b8 06 00 00 00       	mov    $0x6,%eax
 29b:	cd 40                	int    $0x40
 29d:	c3                   	ret    

0000029e <exec>:
 29e:	b8 07 00 00 00       	mov    $0x7,%eax
 2a3:	cd 40                	int    $0x40
 2a5:	c3                   	ret    

000002a6 <open>:
 2a6:	b8 0f 00 00 00       	mov    $0xf,%eax
 2ab:	cd 40                	int    $0x40
 2ad:	c3                   	ret    

000002ae <mknod>:
 2ae:	b8 11 00 00 00       	mov    $0x11,%eax
 2b3:	cd 40                	int    $0x40
 2b5:	c3                   	ret    

000002b6 <unlink>:
 2b6:	b8 12 00 00 00       	mov    $0x12,%eax
 2bb:	cd 40                	int    $0x40
 2bd:	c3                   	ret    

000002be <fstat>:
 2be:	b8 08 00 00 00       	mov    $0x8,%eax
 2c3:	cd 40                	int    $0x40
 2c5:	c3                   	ret    

000002c6 <link>:
 2c6:	b8 13 00 00 00       	mov    $0x13,%eax
 2cb:	cd 40                	int    $0x40
 2cd:	c3                   	ret    

000002ce <mkdir>:
 2ce:	b8 14 00 00 00       	mov    $0x14,%eax
 2d3:	cd 40                	int    $0x40
 2d5:	c3                   	ret    

000002d6 <chdir>:
 2d6:	b8 09 00 00 00       	mov    $0x9,%eax
 2db:	cd 40                	int    $0x40
 2dd:	c3                   	ret    

000002de <dup>:
 2de:	b8 0a 00 00 00       	mov    $0xa,%eax
 2e3:	cd 40                	int    $0x40
 2e5:	c3                   	ret    

000002e6 <getpid>:
 2e6:	b8 0b 00 00 00       	mov    $0xb,%eax
 2eb:	cd 40                	int    $0x40
 2ed:	c3                   	ret    

000002ee <sbrk>:
 2ee:	b8 0c 00 00 00       	mov    $0xc,%eax
 2f3:	cd 40                	int    $0x40
 2f5:	c3                   	ret    

000002f6 <sleep>:
 2f6:	b8 0d 00 00 00       	mov    $0xd,%eax
 2fb:	cd 40                	int    $0x40
 2fd:	c3                   	ret    

000002fe <uptime>:
 2fe:	b8 0e 00 00 00       	mov    $0xe,%eax
 303:	cd 40                	int    $0x40
 305:	c3                   	ret    

00000306 <putc>:
 306:	55                   	push   %ebp
 307:	89 e5                	mov    %esp,%ebp
 309:	83 ec 18             	sub    $0x18,%esp
 30c:	8b 45 0c             	mov    0xc(%ebp),%eax
 30f:	88 45 f4             	mov    %al,-0xc(%ebp)
 312:	83 ec 04             	sub    $0x4,%esp
 315:	6a 01                	push   $0x1
 317:	8d 45 f4             	lea    -0xc(%ebp),%eax
 31a:	50                   	push   %eax
 31b:	ff 75 08             	pushl  0x8(%ebp)
 31e:	e8 63 ff ff ff       	call   286 <write>
 323:	83 c4 10             	add    $0x10,%esp
 326:	c9                   	leave  
 327:	c3                   	ret    

00000328 <printint>:
 328:	55                   	push   %ebp
 329:	89 e5                	mov    %esp,%ebp
 32b:	53                   	push   %ebx
 32c:	83 ec 24             	sub    $0x24,%esp
 32f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 336:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 33a:	74 17                	je     353 <printint+0x2b>
 33c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 340:	79 11                	jns    353 <printint+0x2b>
 342:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 349:	8b 45 0c             	mov    0xc(%ebp),%eax
 34c:	f7 d8                	neg    %eax
 34e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 351:	eb 06                	jmp    359 <printint+0x31>
 353:	8b 45 0c             	mov    0xc(%ebp),%eax
 356:	89 45 ec             	mov    %eax,-0x14(%ebp)
 359:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 360:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 363:	8d 41 01             	lea    0x1(%ecx),%eax
 366:	89 45 f4             	mov    %eax,-0xc(%ebp)
 369:	8b 5d 10             	mov    0x10(%ebp),%ebx
 36c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 36f:	ba 00 00 00 00       	mov    $0x0,%edx
 374:	f7 f3                	div    %ebx
 376:	89 d0                	mov    %edx,%eax
 378:	8a 80 e4 09 00 00    	mov    0x9e4(%eax),%al
 37e:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
 382:	8b 5d 10             	mov    0x10(%ebp),%ebx
 385:	8b 45 ec             	mov    -0x14(%ebp),%eax
 388:	ba 00 00 00 00       	mov    $0x0,%edx
 38d:	f7 f3                	div    %ebx
 38f:	89 45 ec             	mov    %eax,-0x14(%ebp)
 392:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 396:	75 c8                	jne    360 <printint+0x38>
 398:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 39c:	74 0e                	je     3ac <printint+0x84>
 39e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3a1:	8d 50 01             	lea    0x1(%eax),%edx
 3a4:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3a7:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
 3ac:	eb 1c                	jmp    3ca <printint+0xa2>
 3ae:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3b4:	01 d0                	add    %edx,%eax
 3b6:	8a 00                	mov    (%eax),%al
 3b8:	0f be c0             	movsbl %al,%eax
 3bb:	83 ec 08             	sub    $0x8,%esp
 3be:	50                   	push   %eax
 3bf:	ff 75 08             	pushl  0x8(%ebp)
 3c2:	e8 3f ff ff ff       	call   306 <putc>
 3c7:	83 c4 10             	add    $0x10,%esp
 3ca:	ff 4d f4             	decl   -0xc(%ebp)
 3cd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 3d1:	79 db                	jns    3ae <printint+0x86>
 3d3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3d6:	c9                   	leave  
 3d7:	c3                   	ret    

000003d8 <printf>:
 3d8:	55                   	push   %ebp
 3d9:	89 e5                	mov    %esp,%ebp
 3db:	83 ec 28             	sub    $0x28,%esp
 3de:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 3e5:	8d 45 0c             	lea    0xc(%ebp),%eax
 3e8:	83 c0 04             	add    $0x4,%eax
 3eb:	89 45 e8             	mov    %eax,-0x18(%ebp)
 3ee:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 3f5:	e9 54 01 00 00       	jmp    54e <printf+0x176>
 3fa:	8b 55 0c             	mov    0xc(%ebp),%edx
 3fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 400:	01 d0                	add    %edx,%eax
 402:	8a 00                	mov    (%eax),%al
 404:	0f be c0             	movsbl %al,%eax
 407:	25 ff 00 00 00       	and    $0xff,%eax
 40c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 40f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 413:	75 2c                	jne    441 <printf+0x69>
 415:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 419:	75 0c                	jne    427 <printf+0x4f>
 41b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 422:	e9 24 01 00 00       	jmp    54b <printf+0x173>
 427:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 42a:	0f be c0             	movsbl %al,%eax
 42d:	83 ec 08             	sub    $0x8,%esp
 430:	50                   	push   %eax
 431:	ff 75 08             	pushl  0x8(%ebp)
 434:	e8 cd fe ff ff       	call   306 <putc>
 439:	83 c4 10             	add    $0x10,%esp
 43c:	e9 0a 01 00 00       	jmp    54b <printf+0x173>
 441:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 445:	0f 85 00 01 00 00    	jne    54b <printf+0x173>
 44b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 44f:	75 1e                	jne    46f <printf+0x97>
 451:	8b 45 e8             	mov    -0x18(%ebp),%eax
 454:	8b 00                	mov    (%eax),%eax
 456:	6a 01                	push   $0x1
 458:	6a 0a                	push   $0xa
 45a:	50                   	push   %eax
 45b:	ff 75 08             	pushl  0x8(%ebp)
 45e:	e8 c5 fe ff ff       	call   328 <printint>
 463:	83 c4 10             	add    $0x10,%esp
 466:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 46a:	e9 d5 00 00 00       	jmp    544 <printf+0x16c>
 46f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 473:	74 06                	je     47b <printf+0xa3>
 475:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 479:	75 1e                	jne    499 <printf+0xc1>
 47b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 47e:	8b 00                	mov    (%eax),%eax
 480:	6a 00                	push   $0x0
 482:	6a 10                	push   $0x10
 484:	50                   	push   %eax
 485:	ff 75 08             	pushl  0x8(%ebp)
 488:	e8 9b fe ff ff       	call   328 <printint>
 48d:	83 c4 10             	add    $0x10,%esp
 490:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 494:	e9 ab 00 00 00       	jmp    544 <printf+0x16c>
 499:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 49d:	75 40                	jne    4df <printf+0x107>
 49f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4a2:	8b 00                	mov    (%eax),%eax
 4a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4a7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4ab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4af:	75 07                	jne    4b8 <printf+0xe0>
 4b1:	c7 45 f4 92 07 00 00 	movl   $0x792,-0xc(%ebp)
 4b8:	eb 1a                	jmp    4d4 <printf+0xfc>
 4ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4bd:	8a 00                	mov    (%eax),%al
 4bf:	0f be c0             	movsbl %al,%eax
 4c2:	83 ec 08             	sub    $0x8,%esp
 4c5:	50                   	push   %eax
 4c6:	ff 75 08             	pushl  0x8(%ebp)
 4c9:	e8 38 fe ff ff       	call   306 <putc>
 4ce:	83 c4 10             	add    $0x10,%esp
 4d1:	ff 45 f4             	incl   -0xc(%ebp)
 4d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4d7:	8a 00                	mov    (%eax),%al
 4d9:	84 c0                	test   %al,%al
 4db:	75 dd                	jne    4ba <printf+0xe2>
 4dd:	eb 65                	jmp    544 <printf+0x16c>
 4df:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 4e3:	75 1d                	jne    502 <printf+0x12a>
 4e5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e8:	8b 00                	mov    (%eax),%eax
 4ea:	0f be c0             	movsbl %al,%eax
 4ed:	83 ec 08             	sub    $0x8,%esp
 4f0:	50                   	push   %eax
 4f1:	ff 75 08             	pushl  0x8(%ebp)
 4f4:	e8 0d fe ff ff       	call   306 <putc>
 4f9:	83 c4 10             	add    $0x10,%esp
 4fc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 500:	eb 42                	jmp    544 <printf+0x16c>
 502:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 506:	75 17                	jne    51f <printf+0x147>
 508:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 50b:	0f be c0             	movsbl %al,%eax
 50e:	83 ec 08             	sub    $0x8,%esp
 511:	50                   	push   %eax
 512:	ff 75 08             	pushl  0x8(%ebp)
 515:	e8 ec fd ff ff       	call   306 <putc>
 51a:	83 c4 10             	add    $0x10,%esp
 51d:	eb 25                	jmp    544 <printf+0x16c>
 51f:	83 ec 08             	sub    $0x8,%esp
 522:	6a 25                	push   $0x25
 524:	ff 75 08             	pushl  0x8(%ebp)
 527:	e8 da fd ff ff       	call   306 <putc>
 52c:	83 c4 10             	add    $0x10,%esp
 52f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 532:	0f be c0             	movsbl %al,%eax
 535:	83 ec 08             	sub    $0x8,%esp
 538:	50                   	push   %eax
 539:	ff 75 08             	pushl  0x8(%ebp)
 53c:	e8 c5 fd ff ff       	call   306 <putc>
 541:	83 c4 10             	add    $0x10,%esp
 544:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 54b:	ff 45 f0             	incl   -0x10(%ebp)
 54e:	8b 55 0c             	mov    0xc(%ebp),%edx
 551:	8b 45 f0             	mov    -0x10(%ebp),%eax
 554:	01 d0                	add    %edx,%eax
 556:	8a 00                	mov    (%eax),%al
 558:	84 c0                	test   %al,%al
 55a:	0f 85 9a fe ff ff    	jne    3fa <printf+0x22>
 560:	c9                   	leave  
 561:	c3                   	ret    

00000562 <free>:
 562:	55                   	push   %ebp
 563:	89 e5                	mov    %esp,%ebp
 565:	83 ec 10             	sub    $0x10,%esp
 568:	8b 45 08             	mov    0x8(%ebp),%eax
 56b:	83 e8 08             	sub    $0x8,%eax
 56e:	89 45 f8             	mov    %eax,-0x8(%ebp)
 571:	a1 00 0a 00 00       	mov    0xa00,%eax
 576:	89 45 fc             	mov    %eax,-0x4(%ebp)
 579:	eb 24                	jmp    59f <free+0x3d>
 57b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 57e:	8b 00                	mov    (%eax),%eax
 580:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 583:	77 12                	ja     597 <free+0x35>
 585:	8b 45 f8             	mov    -0x8(%ebp),%eax
 588:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 58b:	77 24                	ja     5b1 <free+0x4f>
 58d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 590:	8b 00                	mov    (%eax),%eax
 592:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 595:	77 1a                	ja     5b1 <free+0x4f>
 597:	8b 45 fc             	mov    -0x4(%ebp),%eax
 59a:	8b 00                	mov    (%eax),%eax
 59c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 59f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5a2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5a5:	76 d4                	jbe    57b <free+0x19>
 5a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5aa:	8b 00                	mov    (%eax),%eax
 5ac:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5af:	76 ca                	jbe    57b <free+0x19>
 5b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5b4:	8b 40 04             	mov    0x4(%eax),%eax
 5b7:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 5be:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5c1:	01 c2                	add    %eax,%edx
 5c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5c6:	8b 00                	mov    (%eax),%eax
 5c8:	39 c2                	cmp    %eax,%edx
 5ca:	75 24                	jne    5f0 <free+0x8e>
 5cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5cf:	8b 50 04             	mov    0x4(%eax),%edx
 5d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5d5:	8b 00                	mov    (%eax),%eax
 5d7:	8b 40 04             	mov    0x4(%eax),%eax
 5da:	01 c2                	add    %eax,%edx
 5dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5df:	89 50 04             	mov    %edx,0x4(%eax)
 5e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e5:	8b 00                	mov    (%eax),%eax
 5e7:	8b 10                	mov    (%eax),%edx
 5e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5ec:	89 10                	mov    %edx,(%eax)
 5ee:	eb 0a                	jmp    5fa <free+0x98>
 5f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f3:	8b 10                	mov    (%eax),%edx
 5f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f8:	89 10                	mov    %edx,(%eax)
 5fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5fd:	8b 40 04             	mov    0x4(%eax),%eax
 600:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 607:	8b 45 fc             	mov    -0x4(%ebp),%eax
 60a:	01 d0                	add    %edx,%eax
 60c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 60f:	75 20                	jne    631 <free+0xcf>
 611:	8b 45 fc             	mov    -0x4(%ebp),%eax
 614:	8b 50 04             	mov    0x4(%eax),%edx
 617:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61a:	8b 40 04             	mov    0x4(%eax),%eax
 61d:	01 c2                	add    %eax,%edx
 61f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 622:	89 50 04             	mov    %edx,0x4(%eax)
 625:	8b 45 f8             	mov    -0x8(%ebp),%eax
 628:	8b 10                	mov    (%eax),%edx
 62a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62d:	89 10                	mov    %edx,(%eax)
 62f:	eb 08                	jmp    639 <free+0xd7>
 631:	8b 45 fc             	mov    -0x4(%ebp),%eax
 634:	8b 55 f8             	mov    -0x8(%ebp),%edx
 637:	89 10                	mov    %edx,(%eax)
 639:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63c:	a3 00 0a 00 00       	mov    %eax,0xa00
 641:	c9                   	leave  
 642:	c3                   	ret    

00000643 <morecore>:
 643:	55                   	push   %ebp
 644:	89 e5                	mov    %esp,%ebp
 646:	83 ec 18             	sub    $0x18,%esp
 649:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 650:	77 07                	ja     659 <morecore+0x16>
 652:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 659:	8b 45 08             	mov    0x8(%ebp),%eax
 65c:	c1 e0 03             	shl    $0x3,%eax
 65f:	83 ec 0c             	sub    $0xc,%esp
 662:	50                   	push   %eax
 663:	e8 86 fc ff ff       	call   2ee <sbrk>
 668:	83 c4 10             	add    $0x10,%esp
 66b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 66e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 672:	75 07                	jne    67b <morecore+0x38>
 674:	b8 00 00 00 00       	mov    $0x0,%eax
 679:	eb 26                	jmp    6a1 <morecore+0x5e>
 67b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 67e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 681:	8b 45 f0             	mov    -0x10(%ebp),%eax
 684:	8b 55 08             	mov    0x8(%ebp),%edx
 687:	89 50 04             	mov    %edx,0x4(%eax)
 68a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 68d:	83 c0 08             	add    $0x8,%eax
 690:	83 ec 0c             	sub    $0xc,%esp
 693:	50                   	push   %eax
 694:	e8 c9 fe ff ff       	call   562 <free>
 699:	83 c4 10             	add    $0x10,%esp
 69c:	a1 00 0a 00 00       	mov    0xa00,%eax
 6a1:	c9                   	leave  
 6a2:	c3                   	ret    

000006a3 <malloc>:
 6a3:	55                   	push   %ebp
 6a4:	89 e5                	mov    %esp,%ebp
 6a6:	83 ec 18             	sub    $0x18,%esp
 6a9:	8b 45 08             	mov    0x8(%ebp),%eax
 6ac:	83 c0 07             	add    $0x7,%eax
 6af:	c1 e8 03             	shr    $0x3,%eax
 6b2:	40                   	inc    %eax
 6b3:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6b6:	a1 00 0a 00 00       	mov    0xa00,%eax
 6bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
 6be:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6c2:	75 23                	jne    6e7 <malloc+0x44>
 6c4:	c7 45 f0 f8 09 00 00 	movl   $0x9f8,-0x10(%ebp)
 6cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6ce:	a3 00 0a 00 00       	mov    %eax,0xa00
 6d3:	a1 00 0a 00 00       	mov    0xa00,%eax
 6d8:	a3 f8 09 00 00       	mov    %eax,0x9f8
 6dd:	c7 05 fc 09 00 00 00 	movl   $0x0,0x9fc
 6e4:	00 00 00 
 6e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6ea:	8b 00                	mov    (%eax),%eax
 6ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
 6ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6f2:	8b 40 04             	mov    0x4(%eax),%eax
 6f5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 6f8:	72 4d                	jb     747 <malloc+0xa4>
 6fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6fd:	8b 40 04             	mov    0x4(%eax),%eax
 700:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 703:	75 0c                	jne    711 <malloc+0x6e>
 705:	8b 45 f4             	mov    -0xc(%ebp),%eax
 708:	8b 10                	mov    (%eax),%edx
 70a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 70d:	89 10                	mov    %edx,(%eax)
 70f:	eb 26                	jmp    737 <malloc+0x94>
 711:	8b 45 f4             	mov    -0xc(%ebp),%eax
 714:	8b 40 04             	mov    0x4(%eax),%eax
 717:	2b 45 ec             	sub    -0x14(%ebp),%eax
 71a:	89 c2                	mov    %eax,%edx
 71c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 71f:	89 50 04             	mov    %edx,0x4(%eax)
 722:	8b 45 f4             	mov    -0xc(%ebp),%eax
 725:	8b 40 04             	mov    0x4(%eax),%eax
 728:	c1 e0 03             	shl    $0x3,%eax
 72b:	01 45 f4             	add    %eax,-0xc(%ebp)
 72e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 731:	8b 55 ec             	mov    -0x14(%ebp),%edx
 734:	89 50 04             	mov    %edx,0x4(%eax)
 737:	8b 45 f0             	mov    -0x10(%ebp),%eax
 73a:	a3 00 0a 00 00       	mov    %eax,0xa00
 73f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 742:	83 c0 08             	add    $0x8,%eax
 745:	eb 3b                	jmp    782 <malloc+0xdf>
 747:	a1 00 0a 00 00       	mov    0xa00,%eax
 74c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 74f:	75 1e                	jne    76f <malloc+0xcc>
 751:	83 ec 0c             	sub    $0xc,%esp
 754:	ff 75 ec             	pushl  -0x14(%ebp)
 757:	e8 e7 fe ff ff       	call   643 <morecore>
 75c:	83 c4 10             	add    $0x10,%esp
 75f:	89 45 f4             	mov    %eax,-0xc(%ebp)
 762:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 766:	75 07                	jne    76f <malloc+0xcc>
 768:	b8 00 00 00 00       	mov    $0x0,%eax
 76d:	eb 13                	jmp    782 <malloc+0xdf>
 76f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 772:	89 45 f0             	mov    %eax,-0x10(%ebp)
 775:	8b 45 f4             	mov    -0xc(%ebp),%eax
 778:	8b 00                	mov    (%eax),%eax
 77a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 77d:	e9 6d ff ff ff       	jmp    6ef <malloc+0x4c>
 782:	c9                   	leave  
 783:	c3                   	ret    
