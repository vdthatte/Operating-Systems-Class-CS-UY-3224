
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <iputtest>:
int stdout = 1;

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "iput test\n");
       6:	a1 8c 62 00 00       	mov    0x628c,%eax
       b:	83 ec 08             	sub    $0x8,%esp
       e:	68 c6 43 00 00       	push   $0x43c6
      13:	50                   	push   %eax
      14:	e8 e8 3f 00 00       	call   4001 <printf>
      19:	83 c4 10             	add    $0x10,%esp

  if(mkdir("iputdir") < 0){
      1c:	83 ec 0c             	sub    $0xc,%esp
      1f:	68 d1 43 00 00       	push   $0x43d1
      24:	e8 ce 3e 00 00       	call   3ef7 <mkdir>
      29:	83 c4 10             	add    $0x10,%esp
      2c:	85 c0                	test   %eax,%eax
      2e:	79 1b                	jns    4b <iputtest+0x4b>
    printf(stdout, "mkdir failed\n");
      30:	a1 8c 62 00 00       	mov    0x628c,%eax
      35:	83 ec 08             	sub    $0x8,%esp
      38:	68 d9 43 00 00       	push   $0x43d9
      3d:	50                   	push   %eax
      3e:	e8 be 3f 00 00       	call   4001 <printf>
      43:	83 c4 10             	add    $0x10,%esp
    exit();
      46:	e8 44 3e 00 00       	call   3e8f <exit>
  }
  if(chdir("iputdir") < 0){
      4b:	83 ec 0c             	sub    $0xc,%esp
      4e:	68 d1 43 00 00       	push   $0x43d1
      53:	e8 a7 3e 00 00       	call   3eff <chdir>
      58:	83 c4 10             	add    $0x10,%esp
      5b:	85 c0                	test   %eax,%eax
      5d:	79 1b                	jns    7a <iputtest+0x7a>
    printf(stdout, "chdir iputdir failed\n");
      5f:	a1 8c 62 00 00       	mov    0x628c,%eax
      64:	83 ec 08             	sub    $0x8,%esp
      67:	68 e7 43 00 00       	push   $0x43e7
      6c:	50                   	push   %eax
      6d:	e8 8f 3f 00 00       	call   4001 <printf>
      72:	83 c4 10             	add    $0x10,%esp
    exit();
      75:	e8 15 3e 00 00       	call   3e8f <exit>
  }
  if(unlink("../iputdir") < 0){
      7a:	83 ec 0c             	sub    $0xc,%esp
      7d:	68 fd 43 00 00       	push   $0x43fd
      82:	e8 58 3e 00 00       	call   3edf <unlink>
      87:	83 c4 10             	add    $0x10,%esp
      8a:	85 c0                	test   %eax,%eax
      8c:	79 1b                	jns    a9 <iputtest+0xa9>
    printf(stdout, "unlink ../iputdir failed\n");
      8e:	a1 8c 62 00 00       	mov    0x628c,%eax
      93:	83 ec 08             	sub    $0x8,%esp
      96:	68 08 44 00 00       	push   $0x4408
      9b:	50                   	push   %eax
      9c:	e8 60 3f 00 00       	call   4001 <printf>
      a1:	83 c4 10             	add    $0x10,%esp
    exit();
      a4:	e8 e6 3d 00 00       	call   3e8f <exit>
  }
  if(chdir("/") < 0){
      a9:	83 ec 0c             	sub    $0xc,%esp
      ac:	68 22 44 00 00       	push   $0x4422
      b1:	e8 49 3e 00 00       	call   3eff <chdir>
      b6:	83 c4 10             	add    $0x10,%esp
      b9:	85 c0                	test   %eax,%eax
      bb:	79 1b                	jns    d8 <iputtest+0xd8>
    printf(stdout, "chdir / failed\n");
      bd:	a1 8c 62 00 00       	mov    0x628c,%eax
      c2:	83 ec 08             	sub    $0x8,%esp
      c5:	68 24 44 00 00       	push   $0x4424
      ca:	50                   	push   %eax
      cb:	e8 31 3f 00 00       	call   4001 <printf>
      d0:	83 c4 10             	add    $0x10,%esp
    exit();
      d3:	e8 b7 3d 00 00       	call   3e8f <exit>
  }
  printf(stdout, "iput test ok\n");
      d8:	a1 8c 62 00 00       	mov    0x628c,%eax
      dd:	83 ec 08             	sub    $0x8,%esp
      e0:	68 34 44 00 00       	push   $0x4434
      e5:	50                   	push   %eax
      e6:	e8 16 3f 00 00       	call   4001 <printf>
      eb:	83 c4 10             	add    $0x10,%esp
}
      ee:	c9                   	leave  
      ef:	c3                   	ret    

000000f0 <exitiputtest>:

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
      f0:	55                   	push   %ebp
      f1:	89 e5                	mov    %esp,%ebp
      f3:	83 ec 18             	sub    $0x18,%esp
  int pid;

  printf(stdout, "exitiput test\n");
      f6:	a1 8c 62 00 00       	mov    0x628c,%eax
      fb:	83 ec 08             	sub    $0x8,%esp
      fe:	68 42 44 00 00       	push   $0x4442
     103:	50                   	push   %eax
     104:	e8 f8 3e 00 00       	call   4001 <printf>
     109:	83 c4 10             	add    $0x10,%esp

  pid = fork();
     10c:	e8 76 3d 00 00       	call   3e87 <fork>
     111:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid < 0){
     114:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     118:	79 1b                	jns    135 <exitiputtest+0x45>
    printf(stdout, "fork failed\n");
     11a:	a1 8c 62 00 00       	mov    0x628c,%eax
     11f:	83 ec 08             	sub    $0x8,%esp
     122:	68 51 44 00 00       	push   $0x4451
     127:	50                   	push   %eax
     128:	e8 d4 3e 00 00       	call   4001 <printf>
     12d:	83 c4 10             	add    $0x10,%esp
    exit();
     130:	e8 5a 3d 00 00       	call   3e8f <exit>
  }
  if(pid == 0){
     135:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     139:	0f 85 92 00 00 00    	jne    1d1 <exitiputtest+0xe1>
    if(mkdir("iputdir") < 0){
     13f:	83 ec 0c             	sub    $0xc,%esp
     142:	68 d1 43 00 00       	push   $0x43d1
     147:	e8 ab 3d 00 00       	call   3ef7 <mkdir>
     14c:	83 c4 10             	add    $0x10,%esp
     14f:	85 c0                	test   %eax,%eax
     151:	79 1b                	jns    16e <exitiputtest+0x7e>
      printf(stdout, "mkdir failed\n");
     153:	a1 8c 62 00 00       	mov    0x628c,%eax
     158:	83 ec 08             	sub    $0x8,%esp
     15b:	68 d9 43 00 00       	push   $0x43d9
     160:	50                   	push   %eax
     161:	e8 9b 3e 00 00       	call   4001 <printf>
     166:	83 c4 10             	add    $0x10,%esp
      exit();
     169:	e8 21 3d 00 00       	call   3e8f <exit>
    }
    if(chdir("iputdir") < 0){
     16e:	83 ec 0c             	sub    $0xc,%esp
     171:	68 d1 43 00 00       	push   $0x43d1
     176:	e8 84 3d 00 00       	call   3eff <chdir>
     17b:	83 c4 10             	add    $0x10,%esp
     17e:	85 c0                	test   %eax,%eax
     180:	79 1b                	jns    19d <exitiputtest+0xad>
      printf(stdout, "child chdir failed\n");
     182:	a1 8c 62 00 00       	mov    0x628c,%eax
     187:	83 ec 08             	sub    $0x8,%esp
     18a:	68 5e 44 00 00       	push   $0x445e
     18f:	50                   	push   %eax
     190:	e8 6c 3e 00 00       	call   4001 <printf>
     195:	83 c4 10             	add    $0x10,%esp
      exit();
     198:	e8 f2 3c 00 00       	call   3e8f <exit>
    }
    if(unlink("../iputdir") < 0){
     19d:	83 ec 0c             	sub    $0xc,%esp
     1a0:	68 fd 43 00 00       	push   $0x43fd
     1a5:	e8 35 3d 00 00       	call   3edf <unlink>
     1aa:	83 c4 10             	add    $0x10,%esp
     1ad:	85 c0                	test   %eax,%eax
     1af:	79 1b                	jns    1cc <exitiputtest+0xdc>
      printf(stdout, "unlink ../iputdir failed\n");
     1b1:	a1 8c 62 00 00       	mov    0x628c,%eax
     1b6:	83 ec 08             	sub    $0x8,%esp
     1b9:	68 08 44 00 00       	push   $0x4408
     1be:	50                   	push   %eax
     1bf:	e8 3d 3e 00 00       	call   4001 <printf>
     1c4:	83 c4 10             	add    $0x10,%esp
      exit();
     1c7:	e8 c3 3c 00 00       	call   3e8f <exit>
    }
    exit();
     1cc:	e8 be 3c 00 00       	call   3e8f <exit>
  }
  wait();
     1d1:	e8 c1 3c 00 00       	call   3e97 <wait>
  printf(stdout, "exitiput test ok\n");
     1d6:	a1 8c 62 00 00       	mov    0x628c,%eax
     1db:	83 ec 08             	sub    $0x8,%esp
     1de:	68 72 44 00 00       	push   $0x4472
     1e3:	50                   	push   %eax
     1e4:	e8 18 3e 00 00       	call   4001 <printf>
     1e9:	83 c4 10             	add    $0x10,%esp
}
     1ec:	c9                   	leave  
     1ed:	c3                   	ret    

000001ee <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
     1ee:	55                   	push   %ebp
     1ef:	89 e5                	mov    %esp,%ebp
     1f1:	83 ec 18             	sub    $0x18,%esp
  int pid;

  printf(stdout, "openiput test\n");
     1f4:	a1 8c 62 00 00       	mov    0x628c,%eax
     1f9:	83 ec 08             	sub    $0x8,%esp
     1fc:	68 84 44 00 00       	push   $0x4484
     201:	50                   	push   %eax
     202:	e8 fa 3d 00 00       	call   4001 <printf>
     207:	83 c4 10             	add    $0x10,%esp
  if(mkdir("oidir") < 0){
     20a:	83 ec 0c             	sub    $0xc,%esp
     20d:	68 93 44 00 00       	push   $0x4493
     212:	e8 e0 3c 00 00       	call   3ef7 <mkdir>
     217:	83 c4 10             	add    $0x10,%esp
     21a:	85 c0                	test   %eax,%eax
     21c:	79 1b                	jns    239 <openiputtest+0x4b>
    printf(stdout, "mkdir oidir failed\n");
     21e:	a1 8c 62 00 00       	mov    0x628c,%eax
     223:	83 ec 08             	sub    $0x8,%esp
     226:	68 99 44 00 00       	push   $0x4499
     22b:	50                   	push   %eax
     22c:	e8 d0 3d 00 00       	call   4001 <printf>
     231:	83 c4 10             	add    $0x10,%esp
    exit();
     234:	e8 56 3c 00 00       	call   3e8f <exit>
  }
  pid = fork();
     239:	e8 49 3c 00 00       	call   3e87 <fork>
     23e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid < 0){
     241:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     245:	79 1b                	jns    262 <openiputtest+0x74>
    printf(stdout, "fork failed\n");
     247:	a1 8c 62 00 00       	mov    0x628c,%eax
     24c:	83 ec 08             	sub    $0x8,%esp
     24f:	68 51 44 00 00       	push   $0x4451
     254:	50                   	push   %eax
     255:	e8 a7 3d 00 00       	call   4001 <printf>
     25a:	83 c4 10             	add    $0x10,%esp
    exit();
     25d:	e8 2d 3c 00 00       	call   3e8f <exit>
  }
  if(pid == 0){
     262:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     266:	75 3b                	jne    2a3 <openiputtest+0xb5>
    int fd = open("oidir", O_RDWR);
     268:	83 ec 08             	sub    $0x8,%esp
     26b:	6a 02                	push   $0x2
     26d:	68 93 44 00 00       	push   $0x4493
     272:	e8 58 3c 00 00       	call   3ecf <open>
     277:	83 c4 10             	add    $0x10,%esp
     27a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0){
     27d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     281:	78 1b                	js     29e <openiputtest+0xb0>
      printf(stdout, "open directory for write succeeded\n");
     283:	a1 8c 62 00 00       	mov    0x628c,%eax
     288:	83 ec 08             	sub    $0x8,%esp
     28b:	68 b0 44 00 00       	push   $0x44b0
     290:	50                   	push   %eax
     291:	e8 6b 3d 00 00       	call   4001 <printf>
     296:	83 c4 10             	add    $0x10,%esp
      exit();
     299:	e8 f1 3b 00 00       	call   3e8f <exit>
    }
    exit();
     29e:	e8 ec 3b 00 00       	call   3e8f <exit>
  }
  sleep(1);
     2a3:	83 ec 0c             	sub    $0xc,%esp
     2a6:	6a 01                	push   $0x1
     2a8:	e8 72 3c 00 00       	call   3f1f <sleep>
     2ad:	83 c4 10             	add    $0x10,%esp
  if(unlink("oidir") != 0){
     2b0:	83 ec 0c             	sub    $0xc,%esp
     2b3:	68 93 44 00 00       	push   $0x4493
     2b8:	e8 22 3c 00 00       	call   3edf <unlink>
     2bd:	83 c4 10             	add    $0x10,%esp
     2c0:	85 c0                	test   %eax,%eax
     2c2:	74 1b                	je     2df <openiputtest+0xf1>
    printf(stdout, "unlink failed\n");
     2c4:	a1 8c 62 00 00       	mov    0x628c,%eax
     2c9:	83 ec 08             	sub    $0x8,%esp
     2cc:	68 d4 44 00 00       	push   $0x44d4
     2d1:	50                   	push   %eax
     2d2:	e8 2a 3d 00 00       	call   4001 <printf>
     2d7:	83 c4 10             	add    $0x10,%esp
    exit();
     2da:	e8 b0 3b 00 00       	call   3e8f <exit>
  }
  wait();
     2df:	e8 b3 3b 00 00       	call   3e97 <wait>
  printf(stdout, "openiput test ok\n");
     2e4:	a1 8c 62 00 00       	mov    0x628c,%eax
     2e9:	83 ec 08             	sub    $0x8,%esp
     2ec:	68 e3 44 00 00       	push   $0x44e3
     2f1:	50                   	push   %eax
     2f2:	e8 0a 3d 00 00       	call   4001 <printf>
     2f7:	83 c4 10             	add    $0x10,%esp
}
     2fa:	c9                   	leave  
     2fb:	c3                   	ret    

000002fc <opentest>:

// simple file system tests

void
opentest(void)
{
     2fc:	55                   	push   %ebp
     2fd:	89 e5                	mov    %esp,%ebp
     2ff:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(stdout, "open test\n");
     302:	a1 8c 62 00 00       	mov    0x628c,%eax
     307:	83 ec 08             	sub    $0x8,%esp
     30a:	68 f5 44 00 00       	push   $0x44f5
     30f:	50                   	push   %eax
     310:	e8 ec 3c 00 00       	call   4001 <printf>
     315:	83 c4 10             	add    $0x10,%esp
  fd = open("echo", 0);
     318:	83 ec 08             	sub    $0x8,%esp
     31b:	6a 00                	push   $0x0
     31d:	68 b0 43 00 00       	push   $0x43b0
     322:	e8 a8 3b 00 00       	call   3ecf <open>
     327:	83 c4 10             	add    $0x10,%esp
     32a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
     32d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     331:	79 1b                	jns    34e <opentest+0x52>
    printf(stdout, "open echo failed!\n");
     333:	a1 8c 62 00 00       	mov    0x628c,%eax
     338:	83 ec 08             	sub    $0x8,%esp
     33b:	68 00 45 00 00       	push   $0x4500
     340:	50                   	push   %eax
     341:	e8 bb 3c 00 00       	call   4001 <printf>
     346:	83 c4 10             	add    $0x10,%esp
    exit();
     349:	e8 41 3b 00 00       	call   3e8f <exit>
  }
  close(fd);
     34e:	83 ec 0c             	sub    $0xc,%esp
     351:	ff 75 f4             	pushl  -0xc(%ebp)
     354:	e8 5e 3b 00 00       	call   3eb7 <close>
     359:	83 c4 10             	add    $0x10,%esp
  fd = open("doesnotexist", 0);
     35c:	83 ec 08             	sub    $0x8,%esp
     35f:	6a 00                	push   $0x0
     361:	68 13 45 00 00       	push   $0x4513
     366:	e8 64 3b 00 00       	call   3ecf <open>
     36b:	83 c4 10             	add    $0x10,%esp
     36e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
     371:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     375:	78 1b                	js     392 <opentest+0x96>
    printf(stdout, "open doesnotexist succeeded!\n");
     377:	a1 8c 62 00 00       	mov    0x628c,%eax
     37c:	83 ec 08             	sub    $0x8,%esp
     37f:	68 20 45 00 00       	push   $0x4520
     384:	50                   	push   %eax
     385:	e8 77 3c 00 00       	call   4001 <printf>
     38a:	83 c4 10             	add    $0x10,%esp
    exit();
     38d:	e8 fd 3a 00 00       	call   3e8f <exit>
  }
  printf(stdout, "open test ok\n");
     392:	a1 8c 62 00 00       	mov    0x628c,%eax
     397:	83 ec 08             	sub    $0x8,%esp
     39a:	68 3e 45 00 00       	push   $0x453e
     39f:	50                   	push   %eax
     3a0:	e8 5c 3c 00 00       	call   4001 <printf>
     3a5:	83 c4 10             	add    $0x10,%esp
}
     3a8:	c9                   	leave  
     3a9:	c3                   	ret    

000003aa <writetest>:

void
writetest(void)
{
     3aa:	55                   	push   %ebp
     3ab:	89 e5                	mov    %esp,%ebp
     3ad:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int i;

  printf(stdout, "small file test\n");
     3b0:	a1 8c 62 00 00       	mov    0x628c,%eax
     3b5:	83 ec 08             	sub    $0x8,%esp
     3b8:	68 4c 45 00 00       	push   $0x454c
     3bd:	50                   	push   %eax
     3be:	e8 3e 3c 00 00       	call   4001 <printf>
     3c3:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_CREATE|O_RDWR);
     3c6:	83 ec 08             	sub    $0x8,%esp
     3c9:	68 02 02 00 00       	push   $0x202
     3ce:	68 5d 45 00 00       	push   $0x455d
     3d3:	e8 f7 3a 00 00       	call   3ecf <open>
     3d8:	83 c4 10             	add    $0x10,%esp
     3db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
     3de:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     3e2:	78 22                	js     406 <writetest+0x5c>
    printf(stdout, "creat small succeeded; ok\n");
     3e4:	a1 8c 62 00 00       	mov    0x628c,%eax
     3e9:	83 ec 08             	sub    $0x8,%esp
     3ec:	68 63 45 00 00       	push   $0x4563
     3f1:	50                   	push   %eax
     3f2:	e8 0a 3c 00 00       	call   4001 <printf>
     3f7:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     3fa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     401:	e9 8e 00 00 00       	jmp    494 <writetest+0xea>
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
     406:	a1 8c 62 00 00       	mov    0x628c,%eax
     40b:	83 ec 08             	sub    $0x8,%esp
     40e:	68 7e 45 00 00       	push   $0x457e
     413:	50                   	push   %eax
     414:	e8 e8 3b 00 00       	call   4001 <printf>
     419:	83 c4 10             	add    $0x10,%esp
    exit();
     41c:	e8 6e 3a 00 00       	call   3e8f <exit>
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     421:	83 ec 04             	sub    $0x4,%esp
     424:	6a 0a                	push   $0xa
     426:	68 9a 45 00 00       	push   $0x459a
     42b:	ff 75 f0             	pushl  -0x10(%ebp)
     42e:	e8 7c 3a 00 00       	call   3eaf <write>
     433:	83 c4 10             	add    $0x10,%esp
     436:	83 f8 0a             	cmp    $0xa,%eax
     439:	74 1e                	je     459 <writetest+0xaf>
      printf(stdout, "error: write aa %d new file failed\n", i);
     43b:	a1 8c 62 00 00       	mov    0x628c,%eax
     440:	83 ec 04             	sub    $0x4,%esp
     443:	ff 75 f4             	pushl  -0xc(%ebp)
     446:	68 a8 45 00 00       	push   $0x45a8
     44b:	50                   	push   %eax
     44c:	e8 b0 3b 00 00       	call   4001 <printf>
     451:	83 c4 10             	add    $0x10,%esp
      exit();
     454:	e8 36 3a 00 00       	call   3e8f <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     459:	83 ec 04             	sub    $0x4,%esp
     45c:	6a 0a                	push   $0xa
     45e:	68 cc 45 00 00       	push   $0x45cc
     463:	ff 75 f0             	pushl  -0x10(%ebp)
     466:	e8 44 3a 00 00       	call   3eaf <write>
     46b:	83 c4 10             	add    $0x10,%esp
     46e:	83 f8 0a             	cmp    $0xa,%eax
     471:	74 1e                	je     491 <writetest+0xe7>
      printf(stdout, "error: write bb %d new file failed\n", i);
     473:	a1 8c 62 00 00       	mov    0x628c,%eax
     478:	83 ec 04             	sub    $0x4,%esp
     47b:	ff 75 f4             	pushl  -0xc(%ebp)
     47e:	68 d8 45 00 00       	push   $0x45d8
     483:	50                   	push   %eax
     484:	e8 78 3b 00 00       	call   4001 <printf>
     489:	83 c4 10             	add    $0x10,%esp
      exit();
     48c:	e8 fe 39 00 00       	call   3e8f <exit>
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     491:	ff 45 f4             	incl   -0xc(%ebp)
     494:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     498:	7e 87                	jle    421 <writetest+0x77>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit();
    }
  }
  printf(stdout, "writes ok\n");
     49a:	a1 8c 62 00 00       	mov    0x628c,%eax
     49f:	83 ec 08             	sub    $0x8,%esp
     4a2:	68 fc 45 00 00       	push   $0x45fc
     4a7:	50                   	push   %eax
     4a8:	e8 54 3b 00 00       	call   4001 <printf>
     4ad:	83 c4 10             	add    $0x10,%esp
  close(fd);
     4b0:	83 ec 0c             	sub    $0xc,%esp
     4b3:	ff 75 f0             	pushl  -0x10(%ebp)
     4b6:	e8 fc 39 00 00       	call   3eb7 <close>
     4bb:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_RDONLY);
     4be:	83 ec 08             	sub    $0x8,%esp
     4c1:	6a 00                	push   $0x0
     4c3:	68 5d 45 00 00       	push   $0x455d
     4c8:	e8 02 3a 00 00       	call   3ecf <open>
     4cd:	83 c4 10             	add    $0x10,%esp
     4d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
     4d3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4d7:	78 3c                	js     515 <writetest+0x16b>
    printf(stdout, "open small succeeded ok\n");
     4d9:	a1 8c 62 00 00       	mov    0x628c,%eax
     4de:	83 ec 08             	sub    $0x8,%esp
     4e1:	68 07 46 00 00       	push   $0x4607
     4e6:	50                   	push   %eax
     4e7:	e8 15 3b 00 00       	call   4001 <printf>
     4ec:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
     4ef:	83 ec 04             	sub    $0x4,%esp
     4f2:	68 d0 07 00 00       	push   $0x7d0
     4f7:	68 80 8a 00 00       	push   $0x8a80
     4fc:	ff 75 f0             	pushl  -0x10(%ebp)
     4ff:	e8 a3 39 00 00       	call   3ea7 <read>
     504:	83 c4 10             	add    $0x10,%esp
     507:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(i == 2000){
     50a:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
     511:	75 57                	jne    56a <writetest+0x1c0>
     513:	eb 1b                	jmp    530 <writetest+0x186>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
     515:	a1 8c 62 00 00       	mov    0x628c,%eax
     51a:	83 ec 08             	sub    $0x8,%esp
     51d:	68 20 46 00 00       	push   $0x4620
     522:	50                   	push   %eax
     523:	e8 d9 3a 00 00       	call   4001 <printf>
     528:	83 c4 10             	add    $0x10,%esp
    exit();
     52b:	e8 5f 39 00 00       	call   3e8f <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
     530:	a1 8c 62 00 00       	mov    0x628c,%eax
     535:	83 ec 08             	sub    $0x8,%esp
     538:	68 3b 46 00 00       	push   $0x463b
     53d:	50                   	push   %eax
     53e:	e8 be 3a 00 00       	call   4001 <printf>
     543:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
     546:	83 ec 0c             	sub    $0xc,%esp
     549:	ff 75 f0             	pushl  -0x10(%ebp)
     54c:	e8 66 39 00 00       	call   3eb7 <close>
     551:	83 c4 10             	add    $0x10,%esp

  if(unlink("small") < 0){
     554:	83 ec 0c             	sub    $0xc,%esp
     557:	68 5d 45 00 00       	push   $0x455d
     55c:	e8 7e 39 00 00       	call   3edf <unlink>
     561:	83 c4 10             	add    $0x10,%esp
     564:	85 c0                	test   %eax,%eax
     566:	79 38                	jns    5a0 <writetest+0x1f6>
     568:	eb 1b                	jmp    585 <writetest+0x1db>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
     56a:	a1 8c 62 00 00       	mov    0x628c,%eax
     56f:	83 ec 08             	sub    $0x8,%esp
     572:	68 4e 46 00 00       	push   $0x464e
     577:	50                   	push   %eax
     578:	e8 84 3a 00 00       	call   4001 <printf>
     57d:	83 c4 10             	add    $0x10,%esp
    exit();
     580:	e8 0a 39 00 00       	call   3e8f <exit>
  }
  close(fd);

  if(unlink("small") < 0){
    printf(stdout, "unlink small failed\n");
     585:	a1 8c 62 00 00       	mov    0x628c,%eax
     58a:	83 ec 08             	sub    $0x8,%esp
     58d:	68 5b 46 00 00       	push   $0x465b
     592:	50                   	push   %eax
     593:	e8 69 3a 00 00       	call   4001 <printf>
     598:	83 c4 10             	add    $0x10,%esp
    exit();
     59b:	e8 ef 38 00 00       	call   3e8f <exit>
  }
  printf(stdout, "small file test ok\n");
     5a0:	a1 8c 62 00 00       	mov    0x628c,%eax
     5a5:	83 ec 08             	sub    $0x8,%esp
     5a8:	68 70 46 00 00       	push   $0x4670
     5ad:	50                   	push   %eax
     5ae:	e8 4e 3a 00 00       	call   4001 <printf>
     5b3:	83 c4 10             	add    $0x10,%esp
}
     5b6:	c9                   	leave  
     5b7:	c3                   	ret    

000005b8 <writetest1>:

void
writetest1(void)
{
     5b8:	55                   	push   %ebp
     5b9:	89 e5                	mov    %esp,%ebp
     5bb:	83 ec 18             	sub    $0x18,%esp
  int i, fd, n;

  printf(stdout, "big files test\n");
     5be:	a1 8c 62 00 00       	mov    0x628c,%eax
     5c3:	83 ec 08             	sub    $0x8,%esp
     5c6:	68 84 46 00 00       	push   $0x4684
     5cb:	50                   	push   %eax
     5cc:	e8 30 3a 00 00       	call   4001 <printf>
     5d1:	83 c4 10             	add    $0x10,%esp

  fd = open("big", O_CREATE|O_RDWR);
     5d4:	83 ec 08             	sub    $0x8,%esp
     5d7:	68 02 02 00 00       	push   $0x202
     5dc:	68 94 46 00 00       	push   $0x4694
     5e1:	e8 e9 38 00 00       	call   3ecf <open>
     5e6:	83 c4 10             	add    $0x10,%esp
     5e9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
     5ec:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     5f0:	79 1b                	jns    60d <writetest1+0x55>
    printf(stdout, "error: creat big failed!\n");
     5f2:	a1 8c 62 00 00       	mov    0x628c,%eax
     5f7:	83 ec 08             	sub    $0x8,%esp
     5fa:	68 98 46 00 00       	push   $0x4698
     5ff:	50                   	push   %eax
     600:	e8 fc 39 00 00       	call   4001 <printf>
     605:	83 c4 10             	add    $0x10,%esp
    exit();
     608:	e8 82 38 00 00       	call   3e8f <exit>
  }

  for(i = 0; i < MAXFILE; i++){
     60d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     614:	eb 4a                	jmp    660 <writetest1+0xa8>
    ((int*)buf)[0] = i;
     616:	b8 80 8a 00 00       	mov    $0x8a80,%eax
     61b:	8b 55 f4             	mov    -0xc(%ebp),%edx
     61e:	89 10                	mov    %edx,(%eax)
    if(write(fd, buf, 512) != 512){
     620:	83 ec 04             	sub    $0x4,%esp
     623:	68 00 02 00 00       	push   $0x200
     628:	68 80 8a 00 00       	push   $0x8a80
     62d:	ff 75 ec             	pushl  -0x14(%ebp)
     630:	e8 7a 38 00 00       	call   3eaf <write>
     635:	83 c4 10             	add    $0x10,%esp
     638:	3d 00 02 00 00       	cmp    $0x200,%eax
     63d:	74 1e                	je     65d <writetest1+0xa5>
      printf(stdout, "error: write big file failed\n", i);
     63f:	a1 8c 62 00 00       	mov    0x628c,%eax
     644:	83 ec 04             	sub    $0x4,%esp
     647:	ff 75 f4             	pushl  -0xc(%ebp)
     64a:	68 b2 46 00 00       	push   $0x46b2
     64f:	50                   	push   %eax
     650:	e8 ac 39 00 00       	call   4001 <printf>
     655:	83 c4 10             	add    $0x10,%esp
      exit();
     658:	e8 32 38 00 00       	call   3e8f <exit>
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
     65d:	ff 45 f4             	incl   -0xc(%ebp)
     660:	8b 45 f4             	mov    -0xc(%ebp),%eax
     663:	3d 8b 00 00 00       	cmp    $0x8b,%eax
     668:	76 ac                	jbe    616 <writetest1+0x5e>
      printf(stdout, "error: write big file failed\n", i);
      exit();
    }
  }

  close(fd);
     66a:	83 ec 0c             	sub    $0xc,%esp
     66d:	ff 75 ec             	pushl  -0x14(%ebp)
     670:	e8 42 38 00 00       	call   3eb7 <close>
     675:	83 c4 10             	add    $0x10,%esp

  fd = open("big", O_RDONLY);
     678:	83 ec 08             	sub    $0x8,%esp
     67b:	6a 00                	push   $0x0
     67d:	68 94 46 00 00       	push   $0x4694
     682:	e8 48 38 00 00       	call   3ecf <open>
     687:	83 c4 10             	add    $0x10,%esp
     68a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
     68d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     691:	79 1b                	jns    6ae <writetest1+0xf6>
    printf(stdout, "error: open big failed!\n");
     693:	a1 8c 62 00 00       	mov    0x628c,%eax
     698:	83 ec 08             	sub    $0x8,%esp
     69b:	68 d0 46 00 00       	push   $0x46d0
     6a0:	50                   	push   %eax
     6a1:	e8 5b 39 00 00       	call   4001 <printf>
     6a6:	83 c4 10             	add    $0x10,%esp
    exit();
     6a9:	e8 e1 37 00 00       	call   3e8f <exit>
  }

  n = 0;
     6ae:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(;;){
    i = read(fd, buf, 512);
     6b5:	83 ec 04             	sub    $0x4,%esp
     6b8:	68 00 02 00 00       	push   $0x200
     6bd:	68 80 8a 00 00       	push   $0x8a80
     6c2:	ff 75 ec             	pushl  -0x14(%ebp)
     6c5:	e8 dd 37 00 00       	call   3ea7 <read>
     6ca:	83 c4 10             	add    $0x10,%esp
     6cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(i == 0){
     6d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     6d4:	75 4c                	jne    722 <writetest1+0x16a>
      if(n == MAXFILE - 1){
     6d6:	81 7d f0 8b 00 00 00 	cmpl   $0x8b,-0x10(%ebp)
     6dd:	75 1e                	jne    6fd <writetest1+0x145>
        printf(stdout, "read only %d blocks from big", n);
     6df:	a1 8c 62 00 00       	mov    0x628c,%eax
     6e4:	83 ec 04             	sub    $0x4,%esp
     6e7:	ff 75 f0             	pushl  -0x10(%ebp)
     6ea:	68 e9 46 00 00       	push   $0x46e9
     6ef:	50                   	push   %eax
     6f0:	e8 0c 39 00 00       	call   4001 <printf>
     6f5:	83 c4 10             	add    $0x10,%esp
        exit();
     6f8:	e8 92 37 00 00       	call   3e8f <exit>
      }
      break;
     6fd:	90                   	nop
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
  }
  close(fd);
     6fe:	83 ec 0c             	sub    $0xc,%esp
     701:	ff 75 ec             	pushl  -0x14(%ebp)
     704:	e8 ae 37 00 00       	call   3eb7 <close>
     709:	83 c4 10             	add    $0x10,%esp
  if(unlink("big") < 0){
     70c:	83 ec 0c             	sub    $0xc,%esp
     70f:	68 94 46 00 00       	push   $0x4694
     714:	e8 c6 37 00 00       	call   3edf <unlink>
     719:	83 c4 10             	add    $0x10,%esp
     71c:	85 c0                	test   %eax,%eax
     71e:	79 7b                	jns    79b <writetest1+0x1e3>
     720:	eb 5e                	jmp    780 <writetest1+0x1c8>
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512){
     722:	81 7d f4 00 02 00 00 	cmpl   $0x200,-0xc(%ebp)
     729:	74 1e                	je     749 <writetest1+0x191>
      printf(stdout, "read failed %d\n", i);
     72b:	a1 8c 62 00 00       	mov    0x628c,%eax
     730:	83 ec 04             	sub    $0x4,%esp
     733:	ff 75 f4             	pushl  -0xc(%ebp)
     736:	68 06 47 00 00       	push   $0x4706
     73b:	50                   	push   %eax
     73c:	e8 c0 38 00 00       	call   4001 <printf>
     741:	83 c4 10             	add    $0x10,%esp
      exit();
     744:	e8 46 37 00 00       	call   3e8f <exit>
    }
    if(((int*)buf)[0] != n){
     749:	b8 80 8a 00 00       	mov    $0x8a80,%eax
     74e:	8b 00                	mov    (%eax),%eax
     750:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     753:	74 23                	je     778 <writetest1+0x1c0>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
     755:	b8 80 8a 00 00       	mov    $0x8a80,%eax
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
      printf(stdout, "read content of block %d is %d\n",
     75a:	8b 10                	mov    (%eax),%edx
     75c:	a1 8c 62 00 00       	mov    0x628c,%eax
     761:	52                   	push   %edx
     762:	ff 75 f0             	pushl  -0x10(%ebp)
     765:	68 18 47 00 00       	push   $0x4718
     76a:	50                   	push   %eax
     76b:	e8 91 38 00 00       	call   4001 <printf>
     770:	83 c4 10             	add    $0x10,%esp
             n, ((int*)buf)[0]);
      exit();
     773:	e8 17 37 00 00       	call   3e8f <exit>
    }
    n++;
     778:	ff 45 f0             	incl   -0x10(%ebp)
  }
     77b:	e9 35 ff ff ff       	jmp    6b5 <writetest1+0xfd>
  close(fd);
  if(unlink("big") < 0){
    printf(stdout, "unlink big failed\n");
     780:	a1 8c 62 00 00       	mov    0x628c,%eax
     785:	83 ec 08             	sub    $0x8,%esp
     788:	68 38 47 00 00       	push   $0x4738
     78d:	50                   	push   %eax
     78e:	e8 6e 38 00 00       	call   4001 <printf>
     793:	83 c4 10             	add    $0x10,%esp
    exit();
     796:	e8 f4 36 00 00       	call   3e8f <exit>
  }
  printf(stdout, "big files ok\n");
     79b:	a1 8c 62 00 00       	mov    0x628c,%eax
     7a0:	83 ec 08             	sub    $0x8,%esp
     7a3:	68 4b 47 00 00       	push   $0x474b
     7a8:	50                   	push   %eax
     7a9:	e8 53 38 00 00       	call   4001 <printf>
     7ae:	83 c4 10             	add    $0x10,%esp
}
     7b1:	c9                   	leave  
     7b2:	c3                   	ret    

000007b3 <createtest>:

void
createtest(void)
{
     7b3:	55                   	push   %ebp
     7b4:	89 e5                	mov    %esp,%ebp
     7b6:	83 ec 18             	sub    $0x18,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     7b9:	a1 8c 62 00 00       	mov    0x628c,%eax
     7be:	83 ec 08             	sub    $0x8,%esp
     7c1:	68 5c 47 00 00       	push   $0x475c
     7c6:	50                   	push   %eax
     7c7:	e8 35 38 00 00       	call   4001 <printf>
     7cc:	83 c4 10             	add    $0x10,%esp

  name[0] = 'a';
     7cf:	c6 05 80 aa 00 00 61 	movb   $0x61,0xaa80
  name[2] = '\0';
     7d6:	c6 05 82 aa 00 00 00 	movb   $0x0,0xaa82
  for(i = 0; i < 52; i++){
     7dd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     7e4:	eb 34                	jmp    81a <createtest+0x67>
    name[1] = '0' + i;
     7e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e9:	83 c0 30             	add    $0x30,%eax
     7ec:	a2 81 aa 00 00       	mov    %al,0xaa81
    fd = open(name, O_CREATE|O_RDWR);
     7f1:	83 ec 08             	sub    $0x8,%esp
     7f4:	68 02 02 00 00       	push   $0x202
     7f9:	68 80 aa 00 00       	push   $0xaa80
     7fe:	e8 cc 36 00 00       	call   3ecf <open>
     803:	83 c4 10             	add    $0x10,%esp
     806:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(fd);
     809:	83 ec 0c             	sub    $0xc,%esp
     80c:	ff 75 f0             	pushl  -0x10(%ebp)
     80f:	e8 a3 36 00 00       	call   3eb7 <close>
     814:	83 c4 10             	add    $0x10,%esp

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     817:	ff 45 f4             	incl   -0xc(%ebp)
     81a:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     81e:	7e c6                	jle    7e6 <createtest+0x33>
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
     820:	c6 05 80 aa 00 00 61 	movb   $0x61,0xaa80
  name[2] = '\0';
     827:	c6 05 82 aa 00 00 00 	movb   $0x0,0xaa82
  for(i = 0; i < 52; i++){
     82e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     835:	eb 1e                	jmp    855 <createtest+0xa2>
    name[1] = '0' + i;
     837:	8b 45 f4             	mov    -0xc(%ebp),%eax
     83a:	83 c0 30             	add    $0x30,%eax
     83d:	a2 81 aa 00 00       	mov    %al,0xaa81
    unlink(name);
     842:	83 ec 0c             	sub    $0xc,%esp
     845:	68 80 aa 00 00       	push   $0xaa80
     84a:	e8 90 36 00 00       	call   3edf <unlink>
     84f:	83 c4 10             	add    $0x10,%esp
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     852:	ff 45 f4             	incl   -0xc(%ebp)
     855:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     859:	7e dc                	jle    837 <createtest+0x84>
    name[1] = '0' + i;
    unlink(name);
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     85b:	a1 8c 62 00 00       	mov    0x628c,%eax
     860:	83 ec 08             	sub    $0x8,%esp
     863:	68 84 47 00 00       	push   $0x4784
     868:	50                   	push   %eax
     869:	e8 93 37 00 00       	call   4001 <printf>
     86e:	83 c4 10             	add    $0x10,%esp
}
     871:	c9                   	leave  
     872:	c3                   	ret    

00000873 <dirtest>:

void dirtest(void)
{
     873:	55                   	push   %ebp
     874:	89 e5                	mov    %esp,%ebp
     876:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "mkdir test\n");
     879:	a1 8c 62 00 00       	mov    0x628c,%eax
     87e:	83 ec 08             	sub    $0x8,%esp
     881:	68 aa 47 00 00       	push   $0x47aa
     886:	50                   	push   %eax
     887:	e8 75 37 00 00       	call   4001 <printf>
     88c:	83 c4 10             	add    $0x10,%esp

  if(mkdir("dir0") < 0){
     88f:	83 ec 0c             	sub    $0xc,%esp
     892:	68 b6 47 00 00       	push   $0x47b6
     897:	e8 5b 36 00 00       	call   3ef7 <mkdir>
     89c:	83 c4 10             	add    $0x10,%esp
     89f:	85 c0                	test   %eax,%eax
     8a1:	79 1b                	jns    8be <dirtest+0x4b>
    printf(stdout, "mkdir failed\n");
     8a3:	a1 8c 62 00 00       	mov    0x628c,%eax
     8a8:	83 ec 08             	sub    $0x8,%esp
     8ab:	68 d9 43 00 00       	push   $0x43d9
     8b0:	50                   	push   %eax
     8b1:	e8 4b 37 00 00       	call   4001 <printf>
     8b6:	83 c4 10             	add    $0x10,%esp
    exit();
     8b9:	e8 d1 35 00 00       	call   3e8f <exit>
  }

  if(chdir("dir0") < 0){
     8be:	83 ec 0c             	sub    $0xc,%esp
     8c1:	68 b6 47 00 00       	push   $0x47b6
     8c6:	e8 34 36 00 00       	call   3eff <chdir>
     8cb:	83 c4 10             	add    $0x10,%esp
     8ce:	85 c0                	test   %eax,%eax
     8d0:	79 1b                	jns    8ed <dirtest+0x7a>
    printf(stdout, "chdir dir0 failed\n");
     8d2:	a1 8c 62 00 00       	mov    0x628c,%eax
     8d7:	83 ec 08             	sub    $0x8,%esp
     8da:	68 bb 47 00 00       	push   $0x47bb
     8df:	50                   	push   %eax
     8e0:	e8 1c 37 00 00       	call   4001 <printf>
     8e5:	83 c4 10             	add    $0x10,%esp
    exit();
     8e8:	e8 a2 35 00 00       	call   3e8f <exit>
  }

  if(chdir("..") < 0){
     8ed:	83 ec 0c             	sub    $0xc,%esp
     8f0:	68 ce 47 00 00       	push   $0x47ce
     8f5:	e8 05 36 00 00       	call   3eff <chdir>
     8fa:	83 c4 10             	add    $0x10,%esp
     8fd:	85 c0                	test   %eax,%eax
     8ff:	79 1b                	jns    91c <dirtest+0xa9>
    printf(stdout, "chdir .. failed\n");
     901:	a1 8c 62 00 00       	mov    0x628c,%eax
     906:	83 ec 08             	sub    $0x8,%esp
     909:	68 d1 47 00 00       	push   $0x47d1
     90e:	50                   	push   %eax
     90f:	e8 ed 36 00 00       	call   4001 <printf>
     914:	83 c4 10             	add    $0x10,%esp
    exit();
     917:	e8 73 35 00 00       	call   3e8f <exit>
  }

  if(unlink("dir0") < 0){
     91c:	83 ec 0c             	sub    $0xc,%esp
     91f:	68 b6 47 00 00       	push   $0x47b6
     924:	e8 b6 35 00 00       	call   3edf <unlink>
     929:	83 c4 10             	add    $0x10,%esp
     92c:	85 c0                	test   %eax,%eax
     92e:	79 1b                	jns    94b <dirtest+0xd8>
    printf(stdout, "unlink dir0 failed\n");
     930:	a1 8c 62 00 00       	mov    0x628c,%eax
     935:	83 ec 08             	sub    $0x8,%esp
     938:	68 e2 47 00 00       	push   $0x47e2
     93d:	50                   	push   %eax
     93e:	e8 be 36 00 00       	call   4001 <printf>
     943:	83 c4 10             	add    $0x10,%esp
    exit();
     946:	e8 44 35 00 00       	call   3e8f <exit>
  }
  printf(stdout, "mkdir test ok\n");
     94b:	a1 8c 62 00 00       	mov    0x628c,%eax
     950:	83 ec 08             	sub    $0x8,%esp
     953:	68 f6 47 00 00       	push   $0x47f6
     958:	50                   	push   %eax
     959:	e8 a3 36 00 00       	call   4001 <printf>
     95e:	83 c4 10             	add    $0x10,%esp
}
     961:	c9                   	leave  
     962:	c3                   	ret    

00000963 <exectest>:

void
exectest(void)
{
     963:	55                   	push   %ebp
     964:	89 e5                	mov    %esp,%ebp
     966:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "exec test\n");
     969:	a1 8c 62 00 00       	mov    0x628c,%eax
     96e:	83 ec 08             	sub    $0x8,%esp
     971:	68 05 48 00 00       	push   $0x4805
     976:	50                   	push   %eax
     977:	e8 85 36 00 00       	call   4001 <printf>
     97c:	83 c4 10             	add    $0x10,%esp
  if(exec("echo", echoargv) < 0){
     97f:	83 ec 08             	sub    $0x8,%esp
     982:	68 78 62 00 00       	push   $0x6278
     987:	68 b0 43 00 00       	push   $0x43b0
     98c:	e8 36 35 00 00       	call   3ec7 <exec>
     991:	83 c4 10             	add    $0x10,%esp
     994:	85 c0                	test   %eax,%eax
     996:	79 1b                	jns    9b3 <exectest+0x50>
    printf(stdout, "exec echo failed\n");
     998:	a1 8c 62 00 00       	mov    0x628c,%eax
     99d:	83 ec 08             	sub    $0x8,%esp
     9a0:	68 10 48 00 00       	push   $0x4810
     9a5:	50                   	push   %eax
     9a6:	e8 56 36 00 00       	call   4001 <printf>
     9ab:	83 c4 10             	add    $0x10,%esp
    exit();
     9ae:	e8 dc 34 00 00       	call   3e8f <exit>
  }
}
     9b3:	c9                   	leave  
     9b4:	c3                   	ret    

000009b5 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     9b5:	55                   	push   %ebp
     9b6:	89 e5                	mov    %esp,%ebp
     9b8:	83 ec 28             	sub    $0x28,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     9bb:	83 ec 0c             	sub    $0xc,%esp
     9be:	8d 45 d8             	lea    -0x28(%ebp),%eax
     9c1:	50                   	push   %eax
     9c2:	e8 d8 34 00 00       	call   3e9f <pipe>
     9c7:	83 c4 10             	add    $0x10,%esp
     9ca:	85 c0                	test   %eax,%eax
     9cc:	74 17                	je     9e5 <pipe1+0x30>
    printf(1, "pipe() failed\n");
     9ce:	83 ec 08             	sub    $0x8,%esp
     9d1:	68 22 48 00 00       	push   $0x4822
     9d6:	6a 01                	push   $0x1
     9d8:	e8 24 36 00 00       	call   4001 <printf>
     9dd:	83 c4 10             	add    $0x10,%esp
    exit();
     9e0:	e8 aa 34 00 00       	call   3e8f <exit>
  }
  pid = fork();
     9e5:	e8 9d 34 00 00       	call   3e87 <fork>
     9ea:	89 45 e0             	mov    %eax,-0x20(%ebp)
  seq = 0;
     9ed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  if(pid == 0){
     9f4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     9f8:	0f 85 86 00 00 00    	jne    a84 <pipe1+0xcf>
    close(fds[0]);
     9fe:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a01:	83 ec 0c             	sub    $0xc,%esp
     a04:	50                   	push   %eax
     a05:	e8 ad 34 00 00       	call   3eb7 <close>
     a0a:	83 c4 10             	add    $0x10,%esp
    for(n = 0; n < 5; n++){
     a0d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     a14:	eb 63                	jmp    a79 <pipe1+0xc4>
      for(i = 0; i < 1033; i++)
     a16:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a1d:	eb 17                	jmp    a36 <pipe1+0x81>
        buf[i] = seq++;
     a1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a22:	8d 50 01             	lea    0x1(%eax),%edx
     a25:	89 55 f4             	mov    %edx,-0xc(%ebp)
     a28:	8b 55 f0             	mov    -0x10(%ebp),%edx
     a2b:	81 c2 80 8a 00 00    	add    $0x8a80,%edx
     a31:	88 02                	mov    %al,(%edx)
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
     a33:	ff 45 f0             	incl   -0x10(%ebp)
     a36:	81 7d f0 08 04 00 00 	cmpl   $0x408,-0x10(%ebp)
     a3d:	7e e0                	jle    a1f <pipe1+0x6a>
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
     a3f:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a42:	83 ec 04             	sub    $0x4,%esp
     a45:	68 09 04 00 00       	push   $0x409
     a4a:	68 80 8a 00 00       	push   $0x8a80
     a4f:	50                   	push   %eax
     a50:	e8 5a 34 00 00       	call   3eaf <write>
     a55:	83 c4 10             	add    $0x10,%esp
     a58:	3d 09 04 00 00       	cmp    $0x409,%eax
     a5d:	74 17                	je     a76 <pipe1+0xc1>
        printf(1, "pipe1 oops 1\n");
     a5f:	83 ec 08             	sub    $0x8,%esp
     a62:	68 31 48 00 00       	push   $0x4831
     a67:	6a 01                	push   $0x1
     a69:	e8 93 35 00 00       	call   4001 <printf>
     a6e:	83 c4 10             	add    $0x10,%esp
        exit();
     a71:	e8 19 34 00 00       	call   3e8f <exit>
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
     a76:	ff 45 ec             	incl   -0x14(%ebp)
     a79:	83 7d ec 04          	cmpl   $0x4,-0x14(%ebp)
     a7d:	7e 97                	jle    a16 <pipe1+0x61>
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
     a7f:	e8 0b 34 00 00       	call   3e8f <exit>
  } else if(pid > 0){
     a84:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     a88:	0f 8e f7 00 00 00    	jle    b85 <pipe1+0x1d0>
    close(fds[1]);
     a8e:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a91:	83 ec 0c             	sub    $0xc,%esp
     a94:	50                   	push   %eax
     a95:	e8 1d 34 00 00       	call   3eb7 <close>
     a9a:	83 c4 10             	add    $0x10,%esp
    total = 0;
     a9d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    cc = 1;
     aa4:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     aab:	eb 69                	jmp    b16 <pipe1+0x161>
      for(i = 0; i < n; i++){
     aad:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     ab4:	eb 39                	jmp    aef <pipe1+0x13a>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     ab6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ab9:	05 80 8a 00 00       	add    $0x8a80,%eax
     abe:	8a 00                	mov    (%eax),%al
     ac0:	0f be c8             	movsbl %al,%ecx
     ac3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ac6:	8d 50 01             	lea    0x1(%eax),%edx
     ac9:	89 55 f4             	mov    %edx,-0xc(%ebp)
     acc:	31 c8                	xor    %ecx,%eax
     ace:	0f b6 c0             	movzbl %al,%eax
     ad1:	85 c0                	test   %eax,%eax
     ad3:	74 17                	je     aec <pipe1+0x137>
          printf(1, "pipe1 oops 2\n");
     ad5:	83 ec 08             	sub    $0x8,%esp
     ad8:	68 3f 48 00 00       	push   $0x483f
     add:	6a 01                	push   $0x1
     adf:	e8 1d 35 00 00       	call   4001 <printf>
     ae4:	83 c4 10             	add    $0x10,%esp
     ae7:	e9 b0 00 00 00       	jmp    b9c <pipe1+0x1e7>
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
     aec:	ff 45 f0             	incl   -0x10(%ebp)
     aef:	8b 45 f0             	mov    -0x10(%ebp),%eax
     af2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     af5:	7c bf                	jl     ab6 <pipe1+0x101>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
     af7:	8b 45 ec             	mov    -0x14(%ebp),%eax
     afa:	01 45 e4             	add    %eax,-0x1c(%ebp)
      cc = cc * 2;
     afd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b00:	01 c0                	add    %eax,%eax
     b02:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(cc > sizeof(buf))
     b05:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b08:	3d 00 20 00 00       	cmp    $0x2000,%eax
     b0d:	76 07                	jbe    b16 <pipe1+0x161>
        cc = sizeof(buf);
     b0f:	c7 45 e8 00 20 00 00 	movl   $0x2000,-0x18(%ebp)
    exit();
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     b16:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b19:	83 ec 04             	sub    $0x4,%esp
     b1c:	ff 75 e8             	pushl  -0x18(%ebp)
     b1f:	68 80 8a 00 00       	push   $0x8a80
     b24:	50                   	push   %eax
     b25:	e8 7d 33 00 00       	call   3ea7 <read>
     b2a:	83 c4 10             	add    $0x10,%esp
     b2d:	89 45 ec             	mov    %eax,-0x14(%ebp)
     b30:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     b34:	0f 8f 73 ff ff ff    	jg     aad <pipe1+0xf8>
      total += n;
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
     b3a:	81 7d e4 2d 14 00 00 	cmpl   $0x142d,-0x1c(%ebp)
     b41:	74 1a                	je     b5d <pipe1+0x1a8>
      printf(1, "pipe1 oops 3 total %d\n", total);
     b43:	83 ec 04             	sub    $0x4,%esp
     b46:	ff 75 e4             	pushl  -0x1c(%ebp)
     b49:	68 4d 48 00 00       	push   $0x484d
     b4e:	6a 01                	push   $0x1
     b50:	e8 ac 34 00 00       	call   4001 <printf>
     b55:	83 c4 10             	add    $0x10,%esp
      exit();
     b58:	e8 32 33 00 00       	call   3e8f <exit>
    }
    close(fds[0]);
     b5d:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b60:	83 ec 0c             	sub    $0xc,%esp
     b63:	50                   	push   %eax
     b64:	e8 4e 33 00 00       	call   3eb7 <close>
     b69:	83 c4 10             	add    $0x10,%esp
    wait();
     b6c:	e8 26 33 00 00       	call   3e97 <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     b71:	83 ec 08             	sub    $0x8,%esp
     b74:	68 73 48 00 00       	push   $0x4873
     b79:	6a 01                	push   $0x1
     b7b:	e8 81 34 00 00       	call   4001 <printf>
     b80:	83 c4 10             	add    $0x10,%esp
     b83:	eb 17                	jmp    b9c <pipe1+0x1e7>
      exit();
    }
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
     b85:	83 ec 08             	sub    $0x8,%esp
     b88:	68 64 48 00 00       	push   $0x4864
     b8d:	6a 01                	push   $0x1
     b8f:	e8 6d 34 00 00       	call   4001 <printf>
     b94:	83 c4 10             	add    $0x10,%esp
    exit();
     b97:	e8 f3 32 00 00       	call   3e8f <exit>
  }
  printf(1, "pipe1 ok\n");
}
     b9c:	c9                   	leave  
     b9d:	c3                   	ret    

00000b9e <preempt>:

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     b9e:	55                   	push   %ebp
     b9f:	89 e5                	mov    %esp,%ebp
     ba1:	83 ec 28             	sub    $0x28,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     ba4:	83 ec 08             	sub    $0x8,%esp
     ba7:	68 7d 48 00 00       	push   $0x487d
     bac:	6a 01                	push   $0x1
     bae:	e8 4e 34 00 00       	call   4001 <printf>
     bb3:	83 c4 10             	add    $0x10,%esp
  pid1 = fork();
     bb6:	e8 cc 32 00 00       	call   3e87 <fork>
     bbb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid1 == 0)
     bbe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     bc2:	75 02                	jne    bc6 <preempt+0x28>
    for(;;)
      ;
     bc4:	eb fe                	jmp    bc4 <preempt+0x26>

  pid2 = fork();
     bc6:	e8 bc 32 00 00       	call   3e87 <fork>
     bcb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid2 == 0)
     bce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     bd2:	75 02                	jne    bd6 <preempt+0x38>
    for(;;)
      ;
     bd4:	eb fe                	jmp    bd4 <preempt+0x36>

  pipe(pfds);
     bd6:	83 ec 0c             	sub    $0xc,%esp
     bd9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     bdc:	50                   	push   %eax
     bdd:	e8 bd 32 00 00       	call   3e9f <pipe>
     be2:	83 c4 10             	add    $0x10,%esp
  pid3 = fork();
     be5:	e8 9d 32 00 00       	call   3e87 <fork>
     bea:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid3 == 0){
     bed:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     bf1:	75 4d                	jne    c40 <preempt+0xa2>
    close(pfds[0]);
     bf3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     bf6:	83 ec 0c             	sub    $0xc,%esp
     bf9:	50                   	push   %eax
     bfa:	e8 b8 32 00 00       	call   3eb7 <close>
     bff:	83 c4 10             	add    $0x10,%esp
    if(write(pfds[1], "x", 1) != 1)
     c02:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c05:	83 ec 04             	sub    $0x4,%esp
     c08:	6a 01                	push   $0x1
     c0a:	68 87 48 00 00       	push   $0x4887
     c0f:	50                   	push   %eax
     c10:	e8 9a 32 00 00       	call   3eaf <write>
     c15:	83 c4 10             	add    $0x10,%esp
     c18:	83 f8 01             	cmp    $0x1,%eax
     c1b:	74 12                	je     c2f <preempt+0x91>
      printf(1, "preempt write error");
     c1d:	83 ec 08             	sub    $0x8,%esp
     c20:	68 89 48 00 00       	push   $0x4889
     c25:	6a 01                	push   $0x1
     c27:	e8 d5 33 00 00       	call   4001 <printf>
     c2c:	83 c4 10             	add    $0x10,%esp
    close(pfds[1]);
     c2f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c32:	83 ec 0c             	sub    $0xc,%esp
     c35:	50                   	push   %eax
     c36:	e8 7c 32 00 00       	call   3eb7 <close>
     c3b:	83 c4 10             	add    $0x10,%esp
    for(;;)
      ;
     c3e:	eb fe                	jmp    c3e <preempt+0xa0>
  }

  close(pfds[1]);
     c40:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c43:	83 ec 0c             	sub    $0xc,%esp
     c46:	50                   	push   %eax
     c47:	e8 6b 32 00 00       	call   3eb7 <close>
     c4c:	83 c4 10             	add    $0x10,%esp
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     c4f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c52:	83 ec 04             	sub    $0x4,%esp
     c55:	68 00 20 00 00       	push   $0x2000
     c5a:	68 80 8a 00 00       	push   $0x8a80
     c5f:	50                   	push   %eax
     c60:	e8 42 32 00 00       	call   3ea7 <read>
     c65:	83 c4 10             	add    $0x10,%esp
     c68:	83 f8 01             	cmp    $0x1,%eax
     c6b:	74 14                	je     c81 <preempt+0xe3>
    printf(1, "preempt read error");
     c6d:	83 ec 08             	sub    $0x8,%esp
     c70:	68 9d 48 00 00       	push   $0x489d
     c75:	6a 01                	push   $0x1
     c77:	e8 85 33 00 00       	call   4001 <printf>
     c7c:	83 c4 10             	add    $0x10,%esp
     c7f:	eb 7e                	jmp    cff <preempt+0x161>
    return;
  }
  close(pfds[0]);
     c81:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c84:	83 ec 0c             	sub    $0xc,%esp
     c87:	50                   	push   %eax
     c88:	e8 2a 32 00 00       	call   3eb7 <close>
     c8d:	83 c4 10             	add    $0x10,%esp
  printf(1, "kill... ");
     c90:	83 ec 08             	sub    $0x8,%esp
     c93:	68 b0 48 00 00       	push   $0x48b0
     c98:	6a 01                	push   $0x1
     c9a:	e8 62 33 00 00       	call   4001 <printf>
     c9f:	83 c4 10             	add    $0x10,%esp
  kill(pid1);
     ca2:	83 ec 0c             	sub    $0xc,%esp
     ca5:	ff 75 f4             	pushl  -0xc(%ebp)
     ca8:	e8 12 32 00 00       	call   3ebf <kill>
     cad:	83 c4 10             	add    $0x10,%esp
  kill(pid2);
     cb0:	83 ec 0c             	sub    $0xc,%esp
     cb3:	ff 75 f0             	pushl  -0x10(%ebp)
     cb6:	e8 04 32 00 00       	call   3ebf <kill>
     cbb:	83 c4 10             	add    $0x10,%esp
  kill(pid3);
     cbe:	83 ec 0c             	sub    $0xc,%esp
     cc1:	ff 75 ec             	pushl  -0x14(%ebp)
     cc4:	e8 f6 31 00 00       	call   3ebf <kill>
     cc9:	83 c4 10             	add    $0x10,%esp
  printf(1, "wait... ");
     ccc:	83 ec 08             	sub    $0x8,%esp
     ccf:	68 b9 48 00 00       	push   $0x48b9
     cd4:	6a 01                	push   $0x1
     cd6:	e8 26 33 00 00       	call   4001 <printf>
     cdb:	83 c4 10             	add    $0x10,%esp
  wait();
     cde:	e8 b4 31 00 00       	call   3e97 <wait>
  wait();
     ce3:	e8 af 31 00 00       	call   3e97 <wait>
  wait();
     ce8:	e8 aa 31 00 00       	call   3e97 <wait>
  printf(1, "preempt ok\n");
     ced:	83 ec 08             	sub    $0x8,%esp
     cf0:	68 c2 48 00 00       	push   $0x48c2
     cf5:	6a 01                	push   $0x1
     cf7:	e8 05 33 00 00       	call   4001 <printf>
     cfc:	83 c4 10             	add    $0x10,%esp
}
     cff:	c9                   	leave  
     d00:	c3                   	ret    

00000d01 <exitwait>:

// try to find any races between exit and wait
void
exitwait(void)
{
     d01:	55                   	push   %ebp
     d02:	89 e5                	mov    %esp,%ebp
     d04:	83 ec 18             	sub    $0x18,%esp
  int i, pid;

  for(i = 0; i < 100; i++){
     d07:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d0e:	eb 4e                	jmp    d5e <exitwait+0x5d>
    pid = fork();
     d10:	e8 72 31 00 00       	call   3e87 <fork>
     d15:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0){
     d18:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     d1c:	79 14                	jns    d32 <exitwait+0x31>
      printf(1, "fork failed\n");
     d1e:	83 ec 08             	sub    $0x8,%esp
     d21:	68 51 44 00 00       	push   $0x4451
     d26:	6a 01                	push   $0x1
     d28:	e8 d4 32 00 00       	call   4001 <printf>
     d2d:	83 c4 10             	add    $0x10,%esp
      return;
     d30:	eb 44                	jmp    d76 <exitwait+0x75>
    }
    if(pid){
     d32:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     d36:	74 1e                	je     d56 <exitwait+0x55>
      if(wait() != pid){
     d38:	e8 5a 31 00 00       	call   3e97 <wait>
     d3d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     d40:	74 19                	je     d5b <exitwait+0x5a>
        printf(1, "wait wrong pid\n");
     d42:	83 ec 08             	sub    $0x8,%esp
     d45:	68 ce 48 00 00       	push   $0x48ce
     d4a:	6a 01                	push   $0x1
     d4c:	e8 b0 32 00 00       	call   4001 <printf>
     d51:	83 c4 10             	add    $0x10,%esp
        return;
     d54:	eb 20                	jmp    d76 <exitwait+0x75>
      }
    } else {
      exit();
     d56:	e8 34 31 00 00       	call   3e8f <exit>
void
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
     d5b:	ff 45 f4             	incl   -0xc(%ebp)
     d5e:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     d62:	7e ac                	jle    d10 <exitwait+0xf>
      }
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
     d64:	83 ec 08             	sub    $0x8,%esp
     d67:	68 de 48 00 00       	push   $0x48de
     d6c:	6a 01                	push   $0x1
     d6e:	e8 8e 32 00 00       	call   4001 <printf>
     d73:	83 c4 10             	add    $0x10,%esp
}
     d76:	c9                   	leave  
     d77:	c3                   	ret    

00000d78 <mem>:

void
mem(void)
{
     d78:	55                   	push   %ebp
     d79:	89 e5                	mov    %esp,%ebp
     d7b:	83 ec 18             	sub    $0x18,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
     d7e:	83 ec 08             	sub    $0x8,%esp
     d81:	68 eb 48 00 00       	push   $0x48eb
     d86:	6a 01                	push   $0x1
     d88:	e8 74 32 00 00       	call   4001 <printf>
     d8d:	83 c4 10             	add    $0x10,%esp
  ppid = getpid();
     d90:	e8 7a 31 00 00       	call   3f0f <getpid>
     d95:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if((pid = fork()) == 0){
     d98:	e8 ea 30 00 00       	call   3e87 <fork>
     d9d:	89 45 ec             	mov    %eax,-0x14(%ebp)
     da0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     da4:	0f 85 b7 00 00 00    	jne    e61 <mem+0xe9>
    m1 = 0;
     daa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while((m2 = malloc(10001)) != 0){
     db1:	eb 0e                	jmp    dc1 <mem+0x49>
      *(char**)m2 = m1;
     db3:	8b 45 e8             	mov    -0x18(%ebp),%eax
     db6:	8b 55 f4             	mov    -0xc(%ebp),%edx
     db9:	89 10                	mov    %edx,(%eax)
      m1 = m2;
     dbb:	8b 45 e8             	mov    -0x18(%ebp),%eax
     dbe:	89 45 f4             	mov    %eax,-0xc(%ebp)

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
     dc1:	83 ec 0c             	sub    $0xc,%esp
     dc4:	68 11 27 00 00       	push   $0x2711
     dc9:	e8 fe 34 00 00       	call   42cc <malloc>
     dce:	83 c4 10             	add    $0x10,%esp
     dd1:	89 45 e8             	mov    %eax,-0x18(%ebp)
     dd4:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     dd8:	75 d9                	jne    db3 <mem+0x3b>
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     dda:	eb 1c                	jmp    df8 <mem+0x80>
      m2 = *(char**)m1;
     ddc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ddf:	8b 00                	mov    (%eax),%eax
     de1:	89 45 e8             	mov    %eax,-0x18(%ebp)
      free(m1);
     de4:	83 ec 0c             	sub    $0xc,%esp
     de7:	ff 75 f4             	pushl  -0xc(%ebp)
     dea:	e8 9c 33 00 00       	call   418b <free>
     def:	83 c4 10             	add    $0x10,%esp
      m1 = m2;
     df2:	8b 45 e8             	mov    -0x18(%ebp),%eax
     df5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     df8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     dfc:	75 de                	jne    ddc <mem+0x64>
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
     dfe:	83 ec 0c             	sub    $0xc,%esp
     e01:	68 00 50 00 00       	push   $0x5000
     e06:	e8 c1 34 00 00       	call   42cc <malloc>
     e0b:	83 c4 10             	add    $0x10,%esp
     e0e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(m1 == 0){
     e11:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e15:	75 25                	jne    e3c <mem+0xc4>
      printf(1, "couldn't allocate mem?!!\n");
     e17:	83 ec 08             	sub    $0x8,%esp
     e1a:	68 f5 48 00 00       	push   $0x48f5
     e1f:	6a 01                	push   $0x1
     e21:	e8 db 31 00 00       	call   4001 <printf>
     e26:	83 c4 10             	add    $0x10,%esp
      kill(ppid);
     e29:	83 ec 0c             	sub    $0xc,%esp
     e2c:	ff 75 f0             	pushl  -0x10(%ebp)
     e2f:	e8 8b 30 00 00       	call   3ebf <kill>
     e34:	83 c4 10             	add    $0x10,%esp
      exit();
     e37:	e8 53 30 00 00       	call   3e8f <exit>
    }
    free(m1);
     e3c:	83 ec 0c             	sub    $0xc,%esp
     e3f:	ff 75 f4             	pushl  -0xc(%ebp)
     e42:	e8 44 33 00 00       	call   418b <free>
     e47:	83 c4 10             	add    $0x10,%esp
    printf(1, "mem ok\n");
     e4a:	83 ec 08             	sub    $0x8,%esp
     e4d:	68 0f 49 00 00       	push   $0x490f
     e52:	6a 01                	push   $0x1
     e54:	e8 a8 31 00 00       	call   4001 <printf>
     e59:	83 c4 10             	add    $0x10,%esp
    exit();
     e5c:	e8 2e 30 00 00       	call   3e8f <exit>
  } else {
    wait();
     e61:	e8 31 30 00 00       	call   3e97 <wait>
  }
}
     e66:	c9                   	leave  
     e67:	c3                   	ret    

00000e68 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     e68:	55                   	push   %ebp
     e69:	89 e5                	mov    %esp,%ebp
     e6b:	83 ec 38             	sub    $0x38,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
     e6e:	83 ec 08             	sub    $0x8,%esp
     e71:	68 17 49 00 00       	push   $0x4917
     e76:	6a 01                	push   $0x1
     e78:	e8 84 31 00 00       	call   4001 <printf>
     e7d:	83 c4 10             	add    $0x10,%esp

  unlink("sharedfd");
     e80:	83 ec 0c             	sub    $0xc,%esp
     e83:	68 26 49 00 00       	push   $0x4926
     e88:	e8 52 30 00 00       	call   3edf <unlink>
     e8d:	83 c4 10             	add    $0x10,%esp
  fd = open("sharedfd", O_CREATE|O_RDWR);
     e90:	83 ec 08             	sub    $0x8,%esp
     e93:	68 02 02 00 00       	push   $0x202
     e98:	68 26 49 00 00       	push   $0x4926
     e9d:	e8 2d 30 00 00       	call   3ecf <open>
     ea2:	83 c4 10             	add    $0x10,%esp
     ea5:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
     ea8:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     eac:	79 17                	jns    ec5 <sharedfd+0x5d>
    printf(1, "fstests: cannot open sharedfd for writing");
     eae:	83 ec 08             	sub    $0x8,%esp
     eb1:	68 30 49 00 00       	push   $0x4930
     eb6:	6a 01                	push   $0x1
     eb8:	e8 44 31 00 00       	call   4001 <printf>
     ebd:	83 c4 10             	add    $0x10,%esp
    return;
     ec0:	e9 7e 01 00 00       	jmp    1043 <sharedfd+0x1db>
  }
  pid = fork();
     ec5:	e8 bd 2f 00 00       	call   3e87 <fork>
     eca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     ecd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     ed1:	75 07                	jne    eda <sharedfd+0x72>
     ed3:	b8 63 00 00 00       	mov    $0x63,%eax
     ed8:	eb 05                	jmp    edf <sharedfd+0x77>
     eda:	b8 70 00 00 00       	mov    $0x70,%eax
     edf:	83 ec 04             	sub    $0x4,%esp
     ee2:	6a 0a                	push   $0xa
     ee4:	50                   	push   %eax
     ee5:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     ee8:	50                   	push   %eax
     ee9:	e8 13 2e 00 00       	call   3d01 <memset>
     eee:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 1000; i++){
     ef1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ef8:	eb 30                	jmp    f2a <sharedfd+0xc2>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     efa:	83 ec 04             	sub    $0x4,%esp
     efd:	6a 0a                	push   $0xa
     eff:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     f02:	50                   	push   %eax
     f03:	ff 75 e8             	pushl  -0x18(%ebp)
     f06:	e8 a4 2f 00 00       	call   3eaf <write>
     f0b:	83 c4 10             	add    $0x10,%esp
     f0e:	83 f8 0a             	cmp    $0xa,%eax
     f11:	74 14                	je     f27 <sharedfd+0xbf>
      printf(1, "fstests: write sharedfd failed\n");
     f13:	83 ec 08             	sub    $0x8,%esp
     f16:	68 5c 49 00 00       	push   $0x495c
     f1b:	6a 01                	push   $0x1
     f1d:	e8 df 30 00 00       	call   4001 <printf>
     f22:	83 c4 10             	add    $0x10,%esp
      break;
     f25:	eb 0c                	jmp    f33 <sharedfd+0xcb>
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
  memset(buf, pid==0?'c':'p', sizeof(buf));
  for(i = 0; i < 1000; i++){
     f27:	ff 45 f4             	incl   -0xc(%ebp)
     f2a:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
     f31:	7e c7                	jle    efa <sharedfd+0x92>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
      printf(1, "fstests: write sharedfd failed\n");
      break;
    }
  }
  if(pid == 0)
     f33:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     f37:	75 05                	jne    f3e <sharedfd+0xd6>
    exit();
     f39:	e8 51 2f 00 00       	call   3e8f <exit>
  else
    wait();
     f3e:	e8 54 2f 00 00       	call   3e97 <wait>
  close(fd);
     f43:	83 ec 0c             	sub    $0xc,%esp
     f46:	ff 75 e8             	pushl  -0x18(%ebp)
     f49:	e8 69 2f 00 00       	call   3eb7 <close>
     f4e:	83 c4 10             	add    $0x10,%esp
  fd = open("sharedfd", 0);
     f51:	83 ec 08             	sub    $0x8,%esp
     f54:	6a 00                	push   $0x0
     f56:	68 26 49 00 00       	push   $0x4926
     f5b:	e8 6f 2f 00 00       	call   3ecf <open>
     f60:	83 c4 10             	add    $0x10,%esp
     f63:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
     f66:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     f6a:	79 17                	jns    f83 <sharedfd+0x11b>
    printf(1, "fstests: cannot open sharedfd for reading\n");
     f6c:	83 ec 08             	sub    $0x8,%esp
     f6f:	68 7c 49 00 00       	push   $0x497c
     f74:	6a 01                	push   $0x1
     f76:	e8 86 30 00 00       	call   4001 <printf>
     f7b:	83 c4 10             	add    $0x10,%esp
    return;
     f7e:	e9 c0 00 00 00       	jmp    1043 <sharedfd+0x1db>
  }
  nc = np = 0;
     f83:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     f8a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f8d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
     f90:	eb 36                	jmp    fc8 <sharedfd+0x160>
    for(i = 0; i < sizeof(buf); i++){
     f92:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     f99:	eb 25                	jmp    fc0 <sharedfd+0x158>
      if(buf[i] == 'c')
     f9b:	8d 55 d6             	lea    -0x2a(%ebp),%edx
     f9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fa1:	01 d0                	add    %edx,%eax
     fa3:	8a 00                	mov    (%eax),%al
     fa5:	3c 63                	cmp    $0x63,%al
     fa7:	75 03                	jne    fac <sharedfd+0x144>
        nc++;
     fa9:	ff 45 f0             	incl   -0x10(%ebp)
      if(buf[i] == 'p')
     fac:	8d 55 d6             	lea    -0x2a(%ebp),%edx
     faf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fb2:	01 d0                	add    %edx,%eax
     fb4:	8a 00                	mov    (%eax),%al
     fb6:	3c 70                	cmp    $0x70,%al
     fb8:	75 03                	jne    fbd <sharedfd+0x155>
        np++;
     fba:	ff 45 ec             	incl   -0x14(%ebp)
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
     fbd:	ff 45 f4             	incl   -0xc(%ebp)
     fc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fc3:	83 f8 09             	cmp    $0x9,%eax
     fc6:	76 d3                	jbe    f9b <sharedfd+0x133>
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
     fc8:	83 ec 04             	sub    $0x4,%esp
     fcb:	6a 0a                	push   $0xa
     fcd:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     fd0:	50                   	push   %eax
     fd1:	ff 75 e8             	pushl  -0x18(%ebp)
     fd4:	e8 ce 2e 00 00       	call   3ea7 <read>
     fd9:	83 c4 10             	add    $0x10,%esp
     fdc:	89 45 e0             	mov    %eax,-0x20(%ebp)
     fdf:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     fe3:	7f ad                	jg     f92 <sharedfd+0x12a>
        nc++;
      if(buf[i] == 'p')
        np++;
    }
  }
  close(fd);
     fe5:	83 ec 0c             	sub    $0xc,%esp
     fe8:	ff 75 e8             	pushl  -0x18(%ebp)
     feb:	e8 c7 2e 00 00       	call   3eb7 <close>
     ff0:	83 c4 10             	add    $0x10,%esp
  unlink("sharedfd");
     ff3:	83 ec 0c             	sub    $0xc,%esp
     ff6:	68 26 49 00 00       	push   $0x4926
     ffb:	e8 df 2e 00 00       	call   3edf <unlink>
    1000:	83 c4 10             	add    $0x10,%esp
  if(nc == 10000 && np == 10000){
    1003:	81 7d f0 10 27 00 00 	cmpl   $0x2710,-0x10(%ebp)
    100a:	75 1d                	jne    1029 <sharedfd+0x1c1>
    100c:	81 7d ec 10 27 00 00 	cmpl   $0x2710,-0x14(%ebp)
    1013:	75 14                	jne    1029 <sharedfd+0x1c1>
    printf(1, "sharedfd ok\n");
    1015:	83 ec 08             	sub    $0x8,%esp
    1018:	68 a7 49 00 00       	push   $0x49a7
    101d:	6a 01                	push   $0x1
    101f:	e8 dd 2f 00 00       	call   4001 <printf>
    1024:	83 c4 10             	add    $0x10,%esp
    1027:	eb 1a                	jmp    1043 <sharedfd+0x1db>
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    1029:	ff 75 ec             	pushl  -0x14(%ebp)
    102c:	ff 75 f0             	pushl  -0x10(%ebp)
    102f:	68 b4 49 00 00       	push   $0x49b4
    1034:	6a 01                	push   $0x1
    1036:	e8 c6 2f 00 00       	call   4001 <printf>
    103b:	83 c4 10             	add    $0x10,%esp
    exit();
    103e:	e8 4c 2e 00 00       	call   3e8f <exit>
  }
}
    1043:	c9                   	leave  
    1044:	c3                   	ret    

00001045 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    1045:	55                   	push   %ebp
    1046:	89 e5                	mov    %esp,%ebp
    1048:	57                   	push   %edi
    1049:	56                   	push   %esi
    104a:	53                   	push   %ebx
    104b:	83 ec 3c             	sub    $0x3c,%esp
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    104e:	8d 55 b8             	lea    -0x48(%ebp),%edx
    1051:	bb 30 4a 00 00       	mov    $0x4a30,%ebx
    1056:	b8 04 00 00 00       	mov    $0x4,%eax
    105b:	89 d7                	mov    %edx,%edi
    105d:	89 de                	mov    %ebx,%esi
    105f:	89 c1                	mov    %eax,%ecx
    1061:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  char *fname;

  printf(1, "fourfiles test\n");
    1063:	83 ec 08             	sub    $0x8,%esp
    1066:	68 c9 49 00 00       	push   $0x49c9
    106b:	6a 01                	push   $0x1
    106d:	e8 8f 2f 00 00       	call   4001 <printf>
    1072:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    1075:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    107c:	e9 ee 00 00 00       	jmp    116f <fourfiles+0x12a>
    fname = names[pi];
    1081:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1084:	8b 44 85 b8          	mov    -0x48(%ebp,%eax,4),%eax
    1088:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unlink(fname);
    108b:	83 ec 0c             	sub    $0xc,%esp
    108e:	ff 75 d4             	pushl  -0x2c(%ebp)
    1091:	e8 49 2e 00 00       	call   3edf <unlink>
    1096:	83 c4 10             	add    $0x10,%esp

    pid = fork();
    1099:	e8 e9 2d 00 00       	call   3e87 <fork>
    109e:	89 45 d0             	mov    %eax,-0x30(%ebp)
    if(pid < 0){
    10a1:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
    10a5:	79 17                	jns    10be <fourfiles+0x79>
      printf(1, "fork failed\n");
    10a7:	83 ec 08             	sub    $0x8,%esp
    10aa:	68 51 44 00 00       	push   $0x4451
    10af:	6a 01                	push   $0x1
    10b1:	e8 4b 2f 00 00       	call   4001 <printf>
    10b6:	83 c4 10             	add    $0x10,%esp
      exit();
    10b9:	e8 d1 2d 00 00       	call   3e8f <exit>
    }

    if(pid == 0){
    10be:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
    10c2:	0f 85 a4 00 00 00    	jne    116c <fourfiles+0x127>
      fd = open(fname, O_CREATE | O_RDWR);
    10c8:	83 ec 08             	sub    $0x8,%esp
    10cb:	68 02 02 00 00       	push   $0x202
    10d0:	ff 75 d4             	pushl  -0x2c(%ebp)
    10d3:	e8 f7 2d 00 00       	call   3ecf <open>
    10d8:	83 c4 10             	add    $0x10,%esp
    10db:	89 45 cc             	mov    %eax,-0x34(%ebp)
      if(fd < 0){
    10de:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
    10e2:	79 17                	jns    10fb <fourfiles+0xb6>
        printf(1, "create failed\n");
    10e4:	83 ec 08             	sub    $0x8,%esp
    10e7:	68 d9 49 00 00       	push   $0x49d9
    10ec:	6a 01                	push   $0x1
    10ee:	e8 0e 2f 00 00       	call   4001 <printf>
    10f3:	83 c4 10             	add    $0x10,%esp
        exit();
    10f6:	e8 94 2d 00 00       	call   3e8f <exit>
      }
      
      memset(buf, '0'+pi, 512);
    10fb:	8b 45 d8             	mov    -0x28(%ebp),%eax
    10fe:	83 c0 30             	add    $0x30,%eax
    1101:	83 ec 04             	sub    $0x4,%esp
    1104:	68 00 02 00 00       	push   $0x200
    1109:	50                   	push   %eax
    110a:	68 80 8a 00 00       	push   $0x8a80
    110f:	e8 ed 2b 00 00       	call   3d01 <memset>
    1114:	83 c4 10             	add    $0x10,%esp
      for(i = 0; i < 12; i++){
    1117:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    111e:	eb 41                	jmp    1161 <fourfiles+0x11c>
        if((n = write(fd, buf, 500)) != 500){
    1120:	83 ec 04             	sub    $0x4,%esp
    1123:	68 f4 01 00 00       	push   $0x1f4
    1128:	68 80 8a 00 00       	push   $0x8a80
    112d:	ff 75 cc             	pushl  -0x34(%ebp)
    1130:	e8 7a 2d 00 00       	call   3eaf <write>
    1135:	83 c4 10             	add    $0x10,%esp
    1138:	89 45 c8             	mov    %eax,-0x38(%ebp)
    113b:	81 7d c8 f4 01 00 00 	cmpl   $0x1f4,-0x38(%ebp)
    1142:	74 1a                	je     115e <fourfiles+0x119>
          printf(1, "write failed %d\n", n);
    1144:	83 ec 04             	sub    $0x4,%esp
    1147:	ff 75 c8             	pushl  -0x38(%ebp)
    114a:	68 e8 49 00 00       	push   $0x49e8
    114f:	6a 01                	push   $0x1
    1151:	e8 ab 2e 00 00       	call   4001 <printf>
    1156:	83 c4 10             	add    $0x10,%esp
          exit();
    1159:	e8 31 2d 00 00       	call   3e8f <exit>
        printf(1, "create failed\n");
        exit();
      }
      
      memset(buf, '0'+pi, 512);
      for(i = 0; i < 12; i++){
    115e:	ff 45 e4             	incl   -0x1c(%ebp)
    1161:	83 7d e4 0b          	cmpl   $0xb,-0x1c(%ebp)
    1165:	7e b9                	jle    1120 <fourfiles+0xdb>
        if((n = write(fd, buf, 500)) != 500){
          printf(1, "write failed %d\n", n);
          exit();
        }
      }
      exit();
    1167:	e8 23 2d 00 00       	call   3e8f <exit>
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");

  for(pi = 0; pi < 4; pi++){
    116c:	ff 45 d8             	incl   -0x28(%ebp)
    116f:	83 7d d8 03          	cmpl   $0x3,-0x28(%ebp)
    1173:	0f 8e 08 ff ff ff    	jle    1081 <fourfiles+0x3c>
      }
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    1179:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    1180:	eb 08                	jmp    118a <fourfiles+0x145>
    wait();
    1182:	e8 10 2d 00 00       	call   3e97 <wait>
      }
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    1187:	ff 45 d8             	incl   -0x28(%ebp)
    118a:	83 7d d8 03          	cmpl   $0x3,-0x28(%ebp)
    118e:	7e f2                	jle    1182 <fourfiles+0x13d>
    wait();
  }

  for(i = 0; i < 2; i++){
    1190:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    1197:	e9 d1 00 00 00       	jmp    126d <fourfiles+0x228>
    fname = names[i];
    119c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    119f:	8b 44 85 b8          	mov    -0x48(%ebp,%eax,4),%eax
    11a3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    fd = open(fname, 0);
    11a6:	83 ec 08             	sub    $0x8,%esp
    11a9:	6a 00                	push   $0x0
    11ab:	ff 75 d4             	pushl  -0x2c(%ebp)
    11ae:	e8 1c 2d 00 00       	call   3ecf <open>
    11b3:	83 c4 10             	add    $0x10,%esp
    11b6:	89 45 cc             	mov    %eax,-0x34(%ebp)
    total = 0;
    11b9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    11c0:	eb 48                	jmp    120a <fourfiles+0x1c5>
      for(j = 0; j < n; j++){
    11c2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    11c9:	eb 31                	jmp    11fc <fourfiles+0x1b7>
        if(buf[j] != '0'+i){
    11cb:	8b 45 e0             	mov    -0x20(%ebp),%eax
    11ce:	05 80 8a 00 00       	add    $0x8a80,%eax
    11d3:	8a 00                	mov    (%eax),%al
    11d5:	0f be c0             	movsbl %al,%eax
    11d8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    11db:	83 c2 30             	add    $0x30,%edx
    11de:	39 d0                	cmp    %edx,%eax
    11e0:	74 17                	je     11f9 <fourfiles+0x1b4>
          printf(1, "wrong char\n");
    11e2:	83 ec 08             	sub    $0x8,%esp
    11e5:	68 f9 49 00 00       	push   $0x49f9
    11ea:	6a 01                	push   $0x1
    11ec:	e8 10 2e 00 00       	call   4001 <printf>
    11f1:	83 c4 10             	add    $0x10,%esp
          exit();
    11f4:	e8 96 2c 00 00       	call   3e8f <exit>
  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
    11f9:	ff 45 e0             	incl   -0x20(%ebp)
    11fc:	8b 45 e0             	mov    -0x20(%ebp),%eax
    11ff:	3b 45 c8             	cmp    -0x38(%ebp),%eax
    1202:	7c c7                	jl     11cb <fourfiles+0x186>
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
          exit();
        }
      }
      total += n;
    1204:	8b 45 c8             	mov    -0x38(%ebp),%eax
    1207:	01 45 dc             	add    %eax,-0x24(%ebp)

  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
    120a:	83 ec 04             	sub    $0x4,%esp
    120d:	68 00 20 00 00       	push   $0x2000
    1212:	68 80 8a 00 00       	push   $0x8a80
    1217:	ff 75 cc             	pushl  -0x34(%ebp)
    121a:	e8 88 2c 00 00       	call   3ea7 <read>
    121f:	83 c4 10             	add    $0x10,%esp
    1222:	89 45 c8             	mov    %eax,-0x38(%ebp)
    1225:	83 7d c8 00          	cmpl   $0x0,-0x38(%ebp)
    1229:	7f 97                	jg     11c2 <fourfiles+0x17d>
          exit();
        }
      }
      total += n;
    }
    close(fd);
    122b:	83 ec 0c             	sub    $0xc,%esp
    122e:	ff 75 cc             	pushl  -0x34(%ebp)
    1231:	e8 81 2c 00 00       	call   3eb7 <close>
    1236:	83 c4 10             	add    $0x10,%esp
    if(total != 12*500){
    1239:	81 7d dc 70 17 00 00 	cmpl   $0x1770,-0x24(%ebp)
    1240:	74 1a                	je     125c <fourfiles+0x217>
      printf(1, "wrong length %d\n", total);
    1242:	83 ec 04             	sub    $0x4,%esp
    1245:	ff 75 dc             	pushl  -0x24(%ebp)
    1248:	68 05 4a 00 00       	push   $0x4a05
    124d:	6a 01                	push   $0x1
    124f:	e8 ad 2d 00 00       	call   4001 <printf>
    1254:	83 c4 10             	add    $0x10,%esp
      exit();
    1257:	e8 33 2c 00 00       	call   3e8f <exit>
    }
    unlink(fname);
    125c:	83 ec 0c             	sub    $0xc,%esp
    125f:	ff 75 d4             	pushl  -0x2c(%ebp)
    1262:	e8 78 2c 00 00       	call   3edf <unlink>
    1267:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    wait();
  }

  for(i = 0; i < 2; i++){
    126a:	ff 45 e4             	incl   -0x1c(%ebp)
    126d:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1271:	0f 8e 25 ff ff ff    	jle    119c <fourfiles+0x157>
      exit();
    }
    unlink(fname);
  }

  printf(1, "fourfiles ok\n");
    1277:	83 ec 08             	sub    $0x8,%esp
    127a:	68 16 4a 00 00       	push   $0x4a16
    127f:	6a 01                	push   $0x1
    1281:	e8 7b 2d 00 00       	call   4001 <printf>
    1286:	83 c4 10             	add    $0x10,%esp
}
    1289:	8d 65 f4             	lea    -0xc(%ebp),%esp
    128c:	5b                   	pop    %ebx
    128d:	5e                   	pop    %esi
    128e:	5f                   	pop    %edi
    128f:	5d                   	pop    %ebp
    1290:	c3                   	ret    

00001291 <createdelete>:

// four processes create and delete different files in same directory
void
createdelete(void)
{
    1291:	55                   	push   %ebp
    1292:	89 e5                	mov    %esp,%ebp
    1294:	83 ec 38             	sub    $0x38,%esp
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
    1297:	83 ec 08             	sub    $0x8,%esp
    129a:	68 40 4a 00 00       	push   $0x4a40
    129f:	6a 01                	push   $0x1
    12a1:	e8 5b 2d 00 00       	call   4001 <printf>
    12a6:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    12a9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12b0:	e9 f4 00 00 00       	jmp    13a9 <createdelete+0x118>
    pid = fork();
    12b5:	e8 cd 2b 00 00       	call   3e87 <fork>
    12ba:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pid < 0){
    12bd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    12c1:	79 17                	jns    12da <createdelete+0x49>
      printf(1, "fork failed\n");
    12c3:	83 ec 08             	sub    $0x8,%esp
    12c6:	68 51 44 00 00       	push   $0x4451
    12cb:	6a 01                	push   $0x1
    12cd:	e8 2f 2d 00 00       	call   4001 <printf>
    12d2:	83 c4 10             	add    $0x10,%esp
      exit();
    12d5:	e8 b5 2b 00 00       	call   3e8f <exit>
    }

    if(pid == 0){
    12da:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    12de:	0f 85 c2 00 00 00    	jne    13a6 <createdelete+0x115>
      name[0] = 'p' + pi;
    12e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12e7:	83 c0 70             	add    $0x70,%eax
    12ea:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[2] = '\0';
    12ed:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
      for(i = 0; i < N; i++){
    12f1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12f8:	e9 9a 00 00 00       	jmp    1397 <createdelete+0x106>
        name[1] = '0' + i;
    12fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1300:	83 c0 30             	add    $0x30,%eax
    1303:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    1306:	83 ec 08             	sub    $0x8,%esp
    1309:	68 02 02 00 00       	push   $0x202
    130e:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1311:	50                   	push   %eax
    1312:	e8 b8 2b 00 00       	call   3ecf <open>
    1317:	83 c4 10             	add    $0x10,%esp
    131a:	89 45 e8             	mov    %eax,-0x18(%ebp)
        if(fd < 0){
    131d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1321:	79 17                	jns    133a <createdelete+0xa9>
          printf(1, "create failed\n");
    1323:	83 ec 08             	sub    $0x8,%esp
    1326:	68 d9 49 00 00       	push   $0x49d9
    132b:	6a 01                	push   $0x1
    132d:	e8 cf 2c 00 00       	call   4001 <printf>
    1332:	83 c4 10             	add    $0x10,%esp
          exit();
    1335:	e8 55 2b 00 00       	call   3e8f <exit>
        }
        close(fd);
    133a:	83 ec 0c             	sub    $0xc,%esp
    133d:	ff 75 e8             	pushl  -0x18(%ebp)
    1340:	e8 72 2b 00 00       	call   3eb7 <close>
    1345:	83 c4 10             	add    $0x10,%esp
        if(i > 0 && (i % 2 ) == 0){
    1348:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    134c:	7e 46                	jle    1394 <createdelete+0x103>
    134e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1351:	83 e0 01             	and    $0x1,%eax
    1354:	85 c0                	test   %eax,%eax
    1356:	75 3c                	jne    1394 <createdelete+0x103>
          name[1] = '0' + (i / 2);
    1358:	8b 45 f4             	mov    -0xc(%ebp),%eax
    135b:	89 c2                	mov    %eax,%edx
    135d:	c1 ea 1f             	shr    $0x1f,%edx
    1360:	01 d0                	add    %edx,%eax
    1362:	d1 f8                	sar    %eax
    1364:	83 c0 30             	add    $0x30,%eax
    1367:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    136a:	83 ec 0c             	sub    $0xc,%esp
    136d:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1370:	50                   	push   %eax
    1371:	e8 69 2b 00 00       	call   3edf <unlink>
    1376:	83 c4 10             	add    $0x10,%esp
    1379:	85 c0                	test   %eax,%eax
    137b:	79 17                	jns    1394 <createdelete+0x103>
            printf(1, "unlink failed\n");
    137d:	83 ec 08             	sub    $0x8,%esp
    1380:	68 d4 44 00 00       	push   $0x44d4
    1385:	6a 01                	push   $0x1
    1387:	e8 75 2c 00 00       	call   4001 <printf>
    138c:	83 c4 10             	add    $0x10,%esp
            exit();
    138f:	e8 fb 2a 00 00       	call   3e8f <exit>
    }

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
      for(i = 0; i < N; i++){
    1394:	ff 45 f4             	incl   -0xc(%ebp)
    1397:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    139b:	0f 8e 5c ff ff ff    	jle    12fd <createdelete+0x6c>
            printf(1, "unlink failed\n");
            exit();
          }
        }
      }
      exit();
    13a1:	e8 e9 2a 00 00       	call   3e8f <exit>
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    13a6:	ff 45 f0             	incl   -0x10(%ebp)
    13a9:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    13ad:	0f 8e 02 ff ff ff    	jle    12b5 <createdelete+0x24>
      }
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    13b3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    13ba:	eb 08                	jmp    13c4 <createdelete+0x133>
    wait();
    13bc:	e8 d6 2a 00 00       	call   3e97 <wait>
      }
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    13c1:	ff 45 f0             	incl   -0x10(%ebp)
    13c4:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    13c8:	7e f2                	jle    13bc <createdelete+0x12b>
    wait();
  }

  name[0] = name[1] = name[2] = 0;
    13ca:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    13ce:	8a 45 ca             	mov    -0x36(%ebp),%al
    13d1:	88 45 c9             	mov    %al,-0x37(%ebp)
    13d4:	8a 45 c9             	mov    -0x37(%ebp),%al
    13d7:	88 45 c8             	mov    %al,-0x38(%ebp)
  for(i = 0; i < N; i++){
    13da:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    13e1:	e9 b0 00 00 00       	jmp    1496 <createdelete+0x205>
    for(pi = 0; pi < 4; pi++){
    13e6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    13ed:	e9 97 00 00 00       	jmp    1489 <createdelete+0x1f8>
      name[0] = 'p' + pi;
    13f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13f5:	83 c0 70             	add    $0x70,%eax
    13f8:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    13fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13fe:	83 c0 30             	add    $0x30,%eax
    1401:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    1404:	83 ec 08             	sub    $0x8,%esp
    1407:	6a 00                	push   $0x0
    1409:	8d 45 c8             	lea    -0x38(%ebp),%eax
    140c:	50                   	push   %eax
    140d:	e8 bd 2a 00 00       	call   3ecf <open>
    1412:	83 c4 10             	add    $0x10,%esp
    1415:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((i == 0 || i >= N/2) && fd < 0){
    1418:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    141c:	74 06                	je     1424 <createdelete+0x193>
    141e:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1422:	7e 21                	jle    1445 <createdelete+0x1b4>
    1424:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1428:	79 1b                	jns    1445 <createdelete+0x1b4>
        printf(1, "oops createdelete %s didn't exist\n", name);
    142a:	83 ec 04             	sub    $0x4,%esp
    142d:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1430:	50                   	push   %eax
    1431:	68 54 4a 00 00       	push   $0x4a54
    1436:	6a 01                	push   $0x1
    1438:	e8 c4 2b 00 00       	call   4001 <printf>
    143d:	83 c4 10             	add    $0x10,%esp
        exit();
    1440:	e8 4a 2a 00 00       	call   3e8f <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1445:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1449:	7e 27                	jle    1472 <createdelete+0x1e1>
    144b:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    144f:	7f 21                	jg     1472 <createdelete+0x1e1>
    1451:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1455:	78 1b                	js     1472 <createdelete+0x1e1>
        printf(1, "oops createdelete %s did exist\n", name);
    1457:	83 ec 04             	sub    $0x4,%esp
    145a:	8d 45 c8             	lea    -0x38(%ebp),%eax
    145d:	50                   	push   %eax
    145e:	68 78 4a 00 00       	push   $0x4a78
    1463:	6a 01                	push   $0x1
    1465:	e8 97 2b 00 00       	call   4001 <printf>
    146a:	83 c4 10             	add    $0x10,%esp
        exit();
    146d:	e8 1d 2a 00 00       	call   3e8f <exit>
      }
      if(fd >= 0)
    1472:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1476:	78 0e                	js     1486 <createdelete+0x1f5>
        close(fd);
    1478:	83 ec 0c             	sub    $0xc,%esp
    147b:	ff 75 e8             	pushl  -0x18(%ebp)
    147e:	e8 34 2a 00 00       	call   3eb7 <close>
    1483:	83 c4 10             	add    $0x10,%esp
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    1486:	ff 45 f0             	incl   -0x10(%ebp)
    1489:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    148d:	0f 8e 5f ff ff ff    	jle    13f2 <createdelete+0x161>
  for(pi = 0; pi < 4; pi++){
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    1493:	ff 45 f4             	incl   -0xc(%ebp)
    1496:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    149a:	0f 8e 46 ff ff ff    	jle    13e6 <createdelete+0x155>
      if(fd >= 0)
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    14a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    14a7:	eb 36                	jmp    14df <createdelete+0x24e>
    for(pi = 0; pi < 4; pi++){
    14a9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14b0:	eb 24                	jmp    14d6 <createdelete+0x245>
      name[0] = 'p' + i;
    14b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b5:	83 c0 70             	add    $0x70,%eax
    14b8:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    14bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14be:	83 c0 30             	add    $0x30,%eax
    14c1:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    14c4:	83 ec 0c             	sub    $0xc,%esp
    14c7:	8d 45 c8             	lea    -0x38(%ebp),%eax
    14ca:	50                   	push   %eax
    14cb:	e8 0f 2a 00 00       	call   3edf <unlink>
    14d0:	83 c4 10             	add    $0x10,%esp
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    14d3:	ff 45 f0             	incl   -0x10(%ebp)
    14d6:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    14da:	7e d6                	jle    14b2 <createdelete+0x221>
      if(fd >= 0)
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    14dc:	ff 45 f4             	incl   -0xc(%ebp)
    14df:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    14e3:	7e c4                	jle    14a9 <createdelete+0x218>
      name[1] = '0' + i;
      unlink(name);
    }
  }

  printf(1, "createdelete ok\n");
    14e5:	83 ec 08             	sub    $0x8,%esp
    14e8:	68 98 4a 00 00       	push   $0x4a98
    14ed:	6a 01                	push   $0x1
    14ef:	e8 0d 2b 00 00       	call   4001 <printf>
    14f4:	83 c4 10             	add    $0x10,%esp
}
    14f7:	c9                   	leave  
    14f8:	c3                   	ret    

000014f9 <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(void)
{
    14f9:	55                   	push   %ebp
    14fa:	89 e5                	mov    %esp,%ebp
    14fc:	83 ec 18             	sub    $0x18,%esp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    14ff:	83 ec 08             	sub    $0x8,%esp
    1502:	68 a9 4a 00 00       	push   $0x4aa9
    1507:	6a 01                	push   $0x1
    1509:	e8 f3 2a 00 00       	call   4001 <printf>
    150e:	83 c4 10             	add    $0x10,%esp
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1511:	83 ec 08             	sub    $0x8,%esp
    1514:	68 02 02 00 00       	push   $0x202
    1519:	68 ba 4a 00 00       	push   $0x4aba
    151e:	e8 ac 29 00 00       	call   3ecf <open>
    1523:	83 c4 10             	add    $0x10,%esp
    1526:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1529:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    152d:	79 17                	jns    1546 <unlinkread+0x4d>
    printf(1, "create unlinkread failed\n");
    152f:	83 ec 08             	sub    $0x8,%esp
    1532:	68 c5 4a 00 00       	push   $0x4ac5
    1537:	6a 01                	push   $0x1
    1539:	e8 c3 2a 00 00       	call   4001 <printf>
    153e:	83 c4 10             	add    $0x10,%esp
    exit();
    1541:	e8 49 29 00 00       	call   3e8f <exit>
  }
  write(fd, "hello", 5);
    1546:	83 ec 04             	sub    $0x4,%esp
    1549:	6a 05                	push   $0x5
    154b:	68 df 4a 00 00       	push   $0x4adf
    1550:	ff 75 f4             	pushl  -0xc(%ebp)
    1553:	e8 57 29 00 00       	call   3eaf <write>
    1558:	83 c4 10             	add    $0x10,%esp
  close(fd);
    155b:	83 ec 0c             	sub    $0xc,%esp
    155e:	ff 75 f4             	pushl  -0xc(%ebp)
    1561:	e8 51 29 00 00       	call   3eb7 <close>
    1566:	83 c4 10             	add    $0x10,%esp

  fd = open("unlinkread", O_RDWR);
    1569:	83 ec 08             	sub    $0x8,%esp
    156c:	6a 02                	push   $0x2
    156e:	68 ba 4a 00 00       	push   $0x4aba
    1573:	e8 57 29 00 00       	call   3ecf <open>
    1578:	83 c4 10             	add    $0x10,%esp
    157b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    157e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1582:	79 17                	jns    159b <unlinkread+0xa2>
    printf(1, "open unlinkread failed\n");
    1584:	83 ec 08             	sub    $0x8,%esp
    1587:	68 e5 4a 00 00       	push   $0x4ae5
    158c:	6a 01                	push   $0x1
    158e:	e8 6e 2a 00 00       	call   4001 <printf>
    1593:	83 c4 10             	add    $0x10,%esp
    exit();
    1596:	e8 f4 28 00 00       	call   3e8f <exit>
  }
  if(unlink("unlinkread") != 0){
    159b:	83 ec 0c             	sub    $0xc,%esp
    159e:	68 ba 4a 00 00       	push   $0x4aba
    15a3:	e8 37 29 00 00       	call   3edf <unlink>
    15a8:	83 c4 10             	add    $0x10,%esp
    15ab:	85 c0                	test   %eax,%eax
    15ad:	74 17                	je     15c6 <unlinkread+0xcd>
    printf(1, "unlink unlinkread failed\n");
    15af:	83 ec 08             	sub    $0x8,%esp
    15b2:	68 fd 4a 00 00       	push   $0x4afd
    15b7:	6a 01                	push   $0x1
    15b9:	e8 43 2a 00 00       	call   4001 <printf>
    15be:	83 c4 10             	add    $0x10,%esp
    exit();
    15c1:	e8 c9 28 00 00       	call   3e8f <exit>
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    15c6:	83 ec 08             	sub    $0x8,%esp
    15c9:	68 02 02 00 00       	push   $0x202
    15ce:	68 ba 4a 00 00       	push   $0x4aba
    15d3:	e8 f7 28 00 00       	call   3ecf <open>
    15d8:	83 c4 10             	add    $0x10,%esp
    15db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  write(fd1, "yyy", 3);
    15de:	83 ec 04             	sub    $0x4,%esp
    15e1:	6a 03                	push   $0x3
    15e3:	68 17 4b 00 00       	push   $0x4b17
    15e8:	ff 75 f0             	pushl  -0x10(%ebp)
    15eb:	e8 bf 28 00 00       	call   3eaf <write>
    15f0:	83 c4 10             	add    $0x10,%esp
  close(fd1);
    15f3:	83 ec 0c             	sub    $0xc,%esp
    15f6:	ff 75 f0             	pushl  -0x10(%ebp)
    15f9:	e8 b9 28 00 00       	call   3eb7 <close>
    15fe:	83 c4 10             	add    $0x10,%esp

  if(read(fd, buf, sizeof(buf)) != 5){
    1601:	83 ec 04             	sub    $0x4,%esp
    1604:	68 00 20 00 00       	push   $0x2000
    1609:	68 80 8a 00 00       	push   $0x8a80
    160e:	ff 75 f4             	pushl  -0xc(%ebp)
    1611:	e8 91 28 00 00       	call   3ea7 <read>
    1616:	83 c4 10             	add    $0x10,%esp
    1619:	83 f8 05             	cmp    $0x5,%eax
    161c:	74 17                	je     1635 <unlinkread+0x13c>
    printf(1, "unlinkread read failed");
    161e:	83 ec 08             	sub    $0x8,%esp
    1621:	68 1b 4b 00 00       	push   $0x4b1b
    1626:	6a 01                	push   $0x1
    1628:	e8 d4 29 00 00       	call   4001 <printf>
    162d:	83 c4 10             	add    $0x10,%esp
    exit();
    1630:	e8 5a 28 00 00       	call   3e8f <exit>
  }
  if(buf[0] != 'h'){
    1635:	a0 80 8a 00 00       	mov    0x8a80,%al
    163a:	3c 68                	cmp    $0x68,%al
    163c:	74 17                	je     1655 <unlinkread+0x15c>
    printf(1, "unlinkread wrong data\n");
    163e:	83 ec 08             	sub    $0x8,%esp
    1641:	68 32 4b 00 00       	push   $0x4b32
    1646:	6a 01                	push   $0x1
    1648:	e8 b4 29 00 00       	call   4001 <printf>
    164d:	83 c4 10             	add    $0x10,%esp
    exit();
    1650:	e8 3a 28 00 00       	call   3e8f <exit>
  }
  if(write(fd, buf, 10) != 10){
    1655:	83 ec 04             	sub    $0x4,%esp
    1658:	6a 0a                	push   $0xa
    165a:	68 80 8a 00 00       	push   $0x8a80
    165f:	ff 75 f4             	pushl  -0xc(%ebp)
    1662:	e8 48 28 00 00       	call   3eaf <write>
    1667:	83 c4 10             	add    $0x10,%esp
    166a:	83 f8 0a             	cmp    $0xa,%eax
    166d:	74 17                	je     1686 <unlinkread+0x18d>
    printf(1, "unlinkread write failed\n");
    166f:	83 ec 08             	sub    $0x8,%esp
    1672:	68 49 4b 00 00       	push   $0x4b49
    1677:	6a 01                	push   $0x1
    1679:	e8 83 29 00 00       	call   4001 <printf>
    167e:	83 c4 10             	add    $0x10,%esp
    exit();
    1681:	e8 09 28 00 00       	call   3e8f <exit>
  }
  close(fd);
    1686:	83 ec 0c             	sub    $0xc,%esp
    1689:	ff 75 f4             	pushl  -0xc(%ebp)
    168c:	e8 26 28 00 00       	call   3eb7 <close>
    1691:	83 c4 10             	add    $0x10,%esp
  unlink("unlinkread");
    1694:	83 ec 0c             	sub    $0xc,%esp
    1697:	68 ba 4a 00 00       	push   $0x4aba
    169c:	e8 3e 28 00 00       	call   3edf <unlink>
    16a1:	83 c4 10             	add    $0x10,%esp
  printf(1, "unlinkread ok\n");
    16a4:	83 ec 08             	sub    $0x8,%esp
    16a7:	68 62 4b 00 00       	push   $0x4b62
    16ac:	6a 01                	push   $0x1
    16ae:	e8 4e 29 00 00       	call   4001 <printf>
    16b3:	83 c4 10             	add    $0x10,%esp
}
    16b6:	c9                   	leave  
    16b7:	c3                   	ret    

000016b8 <linktest>:

void
linktest(void)
{
    16b8:	55                   	push   %ebp
    16b9:	89 e5                	mov    %esp,%ebp
    16bb:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(1, "linktest\n");
    16be:	83 ec 08             	sub    $0x8,%esp
    16c1:	68 71 4b 00 00       	push   $0x4b71
    16c6:	6a 01                	push   $0x1
    16c8:	e8 34 29 00 00       	call   4001 <printf>
    16cd:	83 c4 10             	add    $0x10,%esp

  unlink("lf1");
    16d0:	83 ec 0c             	sub    $0xc,%esp
    16d3:	68 7b 4b 00 00       	push   $0x4b7b
    16d8:	e8 02 28 00 00       	call   3edf <unlink>
    16dd:	83 c4 10             	add    $0x10,%esp
  unlink("lf2");
    16e0:	83 ec 0c             	sub    $0xc,%esp
    16e3:	68 7f 4b 00 00       	push   $0x4b7f
    16e8:	e8 f2 27 00 00       	call   3edf <unlink>
    16ed:	83 c4 10             	add    $0x10,%esp

  fd = open("lf1", O_CREATE|O_RDWR);
    16f0:	83 ec 08             	sub    $0x8,%esp
    16f3:	68 02 02 00 00       	push   $0x202
    16f8:	68 7b 4b 00 00       	push   $0x4b7b
    16fd:	e8 cd 27 00 00       	call   3ecf <open>
    1702:	83 c4 10             	add    $0x10,%esp
    1705:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1708:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    170c:	79 17                	jns    1725 <linktest+0x6d>
    printf(1, "create lf1 failed\n");
    170e:	83 ec 08             	sub    $0x8,%esp
    1711:	68 83 4b 00 00       	push   $0x4b83
    1716:	6a 01                	push   $0x1
    1718:	e8 e4 28 00 00       	call   4001 <printf>
    171d:	83 c4 10             	add    $0x10,%esp
    exit();
    1720:	e8 6a 27 00 00       	call   3e8f <exit>
  }
  if(write(fd, "hello", 5) != 5){
    1725:	83 ec 04             	sub    $0x4,%esp
    1728:	6a 05                	push   $0x5
    172a:	68 df 4a 00 00       	push   $0x4adf
    172f:	ff 75 f4             	pushl  -0xc(%ebp)
    1732:	e8 78 27 00 00       	call   3eaf <write>
    1737:	83 c4 10             	add    $0x10,%esp
    173a:	83 f8 05             	cmp    $0x5,%eax
    173d:	74 17                	je     1756 <linktest+0x9e>
    printf(1, "write lf1 failed\n");
    173f:	83 ec 08             	sub    $0x8,%esp
    1742:	68 96 4b 00 00       	push   $0x4b96
    1747:	6a 01                	push   $0x1
    1749:	e8 b3 28 00 00       	call   4001 <printf>
    174e:	83 c4 10             	add    $0x10,%esp
    exit();
    1751:	e8 39 27 00 00       	call   3e8f <exit>
  }
  close(fd);
    1756:	83 ec 0c             	sub    $0xc,%esp
    1759:	ff 75 f4             	pushl  -0xc(%ebp)
    175c:	e8 56 27 00 00       	call   3eb7 <close>
    1761:	83 c4 10             	add    $0x10,%esp

  if(link("lf1", "lf2") < 0){
    1764:	83 ec 08             	sub    $0x8,%esp
    1767:	68 7f 4b 00 00       	push   $0x4b7f
    176c:	68 7b 4b 00 00       	push   $0x4b7b
    1771:	e8 79 27 00 00       	call   3eef <link>
    1776:	83 c4 10             	add    $0x10,%esp
    1779:	85 c0                	test   %eax,%eax
    177b:	79 17                	jns    1794 <linktest+0xdc>
    printf(1, "link lf1 lf2 failed\n");
    177d:	83 ec 08             	sub    $0x8,%esp
    1780:	68 a8 4b 00 00       	push   $0x4ba8
    1785:	6a 01                	push   $0x1
    1787:	e8 75 28 00 00       	call   4001 <printf>
    178c:	83 c4 10             	add    $0x10,%esp
    exit();
    178f:	e8 fb 26 00 00       	call   3e8f <exit>
  }
  unlink("lf1");
    1794:	83 ec 0c             	sub    $0xc,%esp
    1797:	68 7b 4b 00 00       	push   $0x4b7b
    179c:	e8 3e 27 00 00       	call   3edf <unlink>
    17a1:	83 c4 10             	add    $0x10,%esp

  if(open("lf1", 0) >= 0){
    17a4:	83 ec 08             	sub    $0x8,%esp
    17a7:	6a 00                	push   $0x0
    17a9:	68 7b 4b 00 00       	push   $0x4b7b
    17ae:	e8 1c 27 00 00       	call   3ecf <open>
    17b3:	83 c4 10             	add    $0x10,%esp
    17b6:	85 c0                	test   %eax,%eax
    17b8:	78 17                	js     17d1 <linktest+0x119>
    printf(1, "unlinked lf1 but it is still there!\n");
    17ba:	83 ec 08             	sub    $0x8,%esp
    17bd:	68 c0 4b 00 00       	push   $0x4bc0
    17c2:	6a 01                	push   $0x1
    17c4:	e8 38 28 00 00       	call   4001 <printf>
    17c9:	83 c4 10             	add    $0x10,%esp
    exit();
    17cc:	e8 be 26 00 00       	call   3e8f <exit>
  }

  fd = open("lf2", 0);
    17d1:	83 ec 08             	sub    $0x8,%esp
    17d4:	6a 00                	push   $0x0
    17d6:	68 7f 4b 00 00       	push   $0x4b7f
    17db:	e8 ef 26 00 00       	call   3ecf <open>
    17e0:	83 c4 10             	add    $0x10,%esp
    17e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    17e6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    17ea:	79 17                	jns    1803 <linktest+0x14b>
    printf(1, "open lf2 failed\n");
    17ec:	83 ec 08             	sub    $0x8,%esp
    17ef:	68 e5 4b 00 00       	push   $0x4be5
    17f4:	6a 01                	push   $0x1
    17f6:	e8 06 28 00 00       	call   4001 <printf>
    17fb:	83 c4 10             	add    $0x10,%esp
    exit();
    17fe:	e8 8c 26 00 00       	call   3e8f <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    1803:	83 ec 04             	sub    $0x4,%esp
    1806:	68 00 20 00 00       	push   $0x2000
    180b:	68 80 8a 00 00       	push   $0x8a80
    1810:	ff 75 f4             	pushl  -0xc(%ebp)
    1813:	e8 8f 26 00 00       	call   3ea7 <read>
    1818:	83 c4 10             	add    $0x10,%esp
    181b:	83 f8 05             	cmp    $0x5,%eax
    181e:	74 17                	je     1837 <linktest+0x17f>
    printf(1, "read lf2 failed\n");
    1820:	83 ec 08             	sub    $0x8,%esp
    1823:	68 f6 4b 00 00       	push   $0x4bf6
    1828:	6a 01                	push   $0x1
    182a:	e8 d2 27 00 00       	call   4001 <printf>
    182f:	83 c4 10             	add    $0x10,%esp
    exit();
    1832:	e8 58 26 00 00       	call   3e8f <exit>
  }
  close(fd);
    1837:	83 ec 0c             	sub    $0xc,%esp
    183a:	ff 75 f4             	pushl  -0xc(%ebp)
    183d:	e8 75 26 00 00       	call   3eb7 <close>
    1842:	83 c4 10             	add    $0x10,%esp

  if(link("lf2", "lf2") >= 0){
    1845:	83 ec 08             	sub    $0x8,%esp
    1848:	68 7f 4b 00 00       	push   $0x4b7f
    184d:	68 7f 4b 00 00       	push   $0x4b7f
    1852:	e8 98 26 00 00       	call   3eef <link>
    1857:	83 c4 10             	add    $0x10,%esp
    185a:	85 c0                	test   %eax,%eax
    185c:	78 17                	js     1875 <linktest+0x1bd>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    185e:	83 ec 08             	sub    $0x8,%esp
    1861:	68 07 4c 00 00       	push   $0x4c07
    1866:	6a 01                	push   $0x1
    1868:	e8 94 27 00 00       	call   4001 <printf>
    186d:	83 c4 10             	add    $0x10,%esp
    exit();
    1870:	e8 1a 26 00 00       	call   3e8f <exit>
  }

  unlink("lf2");
    1875:	83 ec 0c             	sub    $0xc,%esp
    1878:	68 7f 4b 00 00       	push   $0x4b7f
    187d:	e8 5d 26 00 00       	call   3edf <unlink>
    1882:	83 c4 10             	add    $0x10,%esp
  if(link("lf2", "lf1") >= 0){
    1885:	83 ec 08             	sub    $0x8,%esp
    1888:	68 7b 4b 00 00       	push   $0x4b7b
    188d:	68 7f 4b 00 00       	push   $0x4b7f
    1892:	e8 58 26 00 00       	call   3eef <link>
    1897:	83 c4 10             	add    $0x10,%esp
    189a:	85 c0                	test   %eax,%eax
    189c:	78 17                	js     18b5 <linktest+0x1fd>
    printf(1, "link non-existant succeeded! oops\n");
    189e:	83 ec 08             	sub    $0x8,%esp
    18a1:	68 28 4c 00 00       	push   $0x4c28
    18a6:	6a 01                	push   $0x1
    18a8:	e8 54 27 00 00       	call   4001 <printf>
    18ad:	83 c4 10             	add    $0x10,%esp
    exit();
    18b0:	e8 da 25 00 00       	call   3e8f <exit>
  }

  if(link(".", "lf1") >= 0){
    18b5:	83 ec 08             	sub    $0x8,%esp
    18b8:	68 7b 4b 00 00       	push   $0x4b7b
    18bd:	68 4b 4c 00 00       	push   $0x4c4b
    18c2:	e8 28 26 00 00       	call   3eef <link>
    18c7:	83 c4 10             	add    $0x10,%esp
    18ca:	85 c0                	test   %eax,%eax
    18cc:	78 17                	js     18e5 <linktest+0x22d>
    printf(1, "link . lf1 succeeded! oops\n");
    18ce:	83 ec 08             	sub    $0x8,%esp
    18d1:	68 4d 4c 00 00       	push   $0x4c4d
    18d6:	6a 01                	push   $0x1
    18d8:	e8 24 27 00 00       	call   4001 <printf>
    18dd:	83 c4 10             	add    $0x10,%esp
    exit();
    18e0:	e8 aa 25 00 00       	call   3e8f <exit>
  }

  printf(1, "linktest ok\n");
    18e5:	83 ec 08             	sub    $0x8,%esp
    18e8:	68 69 4c 00 00       	push   $0x4c69
    18ed:	6a 01                	push   $0x1
    18ef:	e8 0d 27 00 00       	call   4001 <printf>
    18f4:	83 c4 10             	add    $0x10,%esp
}
    18f7:	c9                   	leave  
    18f8:	c3                   	ret    

000018f9 <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    18f9:	55                   	push   %ebp
    18fa:	89 e5                	mov    %esp,%ebp
    18fc:	83 ec 58             	sub    $0x58,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    18ff:	83 ec 08             	sub    $0x8,%esp
    1902:	68 76 4c 00 00       	push   $0x4c76
    1907:	6a 01                	push   $0x1
    1909:	e8 f3 26 00 00       	call   4001 <printf>
    190e:	83 c4 10             	add    $0x10,%esp
  file[0] = 'C';
    1911:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
  file[2] = '\0';
    1915:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
  for(i = 0; i < 40; i++){
    1919:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1920:	e9 d5 00 00 00       	jmp    19fa <concreate+0x101>
    file[1] = '0' + i;
    1925:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1928:	83 c0 30             	add    $0x30,%eax
    192b:	88 45 e6             	mov    %al,-0x1a(%ebp)
    unlink(file);
    192e:	83 ec 0c             	sub    $0xc,%esp
    1931:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1934:	50                   	push   %eax
    1935:	e8 a5 25 00 00       	call   3edf <unlink>
    193a:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    193d:	e8 45 25 00 00       	call   3e87 <fork>
    1942:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pid && (i % 3) == 1){
    1945:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1949:	74 28                	je     1973 <concreate+0x7a>
    194b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    194e:	b9 03 00 00 00       	mov    $0x3,%ecx
    1953:	99                   	cltd   
    1954:	f7 f9                	idiv   %ecx
    1956:	89 d0                	mov    %edx,%eax
    1958:	83 f8 01             	cmp    $0x1,%eax
    195b:	75 16                	jne    1973 <concreate+0x7a>
      link("C0", file);
    195d:	83 ec 08             	sub    $0x8,%esp
    1960:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1963:	50                   	push   %eax
    1964:	68 86 4c 00 00       	push   $0x4c86
    1969:	e8 81 25 00 00       	call   3eef <link>
    196e:	83 c4 10             	add    $0x10,%esp
    1971:	eb 74                	jmp    19e7 <concreate+0xee>
    } else if(pid == 0 && (i % 5) == 1){
    1973:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1977:	75 28                	jne    19a1 <concreate+0xa8>
    1979:	8b 45 f4             	mov    -0xc(%ebp),%eax
    197c:	b9 05 00 00 00       	mov    $0x5,%ecx
    1981:	99                   	cltd   
    1982:	f7 f9                	idiv   %ecx
    1984:	89 d0                	mov    %edx,%eax
    1986:	83 f8 01             	cmp    $0x1,%eax
    1989:	75 16                	jne    19a1 <concreate+0xa8>
      link("C0", file);
    198b:	83 ec 08             	sub    $0x8,%esp
    198e:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1991:	50                   	push   %eax
    1992:	68 86 4c 00 00       	push   $0x4c86
    1997:	e8 53 25 00 00       	call   3eef <link>
    199c:	83 c4 10             	add    $0x10,%esp
    199f:	eb 46                	jmp    19e7 <concreate+0xee>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    19a1:	83 ec 08             	sub    $0x8,%esp
    19a4:	68 02 02 00 00       	push   $0x202
    19a9:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19ac:	50                   	push   %eax
    19ad:	e8 1d 25 00 00       	call   3ecf <open>
    19b2:	83 c4 10             	add    $0x10,%esp
    19b5:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(fd < 0){
    19b8:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    19bc:	79 1b                	jns    19d9 <concreate+0xe0>
        printf(1, "concreate create %s failed\n", file);
    19be:	83 ec 04             	sub    $0x4,%esp
    19c1:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19c4:	50                   	push   %eax
    19c5:	68 89 4c 00 00       	push   $0x4c89
    19ca:	6a 01                	push   $0x1
    19cc:	e8 30 26 00 00       	call   4001 <printf>
    19d1:	83 c4 10             	add    $0x10,%esp
        exit();
    19d4:	e8 b6 24 00 00       	call   3e8f <exit>
      }
      close(fd);
    19d9:	83 ec 0c             	sub    $0xc,%esp
    19dc:	ff 75 e8             	pushl  -0x18(%ebp)
    19df:	e8 d3 24 00 00       	call   3eb7 <close>
    19e4:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    19e7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19eb:	75 05                	jne    19f2 <concreate+0xf9>
      exit();
    19ed:	e8 9d 24 00 00       	call   3e8f <exit>
    else
      wait();
    19f2:	e8 a0 24 00 00       	call   3e97 <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    19f7:	ff 45 f4             	incl   -0xc(%ebp)
    19fa:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    19fe:	0f 8e 21 ff ff ff    	jle    1925 <concreate+0x2c>
      exit();
    else
      wait();
  }

  memset(fa, 0, sizeof(fa));
    1a04:	83 ec 04             	sub    $0x4,%esp
    1a07:	6a 28                	push   $0x28
    1a09:	6a 00                	push   $0x0
    1a0b:	8d 45 bd             	lea    -0x43(%ebp),%eax
    1a0e:	50                   	push   %eax
    1a0f:	e8 ed 22 00 00       	call   3d01 <memset>
    1a14:	83 c4 10             	add    $0x10,%esp
  fd = open(".", 0);
    1a17:	83 ec 08             	sub    $0x8,%esp
    1a1a:	6a 00                	push   $0x0
    1a1c:	68 4b 4c 00 00       	push   $0x4c4b
    1a21:	e8 a9 24 00 00       	call   3ecf <open>
    1a26:	83 c4 10             	add    $0x10,%esp
    1a29:	89 45 e8             	mov    %eax,-0x18(%ebp)
  n = 0;
    1a2c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    1a33:	e9 8d 00 00 00       	jmp    1ac5 <concreate+0x1cc>
    if(de.inum == 0)
    1a38:	8b 45 ac             	mov    -0x54(%ebp),%eax
    1a3b:	66 85 c0             	test   %ax,%ax
    1a3e:	75 05                	jne    1a45 <concreate+0x14c>
      continue;
    1a40:	e9 80 00 00 00       	jmp    1ac5 <concreate+0x1cc>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    1a45:	8a 45 ae             	mov    -0x52(%ebp),%al
    1a48:	3c 43                	cmp    $0x43,%al
    1a4a:	75 79                	jne    1ac5 <concreate+0x1cc>
    1a4c:	8a 45 b0             	mov    -0x50(%ebp),%al
    1a4f:	84 c0                	test   %al,%al
    1a51:	75 72                	jne    1ac5 <concreate+0x1cc>
      i = de.name[1] - '0';
    1a53:	8a 45 af             	mov    -0x51(%ebp),%al
    1a56:	0f be c0             	movsbl %al,%eax
    1a59:	83 e8 30             	sub    $0x30,%eax
    1a5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
      if(i < 0 || i >= sizeof(fa)){
    1a5f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1a63:	78 08                	js     1a6d <concreate+0x174>
    1a65:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a68:	83 f8 27             	cmp    $0x27,%eax
    1a6b:	76 1e                	jbe    1a8b <concreate+0x192>
        printf(1, "concreate weird file %s\n", de.name);
    1a6d:	83 ec 04             	sub    $0x4,%esp
    1a70:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1a73:	83 c0 02             	add    $0x2,%eax
    1a76:	50                   	push   %eax
    1a77:	68 a5 4c 00 00       	push   $0x4ca5
    1a7c:	6a 01                	push   $0x1
    1a7e:	e8 7e 25 00 00       	call   4001 <printf>
    1a83:	83 c4 10             	add    $0x10,%esp
        exit();
    1a86:	e8 04 24 00 00       	call   3e8f <exit>
      }
      if(fa[i]){
    1a8b:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1a8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a91:	01 d0                	add    %edx,%eax
    1a93:	8a 00                	mov    (%eax),%al
    1a95:	84 c0                	test   %al,%al
    1a97:	74 1e                	je     1ab7 <concreate+0x1be>
        printf(1, "concreate duplicate file %s\n", de.name);
    1a99:	83 ec 04             	sub    $0x4,%esp
    1a9c:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1a9f:	83 c0 02             	add    $0x2,%eax
    1aa2:	50                   	push   %eax
    1aa3:	68 be 4c 00 00       	push   $0x4cbe
    1aa8:	6a 01                	push   $0x1
    1aaa:	e8 52 25 00 00       	call   4001 <printf>
    1aaf:	83 c4 10             	add    $0x10,%esp
        exit();
    1ab2:	e8 d8 23 00 00       	call   3e8f <exit>
      }
      fa[i] = 1;
    1ab7:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1aba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1abd:	01 d0                	add    %edx,%eax
    1abf:	c6 00 01             	movb   $0x1,(%eax)
      n++;
    1ac2:	ff 45 f0             	incl   -0x10(%ebp)
  }

  memset(fa, 0, sizeof(fa));
  fd = open(".", 0);
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    1ac5:	83 ec 04             	sub    $0x4,%esp
    1ac8:	6a 10                	push   $0x10
    1aca:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1acd:	50                   	push   %eax
    1ace:	ff 75 e8             	pushl  -0x18(%ebp)
    1ad1:	e8 d1 23 00 00       	call   3ea7 <read>
    1ad6:	83 c4 10             	add    $0x10,%esp
    1ad9:	85 c0                	test   %eax,%eax
    1adb:	0f 8f 57 ff ff ff    	jg     1a38 <concreate+0x13f>
      }
      fa[i] = 1;
      n++;
    }
  }
  close(fd);
    1ae1:	83 ec 0c             	sub    $0xc,%esp
    1ae4:	ff 75 e8             	pushl  -0x18(%ebp)
    1ae7:	e8 cb 23 00 00       	call   3eb7 <close>
    1aec:	83 c4 10             	add    $0x10,%esp

  if(n != 40){
    1aef:	83 7d f0 28          	cmpl   $0x28,-0x10(%ebp)
    1af3:	74 17                	je     1b0c <concreate+0x213>
    printf(1, "concreate not enough files in directory listing\n");
    1af5:	83 ec 08             	sub    $0x8,%esp
    1af8:	68 dc 4c 00 00       	push   $0x4cdc
    1afd:	6a 01                	push   $0x1
    1aff:	e8 fd 24 00 00       	call   4001 <printf>
    1b04:	83 c4 10             	add    $0x10,%esp
    exit();
    1b07:	e8 83 23 00 00       	call   3e8f <exit>
  }

  for(i = 0; i < 40; i++){
    1b0c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1b13:	e9 22 01 00 00       	jmp    1c3a <concreate+0x341>
    file[1] = '0' + i;
    1b18:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b1b:	83 c0 30             	add    $0x30,%eax
    1b1e:	88 45 e6             	mov    %al,-0x1a(%ebp)
    pid = fork();
    1b21:	e8 61 23 00 00       	call   3e87 <fork>
    1b26:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pid < 0){
    1b29:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b2d:	79 17                	jns    1b46 <concreate+0x24d>
      printf(1, "fork failed\n");
    1b2f:	83 ec 08             	sub    $0x8,%esp
    1b32:	68 51 44 00 00       	push   $0x4451
    1b37:	6a 01                	push   $0x1
    1b39:	e8 c3 24 00 00       	call   4001 <printf>
    1b3e:	83 c4 10             	add    $0x10,%esp
      exit();
    1b41:	e8 49 23 00 00       	call   3e8f <exit>
    }
    if(((i % 3) == 0 && pid == 0) ||
    1b46:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b49:	b9 03 00 00 00       	mov    $0x3,%ecx
    1b4e:	99                   	cltd   
    1b4f:	f7 f9                	idiv   %ecx
    1b51:	89 d0                	mov    %edx,%eax
    1b53:	85 c0                	test   %eax,%eax
    1b55:	75 06                	jne    1b5d <concreate+0x264>
    1b57:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b5b:	74 18                	je     1b75 <concreate+0x27c>
       ((i % 3) == 1 && pid != 0)){
    1b5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b60:	b9 03 00 00 00       	mov    $0x3,%ecx
    1b65:	99                   	cltd   
    1b66:	f7 f9                	idiv   %ecx
    1b68:	89 d0                	mov    %edx,%eax
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    1b6a:	83 f8 01             	cmp    $0x1,%eax
    1b6d:	75 7c                	jne    1beb <concreate+0x2f2>
       ((i % 3) == 1 && pid != 0)){
    1b6f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b73:	74 76                	je     1beb <concreate+0x2f2>
      close(open(file, 0));
    1b75:	83 ec 08             	sub    $0x8,%esp
    1b78:	6a 00                	push   $0x0
    1b7a:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1b7d:	50                   	push   %eax
    1b7e:	e8 4c 23 00 00       	call   3ecf <open>
    1b83:	83 c4 10             	add    $0x10,%esp
    1b86:	83 ec 0c             	sub    $0xc,%esp
    1b89:	50                   	push   %eax
    1b8a:	e8 28 23 00 00       	call   3eb7 <close>
    1b8f:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1b92:	83 ec 08             	sub    $0x8,%esp
    1b95:	6a 00                	push   $0x0
    1b97:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1b9a:	50                   	push   %eax
    1b9b:	e8 2f 23 00 00       	call   3ecf <open>
    1ba0:	83 c4 10             	add    $0x10,%esp
    1ba3:	83 ec 0c             	sub    $0xc,%esp
    1ba6:	50                   	push   %eax
    1ba7:	e8 0b 23 00 00       	call   3eb7 <close>
    1bac:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1baf:	83 ec 08             	sub    $0x8,%esp
    1bb2:	6a 00                	push   $0x0
    1bb4:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1bb7:	50                   	push   %eax
    1bb8:	e8 12 23 00 00       	call   3ecf <open>
    1bbd:	83 c4 10             	add    $0x10,%esp
    1bc0:	83 ec 0c             	sub    $0xc,%esp
    1bc3:	50                   	push   %eax
    1bc4:	e8 ee 22 00 00       	call   3eb7 <close>
    1bc9:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1bcc:	83 ec 08             	sub    $0x8,%esp
    1bcf:	6a 00                	push   $0x0
    1bd1:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1bd4:	50                   	push   %eax
    1bd5:	e8 f5 22 00 00       	call   3ecf <open>
    1bda:	83 c4 10             	add    $0x10,%esp
    1bdd:	83 ec 0c             	sub    $0xc,%esp
    1be0:	50                   	push   %eax
    1be1:	e8 d1 22 00 00       	call   3eb7 <close>
    1be6:	83 c4 10             	add    $0x10,%esp
    1be9:	eb 3c                	jmp    1c27 <concreate+0x32e>
    } else {
      unlink(file);
    1beb:	83 ec 0c             	sub    $0xc,%esp
    1bee:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1bf1:	50                   	push   %eax
    1bf2:	e8 e8 22 00 00       	call   3edf <unlink>
    1bf7:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    1bfa:	83 ec 0c             	sub    $0xc,%esp
    1bfd:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c00:	50                   	push   %eax
    1c01:	e8 d9 22 00 00       	call   3edf <unlink>
    1c06:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    1c09:	83 ec 0c             	sub    $0xc,%esp
    1c0c:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c0f:	50                   	push   %eax
    1c10:	e8 ca 22 00 00       	call   3edf <unlink>
    1c15:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    1c18:	83 ec 0c             	sub    $0xc,%esp
    1c1b:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c1e:	50                   	push   %eax
    1c1f:	e8 bb 22 00 00       	call   3edf <unlink>
    1c24:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    1c27:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c2b:	75 05                	jne    1c32 <concreate+0x339>
      exit();
    1c2d:	e8 5d 22 00 00       	call   3e8f <exit>
    else
      wait();
    1c32:	e8 60 22 00 00       	call   3e97 <wait>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    1c37:	ff 45 f4             	incl   -0xc(%ebp)
    1c3a:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    1c3e:	0f 8e d4 fe ff ff    	jle    1b18 <concreate+0x21f>
      exit();
    else
      wait();
  }

  printf(1, "concreate ok\n");
    1c44:	83 ec 08             	sub    $0x8,%esp
    1c47:	68 0d 4d 00 00       	push   $0x4d0d
    1c4c:	6a 01                	push   $0x1
    1c4e:	e8 ae 23 00 00       	call   4001 <printf>
    1c53:	83 c4 10             	add    $0x10,%esp
}
    1c56:	c9                   	leave  
    1c57:	c3                   	ret    

00001c58 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1c58:	55                   	push   %ebp
    1c59:	89 e5                	mov    %esp,%ebp
    1c5b:	83 ec 18             	sub    $0x18,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    1c5e:	83 ec 08             	sub    $0x8,%esp
    1c61:	68 1b 4d 00 00       	push   $0x4d1b
    1c66:	6a 01                	push   $0x1
    1c68:	e8 94 23 00 00       	call   4001 <printf>
    1c6d:	83 c4 10             	add    $0x10,%esp

  unlink("x");
    1c70:	83 ec 0c             	sub    $0xc,%esp
    1c73:	68 87 48 00 00       	push   $0x4887
    1c78:	e8 62 22 00 00       	call   3edf <unlink>
    1c7d:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    1c80:	e8 02 22 00 00       	call   3e87 <fork>
    1c85:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid < 0){
    1c88:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c8c:	79 17                	jns    1ca5 <linkunlink+0x4d>
    printf(1, "fork failed\n");
    1c8e:	83 ec 08             	sub    $0x8,%esp
    1c91:	68 51 44 00 00       	push   $0x4451
    1c96:	6a 01                	push   $0x1
    1c98:	e8 64 23 00 00       	call   4001 <printf>
    1c9d:	83 c4 10             	add    $0x10,%esp
    exit();
    1ca0:	e8 ea 21 00 00       	call   3e8f <exit>
  }

  unsigned int x = (pid ? 1 : 97);
    1ca5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1ca9:	74 07                	je     1cb2 <linkunlink+0x5a>
    1cab:	b8 01 00 00 00       	mov    $0x1,%eax
    1cb0:	eb 05                	jmp    1cb7 <linkunlink+0x5f>
    1cb2:	b8 61 00 00 00       	mov    $0x61,%eax
    1cb7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 100; i++){
    1cba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1cc1:	e9 af 00 00 00       	jmp    1d75 <linkunlink+0x11d>
    x = x * 1103515245 + 12345;
    1cc6:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1cc9:	89 ca                	mov    %ecx,%edx
    1ccb:	89 d0                	mov    %edx,%eax
    1ccd:	c1 e0 09             	shl    $0x9,%eax
    1cd0:	89 c2                	mov    %eax,%edx
    1cd2:	29 ca                	sub    %ecx,%edx
    1cd4:	c1 e2 02             	shl    $0x2,%edx
    1cd7:	01 ca                	add    %ecx,%edx
    1cd9:	89 d0                	mov    %edx,%eax
    1cdb:	c1 e0 09             	shl    $0x9,%eax
    1cde:	29 d0                	sub    %edx,%eax
    1ce0:	01 c0                	add    %eax,%eax
    1ce2:	01 c8                	add    %ecx,%eax
    1ce4:	89 c2                	mov    %eax,%edx
    1ce6:	c1 e2 05             	shl    $0x5,%edx
    1ce9:	01 d0                	add    %edx,%eax
    1ceb:	c1 e0 02             	shl    $0x2,%eax
    1cee:	29 c8                	sub    %ecx,%eax
    1cf0:	c1 e0 02             	shl    $0x2,%eax
    1cf3:	01 c8                	add    %ecx,%eax
    1cf5:	05 39 30 00 00       	add    $0x3039,%eax
    1cfa:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((x % 3) == 0){
    1cfd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d00:	b9 03 00 00 00       	mov    $0x3,%ecx
    1d05:	ba 00 00 00 00       	mov    $0x0,%edx
    1d0a:	f7 f1                	div    %ecx
    1d0c:	89 d0                	mov    %edx,%eax
    1d0e:	85 c0                	test   %eax,%eax
    1d10:	75 23                	jne    1d35 <linkunlink+0xdd>
      close(open("x", O_RDWR | O_CREATE));
    1d12:	83 ec 08             	sub    $0x8,%esp
    1d15:	68 02 02 00 00       	push   $0x202
    1d1a:	68 87 48 00 00       	push   $0x4887
    1d1f:	e8 ab 21 00 00       	call   3ecf <open>
    1d24:	83 c4 10             	add    $0x10,%esp
    1d27:	83 ec 0c             	sub    $0xc,%esp
    1d2a:	50                   	push   %eax
    1d2b:	e8 87 21 00 00       	call   3eb7 <close>
    1d30:	83 c4 10             	add    $0x10,%esp
    1d33:	eb 3d                	jmp    1d72 <linkunlink+0x11a>
    } else if((x % 3) == 1){
    1d35:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d38:	b9 03 00 00 00       	mov    $0x3,%ecx
    1d3d:	ba 00 00 00 00       	mov    $0x0,%edx
    1d42:	f7 f1                	div    %ecx
    1d44:	89 d0                	mov    %edx,%eax
    1d46:	83 f8 01             	cmp    $0x1,%eax
    1d49:	75 17                	jne    1d62 <linkunlink+0x10a>
      link("cat", "x");
    1d4b:	83 ec 08             	sub    $0x8,%esp
    1d4e:	68 87 48 00 00       	push   $0x4887
    1d53:	68 2c 4d 00 00       	push   $0x4d2c
    1d58:	e8 92 21 00 00       	call   3eef <link>
    1d5d:	83 c4 10             	add    $0x10,%esp
    1d60:	eb 10                	jmp    1d72 <linkunlink+0x11a>
    } else {
      unlink("x");
    1d62:	83 ec 0c             	sub    $0xc,%esp
    1d65:	68 87 48 00 00       	push   $0x4887
    1d6a:	e8 70 21 00 00       	call   3edf <unlink>
    1d6f:	83 c4 10             	add    $0x10,%esp
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    1d72:	ff 45 f4             	incl   -0xc(%ebp)
    1d75:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
    1d79:	0f 8e 47 ff ff ff    	jle    1cc6 <linkunlink+0x6e>
    } else {
      unlink("x");
    }
  }

  if(pid)
    1d7f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1d83:	74 07                	je     1d8c <linkunlink+0x134>
    wait();
    1d85:	e8 0d 21 00 00       	call   3e97 <wait>
    1d8a:	eb 05                	jmp    1d91 <linkunlink+0x139>
  else 
    exit();
    1d8c:	e8 fe 20 00 00       	call   3e8f <exit>

  printf(1, "linkunlink ok\n");
    1d91:	83 ec 08             	sub    $0x8,%esp
    1d94:	68 30 4d 00 00       	push   $0x4d30
    1d99:	6a 01                	push   $0x1
    1d9b:	e8 61 22 00 00       	call   4001 <printf>
    1da0:	83 c4 10             	add    $0x10,%esp
}
    1da3:	c9                   	leave  
    1da4:	c3                   	ret    

00001da5 <bigdir>:

// directory that uses indirect blocks
void
bigdir(void)
{
    1da5:	55                   	push   %ebp
    1da6:	89 e5                	mov    %esp,%ebp
    1da8:	83 ec 28             	sub    $0x28,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1dab:	83 ec 08             	sub    $0x8,%esp
    1dae:	68 3f 4d 00 00       	push   $0x4d3f
    1db3:	6a 01                	push   $0x1
    1db5:	e8 47 22 00 00       	call   4001 <printf>
    1dba:	83 c4 10             	add    $0x10,%esp
  unlink("bd");
    1dbd:	83 ec 0c             	sub    $0xc,%esp
    1dc0:	68 4c 4d 00 00       	push   $0x4d4c
    1dc5:	e8 15 21 00 00       	call   3edf <unlink>
    1dca:	83 c4 10             	add    $0x10,%esp

  fd = open("bd", O_CREATE);
    1dcd:	83 ec 08             	sub    $0x8,%esp
    1dd0:	68 00 02 00 00       	push   $0x200
    1dd5:	68 4c 4d 00 00       	push   $0x4d4c
    1dda:	e8 f0 20 00 00       	call   3ecf <open>
    1ddf:	83 c4 10             	add    $0x10,%esp
    1de2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0){
    1de5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1de9:	79 17                	jns    1e02 <bigdir+0x5d>
    printf(1, "bigdir create failed\n");
    1deb:	83 ec 08             	sub    $0x8,%esp
    1dee:	68 4f 4d 00 00       	push   $0x4d4f
    1df3:	6a 01                	push   $0x1
    1df5:	e8 07 22 00 00       	call   4001 <printf>
    1dfa:	83 c4 10             	add    $0x10,%esp
    exit();
    1dfd:	e8 8d 20 00 00       	call   3e8f <exit>
  }
  close(fd);
    1e02:	83 ec 0c             	sub    $0xc,%esp
    1e05:	ff 75 f0             	pushl  -0x10(%ebp)
    1e08:	e8 aa 20 00 00       	call   3eb7 <close>
    1e0d:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 500; i++){
    1e10:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1e17:	eb 64                	jmp    1e7d <bigdir+0xd8>
    name[0] = 'x';
    1e19:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    1e1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e20:	85 c0                	test   %eax,%eax
    1e22:	79 03                	jns    1e27 <bigdir+0x82>
    1e24:	83 c0 3f             	add    $0x3f,%eax
    1e27:	c1 f8 06             	sar    $0x6,%eax
    1e2a:	83 c0 30             	add    $0x30,%eax
    1e2d:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    1e30:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e33:	25 3f 00 00 80       	and    $0x8000003f,%eax
    1e38:	85 c0                	test   %eax,%eax
    1e3a:	79 05                	jns    1e41 <bigdir+0x9c>
    1e3c:	48                   	dec    %eax
    1e3d:	83 c8 c0             	or     $0xffffffc0,%eax
    1e40:	40                   	inc    %eax
    1e41:	83 c0 30             	add    $0x30,%eax
    1e44:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    1e47:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(link("bd", name) != 0){
    1e4b:	83 ec 08             	sub    $0x8,%esp
    1e4e:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1e51:	50                   	push   %eax
    1e52:	68 4c 4d 00 00       	push   $0x4d4c
    1e57:	e8 93 20 00 00       	call   3eef <link>
    1e5c:	83 c4 10             	add    $0x10,%esp
    1e5f:	85 c0                	test   %eax,%eax
    1e61:	74 17                	je     1e7a <bigdir+0xd5>
      printf(1, "bigdir link failed\n");
    1e63:	83 ec 08             	sub    $0x8,%esp
    1e66:	68 65 4d 00 00       	push   $0x4d65
    1e6b:	6a 01                	push   $0x1
    1e6d:	e8 8f 21 00 00       	call   4001 <printf>
    1e72:	83 c4 10             	add    $0x10,%esp
      exit();
    1e75:	e8 15 20 00 00       	call   3e8f <exit>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    1e7a:	ff 45 f4             	incl   -0xc(%ebp)
    1e7d:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1e84:	7e 93                	jle    1e19 <bigdir+0x74>
      printf(1, "bigdir link failed\n");
      exit();
    }
  }

  unlink("bd");
    1e86:	83 ec 0c             	sub    $0xc,%esp
    1e89:	68 4c 4d 00 00       	push   $0x4d4c
    1e8e:	e8 4c 20 00 00       	call   3edf <unlink>
    1e93:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 500; i++){
    1e96:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1e9d:	eb 5f                	jmp    1efe <bigdir+0x159>
    name[0] = 'x';
    1e9f:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    1ea3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ea6:	85 c0                	test   %eax,%eax
    1ea8:	79 03                	jns    1ead <bigdir+0x108>
    1eaa:	83 c0 3f             	add    $0x3f,%eax
    1ead:	c1 f8 06             	sar    $0x6,%eax
    1eb0:	83 c0 30             	add    $0x30,%eax
    1eb3:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    1eb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1eb9:	25 3f 00 00 80       	and    $0x8000003f,%eax
    1ebe:	85 c0                	test   %eax,%eax
    1ec0:	79 05                	jns    1ec7 <bigdir+0x122>
    1ec2:	48                   	dec    %eax
    1ec3:	83 c8 c0             	or     $0xffffffc0,%eax
    1ec6:	40                   	inc    %eax
    1ec7:	83 c0 30             	add    $0x30,%eax
    1eca:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    1ecd:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(unlink(name) != 0){
    1ed1:	83 ec 0c             	sub    $0xc,%esp
    1ed4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1ed7:	50                   	push   %eax
    1ed8:	e8 02 20 00 00       	call   3edf <unlink>
    1edd:	83 c4 10             	add    $0x10,%esp
    1ee0:	85 c0                	test   %eax,%eax
    1ee2:	74 17                	je     1efb <bigdir+0x156>
      printf(1, "bigdir unlink failed");
    1ee4:	83 ec 08             	sub    $0x8,%esp
    1ee7:	68 79 4d 00 00       	push   $0x4d79
    1eec:	6a 01                	push   $0x1
    1eee:	e8 0e 21 00 00       	call   4001 <printf>
    1ef3:	83 c4 10             	add    $0x10,%esp
      exit();
    1ef6:	e8 94 1f 00 00       	call   3e8f <exit>
      exit();
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    1efb:	ff 45 f4             	incl   -0xc(%ebp)
    1efe:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1f05:	7e 98                	jle    1e9f <bigdir+0xfa>
      printf(1, "bigdir unlink failed");
      exit();
    }
  }

  printf(1, "bigdir ok\n");
    1f07:	83 ec 08             	sub    $0x8,%esp
    1f0a:	68 8e 4d 00 00       	push   $0x4d8e
    1f0f:	6a 01                	push   $0x1
    1f11:	e8 eb 20 00 00       	call   4001 <printf>
    1f16:	83 c4 10             	add    $0x10,%esp
}
    1f19:	c9                   	leave  
    1f1a:	c3                   	ret    

00001f1b <subdir>:

void
subdir(void)
{
    1f1b:	55                   	push   %ebp
    1f1c:	89 e5                	mov    %esp,%ebp
    1f1e:	83 ec 18             	sub    $0x18,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    1f21:	83 ec 08             	sub    $0x8,%esp
    1f24:	68 99 4d 00 00       	push   $0x4d99
    1f29:	6a 01                	push   $0x1
    1f2b:	e8 d1 20 00 00       	call   4001 <printf>
    1f30:	83 c4 10             	add    $0x10,%esp

  unlink("ff");
    1f33:	83 ec 0c             	sub    $0xc,%esp
    1f36:	68 a6 4d 00 00       	push   $0x4da6
    1f3b:	e8 9f 1f 00 00       	call   3edf <unlink>
    1f40:	83 c4 10             	add    $0x10,%esp
  if(mkdir("dd") != 0){
    1f43:	83 ec 0c             	sub    $0xc,%esp
    1f46:	68 a9 4d 00 00       	push   $0x4da9
    1f4b:	e8 a7 1f 00 00       	call   3ef7 <mkdir>
    1f50:	83 c4 10             	add    $0x10,%esp
    1f53:	85 c0                	test   %eax,%eax
    1f55:	74 17                	je     1f6e <subdir+0x53>
    printf(1, "subdir mkdir dd failed\n");
    1f57:	83 ec 08             	sub    $0x8,%esp
    1f5a:	68 ac 4d 00 00       	push   $0x4dac
    1f5f:	6a 01                	push   $0x1
    1f61:	e8 9b 20 00 00       	call   4001 <printf>
    1f66:	83 c4 10             	add    $0x10,%esp
    exit();
    1f69:	e8 21 1f 00 00       	call   3e8f <exit>
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1f6e:	83 ec 08             	sub    $0x8,%esp
    1f71:	68 02 02 00 00       	push   $0x202
    1f76:	68 c4 4d 00 00       	push   $0x4dc4
    1f7b:	e8 4f 1f 00 00       	call   3ecf <open>
    1f80:	83 c4 10             	add    $0x10,%esp
    1f83:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1f86:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1f8a:	79 17                	jns    1fa3 <subdir+0x88>
    printf(1, "create dd/ff failed\n");
    1f8c:	83 ec 08             	sub    $0x8,%esp
    1f8f:	68 ca 4d 00 00       	push   $0x4dca
    1f94:	6a 01                	push   $0x1
    1f96:	e8 66 20 00 00       	call   4001 <printf>
    1f9b:	83 c4 10             	add    $0x10,%esp
    exit();
    1f9e:	e8 ec 1e 00 00       	call   3e8f <exit>
  }
  write(fd, "ff", 2);
    1fa3:	83 ec 04             	sub    $0x4,%esp
    1fa6:	6a 02                	push   $0x2
    1fa8:	68 a6 4d 00 00       	push   $0x4da6
    1fad:	ff 75 f4             	pushl  -0xc(%ebp)
    1fb0:	e8 fa 1e 00 00       	call   3eaf <write>
    1fb5:	83 c4 10             	add    $0x10,%esp
  close(fd);
    1fb8:	83 ec 0c             	sub    $0xc,%esp
    1fbb:	ff 75 f4             	pushl  -0xc(%ebp)
    1fbe:	e8 f4 1e 00 00       	call   3eb7 <close>
    1fc3:	83 c4 10             	add    $0x10,%esp
  
  if(unlink("dd") >= 0){
    1fc6:	83 ec 0c             	sub    $0xc,%esp
    1fc9:	68 a9 4d 00 00       	push   $0x4da9
    1fce:	e8 0c 1f 00 00       	call   3edf <unlink>
    1fd3:	83 c4 10             	add    $0x10,%esp
    1fd6:	85 c0                	test   %eax,%eax
    1fd8:	78 17                	js     1ff1 <subdir+0xd6>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    1fda:	83 ec 08             	sub    $0x8,%esp
    1fdd:	68 e0 4d 00 00       	push   $0x4de0
    1fe2:	6a 01                	push   $0x1
    1fe4:	e8 18 20 00 00       	call   4001 <printf>
    1fe9:	83 c4 10             	add    $0x10,%esp
    exit();
    1fec:	e8 9e 1e 00 00       	call   3e8f <exit>
  }

  if(mkdir("/dd/dd") != 0){
    1ff1:	83 ec 0c             	sub    $0xc,%esp
    1ff4:	68 06 4e 00 00       	push   $0x4e06
    1ff9:	e8 f9 1e 00 00       	call   3ef7 <mkdir>
    1ffe:	83 c4 10             	add    $0x10,%esp
    2001:	85 c0                	test   %eax,%eax
    2003:	74 17                	je     201c <subdir+0x101>
    printf(1, "subdir mkdir dd/dd failed\n");
    2005:	83 ec 08             	sub    $0x8,%esp
    2008:	68 0d 4e 00 00       	push   $0x4e0d
    200d:	6a 01                	push   $0x1
    200f:	e8 ed 1f 00 00       	call   4001 <printf>
    2014:	83 c4 10             	add    $0x10,%esp
    exit();
    2017:	e8 73 1e 00 00       	call   3e8f <exit>
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    201c:	83 ec 08             	sub    $0x8,%esp
    201f:	68 02 02 00 00       	push   $0x202
    2024:	68 28 4e 00 00       	push   $0x4e28
    2029:	e8 a1 1e 00 00       	call   3ecf <open>
    202e:	83 c4 10             	add    $0x10,%esp
    2031:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2034:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2038:	79 17                	jns    2051 <subdir+0x136>
    printf(1, "create dd/dd/ff failed\n");
    203a:	83 ec 08             	sub    $0x8,%esp
    203d:	68 31 4e 00 00       	push   $0x4e31
    2042:	6a 01                	push   $0x1
    2044:	e8 b8 1f 00 00       	call   4001 <printf>
    2049:	83 c4 10             	add    $0x10,%esp
    exit();
    204c:	e8 3e 1e 00 00       	call   3e8f <exit>
  }
  write(fd, "FF", 2);
    2051:	83 ec 04             	sub    $0x4,%esp
    2054:	6a 02                	push   $0x2
    2056:	68 49 4e 00 00       	push   $0x4e49
    205b:	ff 75 f4             	pushl  -0xc(%ebp)
    205e:	e8 4c 1e 00 00       	call   3eaf <write>
    2063:	83 c4 10             	add    $0x10,%esp
  close(fd);
    2066:	83 ec 0c             	sub    $0xc,%esp
    2069:	ff 75 f4             	pushl  -0xc(%ebp)
    206c:	e8 46 1e 00 00       	call   3eb7 <close>
    2071:	83 c4 10             	add    $0x10,%esp

  fd = open("dd/dd/../ff", 0);
    2074:	83 ec 08             	sub    $0x8,%esp
    2077:	6a 00                	push   $0x0
    2079:	68 4c 4e 00 00       	push   $0x4e4c
    207e:	e8 4c 1e 00 00       	call   3ecf <open>
    2083:	83 c4 10             	add    $0x10,%esp
    2086:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2089:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    208d:	79 17                	jns    20a6 <subdir+0x18b>
    printf(1, "open dd/dd/../ff failed\n");
    208f:	83 ec 08             	sub    $0x8,%esp
    2092:	68 58 4e 00 00       	push   $0x4e58
    2097:	6a 01                	push   $0x1
    2099:	e8 63 1f 00 00       	call   4001 <printf>
    209e:	83 c4 10             	add    $0x10,%esp
    exit();
    20a1:	e8 e9 1d 00 00       	call   3e8f <exit>
  }
  cc = read(fd, buf, sizeof(buf));
    20a6:	83 ec 04             	sub    $0x4,%esp
    20a9:	68 00 20 00 00       	push   $0x2000
    20ae:	68 80 8a 00 00       	push   $0x8a80
    20b3:	ff 75 f4             	pushl  -0xc(%ebp)
    20b6:	e8 ec 1d 00 00       	call   3ea7 <read>
    20bb:	83 c4 10             	add    $0x10,%esp
    20be:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(cc != 2 || buf[0] != 'f'){
    20c1:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
    20c5:	75 09                	jne    20d0 <subdir+0x1b5>
    20c7:	a0 80 8a 00 00       	mov    0x8a80,%al
    20cc:	3c 66                	cmp    $0x66,%al
    20ce:	74 17                	je     20e7 <subdir+0x1cc>
    printf(1, "dd/dd/../ff wrong content\n");
    20d0:	83 ec 08             	sub    $0x8,%esp
    20d3:	68 71 4e 00 00       	push   $0x4e71
    20d8:	6a 01                	push   $0x1
    20da:	e8 22 1f 00 00       	call   4001 <printf>
    20df:	83 c4 10             	add    $0x10,%esp
    exit();
    20e2:	e8 a8 1d 00 00       	call   3e8f <exit>
  }
  close(fd);
    20e7:	83 ec 0c             	sub    $0xc,%esp
    20ea:	ff 75 f4             	pushl  -0xc(%ebp)
    20ed:	e8 c5 1d 00 00       	call   3eb7 <close>
    20f2:	83 c4 10             	add    $0x10,%esp

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    20f5:	83 ec 08             	sub    $0x8,%esp
    20f8:	68 8c 4e 00 00       	push   $0x4e8c
    20fd:	68 28 4e 00 00       	push   $0x4e28
    2102:	e8 e8 1d 00 00       	call   3eef <link>
    2107:	83 c4 10             	add    $0x10,%esp
    210a:	85 c0                	test   %eax,%eax
    210c:	74 17                	je     2125 <subdir+0x20a>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    210e:	83 ec 08             	sub    $0x8,%esp
    2111:	68 98 4e 00 00       	push   $0x4e98
    2116:	6a 01                	push   $0x1
    2118:	e8 e4 1e 00 00       	call   4001 <printf>
    211d:	83 c4 10             	add    $0x10,%esp
    exit();
    2120:	e8 6a 1d 00 00       	call   3e8f <exit>
  }

  if(unlink("dd/dd/ff") != 0){
    2125:	83 ec 0c             	sub    $0xc,%esp
    2128:	68 28 4e 00 00       	push   $0x4e28
    212d:	e8 ad 1d 00 00       	call   3edf <unlink>
    2132:	83 c4 10             	add    $0x10,%esp
    2135:	85 c0                	test   %eax,%eax
    2137:	74 17                	je     2150 <subdir+0x235>
    printf(1, "unlink dd/dd/ff failed\n");
    2139:	83 ec 08             	sub    $0x8,%esp
    213c:	68 b9 4e 00 00       	push   $0x4eb9
    2141:	6a 01                	push   $0x1
    2143:	e8 b9 1e 00 00       	call   4001 <printf>
    2148:	83 c4 10             	add    $0x10,%esp
    exit();
    214b:	e8 3f 1d 00 00       	call   3e8f <exit>
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2150:	83 ec 08             	sub    $0x8,%esp
    2153:	6a 00                	push   $0x0
    2155:	68 28 4e 00 00       	push   $0x4e28
    215a:	e8 70 1d 00 00       	call   3ecf <open>
    215f:	83 c4 10             	add    $0x10,%esp
    2162:	85 c0                	test   %eax,%eax
    2164:	78 17                	js     217d <subdir+0x262>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    2166:	83 ec 08             	sub    $0x8,%esp
    2169:	68 d4 4e 00 00       	push   $0x4ed4
    216e:	6a 01                	push   $0x1
    2170:	e8 8c 1e 00 00       	call   4001 <printf>
    2175:	83 c4 10             	add    $0x10,%esp
    exit();
    2178:	e8 12 1d 00 00       	call   3e8f <exit>
  }

  if(chdir("dd") != 0){
    217d:	83 ec 0c             	sub    $0xc,%esp
    2180:	68 a9 4d 00 00       	push   $0x4da9
    2185:	e8 75 1d 00 00       	call   3eff <chdir>
    218a:	83 c4 10             	add    $0x10,%esp
    218d:	85 c0                	test   %eax,%eax
    218f:	74 17                	je     21a8 <subdir+0x28d>
    printf(1, "chdir dd failed\n");
    2191:	83 ec 08             	sub    $0x8,%esp
    2194:	68 f8 4e 00 00       	push   $0x4ef8
    2199:	6a 01                	push   $0x1
    219b:	e8 61 1e 00 00       	call   4001 <printf>
    21a0:	83 c4 10             	add    $0x10,%esp
    exit();
    21a3:	e8 e7 1c 00 00       	call   3e8f <exit>
  }
  if(chdir("dd/../../dd") != 0){
    21a8:	83 ec 0c             	sub    $0xc,%esp
    21ab:	68 09 4f 00 00       	push   $0x4f09
    21b0:	e8 4a 1d 00 00       	call   3eff <chdir>
    21b5:	83 c4 10             	add    $0x10,%esp
    21b8:	85 c0                	test   %eax,%eax
    21ba:	74 17                	je     21d3 <subdir+0x2b8>
    printf(1, "chdir dd/../../dd failed\n");
    21bc:	83 ec 08             	sub    $0x8,%esp
    21bf:	68 15 4f 00 00       	push   $0x4f15
    21c4:	6a 01                	push   $0x1
    21c6:	e8 36 1e 00 00       	call   4001 <printf>
    21cb:	83 c4 10             	add    $0x10,%esp
    exit();
    21ce:	e8 bc 1c 00 00       	call   3e8f <exit>
  }
  if(chdir("dd/../../../dd") != 0){
    21d3:	83 ec 0c             	sub    $0xc,%esp
    21d6:	68 2f 4f 00 00       	push   $0x4f2f
    21db:	e8 1f 1d 00 00       	call   3eff <chdir>
    21e0:	83 c4 10             	add    $0x10,%esp
    21e3:	85 c0                	test   %eax,%eax
    21e5:	74 17                	je     21fe <subdir+0x2e3>
    printf(1, "chdir dd/../../dd failed\n");
    21e7:	83 ec 08             	sub    $0x8,%esp
    21ea:	68 15 4f 00 00       	push   $0x4f15
    21ef:	6a 01                	push   $0x1
    21f1:	e8 0b 1e 00 00       	call   4001 <printf>
    21f6:	83 c4 10             	add    $0x10,%esp
    exit();
    21f9:	e8 91 1c 00 00       	call   3e8f <exit>
  }
  if(chdir("./..") != 0){
    21fe:	83 ec 0c             	sub    $0xc,%esp
    2201:	68 3e 4f 00 00       	push   $0x4f3e
    2206:	e8 f4 1c 00 00       	call   3eff <chdir>
    220b:	83 c4 10             	add    $0x10,%esp
    220e:	85 c0                	test   %eax,%eax
    2210:	74 17                	je     2229 <subdir+0x30e>
    printf(1, "chdir ./.. failed\n");
    2212:	83 ec 08             	sub    $0x8,%esp
    2215:	68 43 4f 00 00       	push   $0x4f43
    221a:	6a 01                	push   $0x1
    221c:	e8 e0 1d 00 00       	call   4001 <printf>
    2221:	83 c4 10             	add    $0x10,%esp
    exit();
    2224:	e8 66 1c 00 00       	call   3e8f <exit>
  }

  fd = open("dd/dd/ffff", 0);
    2229:	83 ec 08             	sub    $0x8,%esp
    222c:	6a 00                	push   $0x0
    222e:	68 8c 4e 00 00       	push   $0x4e8c
    2233:	e8 97 1c 00 00       	call   3ecf <open>
    2238:	83 c4 10             	add    $0x10,%esp
    223b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    223e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2242:	79 17                	jns    225b <subdir+0x340>
    printf(1, "open dd/dd/ffff failed\n");
    2244:	83 ec 08             	sub    $0x8,%esp
    2247:	68 56 4f 00 00       	push   $0x4f56
    224c:	6a 01                	push   $0x1
    224e:	e8 ae 1d 00 00       	call   4001 <printf>
    2253:	83 c4 10             	add    $0x10,%esp
    exit();
    2256:	e8 34 1c 00 00       	call   3e8f <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    225b:	83 ec 04             	sub    $0x4,%esp
    225e:	68 00 20 00 00       	push   $0x2000
    2263:	68 80 8a 00 00       	push   $0x8a80
    2268:	ff 75 f4             	pushl  -0xc(%ebp)
    226b:	e8 37 1c 00 00       	call   3ea7 <read>
    2270:	83 c4 10             	add    $0x10,%esp
    2273:	83 f8 02             	cmp    $0x2,%eax
    2276:	74 17                	je     228f <subdir+0x374>
    printf(1, "read dd/dd/ffff wrong len\n");
    2278:	83 ec 08             	sub    $0x8,%esp
    227b:	68 6e 4f 00 00       	push   $0x4f6e
    2280:	6a 01                	push   $0x1
    2282:	e8 7a 1d 00 00       	call   4001 <printf>
    2287:	83 c4 10             	add    $0x10,%esp
    exit();
    228a:	e8 00 1c 00 00       	call   3e8f <exit>
  }
  close(fd);
    228f:	83 ec 0c             	sub    $0xc,%esp
    2292:	ff 75 f4             	pushl  -0xc(%ebp)
    2295:	e8 1d 1c 00 00       	call   3eb7 <close>
    229a:	83 c4 10             	add    $0x10,%esp

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    229d:	83 ec 08             	sub    $0x8,%esp
    22a0:	6a 00                	push   $0x0
    22a2:	68 28 4e 00 00       	push   $0x4e28
    22a7:	e8 23 1c 00 00       	call   3ecf <open>
    22ac:	83 c4 10             	add    $0x10,%esp
    22af:	85 c0                	test   %eax,%eax
    22b1:	78 17                	js     22ca <subdir+0x3af>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    22b3:	83 ec 08             	sub    $0x8,%esp
    22b6:	68 8c 4f 00 00       	push   $0x4f8c
    22bb:	6a 01                	push   $0x1
    22bd:	e8 3f 1d 00 00       	call   4001 <printf>
    22c2:	83 c4 10             	add    $0x10,%esp
    exit();
    22c5:	e8 c5 1b 00 00       	call   3e8f <exit>
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    22ca:	83 ec 08             	sub    $0x8,%esp
    22cd:	68 02 02 00 00       	push   $0x202
    22d2:	68 b1 4f 00 00       	push   $0x4fb1
    22d7:	e8 f3 1b 00 00       	call   3ecf <open>
    22dc:	83 c4 10             	add    $0x10,%esp
    22df:	85 c0                	test   %eax,%eax
    22e1:	78 17                	js     22fa <subdir+0x3df>
    printf(1, "create dd/ff/ff succeeded!\n");
    22e3:	83 ec 08             	sub    $0x8,%esp
    22e6:	68 ba 4f 00 00       	push   $0x4fba
    22eb:	6a 01                	push   $0x1
    22ed:	e8 0f 1d 00 00       	call   4001 <printf>
    22f2:	83 c4 10             	add    $0x10,%esp
    exit();
    22f5:	e8 95 1b 00 00       	call   3e8f <exit>
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    22fa:	83 ec 08             	sub    $0x8,%esp
    22fd:	68 02 02 00 00       	push   $0x202
    2302:	68 d6 4f 00 00       	push   $0x4fd6
    2307:	e8 c3 1b 00 00       	call   3ecf <open>
    230c:	83 c4 10             	add    $0x10,%esp
    230f:	85 c0                	test   %eax,%eax
    2311:	78 17                	js     232a <subdir+0x40f>
    printf(1, "create dd/xx/ff succeeded!\n");
    2313:	83 ec 08             	sub    $0x8,%esp
    2316:	68 df 4f 00 00       	push   $0x4fdf
    231b:	6a 01                	push   $0x1
    231d:	e8 df 1c 00 00       	call   4001 <printf>
    2322:	83 c4 10             	add    $0x10,%esp
    exit();
    2325:	e8 65 1b 00 00       	call   3e8f <exit>
  }
  if(open("dd", O_CREATE) >= 0){
    232a:	83 ec 08             	sub    $0x8,%esp
    232d:	68 00 02 00 00       	push   $0x200
    2332:	68 a9 4d 00 00       	push   $0x4da9
    2337:	e8 93 1b 00 00       	call   3ecf <open>
    233c:	83 c4 10             	add    $0x10,%esp
    233f:	85 c0                	test   %eax,%eax
    2341:	78 17                	js     235a <subdir+0x43f>
    printf(1, "create dd succeeded!\n");
    2343:	83 ec 08             	sub    $0x8,%esp
    2346:	68 fb 4f 00 00       	push   $0x4ffb
    234b:	6a 01                	push   $0x1
    234d:	e8 af 1c 00 00       	call   4001 <printf>
    2352:	83 c4 10             	add    $0x10,%esp
    exit();
    2355:	e8 35 1b 00 00       	call   3e8f <exit>
  }
  if(open("dd", O_RDWR) >= 0){
    235a:	83 ec 08             	sub    $0x8,%esp
    235d:	6a 02                	push   $0x2
    235f:	68 a9 4d 00 00       	push   $0x4da9
    2364:	e8 66 1b 00 00       	call   3ecf <open>
    2369:	83 c4 10             	add    $0x10,%esp
    236c:	85 c0                	test   %eax,%eax
    236e:	78 17                	js     2387 <subdir+0x46c>
    printf(1, "open dd rdwr succeeded!\n");
    2370:	83 ec 08             	sub    $0x8,%esp
    2373:	68 11 50 00 00       	push   $0x5011
    2378:	6a 01                	push   $0x1
    237a:	e8 82 1c 00 00       	call   4001 <printf>
    237f:	83 c4 10             	add    $0x10,%esp
    exit();
    2382:	e8 08 1b 00 00       	call   3e8f <exit>
  }
  if(open("dd", O_WRONLY) >= 0){
    2387:	83 ec 08             	sub    $0x8,%esp
    238a:	6a 01                	push   $0x1
    238c:	68 a9 4d 00 00       	push   $0x4da9
    2391:	e8 39 1b 00 00       	call   3ecf <open>
    2396:	83 c4 10             	add    $0x10,%esp
    2399:	85 c0                	test   %eax,%eax
    239b:	78 17                	js     23b4 <subdir+0x499>
    printf(1, "open dd wronly succeeded!\n");
    239d:	83 ec 08             	sub    $0x8,%esp
    23a0:	68 2a 50 00 00       	push   $0x502a
    23a5:	6a 01                	push   $0x1
    23a7:	e8 55 1c 00 00       	call   4001 <printf>
    23ac:	83 c4 10             	add    $0x10,%esp
    exit();
    23af:	e8 db 1a 00 00       	call   3e8f <exit>
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    23b4:	83 ec 08             	sub    $0x8,%esp
    23b7:	68 45 50 00 00       	push   $0x5045
    23bc:	68 b1 4f 00 00       	push   $0x4fb1
    23c1:	e8 29 1b 00 00       	call   3eef <link>
    23c6:	83 c4 10             	add    $0x10,%esp
    23c9:	85 c0                	test   %eax,%eax
    23cb:	75 17                	jne    23e4 <subdir+0x4c9>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    23cd:	83 ec 08             	sub    $0x8,%esp
    23d0:	68 50 50 00 00       	push   $0x5050
    23d5:	6a 01                	push   $0x1
    23d7:	e8 25 1c 00 00       	call   4001 <printf>
    23dc:	83 c4 10             	add    $0x10,%esp
    exit();
    23df:	e8 ab 1a 00 00       	call   3e8f <exit>
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    23e4:	83 ec 08             	sub    $0x8,%esp
    23e7:	68 45 50 00 00       	push   $0x5045
    23ec:	68 d6 4f 00 00       	push   $0x4fd6
    23f1:	e8 f9 1a 00 00       	call   3eef <link>
    23f6:	83 c4 10             	add    $0x10,%esp
    23f9:	85 c0                	test   %eax,%eax
    23fb:	75 17                	jne    2414 <subdir+0x4f9>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    23fd:	83 ec 08             	sub    $0x8,%esp
    2400:	68 74 50 00 00       	push   $0x5074
    2405:	6a 01                	push   $0x1
    2407:	e8 f5 1b 00 00       	call   4001 <printf>
    240c:	83 c4 10             	add    $0x10,%esp
    exit();
    240f:	e8 7b 1a 00 00       	call   3e8f <exit>
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2414:	83 ec 08             	sub    $0x8,%esp
    2417:	68 8c 4e 00 00       	push   $0x4e8c
    241c:	68 c4 4d 00 00       	push   $0x4dc4
    2421:	e8 c9 1a 00 00       	call   3eef <link>
    2426:	83 c4 10             	add    $0x10,%esp
    2429:	85 c0                	test   %eax,%eax
    242b:	75 17                	jne    2444 <subdir+0x529>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    242d:	83 ec 08             	sub    $0x8,%esp
    2430:	68 98 50 00 00       	push   $0x5098
    2435:	6a 01                	push   $0x1
    2437:	e8 c5 1b 00 00       	call   4001 <printf>
    243c:	83 c4 10             	add    $0x10,%esp
    exit();
    243f:	e8 4b 1a 00 00       	call   3e8f <exit>
  }
  if(mkdir("dd/ff/ff") == 0){
    2444:	83 ec 0c             	sub    $0xc,%esp
    2447:	68 b1 4f 00 00       	push   $0x4fb1
    244c:	e8 a6 1a 00 00       	call   3ef7 <mkdir>
    2451:	83 c4 10             	add    $0x10,%esp
    2454:	85 c0                	test   %eax,%eax
    2456:	75 17                	jne    246f <subdir+0x554>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    2458:	83 ec 08             	sub    $0x8,%esp
    245b:	68 ba 50 00 00       	push   $0x50ba
    2460:	6a 01                	push   $0x1
    2462:	e8 9a 1b 00 00       	call   4001 <printf>
    2467:	83 c4 10             	add    $0x10,%esp
    exit();
    246a:	e8 20 1a 00 00       	call   3e8f <exit>
  }
  if(mkdir("dd/xx/ff") == 0){
    246f:	83 ec 0c             	sub    $0xc,%esp
    2472:	68 d6 4f 00 00       	push   $0x4fd6
    2477:	e8 7b 1a 00 00       	call   3ef7 <mkdir>
    247c:	83 c4 10             	add    $0x10,%esp
    247f:	85 c0                	test   %eax,%eax
    2481:	75 17                	jne    249a <subdir+0x57f>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    2483:	83 ec 08             	sub    $0x8,%esp
    2486:	68 d5 50 00 00       	push   $0x50d5
    248b:	6a 01                	push   $0x1
    248d:	e8 6f 1b 00 00       	call   4001 <printf>
    2492:	83 c4 10             	add    $0x10,%esp
    exit();
    2495:	e8 f5 19 00 00       	call   3e8f <exit>
  }
  if(mkdir("dd/dd/ffff") == 0){
    249a:	83 ec 0c             	sub    $0xc,%esp
    249d:	68 8c 4e 00 00       	push   $0x4e8c
    24a2:	e8 50 1a 00 00       	call   3ef7 <mkdir>
    24a7:	83 c4 10             	add    $0x10,%esp
    24aa:	85 c0                	test   %eax,%eax
    24ac:	75 17                	jne    24c5 <subdir+0x5aa>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    24ae:	83 ec 08             	sub    $0x8,%esp
    24b1:	68 f0 50 00 00       	push   $0x50f0
    24b6:	6a 01                	push   $0x1
    24b8:	e8 44 1b 00 00       	call   4001 <printf>
    24bd:	83 c4 10             	add    $0x10,%esp
    exit();
    24c0:	e8 ca 19 00 00       	call   3e8f <exit>
  }
  if(unlink("dd/xx/ff") == 0){
    24c5:	83 ec 0c             	sub    $0xc,%esp
    24c8:	68 d6 4f 00 00       	push   $0x4fd6
    24cd:	e8 0d 1a 00 00       	call   3edf <unlink>
    24d2:	83 c4 10             	add    $0x10,%esp
    24d5:	85 c0                	test   %eax,%eax
    24d7:	75 17                	jne    24f0 <subdir+0x5d5>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    24d9:	83 ec 08             	sub    $0x8,%esp
    24dc:	68 0d 51 00 00       	push   $0x510d
    24e1:	6a 01                	push   $0x1
    24e3:	e8 19 1b 00 00       	call   4001 <printf>
    24e8:	83 c4 10             	add    $0x10,%esp
    exit();
    24eb:	e8 9f 19 00 00       	call   3e8f <exit>
  }
  if(unlink("dd/ff/ff") == 0){
    24f0:	83 ec 0c             	sub    $0xc,%esp
    24f3:	68 b1 4f 00 00       	push   $0x4fb1
    24f8:	e8 e2 19 00 00       	call   3edf <unlink>
    24fd:	83 c4 10             	add    $0x10,%esp
    2500:	85 c0                	test   %eax,%eax
    2502:	75 17                	jne    251b <subdir+0x600>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    2504:	83 ec 08             	sub    $0x8,%esp
    2507:	68 29 51 00 00       	push   $0x5129
    250c:	6a 01                	push   $0x1
    250e:	e8 ee 1a 00 00       	call   4001 <printf>
    2513:	83 c4 10             	add    $0x10,%esp
    exit();
    2516:	e8 74 19 00 00       	call   3e8f <exit>
  }
  if(chdir("dd/ff") == 0){
    251b:	83 ec 0c             	sub    $0xc,%esp
    251e:	68 c4 4d 00 00       	push   $0x4dc4
    2523:	e8 d7 19 00 00       	call   3eff <chdir>
    2528:	83 c4 10             	add    $0x10,%esp
    252b:	85 c0                	test   %eax,%eax
    252d:	75 17                	jne    2546 <subdir+0x62b>
    printf(1, "chdir dd/ff succeeded!\n");
    252f:	83 ec 08             	sub    $0x8,%esp
    2532:	68 45 51 00 00       	push   $0x5145
    2537:	6a 01                	push   $0x1
    2539:	e8 c3 1a 00 00       	call   4001 <printf>
    253e:	83 c4 10             	add    $0x10,%esp
    exit();
    2541:	e8 49 19 00 00       	call   3e8f <exit>
  }
  if(chdir("dd/xx") == 0){
    2546:	83 ec 0c             	sub    $0xc,%esp
    2549:	68 5d 51 00 00       	push   $0x515d
    254e:	e8 ac 19 00 00       	call   3eff <chdir>
    2553:	83 c4 10             	add    $0x10,%esp
    2556:	85 c0                	test   %eax,%eax
    2558:	75 17                	jne    2571 <subdir+0x656>
    printf(1, "chdir dd/xx succeeded!\n");
    255a:	83 ec 08             	sub    $0x8,%esp
    255d:	68 63 51 00 00       	push   $0x5163
    2562:	6a 01                	push   $0x1
    2564:	e8 98 1a 00 00       	call   4001 <printf>
    2569:	83 c4 10             	add    $0x10,%esp
    exit();
    256c:	e8 1e 19 00 00       	call   3e8f <exit>
  }

  if(unlink("dd/dd/ffff") != 0){
    2571:	83 ec 0c             	sub    $0xc,%esp
    2574:	68 8c 4e 00 00       	push   $0x4e8c
    2579:	e8 61 19 00 00       	call   3edf <unlink>
    257e:	83 c4 10             	add    $0x10,%esp
    2581:	85 c0                	test   %eax,%eax
    2583:	74 17                	je     259c <subdir+0x681>
    printf(1, "unlink dd/dd/ff failed\n");
    2585:	83 ec 08             	sub    $0x8,%esp
    2588:	68 b9 4e 00 00       	push   $0x4eb9
    258d:	6a 01                	push   $0x1
    258f:	e8 6d 1a 00 00       	call   4001 <printf>
    2594:	83 c4 10             	add    $0x10,%esp
    exit();
    2597:	e8 f3 18 00 00       	call   3e8f <exit>
  }
  if(unlink("dd/ff") != 0){
    259c:	83 ec 0c             	sub    $0xc,%esp
    259f:	68 c4 4d 00 00       	push   $0x4dc4
    25a4:	e8 36 19 00 00       	call   3edf <unlink>
    25a9:	83 c4 10             	add    $0x10,%esp
    25ac:	85 c0                	test   %eax,%eax
    25ae:	74 17                	je     25c7 <subdir+0x6ac>
    printf(1, "unlink dd/ff failed\n");
    25b0:	83 ec 08             	sub    $0x8,%esp
    25b3:	68 7b 51 00 00       	push   $0x517b
    25b8:	6a 01                	push   $0x1
    25ba:	e8 42 1a 00 00       	call   4001 <printf>
    25bf:	83 c4 10             	add    $0x10,%esp
    exit();
    25c2:	e8 c8 18 00 00       	call   3e8f <exit>
  }
  if(unlink("dd") == 0){
    25c7:	83 ec 0c             	sub    $0xc,%esp
    25ca:	68 a9 4d 00 00       	push   $0x4da9
    25cf:	e8 0b 19 00 00       	call   3edf <unlink>
    25d4:	83 c4 10             	add    $0x10,%esp
    25d7:	85 c0                	test   %eax,%eax
    25d9:	75 17                	jne    25f2 <subdir+0x6d7>
    printf(1, "unlink non-empty dd succeeded!\n");
    25db:	83 ec 08             	sub    $0x8,%esp
    25de:	68 90 51 00 00       	push   $0x5190
    25e3:	6a 01                	push   $0x1
    25e5:	e8 17 1a 00 00       	call   4001 <printf>
    25ea:	83 c4 10             	add    $0x10,%esp
    exit();
    25ed:	e8 9d 18 00 00       	call   3e8f <exit>
  }
  if(unlink("dd/dd") < 0){
    25f2:	83 ec 0c             	sub    $0xc,%esp
    25f5:	68 b0 51 00 00       	push   $0x51b0
    25fa:	e8 e0 18 00 00       	call   3edf <unlink>
    25ff:	83 c4 10             	add    $0x10,%esp
    2602:	85 c0                	test   %eax,%eax
    2604:	79 17                	jns    261d <subdir+0x702>
    printf(1, "unlink dd/dd failed\n");
    2606:	83 ec 08             	sub    $0x8,%esp
    2609:	68 b6 51 00 00       	push   $0x51b6
    260e:	6a 01                	push   $0x1
    2610:	e8 ec 19 00 00       	call   4001 <printf>
    2615:	83 c4 10             	add    $0x10,%esp
    exit();
    2618:	e8 72 18 00 00       	call   3e8f <exit>
  }
  if(unlink("dd") < 0){
    261d:	83 ec 0c             	sub    $0xc,%esp
    2620:	68 a9 4d 00 00       	push   $0x4da9
    2625:	e8 b5 18 00 00       	call   3edf <unlink>
    262a:	83 c4 10             	add    $0x10,%esp
    262d:	85 c0                	test   %eax,%eax
    262f:	79 17                	jns    2648 <subdir+0x72d>
    printf(1, "unlink dd failed\n");
    2631:	83 ec 08             	sub    $0x8,%esp
    2634:	68 cb 51 00 00       	push   $0x51cb
    2639:	6a 01                	push   $0x1
    263b:	e8 c1 19 00 00       	call   4001 <printf>
    2640:	83 c4 10             	add    $0x10,%esp
    exit();
    2643:	e8 47 18 00 00       	call   3e8f <exit>
  }

  printf(1, "subdir ok\n");
    2648:	83 ec 08             	sub    $0x8,%esp
    264b:	68 dd 51 00 00       	push   $0x51dd
    2650:	6a 01                	push   $0x1
    2652:	e8 aa 19 00 00       	call   4001 <printf>
    2657:	83 c4 10             	add    $0x10,%esp
}
    265a:	c9                   	leave  
    265b:	c3                   	ret    

0000265c <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(void)
{
    265c:	55                   	push   %ebp
    265d:	89 e5                	mov    %esp,%ebp
    265f:	83 ec 18             	sub    $0x18,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");
    2662:	83 ec 08             	sub    $0x8,%esp
    2665:	68 e8 51 00 00       	push   $0x51e8
    266a:	6a 01                	push   $0x1
    266c:	e8 90 19 00 00       	call   4001 <printf>
    2671:	83 c4 10             	add    $0x10,%esp

  unlink("bigwrite");
    2674:	83 ec 0c             	sub    $0xc,%esp
    2677:	68 f7 51 00 00       	push   $0x51f7
    267c:	e8 5e 18 00 00       	call   3edf <unlink>
    2681:	83 c4 10             	add    $0x10,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    2684:	c7 45 f4 f3 01 00 00 	movl   $0x1f3,-0xc(%ebp)
    268b:	e9 a7 00 00 00       	jmp    2737 <bigwrite+0xdb>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2690:	83 ec 08             	sub    $0x8,%esp
    2693:	68 02 02 00 00       	push   $0x202
    2698:	68 f7 51 00 00       	push   $0x51f7
    269d:	e8 2d 18 00 00       	call   3ecf <open>
    26a2:	83 c4 10             	add    $0x10,%esp
    26a5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fd < 0){
    26a8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    26ac:	79 17                	jns    26c5 <bigwrite+0x69>
      printf(1, "cannot create bigwrite\n");
    26ae:	83 ec 08             	sub    $0x8,%esp
    26b1:	68 00 52 00 00       	push   $0x5200
    26b6:	6a 01                	push   $0x1
    26b8:	e8 44 19 00 00       	call   4001 <printf>
    26bd:	83 c4 10             	add    $0x10,%esp
      exit();
    26c0:	e8 ca 17 00 00       	call   3e8f <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
    26c5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    26cc:	eb 3e                	jmp    270c <bigwrite+0xb0>
      int cc = write(fd, buf, sz);
    26ce:	83 ec 04             	sub    $0x4,%esp
    26d1:	ff 75 f4             	pushl  -0xc(%ebp)
    26d4:	68 80 8a 00 00       	push   $0x8a80
    26d9:	ff 75 ec             	pushl  -0x14(%ebp)
    26dc:	e8 ce 17 00 00       	call   3eaf <write>
    26e1:	83 c4 10             	add    $0x10,%esp
    26e4:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(cc != sz){
    26e7:	8b 45 e8             	mov    -0x18(%ebp),%eax
    26ea:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    26ed:	74 1a                	je     2709 <bigwrite+0xad>
        printf(1, "write(%d) ret %d\n", sz, cc);
    26ef:	ff 75 e8             	pushl  -0x18(%ebp)
    26f2:	ff 75 f4             	pushl  -0xc(%ebp)
    26f5:	68 18 52 00 00       	push   $0x5218
    26fa:	6a 01                	push   $0x1
    26fc:	e8 00 19 00 00       	call   4001 <printf>
    2701:	83 c4 10             	add    $0x10,%esp
        exit();
    2704:	e8 86 17 00 00       	call   3e8f <exit>
    if(fd < 0){
      printf(1, "cannot create bigwrite\n");
      exit();
    }
    int i;
    for(i = 0; i < 2; i++){
    2709:	ff 45 f0             	incl   -0x10(%ebp)
    270c:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    2710:	7e bc                	jle    26ce <bigwrite+0x72>
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
        exit();
      }
    }
    close(fd);
    2712:	83 ec 0c             	sub    $0xc,%esp
    2715:	ff 75 ec             	pushl  -0x14(%ebp)
    2718:	e8 9a 17 00 00       	call   3eb7 <close>
    271d:	83 c4 10             	add    $0x10,%esp
    unlink("bigwrite");
    2720:	83 ec 0c             	sub    $0xc,%esp
    2723:	68 f7 51 00 00       	push   $0x51f7
    2728:	e8 b2 17 00 00       	call   3edf <unlink>
    272d:	83 c4 10             	add    $0x10,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    2730:	81 45 f4 d7 01 00 00 	addl   $0x1d7,-0xc(%ebp)
    2737:	81 7d f4 ff 17 00 00 	cmpl   $0x17ff,-0xc(%ebp)
    273e:	0f 8e 4c ff ff ff    	jle    2690 <bigwrite+0x34>
    }
    close(fd);
    unlink("bigwrite");
  }

  printf(1, "bigwrite ok\n");
    2744:	83 ec 08             	sub    $0x8,%esp
    2747:	68 2a 52 00 00       	push   $0x522a
    274c:	6a 01                	push   $0x1
    274e:	e8 ae 18 00 00       	call   4001 <printf>
    2753:	83 c4 10             	add    $0x10,%esp
}
    2756:	c9                   	leave  
    2757:	c3                   	ret    

00002758 <bigfile>:

void
bigfile(void)
{
    2758:	55                   	push   %ebp
    2759:	89 e5                	mov    %esp,%ebp
    275b:	83 ec 18             	sub    $0x18,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    275e:	83 ec 08             	sub    $0x8,%esp
    2761:	68 37 52 00 00       	push   $0x5237
    2766:	6a 01                	push   $0x1
    2768:	e8 94 18 00 00       	call   4001 <printf>
    276d:	83 c4 10             	add    $0x10,%esp

  unlink("bigfile");
    2770:	83 ec 0c             	sub    $0xc,%esp
    2773:	68 45 52 00 00       	push   $0x5245
    2778:	e8 62 17 00 00       	call   3edf <unlink>
    277d:	83 c4 10             	add    $0x10,%esp
  fd = open("bigfile", O_CREATE | O_RDWR);
    2780:	83 ec 08             	sub    $0x8,%esp
    2783:	68 02 02 00 00       	push   $0x202
    2788:	68 45 52 00 00       	push   $0x5245
    278d:	e8 3d 17 00 00       	call   3ecf <open>
    2792:	83 c4 10             	add    $0x10,%esp
    2795:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    2798:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    279c:	79 17                	jns    27b5 <bigfile+0x5d>
    printf(1, "cannot create bigfile");
    279e:	83 ec 08             	sub    $0x8,%esp
    27a1:	68 4d 52 00 00       	push   $0x524d
    27a6:	6a 01                	push   $0x1
    27a8:	e8 54 18 00 00       	call   4001 <printf>
    27ad:	83 c4 10             	add    $0x10,%esp
    exit();
    27b0:	e8 da 16 00 00       	call   3e8f <exit>
  }
  for(i = 0; i < 20; i++){
    27b5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    27bc:	eb 51                	jmp    280f <bigfile+0xb7>
    memset(buf, i, 600);
    27be:	83 ec 04             	sub    $0x4,%esp
    27c1:	68 58 02 00 00       	push   $0x258
    27c6:	ff 75 f4             	pushl  -0xc(%ebp)
    27c9:	68 80 8a 00 00       	push   $0x8a80
    27ce:	e8 2e 15 00 00       	call   3d01 <memset>
    27d3:	83 c4 10             	add    $0x10,%esp
    if(write(fd, buf, 600) != 600){
    27d6:	83 ec 04             	sub    $0x4,%esp
    27d9:	68 58 02 00 00       	push   $0x258
    27de:	68 80 8a 00 00       	push   $0x8a80
    27e3:	ff 75 ec             	pushl  -0x14(%ebp)
    27e6:	e8 c4 16 00 00       	call   3eaf <write>
    27eb:	83 c4 10             	add    $0x10,%esp
    27ee:	3d 58 02 00 00       	cmp    $0x258,%eax
    27f3:	74 17                	je     280c <bigfile+0xb4>
      printf(1, "write bigfile failed\n");
    27f5:	83 ec 08             	sub    $0x8,%esp
    27f8:	68 63 52 00 00       	push   $0x5263
    27fd:	6a 01                	push   $0x1
    27ff:	e8 fd 17 00 00       	call   4001 <printf>
    2804:	83 c4 10             	add    $0x10,%esp
      exit();
    2807:	e8 83 16 00 00       	call   3e8f <exit>
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    280c:	ff 45 f4             	incl   -0xc(%ebp)
    280f:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    2813:	7e a9                	jle    27be <bigfile+0x66>
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
      exit();
    }
  }
  close(fd);
    2815:	83 ec 0c             	sub    $0xc,%esp
    2818:	ff 75 ec             	pushl  -0x14(%ebp)
    281b:	e8 97 16 00 00       	call   3eb7 <close>
    2820:	83 c4 10             	add    $0x10,%esp

  fd = open("bigfile", 0);
    2823:	83 ec 08             	sub    $0x8,%esp
    2826:	6a 00                	push   $0x0
    2828:	68 45 52 00 00       	push   $0x5245
    282d:	e8 9d 16 00 00       	call   3ecf <open>
    2832:	83 c4 10             	add    $0x10,%esp
    2835:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    2838:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    283c:	79 17                	jns    2855 <bigfile+0xfd>
    printf(1, "cannot open bigfile\n");
    283e:	83 ec 08             	sub    $0x8,%esp
    2841:	68 79 52 00 00       	push   $0x5279
    2846:	6a 01                	push   $0x1
    2848:	e8 b4 17 00 00       	call   4001 <printf>
    284d:	83 c4 10             	add    $0x10,%esp
    exit();
    2850:	e8 3a 16 00 00       	call   3e8f <exit>
  }
  total = 0;
    2855:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(i = 0; ; i++){
    285c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    cc = read(fd, buf, 300);
    2863:	83 ec 04             	sub    $0x4,%esp
    2866:	68 2c 01 00 00       	push   $0x12c
    286b:	68 80 8a 00 00       	push   $0x8a80
    2870:	ff 75 ec             	pushl  -0x14(%ebp)
    2873:	e8 2f 16 00 00       	call   3ea7 <read>
    2878:	83 c4 10             	add    $0x10,%esp
    287b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(cc < 0){
    287e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2882:	79 17                	jns    289b <bigfile+0x143>
      printf(1, "read bigfile failed\n");
    2884:	83 ec 08             	sub    $0x8,%esp
    2887:	68 8e 52 00 00       	push   $0x528e
    288c:	6a 01                	push   $0x1
    288e:	e8 6e 17 00 00       	call   4001 <printf>
    2893:	83 c4 10             	add    $0x10,%esp
      exit();
    2896:	e8 f4 15 00 00       	call   3e8f <exit>
    }
    if(cc == 0)
    289b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    289f:	75 1e                	jne    28bf <bigfile+0x167>
      break;
    28a1:	90                   	nop
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
  }
  close(fd);
    28a2:	83 ec 0c             	sub    $0xc,%esp
    28a5:	ff 75 ec             	pushl  -0x14(%ebp)
    28a8:	e8 0a 16 00 00       	call   3eb7 <close>
    28ad:	83 c4 10             	add    $0x10,%esp
  if(total != 20*600){
    28b0:	81 7d f0 e0 2e 00 00 	cmpl   $0x2ee0,-0x10(%ebp)
    28b7:	0f 84 8e 00 00 00    	je     294b <bigfile+0x1f3>
    28bd:	eb 75                	jmp    2934 <bigfile+0x1dc>
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
    28bf:	81 7d e8 2c 01 00 00 	cmpl   $0x12c,-0x18(%ebp)
    28c6:	74 17                	je     28df <bigfile+0x187>
      printf(1, "short read bigfile\n");
    28c8:	83 ec 08             	sub    $0x8,%esp
    28cb:	68 a3 52 00 00       	push   $0x52a3
    28d0:	6a 01                	push   $0x1
    28d2:	e8 2a 17 00 00       	call   4001 <printf>
    28d7:	83 c4 10             	add    $0x10,%esp
      exit();
    28da:	e8 b0 15 00 00       	call   3e8f <exit>
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    28df:	a0 80 8a 00 00       	mov    0x8a80,%al
    28e4:	0f be d0             	movsbl %al,%edx
    28e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    28ea:	89 c1                	mov    %eax,%ecx
    28ec:	c1 e9 1f             	shr    $0x1f,%ecx
    28ef:	01 c8                	add    %ecx,%eax
    28f1:	d1 f8                	sar    %eax
    28f3:	39 c2                	cmp    %eax,%edx
    28f5:	75 18                	jne    290f <bigfile+0x1b7>
    28f7:	a0 ab 8b 00 00       	mov    0x8bab,%al
    28fc:	0f be d0             	movsbl %al,%edx
    28ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2902:	89 c1                	mov    %eax,%ecx
    2904:	c1 e9 1f             	shr    $0x1f,%ecx
    2907:	01 c8                	add    %ecx,%eax
    2909:	d1 f8                	sar    %eax
    290b:	39 c2                	cmp    %eax,%edx
    290d:	74 17                	je     2926 <bigfile+0x1ce>
      printf(1, "read bigfile wrong data\n");
    290f:	83 ec 08             	sub    $0x8,%esp
    2912:	68 b7 52 00 00       	push   $0x52b7
    2917:	6a 01                	push   $0x1
    2919:	e8 e3 16 00 00       	call   4001 <printf>
    291e:	83 c4 10             	add    $0x10,%esp
      exit();
    2921:	e8 69 15 00 00       	call   3e8f <exit>
    }
    total += cc;
    2926:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2929:	01 45 f0             	add    %eax,-0x10(%ebp)
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    exit();
  }
  total = 0;
  for(i = 0; ; i++){
    292c:	ff 45 f4             	incl   -0xc(%ebp)
    if(buf[0] != i/2 || buf[299] != i/2){
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
  }
    292f:	e9 2f ff ff ff       	jmp    2863 <bigfile+0x10b>
  close(fd);
  if(total != 20*600){
    printf(1, "read bigfile wrong total\n");
    2934:	83 ec 08             	sub    $0x8,%esp
    2937:	68 d0 52 00 00       	push   $0x52d0
    293c:	6a 01                	push   $0x1
    293e:	e8 be 16 00 00       	call   4001 <printf>
    2943:	83 c4 10             	add    $0x10,%esp
    exit();
    2946:	e8 44 15 00 00       	call   3e8f <exit>
  }
  unlink("bigfile");
    294b:	83 ec 0c             	sub    $0xc,%esp
    294e:	68 45 52 00 00       	push   $0x5245
    2953:	e8 87 15 00 00       	call   3edf <unlink>
    2958:	83 c4 10             	add    $0x10,%esp

  printf(1, "bigfile test ok\n");
    295b:	83 ec 08             	sub    $0x8,%esp
    295e:	68 ea 52 00 00       	push   $0x52ea
    2963:	6a 01                	push   $0x1
    2965:	e8 97 16 00 00       	call   4001 <printf>
    296a:	83 c4 10             	add    $0x10,%esp
}
    296d:	c9                   	leave  
    296e:	c3                   	ret    

0000296f <fourteen>:

void
fourteen(void)
{
    296f:	55                   	push   %ebp
    2970:	89 e5                	mov    %esp,%ebp
    2972:	83 ec 18             	sub    $0x18,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    2975:	83 ec 08             	sub    $0x8,%esp
    2978:	68 fb 52 00 00       	push   $0x52fb
    297d:	6a 01                	push   $0x1
    297f:	e8 7d 16 00 00       	call   4001 <printf>
    2984:	83 c4 10             	add    $0x10,%esp

  if(mkdir("12345678901234") != 0){
    2987:	83 ec 0c             	sub    $0xc,%esp
    298a:	68 0a 53 00 00       	push   $0x530a
    298f:	e8 63 15 00 00       	call   3ef7 <mkdir>
    2994:	83 c4 10             	add    $0x10,%esp
    2997:	85 c0                	test   %eax,%eax
    2999:	74 17                	je     29b2 <fourteen+0x43>
    printf(1, "mkdir 12345678901234 failed\n");
    299b:	83 ec 08             	sub    $0x8,%esp
    299e:	68 19 53 00 00       	push   $0x5319
    29a3:	6a 01                	push   $0x1
    29a5:	e8 57 16 00 00       	call   4001 <printf>
    29aa:	83 c4 10             	add    $0x10,%esp
    exit();
    29ad:	e8 dd 14 00 00       	call   3e8f <exit>
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    29b2:	83 ec 0c             	sub    $0xc,%esp
    29b5:	68 38 53 00 00       	push   $0x5338
    29ba:	e8 38 15 00 00       	call   3ef7 <mkdir>
    29bf:	83 c4 10             	add    $0x10,%esp
    29c2:	85 c0                	test   %eax,%eax
    29c4:	74 17                	je     29dd <fourteen+0x6e>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    29c6:	83 ec 08             	sub    $0x8,%esp
    29c9:	68 58 53 00 00       	push   $0x5358
    29ce:	6a 01                	push   $0x1
    29d0:	e8 2c 16 00 00       	call   4001 <printf>
    29d5:	83 c4 10             	add    $0x10,%esp
    exit();
    29d8:	e8 b2 14 00 00       	call   3e8f <exit>
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    29dd:	83 ec 08             	sub    $0x8,%esp
    29e0:	68 00 02 00 00       	push   $0x200
    29e5:	68 88 53 00 00       	push   $0x5388
    29ea:	e8 e0 14 00 00       	call   3ecf <open>
    29ef:	83 c4 10             	add    $0x10,%esp
    29f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    29f5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    29f9:	79 17                	jns    2a12 <fourteen+0xa3>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    29fb:	83 ec 08             	sub    $0x8,%esp
    29fe:	68 b8 53 00 00       	push   $0x53b8
    2a03:	6a 01                	push   $0x1
    2a05:	e8 f7 15 00 00       	call   4001 <printf>
    2a0a:	83 c4 10             	add    $0x10,%esp
    exit();
    2a0d:	e8 7d 14 00 00       	call   3e8f <exit>
  }
  close(fd);
    2a12:	83 ec 0c             	sub    $0xc,%esp
    2a15:	ff 75 f4             	pushl  -0xc(%ebp)
    2a18:	e8 9a 14 00 00       	call   3eb7 <close>
    2a1d:	83 c4 10             	add    $0x10,%esp
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2a20:	83 ec 08             	sub    $0x8,%esp
    2a23:	6a 00                	push   $0x0
    2a25:	68 f8 53 00 00       	push   $0x53f8
    2a2a:	e8 a0 14 00 00       	call   3ecf <open>
    2a2f:	83 c4 10             	add    $0x10,%esp
    2a32:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2a35:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2a39:	79 17                	jns    2a52 <fourteen+0xe3>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    2a3b:	83 ec 08             	sub    $0x8,%esp
    2a3e:	68 28 54 00 00       	push   $0x5428
    2a43:	6a 01                	push   $0x1
    2a45:	e8 b7 15 00 00       	call   4001 <printf>
    2a4a:	83 c4 10             	add    $0x10,%esp
    exit();
    2a4d:	e8 3d 14 00 00       	call   3e8f <exit>
  }
  close(fd);
    2a52:	83 ec 0c             	sub    $0xc,%esp
    2a55:	ff 75 f4             	pushl  -0xc(%ebp)
    2a58:	e8 5a 14 00 00       	call   3eb7 <close>
    2a5d:	83 c4 10             	add    $0x10,%esp

  if(mkdir("12345678901234/12345678901234") == 0){
    2a60:	83 ec 0c             	sub    $0xc,%esp
    2a63:	68 62 54 00 00       	push   $0x5462
    2a68:	e8 8a 14 00 00       	call   3ef7 <mkdir>
    2a6d:	83 c4 10             	add    $0x10,%esp
    2a70:	85 c0                	test   %eax,%eax
    2a72:	75 17                	jne    2a8b <fourteen+0x11c>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2a74:	83 ec 08             	sub    $0x8,%esp
    2a77:	68 80 54 00 00       	push   $0x5480
    2a7c:	6a 01                	push   $0x1
    2a7e:	e8 7e 15 00 00       	call   4001 <printf>
    2a83:	83 c4 10             	add    $0x10,%esp
    exit();
    2a86:	e8 04 14 00 00       	call   3e8f <exit>
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    2a8b:	83 ec 0c             	sub    $0xc,%esp
    2a8e:	68 b0 54 00 00       	push   $0x54b0
    2a93:	e8 5f 14 00 00       	call   3ef7 <mkdir>
    2a98:	83 c4 10             	add    $0x10,%esp
    2a9b:	85 c0                	test   %eax,%eax
    2a9d:	75 17                	jne    2ab6 <fourteen+0x147>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2a9f:	83 ec 08             	sub    $0x8,%esp
    2aa2:	68 d0 54 00 00       	push   $0x54d0
    2aa7:	6a 01                	push   $0x1
    2aa9:	e8 53 15 00 00       	call   4001 <printf>
    2aae:	83 c4 10             	add    $0x10,%esp
    exit();
    2ab1:	e8 d9 13 00 00       	call   3e8f <exit>
  }

  printf(1, "fourteen ok\n");
    2ab6:	83 ec 08             	sub    $0x8,%esp
    2ab9:	68 01 55 00 00       	push   $0x5501
    2abe:	6a 01                	push   $0x1
    2ac0:	e8 3c 15 00 00       	call   4001 <printf>
    2ac5:	83 c4 10             	add    $0x10,%esp
}
    2ac8:	c9                   	leave  
    2ac9:	c3                   	ret    

00002aca <rmdot>:

void
rmdot(void)
{
    2aca:	55                   	push   %ebp
    2acb:	89 e5                	mov    %esp,%ebp
    2acd:	83 ec 08             	sub    $0x8,%esp
  printf(1, "rmdot test\n");
    2ad0:	83 ec 08             	sub    $0x8,%esp
    2ad3:	68 0e 55 00 00       	push   $0x550e
    2ad8:	6a 01                	push   $0x1
    2ada:	e8 22 15 00 00       	call   4001 <printf>
    2adf:	83 c4 10             	add    $0x10,%esp
  if(mkdir("dots") != 0){
    2ae2:	83 ec 0c             	sub    $0xc,%esp
    2ae5:	68 1a 55 00 00       	push   $0x551a
    2aea:	e8 08 14 00 00       	call   3ef7 <mkdir>
    2aef:	83 c4 10             	add    $0x10,%esp
    2af2:	85 c0                	test   %eax,%eax
    2af4:	74 17                	je     2b0d <rmdot+0x43>
    printf(1, "mkdir dots failed\n");
    2af6:	83 ec 08             	sub    $0x8,%esp
    2af9:	68 1f 55 00 00       	push   $0x551f
    2afe:	6a 01                	push   $0x1
    2b00:	e8 fc 14 00 00       	call   4001 <printf>
    2b05:	83 c4 10             	add    $0x10,%esp
    exit();
    2b08:	e8 82 13 00 00       	call   3e8f <exit>
  }
  if(chdir("dots") != 0){
    2b0d:	83 ec 0c             	sub    $0xc,%esp
    2b10:	68 1a 55 00 00       	push   $0x551a
    2b15:	e8 e5 13 00 00       	call   3eff <chdir>
    2b1a:	83 c4 10             	add    $0x10,%esp
    2b1d:	85 c0                	test   %eax,%eax
    2b1f:	74 17                	je     2b38 <rmdot+0x6e>
    printf(1, "chdir dots failed\n");
    2b21:	83 ec 08             	sub    $0x8,%esp
    2b24:	68 32 55 00 00       	push   $0x5532
    2b29:	6a 01                	push   $0x1
    2b2b:	e8 d1 14 00 00       	call   4001 <printf>
    2b30:	83 c4 10             	add    $0x10,%esp
    exit();
    2b33:	e8 57 13 00 00       	call   3e8f <exit>
  }
  if(unlink(".") == 0){
    2b38:	83 ec 0c             	sub    $0xc,%esp
    2b3b:	68 4b 4c 00 00       	push   $0x4c4b
    2b40:	e8 9a 13 00 00       	call   3edf <unlink>
    2b45:	83 c4 10             	add    $0x10,%esp
    2b48:	85 c0                	test   %eax,%eax
    2b4a:	75 17                	jne    2b63 <rmdot+0x99>
    printf(1, "rm . worked!\n");
    2b4c:	83 ec 08             	sub    $0x8,%esp
    2b4f:	68 45 55 00 00       	push   $0x5545
    2b54:	6a 01                	push   $0x1
    2b56:	e8 a6 14 00 00       	call   4001 <printf>
    2b5b:	83 c4 10             	add    $0x10,%esp
    exit();
    2b5e:	e8 2c 13 00 00       	call   3e8f <exit>
  }
  if(unlink("..") == 0){
    2b63:	83 ec 0c             	sub    $0xc,%esp
    2b66:	68 ce 47 00 00       	push   $0x47ce
    2b6b:	e8 6f 13 00 00       	call   3edf <unlink>
    2b70:	83 c4 10             	add    $0x10,%esp
    2b73:	85 c0                	test   %eax,%eax
    2b75:	75 17                	jne    2b8e <rmdot+0xc4>
    printf(1, "rm .. worked!\n");
    2b77:	83 ec 08             	sub    $0x8,%esp
    2b7a:	68 53 55 00 00       	push   $0x5553
    2b7f:	6a 01                	push   $0x1
    2b81:	e8 7b 14 00 00       	call   4001 <printf>
    2b86:	83 c4 10             	add    $0x10,%esp
    exit();
    2b89:	e8 01 13 00 00       	call   3e8f <exit>
  }
  if(chdir("/") != 0){
    2b8e:	83 ec 0c             	sub    $0xc,%esp
    2b91:	68 22 44 00 00       	push   $0x4422
    2b96:	e8 64 13 00 00       	call   3eff <chdir>
    2b9b:	83 c4 10             	add    $0x10,%esp
    2b9e:	85 c0                	test   %eax,%eax
    2ba0:	74 17                	je     2bb9 <rmdot+0xef>
    printf(1, "chdir / failed\n");
    2ba2:	83 ec 08             	sub    $0x8,%esp
    2ba5:	68 24 44 00 00       	push   $0x4424
    2baa:	6a 01                	push   $0x1
    2bac:	e8 50 14 00 00       	call   4001 <printf>
    2bb1:	83 c4 10             	add    $0x10,%esp
    exit();
    2bb4:	e8 d6 12 00 00       	call   3e8f <exit>
  }
  if(unlink("dots/.") == 0){
    2bb9:	83 ec 0c             	sub    $0xc,%esp
    2bbc:	68 62 55 00 00       	push   $0x5562
    2bc1:	e8 19 13 00 00       	call   3edf <unlink>
    2bc6:	83 c4 10             	add    $0x10,%esp
    2bc9:	85 c0                	test   %eax,%eax
    2bcb:	75 17                	jne    2be4 <rmdot+0x11a>
    printf(1, "unlink dots/. worked!\n");
    2bcd:	83 ec 08             	sub    $0x8,%esp
    2bd0:	68 69 55 00 00       	push   $0x5569
    2bd5:	6a 01                	push   $0x1
    2bd7:	e8 25 14 00 00       	call   4001 <printf>
    2bdc:	83 c4 10             	add    $0x10,%esp
    exit();
    2bdf:	e8 ab 12 00 00       	call   3e8f <exit>
  }
  if(unlink("dots/..") == 0){
    2be4:	83 ec 0c             	sub    $0xc,%esp
    2be7:	68 80 55 00 00       	push   $0x5580
    2bec:	e8 ee 12 00 00       	call   3edf <unlink>
    2bf1:	83 c4 10             	add    $0x10,%esp
    2bf4:	85 c0                	test   %eax,%eax
    2bf6:	75 17                	jne    2c0f <rmdot+0x145>
    printf(1, "unlink dots/.. worked!\n");
    2bf8:	83 ec 08             	sub    $0x8,%esp
    2bfb:	68 88 55 00 00       	push   $0x5588
    2c00:	6a 01                	push   $0x1
    2c02:	e8 fa 13 00 00       	call   4001 <printf>
    2c07:	83 c4 10             	add    $0x10,%esp
    exit();
    2c0a:	e8 80 12 00 00       	call   3e8f <exit>
  }
  if(unlink("dots") != 0){
    2c0f:	83 ec 0c             	sub    $0xc,%esp
    2c12:	68 1a 55 00 00       	push   $0x551a
    2c17:	e8 c3 12 00 00       	call   3edf <unlink>
    2c1c:	83 c4 10             	add    $0x10,%esp
    2c1f:	85 c0                	test   %eax,%eax
    2c21:	74 17                	je     2c3a <rmdot+0x170>
    printf(1, "unlink dots failed!\n");
    2c23:	83 ec 08             	sub    $0x8,%esp
    2c26:	68 a0 55 00 00       	push   $0x55a0
    2c2b:	6a 01                	push   $0x1
    2c2d:	e8 cf 13 00 00       	call   4001 <printf>
    2c32:	83 c4 10             	add    $0x10,%esp
    exit();
    2c35:	e8 55 12 00 00       	call   3e8f <exit>
  }
  printf(1, "rmdot ok\n");
    2c3a:	83 ec 08             	sub    $0x8,%esp
    2c3d:	68 b5 55 00 00       	push   $0x55b5
    2c42:	6a 01                	push   $0x1
    2c44:	e8 b8 13 00 00       	call   4001 <printf>
    2c49:	83 c4 10             	add    $0x10,%esp
}
    2c4c:	c9                   	leave  
    2c4d:	c3                   	ret    

00002c4e <dirfile>:

void
dirfile(void)
{
    2c4e:	55                   	push   %ebp
    2c4f:	89 e5                	mov    %esp,%ebp
    2c51:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(1, "dir vs file\n");
    2c54:	83 ec 08             	sub    $0x8,%esp
    2c57:	68 bf 55 00 00       	push   $0x55bf
    2c5c:	6a 01                	push   $0x1
    2c5e:	e8 9e 13 00 00       	call   4001 <printf>
    2c63:	83 c4 10             	add    $0x10,%esp

  fd = open("dirfile", O_CREATE);
    2c66:	83 ec 08             	sub    $0x8,%esp
    2c69:	68 00 02 00 00       	push   $0x200
    2c6e:	68 cc 55 00 00       	push   $0x55cc
    2c73:	e8 57 12 00 00       	call   3ecf <open>
    2c78:	83 c4 10             	add    $0x10,%esp
    2c7b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2c7e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2c82:	79 17                	jns    2c9b <dirfile+0x4d>
    printf(1, "create dirfile failed\n");
    2c84:	83 ec 08             	sub    $0x8,%esp
    2c87:	68 d4 55 00 00       	push   $0x55d4
    2c8c:	6a 01                	push   $0x1
    2c8e:	e8 6e 13 00 00       	call   4001 <printf>
    2c93:	83 c4 10             	add    $0x10,%esp
    exit();
    2c96:	e8 f4 11 00 00       	call   3e8f <exit>
  }
  close(fd);
    2c9b:	83 ec 0c             	sub    $0xc,%esp
    2c9e:	ff 75 f4             	pushl  -0xc(%ebp)
    2ca1:	e8 11 12 00 00       	call   3eb7 <close>
    2ca6:	83 c4 10             	add    $0x10,%esp
  if(chdir("dirfile") == 0){
    2ca9:	83 ec 0c             	sub    $0xc,%esp
    2cac:	68 cc 55 00 00       	push   $0x55cc
    2cb1:	e8 49 12 00 00       	call   3eff <chdir>
    2cb6:	83 c4 10             	add    $0x10,%esp
    2cb9:	85 c0                	test   %eax,%eax
    2cbb:	75 17                	jne    2cd4 <dirfile+0x86>
    printf(1, "chdir dirfile succeeded!\n");
    2cbd:	83 ec 08             	sub    $0x8,%esp
    2cc0:	68 eb 55 00 00       	push   $0x55eb
    2cc5:	6a 01                	push   $0x1
    2cc7:	e8 35 13 00 00       	call   4001 <printf>
    2ccc:	83 c4 10             	add    $0x10,%esp
    exit();
    2ccf:	e8 bb 11 00 00       	call   3e8f <exit>
  }
  fd = open("dirfile/xx", 0);
    2cd4:	83 ec 08             	sub    $0x8,%esp
    2cd7:	6a 00                	push   $0x0
    2cd9:	68 05 56 00 00       	push   $0x5605
    2cde:	e8 ec 11 00 00       	call   3ecf <open>
    2ce3:	83 c4 10             	add    $0x10,%esp
    2ce6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2ce9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2ced:	78 17                	js     2d06 <dirfile+0xb8>
    printf(1, "create dirfile/xx succeeded!\n");
    2cef:	83 ec 08             	sub    $0x8,%esp
    2cf2:	68 10 56 00 00       	push   $0x5610
    2cf7:	6a 01                	push   $0x1
    2cf9:	e8 03 13 00 00       	call   4001 <printf>
    2cfe:	83 c4 10             	add    $0x10,%esp
    exit();
    2d01:	e8 89 11 00 00       	call   3e8f <exit>
  }
  fd = open("dirfile/xx", O_CREATE);
    2d06:	83 ec 08             	sub    $0x8,%esp
    2d09:	68 00 02 00 00       	push   $0x200
    2d0e:	68 05 56 00 00       	push   $0x5605
    2d13:	e8 b7 11 00 00       	call   3ecf <open>
    2d18:	83 c4 10             	add    $0x10,%esp
    2d1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2d1e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2d22:	78 17                	js     2d3b <dirfile+0xed>
    printf(1, "create dirfile/xx succeeded!\n");
    2d24:	83 ec 08             	sub    $0x8,%esp
    2d27:	68 10 56 00 00       	push   $0x5610
    2d2c:	6a 01                	push   $0x1
    2d2e:	e8 ce 12 00 00       	call   4001 <printf>
    2d33:	83 c4 10             	add    $0x10,%esp
    exit();
    2d36:	e8 54 11 00 00       	call   3e8f <exit>
  }
  if(mkdir("dirfile/xx") == 0){
    2d3b:	83 ec 0c             	sub    $0xc,%esp
    2d3e:	68 05 56 00 00       	push   $0x5605
    2d43:	e8 af 11 00 00       	call   3ef7 <mkdir>
    2d48:	83 c4 10             	add    $0x10,%esp
    2d4b:	85 c0                	test   %eax,%eax
    2d4d:	75 17                	jne    2d66 <dirfile+0x118>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2d4f:	83 ec 08             	sub    $0x8,%esp
    2d52:	68 2e 56 00 00       	push   $0x562e
    2d57:	6a 01                	push   $0x1
    2d59:	e8 a3 12 00 00       	call   4001 <printf>
    2d5e:	83 c4 10             	add    $0x10,%esp
    exit();
    2d61:	e8 29 11 00 00       	call   3e8f <exit>
  }
  if(unlink("dirfile/xx") == 0){
    2d66:	83 ec 0c             	sub    $0xc,%esp
    2d69:	68 05 56 00 00       	push   $0x5605
    2d6e:	e8 6c 11 00 00       	call   3edf <unlink>
    2d73:	83 c4 10             	add    $0x10,%esp
    2d76:	85 c0                	test   %eax,%eax
    2d78:	75 17                	jne    2d91 <dirfile+0x143>
    printf(1, "unlink dirfile/xx succeeded!\n");
    2d7a:	83 ec 08             	sub    $0x8,%esp
    2d7d:	68 4b 56 00 00       	push   $0x564b
    2d82:	6a 01                	push   $0x1
    2d84:	e8 78 12 00 00       	call   4001 <printf>
    2d89:	83 c4 10             	add    $0x10,%esp
    exit();
    2d8c:	e8 fe 10 00 00       	call   3e8f <exit>
  }
  if(link("README", "dirfile/xx") == 0){
    2d91:	83 ec 08             	sub    $0x8,%esp
    2d94:	68 05 56 00 00       	push   $0x5605
    2d99:	68 69 56 00 00       	push   $0x5669
    2d9e:	e8 4c 11 00 00       	call   3eef <link>
    2da3:	83 c4 10             	add    $0x10,%esp
    2da6:	85 c0                	test   %eax,%eax
    2da8:	75 17                	jne    2dc1 <dirfile+0x173>
    printf(1, "link to dirfile/xx succeeded!\n");
    2daa:	83 ec 08             	sub    $0x8,%esp
    2dad:	68 70 56 00 00       	push   $0x5670
    2db2:	6a 01                	push   $0x1
    2db4:	e8 48 12 00 00       	call   4001 <printf>
    2db9:	83 c4 10             	add    $0x10,%esp
    exit();
    2dbc:	e8 ce 10 00 00       	call   3e8f <exit>
  }
  if(unlink("dirfile") != 0){
    2dc1:	83 ec 0c             	sub    $0xc,%esp
    2dc4:	68 cc 55 00 00       	push   $0x55cc
    2dc9:	e8 11 11 00 00       	call   3edf <unlink>
    2dce:	83 c4 10             	add    $0x10,%esp
    2dd1:	85 c0                	test   %eax,%eax
    2dd3:	74 17                	je     2dec <dirfile+0x19e>
    printf(1, "unlink dirfile failed!\n");
    2dd5:	83 ec 08             	sub    $0x8,%esp
    2dd8:	68 8f 56 00 00       	push   $0x568f
    2ddd:	6a 01                	push   $0x1
    2ddf:	e8 1d 12 00 00       	call   4001 <printf>
    2de4:	83 c4 10             	add    $0x10,%esp
    exit();
    2de7:	e8 a3 10 00 00       	call   3e8f <exit>
  }

  fd = open(".", O_RDWR);
    2dec:	83 ec 08             	sub    $0x8,%esp
    2def:	6a 02                	push   $0x2
    2df1:	68 4b 4c 00 00       	push   $0x4c4b
    2df6:	e8 d4 10 00 00       	call   3ecf <open>
    2dfb:	83 c4 10             	add    $0x10,%esp
    2dfe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2e01:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2e05:	78 17                	js     2e1e <dirfile+0x1d0>
    printf(1, "open . for writing succeeded!\n");
    2e07:	83 ec 08             	sub    $0x8,%esp
    2e0a:	68 a8 56 00 00       	push   $0x56a8
    2e0f:	6a 01                	push   $0x1
    2e11:	e8 eb 11 00 00       	call   4001 <printf>
    2e16:	83 c4 10             	add    $0x10,%esp
    exit();
    2e19:	e8 71 10 00 00       	call   3e8f <exit>
  }
  fd = open(".", 0);
    2e1e:	83 ec 08             	sub    $0x8,%esp
    2e21:	6a 00                	push   $0x0
    2e23:	68 4b 4c 00 00       	push   $0x4c4b
    2e28:	e8 a2 10 00 00       	call   3ecf <open>
    2e2d:	83 c4 10             	add    $0x10,%esp
    2e30:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(write(fd, "x", 1) > 0){
    2e33:	83 ec 04             	sub    $0x4,%esp
    2e36:	6a 01                	push   $0x1
    2e38:	68 87 48 00 00       	push   $0x4887
    2e3d:	ff 75 f4             	pushl  -0xc(%ebp)
    2e40:	e8 6a 10 00 00       	call   3eaf <write>
    2e45:	83 c4 10             	add    $0x10,%esp
    2e48:	85 c0                	test   %eax,%eax
    2e4a:	7e 17                	jle    2e63 <dirfile+0x215>
    printf(1, "write . succeeded!\n");
    2e4c:	83 ec 08             	sub    $0x8,%esp
    2e4f:	68 c7 56 00 00       	push   $0x56c7
    2e54:	6a 01                	push   $0x1
    2e56:	e8 a6 11 00 00       	call   4001 <printf>
    2e5b:	83 c4 10             	add    $0x10,%esp
    exit();
    2e5e:	e8 2c 10 00 00       	call   3e8f <exit>
  }
  close(fd);
    2e63:	83 ec 0c             	sub    $0xc,%esp
    2e66:	ff 75 f4             	pushl  -0xc(%ebp)
    2e69:	e8 49 10 00 00       	call   3eb7 <close>
    2e6e:	83 c4 10             	add    $0x10,%esp

  printf(1, "dir vs file OK\n");
    2e71:	83 ec 08             	sub    $0x8,%esp
    2e74:	68 db 56 00 00       	push   $0x56db
    2e79:	6a 01                	push   $0x1
    2e7b:	e8 81 11 00 00       	call   4001 <printf>
    2e80:	83 c4 10             	add    $0x10,%esp
}
    2e83:	c9                   	leave  
    2e84:	c3                   	ret    

00002e85 <iref>:

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2e85:	55                   	push   %ebp
    2e86:	89 e5                	mov    %esp,%ebp
    2e88:	83 ec 18             	sub    $0x18,%esp
  int i, fd;

  printf(1, "empty file name\n");
    2e8b:	83 ec 08             	sub    $0x8,%esp
    2e8e:	68 eb 56 00 00       	push   $0x56eb
    2e93:	6a 01                	push   $0x1
    2e95:	e8 67 11 00 00       	call   4001 <printf>
    2e9a:	83 c4 10             	add    $0x10,%esp

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2e9d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2ea4:	e9 e6 00 00 00       	jmp    2f8f <iref+0x10a>
    if(mkdir("irefd") != 0){
    2ea9:	83 ec 0c             	sub    $0xc,%esp
    2eac:	68 fc 56 00 00       	push   $0x56fc
    2eb1:	e8 41 10 00 00       	call   3ef7 <mkdir>
    2eb6:	83 c4 10             	add    $0x10,%esp
    2eb9:	85 c0                	test   %eax,%eax
    2ebb:	74 17                	je     2ed4 <iref+0x4f>
      printf(1, "mkdir irefd failed\n");
    2ebd:	83 ec 08             	sub    $0x8,%esp
    2ec0:	68 02 57 00 00       	push   $0x5702
    2ec5:	6a 01                	push   $0x1
    2ec7:	e8 35 11 00 00       	call   4001 <printf>
    2ecc:	83 c4 10             	add    $0x10,%esp
      exit();
    2ecf:	e8 bb 0f 00 00       	call   3e8f <exit>
    }
    if(chdir("irefd") != 0){
    2ed4:	83 ec 0c             	sub    $0xc,%esp
    2ed7:	68 fc 56 00 00       	push   $0x56fc
    2edc:	e8 1e 10 00 00       	call   3eff <chdir>
    2ee1:	83 c4 10             	add    $0x10,%esp
    2ee4:	85 c0                	test   %eax,%eax
    2ee6:	74 17                	je     2eff <iref+0x7a>
      printf(1, "chdir irefd failed\n");
    2ee8:	83 ec 08             	sub    $0x8,%esp
    2eeb:	68 16 57 00 00       	push   $0x5716
    2ef0:	6a 01                	push   $0x1
    2ef2:	e8 0a 11 00 00       	call   4001 <printf>
    2ef7:	83 c4 10             	add    $0x10,%esp
      exit();
    2efa:	e8 90 0f 00 00       	call   3e8f <exit>
    }

    mkdir("");
    2eff:	83 ec 0c             	sub    $0xc,%esp
    2f02:	68 2a 57 00 00       	push   $0x572a
    2f07:	e8 eb 0f 00 00       	call   3ef7 <mkdir>
    2f0c:	83 c4 10             	add    $0x10,%esp
    link("README", "");
    2f0f:	83 ec 08             	sub    $0x8,%esp
    2f12:	68 2a 57 00 00       	push   $0x572a
    2f17:	68 69 56 00 00       	push   $0x5669
    2f1c:	e8 ce 0f 00 00       	call   3eef <link>
    2f21:	83 c4 10             	add    $0x10,%esp
    fd = open("", O_CREATE);
    2f24:	83 ec 08             	sub    $0x8,%esp
    2f27:	68 00 02 00 00       	push   $0x200
    2f2c:	68 2a 57 00 00       	push   $0x572a
    2f31:	e8 99 0f 00 00       	call   3ecf <open>
    2f36:	83 c4 10             	add    $0x10,%esp
    2f39:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    2f3c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2f40:	78 0e                	js     2f50 <iref+0xcb>
      close(fd);
    2f42:	83 ec 0c             	sub    $0xc,%esp
    2f45:	ff 75 f0             	pushl  -0x10(%ebp)
    2f48:	e8 6a 0f 00 00       	call   3eb7 <close>
    2f4d:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    2f50:	83 ec 08             	sub    $0x8,%esp
    2f53:	68 00 02 00 00       	push   $0x200
    2f58:	68 2b 57 00 00       	push   $0x572b
    2f5d:	e8 6d 0f 00 00       	call   3ecf <open>
    2f62:	83 c4 10             	add    $0x10,%esp
    2f65:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    2f68:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2f6c:	78 0e                	js     2f7c <iref+0xf7>
      close(fd);
    2f6e:	83 ec 0c             	sub    $0xc,%esp
    2f71:	ff 75 f0             	pushl  -0x10(%ebp)
    2f74:	e8 3e 0f 00 00       	call   3eb7 <close>
    2f79:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    2f7c:	83 ec 0c             	sub    $0xc,%esp
    2f7f:	68 2b 57 00 00       	push   $0x572b
    2f84:	e8 56 0f 00 00       	call   3edf <unlink>
    2f89:	83 c4 10             	add    $0x10,%esp
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2f8c:	ff 45 f4             	incl   -0xc(%ebp)
    2f8f:	83 7d f4 32          	cmpl   $0x32,-0xc(%ebp)
    2f93:	0f 8e 10 ff ff ff    	jle    2ea9 <iref+0x24>
    if(fd >= 0)
      close(fd);
    unlink("xx");
  }

  chdir("/");
    2f99:	83 ec 0c             	sub    $0xc,%esp
    2f9c:	68 22 44 00 00       	push   $0x4422
    2fa1:	e8 59 0f 00 00       	call   3eff <chdir>
    2fa6:	83 c4 10             	add    $0x10,%esp
  printf(1, "empty file name OK\n");
    2fa9:	83 ec 08             	sub    $0x8,%esp
    2fac:	68 2e 57 00 00       	push   $0x572e
    2fb1:	6a 01                	push   $0x1
    2fb3:	e8 49 10 00 00       	call   4001 <printf>
    2fb8:	83 c4 10             	add    $0x10,%esp
}
    2fbb:	c9                   	leave  
    2fbc:	c3                   	ret    

00002fbd <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    2fbd:	55                   	push   %ebp
    2fbe:	89 e5                	mov    %esp,%ebp
    2fc0:	83 ec 18             	sub    $0x18,%esp
  int n, pid;

  printf(1, "fork test\n");
    2fc3:	83 ec 08             	sub    $0x8,%esp
    2fc6:	68 42 57 00 00       	push   $0x5742
    2fcb:	6a 01                	push   $0x1
    2fcd:	e8 2f 10 00 00       	call   4001 <printf>
    2fd2:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<1000; n++){
    2fd5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2fdc:	eb 1e                	jmp    2ffc <forktest+0x3f>
    pid = fork();
    2fde:	e8 a4 0e 00 00       	call   3e87 <fork>
    2fe3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0)
    2fe6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2fea:	79 02                	jns    2fee <forktest+0x31>
      break;
    2fec:	eb 17                	jmp    3005 <forktest+0x48>
    if(pid == 0)
    2fee:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2ff2:	75 05                	jne    2ff9 <forktest+0x3c>
      exit();
    2ff4:	e8 96 0e 00 00       	call   3e8f <exit>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
    2ff9:	ff 45 f4             	incl   -0xc(%ebp)
    2ffc:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
    3003:	7e d9                	jle    2fde <forktest+0x21>
      break;
    if(pid == 0)
      exit();
  }
  
  if(n == 1000){
    3005:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
    300c:	75 17                	jne    3025 <forktest+0x68>
    printf(1, "fork claimed to work 1000 times!\n");
    300e:	83 ec 08             	sub    $0x8,%esp
    3011:	68 50 57 00 00       	push   $0x5750
    3016:	6a 01                	push   $0x1
    3018:	e8 e4 0f 00 00       	call   4001 <printf>
    301d:	83 c4 10             	add    $0x10,%esp
    exit();
    3020:	e8 6a 0e 00 00       	call   3e8f <exit>
  }
  
  for(; n > 0; n--){
    3025:	eb 23                	jmp    304a <forktest+0x8d>
    if(wait() < 0){
    3027:	e8 6b 0e 00 00       	call   3e97 <wait>
    302c:	85 c0                	test   %eax,%eax
    302e:	79 17                	jns    3047 <forktest+0x8a>
      printf(1, "wait stopped early\n");
    3030:	83 ec 08             	sub    $0x8,%esp
    3033:	68 72 57 00 00       	push   $0x5772
    3038:	6a 01                	push   $0x1
    303a:	e8 c2 0f 00 00       	call   4001 <printf>
    303f:	83 c4 10             	add    $0x10,%esp
      exit();
    3042:	e8 48 0e 00 00       	call   3e8f <exit>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }
  
  for(; n > 0; n--){
    3047:	ff 4d f4             	decl   -0xc(%ebp)
    304a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    304e:	7f d7                	jg     3027 <forktest+0x6a>
      printf(1, "wait stopped early\n");
      exit();
    }
  }
  
  if(wait() != -1){
    3050:	e8 42 0e 00 00       	call   3e97 <wait>
    3055:	83 f8 ff             	cmp    $0xffffffff,%eax
    3058:	74 17                	je     3071 <forktest+0xb4>
    printf(1, "wait got too many\n");
    305a:	83 ec 08             	sub    $0x8,%esp
    305d:	68 86 57 00 00       	push   $0x5786
    3062:	6a 01                	push   $0x1
    3064:	e8 98 0f 00 00       	call   4001 <printf>
    3069:	83 c4 10             	add    $0x10,%esp
    exit();
    306c:	e8 1e 0e 00 00       	call   3e8f <exit>
  }
  
  printf(1, "fork test OK\n");
    3071:	83 ec 08             	sub    $0x8,%esp
    3074:	68 99 57 00 00       	push   $0x5799
    3079:	6a 01                	push   $0x1
    307b:	e8 81 0f 00 00       	call   4001 <printf>
    3080:	83 c4 10             	add    $0x10,%esp
}
    3083:	c9                   	leave  
    3084:	c3                   	ret    

00003085 <sbrktest>:

void
sbrktest(void)
{
    3085:	55                   	push   %ebp
    3086:	89 e5                	mov    %esp,%ebp
    3088:	53                   	push   %ebx
    3089:	83 ec 64             	sub    $0x64,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    308c:	a1 8c 62 00 00       	mov    0x628c,%eax
    3091:	83 ec 08             	sub    $0x8,%esp
    3094:	68 a7 57 00 00       	push   $0x57a7
    3099:	50                   	push   %eax
    309a:	e8 62 0f 00 00       	call   4001 <printf>
    309f:	83 c4 10             	add    $0x10,%esp
  oldbrk = sbrk(0);
    30a2:	83 ec 0c             	sub    $0xc,%esp
    30a5:	6a 00                	push   $0x0
    30a7:	e8 6b 0e 00 00       	call   3f17 <sbrk>
    30ac:	83 c4 10             	add    $0x10,%esp
    30af:	89 45 ec             	mov    %eax,-0x14(%ebp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    30b2:	83 ec 0c             	sub    $0xc,%esp
    30b5:	6a 00                	push   $0x0
    30b7:	e8 5b 0e 00 00       	call   3f17 <sbrk>
    30bc:	83 c4 10             	add    $0x10,%esp
    30bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int i;
  for(i = 0; i < 5000; i++){ 
    30c2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    30c9:	eb 4c                	jmp    3117 <sbrktest+0x92>
    b = sbrk(1);
    30cb:	83 ec 0c             	sub    $0xc,%esp
    30ce:	6a 01                	push   $0x1
    30d0:	e8 42 0e 00 00       	call   3f17 <sbrk>
    30d5:	83 c4 10             	add    $0x10,%esp
    30d8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(b != a){
    30db:	8b 45 e8             	mov    -0x18(%ebp),%eax
    30de:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    30e1:	74 24                	je     3107 <sbrktest+0x82>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    30e3:	a1 8c 62 00 00       	mov    0x628c,%eax
    30e8:	83 ec 0c             	sub    $0xc,%esp
    30eb:	ff 75 e8             	pushl  -0x18(%ebp)
    30ee:	ff 75 f4             	pushl  -0xc(%ebp)
    30f1:	ff 75 f0             	pushl  -0x10(%ebp)
    30f4:	68 b2 57 00 00       	push   $0x57b2
    30f9:	50                   	push   %eax
    30fa:	e8 02 0f 00 00       	call   4001 <printf>
    30ff:	83 c4 20             	add    $0x20,%esp
      exit();
    3102:	e8 88 0d 00 00       	call   3e8f <exit>
    }
    *b = 1;
    3107:	8b 45 e8             	mov    -0x18(%ebp),%eax
    310a:	c6 00 01             	movb   $0x1,(%eax)
    a = b + 1;
    310d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3110:	40                   	inc    %eax
    3111:	89 45 f4             	mov    %eax,-0xc(%ebp)
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){ 
    3114:	ff 45 f0             	incl   -0x10(%ebp)
    3117:	81 7d f0 87 13 00 00 	cmpl   $0x1387,-0x10(%ebp)
    311e:	7e ab                	jle    30cb <sbrktest+0x46>
      exit();
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
    3120:	e8 62 0d 00 00       	call   3e87 <fork>
    3125:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    3128:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    312c:	79 1b                	jns    3149 <sbrktest+0xc4>
    printf(stdout, "sbrk test fork failed\n");
    312e:	a1 8c 62 00 00       	mov    0x628c,%eax
    3133:	83 ec 08             	sub    $0x8,%esp
    3136:	68 cd 57 00 00       	push   $0x57cd
    313b:	50                   	push   %eax
    313c:	e8 c0 0e 00 00       	call   4001 <printf>
    3141:	83 c4 10             	add    $0x10,%esp
    exit();
    3144:	e8 46 0d 00 00       	call   3e8f <exit>
  }
  c = sbrk(1);
    3149:	83 ec 0c             	sub    $0xc,%esp
    314c:	6a 01                	push   $0x1
    314e:	e8 c4 0d 00 00       	call   3f17 <sbrk>
    3153:	83 c4 10             	add    $0x10,%esp
    3156:	89 45 e0             	mov    %eax,-0x20(%ebp)
  c = sbrk(1);
    3159:	83 ec 0c             	sub    $0xc,%esp
    315c:	6a 01                	push   $0x1
    315e:	e8 b4 0d 00 00       	call   3f17 <sbrk>
    3163:	83 c4 10             	add    $0x10,%esp
    3166:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a + 1){
    3169:	8b 45 f4             	mov    -0xc(%ebp),%eax
    316c:	40                   	inc    %eax
    316d:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    3170:	74 1b                	je     318d <sbrktest+0x108>
    printf(stdout, "sbrk test failed post-fork\n");
    3172:	a1 8c 62 00 00       	mov    0x628c,%eax
    3177:	83 ec 08             	sub    $0x8,%esp
    317a:	68 e4 57 00 00       	push   $0x57e4
    317f:	50                   	push   %eax
    3180:	e8 7c 0e 00 00       	call   4001 <printf>
    3185:	83 c4 10             	add    $0x10,%esp
    exit();
    3188:	e8 02 0d 00 00       	call   3e8f <exit>
  }
  if(pid == 0)
    318d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    3191:	75 05                	jne    3198 <sbrktest+0x113>
    exit();
    3193:	e8 f7 0c 00 00       	call   3e8f <exit>
  wait();
    3198:	e8 fa 0c 00 00       	call   3e97 <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    319d:	83 ec 0c             	sub    $0xc,%esp
    31a0:	6a 00                	push   $0x0
    31a2:	e8 70 0d 00 00       	call   3f17 <sbrk>
    31a7:	83 c4 10             	add    $0x10,%esp
    31aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  amt = (BIG) - (uint)a;
    31ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    31b0:	ba 00 00 40 06       	mov    $0x6400000,%edx
    31b5:	29 c2                	sub    %eax,%edx
    31b7:	89 d0                	mov    %edx,%eax
    31b9:	89 45 dc             	mov    %eax,-0x24(%ebp)
  p = sbrk(amt);
    31bc:	8b 45 dc             	mov    -0x24(%ebp),%eax
    31bf:	83 ec 0c             	sub    $0xc,%esp
    31c2:	50                   	push   %eax
    31c3:	e8 4f 0d 00 00       	call   3f17 <sbrk>
    31c8:	83 c4 10             	add    $0x10,%esp
    31cb:	89 45 d8             	mov    %eax,-0x28(%ebp)
  if (p != a) { 
    31ce:	8b 45 d8             	mov    -0x28(%ebp),%eax
    31d1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    31d4:	74 1b                	je     31f1 <sbrktest+0x16c>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    31d6:	a1 8c 62 00 00       	mov    0x628c,%eax
    31db:	83 ec 08             	sub    $0x8,%esp
    31de:	68 00 58 00 00       	push   $0x5800
    31e3:	50                   	push   %eax
    31e4:	e8 18 0e 00 00       	call   4001 <printf>
    31e9:	83 c4 10             	add    $0x10,%esp
    exit();
    31ec:	e8 9e 0c 00 00       	call   3e8f <exit>
  }
  lastaddr = (char*) (BIG-1);
    31f1:	c7 45 d4 ff ff 3f 06 	movl   $0x63fffff,-0x2c(%ebp)
  *lastaddr = 99;
    31f8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    31fb:	c6 00 63             	movb   $0x63,(%eax)

  // can one de-allocate?
  a = sbrk(0);
    31fe:	83 ec 0c             	sub    $0xc,%esp
    3201:	6a 00                	push   $0x0
    3203:	e8 0f 0d 00 00       	call   3f17 <sbrk>
    3208:	83 c4 10             	add    $0x10,%esp
    320b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-4096);
    320e:	83 ec 0c             	sub    $0xc,%esp
    3211:	68 00 f0 ff ff       	push   $0xfffff000
    3216:	e8 fc 0c 00 00       	call   3f17 <sbrk>
    321b:	83 c4 10             	add    $0x10,%esp
    321e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c == (char*)0xffffffff){
    3221:	83 7d e0 ff          	cmpl   $0xffffffff,-0x20(%ebp)
    3225:	75 1b                	jne    3242 <sbrktest+0x1bd>
    printf(stdout, "sbrk could not deallocate\n");
    3227:	a1 8c 62 00 00       	mov    0x628c,%eax
    322c:	83 ec 08             	sub    $0x8,%esp
    322f:	68 3e 58 00 00       	push   $0x583e
    3234:	50                   	push   %eax
    3235:	e8 c7 0d 00 00       	call   4001 <printf>
    323a:	83 c4 10             	add    $0x10,%esp
    exit();
    323d:	e8 4d 0c 00 00       	call   3e8f <exit>
  }
  c = sbrk(0);
    3242:	83 ec 0c             	sub    $0xc,%esp
    3245:	6a 00                	push   $0x0
    3247:	e8 cb 0c 00 00       	call   3f17 <sbrk>
    324c:	83 c4 10             	add    $0x10,%esp
    324f:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a - 4096){
    3252:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3255:	2d 00 10 00 00       	sub    $0x1000,%eax
    325a:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    325d:	74 1e                	je     327d <sbrktest+0x1f8>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    325f:	a1 8c 62 00 00       	mov    0x628c,%eax
    3264:	ff 75 e0             	pushl  -0x20(%ebp)
    3267:	ff 75 f4             	pushl  -0xc(%ebp)
    326a:	68 5c 58 00 00       	push   $0x585c
    326f:	50                   	push   %eax
    3270:	e8 8c 0d 00 00       	call   4001 <printf>
    3275:	83 c4 10             	add    $0x10,%esp
    exit();
    3278:	e8 12 0c 00 00       	call   3e8f <exit>
  }

  // can one re-allocate that page?
  a = sbrk(0);
    327d:	83 ec 0c             	sub    $0xc,%esp
    3280:	6a 00                	push   $0x0
    3282:	e8 90 0c 00 00       	call   3f17 <sbrk>
    3287:	83 c4 10             	add    $0x10,%esp
    328a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(4096);
    328d:	83 ec 0c             	sub    $0xc,%esp
    3290:	68 00 10 00 00       	push   $0x1000
    3295:	e8 7d 0c 00 00       	call   3f17 <sbrk>
    329a:	83 c4 10             	add    $0x10,%esp
    329d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a || sbrk(0) != a + 4096){
    32a0:	8b 45 e0             	mov    -0x20(%ebp),%eax
    32a3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    32a6:	75 1a                	jne    32c2 <sbrktest+0x23d>
    32a8:	83 ec 0c             	sub    $0xc,%esp
    32ab:	6a 00                	push   $0x0
    32ad:	e8 65 0c 00 00       	call   3f17 <sbrk>
    32b2:	83 c4 10             	add    $0x10,%esp
    32b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
    32b8:	81 c2 00 10 00 00    	add    $0x1000,%edx
    32be:	39 d0                	cmp    %edx,%eax
    32c0:	74 1e                	je     32e0 <sbrktest+0x25b>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    32c2:	a1 8c 62 00 00       	mov    0x628c,%eax
    32c7:	ff 75 e0             	pushl  -0x20(%ebp)
    32ca:	ff 75 f4             	pushl  -0xc(%ebp)
    32cd:	68 94 58 00 00       	push   $0x5894
    32d2:	50                   	push   %eax
    32d3:	e8 29 0d 00 00       	call   4001 <printf>
    32d8:	83 c4 10             	add    $0x10,%esp
    exit();
    32db:	e8 af 0b 00 00       	call   3e8f <exit>
  }
  if(*lastaddr == 99){
    32e0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    32e3:	8a 00                	mov    (%eax),%al
    32e5:	3c 63                	cmp    $0x63,%al
    32e7:	75 1b                	jne    3304 <sbrktest+0x27f>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    32e9:	a1 8c 62 00 00       	mov    0x628c,%eax
    32ee:	83 ec 08             	sub    $0x8,%esp
    32f1:	68 bc 58 00 00       	push   $0x58bc
    32f6:	50                   	push   %eax
    32f7:	e8 05 0d 00 00       	call   4001 <printf>
    32fc:	83 c4 10             	add    $0x10,%esp
    exit();
    32ff:	e8 8b 0b 00 00       	call   3e8f <exit>
  }

  a = sbrk(0);
    3304:	83 ec 0c             	sub    $0xc,%esp
    3307:	6a 00                	push   $0x0
    3309:	e8 09 0c 00 00       	call   3f17 <sbrk>
    330e:	83 c4 10             	add    $0x10,%esp
    3311:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-(sbrk(0) - oldbrk));
    3314:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    3317:	83 ec 0c             	sub    $0xc,%esp
    331a:	6a 00                	push   $0x0
    331c:	e8 f6 0b 00 00       	call   3f17 <sbrk>
    3321:	83 c4 10             	add    $0x10,%esp
    3324:	29 c3                	sub    %eax,%ebx
    3326:	89 d8                	mov    %ebx,%eax
    3328:	83 ec 0c             	sub    $0xc,%esp
    332b:	50                   	push   %eax
    332c:	e8 e6 0b 00 00       	call   3f17 <sbrk>
    3331:	83 c4 10             	add    $0x10,%esp
    3334:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a){
    3337:	8b 45 e0             	mov    -0x20(%ebp),%eax
    333a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    333d:	74 1e                	je     335d <sbrktest+0x2d8>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    333f:	a1 8c 62 00 00       	mov    0x628c,%eax
    3344:	ff 75 e0             	pushl  -0x20(%ebp)
    3347:	ff 75 f4             	pushl  -0xc(%ebp)
    334a:	68 ec 58 00 00       	push   $0x58ec
    334f:	50                   	push   %eax
    3350:	e8 ac 0c 00 00       	call   4001 <printf>
    3355:	83 c4 10             	add    $0x10,%esp
    exit();
    3358:	e8 32 0b 00 00       	call   3e8f <exit>
  }
  
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    335d:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
    3364:	eb 75                	jmp    33db <sbrktest+0x356>
    ppid = getpid();
    3366:	e8 a4 0b 00 00       	call   3f0f <getpid>
    336b:	89 45 d0             	mov    %eax,-0x30(%ebp)
    pid = fork();
    336e:	e8 14 0b 00 00       	call   3e87 <fork>
    3373:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(pid < 0){
    3376:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    337a:	79 1b                	jns    3397 <sbrktest+0x312>
      printf(stdout, "fork failed\n");
    337c:	a1 8c 62 00 00       	mov    0x628c,%eax
    3381:	83 ec 08             	sub    $0x8,%esp
    3384:	68 51 44 00 00       	push   $0x4451
    3389:	50                   	push   %eax
    338a:	e8 72 0c 00 00       	call   4001 <printf>
    338f:	83 c4 10             	add    $0x10,%esp
      exit();
    3392:	e8 f8 0a 00 00       	call   3e8f <exit>
    }
    if(pid == 0){
    3397:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    339b:	75 32                	jne    33cf <sbrktest+0x34a>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    339d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    33a0:	8a 00                	mov    (%eax),%al
    33a2:	0f be d0             	movsbl %al,%edx
    33a5:	a1 8c 62 00 00       	mov    0x628c,%eax
    33aa:	52                   	push   %edx
    33ab:	ff 75 f4             	pushl  -0xc(%ebp)
    33ae:	68 0d 59 00 00       	push   $0x590d
    33b3:	50                   	push   %eax
    33b4:	e8 48 0c 00 00       	call   4001 <printf>
    33b9:	83 c4 10             	add    $0x10,%esp
      kill(ppid);
    33bc:	83 ec 0c             	sub    $0xc,%esp
    33bf:	ff 75 d0             	pushl  -0x30(%ebp)
    33c2:	e8 f8 0a 00 00       	call   3ebf <kill>
    33c7:	83 c4 10             	add    $0x10,%esp
      exit();
    33ca:	e8 c0 0a 00 00       	call   3e8f <exit>
    }
    wait();
    33cf:	e8 c3 0a 00 00       	call   3e97 <wait>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit();
  }
  
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    33d4:	81 45 f4 50 c3 00 00 	addl   $0xc350,-0xc(%ebp)
    33db:	81 7d f4 7f 84 1e 80 	cmpl   $0x801e847f,-0xc(%ebp)
    33e2:	76 82                	jbe    3366 <sbrktest+0x2e1>
    wait();
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    33e4:	83 ec 0c             	sub    $0xc,%esp
    33e7:	8d 45 c8             	lea    -0x38(%ebp),%eax
    33ea:	50                   	push   %eax
    33eb:	e8 af 0a 00 00       	call   3e9f <pipe>
    33f0:	83 c4 10             	add    $0x10,%esp
    33f3:	85 c0                	test   %eax,%eax
    33f5:	74 17                	je     340e <sbrktest+0x389>
    printf(1, "pipe() failed\n");
    33f7:	83 ec 08             	sub    $0x8,%esp
    33fa:	68 22 48 00 00       	push   $0x4822
    33ff:	6a 01                	push   $0x1
    3401:	e8 fb 0b 00 00       	call   4001 <printf>
    3406:	83 c4 10             	add    $0x10,%esp
    exit();
    3409:	e8 81 0a 00 00       	call   3e8f <exit>
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    340e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3415:	e9 85 00 00 00       	jmp    349f <sbrktest+0x41a>
    if((pids[i] = fork()) == 0){
    341a:	e8 68 0a 00 00       	call   3e87 <fork>
    341f:	8b 55 f0             	mov    -0x10(%ebp),%edx
    3422:	89 44 95 a0          	mov    %eax,-0x60(%ebp,%edx,4)
    3426:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3429:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    342d:	85 c0                	test   %eax,%eax
    342f:	75 4a                	jne    347b <sbrktest+0x3f6>
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    3431:	83 ec 0c             	sub    $0xc,%esp
    3434:	6a 00                	push   $0x0
    3436:	e8 dc 0a 00 00       	call   3f17 <sbrk>
    343b:	83 c4 10             	add    $0x10,%esp
    343e:	ba 00 00 40 06       	mov    $0x6400000,%edx
    3443:	29 c2                	sub    %eax,%edx
    3445:	89 d0                	mov    %edx,%eax
    3447:	83 ec 0c             	sub    $0xc,%esp
    344a:	50                   	push   %eax
    344b:	e8 c7 0a 00 00       	call   3f17 <sbrk>
    3450:	83 c4 10             	add    $0x10,%esp
      write(fds[1], "x", 1);
    3453:	8b 45 cc             	mov    -0x34(%ebp),%eax
    3456:	83 ec 04             	sub    $0x4,%esp
    3459:	6a 01                	push   $0x1
    345b:	68 87 48 00 00       	push   $0x4887
    3460:	50                   	push   %eax
    3461:	e8 49 0a 00 00       	call   3eaf <write>
    3466:	83 c4 10             	add    $0x10,%esp
      // sit around until killed
      for(;;) sleep(1000);
    3469:	83 ec 0c             	sub    $0xc,%esp
    346c:	68 e8 03 00 00       	push   $0x3e8
    3471:	e8 a9 0a 00 00       	call   3f1f <sleep>
    3476:	83 c4 10             	add    $0x10,%esp
    3479:	eb ee                	jmp    3469 <sbrktest+0x3e4>
    }
    if(pids[i] != -1)
    347b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    347e:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    3482:	83 f8 ff             	cmp    $0xffffffff,%eax
    3485:	74 15                	je     349c <sbrktest+0x417>
      read(fds[0], &scratch, 1);
    3487:	8b 45 c8             	mov    -0x38(%ebp),%eax
    348a:	83 ec 04             	sub    $0x4,%esp
    348d:	6a 01                	push   $0x1
    348f:	8d 55 9f             	lea    -0x61(%ebp),%edx
    3492:	52                   	push   %edx
    3493:	50                   	push   %eax
    3494:	e8 0e 0a 00 00       	call   3ea7 <read>
    3499:	83 c4 10             	add    $0x10,%esp
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    349c:	ff 45 f0             	incl   -0x10(%ebp)
    349f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    34a2:	83 f8 09             	cmp    $0x9,%eax
    34a5:	0f 86 6f ff ff ff    	jbe    341a <sbrktest+0x395>
    if(pids[i] != -1)
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    34ab:	83 ec 0c             	sub    $0xc,%esp
    34ae:	68 00 10 00 00       	push   $0x1000
    34b3:	e8 5f 0a 00 00       	call   3f17 <sbrk>
    34b8:	83 c4 10             	add    $0x10,%esp
    34bb:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    34be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    34c5:	eb 29                	jmp    34f0 <sbrktest+0x46b>
    if(pids[i] == -1)
    34c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    34ca:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    34ce:	83 f8 ff             	cmp    $0xffffffff,%eax
    34d1:	75 02                	jne    34d5 <sbrktest+0x450>
      continue;
    34d3:	eb 18                	jmp    34ed <sbrktest+0x468>
    kill(pids[i]);
    34d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    34d8:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    34dc:	83 ec 0c             	sub    $0xc,%esp
    34df:	50                   	push   %eax
    34e0:	e8 da 09 00 00       	call   3ebf <kill>
    34e5:	83 c4 10             	add    $0x10,%esp
    wait();
    34e8:	e8 aa 09 00 00       	call   3e97 <wait>
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    34ed:	ff 45 f0             	incl   -0x10(%ebp)
    34f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    34f3:	83 f8 09             	cmp    $0x9,%eax
    34f6:	76 cf                	jbe    34c7 <sbrktest+0x442>
    if(pids[i] == -1)
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff){
    34f8:	83 7d e0 ff          	cmpl   $0xffffffff,-0x20(%ebp)
    34fc:	75 1b                	jne    3519 <sbrktest+0x494>
    printf(stdout, "failed sbrk leaked memory\n");
    34fe:	a1 8c 62 00 00       	mov    0x628c,%eax
    3503:	83 ec 08             	sub    $0x8,%esp
    3506:	68 26 59 00 00       	push   $0x5926
    350b:	50                   	push   %eax
    350c:	e8 f0 0a 00 00       	call   4001 <printf>
    3511:	83 c4 10             	add    $0x10,%esp
    exit();
    3514:	e8 76 09 00 00       	call   3e8f <exit>
  }

  if(sbrk(0) > oldbrk)
    3519:	83 ec 0c             	sub    $0xc,%esp
    351c:	6a 00                	push   $0x0
    351e:	e8 f4 09 00 00       	call   3f17 <sbrk>
    3523:	83 c4 10             	add    $0x10,%esp
    3526:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    3529:	76 20                	jbe    354b <sbrktest+0x4c6>
    sbrk(-(sbrk(0) - oldbrk));
    352b:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    352e:	83 ec 0c             	sub    $0xc,%esp
    3531:	6a 00                	push   $0x0
    3533:	e8 df 09 00 00       	call   3f17 <sbrk>
    3538:	83 c4 10             	add    $0x10,%esp
    353b:	29 c3                	sub    %eax,%ebx
    353d:	89 d8                	mov    %ebx,%eax
    353f:	83 ec 0c             	sub    $0xc,%esp
    3542:	50                   	push   %eax
    3543:	e8 cf 09 00 00       	call   3f17 <sbrk>
    3548:	83 c4 10             	add    $0x10,%esp

  printf(stdout, "sbrk test OK\n");
    354b:	a1 8c 62 00 00       	mov    0x628c,%eax
    3550:	83 ec 08             	sub    $0x8,%esp
    3553:	68 41 59 00 00       	push   $0x5941
    3558:	50                   	push   %eax
    3559:	e8 a3 0a 00 00       	call   4001 <printf>
    355e:	83 c4 10             	add    $0x10,%esp
}
    3561:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3564:	c9                   	leave  
    3565:	c3                   	ret    

00003566 <validateint>:

void
validateint(int *p)
{
    3566:	55                   	push   %ebp
    3567:	89 e5                	mov    %esp,%ebp
    3569:	53                   	push   %ebx
    356a:	83 ec 10             	sub    $0x10,%esp
  int res;
  asm("mov %%esp, %%ebx\n\t"
    356d:	b8 0d 00 00 00       	mov    $0xd,%eax
    3572:	8b 55 08             	mov    0x8(%ebp),%edx
    3575:	89 d1                	mov    %edx,%ecx
    3577:	89 e3                	mov    %esp,%ebx
    3579:	89 cc                	mov    %ecx,%esp
    357b:	cd 40                	int    $0x40
    357d:	89 dc                	mov    %ebx,%esp
    357f:	89 45 f8             	mov    %eax,-0x8(%ebp)
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    3582:	83 c4 10             	add    $0x10,%esp
    3585:	5b                   	pop    %ebx
    3586:	5d                   	pop    %ebp
    3587:	c3                   	ret    

00003588 <validatetest>:

void
validatetest(void)
{
    3588:	55                   	push   %ebp
    3589:	89 e5                	mov    %esp,%ebp
    358b:	83 ec 18             	sub    $0x18,%esp
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    358e:	a1 8c 62 00 00       	mov    0x628c,%eax
    3593:	83 ec 08             	sub    $0x8,%esp
    3596:	68 4f 59 00 00       	push   $0x594f
    359b:	50                   	push   %eax
    359c:	e8 60 0a 00 00       	call   4001 <printf>
    35a1:	83 c4 10             	add    $0x10,%esp
  hi = 1100*1024;
    35a4:	c7 45 f0 00 30 11 00 	movl   $0x113000,-0x10(%ebp)

  for(p = 0; p <= (uint)hi; p += 4096){
    35ab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    35b2:	e9 8a 00 00 00       	jmp    3641 <validatetest+0xb9>
    if((pid = fork()) == 0){
    35b7:	e8 cb 08 00 00       	call   3e87 <fork>
    35bc:	89 45 ec             	mov    %eax,-0x14(%ebp)
    35bf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    35c3:	75 14                	jne    35d9 <validatetest+0x51>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
    35c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    35c8:	83 ec 0c             	sub    $0xc,%esp
    35cb:	50                   	push   %eax
    35cc:	e8 95 ff ff ff       	call   3566 <validateint>
    35d1:	83 c4 10             	add    $0x10,%esp
      exit();
    35d4:	e8 b6 08 00 00       	call   3e8f <exit>
    }
    sleep(0);
    35d9:	83 ec 0c             	sub    $0xc,%esp
    35dc:	6a 00                	push   $0x0
    35de:	e8 3c 09 00 00       	call   3f1f <sleep>
    35e3:	83 c4 10             	add    $0x10,%esp
    sleep(0);
    35e6:	83 ec 0c             	sub    $0xc,%esp
    35e9:	6a 00                	push   $0x0
    35eb:	e8 2f 09 00 00       	call   3f1f <sleep>
    35f0:	83 c4 10             	add    $0x10,%esp
    kill(pid);
    35f3:	83 ec 0c             	sub    $0xc,%esp
    35f6:	ff 75 ec             	pushl  -0x14(%ebp)
    35f9:	e8 c1 08 00 00       	call   3ebf <kill>
    35fe:	83 c4 10             	add    $0x10,%esp
    wait();
    3601:	e8 91 08 00 00       	call   3e97 <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    3606:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3609:	83 ec 08             	sub    $0x8,%esp
    360c:	50                   	push   %eax
    360d:	68 5e 59 00 00       	push   $0x595e
    3612:	e8 d8 08 00 00       	call   3eef <link>
    3617:	83 c4 10             	add    $0x10,%esp
    361a:	83 f8 ff             	cmp    $0xffffffff,%eax
    361d:	74 1b                	je     363a <validatetest+0xb2>
      printf(stdout, "link should not succeed\n");
    361f:	a1 8c 62 00 00       	mov    0x628c,%eax
    3624:	83 ec 08             	sub    $0x8,%esp
    3627:	68 69 59 00 00       	push   $0x5969
    362c:	50                   	push   %eax
    362d:	e8 cf 09 00 00       	call   4001 <printf>
    3632:	83 c4 10             	add    $0x10,%esp
      exit();
    3635:	e8 55 08 00 00       	call   3e8f <exit>
  uint p;

  printf(stdout, "validate test\n");
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    363a:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    3641:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3644:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    3647:	0f 83 6a ff ff ff    	jae    35b7 <validatetest+0x2f>
      printf(stdout, "link should not succeed\n");
      exit();
    }
  }

  printf(stdout, "validate ok\n");
    364d:	a1 8c 62 00 00       	mov    0x628c,%eax
    3652:	83 ec 08             	sub    $0x8,%esp
    3655:	68 82 59 00 00       	push   $0x5982
    365a:	50                   	push   %eax
    365b:	e8 a1 09 00 00       	call   4001 <printf>
    3660:	83 c4 10             	add    $0x10,%esp
}
    3663:	c9                   	leave  
    3664:	c3                   	ret    

00003665 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    3665:	55                   	push   %ebp
    3666:	89 e5                	mov    %esp,%ebp
    3668:	83 ec 18             	sub    $0x18,%esp
  int i;

  printf(stdout, "bss test\n");
    366b:	a1 8c 62 00 00       	mov    0x628c,%eax
    3670:	83 ec 08             	sub    $0x8,%esp
    3673:	68 8f 59 00 00       	push   $0x598f
    3678:	50                   	push   %eax
    3679:	e8 83 09 00 00       	call   4001 <printf>
    367e:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(uninit); i++){
    3681:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3688:	eb 2c                	jmp    36b6 <bsstest+0x51>
    if(uninit[i] != '\0'){
    368a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    368d:	05 60 63 00 00       	add    $0x6360,%eax
    3692:	8a 00                	mov    (%eax),%al
    3694:	84 c0                	test   %al,%al
    3696:	74 1b                	je     36b3 <bsstest+0x4e>
      printf(stdout, "bss test failed\n");
    3698:	a1 8c 62 00 00       	mov    0x628c,%eax
    369d:	83 ec 08             	sub    $0x8,%esp
    36a0:	68 99 59 00 00       	push   $0x5999
    36a5:	50                   	push   %eax
    36a6:	e8 56 09 00 00       	call   4001 <printf>
    36ab:	83 c4 10             	add    $0x10,%esp
      exit();
    36ae:	e8 dc 07 00 00       	call   3e8f <exit>
bsstest(void)
{
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    36b3:	ff 45 f4             	incl   -0xc(%ebp)
    36b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    36b9:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    36be:	76 ca                	jbe    368a <bsstest+0x25>
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
      exit();
    }
  }
  printf(stdout, "bss test ok\n");
    36c0:	a1 8c 62 00 00       	mov    0x628c,%eax
    36c5:	83 ec 08             	sub    $0x8,%esp
    36c8:	68 aa 59 00 00       	push   $0x59aa
    36cd:	50                   	push   %eax
    36ce:	e8 2e 09 00 00       	call   4001 <printf>
    36d3:	83 c4 10             	add    $0x10,%esp
}
    36d6:	c9                   	leave  
    36d7:	c3                   	ret    

000036d8 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    36d8:	55                   	push   %ebp
    36d9:	89 e5                	mov    %esp,%ebp
    36db:	83 ec 18             	sub    $0x18,%esp
  int pid, fd;

  unlink("bigarg-ok");
    36de:	83 ec 0c             	sub    $0xc,%esp
    36e1:	68 b7 59 00 00       	push   $0x59b7
    36e6:	e8 f4 07 00 00       	call   3edf <unlink>
    36eb:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    36ee:	e8 94 07 00 00       	call   3e87 <fork>
    36f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid == 0){
    36f6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    36fa:	0f 85 96 00 00 00    	jne    3796 <bigargtest+0xbe>
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    3700:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3707:	eb 11                	jmp    371a <bigargtest+0x42>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    3709:	8b 45 f4             	mov    -0xc(%ebp),%eax
    370c:	c7 04 85 c0 62 00 00 	movl   $0x59c4,0x62c0(,%eax,4)
    3713:	c4 59 00 00 
  unlink("bigarg-ok");
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    3717:	ff 45 f4             	incl   -0xc(%ebp)
    371a:	83 7d f4 1e          	cmpl   $0x1e,-0xc(%ebp)
    371e:	7e e9                	jle    3709 <bigargtest+0x31>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    3720:	c7 05 3c 63 00 00 00 	movl   $0x0,0x633c
    3727:	00 00 00 
    printf(stdout, "bigarg test\n");
    372a:	a1 8c 62 00 00       	mov    0x628c,%eax
    372f:	83 ec 08             	sub    $0x8,%esp
    3732:	68 a1 5a 00 00       	push   $0x5aa1
    3737:	50                   	push   %eax
    3738:	e8 c4 08 00 00       	call   4001 <printf>
    373d:	83 c4 10             	add    $0x10,%esp
    exec("echo", args);
    3740:	83 ec 08             	sub    $0x8,%esp
    3743:	68 c0 62 00 00       	push   $0x62c0
    3748:	68 b0 43 00 00       	push   $0x43b0
    374d:	e8 75 07 00 00       	call   3ec7 <exec>
    3752:	83 c4 10             	add    $0x10,%esp
    printf(stdout, "bigarg test ok\n");
    3755:	a1 8c 62 00 00       	mov    0x628c,%eax
    375a:	83 ec 08             	sub    $0x8,%esp
    375d:	68 ae 5a 00 00       	push   $0x5aae
    3762:	50                   	push   %eax
    3763:	e8 99 08 00 00       	call   4001 <printf>
    3768:	83 c4 10             	add    $0x10,%esp
    fd = open("bigarg-ok", O_CREATE);
    376b:	83 ec 08             	sub    $0x8,%esp
    376e:	68 00 02 00 00       	push   $0x200
    3773:	68 b7 59 00 00       	push   $0x59b7
    3778:	e8 52 07 00 00       	call   3ecf <open>
    377d:	83 c4 10             	add    $0x10,%esp
    3780:	89 45 ec             	mov    %eax,-0x14(%ebp)
    close(fd);
    3783:	83 ec 0c             	sub    $0xc,%esp
    3786:	ff 75 ec             	pushl  -0x14(%ebp)
    3789:	e8 29 07 00 00       	call   3eb7 <close>
    378e:	83 c4 10             	add    $0x10,%esp
    exit();
    3791:	e8 f9 06 00 00       	call   3e8f <exit>
  } else if(pid < 0){
    3796:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    379a:	79 1b                	jns    37b7 <bigargtest+0xdf>
    printf(stdout, "bigargtest: fork failed\n");
    379c:	a1 8c 62 00 00       	mov    0x628c,%eax
    37a1:	83 ec 08             	sub    $0x8,%esp
    37a4:	68 be 5a 00 00       	push   $0x5abe
    37a9:	50                   	push   %eax
    37aa:	e8 52 08 00 00       	call   4001 <printf>
    37af:	83 c4 10             	add    $0x10,%esp
    exit();
    37b2:	e8 d8 06 00 00       	call   3e8f <exit>
  }
  wait();
    37b7:	e8 db 06 00 00       	call   3e97 <wait>
  fd = open("bigarg-ok", 0);
    37bc:	83 ec 08             	sub    $0x8,%esp
    37bf:	6a 00                	push   $0x0
    37c1:	68 b7 59 00 00       	push   $0x59b7
    37c6:	e8 04 07 00 00       	call   3ecf <open>
    37cb:	83 c4 10             	add    $0x10,%esp
    37ce:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    37d1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    37d5:	79 1b                	jns    37f2 <bigargtest+0x11a>
    printf(stdout, "bigarg test failed!\n");
    37d7:	a1 8c 62 00 00       	mov    0x628c,%eax
    37dc:	83 ec 08             	sub    $0x8,%esp
    37df:	68 d7 5a 00 00       	push   $0x5ad7
    37e4:	50                   	push   %eax
    37e5:	e8 17 08 00 00       	call   4001 <printf>
    37ea:	83 c4 10             	add    $0x10,%esp
    exit();
    37ed:	e8 9d 06 00 00       	call   3e8f <exit>
  }
  close(fd);
    37f2:	83 ec 0c             	sub    $0xc,%esp
    37f5:	ff 75 ec             	pushl  -0x14(%ebp)
    37f8:	e8 ba 06 00 00       	call   3eb7 <close>
    37fd:	83 c4 10             	add    $0x10,%esp
  unlink("bigarg-ok");
    3800:	83 ec 0c             	sub    $0xc,%esp
    3803:	68 b7 59 00 00       	push   $0x59b7
    3808:	e8 d2 06 00 00       	call   3edf <unlink>
    380d:	83 c4 10             	add    $0x10,%esp
}
    3810:	c9                   	leave  
    3811:	c3                   	ret    

00003812 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    3812:	55                   	push   %ebp
    3813:	89 e5                	mov    %esp,%ebp
    3815:	53                   	push   %ebx
    3816:	83 ec 64             	sub    $0x64,%esp
  int nfiles;
  int fsblocks = 0;
    3819:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

  printf(1, "fsfull test\n");
    3820:	83 ec 08             	sub    $0x8,%esp
    3823:	68 ec 5a 00 00       	push   $0x5aec
    3828:	6a 01                	push   $0x1
    382a:	e8 d2 07 00 00       	call   4001 <printf>
    382f:	83 c4 10             	add    $0x10,%esp

  for(nfiles = 0; ; nfiles++){
    3832:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    char name[64];
    name[0] = 'f';
    3839:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    383d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3840:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    3845:	f7 e9                	imul   %ecx
    3847:	c1 fa 06             	sar    $0x6,%edx
    384a:	89 c8                	mov    %ecx,%eax
    384c:	c1 f8 1f             	sar    $0x1f,%eax
    384f:	29 c2                	sub    %eax,%edx
    3851:	89 d0                	mov    %edx,%eax
    3853:	83 c0 30             	add    $0x30,%eax
    3856:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3859:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    385c:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    3861:	f7 eb                	imul   %ebx
    3863:	c1 fa 06             	sar    $0x6,%edx
    3866:	89 d8                	mov    %ebx,%eax
    3868:	c1 f8 1f             	sar    $0x1f,%eax
    386b:	89 d1                	mov    %edx,%ecx
    386d:	29 c1                	sub    %eax,%ecx
    386f:	89 c8                	mov    %ecx,%eax
    3871:	c1 e0 02             	shl    $0x2,%eax
    3874:	01 c8                	add    %ecx,%eax
    3876:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    387d:	01 d0                	add    %edx,%eax
    387f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    3886:	01 d0                	add    %edx,%eax
    3888:	c1 e0 03             	shl    $0x3,%eax
    388b:	29 c3                	sub    %eax,%ebx
    388d:	89 d9                	mov    %ebx,%ecx
    388f:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3894:	f7 e9                	imul   %ecx
    3896:	c1 fa 05             	sar    $0x5,%edx
    3899:	89 c8                	mov    %ecx,%eax
    389b:	c1 f8 1f             	sar    $0x1f,%eax
    389e:	29 c2                	sub    %eax,%edx
    38a0:	89 d0                	mov    %edx,%eax
    38a2:	83 c0 30             	add    $0x30,%eax
    38a5:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    38a8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    38ab:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    38b0:	f7 eb                	imul   %ebx
    38b2:	c1 fa 05             	sar    $0x5,%edx
    38b5:	89 d8                	mov    %ebx,%eax
    38b7:	c1 f8 1f             	sar    $0x1f,%eax
    38ba:	89 d1                	mov    %edx,%ecx
    38bc:	29 c1                	sub    %eax,%ecx
    38be:	89 c8                	mov    %ecx,%eax
    38c0:	c1 e0 02             	shl    $0x2,%eax
    38c3:	01 c8                	add    %ecx,%eax
    38c5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    38cc:	01 d0                	add    %edx,%eax
    38ce:	c1 e0 02             	shl    $0x2,%eax
    38d1:	29 c3                	sub    %eax,%ebx
    38d3:	89 d9                	mov    %ebx,%ecx
    38d5:	b8 67 66 66 66       	mov    $0x66666667,%eax
    38da:	f7 e9                	imul   %ecx
    38dc:	c1 fa 02             	sar    $0x2,%edx
    38df:	89 c8                	mov    %ecx,%eax
    38e1:	c1 f8 1f             	sar    $0x1f,%eax
    38e4:	29 c2                	sub    %eax,%edx
    38e6:	89 d0                	mov    %edx,%eax
    38e8:	83 c0 30             	add    $0x30,%eax
    38eb:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    38ee:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    38f1:	b8 67 66 66 66       	mov    $0x66666667,%eax
    38f6:	f7 e9                	imul   %ecx
    38f8:	c1 fa 02             	sar    $0x2,%edx
    38fb:	89 c8                	mov    %ecx,%eax
    38fd:	c1 f8 1f             	sar    $0x1f,%eax
    3900:	29 c2                	sub    %eax,%edx
    3902:	89 d0                	mov    %edx,%eax
    3904:	c1 e0 02             	shl    $0x2,%eax
    3907:	01 d0                	add    %edx,%eax
    3909:	01 c0                	add    %eax,%eax
    390b:	29 c1                	sub    %eax,%ecx
    390d:	89 ca                	mov    %ecx,%edx
    390f:	88 d0                	mov    %dl,%al
    3911:	83 c0 30             	add    $0x30,%eax
    3914:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    3917:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    printf(1, "writing %s\n", name);
    391b:	83 ec 04             	sub    $0x4,%esp
    391e:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3921:	50                   	push   %eax
    3922:	68 f9 5a 00 00       	push   $0x5af9
    3927:	6a 01                	push   $0x1
    3929:	e8 d3 06 00 00       	call   4001 <printf>
    392e:	83 c4 10             	add    $0x10,%esp
    int fd = open(name, O_CREATE|O_RDWR);
    3931:	83 ec 08             	sub    $0x8,%esp
    3934:	68 02 02 00 00       	push   $0x202
    3939:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    393c:	50                   	push   %eax
    393d:	e8 8d 05 00 00       	call   3ecf <open>
    3942:	83 c4 10             	add    $0x10,%esp
    3945:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(fd < 0){
    3948:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    394c:	79 18                	jns    3966 <fsfull+0x154>
      printf(1, "open %s failed\n", name);
    394e:	83 ec 04             	sub    $0x4,%esp
    3951:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3954:	50                   	push   %eax
    3955:	68 05 5b 00 00       	push   $0x5b05
    395a:	6a 01                	push   $0x1
    395c:	e8 a0 06 00 00       	call   4001 <printf>
    3961:	83 c4 10             	add    $0x10,%esp
      break;
    3964:	eb 6c                	jmp    39d2 <fsfull+0x1c0>
    }
    int total = 0;
    3966:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while(1){
      int cc = write(fd, buf, 512);
    396d:	83 ec 04             	sub    $0x4,%esp
    3970:	68 00 02 00 00       	push   $0x200
    3975:	68 80 8a 00 00       	push   $0x8a80
    397a:	ff 75 e8             	pushl  -0x18(%ebp)
    397d:	e8 2d 05 00 00       	call   3eaf <write>
    3982:	83 c4 10             	add    $0x10,%esp
    3985:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if(cc < 512)
    3988:	81 7d e4 ff 01 00 00 	cmpl   $0x1ff,-0x1c(%ebp)
    398f:	7f 2c                	jg     39bd <fsfull+0x1ab>
        break;
    3991:	90                   	nop
      total += cc;
      fsblocks++;
    }
    printf(1, "wrote %d bytes\n", total);
    3992:	83 ec 04             	sub    $0x4,%esp
    3995:	ff 75 ec             	pushl  -0x14(%ebp)
    3998:	68 15 5b 00 00       	push   $0x5b15
    399d:	6a 01                	push   $0x1
    399f:	e8 5d 06 00 00       	call   4001 <printf>
    39a4:	83 c4 10             	add    $0x10,%esp
    close(fd);
    39a7:	83 ec 0c             	sub    $0xc,%esp
    39aa:	ff 75 e8             	pushl  -0x18(%ebp)
    39ad:	e8 05 05 00 00       	call   3eb7 <close>
    39b2:	83 c4 10             	add    $0x10,%esp
    if(total == 0)
    39b5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    39b9:	75 0f                	jne    39ca <fsfull+0x1b8>
    39bb:	eb 0b                	jmp    39c8 <fsfull+0x1b6>
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
      if(cc < 512)
        break;
      total += cc;
    39bd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    39c0:	01 45 ec             	add    %eax,-0x14(%ebp)
      fsblocks++;
    39c3:	ff 45 f0             	incl   -0x10(%ebp)
    }
    39c6:	eb a5                	jmp    396d <fsfull+0x15b>
    printf(1, "wrote %d bytes\n", total);
    close(fd);
    if(total == 0)
      break;
    39c8:	eb 08                	jmp    39d2 <fsfull+0x1c0>
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    39ca:	ff 45 f4             	incl   -0xc(%ebp)
    }
    printf(1, "wrote %d bytes\n", total);
    close(fd);
    if(total == 0)
      break;
  }
    39cd:	e9 67 fe ff ff       	jmp    3839 <fsfull+0x27>

  while(nfiles >= 0){
    39d2:	e9 f4 00 00 00       	jmp    3acb <fsfull+0x2b9>
    char name[64];
    name[0] = 'f';
    39d7:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    39db:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    39de:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    39e3:	f7 e9                	imul   %ecx
    39e5:	c1 fa 06             	sar    $0x6,%edx
    39e8:	89 c8                	mov    %ecx,%eax
    39ea:	c1 f8 1f             	sar    $0x1f,%eax
    39ed:	29 c2                	sub    %eax,%edx
    39ef:	89 d0                	mov    %edx,%eax
    39f1:	83 c0 30             	add    $0x30,%eax
    39f4:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    39f7:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    39fa:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    39ff:	f7 eb                	imul   %ebx
    3a01:	c1 fa 06             	sar    $0x6,%edx
    3a04:	89 d8                	mov    %ebx,%eax
    3a06:	c1 f8 1f             	sar    $0x1f,%eax
    3a09:	89 d1                	mov    %edx,%ecx
    3a0b:	29 c1                	sub    %eax,%ecx
    3a0d:	89 c8                	mov    %ecx,%eax
    3a0f:	c1 e0 02             	shl    $0x2,%eax
    3a12:	01 c8                	add    %ecx,%eax
    3a14:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    3a1b:	01 d0                	add    %edx,%eax
    3a1d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    3a24:	01 d0                	add    %edx,%eax
    3a26:	c1 e0 03             	shl    $0x3,%eax
    3a29:	29 c3                	sub    %eax,%ebx
    3a2b:	89 d9                	mov    %ebx,%ecx
    3a2d:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3a32:	f7 e9                	imul   %ecx
    3a34:	c1 fa 05             	sar    $0x5,%edx
    3a37:	89 c8                	mov    %ecx,%eax
    3a39:	c1 f8 1f             	sar    $0x1f,%eax
    3a3c:	29 c2                	sub    %eax,%edx
    3a3e:	89 d0                	mov    %edx,%eax
    3a40:	83 c0 30             	add    $0x30,%eax
    3a43:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3a46:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3a49:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3a4e:	f7 eb                	imul   %ebx
    3a50:	c1 fa 05             	sar    $0x5,%edx
    3a53:	89 d8                	mov    %ebx,%eax
    3a55:	c1 f8 1f             	sar    $0x1f,%eax
    3a58:	89 d1                	mov    %edx,%ecx
    3a5a:	29 c1                	sub    %eax,%ecx
    3a5c:	89 c8                	mov    %ecx,%eax
    3a5e:	c1 e0 02             	shl    $0x2,%eax
    3a61:	01 c8                	add    %ecx,%eax
    3a63:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    3a6a:	01 d0                	add    %edx,%eax
    3a6c:	c1 e0 02             	shl    $0x2,%eax
    3a6f:	29 c3                	sub    %eax,%ebx
    3a71:	89 d9                	mov    %ebx,%ecx
    3a73:	b8 67 66 66 66       	mov    $0x66666667,%eax
    3a78:	f7 e9                	imul   %ecx
    3a7a:	c1 fa 02             	sar    $0x2,%edx
    3a7d:	89 c8                	mov    %ecx,%eax
    3a7f:	c1 f8 1f             	sar    $0x1f,%eax
    3a82:	29 c2                	sub    %eax,%edx
    3a84:	89 d0                	mov    %edx,%eax
    3a86:	83 c0 30             	add    $0x30,%eax
    3a89:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    3a8c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3a8f:	b8 67 66 66 66       	mov    $0x66666667,%eax
    3a94:	f7 e9                	imul   %ecx
    3a96:	c1 fa 02             	sar    $0x2,%edx
    3a99:	89 c8                	mov    %ecx,%eax
    3a9b:	c1 f8 1f             	sar    $0x1f,%eax
    3a9e:	29 c2                	sub    %eax,%edx
    3aa0:	89 d0                	mov    %edx,%eax
    3aa2:	c1 e0 02             	shl    $0x2,%eax
    3aa5:	01 d0                	add    %edx,%eax
    3aa7:	01 c0                	add    %eax,%eax
    3aa9:	29 c1                	sub    %eax,%ecx
    3aab:	89 ca                	mov    %ecx,%edx
    3aad:	88 d0                	mov    %dl,%al
    3aaf:	83 c0 30             	add    $0x30,%eax
    3ab2:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    3ab5:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    unlink(name);
    3ab9:	83 ec 0c             	sub    $0xc,%esp
    3abc:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3abf:	50                   	push   %eax
    3ac0:	e8 1a 04 00 00       	call   3edf <unlink>
    3ac5:	83 c4 10             	add    $0x10,%esp
    nfiles--;
    3ac8:	ff 4d f4             	decl   -0xc(%ebp)
    close(fd);
    if(total == 0)
      break;
  }

  while(nfiles >= 0){
    3acb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3acf:	0f 89 02 ff ff ff    	jns    39d7 <fsfull+0x1c5>
    name[5] = '\0';
    unlink(name);
    nfiles--;
  }

  printf(1, "fsfull test finished\n");
    3ad5:	83 ec 08             	sub    $0x8,%esp
    3ad8:	68 25 5b 00 00       	push   $0x5b25
    3add:	6a 01                	push   $0x1
    3adf:	e8 1d 05 00 00       	call   4001 <printf>
    3ae4:	83 c4 10             	add    $0x10,%esp
}
    3ae7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3aea:	c9                   	leave  
    3aeb:	c3                   	ret    

00003aec <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
    3aec:	55                   	push   %ebp
    3aed:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
    3aef:	8b 15 90 62 00 00    	mov    0x6290,%edx
    3af5:	89 d0                	mov    %edx,%eax
    3af7:	01 c0                	add    %eax,%eax
    3af9:	01 d0                	add    %edx,%eax
    3afb:	c1 e0 02             	shl    $0x2,%eax
    3afe:	01 d0                	add    %edx,%eax
    3b00:	c1 e0 08             	shl    $0x8,%eax
    3b03:	01 d0                	add    %edx,%eax
    3b05:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
    3b0c:	01 c8                	add    %ecx,%eax
    3b0e:	c1 e0 02             	shl    $0x2,%eax
    3b11:	01 d0                	add    %edx,%eax
    3b13:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    3b1a:	01 d0                	add    %edx,%eax
    3b1c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
    3b23:	01 d0                	add    %edx,%eax
    3b25:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3b2a:	a3 90 62 00 00       	mov    %eax,0x6290
  return randstate;
    3b2f:	a1 90 62 00 00       	mov    0x6290,%eax
}
    3b34:	5d                   	pop    %ebp
    3b35:	c3                   	ret    

00003b36 <main>:

int
main(int argc, char *argv[])
{
    3b36:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    3b3a:	83 e4 f0             	and    $0xfffffff0,%esp
    3b3d:	ff 71 fc             	pushl  -0x4(%ecx)
    3b40:	55                   	push   %ebp
    3b41:	89 e5                	mov    %esp,%ebp
    3b43:	51                   	push   %ecx
    3b44:	83 ec 04             	sub    $0x4,%esp
  printf(1, "usertests starting\n");
    3b47:	83 ec 08             	sub    $0x8,%esp
    3b4a:	68 3b 5b 00 00       	push   $0x5b3b
    3b4f:	6a 01                	push   $0x1
    3b51:	e8 ab 04 00 00       	call   4001 <printf>
    3b56:	83 c4 10             	add    $0x10,%esp

  if(open("usertests.ran", 0) >= 0){
    3b59:	83 ec 08             	sub    $0x8,%esp
    3b5c:	6a 00                	push   $0x0
    3b5e:	68 4f 5b 00 00       	push   $0x5b4f
    3b63:	e8 67 03 00 00       	call   3ecf <open>
    3b68:	83 c4 10             	add    $0x10,%esp
    3b6b:	85 c0                	test   %eax,%eax
    3b6d:	78 17                	js     3b86 <main+0x50>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    3b6f:	83 ec 08             	sub    $0x8,%esp
    3b72:	68 60 5b 00 00       	push   $0x5b60
    3b77:	6a 01                	push   $0x1
    3b79:	e8 83 04 00 00       	call   4001 <printf>
    3b7e:	83 c4 10             	add    $0x10,%esp
    exit();
    3b81:	e8 09 03 00 00       	call   3e8f <exit>
  }
  close(open("usertests.ran", O_CREATE));
    3b86:	83 ec 08             	sub    $0x8,%esp
    3b89:	68 00 02 00 00       	push   $0x200
    3b8e:	68 4f 5b 00 00       	push   $0x5b4f
    3b93:	e8 37 03 00 00       	call   3ecf <open>
    3b98:	83 c4 10             	add    $0x10,%esp
    3b9b:	83 ec 0c             	sub    $0xc,%esp
    3b9e:	50                   	push   %eax
    3b9f:	e8 13 03 00 00       	call   3eb7 <close>
    3ba4:	83 c4 10             	add    $0x10,%esp

  createdelete();
    3ba7:	e8 e5 d6 ff ff       	call   1291 <createdelete>
  linkunlink();
    3bac:	e8 a7 e0 ff ff       	call   1c58 <linkunlink>
  concreate();
    3bb1:	e8 43 dd ff ff       	call   18f9 <concreate>
  fourfiles();
    3bb6:	e8 8a d4 ff ff       	call   1045 <fourfiles>
  sharedfd();
    3bbb:	e8 a8 d2 ff ff       	call   e68 <sharedfd>

  bigargtest();
    3bc0:	e8 13 fb ff ff       	call   36d8 <bigargtest>
  bigwrite();
    3bc5:	e8 92 ea ff ff       	call   265c <bigwrite>
  bigargtest();
    3bca:	e8 09 fb ff ff       	call   36d8 <bigargtest>
  bsstest();
    3bcf:	e8 91 fa ff ff       	call   3665 <bsstest>
  sbrktest();
    3bd4:	e8 ac f4 ff ff       	call   3085 <sbrktest>
  validatetest();
    3bd9:	e8 aa f9 ff ff       	call   3588 <validatetest>

  opentest();
    3bde:	e8 19 c7 ff ff       	call   2fc <opentest>
  writetest();
    3be3:	e8 c2 c7 ff ff       	call   3aa <writetest>
  writetest1();
    3be8:	e8 cb c9 ff ff       	call   5b8 <writetest1>
  createtest();
    3bed:	e8 c1 cb ff ff       	call   7b3 <createtest>

  openiputtest();
    3bf2:	e8 f7 c5 ff ff       	call   1ee <openiputtest>
  exitiputtest();
    3bf7:	e8 f4 c4 ff ff       	call   f0 <exitiputtest>
  iputtest();
    3bfc:	e8 ff c3 ff ff       	call   0 <iputtest>

  mem();
    3c01:	e8 72 d1 ff ff       	call   d78 <mem>
  pipe1();
    3c06:	e8 aa cd ff ff       	call   9b5 <pipe1>
  preempt();
    3c0b:	e8 8e cf ff ff       	call   b9e <preempt>
  exitwait();
    3c10:	e8 ec d0 ff ff       	call   d01 <exitwait>

  rmdot();
    3c15:	e8 b0 ee ff ff       	call   2aca <rmdot>
  fourteen();
    3c1a:	e8 50 ed ff ff       	call   296f <fourteen>
  bigfile();
    3c1f:	e8 34 eb ff ff       	call   2758 <bigfile>
  subdir();
    3c24:	e8 f2 e2 ff ff       	call   1f1b <subdir>
  linktest();
    3c29:	e8 8a da ff ff       	call   16b8 <linktest>
  unlinkread();
    3c2e:	e8 c6 d8 ff ff       	call   14f9 <unlinkread>
  dirfile();
    3c33:	e8 16 f0 ff ff       	call   2c4e <dirfile>
  iref();
    3c38:	e8 48 f2 ff ff       	call   2e85 <iref>
  forktest();
    3c3d:	e8 7b f3 ff ff       	call   2fbd <forktest>
  bigdir(); // slow
    3c42:	e8 5e e1 ff ff       	call   1da5 <bigdir>
  exectest();
    3c47:	e8 17 cd ff ff       	call   963 <exectest>

  exit();
    3c4c:	e8 3e 02 00 00       	call   3e8f <exit>

00003c51 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    3c51:	55                   	push   %ebp
    3c52:	89 e5                	mov    %esp,%ebp
    3c54:	57                   	push   %edi
    3c55:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    3c56:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3c59:	8b 55 10             	mov    0x10(%ebp),%edx
    3c5c:	8b 45 0c             	mov    0xc(%ebp),%eax
    3c5f:	89 cb                	mov    %ecx,%ebx
    3c61:	89 df                	mov    %ebx,%edi
    3c63:	89 d1                	mov    %edx,%ecx
    3c65:	fc                   	cld    
    3c66:	f3 aa                	rep stos %al,%es:(%edi)
    3c68:	89 ca                	mov    %ecx,%edx
    3c6a:	89 fb                	mov    %edi,%ebx
    3c6c:	89 5d 08             	mov    %ebx,0x8(%ebp)
    3c6f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    3c72:	5b                   	pop    %ebx
    3c73:	5f                   	pop    %edi
    3c74:	5d                   	pop    %ebp
    3c75:	c3                   	ret    

00003c76 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    3c76:	55                   	push   %ebp
    3c77:	89 e5                	mov    %esp,%ebp
    3c79:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    3c7c:	8b 45 08             	mov    0x8(%ebp),%eax
    3c7f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    3c82:	90                   	nop
    3c83:	8b 45 08             	mov    0x8(%ebp),%eax
    3c86:	8d 50 01             	lea    0x1(%eax),%edx
    3c89:	89 55 08             	mov    %edx,0x8(%ebp)
    3c8c:	8b 55 0c             	mov    0xc(%ebp),%edx
    3c8f:	8d 4a 01             	lea    0x1(%edx),%ecx
    3c92:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    3c95:	8a 12                	mov    (%edx),%dl
    3c97:	88 10                	mov    %dl,(%eax)
    3c99:	8a 00                	mov    (%eax),%al
    3c9b:	84 c0                	test   %al,%al
    3c9d:	75 e4                	jne    3c83 <strcpy+0xd>
    ;
  return os;
    3c9f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3ca2:	c9                   	leave  
    3ca3:	c3                   	ret    

00003ca4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3ca4:	55                   	push   %ebp
    3ca5:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    3ca7:	eb 06                	jmp    3caf <strcmp+0xb>
    p++, q++;
    3ca9:	ff 45 08             	incl   0x8(%ebp)
    3cac:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    3caf:	8b 45 08             	mov    0x8(%ebp),%eax
    3cb2:	8a 00                	mov    (%eax),%al
    3cb4:	84 c0                	test   %al,%al
    3cb6:	74 0e                	je     3cc6 <strcmp+0x22>
    3cb8:	8b 45 08             	mov    0x8(%ebp),%eax
    3cbb:	8a 10                	mov    (%eax),%dl
    3cbd:	8b 45 0c             	mov    0xc(%ebp),%eax
    3cc0:	8a 00                	mov    (%eax),%al
    3cc2:	38 c2                	cmp    %al,%dl
    3cc4:	74 e3                	je     3ca9 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    3cc6:	8b 45 08             	mov    0x8(%ebp),%eax
    3cc9:	8a 00                	mov    (%eax),%al
    3ccb:	0f b6 d0             	movzbl %al,%edx
    3cce:	8b 45 0c             	mov    0xc(%ebp),%eax
    3cd1:	8a 00                	mov    (%eax),%al
    3cd3:	0f b6 c0             	movzbl %al,%eax
    3cd6:	29 c2                	sub    %eax,%edx
    3cd8:	89 d0                	mov    %edx,%eax
}
    3cda:	5d                   	pop    %ebp
    3cdb:	c3                   	ret    

00003cdc <strlen>:

uint
strlen(char *s)
{
    3cdc:	55                   	push   %ebp
    3cdd:	89 e5                	mov    %esp,%ebp
    3cdf:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    3ce2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    3ce9:	eb 03                	jmp    3cee <strlen+0x12>
    3ceb:	ff 45 fc             	incl   -0x4(%ebp)
    3cee:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3cf1:	8b 45 08             	mov    0x8(%ebp),%eax
    3cf4:	01 d0                	add    %edx,%eax
    3cf6:	8a 00                	mov    (%eax),%al
    3cf8:	84 c0                	test   %al,%al
    3cfa:	75 ef                	jne    3ceb <strlen+0xf>
    ;
  return n;
    3cfc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3cff:	c9                   	leave  
    3d00:	c3                   	ret    

00003d01 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3d01:	55                   	push   %ebp
    3d02:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    3d04:	8b 45 10             	mov    0x10(%ebp),%eax
    3d07:	50                   	push   %eax
    3d08:	ff 75 0c             	pushl  0xc(%ebp)
    3d0b:	ff 75 08             	pushl  0x8(%ebp)
    3d0e:	e8 3e ff ff ff       	call   3c51 <stosb>
    3d13:	83 c4 0c             	add    $0xc,%esp
  return dst;
    3d16:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3d19:	c9                   	leave  
    3d1a:	c3                   	ret    

00003d1b <strchr>:

char*
strchr(const char *s, char c)
{
    3d1b:	55                   	push   %ebp
    3d1c:	89 e5                	mov    %esp,%ebp
    3d1e:	83 ec 04             	sub    $0x4,%esp
    3d21:	8b 45 0c             	mov    0xc(%ebp),%eax
    3d24:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    3d27:	eb 12                	jmp    3d3b <strchr+0x20>
    if(*s == c)
    3d29:	8b 45 08             	mov    0x8(%ebp),%eax
    3d2c:	8a 00                	mov    (%eax),%al
    3d2e:	3a 45 fc             	cmp    -0x4(%ebp),%al
    3d31:	75 05                	jne    3d38 <strchr+0x1d>
      return (char*)s;
    3d33:	8b 45 08             	mov    0x8(%ebp),%eax
    3d36:	eb 11                	jmp    3d49 <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    3d38:	ff 45 08             	incl   0x8(%ebp)
    3d3b:	8b 45 08             	mov    0x8(%ebp),%eax
    3d3e:	8a 00                	mov    (%eax),%al
    3d40:	84 c0                	test   %al,%al
    3d42:	75 e5                	jne    3d29 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    3d44:	b8 00 00 00 00       	mov    $0x0,%eax
}
    3d49:	c9                   	leave  
    3d4a:	c3                   	ret    

00003d4b <gets>:

char*
gets(char *buf, int max)
{
    3d4b:	55                   	push   %ebp
    3d4c:	89 e5                	mov    %esp,%ebp
    3d4e:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3d51:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3d58:	eb 41                	jmp    3d9b <gets+0x50>
    cc = read(0, &c, 1);
    3d5a:	83 ec 04             	sub    $0x4,%esp
    3d5d:	6a 01                	push   $0x1
    3d5f:	8d 45 ef             	lea    -0x11(%ebp),%eax
    3d62:	50                   	push   %eax
    3d63:	6a 00                	push   $0x0
    3d65:	e8 3d 01 00 00       	call   3ea7 <read>
    3d6a:	83 c4 10             	add    $0x10,%esp
    3d6d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    3d70:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3d74:	7f 02                	jg     3d78 <gets+0x2d>
      break;
    3d76:	eb 2c                	jmp    3da4 <gets+0x59>
    buf[i++] = c;
    3d78:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3d7b:	8d 50 01             	lea    0x1(%eax),%edx
    3d7e:	89 55 f4             	mov    %edx,-0xc(%ebp)
    3d81:	89 c2                	mov    %eax,%edx
    3d83:	8b 45 08             	mov    0x8(%ebp),%eax
    3d86:	01 c2                	add    %eax,%edx
    3d88:	8a 45 ef             	mov    -0x11(%ebp),%al
    3d8b:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    3d8d:	8a 45 ef             	mov    -0x11(%ebp),%al
    3d90:	3c 0a                	cmp    $0xa,%al
    3d92:	74 10                	je     3da4 <gets+0x59>
    3d94:	8a 45 ef             	mov    -0x11(%ebp),%al
    3d97:	3c 0d                	cmp    $0xd,%al
    3d99:	74 09                	je     3da4 <gets+0x59>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3d9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3d9e:	40                   	inc    %eax
    3d9f:	3b 45 0c             	cmp    0xc(%ebp),%eax
    3da2:	7c b6                	jl     3d5a <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    3da4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3da7:	8b 45 08             	mov    0x8(%ebp),%eax
    3daa:	01 d0                	add    %edx,%eax
    3dac:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    3daf:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3db2:	c9                   	leave  
    3db3:	c3                   	ret    

00003db4 <stat>:

int
stat(char *n, struct stat *st)
{
    3db4:	55                   	push   %ebp
    3db5:	89 e5                	mov    %esp,%ebp
    3db7:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3dba:	83 ec 08             	sub    $0x8,%esp
    3dbd:	6a 00                	push   $0x0
    3dbf:	ff 75 08             	pushl  0x8(%ebp)
    3dc2:	e8 08 01 00 00       	call   3ecf <open>
    3dc7:	83 c4 10             	add    $0x10,%esp
    3dca:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    3dcd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3dd1:	79 07                	jns    3dda <stat+0x26>
    return -1;
    3dd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3dd8:	eb 25                	jmp    3dff <stat+0x4b>
  r = fstat(fd, st);
    3dda:	83 ec 08             	sub    $0x8,%esp
    3ddd:	ff 75 0c             	pushl  0xc(%ebp)
    3de0:	ff 75 f4             	pushl  -0xc(%ebp)
    3de3:	e8 ff 00 00 00       	call   3ee7 <fstat>
    3de8:	83 c4 10             	add    $0x10,%esp
    3deb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    3dee:	83 ec 0c             	sub    $0xc,%esp
    3df1:	ff 75 f4             	pushl  -0xc(%ebp)
    3df4:	e8 be 00 00 00       	call   3eb7 <close>
    3df9:	83 c4 10             	add    $0x10,%esp
  return r;
    3dfc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    3dff:	c9                   	leave  
    3e00:	c3                   	ret    

00003e01 <atoi>:

int
atoi(const char *s)
{
    3e01:	55                   	push   %ebp
    3e02:	89 e5                	mov    %esp,%ebp
    3e04:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    3e07:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    3e0e:	eb 24                	jmp    3e34 <atoi+0x33>
    n = n*10 + *s++ - '0';
    3e10:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3e13:	89 d0                	mov    %edx,%eax
    3e15:	c1 e0 02             	shl    $0x2,%eax
    3e18:	01 d0                	add    %edx,%eax
    3e1a:	01 c0                	add    %eax,%eax
    3e1c:	89 c1                	mov    %eax,%ecx
    3e1e:	8b 45 08             	mov    0x8(%ebp),%eax
    3e21:	8d 50 01             	lea    0x1(%eax),%edx
    3e24:	89 55 08             	mov    %edx,0x8(%ebp)
    3e27:	8a 00                	mov    (%eax),%al
    3e29:	0f be c0             	movsbl %al,%eax
    3e2c:	01 c8                	add    %ecx,%eax
    3e2e:	83 e8 30             	sub    $0x30,%eax
    3e31:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3e34:	8b 45 08             	mov    0x8(%ebp),%eax
    3e37:	8a 00                	mov    (%eax),%al
    3e39:	3c 2f                	cmp    $0x2f,%al
    3e3b:	7e 09                	jle    3e46 <atoi+0x45>
    3e3d:	8b 45 08             	mov    0x8(%ebp),%eax
    3e40:	8a 00                	mov    (%eax),%al
    3e42:	3c 39                	cmp    $0x39,%al
    3e44:	7e ca                	jle    3e10 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    3e46:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3e49:	c9                   	leave  
    3e4a:	c3                   	ret    

00003e4b <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    3e4b:	55                   	push   %ebp
    3e4c:	89 e5                	mov    %esp,%ebp
    3e4e:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    3e51:	8b 45 08             	mov    0x8(%ebp),%eax
    3e54:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    3e57:	8b 45 0c             	mov    0xc(%ebp),%eax
    3e5a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    3e5d:	eb 16                	jmp    3e75 <memmove+0x2a>
    *dst++ = *src++;
    3e5f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3e62:	8d 50 01             	lea    0x1(%eax),%edx
    3e65:	89 55 fc             	mov    %edx,-0x4(%ebp)
    3e68:	8b 55 f8             	mov    -0x8(%ebp),%edx
    3e6b:	8d 4a 01             	lea    0x1(%edx),%ecx
    3e6e:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    3e71:	8a 12                	mov    (%edx),%dl
    3e73:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3e75:	8b 45 10             	mov    0x10(%ebp),%eax
    3e78:	8d 50 ff             	lea    -0x1(%eax),%edx
    3e7b:	89 55 10             	mov    %edx,0x10(%ebp)
    3e7e:	85 c0                	test   %eax,%eax
    3e80:	7f dd                	jg     3e5f <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    3e82:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3e85:	c9                   	leave  
    3e86:	c3                   	ret    

00003e87 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3e87:	b8 01 00 00 00       	mov    $0x1,%eax
    3e8c:	cd 40                	int    $0x40
    3e8e:	c3                   	ret    

00003e8f <exit>:
SYSCALL(exit)
    3e8f:	b8 02 00 00 00       	mov    $0x2,%eax
    3e94:	cd 40                	int    $0x40
    3e96:	c3                   	ret    

00003e97 <wait>:
SYSCALL(wait)
    3e97:	b8 03 00 00 00       	mov    $0x3,%eax
    3e9c:	cd 40                	int    $0x40
    3e9e:	c3                   	ret    

00003e9f <pipe>:
SYSCALL(pipe)
    3e9f:	b8 04 00 00 00       	mov    $0x4,%eax
    3ea4:	cd 40                	int    $0x40
    3ea6:	c3                   	ret    

00003ea7 <read>:
SYSCALL(read)
    3ea7:	b8 05 00 00 00       	mov    $0x5,%eax
    3eac:	cd 40                	int    $0x40
    3eae:	c3                   	ret    

00003eaf <write>:
SYSCALL(write)
    3eaf:	b8 10 00 00 00       	mov    $0x10,%eax
    3eb4:	cd 40                	int    $0x40
    3eb6:	c3                   	ret    

00003eb7 <close>:
SYSCALL(close)
    3eb7:	b8 15 00 00 00       	mov    $0x15,%eax
    3ebc:	cd 40                	int    $0x40
    3ebe:	c3                   	ret    

00003ebf <kill>:
SYSCALL(kill)
    3ebf:	b8 06 00 00 00       	mov    $0x6,%eax
    3ec4:	cd 40                	int    $0x40
    3ec6:	c3                   	ret    

00003ec7 <exec>:
SYSCALL(exec)
    3ec7:	b8 07 00 00 00       	mov    $0x7,%eax
    3ecc:	cd 40                	int    $0x40
    3ece:	c3                   	ret    

00003ecf <open>:
SYSCALL(open)
    3ecf:	b8 0f 00 00 00       	mov    $0xf,%eax
    3ed4:	cd 40                	int    $0x40
    3ed6:	c3                   	ret    

00003ed7 <mknod>:
SYSCALL(mknod)
    3ed7:	b8 11 00 00 00       	mov    $0x11,%eax
    3edc:	cd 40                	int    $0x40
    3ede:	c3                   	ret    

00003edf <unlink>:
SYSCALL(unlink)
    3edf:	b8 12 00 00 00       	mov    $0x12,%eax
    3ee4:	cd 40                	int    $0x40
    3ee6:	c3                   	ret    

00003ee7 <fstat>:
SYSCALL(fstat)
    3ee7:	b8 08 00 00 00       	mov    $0x8,%eax
    3eec:	cd 40                	int    $0x40
    3eee:	c3                   	ret    

00003eef <link>:
SYSCALL(link)
    3eef:	b8 13 00 00 00       	mov    $0x13,%eax
    3ef4:	cd 40                	int    $0x40
    3ef6:	c3                   	ret    

00003ef7 <mkdir>:
SYSCALL(mkdir)
    3ef7:	b8 14 00 00 00       	mov    $0x14,%eax
    3efc:	cd 40                	int    $0x40
    3efe:	c3                   	ret    

00003eff <chdir>:
SYSCALL(chdir)
    3eff:	b8 09 00 00 00       	mov    $0x9,%eax
    3f04:	cd 40                	int    $0x40
    3f06:	c3                   	ret    

00003f07 <dup>:
SYSCALL(dup)
    3f07:	b8 0a 00 00 00       	mov    $0xa,%eax
    3f0c:	cd 40                	int    $0x40
    3f0e:	c3                   	ret    

00003f0f <getpid>:
SYSCALL(getpid)
    3f0f:	b8 0b 00 00 00       	mov    $0xb,%eax
    3f14:	cd 40                	int    $0x40
    3f16:	c3                   	ret    

00003f17 <sbrk>:
SYSCALL(sbrk)
    3f17:	b8 0c 00 00 00       	mov    $0xc,%eax
    3f1c:	cd 40                	int    $0x40
    3f1e:	c3                   	ret    

00003f1f <sleep>:
SYSCALL(sleep)
    3f1f:	b8 0d 00 00 00       	mov    $0xd,%eax
    3f24:	cd 40                	int    $0x40
    3f26:	c3                   	ret    

00003f27 <uptime>:
SYSCALL(uptime)
    3f27:	b8 0e 00 00 00       	mov    $0xe,%eax
    3f2c:	cd 40                	int    $0x40
    3f2e:	c3                   	ret    

00003f2f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    3f2f:	55                   	push   %ebp
    3f30:	89 e5                	mov    %esp,%ebp
    3f32:	83 ec 18             	sub    $0x18,%esp
    3f35:	8b 45 0c             	mov    0xc(%ebp),%eax
    3f38:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    3f3b:	83 ec 04             	sub    $0x4,%esp
    3f3e:	6a 01                	push   $0x1
    3f40:	8d 45 f4             	lea    -0xc(%ebp),%eax
    3f43:	50                   	push   %eax
    3f44:	ff 75 08             	pushl  0x8(%ebp)
    3f47:	e8 63 ff ff ff       	call   3eaf <write>
    3f4c:	83 c4 10             	add    $0x10,%esp
}
    3f4f:	c9                   	leave  
    3f50:	c3                   	ret    

00003f51 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    3f51:	55                   	push   %ebp
    3f52:	89 e5                	mov    %esp,%ebp
    3f54:	53                   	push   %ebx
    3f55:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    3f58:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    3f5f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    3f63:	74 17                	je     3f7c <printint+0x2b>
    3f65:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    3f69:	79 11                	jns    3f7c <printint+0x2b>
    neg = 1;
    3f6b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    3f72:	8b 45 0c             	mov    0xc(%ebp),%eax
    3f75:	f7 d8                	neg    %eax
    3f77:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3f7a:	eb 06                	jmp    3f82 <printint+0x31>
  } else {
    x = xx;
    3f7c:	8b 45 0c             	mov    0xc(%ebp),%eax
    3f7f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    3f82:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    3f89:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3f8c:	8d 41 01             	lea    0x1(%ecx),%eax
    3f8f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3f92:	8b 5d 10             	mov    0x10(%ebp),%ebx
    3f95:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3f98:	ba 00 00 00 00       	mov    $0x0,%edx
    3f9d:	f7 f3                	div    %ebx
    3f9f:	89 d0                	mov    %edx,%eax
    3fa1:	8a 80 94 62 00 00    	mov    0x6294(%eax),%al
    3fa7:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    3fab:	8b 5d 10             	mov    0x10(%ebp),%ebx
    3fae:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3fb1:	ba 00 00 00 00       	mov    $0x0,%edx
    3fb6:	f7 f3                	div    %ebx
    3fb8:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3fbb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3fbf:	75 c8                	jne    3f89 <printint+0x38>
  if(neg)
    3fc1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3fc5:	74 0e                	je     3fd5 <printint+0x84>
    buf[i++] = '-';
    3fc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3fca:	8d 50 01             	lea    0x1(%eax),%edx
    3fcd:	89 55 f4             	mov    %edx,-0xc(%ebp)
    3fd0:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    3fd5:	eb 1c                	jmp    3ff3 <printint+0xa2>
    putc(fd, buf[i]);
    3fd7:	8d 55 dc             	lea    -0x24(%ebp),%edx
    3fda:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3fdd:	01 d0                	add    %edx,%eax
    3fdf:	8a 00                	mov    (%eax),%al
    3fe1:	0f be c0             	movsbl %al,%eax
    3fe4:	83 ec 08             	sub    $0x8,%esp
    3fe7:	50                   	push   %eax
    3fe8:	ff 75 08             	pushl  0x8(%ebp)
    3feb:	e8 3f ff ff ff       	call   3f2f <putc>
    3ff0:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    3ff3:	ff 4d f4             	decl   -0xc(%ebp)
    3ff6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3ffa:	79 db                	jns    3fd7 <printint+0x86>
    putc(fd, buf[i]);
}
    3ffc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3fff:	c9                   	leave  
    4000:	c3                   	ret    

00004001 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    4001:	55                   	push   %ebp
    4002:	89 e5                	mov    %esp,%ebp
    4004:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    4007:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    400e:	8d 45 0c             	lea    0xc(%ebp),%eax
    4011:	83 c0 04             	add    $0x4,%eax
    4014:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    4017:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    401e:	e9 54 01 00 00       	jmp    4177 <printf+0x176>
    c = fmt[i] & 0xff;
    4023:	8b 55 0c             	mov    0xc(%ebp),%edx
    4026:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4029:	01 d0                	add    %edx,%eax
    402b:	8a 00                	mov    (%eax),%al
    402d:	0f be c0             	movsbl %al,%eax
    4030:	25 ff 00 00 00       	and    $0xff,%eax
    4035:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    4038:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    403c:	75 2c                	jne    406a <printf+0x69>
      if(c == '%'){
    403e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    4042:	75 0c                	jne    4050 <printf+0x4f>
        state = '%';
    4044:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    404b:	e9 24 01 00 00       	jmp    4174 <printf+0x173>
      } else {
        putc(fd, c);
    4050:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4053:	0f be c0             	movsbl %al,%eax
    4056:	83 ec 08             	sub    $0x8,%esp
    4059:	50                   	push   %eax
    405a:	ff 75 08             	pushl  0x8(%ebp)
    405d:	e8 cd fe ff ff       	call   3f2f <putc>
    4062:	83 c4 10             	add    $0x10,%esp
    4065:	e9 0a 01 00 00       	jmp    4174 <printf+0x173>
      }
    } else if(state == '%'){
    406a:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    406e:	0f 85 00 01 00 00    	jne    4174 <printf+0x173>
      if(c == 'd'){
    4074:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    4078:	75 1e                	jne    4098 <printf+0x97>
        printint(fd, *ap, 10, 1);
    407a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    407d:	8b 00                	mov    (%eax),%eax
    407f:	6a 01                	push   $0x1
    4081:	6a 0a                	push   $0xa
    4083:	50                   	push   %eax
    4084:	ff 75 08             	pushl  0x8(%ebp)
    4087:	e8 c5 fe ff ff       	call   3f51 <printint>
    408c:	83 c4 10             	add    $0x10,%esp
        ap++;
    408f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    4093:	e9 d5 00 00 00       	jmp    416d <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
    4098:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    409c:	74 06                	je     40a4 <printf+0xa3>
    409e:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    40a2:	75 1e                	jne    40c2 <printf+0xc1>
        printint(fd, *ap, 16, 0);
    40a4:	8b 45 e8             	mov    -0x18(%ebp),%eax
    40a7:	8b 00                	mov    (%eax),%eax
    40a9:	6a 00                	push   $0x0
    40ab:	6a 10                	push   $0x10
    40ad:	50                   	push   %eax
    40ae:	ff 75 08             	pushl  0x8(%ebp)
    40b1:	e8 9b fe ff ff       	call   3f51 <printint>
    40b6:	83 c4 10             	add    $0x10,%esp
        ap++;
    40b9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    40bd:	e9 ab 00 00 00       	jmp    416d <printf+0x16c>
      } else if(c == 's'){
    40c2:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    40c6:	75 40                	jne    4108 <printf+0x107>
        s = (char*)*ap;
    40c8:	8b 45 e8             	mov    -0x18(%ebp),%eax
    40cb:	8b 00                	mov    (%eax),%eax
    40cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    40d0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    40d4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    40d8:	75 07                	jne    40e1 <printf+0xe0>
          s = "(null)";
    40da:	c7 45 f4 8a 5b 00 00 	movl   $0x5b8a,-0xc(%ebp)
        while(*s != 0){
    40e1:	eb 1a                	jmp    40fd <printf+0xfc>
          putc(fd, *s);
    40e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40e6:	8a 00                	mov    (%eax),%al
    40e8:	0f be c0             	movsbl %al,%eax
    40eb:	83 ec 08             	sub    $0x8,%esp
    40ee:	50                   	push   %eax
    40ef:	ff 75 08             	pushl  0x8(%ebp)
    40f2:	e8 38 fe ff ff       	call   3f2f <putc>
    40f7:	83 c4 10             	add    $0x10,%esp
          s++;
    40fa:	ff 45 f4             	incl   -0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    40fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4100:	8a 00                	mov    (%eax),%al
    4102:	84 c0                	test   %al,%al
    4104:	75 dd                	jne    40e3 <printf+0xe2>
    4106:	eb 65                	jmp    416d <printf+0x16c>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    4108:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    410c:	75 1d                	jne    412b <printf+0x12a>
        putc(fd, *ap);
    410e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    4111:	8b 00                	mov    (%eax),%eax
    4113:	0f be c0             	movsbl %al,%eax
    4116:	83 ec 08             	sub    $0x8,%esp
    4119:	50                   	push   %eax
    411a:	ff 75 08             	pushl  0x8(%ebp)
    411d:	e8 0d fe ff ff       	call   3f2f <putc>
    4122:	83 c4 10             	add    $0x10,%esp
        ap++;
    4125:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    4129:	eb 42                	jmp    416d <printf+0x16c>
      } else if(c == '%'){
    412b:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    412f:	75 17                	jne    4148 <printf+0x147>
        putc(fd, c);
    4131:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4134:	0f be c0             	movsbl %al,%eax
    4137:	83 ec 08             	sub    $0x8,%esp
    413a:	50                   	push   %eax
    413b:	ff 75 08             	pushl  0x8(%ebp)
    413e:	e8 ec fd ff ff       	call   3f2f <putc>
    4143:	83 c4 10             	add    $0x10,%esp
    4146:	eb 25                	jmp    416d <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    4148:	83 ec 08             	sub    $0x8,%esp
    414b:	6a 25                	push   $0x25
    414d:	ff 75 08             	pushl  0x8(%ebp)
    4150:	e8 da fd ff ff       	call   3f2f <putc>
    4155:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    4158:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    415b:	0f be c0             	movsbl %al,%eax
    415e:	83 ec 08             	sub    $0x8,%esp
    4161:	50                   	push   %eax
    4162:	ff 75 08             	pushl  0x8(%ebp)
    4165:	e8 c5 fd ff ff       	call   3f2f <putc>
    416a:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    416d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    4174:	ff 45 f0             	incl   -0x10(%ebp)
    4177:	8b 55 0c             	mov    0xc(%ebp),%edx
    417a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    417d:	01 d0                	add    %edx,%eax
    417f:	8a 00                	mov    (%eax),%al
    4181:	84 c0                	test   %al,%al
    4183:	0f 85 9a fe ff ff    	jne    4023 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    4189:	c9                   	leave  
    418a:	c3                   	ret    

0000418b <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    418b:	55                   	push   %ebp
    418c:	89 e5                	mov    %esp,%ebp
    418e:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    4191:	8b 45 08             	mov    0x8(%ebp),%eax
    4194:	83 e8 08             	sub    $0x8,%eax
    4197:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    419a:	a1 48 63 00 00       	mov    0x6348,%eax
    419f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    41a2:	eb 24                	jmp    41c8 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    41a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    41a7:	8b 00                	mov    (%eax),%eax
    41a9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    41ac:	77 12                	ja     41c0 <free+0x35>
    41ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
    41b1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    41b4:	77 24                	ja     41da <free+0x4f>
    41b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    41b9:	8b 00                	mov    (%eax),%eax
    41bb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    41be:	77 1a                	ja     41da <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    41c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    41c3:	8b 00                	mov    (%eax),%eax
    41c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    41c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    41cb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    41ce:	76 d4                	jbe    41a4 <free+0x19>
    41d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    41d3:	8b 00                	mov    (%eax),%eax
    41d5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    41d8:	76 ca                	jbe    41a4 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    41da:	8b 45 f8             	mov    -0x8(%ebp),%eax
    41dd:	8b 40 04             	mov    0x4(%eax),%eax
    41e0:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    41e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    41ea:	01 c2                	add    %eax,%edx
    41ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
    41ef:	8b 00                	mov    (%eax),%eax
    41f1:	39 c2                	cmp    %eax,%edx
    41f3:	75 24                	jne    4219 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    41f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    41f8:	8b 50 04             	mov    0x4(%eax),%edx
    41fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    41fe:	8b 00                	mov    (%eax),%eax
    4200:	8b 40 04             	mov    0x4(%eax),%eax
    4203:	01 c2                	add    %eax,%edx
    4205:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4208:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    420b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    420e:	8b 00                	mov    (%eax),%eax
    4210:	8b 10                	mov    (%eax),%edx
    4212:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4215:	89 10                	mov    %edx,(%eax)
    4217:	eb 0a                	jmp    4223 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    4219:	8b 45 fc             	mov    -0x4(%ebp),%eax
    421c:	8b 10                	mov    (%eax),%edx
    421e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4221:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    4223:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4226:	8b 40 04             	mov    0x4(%eax),%eax
    4229:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    4230:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4233:	01 d0                	add    %edx,%eax
    4235:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    4238:	75 20                	jne    425a <free+0xcf>
    p->s.size += bp->s.size;
    423a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    423d:	8b 50 04             	mov    0x4(%eax),%edx
    4240:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4243:	8b 40 04             	mov    0x4(%eax),%eax
    4246:	01 c2                	add    %eax,%edx
    4248:	8b 45 fc             	mov    -0x4(%ebp),%eax
    424b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    424e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4251:	8b 10                	mov    (%eax),%edx
    4253:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4256:	89 10                	mov    %edx,(%eax)
    4258:	eb 08                	jmp    4262 <free+0xd7>
  } else
    p->s.ptr = bp;
    425a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    425d:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4260:	89 10                	mov    %edx,(%eax)
  freep = p;
    4262:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4265:	a3 48 63 00 00       	mov    %eax,0x6348
}
    426a:	c9                   	leave  
    426b:	c3                   	ret    

0000426c <morecore>:

static Header*
morecore(uint nu)
{
    426c:	55                   	push   %ebp
    426d:	89 e5                	mov    %esp,%ebp
    426f:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    4272:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    4279:	77 07                	ja     4282 <morecore+0x16>
    nu = 4096;
    427b:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    4282:	8b 45 08             	mov    0x8(%ebp),%eax
    4285:	c1 e0 03             	shl    $0x3,%eax
    4288:	83 ec 0c             	sub    $0xc,%esp
    428b:	50                   	push   %eax
    428c:	e8 86 fc ff ff       	call   3f17 <sbrk>
    4291:	83 c4 10             	add    $0x10,%esp
    4294:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    4297:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    429b:	75 07                	jne    42a4 <morecore+0x38>
    return 0;
    429d:	b8 00 00 00 00       	mov    $0x0,%eax
    42a2:	eb 26                	jmp    42ca <morecore+0x5e>
  hp = (Header*)p;
    42a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    42a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    42aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
    42ad:	8b 55 08             	mov    0x8(%ebp),%edx
    42b0:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    42b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    42b6:	83 c0 08             	add    $0x8,%eax
    42b9:	83 ec 0c             	sub    $0xc,%esp
    42bc:	50                   	push   %eax
    42bd:	e8 c9 fe ff ff       	call   418b <free>
    42c2:	83 c4 10             	add    $0x10,%esp
  return freep;
    42c5:	a1 48 63 00 00       	mov    0x6348,%eax
}
    42ca:	c9                   	leave  
    42cb:	c3                   	ret    

000042cc <malloc>:

void*
malloc(uint nbytes)
{
    42cc:	55                   	push   %ebp
    42cd:	89 e5                	mov    %esp,%ebp
    42cf:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    42d2:	8b 45 08             	mov    0x8(%ebp),%eax
    42d5:	83 c0 07             	add    $0x7,%eax
    42d8:	c1 e8 03             	shr    $0x3,%eax
    42db:	40                   	inc    %eax
    42dc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    42df:	a1 48 63 00 00       	mov    0x6348,%eax
    42e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    42e7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    42eb:	75 23                	jne    4310 <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
    42ed:	c7 45 f0 40 63 00 00 	movl   $0x6340,-0x10(%ebp)
    42f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    42f7:	a3 48 63 00 00       	mov    %eax,0x6348
    42fc:	a1 48 63 00 00       	mov    0x6348,%eax
    4301:	a3 40 63 00 00       	mov    %eax,0x6340
    base.s.size = 0;
    4306:	c7 05 44 63 00 00 00 	movl   $0x0,0x6344
    430d:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4310:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4313:	8b 00                	mov    (%eax),%eax
    4315:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    4318:	8b 45 f4             	mov    -0xc(%ebp),%eax
    431b:	8b 40 04             	mov    0x4(%eax),%eax
    431e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    4321:	72 4d                	jb     4370 <malloc+0xa4>
      if(p->s.size == nunits)
    4323:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4326:	8b 40 04             	mov    0x4(%eax),%eax
    4329:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    432c:	75 0c                	jne    433a <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
    432e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4331:	8b 10                	mov    (%eax),%edx
    4333:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4336:	89 10                	mov    %edx,(%eax)
    4338:	eb 26                	jmp    4360 <malloc+0x94>
      else {
        p->s.size -= nunits;
    433a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    433d:	8b 40 04             	mov    0x4(%eax),%eax
    4340:	2b 45 ec             	sub    -0x14(%ebp),%eax
    4343:	89 c2                	mov    %eax,%edx
    4345:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4348:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    434b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    434e:	8b 40 04             	mov    0x4(%eax),%eax
    4351:	c1 e0 03             	shl    $0x3,%eax
    4354:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    4357:	8b 45 f4             	mov    -0xc(%ebp),%eax
    435a:	8b 55 ec             	mov    -0x14(%ebp),%edx
    435d:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    4360:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4363:	a3 48 63 00 00       	mov    %eax,0x6348
      return (void*)(p + 1);
    4368:	8b 45 f4             	mov    -0xc(%ebp),%eax
    436b:	83 c0 08             	add    $0x8,%eax
    436e:	eb 3b                	jmp    43ab <malloc+0xdf>
    }
    if(p == freep)
    4370:	a1 48 63 00 00       	mov    0x6348,%eax
    4375:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    4378:	75 1e                	jne    4398 <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
    437a:	83 ec 0c             	sub    $0xc,%esp
    437d:	ff 75 ec             	pushl  -0x14(%ebp)
    4380:	e8 e7 fe ff ff       	call   426c <morecore>
    4385:	83 c4 10             	add    $0x10,%esp
    4388:	89 45 f4             	mov    %eax,-0xc(%ebp)
    438b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    438f:	75 07                	jne    4398 <malloc+0xcc>
        return 0;
    4391:	b8 00 00 00 00       	mov    $0x0,%eax
    4396:	eb 13                	jmp    43ab <malloc+0xdf>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4398:	8b 45 f4             	mov    -0xc(%ebp),%eax
    439b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    439e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    43a1:	8b 00                	mov    (%eax),%eax
    43a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    43a6:	e9 6d ff ff ff       	jmp    4318 <malloc+0x4c>
}
    43ab:	c9                   	leave  
    43ac:	c3                   	ret    
