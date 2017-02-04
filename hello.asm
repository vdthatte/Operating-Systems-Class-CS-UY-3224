
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
  14:	68 8c 07 00 00       	push   $0x78c
  19:	6a 01                	push   $0x1
  1b:	e8 c0 03 00 00       	call   3e0 <printf>
  20:	83 c4 10             	add    $0x10,%esp
	return 0;	
  23:	b8 00 00 00 00       	mov    $0x0,%eax
}
  28:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  2b:	c9                   	leave  
  2c:	8d 61 fc             	lea    -0x4(%ecx),%esp
  2f:	c3                   	ret    

00000030 <stosb>:
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	57                   	push   %edi
  34:	53                   	push   %ebx
  35:	8b 4d 08             	mov    0x8(%ebp),%ecx
  38:	8b 55 10             	mov    0x10(%ebp),%edx
  3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  3e:	89 cb                	mov    %ecx,%ebx
  40:	89 df                	mov    %ebx,%edi
  42:	89 d1                	mov    %edx,%ecx
  44:	fc                   	cld    
  45:	f3 aa                	rep stos %al,%es:(%edi)
  47:	89 ca                	mov    %ecx,%edx
  49:	89 fb                	mov    %edi,%ebx
  4b:	89 5d 08             	mov    %ebx,0x8(%ebp)
  4e:	89 55 10             	mov    %edx,0x10(%ebp)
  51:	5b                   	pop    %ebx
  52:	5f                   	pop    %edi
  53:	5d                   	pop    %ebp
  54:	c3                   	ret    

00000055 <strcpy>:
  55:	55                   	push   %ebp
  56:	89 e5                	mov    %esp,%ebp
  58:	83 ec 10             	sub    $0x10,%esp
  5b:	8b 45 08             	mov    0x8(%ebp),%eax
  5e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  61:	90                   	nop
  62:	8b 45 08             	mov    0x8(%ebp),%eax
  65:	8d 50 01             	lea    0x1(%eax),%edx
  68:	89 55 08             	mov    %edx,0x8(%ebp)
  6b:	8b 55 0c             	mov    0xc(%ebp),%edx
  6e:	8d 4a 01             	lea    0x1(%edx),%ecx
  71:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  74:	8a 12                	mov    (%edx),%dl
  76:	88 10                	mov    %dl,(%eax)
  78:	8a 00                	mov    (%eax),%al
  7a:	84 c0                	test   %al,%al
  7c:	75 e4                	jne    62 <strcpy+0xd>
  7e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  81:	c9                   	leave  
  82:	c3                   	ret    

00000083 <strcmp>:
  83:	55                   	push   %ebp
  84:	89 e5                	mov    %esp,%ebp
  86:	eb 06                	jmp    8e <strcmp+0xb>
  88:	ff 45 08             	incl   0x8(%ebp)
  8b:	ff 45 0c             	incl   0xc(%ebp)
  8e:	8b 45 08             	mov    0x8(%ebp),%eax
  91:	8a 00                	mov    (%eax),%al
  93:	84 c0                	test   %al,%al
  95:	74 0e                	je     a5 <strcmp+0x22>
  97:	8b 45 08             	mov    0x8(%ebp),%eax
  9a:	8a 10                	mov    (%eax),%dl
  9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  9f:	8a 00                	mov    (%eax),%al
  a1:	38 c2                	cmp    %al,%dl
  a3:	74 e3                	je     88 <strcmp+0x5>
  a5:	8b 45 08             	mov    0x8(%ebp),%eax
  a8:	8a 00                	mov    (%eax),%al
  aa:	0f b6 d0             	movzbl %al,%edx
  ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  b0:	8a 00                	mov    (%eax),%al
  b2:	0f b6 c0             	movzbl %al,%eax
  b5:	29 c2                	sub    %eax,%edx
  b7:	89 d0                	mov    %edx,%eax
  b9:	5d                   	pop    %ebp
  ba:	c3                   	ret    

000000bb <strlen>:
  bb:	55                   	push   %ebp
  bc:	89 e5                	mov    %esp,%ebp
  be:	83 ec 10             	sub    $0x10,%esp
  c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  c8:	eb 03                	jmp    cd <strlen+0x12>
  ca:	ff 45 fc             	incl   -0x4(%ebp)
  cd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  d0:	8b 45 08             	mov    0x8(%ebp),%eax
  d3:	01 d0                	add    %edx,%eax
  d5:	8a 00                	mov    (%eax),%al
  d7:	84 c0                	test   %al,%al
  d9:	75 ef                	jne    ca <strlen+0xf>
  db:	8b 45 fc             	mov    -0x4(%ebp),%eax
  de:	c9                   	leave  
  df:	c3                   	ret    

000000e0 <memset>:
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 45 10             	mov    0x10(%ebp),%eax
  e6:	50                   	push   %eax
  e7:	ff 75 0c             	pushl  0xc(%ebp)
  ea:	ff 75 08             	pushl  0x8(%ebp)
  ed:	e8 3e ff ff ff       	call   30 <stosb>
  f2:	83 c4 0c             	add    $0xc,%esp
  f5:	8b 45 08             	mov    0x8(%ebp),%eax
  f8:	c9                   	leave  
  f9:	c3                   	ret    

000000fa <strchr>:
  fa:	55                   	push   %ebp
  fb:	89 e5                	mov    %esp,%ebp
  fd:	83 ec 04             	sub    $0x4,%esp
 100:	8b 45 0c             	mov    0xc(%ebp),%eax
 103:	88 45 fc             	mov    %al,-0x4(%ebp)
 106:	eb 12                	jmp    11a <strchr+0x20>
 108:	8b 45 08             	mov    0x8(%ebp),%eax
 10b:	8a 00                	mov    (%eax),%al
 10d:	3a 45 fc             	cmp    -0x4(%ebp),%al
 110:	75 05                	jne    117 <strchr+0x1d>
 112:	8b 45 08             	mov    0x8(%ebp),%eax
 115:	eb 11                	jmp    128 <strchr+0x2e>
 117:	ff 45 08             	incl   0x8(%ebp)
 11a:	8b 45 08             	mov    0x8(%ebp),%eax
 11d:	8a 00                	mov    (%eax),%al
 11f:	84 c0                	test   %al,%al
 121:	75 e5                	jne    108 <strchr+0xe>
 123:	b8 00 00 00 00       	mov    $0x0,%eax
 128:	c9                   	leave  
 129:	c3                   	ret    

0000012a <gets>:
 12a:	55                   	push   %ebp
 12b:	89 e5                	mov    %esp,%ebp
 12d:	83 ec 18             	sub    $0x18,%esp
 130:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 137:	eb 41                	jmp    17a <gets+0x50>
 139:	83 ec 04             	sub    $0x4,%esp
 13c:	6a 01                	push   $0x1
 13e:	8d 45 ef             	lea    -0x11(%ebp),%eax
 141:	50                   	push   %eax
 142:	6a 00                	push   $0x0
 144:	e8 3d 01 00 00       	call   286 <read>
 149:	83 c4 10             	add    $0x10,%esp
 14c:	89 45 f0             	mov    %eax,-0x10(%ebp)
 14f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 153:	7f 02                	jg     157 <gets+0x2d>
 155:	eb 2c                	jmp    183 <gets+0x59>
 157:	8b 45 f4             	mov    -0xc(%ebp),%eax
 15a:	8d 50 01             	lea    0x1(%eax),%edx
 15d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 160:	89 c2                	mov    %eax,%edx
 162:	8b 45 08             	mov    0x8(%ebp),%eax
 165:	01 c2                	add    %eax,%edx
 167:	8a 45 ef             	mov    -0x11(%ebp),%al
 16a:	88 02                	mov    %al,(%edx)
 16c:	8a 45 ef             	mov    -0x11(%ebp),%al
 16f:	3c 0a                	cmp    $0xa,%al
 171:	74 10                	je     183 <gets+0x59>
 173:	8a 45 ef             	mov    -0x11(%ebp),%al
 176:	3c 0d                	cmp    $0xd,%al
 178:	74 09                	je     183 <gets+0x59>
 17a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 17d:	40                   	inc    %eax
 17e:	3b 45 0c             	cmp    0xc(%ebp),%eax
 181:	7c b6                	jl     139 <gets+0xf>
 183:	8b 55 f4             	mov    -0xc(%ebp),%edx
 186:	8b 45 08             	mov    0x8(%ebp),%eax
 189:	01 d0                	add    %edx,%eax
 18b:	c6 00 00             	movb   $0x0,(%eax)
 18e:	8b 45 08             	mov    0x8(%ebp),%eax
 191:	c9                   	leave  
 192:	c3                   	ret    

00000193 <stat>:
 193:	55                   	push   %ebp
 194:	89 e5                	mov    %esp,%ebp
 196:	83 ec 18             	sub    $0x18,%esp
 199:	83 ec 08             	sub    $0x8,%esp
 19c:	6a 00                	push   $0x0
 19e:	ff 75 08             	pushl  0x8(%ebp)
 1a1:	e8 08 01 00 00       	call   2ae <open>
 1a6:	83 c4 10             	add    $0x10,%esp
 1a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
 1ac:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1b0:	79 07                	jns    1b9 <stat+0x26>
 1b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1b7:	eb 25                	jmp    1de <stat+0x4b>
 1b9:	83 ec 08             	sub    $0x8,%esp
 1bc:	ff 75 0c             	pushl  0xc(%ebp)
 1bf:	ff 75 f4             	pushl  -0xc(%ebp)
 1c2:	e8 ff 00 00 00       	call   2c6 <fstat>
 1c7:	83 c4 10             	add    $0x10,%esp
 1ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
 1cd:	83 ec 0c             	sub    $0xc,%esp
 1d0:	ff 75 f4             	pushl  -0xc(%ebp)
 1d3:	e8 be 00 00 00       	call   296 <close>
 1d8:	83 c4 10             	add    $0x10,%esp
 1db:	8b 45 f0             	mov    -0x10(%ebp),%eax
 1de:	c9                   	leave  
 1df:	c3                   	ret    

000001e0 <atoi>:
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	83 ec 10             	sub    $0x10,%esp
 1e6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1ed:	eb 24                	jmp    213 <atoi+0x33>
 1ef:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1f2:	89 d0                	mov    %edx,%eax
 1f4:	c1 e0 02             	shl    $0x2,%eax
 1f7:	01 d0                	add    %edx,%eax
 1f9:	01 c0                	add    %eax,%eax
 1fb:	89 c1                	mov    %eax,%ecx
 1fd:	8b 45 08             	mov    0x8(%ebp),%eax
 200:	8d 50 01             	lea    0x1(%eax),%edx
 203:	89 55 08             	mov    %edx,0x8(%ebp)
 206:	8a 00                	mov    (%eax),%al
 208:	0f be c0             	movsbl %al,%eax
 20b:	01 c8                	add    %ecx,%eax
 20d:	83 e8 30             	sub    $0x30,%eax
 210:	89 45 fc             	mov    %eax,-0x4(%ebp)
 213:	8b 45 08             	mov    0x8(%ebp),%eax
 216:	8a 00                	mov    (%eax),%al
 218:	3c 2f                	cmp    $0x2f,%al
 21a:	7e 09                	jle    225 <atoi+0x45>
 21c:	8b 45 08             	mov    0x8(%ebp),%eax
 21f:	8a 00                	mov    (%eax),%al
 221:	3c 39                	cmp    $0x39,%al
 223:	7e ca                	jle    1ef <atoi+0xf>
 225:	8b 45 fc             	mov    -0x4(%ebp),%eax
 228:	c9                   	leave  
 229:	c3                   	ret    

0000022a <memmove>:
 22a:	55                   	push   %ebp
 22b:	89 e5                	mov    %esp,%ebp
 22d:	83 ec 10             	sub    $0x10,%esp
 230:	8b 45 08             	mov    0x8(%ebp),%eax
 233:	89 45 fc             	mov    %eax,-0x4(%ebp)
 236:	8b 45 0c             	mov    0xc(%ebp),%eax
 239:	89 45 f8             	mov    %eax,-0x8(%ebp)
 23c:	eb 16                	jmp    254 <memmove+0x2a>
 23e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 241:	8d 50 01             	lea    0x1(%eax),%edx
 244:	89 55 fc             	mov    %edx,-0x4(%ebp)
 247:	8b 55 f8             	mov    -0x8(%ebp),%edx
 24a:	8d 4a 01             	lea    0x1(%edx),%ecx
 24d:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 250:	8a 12                	mov    (%edx),%dl
 252:	88 10                	mov    %dl,(%eax)
 254:	8b 45 10             	mov    0x10(%ebp),%eax
 257:	8d 50 ff             	lea    -0x1(%eax),%edx
 25a:	89 55 10             	mov    %edx,0x10(%ebp)
 25d:	85 c0                	test   %eax,%eax
 25f:	7f dd                	jg     23e <memmove+0x14>
 261:	8b 45 08             	mov    0x8(%ebp),%eax
 264:	c9                   	leave  
 265:	c3                   	ret    

00000266 <fork>:
 266:	b8 01 00 00 00       	mov    $0x1,%eax
 26b:	cd 40                	int    $0x40
 26d:	c3                   	ret    

0000026e <exit>:
 26e:	b8 02 00 00 00       	mov    $0x2,%eax
 273:	cd 40                	int    $0x40
 275:	c3                   	ret    

00000276 <wait>:
 276:	b8 03 00 00 00       	mov    $0x3,%eax
 27b:	cd 40                	int    $0x40
 27d:	c3                   	ret    

0000027e <pipe>:
 27e:	b8 04 00 00 00       	mov    $0x4,%eax
 283:	cd 40                	int    $0x40
 285:	c3                   	ret    

00000286 <read>:
 286:	b8 05 00 00 00       	mov    $0x5,%eax
 28b:	cd 40                	int    $0x40
 28d:	c3                   	ret    

0000028e <write>:
 28e:	b8 10 00 00 00       	mov    $0x10,%eax
 293:	cd 40                	int    $0x40
 295:	c3                   	ret    

00000296 <close>:
 296:	b8 15 00 00 00       	mov    $0x15,%eax
 29b:	cd 40                	int    $0x40
 29d:	c3                   	ret    

0000029e <kill>:
 29e:	b8 06 00 00 00       	mov    $0x6,%eax
 2a3:	cd 40                	int    $0x40
 2a5:	c3                   	ret    

000002a6 <exec>:
 2a6:	b8 07 00 00 00       	mov    $0x7,%eax
 2ab:	cd 40                	int    $0x40
 2ad:	c3                   	ret    

000002ae <open>:
 2ae:	b8 0f 00 00 00       	mov    $0xf,%eax
 2b3:	cd 40                	int    $0x40
 2b5:	c3                   	ret    

000002b6 <mknod>:
 2b6:	b8 11 00 00 00       	mov    $0x11,%eax
 2bb:	cd 40                	int    $0x40
 2bd:	c3                   	ret    

000002be <unlink>:
 2be:	b8 12 00 00 00       	mov    $0x12,%eax
 2c3:	cd 40                	int    $0x40
 2c5:	c3                   	ret    

000002c6 <fstat>:
 2c6:	b8 08 00 00 00       	mov    $0x8,%eax
 2cb:	cd 40                	int    $0x40
 2cd:	c3                   	ret    

000002ce <link>:
 2ce:	b8 13 00 00 00       	mov    $0x13,%eax
 2d3:	cd 40                	int    $0x40
 2d5:	c3                   	ret    

000002d6 <mkdir>:
 2d6:	b8 14 00 00 00       	mov    $0x14,%eax
 2db:	cd 40                	int    $0x40
 2dd:	c3                   	ret    

000002de <chdir>:
 2de:	b8 09 00 00 00       	mov    $0x9,%eax
 2e3:	cd 40                	int    $0x40
 2e5:	c3                   	ret    

000002e6 <dup>:
 2e6:	b8 0a 00 00 00       	mov    $0xa,%eax
 2eb:	cd 40                	int    $0x40
 2ed:	c3                   	ret    

000002ee <getpid>:
 2ee:	b8 0b 00 00 00       	mov    $0xb,%eax
 2f3:	cd 40                	int    $0x40
 2f5:	c3                   	ret    

000002f6 <sbrk>:
 2f6:	b8 0c 00 00 00       	mov    $0xc,%eax
 2fb:	cd 40                	int    $0x40
 2fd:	c3                   	ret    

000002fe <sleep>:
 2fe:	b8 0d 00 00 00       	mov    $0xd,%eax
 303:	cd 40                	int    $0x40
 305:	c3                   	ret    

00000306 <uptime>:
 306:	b8 0e 00 00 00       	mov    $0xe,%eax
 30b:	cd 40                	int    $0x40
 30d:	c3                   	ret    

0000030e <putc>:
 30e:	55                   	push   %ebp
 30f:	89 e5                	mov    %esp,%ebp
 311:	83 ec 18             	sub    $0x18,%esp
 314:	8b 45 0c             	mov    0xc(%ebp),%eax
 317:	88 45 f4             	mov    %al,-0xc(%ebp)
 31a:	83 ec 04             	sub    $0x4,%esp
 31d:	6a 01                	push   $0x1
 31f:	8d 45 f4             	lea    -0xc(%ebp),%eax
 322:	50                   	push   %eax
 323:	ff 75 08             	pushl  0x8(%ebp)
 326:	e8 63 ff ff ff       	call   28e <write>
 32b:	83 c4 10             	add    $0x10,%esp
 32e:	c9                   	leave  
 32f:	c3                   	ret    

00000330 <printint>:
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	53                   	push   %ebx
 334:	83 ec 24             	sub    $0x24,%esp
 337:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 33e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 342:	74 17                	je     35b <printint+0x2b>
 344:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 348:	79 11                	jns    35b <printint+0x2b>
 34a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 351:	8b 45 0c             	mov    0xc(%ebp),%eax
 354:	f7 d8                	neg    %eax
 356:	89 45 ec             	mov    %eax,-0x14(%ebp)
 359:	eb 06                	jmp    361 <printint+0x31>
 35b:	8b 45 0c             	mov    0xc(%ebp),%eax
 35e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 361:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 368:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 36b:	8d 41 01             	lea    0x1(%ecx),%eax
 36e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 371:	8b 5d 10             	mov    0x10(%ebp),%ebx
 374:	8b 45 ec             	mov    -0x14(%ebp),%eax
 377:	ba 00 00 00 00       	mov    $0x0,%edx
 37c:	f7 f3                	div    %ebx
 37e:	89 d0                	mov    %edx,%eax
 380:	8a 80 f4 09 00 00    	mov    0x9f4(%eax),%al
 386:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
 38a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 38d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 390:	ba 00 00 00 00       	mov    $0x0,%edx
 395:	f7 f3                	div    %ebx
 397:	89 45 ec             	mov    %eax,-0x14(%ebp)
 39a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 39e:	75 c8                	jne    368 <printint+0x38>
 3a0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3a4:	74 0e                	je     3b4 <printint+0x84>
 3a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3a9:	8d 50 01             	lea    0x1(%eax),%edx
 3ac:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3af:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
 3b4:	eb 1c                	jmp    3d2 <printint+0xa2>
 3b6:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3bc:	01 d0                	add    %edx,%eax
 3be:	8a 00                	mov    (%eax),%al
 3c0:	0f be c0             	movsbl %al,%eax
 3c3:	83 ec 08             	sub    $0x8,%esp
 3c6:	50                   	push   %eax
 3c7:	ff 75 08             	pushl  0x8(%ebp)
 3ca:	e8 3f ff ff ff       	call   30e <putc>
 3cf:	83 c4 10             	add    $0x10,%esp
 3d2:	ff 4d f4             	decl   -0xc(%ebp)
 3d5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 3d9:	79 db                	jns    3b6 <printint+0x86>
 3db:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3de:	c9                   	leave  
 3df:	c3                   	ret    

000003e0 <printf>:
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	83 ec 28             	sub    $0x28,%esp
 3e6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 3ed:	8d 45 0c             	lea    0xc(%ebp),%eax
 3f0:	83 c0 04             	add    $0x4,%eax
 3f3:	89 45 e8             	mov    %eax,-0x18(%ebp)
 3f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 3fd:	e9 54 01 00 00       	jmp    556 <printf+0x176>
 402:	8b 55 0c             	mov    0xc(%ebp),%edx
 405:	8b 45 f0             	mov    -0x10(%ebp),%eax
 408:	01 d0                	add    %edx,%eax
 40a:	8a 00                	mov    (%eax),%al
 40c:	0f be c0             	movsbl %al,%eax
 40f:	25 ff 00 00 00       	and    $0xff,%eax
 414:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 417:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 41b:	75 2c                	jne    449 <printf+0x69>
 41d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 421:	75 0c                	jne    42f <printf+0x4f>
 423:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 42a:	e9 24 01 00 00       	jmp    553 <printf+0x173>
 42f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 432:	0f be c0             	movsbl %al,%eax
 435:	83 ec 08             	sub    $0x8,%esp
 438:	50                   	push   %eax
 439:	ff 75 08             	pushl  0x8(%ebp)
 43c:	e8 cd fe ff ff       	call   30e <putc>
 441:	83 c4 10             	add    $0x10,%esp
 444:	e9 0a 01 00 00       	jmp    553 <printf+0x173>
 449:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 44d:	0f 85 00 01 00 00    	jne    553 <printf+0x173>
 453:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 457:	75 1e                	jne    477 <printf+0x97>
 459:	8b 45 e8             	mov    -0x18(%ebp),%eax
 45c:	8b 00                	mov    (%eax),%eax
 45e:	6a 01                	push   $0x1
 460:	6a 0a                	push   $0xa
 462:	50                   	push   %eax
 463:	ff 75 08             	pushl  0x8(%ebp)
 466:	e8 c5 fe ff ff       	call   330 <printint>
 46b:	83 c4 10             	add    $0x10,%esp
 46e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 472:	e9 d5 00 00 00       	jmp    54c <printf+0x16c>
 477:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 47b:	74 06                	je     483 <printf+0xa3>
 47d:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 481:	75 1e                	jne    4a1 <printf+0xc1>
 483:	8b 45 e8             	mov    -0x18(%ebp),%eax
 486:	8b 00                	mov    (%eax),%eax
 488:	6a 00                	push   $0x0
 48a:	6a 10                	push   $0x10
 48c:	50                   	push   %eax
 48d:	ff 75 08             	pushl  0x8(%ebp)
 490:	e8 9b fe ff ff       	call   330 <printint>
 495:	83 c4 10             	add    $0x10,%esp
 498:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 49c:	e9 ab 00 00 00       	jmp    54c <printf+0x16c>
 4a1:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4a5:	75 40                	jne    4e7 <printf+0x107>
 4a7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4aa:	8b 00                	mov    (%eax),%eax
 4ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4af:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4b3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4b7:	75 07                	jne    4c0 <printf+0xe0>
 4b9:	c7 45 f4 9a 07 00 00 	movl   $0x79a,-0xc(%ebp)
 4c0:	eb 1a                	jmp    4dc <printf+0xfc>
 4c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4c5:	8a 00                	mov    (%eax),%al
 4c7:	0f be c0             	movsbl %al,%eax
 4ca:	83 ec 08             	sub    $0x8,%esp
 4cd:	50                   	push   %eax
 4ce:	ff 75 08             	pushl  0x8(%ebp)
 4d1:	e8 38 fe ff ff       	call   30e <putc>
 4d6:	83 c4 10             	add    $0x10,%esp
 4d9:	ff 45 f4             	incl   -0xc(%ebp)
 4dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4df:	8a 00                	mov    (%eax),%al
 4e1:	84 c0                	test   %al,%al
 4e3:	75 dd                	jne    4c2 <printf+0xe2>
 4e5:	eb 65                	jmp    54c <printf+0x16c>
 4e7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 4eb:	75 1d                	jne    50a <printf+0x12a>
 4ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4f0:	8b 00                	mov    (%eax),%eax
 4f2:	0f be c0             	movsbl %al,%eax
 4f5:	83 ec 08             	sub    $0x8,%esp
 4f8:	50                   	push   %eax
 4f9:	ff 75 08             	pushl  0x8(%ebp)
 4fc:	e8 0d fe ff ff       	call   30e <putc>
 501:	83 c4 10             	add    $0x10,%esp
 504:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 508:	eb 42                	jmp    54c <printf+0x16c>
 50a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 50e:	75 17                	jne    527 <printf+0x147>
 510:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 513:	0f be c0             	movsbl %al,%eax
 516:	83 ec 08             	sub    $0x8,%esp
 519:	50                   	push   %eax
 51a:	ff 75 08             	pushl  0x8(%ebp)
 51d:	e8 ec fd ff ff       	call   30e <putc>
 522:	83 c4 10             	add    $0x10,%esp
 525:	eb 25                	jmp    54c <printf+0x16c>
 527:	83 ec 08             	sub    $0x8,%esp
 52a:	6a 25                	push   $0x25
 52c:	ff 75 08             	pushl  0x8(%ebp)
 52f:	e8 da fd ff ff       	call   30e <putc>
 534:	83 c4 10             	add    $0x10,%esp
 537:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 53a:	0f be c0             	movsbl %al,%eax
 53d:	83 ec 08             	sub    $0x8,%esp
 540:	50                   	push   %eax
 541:	ff 75 08             	pushl  0x8(%ebp)
 544:	e8 c5 fd ff ff       	call   30e <putc>
 549:	83 c4 10             	add    $0x10,%esp
 54c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 553:	ff 45 f0             	incl   -0x10(%ebp)
 556:	8b 55 0c             	mov    0xc(%ebp),%edx
 559:	8b 45 f0             	mov    -0x10(%ebp),%eax
 55c:	01 d0                	add    %edx,%eax
 55e:	8a 00                	mov    (%eax),%al
 560:	84 c0                	test   %al,%al
 562:	0f 85 9a fe ff ff    	jne    402 <printf+0x22>
 568:	c9                   	leave  
 569:	c3                   	ret    

0000056a <free>:
 56a:	55                   	push   %ebp
 56b:	89 e5                	mov    %esp,%ebp
 56d:	83 ec 10             	sub    $0x10,%esp
 570:	8b 45 08             	mov    0x8(%ebp),%eax
 573:	83 e8 08             	sub    $0x8,%eax
 576:	89 45 f8             	mov    %eax,-0x8(%ebp)
 579:	a1 10 0a 00 00       	mov    0xa10,%eax
 57e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 581:	eb 24                	jmp    5a7 <free+0x3d>
 583:	8b 45 fc             	mov    -0x4(%ebp),%eax
 586:	8b 00                	mov    (%eax),%eax
 588:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 58b:	77 12                	ja     59f <free+0x35>
 58d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 590:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 593:	77 24                	ja     5b9 <free+0x4f>
 595:	8b 45 fc             	mov    -0x4(%ebp),%eax
 598:	8b 00                	mov    (%eax),%eax
 59a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 59d:	77 1a                	ja     5b9 <free+0x4f>
 59f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5a2:	8b 00                	mov    (%eax),%eax
 5a4:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5aa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5ad:	76 d4                	jbe    583 <free+0x19>
 5af:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5b2:	8b 00                	mov    (%eax),%eax
 5b4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5b7:	76 ca                	jbe    583 <free+0x19>
 5b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5bc:	8b 40 04             	mov    0x4(%eax),%eax
 5bf:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 5c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5c9:	01 c2                	add    %eax,%edx
 5cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5ce:	8b 00                	mov    (%eax),%eax
 5d0:	39 c2                	cmp    %eax,%edx
 5d2:	75 24                	jne    5f8 <free+0x8e>
 5d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5d7:	8b 50 04             	mov    0x4(%eax),%edx
 5da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5dd:	8b 00                	mov    (%eax),%eax
 5df:	8b 40 04             	mov    0x4(%eax),%eax
 5e2:	01 c2                	add    %eax,%edx
 5e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5e7:	89 50 04             	mov    %edx,0x4(%eax)
 5ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5ed:	8b 00                	mov    (%eax),%eax
 5ef:	8b 10                	mov    (%eax),%edx
 5f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f4:	89 10                	mov    %edx,(%eax)
 5f6:	eb 0a                	jmp    602 <free+0x98>
 5f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5fb:	8b 10                	mov    (%eax),%edx
 5fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 600:	89 10                	mov    %edx,(%eax)
 602:	8b 45 fc             	mov    -0x4(%ebp),%eax
 605:	8b 40 04             	mov    0x4(%eax),%eax
 608:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 60f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 612:	01 d0                	add    %edx,%eax
 614:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 617:	75 20                	jne    639 <free+0xcf>
 619:	8b 45 fc             	mov    -0x4(%ebp),%eax
 61c:	8b 50 04             	mov    0x4(%eax),%edx
 61f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 622:	8b 40 04             	mov    0x4(%eax),%eax
 625:	01 c2                	add    %eax,%edx
 627:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62a:	89 50 04             	mov    %edx,0x4(%eax)
 62d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 630:	8b 10                	mov    (%eax),%edx
 632:	8b 45 fc             	mov    -0x4(%ebp),%eax
 635:	89 10                	mov    %edx,(%eax)
 637:	eb 08                	jmp    641 <free+0xd7>
 639:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 63f:	89 10                	mov    %edx,(%eax)
 641:	8b 45 fc             	mov    -0x4(%ebp),%eax
 644:	a3 10 0a 00 00       	mov    %eax,0xa10
 649:	c9                   	leave  
 64a:	c3                   	ret    

0000064b <morecore>:
 64b:	55                   	push   %ebp
 64c:	89 e5                	mov    %esp,%ebp
 64e:	83 ec 18             	sub    $0x18,%esp
 651:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 658:	77 07                	ja     661 <morecore+0x16>
 65a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 661:	8b 45 08             	mov    0x8(%ebp),%eax
 664:	c1 e0 03             	shl    $0x3,%eax
 667:	83 ec 0c             	sub    $0xc,%esp
 66a:	50                   	push   %eax
 66b:	e8 86 fc ff ff       	call   2f6 <sbrk>
 670:	83 c4 10             	add    $0x10,%esp
 673:	89 45 f4             	mov    %eax,-0xc(%ebp)
 676:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 67a:	75 07                	jne    683 <morecore+0x38>
 67c:	b8 00 00 00 00       	mov    $0x0,%eax
 681:	eb 26                	jmp    6a9 <morecore+0x5e>
 683:	8b 45 f4             	mov    -0xc(%ebp),%eax
 686:	89 45 f0             	mov    %eax,-0x10(%ebp)
 689:	8b 45 f0             	mov    -0x10(%ebp),%eax
 68c:	8b 55 08             	mov    0x8(%ebp),%edx
 68f:	89 50 04             	mov    %edx,0x4(%eax)
 692:	8b 45 f0             	mov    -0x10(%ebp),%eax
 695:	83 c0 08             	add    $0x8,%eax
 698:	83 ec 0c             	sub    $0xc,%esp
 69b:	50                   	push   %eax
 69c:	e8 c9 fe ff ff       	call   56a <free>
 6a1:	83 c4 10             	add    $0x10,%esp
 6a4:	a1 10 0a 00 00       	mov    0xa10,%eax
 6a9:	c9                   	leave  
 6aa:	c3                   	ret    

000006ab <malloc>:
 6ab:	55                   	push   %ebp
 6ac:	89 e5                	mov    %esp,%ebp
 6ae:	83 ec 18             	sub    $0x18,%esp
 6b1:	8b 45 08             	mov    0x8(%ebp),%eax
 6b4:	83 c0 07             	add    $0x7,%eax
 6b7:	c1 e8 03             	shr    $0x3,%eax
 6ba:	40                   	inc    %eax
 6bb:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6be:	a1 10 0a 00 00       	mov    0xa10,%eax
 6c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
 6c6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6ca:	75 23                	jne    6ef <malloc+0x44>
 6cc:	c7 45 f0 08 0a 00 00 	movl   $0xa08,-0x10(%ebp)
 6d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6d6:	a3 10 0a 00 00       	mov    %eax,0xa10
 6db:	a1 10 0a 00 00       	mov    0xa10,%eax
 6e0:	a3 08 0a 00 00       	mov    %eax,0xa08
 6e5:	c7 05 0c 0a 00 00 00 	movl   $0x0,0xa0c
 6ec:	00 00 00 
 6ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f2:	8b 00                	mov    (%eax),%eax
 6f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
 6f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6fa:	8b 40 04             	mov    0x4(%eax),%eax
 6fd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 700:	72 4d                	jb     74f <malloc+0xa4>
 702:	8b 45 f4             	mov    -0xc(%ebp),%eax
 705:	8b 40 04             	mov    0x4(%eax),%eax
 708:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 70b:	75 0c                	jne    719 <malloc+0x6e>
 70d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 710:	8b 10                	mov    (%eax),%edx
 712:	8b 45 f0             	mov    -0x10(%ebp),%eax
 715:	89 10                	mov    %edx,(%eax)
 717:	eb 26                	jmp    73f <malloc+0x94>
 719:	8b 45 f4             	mov    -0xc(%ebp),%eax
 71c:	8b 40 04             	mov    0x4(%eax),%eax
 71f:	2b 45 ec             	sub    -0x14(%ebp),%eax
 722:	89 c2                	mov    %eax,%edx
 724:	8b 45 f4             	mov    -0xc(%ebp),%eax
 727:	89 50 04             	mov    %edx,0x4(%eax)
 72a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 72d:	8b 40 04             	mov    0x4(%eax),%eax
 730:	c1 e0 03             	shl    $0x3,%eax
 733:	01 45 f4             	add    %eax,-0xc(%ebp)
 736:	8b 45 f4             	mov    -0xc(%ebp),%eax
 739:	8b 55 ec             	mov    -0x14(%ebp),%edx
 73c:	89 50 04             	mov    %edx,0x4(%eax)
 73f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 742:	a3 10 0a 00 00       	mov    %eax,0xa10
 747:	8b 45 f4             	mov    -0xc(%ebp),%eax
 74a:	83 c0 08             	add    $0x8,%eax
 74d:	eb 3b                	jmp    78a <malloc+0xdf>
 74f:	a1 10 0a 00 00       	mov    0xa10,%eax
 754:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 757:	75 1e                	jne    777 <malloc+0xcc>
 759:	83 ec 0c             	sub    $0xc,%esp
 75c:	ff 75 ec             	pushl  -0x14(%ebp)
 75f:	e8 e7 fe ff ff       	call   64b <morecore>
 764:	83 c4 10             	add    $0x10,%esp
 767:	89 45 f4             	mov    %eax,-0xc(%ebp)
 76a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 76e:	75 07                	jne    777 <malloc+0xcc>
 770:	b8 00 00 00 00       	mov    $0x0,%eax
 775:	eb 13                	jmp    78a <malloc+0xdf>
 777:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77a:	89 45 f0             	mov    %eax,-0x10(%ebp)
 77d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 780:	8b 00                	mov    (%eax),%eax
 782:	89 45 f4             	mov    %eax,-0xc(%ebp)
 785:	e9 6d ff ff ff       	jmp    6f7 <malloc+0x4c>
 78a:	c9                   	leave  
 78b:	c3                   	ret    
