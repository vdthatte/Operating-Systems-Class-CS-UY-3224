
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
       6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
       a:	75 05                	jne    11 <runcmd+0x11>
    exit();
       c:	e8 89 0e 00 00       	call   e9a <exit>
  
  switch(cmd->type){
      11:	8b 45 08             	mov    0x8(%ebp),%eax
      14:	8b 00                	mov    (%eax),%eax
      16:	83 f8 05             	cmp    $0x5,%eax
      19:	77 09                	ja     24 <runcmd+0x24>
      1b:	8b 04 85 e4 13 00 00 	mov    0x13e4(,%eax,4),%eax
      22:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      24:	83 ec 0c             	sub    $0xc,%esp
      27:	68 b8 13 00 00       	push   $0x13b8
      2c:	e8 62 03 00 00       	call   393 <panic>
      31:	83 c4 10             	add    $0x10,%esp

  case EXEC:
    ecmd = (struct execcmd*)cmd;
      34:	8b 45 08             	mov    0x8(%ebp),%eax
      37:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ecmd->argv[0] == 0)
      3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
      3d:	8b 40 04             	mov    0x4(%eax),%eax
      40:	85 c0                	test   %eax,%eax
      42:	75 05                	jne    49 <runcmd+0x49>
      exit();
      44:	e8 51 0e 00 00       	call   e9a <exit>
    exec(ecmd->argv[0], ecmd->argv);
      49:	8b 45 f4             	mov    -0xc(%ebp),%eax
      4c:	8d 50 04             	lea    0x4(%eax),%edx
      4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
      52:	8b 40 04             	mov    0x4(%eax),%eax
      55:	83 ec 08             	sub    $0x8,%esp
      58:	52                   	push   %edx
      59:	50                   	push   %eax
      5a:	e8 73 0e 00 00       	call   ed2 <exec>
      5f:	83 c4 10             	add    $0x10,%esp
    printf(2, "exec %s failed\n", ecmd->argv[0]);
      62:	8b 45 f4             	mov    -0xc(%ebp),%eax
      65:	8b 40 04             	mov    0x4(%eax),%eax
      68:	83 ec 04             	sub    $0x4,%esp
      6b:	50                   	push   %eax
      6c:	68 bf 13 00 00       	push   $0x13bf
      71:	6a 02                	push   $0x2
      73:	e8 94 0f 00 00       	call   100c <printf>
      78:	83 c4 10             	add    $0x10,%esp
    break;
      7b:	e9 c8 01 00 00       	jmp    248 <runcmd+0x248>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      80:	8b 45 08             	mov    0x8(%ebp),%eax
      83:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(rcmd->fd);
      86:	8b 45 f0             	mov    -0x10(%ebp),%eax
      89:	8b 40 14             	mov    0x14(%eax),%eax
      8c:	83 ec 0c             	sub    $0xc,%esp
      8f:	50                   	push   %eax
      90:	e8 2d 0e 00 00       	call   ec2 <close>
      95:	83 c4 10             	add    $0x10,%esp
    if(open(rcmd->file, rcmd->mode) < 0){
      98:	8b 45 f0             	mov    -0x10(%ebp),%eax
      9b:	8b 50 10             	mov    0x10(%eax),%edx
      9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
      a1:	8b 40 08             	mov    0x8(%eax),%eax
      a4:	83 ec 08             	sub    $0x8,%esp
      a7:	52                   	push   %edx
      a8:	50                   	push   %eax
      a9:	e8 2c 0e 00 00       	call   eda <open>
      ae:	83 c4 10             	add    $0x10,%esp
      b1:	85 c0                	test   %eax,%eax
      b3:	79 1e                	jns    d3 <runcmd+0xd3>
      printf(2, "open %s failed\n", rcmd->file);
      b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
      b8:	8b 40 08             	mov    0x8(%eax),%eax
      bb:	83 ec 04             	sub    $0x4,%esp
      be:	50                   	push   %eax
      bf:	68 cf 13 00 00       	push   $0x13cf
      c4:	6a 02                	push   $0x2
      c6:	e8 41 0f 00 00       	call   100c <printf>
      cb:	83 c4 10             	add    $0x10,%esp
      exit();
      ce:	e8 c7 0d 00 00       	call   e9a <exit>
    }
    runcmd(rcmd->cmd);
      d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
      d6:	8b 40 04             	mov    0x4(%eax),%eax
      d9:	83 ec 0c             	sub    $0xc,%esp
      dc:	50                   	push   %eax
      dd:	e8 1e ff ff ff       	call   0 <runcmd>
      e2:	83 c4 10             	add    $0x10,%esp
    break;
      e5:	e9 5e 01 00 00       	jmp    248 <runcmd+0x248>

  case LIST:
    lcmd = (struct listcmd*)cmd;
      ea:	8b 45 08             	mov    0x8(%ebp),%eax
      ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fork1() == 0)
      f0:	e8 be 02 00 00       	call   3b3 <fork1>
      f5:	85 c0                	test   %eax,%eax
      f7:	75 12                	jne    10b <runcmd+0x10b>
      runcmd(lcmd->left);
      f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
      fc:	8b 40 04             	mov    0x4(%eax),%eax
      ff:	83 ec 0c             	sub    $0xc,%esp
     102:	50                   	push   %eax
     103:	e8 f8 fe ff ff       	call   0 <runcmd>
     108:	83 c4 10             	add    $0x10,%esp
    wait();
     10b:	e8 92 0d 00 00       	call   ea2 <wait>
    runcmd(lcmd->right);
     110:	8b 45 ec             	mov    -0x14(%ebp),%eax
     113:	8b 40 08             	mov    0x8(%eax),%eax
     116:	83 ec 0c             	sub    $0xc,%esp
     119:	50                   	push   %eax
     11a:	e8 e1 fe ff ff       	call   0 <runcmd>
     11f:	83 c4 10             	add    $0x10,%esp
    break;
     122:	e9 21 01 00 00       	jmp    248 <runcmd+0x248>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     127:	8b 45 08             	mov    0x8(%ebp),%eax
     12a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pipe(p) < 0)
     12d:	83 ec 0c             	sub    $0xc,%esp
     130:	8d 45 dc             	lea    -0x24(%ebp),%eax
     133:	50                   	push   %eax
     134:	e8 71 0d 00 00       	call   eaa <pipe>
     139:	83 c4 10             	add    $0x10,%esp
     13c:	85 c0                	test   %eax,%eax
     13e:	79 10                	jns    150 <runcmd+0x150>
      panic("pipe");
     140:	83 ec 0c             	sub    $0xc,%esp
     143:	68 df 13 00 00       	push   $0x13df
     148:	e8 46 02 00 00       	call   393 <panic>
     14d:	83 c4 10             	add    $0x10,%esp
    if(fork1() == 0){
     150:	e8 5e 02 00 00       	call   3b3 <fork1>
     155:	85 c0                	test   %eax,%eax
     157:	75 4c                	jne    1a5 <runcmd+0x1a5>
      close(1);
     159:	83 ec 0c             	sub    $0xc,%esp
     15c:	6a 01                	push   $0x1
     15e:	e8 5f 0d 00 00       	call   ec2 <close>
     163:	83 c4 10             	add    $0x10,%esp
      dup(p[1]);
     166:	8b 45 e0             	mov    -0x20(%ebp),%eax
     169:	83 ec 0c             	sub    $0xc,%esp
     16c:	50                   	push   %eax
     16d:	e8 a0 0d 00 00       	call   f12 <dup>
     172:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     175:	8b 45 dc             	mov    -0x24(%ebp),%eax
     178:	83 ec 0c             	sub    $0xc,%esp
     17b:	50                   	push   %eax
     17c:	e8 41 0d 00 00       	call   ec2 <close>
     181:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     184:	8b 45 e0             	mov    -0x20(%ebp),%eax
     187:	83 ec 0c             	sub    $0xc,%esp
     18a:	50                   	push   %eax
     18b:	e8 32 0d 00 00       	call   ec2 <close>
     190:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->left);
     193:	8b 45 e8             	mov    -0x18(%ebp),%eax
     196:	8b 40 04             	mov    0x4(%eax),%eax
     199:	83 ec 0c             	sub    $0xc,%esp
     19c:	50                   	push   %eax
     19d:	e8 5e fe ff ff       	call   0 <runcmd>
     1a2:	83 c4 10             	add    $0x10,%esp
    }
    if(fork1() == 0){
     1a5:	e8 09 02 00 00       	call   3b3 <fork1>
     1aa:	85 c0                	test   %eax,%eax
     1ac:	75 4c                	jne    1fa <runcmd+0x1fa>
      close(0);
     1ae:	83 ec 0c             	sub    $0xc,%esp
     1b1:	6a 00                	push   $0x0
     1b3:	e8 0a 0d 00 00       	call   ec2 <close>
     1b8:	83 c4 10             	add    $0x10,%esp
      dup(p[0]);
     1bb:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1be:	83 ec 0c             	sub    $0xc,%esp
     1c1:	50                   	push   %eax
     1c2:	e8 4b 0d 00 00       	call   f12 <dup>
     1c7:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     1ca:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1cd:	83 ec 0c             	sub    $0xc,%esp
     1d0:	50                   	push   %eax
     1d1:	e8 ec 0c 00 00       	call   ec2 <close>
     1d6:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     1d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1dc:	83 ec 0c             	sub    $0xc,%esp
     1df:	50                   	push   %eax
     1e0:	e8 dd 0c 00 00       	call   ec2 <close>
     1e5:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->right);
     1e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
     1eb:	8b 40 08             	mov    0x8(%eax),%eax
     1ee:	83 ec 0c             	sub    $0xc,%esp
     1f1:	50                   	push   %eax
     1f2:	e8 09 fe ff ff       	call   0 <runcmd>
     1f7:	83 c4 10             	add    $0x10,%esp
    }
    close(p[0]);
     1fa:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1fd:	83 ec 0c             	sub    $0xc,%esp
     200:	50                   	push   %eax
     201:	e8 bc 0c 00 00       	call   ec2 <close>
     206:	83 c4 10             	add    $0x10,%esp
    close(p[1]);
     209:	8b 45 e0             	mov    -0x20(%ebp),%eax
     20c:	83 ec 0c             	sub    $0xc,%esp
     20f:	50                   	push   %eax
     210:	e8 ad 0c 00 00       	call   ec2 <close>
     215:	83 c4 10             	add    $0x10,%esp
    wait();
     218:	e8 85 0c 00 00       	call   ea2 <wait>
    wait();
     21d:	e8 80 0c 00 00       	call   ea2 <wait>
    break;
     222:	eb 24                	jmp    248 <runcmd+0x248>
    
  case BACK:
    bcmd = (struct backcmd*)cmd;
     224:	8b 45 08             	mov    0x8(%ebp),%eax
     227:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(fork1() == 0)
     22a:	e8 84 01 00 00       	call   3b3 <fork1>
     22f:	85 c0                	test   %eax,%eax
     231:	75 14                	jne    247 <runcmd+0x247>
      runcmd(bcmd->cmd);
     233:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     236:	8b 40 04             	mov    0x4(%eax),%eax
     239:	83 ec 0c             	sub    $0xc,%esp
     23c:	50                   	push   %eax
     23d:	e8 be fd ff ff       	call   0 <runcmd>
     242:	83 c4 10             	add    $0x10,%esp
    break;
     245:	eb 00                	jmp    247 <runcmd+0x247>
     247:	90                   	nop
  }
  exit();
     248:	e8 4d 0c 00 00       	call   e9a <exit>

0000024d <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     24d:	55                   	push   %ebp
     24e:	89 e5                	mov    %esp,%ebp
     250:	83 ec 08             	sub    $0x8,%esp
  printf(2, "$ ");
     253:	83 ec 08             	sub    $0x8,%esp
     256:	68 fc 13 00 00       	push   $0x13fc
     25b:	6a 02                	push   $0x2
     25d:	e8 aa 0d 00 00       	call   100c <printf>
     262:	83 c4 10             	add    $0x10,%esp
  memset(buf, 0, nbuf);
     265:	8b 45 0c             	mov    0xc(%ebp),%eax
     268:	83 ec 04             	sub    $0x4,%esp
     26b:	50                   	push   %eax
     26c:	6a 00                	push   $0x0
     26e:	ff 75 08             	pushl  0x8(%ebp)
     271:	e8 96 0a 00 00       	call   d0c <memset>
     276:	83 c4 10             	add    $0x10,%esp
  gets(buf, nbuf);
     279:	83 ec 08             	sub    $0x8,%esp
     27c:	ff 75 0c             	pushl  0xc(%ebp)
     27f:	ff 75 08             	pushl  0x8(%ebp)
     282:	e8 cf 0a 00 00       	call   d56 <gets>
     287:	83 c4 10             	add    $0x10,%esp
  if(buf[0] == 0) // EOF
     28a:	8b 45 08             	mov    0x8(%ebp),%eax
     28d:	8a 00                	mov    (%eax),%al
     28f:	84 c0                	test   %al,%al
     291:	75 07                	jne    29a <getcmd+0x4d>
    return -1;
     293:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     298:	eb 05                	jmp    29f <getcmd+0x52>
  return 0;
     29a:	b8 00 00 00 00       	mov    $0x0,%eax
}
     29f:	c9                   	leave  
     2a0:	c3                   	ret    

000002a1 <main>:

int
main(void)
{
     2a1:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     2a5:	83 e4 f0             	and    $0xfffffff0,%esp
     2a8:	ff 71 fc             	pushl  -0x4(%ecx)
     2ab:	55                   	push   %ebp
     2ac:	89 e5                	mov    %esp,%ebp
     2ae:	51                   	push   %ecx
     2af:	83 ec 14             	sub    $0x14,%esp
  static char buf[100];
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     2b2:	eb 16                	jmp    2ca <main+0x29>
    if(fd >= 3){
     2b4:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
     2b8:	7e 10                	jle    2ca <main+0x29>
      close(fd);
     2ba:	83 ec 0c             	sub    $0xc,%esp
     2bd:	ff 75 f4             	pushl  -0xc(%ebp)
     2c0:	e8 fd 0b 00 00       	call   ec2 <close>
     2c5:	83 c4 10             	add    $0x10,%esp
      break;
     2c8:	eb 1b                	jmp    2e5 <main+0x44>
{
  static char buf[100];
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     2ca:	83 ec 08             	sub    $0x8,%esp
     2cd:	6a 02                	push   $0x2
     2cf:	68 ff 13 00 00       	push   $0x13ff
     2d4:	e8 01 0c 00 00       	call   eda <open>
     2d9:	83 c4 10             	add    $0x10,%esp
     2dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
     2df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     2e3:	79 cf                	jns    2b4 <main+0x13>
      break;
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     2e5:	e9 8a 00 00 00       	jmp    374 <main+0xd3>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     2ea:	a0 60 19 00 00       	mov    0x1960,%al
     2ef:	3c 63                	cmp    $0x63,%al
     2f1:	75 57                	jne    34a <main+0xa9>
     2f3:	a0 61 19 00 00       	mov    0x1961,%al
     2f8:	3c 64                	cmp    $0x64,%al
     2fa:	75 4e                	jne    34a <main+0xa9>
     2fc:	a0 62 19 00 00       	mov    0x1962,%al
     301:	3c 20                	cmp    $0x20,%al
     303:	75 45                	jne    34a <main+0xa9>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     305:	83 ec 0c             	sub    $0xc,%esp
     308:	68 60 19 00 00       	push   $0x1960
     30d:	e8 d5 09 00 00       	call   ce7 <strlen>
     312:	83 c4 10             	add    $0x10,%esp
     315:	48                   	dec    %eax
     316:	c6 80 60 19 00 00 00 	movb   $0x0,0x1960(%eax)
      if(chdir(buf+3) < 0)
     31d:	83 ec 0c             	sub    $0xc,%esp
     320:	68 63 19 00 00       	push   $0x1963
     325:	e8 e0 0b 00 00       	call   f0a <chdir>
     32a:	83 c4 10             	add    $0x10,%esp
     32d:	85 c0                	test   %eax,%eax
     32f:	79 17                	jns    348 <main+0xa7>
        printf(2, "cannot cd %s\n", buf+3);
     331:	83 ec 04             	sub    $0x4,%esp
     334:	68 63 19 00 00       	push   $0x1963
     339:	68 07 14 00 00       	push   $0x1407
     33e:	6a 02                	push   $0x2
     340:	e8 c7 0c 00 00       	call   100c <printf>
     345:	83 c4 10             	add    $0x10,%esp
      continue;
     348:	eb 2a                	jmp    374 <main+0xd3>
    }
    if(fork1() == 0)
     34a:	e8 64 00 00 00       	call   3b3 <fork1>
     34f:	85 c0                	test   %eax,%eax
     351:	75 1c                	jne    36f <main+0xce>
      runcmd(parsecmd(buf));
     353:	83 ec 0c             	sub    $0xc,%esp
     356:	68 60 19 00 00       	push   $0x1960
     35b:	e8 96 03 00 00       	call   6f6 <parsecmd>
     360:	83 c4 10             	add    $0x10,%esp
     363:	83 ec 0c             	sub    $0xc,%esp
     366:	50                   	push   %eax
     367:	e8 94 fc ff ff       	call   0 <runcmd>
     36c:	83 c4 10             	add    $0x10,%esp
    wait();
     36f:	e8 2e 0b 00 00       	call   ea2 <wait>
      break;
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     374:	83 ec 08             	sub    $0x8,%esp
     377:	6a 64                	push   $0x64
     379:	68 60 19 00 00       	push   $0x1960
     37e:	e8 ca fe ff ff       	call   24d <getcmd>
     383:	83 c4 10             	add    $0x10,%esp
     386:	85 c0                	test   %eax,%eax
     388:	0f 89 5c ff ff ff    	jns    2ea <main+0x49>
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    wait();
  }
  exit();
     38e:	e8 07 0b 00 00       	call   e9a <exit>

00000393 <panic>:
}

void
panic(char *s)
{
     393:	55                   	push   %ebp
     394:	89 e5                	mov    %esp,%ebp
     396:	83 ec 08             	sub    $0x8,%esp
  printf(2, "%s\n", s);
     399:	83 ec 04             	sub    $0x4,%esp
     39c:	ff 75 08             	pushl  0x8(%ebp)
     39f:	68 15 14 00 00       	push   $0x1415
     3a4:	6a 02                	push   $0x2
     3a6:	e8 61 0c 00 00       	call   100c <printf>
     3ab:	83 c4 10             	add    $0x10,%esp
  exit();
     3ae:	e8 e7 0a 00 00       	call   e9a <exit>

000003b3 <fork1>:
}

int
fork1(void)
{
     3b3:	55                   	push   %ebp
     3b4:	89 e5                	mov    %esp,%ebp
     3b6:	83 ec 18             	sub    $0x18,%esp
  int pid;
  
  pid = fork();
     3b9:	e8 d4 0a 00 00       	call   e92 <fork>
     3be:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid == -1)
     3c1:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     3c5:	75 10                	jne    3d7 <fork1+0x24>
    panic("fork");
     3c7:	83 ec 0c             	sub    $0xc,%esp
     3ca:	68 19 14 00 00       	push   $0x1419
     3cf:	e8 bf ff ff ff       	call   393 <panic>
     3d4:	83 c4 10             	add    $0x10,%esp
  return pid;
     3d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     3da:	c9                   	leave  
     3db:	c3                   	ret    

000003dc <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     3dc:	55                   	push   %ebp
     3dd:	89 e5                	mov    %esp,%ebp
     3df:	83 ec 18             	sub    $0x18,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3e2:	83 ec 0c             	sub    $0xc,%esp
     3e5:	6a 54                	push   $0x54
     3e7:	e8 eb 0e 00 00       	call   12d7 <malloc>
     3ec:	83 c4 10             	add    $0x10,%esp
     3ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     3f2:	83 ec 04             	sub    $0x4,%esp
     3f5:	6a 54                	push   $0x54
     3f7:	6a 00                	push   $0x0
     3f9:	ff 75 f4             	pushl  -0xc(%ebp)
     3fc:	e8 0b 09 00 00       	call   d0c <memset>
     401:	83 c4 10             	add    $0x10,%esp
  cmd->type = EXEC;
     404:	8b 45 f4             	mov    -0xc(%ebp),%eax
     407:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
     40d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     410:	c9                   	leave  
     411:	c3                   	ret    

00000412 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     412:	55                   	push   %ebp
     413:	89 e5                	mov    %esp,%ebp
     415:	83 ec 18             	sub    $0x18,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     418:	83 ec 0c             	sub    $0xc,%esp
     41b:	6a 18                	push   $0x18
     41d:	e8 b5 0e 00 00       	call   12d7 <malloc>
     422:	83 c4 10             	add    $0x10,%esp
     425:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     428:	83 ec 04             	sub    $0x4,%esp
     42b:	6a 18                	push   $0x18
     42d:	6a 00                	push   $0x0
     42f:	ff 75 f4             	pushl  -0xc(%ebp)
     432:	e8 d5 08 00 00       	call   d0c <memset>
     437:	83 c4 10             	add    $0x10,%esp
  cmd->type = REDIR;
     43a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     43d:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
     443:	8b 45 f4             	mov    -0xc(%ebp),%eax
     446:	8b 55 08             	mov    0x8(%ebp),%edx
     449:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->file = file;
     44c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     44f:	8b 55 0c             	mov    0xc(%ebp),%edx
     452:	89 50 08             	mov    %edx,0x8(%eax)
  cmd->efile = efile;
     455:	8b 45 f4             	mov    -0xc(%ebp),%eax
     458:	8b 55 10             	mov    0x10(%ebp),%edx
     45b:	89 50 0c             	mov    %edx,0xc(%eax)
  cmd->mode = mode;
     45e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     461:	8b 55 14             	mov    0x14(%ebp),%edx
     464:	89 50 10             	mov    %edx,0x10(%eax)
  cmd->fd = fd;
     467:	8b 45 f4             	mov    -0xc(%ebp),%eax
     46a:	8b 55 18             	mov    0x18(%ebp),%edx
     46d:	89 50 14             	mov    %edx,0x14(%eax)
  return (struct cmd*)cmd;
     470:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     473:	c9                   	leave  
     474:	c3                   	ret    

00000475 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     475:	55                   	push   %ebp
     476:	89 e5                	mov    %esp,%ebp
     478:	83 ec 18             	sub    $0x18,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     47b:	83 ec 0c             	sub    $0xc,%esp
     47e:	6a 0c                	push   $0xc
     480:	e8 52 0e 00 00       	call   12d7 <malloc>
     485:	83 c4 10             	add    $0x10,%esp
     488:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     48b:	83 ec 04             	sub    $0x4,%esp
     48e:	6a 0c                	push   $0xc
     490:	6a 00                	push   $0x0
     492:	ff 75 f4             	pushl  -0xc(%ebp)
     495:	e8 72 08 00 00       	call   d0c <memset>
     49a:	83 c4 10             	add    $0x10,%esp
  cmd->type = PIPE;
     49d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4a0:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
     4a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4a9:	8b 55 08             	mov    0x8(%ebp),%edx
     4ac:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     4af:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4b2:	8b 55 0c             	mov    0xc(%ebp),%edx
     4b5:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     4b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     4bb:	c9                   	leave  
     4bc:	c3                   	ret    

000004bd <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     4bd:	55                   	push   %ebp
     4be:	89 e5                	mov    %esp,%ebp
     4c0:	83 ec 18             	sub    $0x18,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4c3:	83 ec 0c             	sub    $0xc,%esp
     4c6:	6a 0c                	push   $0xc
     4c8:	e8 0a 0e 00 00       	call   12d7 <malloc>
     4cd:	83 c4 10             	add    $0x10,%esp
     4d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     4d3:	83 ec 04             	sub    $0x4,%esp
     4d6:	6a 0c                	push   $0xc
     4d8:	6a 00                	push   $0x0
     4da:	ff 75 f4             	pushl  -0xc(%ebp)
     4dd:	e8 2a 08 00 00       	call   d0c <memset>
     4e2:	83 c4 10             	add    $0x10,%esp
  cmd->type = LIST;
     4e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4e8:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
     4ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4f1:	8b 55 08             	mov    0x8(%ebp),%edx
     4f4:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     4f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4fa:	8b 55 0c             	mov    0xc(%ebp),%edx
     4fd:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     500:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     503:	c9                   	leave  
     504:	c3                   	ret    

00000505 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     505:	55                   	push   %ebp
     506:	89 e5                	mov    %esp,%ebp
     508:	83 ec 18             	sub    $0x18,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     50b:	83 ec 0c             	sub    $0xc,%esp
     50e:	6a 08                	push   $0x8
     510:	e8 c2 0d 00 00       	call   12d7 <malloc>
     515:	83 c4 10             	add    $0x10,%esp
     518:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     51b:	83 ec 04             	sub    $0x4,%esp
     51e:	6a 08                	push   $0x8
     520:	6a 00                	push   $0x0
     522:	ff 75 f4             	pushl  -0xc(%ebp)
     525:	e8 e2 07 00 00       	call   d0c <memset>
     52a:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     52d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     530:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
     536:	8b 45 f4             	mov    -0xc(%ebp),%eax
     539:	8b 55 08             	mov    0x8(%ebp),%edx
     53c:	89 50 04             	mov    %edx,0x4(%eax)
  return (struct cmd*)cmd;
     53f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     542:	c9                   	leave  
     543:	c3                   	ret    

00000544 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     544:	55                   	push   %ebp
     545:	89 e5                	mov    %esp,%ebp
     547:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int ret;
  
  s = *ps;
     54a:	8b 45 08             	mov    0x8(%ebp),%eax
     54d:	8b 00                	mov    (%eax),%eax
     54f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     552:	eb 03                	jmp    557 <gettoken+0x13>
    s++;
     554:	ff 45 f4             	incl   -0xc(%ebp)
{
  char *s;
  int ret;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     557:	8b 45 f4             	mov    -0xc(%ebp),%eax
     55a:	3b 45 0c             	cmp    0xc(%ebp),%eax
     55d:	73 1d                	jae    57c <gettoken+0x38>
     55f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     562:	8a 00                	mov    (%eax),%al
     564:	0f be c0             	movsbl %al,%eax
     567:	83 ec 08             	sub    $0x8,%esp
     56a:	50                   	push   %eax
     56b:	68 34 19 00 00       	push   $0x1934
     570:	e8 b1 07 00 00       	call   d26 <strchr>
     575:	83 c4 10             	add    $0x10,%esp
     578:	85 c0                	test   %eax,%eax
     57a:	75 d8                	jne    554 <gettoken+0x10>
    s++;
  if(q)
     57c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     580:	74 08                	je     58a <gettoken+0x46>
    *q = s;
     582:	8b 45 10             	mov    0x10(%ebp),%eax
     585:	8b 55 f4             	mov    -0xc(%ebp),%edx
     588:	89 10                	mov    %edx,(%eax)
  ret = *s;
     58a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     58d:	8a 00                	mov    (%eax),%al
     58f:	0f be c0             	movsbl %al,%eax
     592:	89 45 f0             	mov    %eax,-0x10(%ebp)
  switch(*s){
     595:	8b 45 f4             	mov    -0xc(%ebp),%eax
     598:	8a 00                	mov    (%eax),%al
     59a:	0f be c0             	movsbl %al,%eax
     59d:	83 f8 29             	cmp    $0x29,%eax
     5a0:	7f 14                	jg     5b6 <gettoken+0x72>
     5a2:	83 f8 28             	cmp    $0x28,%eax
     5a5:	7d 28                	jge    5cf <gettoken+0x8b>
     5a7:	85 c0                	test   %eax,%eax
     5a9:	0f 84 8f 00 00 00    	je     63e <gettoken+0xfa>
     5af:	83 f8 26             	cmp    $0x26,%eax
     5b2:	74 1b                	je     5cf <gettoken+0x8b>
     5b4:	eb 38                	jmp    5ee <gettoken+0xaa>
     5b6:	83 f8 3e             	cmp    $0x3e,%eax
     5b9:	74 19                	je     5d4 <gettoken+0x90>
     5bb:	83 f8 3e             	cmp    $0x3e,%eax
     5be:	7f 0a                	jg     5ca <gettoken+0x86>
     5c0:	83 e8 3b             	sub    $0x3b,%eax
     5c3:	83 f8 01             	cmp    $0x1,%eax
     5c6:	77 26                	ja     5ee <gettoken+0xaa>
     5c8:	eb 05                	jmp    5cf <gettoken+0x8b>
     5ca:	83 f8 7c             	cmp    $0x7c,%eax
     5cd:	75 1f                	jne    5ee <gettoken+0xaa>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     5cf:	ff 45 f4             	incl   -0xc(%ebp)
    break;
     5d2:	eb 6b                	jmp    63f <gettoken+0xfb>
  case '>':
    s++;
     5d4:	ff 45 f4             	incl   -0xc(%ebp)
    if(*s == '>'){
     5d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5da:	8a 00                	mov    (%eax),%al
     5dc:	3c 3e                	cmp    $0x3e,%al
     5de:	75 0c                	jne    5ec <gettoken+0xa8>
      ret = '+';
     5e0:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
      s++;
     5e7:	ff 45 f4             	incl   -0xc(%ebp)
    }
    break;
     5ea:	eb 53                	jmp    63f <gettoken+0xfb>
     5ec:	eb 51                	jmp    63f <gettoken+0xfb>
  default:
    ret = 'a';
     5ee:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5f5:	eb 03                	jmp    5fa <gettoken+0xb6>
      s++;
     5f7:	ff 45 f4             	incl   -0xc(%ebp)
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5fd:	3b 45 0c             	cmp    0xc(%ebp),%eax
     600:	73 3a                	jae    63c <gettoken+0xf8>
     602:	8b 45 f4             	mov    -0xc(%ebp),%eax
     605:	8a 00                	mov    (%eax),%al
     607:	0f be c0             	movsbl %al,%eax
     60a:	83 ec 08             	sub    $0x8,%esp
     60d:	50                   	push   %eax
     60e:	68 34 19 00 00       	push   $0x1934
     613:	e8 0e 07 00 00       	call   d26 <strchr>
     618:	83 c4 10             	add    $0x10,%esp
     61b:	85 c0                	test   %eax,%eax
     61d:	75 1d                	jne    63c <gettoken+0xf8>
     61f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     622:	8a 00                	mov    (%eax),%al
     624:	0f be c0             	movsbl %al,%eax
     627:	83 ec 08             	sub    $0x8,%esp
     62a:	50                   	push   %eax
     62b:	68 3c 19 00 00       	push   $0x193c
     630:	e8 f1 06 00 00       	call   d26 <strchr>
     635:	83 c4 10             	add    $0x10,%esp
     638:	85 c0                	test   %eax,%eax
     63a:	74 bb                	je     5f7 <gettoken+0xb3>
      s++;
    break;
     63c:	eb 01                	jmp    63f <gettoken+0xfb>
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
  case 0:
    break;
     63e:	90                   	nop
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     63f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     643:	74 08                	je     64d <gettoken+0x109>
    *eq = s;
     645:	8b 45 14             	mov    0x14(%ebp),%eax
     648:	8b 55 f4             	mov    -0xc(%ebp),%edx
     64b:	89 10                	mov    %edx,(%eax)
  
  while(s < es && strchr(whitespace, *s))
     64d:	eb 03                	jmp    652 <gettoken+0x10e>
    s++;
     64f:	ff 45 f4             	incl   -0xc(%ebp)
    break;
  }
  if(eq)
    *eq = s;
  
  while(s < es && strchr(whitespace, *s))
     652:	8b 45 f4             	mov    -0xc(%ebp),%eax
     655:	3b 45 0c             	cmp    0xc(%ebp),%eax
     658:	73 1d                	jae    677 <gettoken+0x133>
     65a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     65d:	8a 00                	mov    (%eax),%al
     65f:	0f be c0             	movsbl %al,%eax
     662:	83 ec 08             	sub    $0x8,%esp
     665:	50                   	push   %eax
     666:	68 34 19 00 00       	push   $0x1934
     66b:	e8 b6 06 00 00       	call   d26 <strchr>
     670:	83 c4 10             	add    $0x10,%esp
     673:	85 c0                	test   %eax,%eax
     675:	75 d8                	jne    64f <gettoken+0x10b>
    s++;
  *ps = s;
     677:	8b 45 08             	mov    0x8(%ebp),%eax
     67a:	8b 55 f4             	mov    -0xc(%ebp),%edx
     67d:	89 10                	mov    %edx,(%eax)
  return ret;
     67f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     682:	c9                   	leave  
     683:	c3                   	ret    

00000684 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     684:	55                   	push   %ebp
     685:	89 e5                	mov    %esp,%ebp
     687:	83 ec 18             	sub    $0x18,%esp
  char *s;
  
  s = *ps;
     68a:	8b 45 08             	mov    0x8(%ebp),%eax
     68d:	8b 00                	mov    (%eax),%eax
     68f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     692:	eb 03                	jmp    697 <peek+0x13>
    s++;
     694:	ff 45 f4             	incl   -0xc(%ebp)
peek(char **ps, char *es, char *toks)
{
  char *s;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     697:	8b 45 f4             	mov    -0xc(%ebp),%eax
     69a:	3b 45 0c             	cmp    0xc(%ebp),%eax
     69d:	73 1d                	jae    6bc <peek+0x38>
     69f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6a2:	8a 00                	mov    (%eax),%al
     6a4:	0f be c0             	movsbl %al,%eax
     6a7:	83 ec 08             	sub    $0x8,%esp
     6aa:	50                   	push   %eax
     6ab:	68 34 19 00 00       	push   $0x1934
     6b0:	e8 71 06 00 00       	call   d26 <strchr>
     6b5:	83 c4 10             	add    $0x10,%esp
     6b8:	85 c0                	test   %eax,%eax
     6ba:	75 d8                	jne    694 <peek+0x10>
    s++;
  *ps = s;
     6bc:	8b 45 08             	mov    0x8(%ebp),%eax
     6bf:	8b 55 f4             	mov    -0xc(%ebp),%edx
     6c2:	89 10                	mov    %edx,(%eax)
  return *s && strchr(toks, *s);
     6c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6c7:	8a 00                	mov    (%eax),%al
     6c9:	84 c0                	test   %al,%al
     6cb:	74 22                	je     6ef <peek+0x6b>
     6cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6d0:	8a 00                	mov    (%eax),%al
     6d2:	0f be c0             	movsbl %al,%eax
     6d5:	83 ec 08             	sub    $0x8,%esp
     6d8:	50                   	push   %eax
     6d9:	ff 75 10             	pushl  0x10(%ebp)
     6dc:	e8 45 06 00 00       	call   d26 <strchr>
     6e1:	83 c4 10             	add    $0x10,%esp
     6e4:	85 c0                	test   %eax,%eax
     6e6:	74 07                	je     6ef <peek+0x6b>
     6e8:	b8 01 00 00 00       	mov    $0x1,%eax
     6ed:	eb 05                	jmp    6f4 <peek+0x70>
     6ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
     6f4:	c9                   	leave  
     6f5:	c3                   	ret    

000006f6 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     6f6:	55                   	push   %ebp
     6f7:	89 e5                	mov    %esp,%ebp
     6f9:	53                   	push   %ebx
     6fa:	83 ec 14             	sub    $0x14,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     6fd:	8b 5d 08             	mov    0x8(%ebp),%ebx
     700:	8b 45 08             	mov    0x8(%ebp),%eax
     703:	83 ec 0c             	sub    $0xc,%esp
     706:	50                   	push   %eax
     707:	e8 db 05 00 00       	call   ce7 <strlen>
     70c:	83 c4 10             	add    $0x10,%esp
     70f:	01 d8                	add    %ebx,%eax
     711:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cmd = parseline(&s, es);
     714:	83 ec 08             	sub    $0x8,%esp
     717:	ff 75 f4             	pushl  -0xc(%ebp)
     71a:	8d 45 08             	lea    0x8(%ebp),%eax
     71d:	50                   	push   %eax
     71e:	e8 61 00 00 00       	call   784 <parseline>
     723:	83 c4 10             	add    $0x10,%esp
     726:	89 45 f0             	mov    %eax,-0x10(%ebp)
  peek(&s, es, "");
     729:	83 ec 04             	sub    $0x4,%esp
     72c:	68 1e 14 00 00       	push   $0x141e
     731:	ff 75 f4             	pushl  -0xc(%ebp)
     734:	8d 45 08             	lea    0x8(%ebp),%eax
     737:	50                   	push   %eax
     738:	e8 47 ff ff ff       	call   684 <peek>
     73d:	83 c4 10             	add    $0x10,%esp
  if(s != es){
     740:	8b 45 08             	mov    0x8(%ebp),%eax
     743:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     746:	74 26                	je     76e <parsecmd+0x78>
    printf(2, "leftovers: %s\n", s);
     748:	8b 45 08             	mov    0x8(%ebp),%eax
     74b:	83 ec 04             	sub    $0x4,%esp
     74e:	50                   	push   %eax
     74f:	68 1f 14 00 00       	push   $0x141f
     754:	6a 02                	push   $0x2
     756:	e8 b1 08 00 00       	call   100c <printf>
     75b:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
     75e:	83 ec 0c             	sub    $0xc,%esp
     761:	68 2e 14 00 00       	push   $0x142e
     766:	e8 28 fc ff ff       	call   393 <panic>
     76b:	83 c4 10             	add    $0x10,%esp
  }
  nulterminate(cmd);
     76e:	83 ec 0c             	sub    $0xc,%esp
     771:	ff 75 f0             	pushl  -0x10(%ebp)
     774:	e8 e8 03 00 00       	call   b61 <nulterminate>
     779:	83 c4 10             	add    $0x10,%esp
  return cmd;
     77c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     77f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     782:	c9                   	leave  
     783:	c3                   	ret    

00000784 <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     784:	55                   	push   %ebp
     785:	89 e5                	mov    %esp,%ebp
     787:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     78a:	83 ec 08             	sub    $0x8,%esp
     78d:	ff 75 0c             	pushl  0xc(%ebp)
     790:	ff 75 08             	pushl  0x8(%ebp)
     793:	e8 99 00 00 00       	call   831 <parsepipe>
     798:	83 c4 10             	add    $0x10,%esp
     79b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     79e:	eb 23                	jmp    7c3 <parseline+0x3f>
    gettoken(ps, es, 0, 0);
     7a0:	6a 00                	push   $0x0
     7a2:	6a 00                	push   $0x0
     7a4:	ff 75 0c             	pushl  0xc(%ebp)
     7a7:	ff 75 08             	pushl  0x8(%ebp)
     7aa:	e8 95 fd ff ff       	call   544 <gettoken>
     7af:	83 c4 10             	add    $0x10,%esp
    cmd = backcmd(cmd);
     7b2:	83 ec 0c             	sub    $0xc,%esp
     7b5:	ff 75 f4             	pushl  -0xc(%ebp)
     7b8:	e8 48 fd ff ff       	call   505 <backcmd>
     7bd:	83 c4 10             	add    $0x10,%esp
     7c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
     7c3:	83 ec 04             	sub    $0x4,%esp
     7c6:	68 35 14 00 00       	push   $0x1435
     7cb:	ff 75 0c             	pushl  0xc(%ebp)
     7ce:	ff 75 08             	pushl  0x8(%ebp)
     7d1:	e8 ae fe ff ff       	call   684 <peek>
     7d6:	83 c4 10             	add    $0x10,%esp
     7d9:	85 c0                	test   %eax,%eax
     7db:	75 c3                	jne    7a0 <parseline+0x1c>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
     7dd:	83 ec 04             	sub    $0x4,%esp
     7e0:	68 37 14 00 00       	push   $0x1437
     7e5:	ff 75 0c             	pushl  0xc(%ebp)
     7e8:	ff 75 08             	pushl  0x8(%ebp)
     7eb:	e8 94 fe ff ff       	call   684 <peek>
     7f0:	83 c4 10             	add    $0x10,%esp
     7f3:	85 c0                	test   %eax,%eax
     7f5:	74 35                	je     82c <parseline+0xa8>
    gettoken(ps, es, 0, 0);
     7f7:	6a 00                	push   $0x0
     7f9:	6a 00                	push   $0x0
     7fb:	ff 75 0c             	pushl  0xc(%ebp)
     7fe:	ff 75 08             	pushl  0x8(%ebp)
     801:	e8 3e fd ff ff       	call   544 <gettoken>
     806:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
     809:	83 ec 08             	sub    $0x8,%esp
     80c:	ff 75 0c             	pushl  0xc(%ebp)
     80f:	ff 75 08             	pushl  0x8(%ebp)
     812:	e8 6d ff ff ff       	call   784 <parseline>
     817:	83 c4 10             	add    $0x10,%esp
     81a:	83 ec 08             	sub    $0x8,%esp
     81d:	50                   	push   %eax
     81e:	ff 75 f4             	pushl  -0xc(%ebp)
     821:	e8 97 fc ff ff       	call   4bd <listcmd>
     826:	83 c4 10             	add    $0x10,%esp
     829:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     82c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     82f:	c9                   	leave  
     830:	c3                   	ret    

00000831 <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     831:	55                   	push   %ebp
     832:	89 e5                	mov    %esp,%ebp
     834:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     837:	83 ec 08             	sub    $0x8,%esp
     83a:	ff 75 0c             	pushl  0xc(%ebp)
     83d:	ff 75 08             	pushl  0x8(%ebp)
     840:	e8 ec 01 00 00       	call   a31 <parseexec>
     845:	83 c4 10             	add    $0x10,%esp
     848:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(peek(ps, es, "|")){
     84b:	83 ec 04             	sub    $0x4,%esp
     84e:	68 39 14 00 00       	push   $0x1439
     853:	ff 75 0c             	pushl  0xc(%ebp)
     856:	ff 75 08             	pushl  0x8(%ebp)
     859:	e8 26 fe ff ff       	call   684 <peek>
     85e:	83 c4 10             	add    $0x10,%esp
     861:	85 c0                	test   %eax,%eax
     863:	74 35                	je     89a <parsepipe+0x69>
    gettoken(ps, es, 0, 0);
     865:	6a 00                	push   $0x0
     867:	6a 00                	push   $0x0
     869:	ff 75 0c             	pushl  0xc(%ebp)
     86c:	ff 75 08             	pushl  0x8(%ebp)
     86f:	e8 d0 fc ff ff       	call   544 <gettoken>
     874:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     877:	83 ec 08             	sub    $0x8,%esp
     87a:	ff 75 0c             	pushl  0xc(%ebp)
     87d:	ff 75 08             	pushl  0x8(%ebp)
     880:	e8 ac ff ff ff       	call   831 <parsepipe>
     885:	83 c4 10             	add    $0x10,%esp
     888:	83 ec 08             	sub    $0x8,%esp
     88b:	50                   	push   %eax
     88c:	ff 75 f4             	pushl  -0xc(%ebp)
     88f:	e8 e1 fb ff ff       	call   475 <pipecmd>
     894:	83 c4 10             	add    $0x10,%esp
     897:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     89a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     89d:	c9                   	leave  
     89e:	c3                   	ret    

0000089f <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     89f:	55                   	push   %ebp
     8a0:	89 e5                	mov    %esp,%ebp
     8a2:	83 ec 18             	sub    $0x18,%esp
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     8a5:	e9 b6 00 00 00       	jmp    960 <parseredirs+0xc1>
    tok = gettoken(ps, es, 0, 0);
     8aa:	6a 00                	push   $0x0
     8ac:	6a 00                	push   $0x0
     8ae:	ff 75 10             	pushl  0x10(%ebp)
     8b1:	ff 75 0c             	pushl  0xc(%ebp)
     8b4:	e8 8b fc ff ff       	call   544 <gettoken>
     8b9:	83 c4 10             	add    $0x10,%esp
     8bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
     8bf:	8d 45 ec             	lea    -0x14(%ebp),%eax
     8c2:	50                   	push   %eax
     8c3:	8d 45 f0             	lea    -0x10(%ebp),%eax
     8c6:	50                   	push   %eax
     8c7:	ff 75 10             	pushl  0x10(%ebp)
     8ca:	ff 75 0c             	pushl  0xc(%ebp)
     8cd:	e8 72 fc ff ff       	call   544 <gettoken>
     8d2:	83 c4 10             	add    $0x10,%esp
     8d5:	83 f8 61             	cmp    $0x61,%eax
     8d8:	74 10                	je     8ea <parseredirs+0x4b>
      panic("missing file for redirection");
     8da:	83 ec 0c             	sub    $0xc,%esp
     8dd:	68 3b 14 00 00       	push   $0x143b
     8e2:	e8 ac fa ff ff       	call   393 <panic>
     8e7:	83 c4 10             	add    $0x10,%esp
    switch(tok){
     8ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8ed:	83 f8 3c             	cmp    $0x3c,%eax
     8f0:	74 0c                	je     8fe <parseredirs+0x5f>
     8f2:	83 f8 3e             	cmp    $0x3e,%eax
     8f5:	74 26                	je     91d <parseredirs+0x7e>
     8f7:	83 f8 2b             	cmp    $0x2b,%eax
     8fa:	74 43                	je     93f <parseredirs+0xa0>
     8fc:	eb 62                	jmp    960 <parseredirs+0xc1>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     8fe:	8b 55 ec             	mov    -0x14(%ebp),%edx
     901:	8b 45 f0             	mov    -0x10(%ebp),%eax
     904:	83 ec 0c             	sub    $0xc,%esp
     907:	6a 00                	push   $0x0
     909:	6a 00                	push   $0x0
     90b:	52                   	push   %edx
     90c:	50                   	push   %eax
     90d:	ff 75 08             	pushl  0x8(%ebp)
     910:	e8 fd fa ff ff       	call   412 <redircmd>
     915:	83 c4 20             	add    $0x20,%esp
     918:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     91b:	eb 43                	jmp    960 <parseredirs+0xc1>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     91d:	8b 55 ec             	mov    -0x14(%ebp),%edx
     920:	8b 45 f0             	mov    -0x10(%ebp),%eax
     923:	83 ec 0c             	sub    $0xc,%esp
     926:	6a 01                	push   $0x1
     928:	68 01 02 00 00       	push   $0x201
     92d:	52                   	push   %edx
     92e:	50                   	push   %eax
     92f:	ff 75 08             	pushl  0x8(%ebp)
     932:	e8 db fa ff ff       	call   412 <redircmd>
     937:	83 c4 20             	add    $0x20,%esp
     93a:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     93d:	eb 21                	jmp    960 <parseredirs+0xc1>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     93f:	8b 55 ec             	mov    -0x14(%ebp),%edx
     942:	8b 45 f0             	mov    -0x10(%ebp),%eax
     945:	83 ec 0c             	sub    $0xc,%esp
     948:	6a 01                	push   $0x1
     94a:	68 01 02 00 00       	push   $0x201
     94f:	52                   	push   %edx
     950:	50                   	push   %eax
     951:	ff 75 08             	pushl  0x8(%ebp)
     954:	e8 b9 fa ff ff       	call   412 <redircmd>
     959:	83 c4 20             	add    $0x20,%esp
     95c:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     95f:	90                   	nop
parseredirs(struct cmd *cmd, char **ps, char *es)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     960:	83 ec 04             	sub    $0x4,%esp
     963:	68 58 14 00 00       	push   $0x1458
     968:	ff 75 10             	pushl  0x10(%ebp)
     96b:	ff 75 0c             	pushl  0xc(%ebp)
     96e:	e8 11 fd ff ff       	call   684 <peek>
     973:	83 c4 10             	add    $0x10,%esp
     976:	85 c0                	test   %eax,%eax
     978:	0f 85 2c ff ff ff    	jne    8aa <parseredirs+0xb>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
     97e:	8b 45 08             	mov    0x8(%ebp),%eax
}
     981:	c9                   	leave  
     982:	c3                   	ret    

00000983 <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     983:	55                   	push   %ebp
     984:	89 e5                	mov    %esp,%ebp
     986:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     989:	83 ec 04             	sub    $0x4,%esp
     98c:	68 5b 14 00 00       	push   $0x145b
     991:	ff 75 0c             	pushl  0xc(%ebp)
     994:	ff 75 08             	pushl  0x8(%ebp)
     997:	e8 e8 fc ff ff       	call   684 <peek>
     99c:	83 c4 10             	add    $0x10,%esp
     99f:	85 c0                	test   %eax,%eax
     9a1:	75 10                	jne    9b3 <parseblock+0x30>
    panic("parseblock");
     9a3:	83 ec 0c             	sub    $0xc,%esp
     9a6:	68 5d 14 00 00       	push   $0x145d
     9ab:	e8 e3 f9 ff ff       	call   393 <panic>
     9b0:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     9b3:	6a 00                	push   $0x0
     9b5:	6a 00                	push   $0x0
     9b7:	ff 75 0c             	pushl  0xc(%ebp)
     9ba:	ff 75 08             	pushl  0x8(%ebp)
     9bd:	e8 82 fb ff ff       	call   544 <gettoken>
     9c2:	83 c4 10             	add    $0x10,%esp
  cmd = parseline(ps, es);
     9c5:	83 ec 08             	sub    $0x8,%esp
     9c8:	ff 75 0c             	pushl  0xc(%ebp)
     9cb:	ff 75 08             	pushl  0x8(%ebp)
     9ce:	e8 b1 fd ff ff       	call   784 <parseline>
     9d3:	83 c4 10             	add    $0x10,%esp
     9d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!peek(ps, es, ")"))
     9d9:	83 ec 04             	sub    $0x4,%esp
     9dc:	68 68 14 00 00       	push   $0x1468
     9e1:	ff 75 0c             	pushl  0xc(%ebp)
     9e4:	ff 75 08             	pushl  0x8(%ebp)
     9e7:	e8 98 fc ff ff       	call   684 <peek>
     9ec:	83 c4 10             	add    $0x10,%esp
     9ef:	85 c0                	test   %eax,%eax
     9f1:	75 10                	jne    a03 <parseblock+0x80>
    panic("syntax - missing )");
     9f3:	83 ec 0c             	sub    $0xc,%esp
     9f6:	68 6a 14 00 00       	push   $0x146a
     9fb:	e8 93 f9 ff ff       	call   393 <panic>
     a00:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     a03:	6a 00                	push   $0x0
     a05:	6a 00                	push   $0x0
     a07:	ff 75 0c             	pushl  0xc(%ebp)
     a0a:	ff 75 08             	pushl  0x8(%ebp)
     a0d:	e8 32 fb ff ff       	call   544 <gettoken>
     a12:	83 c4 10             	add    $0x10,%esp
  cmd = parseredirs(cmd, ps, es);
     a15:	83 ec 04             	sub    $0x4,%esp
     a18:	ff 75 0c             	pushl  0xc(%ebp)
     a1b:	ff 75 08             	pushl  0x8(%ebp)
     a1e:	ff 75 f4             	pushl  -0xc(%ebp)
     a21:	e8 79 fe ff ff       	call   89f <parseredirs>
     a26:	83 c4 10             	add    $0x10,%esp
     a29:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return cmd;
     a2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     a2f:	c9                   	leave  
     a30:	c3                   	ret    

00000a31 <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     a31:	55                   	push   %ebp
     a32:	89 e5                	mov    %esp,%ebp
     a34:	83 ec 28             	sub    $0x28,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
     a37:	83 ec 04             	sub    $0x4,%esp
     a3a:	68 5b 14 00 00       	push   $0x145b
     a3f:	ff 75 0c             	pushl  0xc(%ebp)
     a42:	ff 75 08             	pushl  0x8(%ebp)
     a45:	e8 3a fc ff ff       	call   684 <peek>
     a4a:	83 c4 10             	add    $0x10,%esp
     a4d:	85 c0                	test   %eax,%eax
     a4f:	74 16                	je     a67 <parseexec+0x36>
    return parseblock(ps, es);
     a51:	83 ec 08             	sub    $0x8,%esp
     a54:	ff 75 0c             	pushl  0xc(%ebp)
     a57:	ff 75 08             	pushl  0x8(%ebp)
     a5a:	e8 24 ff ff ff       	call   983 <parseblock>
     a5f:	83 c4 10             	add    $0x10,%esp
     a62:	e9 f8 00 00 00       	jmp    b5f <parseexec+0x12e>

  ret = execcmd();
     a67:	e8 70 f9 ff ff       	call   3dc <execcmd>
     a6c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cmd = (struct execcmd*)ret;
     a6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a72:	89 45 ec             	mov    %eax,-0x14(%ebp)

  argc = 0;
     a75:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  ret = parseredirs(ret, ps, es);
     a7c:	83 ec 04             	sub    $0x4,%esp
     a7f:	ff 75 0c             	pushl  0xc(%ebp)
     a82:	ff 75 08             	pushl  0x8(%ebp)
     a85:	ff 75 f0             	pushl  -0x10(%ebp)
     a88:	e8 12 fe ff ff       	call   89f <parseredirs>
     a8d:	83 c4 10             	add    $0x10,%esp
     a90:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
     a93:	e9 87 00 00 00       	jmp    b1f <parseexec+0xee>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     a98:	8d 45 e0             	lea    -0x20(%ebp),%eax
     a9b:	50                   	push   %eax
     a9c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     a9f:	50                   	push   %eax
     aa0:	ff 75 0c             	pushl  0xc(%ebp)
     aa3:	ff 75 08             	pushl  0x8(%ebp)
     aa6:	e8 99 fa ff ff       	call   544 <gettoken>
     aab:	83 c4 10             	add    $0x10,%esp
     aae:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ab1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     ab5:	75 05                	jne    abc <parseexec+0x8b>
      break;
     ab7:	e9 81 00 00 00       	jmp    b3d <parseexec+0x10c>
    if(tok != 'a')
     abc:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
     ac0:	74 10                	je     ad2 <parseexec+0xa1>
      panic("syntax");
     ac2:	83 ec 0c             	sub    $0xc,%esp
     ac5:	68 2e 14 00 00       	push   $0x142e
     aca:	e8 c4 f8 ff ff       	call   393 <panic>
     acf:	83 c4 10             	add    $0x10,%esp
    cmd->argv[argc] = q;
     ad2:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     ad5:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ad8:	8b 55 f4             	mov    -0xc(%ebp),%edx
     adb:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
    cmd->eargv[argc] = eq;
     adf:	8b 55 e0             	mov    -0x20(%ebp),%edx
     ae2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ae5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     ae8:	83 c1 08             	add    $0x8,%ecx
     aeb:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    argc++;
     aef:	ff 45 f4             	incl   -0xc(%ebp)
    if(argc >= MAXARGS)
     af2:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
     af6:	7e 10                	jle    b08 <parseexec+0xd7>
      panic("too many args");
     af8:	83 ec 0c             	sub    $0xc,%esp
     afb:	68 7d 14 00 00       	push   $0x147d
     b00:	e8 8e f8 ff ff       	call   393 <panic>
     b05:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
     b08:	83 ec 04             	sub    $0x4,%esp
     b0b:	ff 75 0c             	pushl  0xc(%ebp)
     b0e:	ff 75 08             	pushl  0x8(%ebp)
     b11:	ff 75 f0             	pushl  -0x10(%ebp)
     b14:	e8 86 fd ff ff       	call   89f <parseredirs>
     b19:	83 c4 10             	add    $0x10,%esp
     b1c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
     b1f:	83 ec 04             	sub    $0x4,%esp
     b22:	68 8b 14 00 00       	push   $0x148b
     b27:	ff 75 0c             	pushl  0xc(%ebp)
     b2a:	ff 75 08             	pushl  0x8(%ebp)
     b2d:	e8 52 fb ff ff       	call   684 <peek>
     b32:	83 c4 10             	add    $0x10,%esp
     b35:	85 c0                	test   %eax,%eax
     b37:	0f 84 5b ff ff ff    	je     a98 <parseexec+0x67>
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
     b3d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b40:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b43:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
     b4a:	00 
  cmd->eargv[argc] = 0;
     b4b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b4e:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b51:	83 c2 08             	add    $0x8,%edx
     b54:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
     b5b:	00 
  return ret;
     b5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     b5f:	c9                   	leave  
     b60:	c3                   	ret    

00000b61 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     b61:	55                   	push   %ebp
     b62:	89 e5                	mov    %esp,%ebp
     b64:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     b67:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     b6b:	75 0a                	jne    b77 <nulterminate+0x16>
    return 0;
     b6d:	b8 00 00 00 00       	mov    $0x0,%eax
     b72:	e9 e3 00 00 00       	jmp    c5a <nulterminate+0xf9>
  
  switch(cmd->type){
     b77:	8b 45 08             	mov    0x8(%ebp),%eax
     b7a:	8b 00                	mov    (%eax),%eax
     b7c:	83 f8 05             	cmp    $0x5,%eax
     b7f:	0f 87 d2 00 00 00    	ja     c57 <nulterminate+0xf6>
     b85:	8b 04 85 90 14 00 00 	mov    0x1490(,%eax,4),%eax
     b8c:	ff e0                	jmp    *%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
     b8e:	8b 45 08             	mov    0x8(%ebp),%eax
     b91:	89 45 f0             	mov    %eax,-0x10(%ebp)
    for(i=0; ecmd->argv[i]; i++)
     b94:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     b9b:	eb 13                	jmp    bb0 <nulterminate+0x4f>
      *ecmd->eargv[i] = 0;
     b9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ba0:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ba3:	83 c2 08             	add    $0x8,%edx
     ba6:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
     baa:	c6 00 00             	movb   $0x0,(%eax)
    return 0;
  
  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     bad:	ff 45 f4             	incl   -0xc(%ebp)
     bb0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bb3:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bb6:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
     bba:	85 c0                	test   %eax,%eax
     bbc:	75 df                	jne    b9d <nulterminate+0x3c>
      *ecmd->eargv[i] = 0;
    break;
     bbe:	e9 94 00 00 00       	jmp    c57 <nulterminate+0xf6>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
     bc3:	8b 45 08             	mov    0x8(%ebp),%eax
     bc6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    nulterminate(rcmd->cmd);
     bc9:	8b 45 ec             	mov    -0x14(%ebp),%eax
     bcc:	8b 40 04             	mov    0x4(%eax),%eax
     bcf:	83 ec 0c             	sub    $0xc,%esp
     bd2:	50                   	push   %eax
     bd3:	e8 89 ff ff ff       	call   b61 <nulterminate>
     bd8:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     bdb:	8b 45 ec             	mov    -0x14(%ebp),%eax
     bde:	8b 40 0c             	mov    0xc(%eax),%eax
     be1:	c6 00 00             	movb   $0x0,(%eax)
    break;
     be4:	eb 71                	jmp    c57 <nulterminate+0xf6>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     be6:	8b 45 08             	mov    0x8(%ebp),%eax
     be9:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nulterminate(pcmd->left);
     bec:	8b 45 e8             	mov    -0x18(%ebp),%eax
     bef:	8b 40 04             	mov    0x4(%eax),%eax
     bf2:	83 ec 0c             	sub    $0xc,%esp
     bf5:	50                   	push   %eax
     bf6:	e8 66 ff ff ff       	call   b61 <nulterminate>
     bfb:	83 c4 10             	add    $0x10,%esp
    nulterminate(pcmd->right);
     bfe:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c01:	8b 40 08             	mov    0x8(%eax),%eax
     c04:	83 ec 0c             	sub    $0xc,%esp
     c07:	50                   	push   %eax
     c08:	e8 54 ff ff ff       	call   b61 <nulterminate>
     c0d:	83 c4 10             	add    $0x10,%esp
    break;
     c10:	eb 45                	jmp    c57 <nulterminate+0xf6>
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
     c12:	8b 45 08             	mov    0x8(%ebp),%eax
     c15:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nulterminate(lcmd->left);
     c18:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c1b:	8b 40 04             	mov    0x4(%eax),%eax
     c1e:	83 ec 0c             	sub    $0xc,%esp
     c21:	50                   	push   %eax
     c22:	e8 3a ff ff ff       	call   b61 <nulterminate>
     c27:	83 c4 10             	add    $0x10,%esp
    nulterminate(lcmd->right);
     c2a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c2d:	8b 40 08             	mov    0x8(%eax),%eax
     c30:	83 ec 0c             	sub    $0xc,%esp
     c33:	50                   	push   %eax
     c34:	e8 28 ff ff ff       	call   b61 <nulterminate>
     c39:	83 c4 10             	add    $0x10,%esp
    break;
     c3c:	eb 19                	jmp    c57 <nulterminate+0xf6>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     c3e:	8b 45 08             	mov    0x8(%ebp),%eax
     c41:	89 45 e0             	mov    %eax,-0x20(%ebp)
    nulterminate(bcmd->cmd);
     c44:	8b 45 e0             	mov    -0x20(%ebp),%eax
     c47:	8b 40 04             	mov    0x4(%eax),%eax
     c4a:	83 ec 0c             	sub    $0xc,%esp
     c4d:	50                   	push   %eax
     c4e:	e8 0e ff ff ff       	call   b61 <nulterminate>
     c53:	83 c4 10             	add    $0x10,%esp
    break;
     c56:	90                   	nop
  }
  return cmd;
     c57:	8b 45 08             	mov    0x8(%ebp),%eax
}
     c5a:	c9                   	leave  
     c5b:	c3                   	ret    

00000c5c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     c5c:	55                   	push   %ebp
     c5d:	89 e5                	mov    %esp,%ebp
     c5f:	57                   	push   %edi
     c60:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     c61:	8b 4d 08             	mov    0x8(%ebp),%ecx
     c64:	8b 55 10             	mov    0x10(%ebp),%edx
     c67:	8b 45 0c             	mov    0xc(%ebp),%eax
     c6a:	89 cb                	mov    %ecx,%ebx
     c6c:	89 df                	mov    %ebx,%edi
     c6e:	89 d1                	mov    %edx,%ecx
     c70:	fc                   	cld    
     c71:	f3 aa                	rep stos %al,%es:(%edi)
     c73:	89 ca                	mov    %ecx,%edx
     c75:	89 fb                	mov    %edi,%ebx
     c77:	89 5d 08             	mov    %ebx,0x8(%ebp)
     c7a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     c7d:	5b                   	pop    %ebx
     c7e:	5f                   	pop    %edi
     c7f:	5d                   	pop    %ebp
     c80:	c3                   	ret    

00000c81 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     c81:	55                   	push   %ebp
     c82:	89 e5                	mov    %esp,%ebp
     c84:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     c87:	8b 45 08             	mov    0x8(%ebp),%eax
     c8a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     c8d:	90                   	nop
     c8e:	8b 45 08             	mov    0x8(%ebp),%eax
     c91:	8d 50 01             	lea    0x1(%eax),%edx
     c94:	89 55 08             	mov    %edx,0x8(%ebp)
     c97:	8b 55 0c             	mov    0xc(%ebp),%edx
     c9a:	8d 4a 01             	lea    0x1(%edx),%ecx
     c9d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     ca0:	8a 12                	mov    (%edx),%dl
     ca2:	88 10                	mov    %dl,(%eax)
     ca4:	8a 00                	mov    (%eax),%al
     ca6:	84 c0                	test   %al,%al
     ca8:	75 e4                	jne    c8e <strcpy+0xd>
    ;
  return os;
     caa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     cad:	c9                   	leave  
     cae:	c3                   	ret    

00000caf <strcmp>:

int
strcmp(const char *p, const char *q)
{
     caf:	55                   	push   %ebp
     cb0:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     cb2:	eb 06                	jmp    cba <strcmp+0xb>
    p++, q++;
     cb4:	ff 45 08             	incl   0x8(%ebp)
     cb7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     cba:	8b 45 08             	mov    0x8(%ebp),%eax
     cbd:	8a 00                	mov    (%eax),%al
     cbf:	84 c0                	test   %al,%al
     cc1:	74 0e                	je     cd1 <strcmp+0x22>
     cc3:	8b 45 08             	mov    0x8(%ebp),%eax
     cc6:	8a 10                	mov    (%eax),%dl
     cc8:	8b 45 0c             	mov    0xc(%ebp),%eax
     ccb:	8a 00                	mov    (%eax),%al
     ccd:	38 c2                	cmp    %al,%dl
     ccf:	74 e3                	je     cb4 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     cd1:	8b 45 08             	mov    0x8(%ebp),%eax
     cd4:	8a 00                	mov    (%eax),%al
     cd6:	0f b6 d0             	movzbl %al,%edx
     cd9:	8b 45 0c             	mov    0xc(%ebp),%eax
     cdc:	8a 00                	mov    (%eax),%al
     cde:	0f b6 c0             	movzbl %al,%eax
     ce1:	29 c2                	sub    %eax,%edx
     ce3:	89 d0                	mov    %edx,%eax
}
     ce5:	5d                   	pop    %ebp
     ce6:	c3                   	ret    

00000ce7 <strlen>:

uint
strlen(char *s)
{
     ce7:	55                   	push   %ebp
     ce8:	89 e5                	mov    %esp,%ebp
     cea:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     ced:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     cf4:	eb 03                	jmp    cf9 <strlen+0x12>
     cf6:	ff 45 fc             	incl   -0x4(%ebp)
     cf9:	8b 55 fc             	mov    -0x4(%ebp),%edx
     cfc:	8b 45 08             	mov    0x8(%ebp),%eax
     cff:	01 d0                	add    %edx,%eax
     d01:	8a 00                	mov    (%eax),%al
     d03:	84 c0                	test   %al,%al
     d05:	75 ef                	jne    cf6 <strlen+0xf>
    ;
  return n;
     d07:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     d0a:	c9                   	leave  
     d0b:	c3                   	ret    

00000d0c <memset>:

void*
memset(void *dst, int c, uint n)
{
     d0c:	55                   	push   %ebp
     d0d:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     d0f:	8b 45 10             	mov    0x10(%ebp),%eax
     d12:	50                   	push   %eax
     d13:	ff 75 0c             	pushl  0xc(%ebp)
     d16:	ff 75 08             	pushl  0x8(%ebp)
     d19:	e8 3e ff ff ff       	call   c5c <stosb>
     d1e:	83 c4 0c             	add    $0xc,%esp
  return dst;
     d21:	8b 45 08             	mov    0x8(%ebp),%eax
}
     d24:	c9                   	leave  
     d25:	c3                   	ret    

00000d26 <strchr>:

char*
strchr(const char *s, char c)
{
     d26:	55                   	push   %ebp
     d27:	89 e5                	mov    %esp,%ebp
     d29:	83 ec 04             	sub    $0x4,%esp
     d2c:	8b 45 0c             	mov    0xc(%ebp),%eax
     d2f:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     d32:	eb 12                	jmp    d46 <strchr+0x20>
    if(*s == c)
     d34:	8b 45 08             	mov    0x8(%ebp),%eax
     d37:	8a 00                	mov    (%eax),%al
     d39:	3a 45 fc             	cmp    -0x4(%ebp),%al
     d3c:	75 05                	jne    d43 <strchr+0x1d>
      return (char*)s;
     d3e:	8b 45 08             	mov    0x8(%ebp),%eax
     d41:	eb 11                	jmp    d54 <strchr+0x2e>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     d43:	ff 45 08             	incl   0x8(%ebp)
     d46:	8b 45 08             	mov    0x8(%ebp),%eax
     d49:	8a 00                	mov    (%eax),%al
     d4b:	84 c0                	test   %al,%al
     d4d:	75 e5                	jne    d34 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     d4f:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d54:	c9                   	leave  
     d55:	c3                   	ret    

00000d56 <gets>:

char*
gets(char *buf, int max)
{
     d56:	55                   	push   %ebp
     d57:	89 e5                	mov    %esp,%ebp
     d59:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     d5c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d63:	eb 41                	jmp    da6 <gets+0x50>
    cc = read(0, &c, 1);
     d65:	83 ec 04             	sub    $0x4,%esp
     d68:	6a 01                	push   $0x1
     d6a:	8d 45 ef             	lea    -0x11(%ebp),%eax
     d6d:	50                   	push   %eax
     d6e:	6a 00                	push   $0x0
     d70:	e8 3d 01 00 00       	call   eb2 <read>
     d75:	83 c4 10             	add    $0x10,%esp
     d78:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     d7b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     d7f:	7f 02                	jg     d83 <gets+0x2d>
      break;
     d81:	eb 2c                	jmp    daf <gets+0x59>
    buf[i++] = c;
     d83:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d86:	8d 50 01             	lea    0x1(%eax),%edx
     d89:	89 55 f4             	mov    %edx,-0xc(%ebp)
     d8c:	89 c2                	mov    %eax,%edx
     d8e:	8b 45 08             	mov    0x8(%ebp),%eax
     d91:	01 c2                	add    %eax,%edx
     d93:	8a 45 ef             	mov    -0x11(%ebp),%al
     d96:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     d98:	8a 45 ef             	mov    -0x11(%ebp),%al
     d9b:	3c 0a                	cmp    $0xa,%al
     d9d:	74 10                	je     daf <gets+0x59>
     d9f:	8a 45 ef             	mov    -0x11(%ebp),%al
     da2:	3c 0d                	cmp    $0xd,%al
     da4:	74 09                	je     daf <gets+0x59>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     da6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     da9:	40                   	inc    %eax
     daa:	3b 45 0c             	cmp    0xc(%ebp),%eax
     dad:	7c b6                	jl     d65 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     daf:	8b 55 f4             	mov    -0xc(%ebp),%edx
     db2:	8b 45 08             	mov    0x8(%ebp),%eax
     db5:	01 d0                	add    %edx,%eax
     db7:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     dba:	8b 45 08             	mov    0x8(%ebp),%eax
}
     dbd:	c9                   	leave  
     dbe:	c3                   	ret    

00000dbf <stat>:

int
stat(char *n, struct stat *st)
{
     dbf:	55                   	push   %ebp
     dc0:	89 e5                	mov    %esp,%ebp
     dc2:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     dc5:	83 ec 08             	sub    $0x8,%esp
     dc8:	6a 00                	push   $0x0
     dca:	ff 75 08             	pushl  0x8(%ebp)
     dcd:	e8 08 01 00 00       	call   eda <open>
     dd2:	83 c4 10             	add    $0x10,%esp
     dd5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     dd8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ddc:	79 07                	jns    de5 <stat+0x26>
    return -1;
     dde:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     de3:	eb 25                	jmp    e0a <stat+0x4b>
  r = fstat(fd, st);
     de5:	83 ec 08             	sub    $0x8,%esp
     de8:	ff 75 0c             	pushl  0xc(%ebp)
     deb:	ff 75 f4             	pushl  -0xc(%ebp)
     dee:	e8 ff 00 00 00       	call   ef2 <fstat>
     df3:	83 c4 10             	add    $0x10,%esp
     df6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     df9:	83 ec 0c             	sub    $0xc,%esp
     dfc:	ff 75 f4             	pushl  -0xc(%ebp)
     dff:	e8 be 00 00 00       	call   ec2 <close>
     e04:	83 c4 10             	add    $0x10,%esp
  return r;
     e07:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     e0a:	c9                   	leave  
     e0b:	c3                   	ret    

00000e0c <atoi>:

int
atoi(const char *s)
{
     e0c:	55                   	push   %ebp
     e0d:	89 e5                	mov    %esp,%ebp
     e0f:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     e12:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     e19:	eb 24                	jmp    e3f <atoi+0x33>
    n = n*10 + *s++ - '0';
     e1b:	8b 55 fc             	mov    -0x4(%ebp),%edx
     e1e:	89 d0                	mov    %edx,%eax
     e20:	c1 e0 02             	shl    $0x2,%eax
     e23:	01 d0                	add    %edx,%eax
     e25:	01 c0                	add    %eax,%eax
     e27:	89 c1                	mov    %eax,%ecx
     e29:	8b 45 08             	mov    0x8(%ebp),%eax
     e2c:	8d 50 01             	lea    0x1(%eax),%edx
     e2f:	89 55 08             	mov    %edx,0x8(%ebp)
     e32:	8a 00                	mov    (%eax),%al
     e34:	0f be c0             	movsbl %al,%eax
     e37:	01 c8                	add    %ecx,%eax
     e39:	83 e8 30             	sub    $0x30,%eax
     e3c:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     e3f:	8b 45 08             	mov    0x8(%ebp),%eax
     e42:	8a 00                	mov    (%eax),%al
     e44:	3c 2f                	cmp    $0x2f,%al
     e46:	7e 09                	jle    e51 <atoi+0x45>
     e48:	8b 45 08             	mov    0x8(%ebp),%eax
     e4b:	8a 00                	mov    (%eax),%al
     e4d:	3c 39                	cmp    $0x39,%al
     e4f:	7e ca                	jle    e1b <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     e51:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     e54:	c9                   	leave  
     e55:	c3                   	ret    

00000e56 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     e56:	55                   	push   %ebp
     e57:	89 e5                	mov    %esp,%ebp
     e59:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     e5c:	8b 45 08             	mov    0x8(%ebp),%eax
     e5f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     e62:	8b 45 0c             	mov    0xc(%ebp),%eax
     e65:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     e68:	eb 16                	jmp    e80 <memmove+0x2a>
    *dst++ = *src++;
     e6a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e6d:	8d 50 01             	lea    0x1(%eax),%edx
     e70:	89 55 fc             	mov    %edx,-0x4(%ebp)
     e73:	8b 55 f8             	mov    -0x8(%ebp),%edx
     e76:	8d 4a 01             	lea    0x1(%edx),%ecx
     e79:	89 4d f8             	mov    %ecx,-0x8(%ebp)
     e7c:	8a 12                	mov    (%edx),%dl
     e7e:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     e80:	8b 45 10             	mov    0x10(%ebp),%eax
     e83:	8d 50 ff             	lea    -0x1(%eax),%edx
     e86:	89 55 10             	mov    %edx,0x10(%ebp)
     e89:	85 c0                	test   %eax,%eax
     e8b:	7f dd                	jg     e6a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     e8d:	8b 45 08             	mov    0x8(%ebp),%eax
}
     e90:	c9                   	leave  
     e91:	c3                   	ret    

00000e92 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     e92:	b8 01 00 00 00       	mov    $0x1,%eax
     e97:	cd 40                	int    $0x40
     e99:	c3                   	ret    

00000e9a <exit>:
SYSCALL(exit)
     e9a:	b8 02 00 00 00       	mov    $0x2,%eax
     e9f:	cd 40                	int    $0x40
     ea1:	c3                   	ret    

00000ea2 <wait>:
SYSCALL(wait)
     ea2:	b8 03 00 00 00       	mov    $0x3,%eax
     ea7:	cd 40                	int    $0x40
     ea9:	c3                   	ret    

00000eaa <pipe>:
SYSCALL(pipe)
     eaa:	b8 04 00 00 00       	mov    $0x4,%eax
     eaf:	cd 40                	int    $0x40
     eb1:	c3                   	ret    

00000eb2 <read>:
SYSCALL(read)
     eb2:	b8 05 00 00 00       	mov    $0x5,%eax
     eb7:	cd 40                	int    $0x40
     eb9:	c3                   	ret    

00000eba <write>:
SYSCALL(write)
     eba:	b8 10 00 00 00       	mov    $0x10,%eax
     ebf:	cd 40                	int    $0x40
     ec1:	c3                   	ret    

00000ec2 <close>:
SYSCALL(close)
     ec2:	b8 15 00 00 00       	mov    $0x15,%eax
     ec7:	cd 40                	int    $0x40
     ec9:	c3                   	ret    

00000eca <kill>:
SYSCALL(kill)
     eca:	b8 06 00 00 00       	mov    $0x6,%eax
     ecf:	cd 40                	int    $0x40
     ed1:	c3                   	ret    

00000ed2 <exec>:
SYSCALL(exec)
     ed2:	b8 07 00 00 00       	mov    $0x7,%eax
     ed7:	cd 40                	int    $0x40
     ed9:	c3                   	ret    

00000eda <open>:
SYSCALL(open)
     eda:	b8 0f 00 00 00       	mov    $0xf,%eax
     edf:	cd 40                	int    $0x40
     ee1:	c3                   	ret    

00000ee2 <mknod>:
SYSCALL(mknod)
     ee2:	b8 11 00 00 00       	mov    $0x11,%eax
     ee7:	cd 40                	int    $0x40
     ee9:	c3                   	ret    

00000eea <unlink>:
SYSCALL(unlink)
     eea:	b8 12 00 00 00       	mov    $0x12,%eax
     eef:	cd 40                	int    $0x40
     ef1:	c3                   	ret    

00000ef2 <fstat>:
SYSCALL(fstat)
     ef2:	b8 08 00 00 00       	mov    $0x8,%eax
     ef7:	cd 40                	int    $0x40
     ef9:	c3                   	ret    

00000efa <link>:
SYSCALL(link)
     efa:	b8 13 00 00 00       	mov    $0x13,%eax
     eff:	cd 40                	int    $0x40
     f01:	c3                   	ret    

00000f02 <mkdir>:
SYSCALL(mkdir)
     f02:	b8 14 00 00 00       	mov    $0x14,%eax
     f07:	cd 40                	int    $0x40
     f09:	c3                   	ret    

00000f0a <chdir>:
SYSCALL(chdir)
     f0a:	b8 09 00 00 00       	mov    $0x9,%eax
     f0f:	cd 40                	int    $0x40
     f11:	c3                   	ret    

00000f12 <dup>:
SYSCALL(dup)
     f12:	b8 0a 00 00 00       	mov    $0xa,%eax
     f17:	cd 40                	int    $0x40
     f19:	c3                   	ret    

00000f1a <getpid>:
SYSCALL(getpid)
     f1a:	b8 0b 00 00 00       	mov    $0xb,%eax
     f1f:	cd 40                	int    $0x40
     f21:	c3                   	ret    

00000f22 <sbrk>:
SYSCALL(sbrk)
     f22:	b8 0c 00 00 00       	mov    $0xc,%eax
     f27:	cd 40                	int    $0x40
     f29:	c3                   	ret    

00000f2a <sleep>:
SYSCALL(sleep)
     f2a:	b8 0d 00 00 00       	mov    $0xd,%eax
     f2f:	cd 40                	int    $0x40
     f31:	c3                   	ret    

00000f32 <uptime>:
SYSCALL(uptime)
     f32:	b8 0e 00 00 00       	mov    $0xe,%eax
     f37:	cd 40                	int    $0x40
     f39:	c3                   	ret    

00000f3a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     f3a:	55                   	push   %ebp
     f3b:	89 e5                	mov    %esp,%ebp
     f3d:	83 ec 18             	sub    $0x18,%esp
     f40:	8b 45 0c             	mov    0xc(%ebp),%eax
     f43:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     f46:	83 ec 04             	sub    $0x4,%esp
     f49:	6a 01                	push   $0x1
     f4b:	8d 45 f4             	lea    -0xc(%ebp),%eax
     f4e:	50                   	push   %eax
     f4f:	ff 75 08             	pushl  0x8(%ebp)
     f52:	e8 63 ff ff ff       	call   eba <write>
     f57:	83 c4 10             	add    $0x10,%esp
}
     f5a:	c9                   	leave  
     f5b:	c3                   	ret    

00000f5c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     f5c:	55                   	push   %ebp
     f5d:	89 e5                	mov    %esp,%ebp
     f5f:	53                   	push   %ebx
     f60:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     f63:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     f6a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     f6e:	74 17                	je     f87 <printint+0x2b>
     f70:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f74:	79 11                	jns    f87 <printint+0x2b>
    neg = 1;
     f76:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     f7d:	8b 45 0c             	mov    0xc(%ebp),%eax
     f80:	f7 d8                	neg    %eax
     f82:	89 45 ec             	mov    %eax,-0x14(%ebp)
     f85:	eb 06                	jmp    f8d <printint+0x31>
  } else {
    x = xx;
     f87:	8b 45 0c             	mov    0xc(%ebp),%eax
     f8a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     f8d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     f94:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     f97:	8d 41 01             	lea    0x1(%ecx),%eax
     f9a:	89 45 f4             	mov    %eax,-0xc(%ebp)
     f9d:	8b 5d 10             	mov    0x10(%ebp),%ebx
     fa0:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fa3:	ba 00 00 00 00       	mov    $0x0,%edx
     fa8:	f7 f3                	div    %ebx
     faa:	89 d0                	mov    %edx,%eax
     fac:	8a 80 44 19 00 00    	mov    0x1944(%eax),%al
     fb2:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
     fb6:	8b 5d 10             	mov    0x10(%ebp),%ebx
     fb9:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fbc:	ba 00 00 00 00       	mov    $0x0,%edx
     fc1:	f7 f3                	div    %ebx
     fc3:	89 45 ec             	mov    %eax,-0x14(%ebp)
     fc6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     fca:	75 c8                	jne    f94 <printint+0x38>
  if(neg)
     fcc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     fd0:	74 0e                	je     fe0 <printint+0x84>
    buf[i++] = '-';
     fd2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fd5:	8d 50 01             	lea    0x1(%eax),%edx
     fd8:	89 55 f4             	mov    %edx,-0xc(%ebp)
     fdb:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     fe0:	eb 1c                	jmp    ffe <printint+0xa2>
    putc(fd, buf[i]);
     fe2:	8d 55 dc             	lea    -0x24(%ebp),%edx
     fe5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fe8:	01 d0                	add    %edx,%eax
     fea:	8a 00                	mov    (%eax),%al
     fec:	0f be c0             	movsbl %al,%eax
     fef:	83 ec 08             	sub    $0x8,%esp
     ff2:	50                   	push   %eax
     ff3:	ff 75 08             	pushl  0x8(%ebp)
     ff6:	e8 3f ff ff ff       	call   f3a <putc>
     ffb:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     ffe:	ff 4d f4             	decl   -0xc(%ebp)
    1001:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1005:	79 db                	jns    fe2 <printint+0x86>
    putc(fd, buf[i]);
}
    1007:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    100a:	c9                   	leave  
    100b:	c3                   	ret    

0000100c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    100c:	55                   	push   %ebp
    100d:	89 e5                	mov    %esp,%ebp
    100f:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1012:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1019:	8d 45 0c             	lea    0xc(%ebp),%eax
    101c:	83 c0 04             	add    $0x4,%eax
    101f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    1022:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1029:	e9 54 01 00 00       	jmp    1182 <printf+0x176>
    c = fmt[i] & 0xff;
    102e:	8b 55 0c             	mov    0xc(%ebp),%edx
    1031:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1034:	01 d0                	add    %edx,%eax
    1036:	8a 00                	mov    (%eax),%al
    1038:	0f be c0             	movsbl %al,%eax
    103b:	25 ff 00 00 00       	and    $0xff,%eax
    1040:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1043:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1047:	75 2c                	jne    1075 <printf+0x69>
      if(c == '%'){
    1049:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    104d:	75 0c                	jne    105b <printf+0x4f>
        state = '%';
    104f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1056:	e9 24 01 00 00       	jmp    117f <printf+0x173>
      } else {
        putc(fd, c);
    105b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    105e:	0f be c0             	movsbl %al,%eax
    1061:	83 ec 08             	sub    $0x8,%esp
    1064:	50                   	push   %eax
    1065:	ff 75 08             	pushl  0x8(%ebp)
    1068:	e8 cd fe ff ff       	call   f3a <putc>
    106d:	83 c4 10             	add    $0x10,%esp
    1070:	e9 0a 01 00 00       	jmp    117f <printf+0x173>
      }
    } else if(state == '%'){
    1075:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1079:	0f 85 00 01 00 00    	jne    117f <printf+0x173>
      if(c == 'd'){
    107f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1083:	75 1e                	jne    10a3 <printf+0x97>
        printint(fd, *ap, 10, 1);
    1085:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1088:	8b 00                	mov    (%eax),%eax
    108a:	6a 01                	push   $0x1
    108c:	6a 0a                	push   $0xa
    108e:	50                   	push   %eax
    108f:	ff 75 08             	pushl  0x8(%ebp)
    1092:	e8 c5 fe ff ff       	call   f5c <printint>
    1097:	83 c4 10             	add    $0x10,%esp
        ap++;
    109a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    109e:	e9 d5 00 00 00       	jmp    1178 <printf+0x16c>
      } else if(c == 'x' || c == 'p'){
    10a3:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    10a7:	74 06                	je     10af <printf+0xa3>
    10a9:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    10ad:	75 1e                	jne    10cd <printf+0xc1>
        printint(fd, *ap, 16, 0);
    10af:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10b2:	8b 00                	mov    (%eax),%eax
    10b4:	6a 00                	push   $0x0
    10b6:	6a 10                	push   $0x10
    10b8:	50                   	push   %eax
    10b9:	ff 75 08             	pushl  0x8(%ebp)
    10bc:	e8 9b fe ff ff       	call   f5c <printint>
    10c1:	83 c4 10             	add    $0x10,%esp
        ap++;
    10c4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    10c8:	e9 ab 00 00 00       	jmp    1178 <printf+0x16c>
      } else if(c == 's'){
    10cd:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    10d1:	75 40                	jne    1113 <printf+0x107>
        s = (char*)*ap;
    10d3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10d6:	8b 00                	mov    (%eax),%eax
    10d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    10db:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    10df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    10e3:	75 07                	jne    10ec <printf+0xe0>
          s = "(null)";
    10e5:	c7 45 f4 a8 14 00 00 	movl   $0x14a8,-0xc(%ebp)
        while(*s != 0){
    10ec:	eb 1a                	jmp    1108 <printf+0xfc>
          putc(fd, *s);
    10ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10f1:	8a 00                	mov    (%eax),%al
    10f3:	0f be c0             	movsbl %al,%eax
    10f6:	83 ec 08             	sub    $0x8,%esp
    10f9:	50                   	push   %eax
    10fa:	ff 75 08             	pushl  0x8(%ebp)
    10fd:	e8 38 fe ff ff       	call   f3a <putc>
    1102:	83 c4 10             	add    $0x10,%esp
          s++;
    1105:	ff 45 f4             	incl   -0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1108:	8b 45 f4             	mov    -0xc(%ebp),%eax
    110b:	8a 00                	mov    (%eax),%al
    110d:	84 c0                	test   %al,%al
    110f:	75 dd                	jne    10ee <printf+0xe2>
    1111:	eb 65                	jmp    1178 <printf+0x16c>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1113:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1117:	75 1d                	jne    1136 <printf+0x12a>
        putc(fd, *ap);
    1119:	8b 45 e8             	mov    -0x18(%ebp),%eax
    111c:	8b 00                	mov    (%eax),%eax
    111e:	0f be c0             	movsbl %al,%eax
    1121:	83 ec 08             	sub    $0x8,%esp
    1124:	50                   	push   %eax
    1125:	ff 75 08             	pushl  0x8(%ebp)
    1128:	e8 0d fe ff ff       	call   f3a <putc>
    112d:	83 c4 10             	add    $0x10,%esp
        ap++;
    1130:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1134:	eb 42                	jmp    1178 <printf+0x16c>
      } else if(c == '%'){
    1136:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    113a:	75 17                	jne    1153 <printf+0x147>
        putc(fd, c);
    113c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    113f:	0f be c0             	movsbl %al,%eax
    1142:	83 ec 08             	sub    $0x8,%esp
    1145:	50                   	push   %eax
    1146:	ff 75 08             	pushl  0x8(%ebp)
    1149:	e8 ec fd ff ff       	call   f3a <putc>
    114e:	83 c4 10             	add    $0x10,%esp
    1151:	eb 25                	jmp    1178 <printf+0x16c>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1153:	83 ec 08             	sub    $0x8,%esp
    1156:	6a 25                	push   $0x25
    1158:	ff 75 08             	pushl  0x8(%ebp)
    115b:	e8 da fd ff ff       	call   f3a <putc>
    1160:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    1163:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1166:	0f be c0             	movsbl %al,%eax
    1169:	83 ec 08             	sub    $0x8,%esp
    116c:	50                   	push   %eax
    116d:	ff 75 08             	pushl  0x8(%ebp)
    1170:	e8 c5 fd ff ff       	call   f3a <putc>
    1175:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1178:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    117f:	ff 45 f0             	incl   -0x10(%ebp)
    1182:	8b 55 0c             	mov    0xc(%ebp),%edx
    1185:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1188:	01 d0                	add    %edx,%eax
    118a:	8a 00                	mov    (%eax),%al
    118c:	84 c0                	test   %al,%al
    118e:	0f 85 9a fe ff ff    	jne    102e <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1194:	c9                   	leave  
    1195:	c3                   	ret    

00001196 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1196:	55                   	push   %ebp
    1197:	89 e5                	mov    %esp,%ebp
    1199:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    119c:	8b 45 08             	mov    0x8(%ebp),%eax
    119f:	83 e8 08             	sub    $0x8,%eax
    11a2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11a5:	a1 cc 19 00 00       	mov    0x19cc,%eax
    11aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
    11ad:	eb 24                	jmp    11d3 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11af:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11b2:	8b 00                	mov    (%eax),%eax
    11b4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    11b7:	77 12                	ja     11cb <free+0x35>
    11b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    11bc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    11bf:	77 24                	ja     11e5 <free+0x4f>
    11c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11c4:	8b 00                	mov    (%eax),%eax
    11c6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    11c9:	77 1a                	ja     11e5 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11ce:	8b 00                	mov    (%eax),%eax
    11d0:	89 45 fc             	mov    %eax,-0x4(%ebp)
    11d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    11d6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    11d9:	76 d4                	jbe    11af <free+0x19>
    11db:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11de:	8b 00                	mov    (%eax),%eax
    11e0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    11e3:	76 ca                	jbe    11af <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    11e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    11e8:	8b 40 04             	mov    0x4(%eax),%eax
    11eb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    11f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
    11f5:	01 c2                	add    %eax,%edx
    11f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11fa:	8b 00                	mov    (%eax),%eax
    11fc:	39 c2                	cmp    %eax,%edx
    11fe:	75 24                	jne    1224 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    1200:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1203:	8b 50 04             	mov    0x4(%eax),%edx
    1206:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1209:	8b 00                	mov    (%eax),%eax
    120b:	8b 40 04             	mov    0x4(%eax),%eax
    120e:	01 c2                	add    %eax,%edx
    1210:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1213:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1216:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1219:	8b 00                	mov    (%eax),%eax
    121b:	8b 10                	mov    (%eax),%edx
    121d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1220:	89 10                	mov    %edx,(%eax)
    1222:	eb 0a                	jmp    122e <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    1224:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1227:	8b 10                	mov    (%eax),%edx
    1229:	8b 45 f8             	mov    -0x8(%ebp),%eax
    122c:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    122e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1231:	8b 40 04             	mov    0x4(%eax),%eax
    1234:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    123b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    123e:	01 d0                	add    %edx,%eax
    1240:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1243:	75 20                	jne    1265 <free+0xcf>
    p->s.size += bp->s.size;
    1245:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1248:	8b 50 04             	mov    0x4(%eax),%edx
    124b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    124e:	8b 40 04             	mov    0x4(%eax),%eax
    1251:	01 c2                	add    %eax,%edx
    1253:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1256:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1259:	8b 45 f8             	mov    -0x8(%ebp),%eax
    125c:	8b 10                	mov    (%eax),%edx
    125e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1261:	89 10                	mov    %edx,(%eax)
    1263:	eb 08                	jmp    126d <free+0xd7>
  } else
    p->s.ptr = bp;
    1265:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1268:	8b 55 f8             	mov    -0x8(%ebp),%edx
    126b:	89 10                	mov    %edx,(%eax)
  freep = p;
    126d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1270:	a3 cc 19 00 00       	mov    %eax,0x19cc
}
    1275:	c9                   	leave  
    1276:	c3                   	ret    

00001277 <morecore>:

static Header*
morecore(uint nu)
{
    1277:	55                   	push   %ebp
    1278:	89 e5                	mov    %esp,%ebp
    127a:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    127d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1284:	77 07                	ja     128d <morecore+0x16>
    nu = 4096;
    1286:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    128d:	8b 45 08             	mov    0x8(%ebp),%eax
    1290:	c1 e0 03             	shl    $0x3,%eax
    1293:	83 ec 0c             	sub    $0xc,%esp
    1296:	50                   	push   %eax
    1297:	e8 86 fc ff ff       	call   f22 <sbrk>
    129c:	83 c4 10             	add    $0x10,%esp
    129f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    12a2:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    12a6:	75 07                	jne    12af <morecore+0x38>
    return 0;
    12a8:	b8 00 00 00 00       	mov    $0x0,%eax
    12ad:	eb 26                	jmp    12d5 <morecore+0x5e>
  hp = (Header*)p;
    12af:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    12b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12b8:	8b 55 08             	mov    0x8(%ebp),%edx
    12bb:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    12be:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12c1:	83 c0 08             	add    $0x8,%eax
    12c4:	83 ec 0c             	sub    $0xc,%esp
    12c7:	50                   	push   %eax
    12c8:	e8 c9 fe ff ff       	call   1196 <free>
    12cd:	83 c4 10             	add    $0x10,%esp
  return freep;
    12d0:	a1 cc 19 00 00       	mov    0x19cc,%eax
}
    12d5:	c9                   	leave  
    12d6:	c3                   	ret    

000012d7 <malloc>:

void*
malloc(uint nbytes)
{
    12d7:	55                   	push   %ebp
    12d8:	89 e5                	mov    %esp,%ebp
    12da:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    12dd:	8b 45 08             	mov    0x8(%ebp),%eax
    12e0:	83 c0 07             	add    $0x7,%eax
    12e3:	c1 e8 03             	shr    $0x3,%eax
    12e6:	40                   	inc    %eax
    12e7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    12ea:	a1 cc 19 00 00       	mov    0x19cc,%eax
    12ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
    12f2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    12f6:	75 23                	jne    131b <malloc+0x44>
    base.s.ptr = freep = prevp = &base;
    12f8:	c7 45 f0 c4 19 00 00 	movl   $0x19c4,-0x10(%ebp)
    12ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1302:	a3 cc 19 00 00       	mov    %eax,0x19cc
    1307:	a1 cc 19 00 00       	mov    0x19cc,%eax
    130c:	a3 c4 19 00 00       	mov    %eax,0x19c4
    base.s.size = 0;
    1311:	c7 05 c8 19 00 00 00 	movl   $0x0,0x19c8
    1318:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    131b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    131e:	8b 00                	mov    (%eax),%eax
    1320:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1323:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1326:	8b 40 04             	mov    0x4(%eax),%eax
    1329:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    132c:	72 4d                	jb     137b <malloc+0xa4>
      if(p->s.size == nunits)
    132e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1331:	8b 40 04             	mov    0x4(%eax),%eax
    1334:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1337:	75 0c                	jne    1345 <malloc+0x6e>
        prevp->s.ptr = p->s.ptr;
    1339:	8b 45 f4             	mov    -0xc(%ebp),%eax
    133c:	8b 10                	mov    (%eax),%edx
    133e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1341:	89 10                	mov    %edx,(%eax)
    1343:	eb 26                	jmp    136b <malloc+0x94>
      else {
        p->s.size -= nunits;
    1345:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1348:	8b 40 04             	mov    0x4(%eax),%eax
    134b:	2b 45 ec             	sub    -0x14(%ebp),%eax
    134e:	89 c2                	mov    %eax,%edx
    1350:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1353:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1356:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1359:	8b 40 04             	mov    0x4(%eax),%eax
    135c:	c1 e0 03             	shl    $0x3,%eax
    135f:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1362:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1365:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1368:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    136b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    136e:	a3 cc 19 00 00       	mov    %eax,0x19cc
      return (void*)(p + 1);
    1373:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1376:	83 c0 08             	add    $0x8,%eax
    1379:	eb 3b                	jmp    13b6 <malloc+0xdf>
    }
    if(p == freep)
    137b:	a1 cc 19 00 00       	mov    0x19cc,%eax
    1380:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1383:	75 1e                	jne    13a3 <malloc+0xcc>
      if((p = morecore(nunits)) == 0)
    1385:	83 ec 0c             	sub    $0xc,%esp
    1388:	ff 75 ec             	pushl  -0x14(%ebp)
    138b:	e8 e7 fe ff ff       	call   1277 <morecore>
    1390:	83 c4 10             	add    $0x10,%esp
    1393:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1396:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    139a:	75 07                	jne    13a3 <malloc+0xcc>
        return 0;
    139c:	b8 00 00 00 00       	mov    $0x0,%eax
    13a1:	eb 13                	jmp    13b6 <malloc+0xdf>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    13a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13ac:	8b 00                	mov    (%eax),%eax
    13ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    13b1:	e9 6d ff ff ff       	jmp    1323 <malloc+0x4c>
}
    13b6:	c9                   	leave  
    13b7:	c3                   	ret    
