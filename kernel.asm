
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 50 c6 10 80       	mov    $0x8010c650,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 87 37 10 80       	mov    $0x80103787,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003a:	83 ec 08             	sub    $0x8,%esp
8010003d:	68 b8 83 10 80       	push   $0x801083b8
80100042:	68 60 c6 10 80       	push   $0x8010c660
80100047:	e8 db 4e 00 00       	call   80104f27 <initlock>
8010004c:	83 c4 10             	add    $0x10,%esp

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004f:	c7 05 70 05 11 80 64 	movl   $0x80110564,0x80110570
80100056:	05 11 80 
  bcache.head.next = &bcache.head;
80100059:	c7 05 74 05 11 80 64 	movl   $0x80110564,0x80110574
80100060:	05 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100063:	c7 45 f4 94 c6 10 80 	movl   $0x8010c694,-0xc(%ebp)
8010006a:	eb 3a                	jmp    801000a6 <binit+0x72>
    b->next = bcache.head.next;
8010006c:	8b 15 74 05 11 80    	mov    0x80110574,%edx
80100072:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100075:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
80100078:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007b:	c7 40 0c 64 05 11 80 	movl   $0x80110564,0xc(%eax)
    b->dev = -1;
80100082:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100085:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
8010008c:	a1 74 05 11 80       	mov    0x80110574,%eax
80100091:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100094:	89 50 0c             	mov    %edx,0xc(%eax)
    bcache.head.next = b;
80100097:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010009a:	a3 74 05 11 80       	mov    %eax,0x80110574

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009f:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
801000a6:	81 7d f4 64 05 11 80 	cmpl   $0x80110564,-0xc(%ebp)
801000ad:	72 bd                	jb     8010006c <binit+0x38>
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000af:	c9                   	leave  
801000b0:	c3                   	ret    

801000b1 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return B_BUSY buffer.
static struct buf*
bget(uint dev, uint blockno)
{
801000b1:	55                   	push   %ebp
801000b2:	89 e5                	mov    %esp,%ebp
801000b4:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  acquire(&bcache.lock);
801000b7:	83 ec 0c             	sub    $0xc,%esp
801000ba:	68 60 c6 10 80       	push   $0x8010c660
801000bf:	e8 84 4e 00 00       	call   80104f48 <acquire>
801000c4:	83 c4 10             	add    $0x10,%esp

 loop:
  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000c7:	a1 74 05 11 80       	mov    0x80110574,%eax
801000cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000cf:	eb 67                	jmp    80100138 <bget+0x87>
    if(b->dev == dev && b->blockno == blockno){
801000d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000d4:	8b 40 04             	mov    0x4(%eax),%eax
801000d7:	3b 45 08             	cmp    0x8(%ebp),%eax
801000da:	75 53                	jne    8010012f <bget+0x7e>
801000dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000df:	8b 40 08             	mov    0x8(%eax),%eax
801000e2:	3b 45 0c             	cmp    0xc(%ebp),%eax
801000e5:	75 48                	jne    8010012f <bget+0x7e>
      if(!(b->flags & B_BUSY)){
801000e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000ea:	8b 00                	mov    (%eax),%eax
801000ec:	83 e0 01             	and    $0x1,%eax
801000ef:	85 c0                	test   %eax,%eax
801000f1:	75 27                	jne    8010011a <bget+0x69>
        b->flags |= B_BUSY;
801000f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f6:	8b 00                	mov    (%eax),%eax
801000f8:	83 c8 01             	or     $0x1,%eax
801000fb:	89 c2                	mov    %eax,%edx
801000fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100100:	89 10                	mov    %edx,(%eax)
        release(&bcache.lock);
80100102:	83 ec 0c             	sub    $0xc,%esp
80100105:	68 60 c6 10 80       	push   $0x8010c660
8010010a:	e8 9f 4e 00 00       	call   80104fae <release>
8010010f:	83 c4 10             	add    $0x10,%esp
        return b;
80100112:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100115:	e9 98 00 00 00       	jmp    801001b2 <bget+0x101>
      }
      sleep(b, &bcache.lock);
8010011a:	83 ec 08             	sub    $0x8,%esp
8010011d:	68 60 c6 10 80       	push   $0x8010c660
80100122:	ff 75 f4             	pushl  -0xc(%ebp)
80100125:	e8 31 4b 00 00       	call   80104c5b <sleep>
8010012a:	83 c4 10             	add    $0x10,%esp
      goto loop;
8010012d:	eb 98                	jmp    801000c7 <bget+0x16>

  acquire(&bcache.lock);

 loop:
  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
8010012f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100132:	8b 40 10             	mov    0x10(%eax),%eax
80100135:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100138:	81 7d f4 64 05 11 80 	cmpl   $0x80110564,-0xc(%ebp)
8010013f:	75 90                	jne    801000d1 <bget+0x20>
  }

  // Not cached; recycle some non-busy and clean buffer.
  // "clean" because B_DIRTY and !B_BUSY means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100141:	a1 70 05 11 80       	mov    0x80110570,%eax
80100146:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100149:	eb 51                	jmp    8010019c <bget+0xeb>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
8010014b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010014e:	8b 00                	mov    (%eax),%eax
80100150:	83 e0 01             	and    $0x1,%eax
80100153:	85 c0                	test   %eax,%eax
80100155:	75 3c                	jne    80100193 <bget+0xe2>
80100157:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010015a:	8b 00                	mov    (%eax),%eax
8010015c:	83 e0 04             	and    $0x4,%eax
8010015f:	85 c0                	test   %eax,%eax
80100161:	75 30                	jne    80100193 <bget+0xe2>
      b->dev = dev;
80100163:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100166:	8b 55 08             	mov    0x8(%ebp),%edx
80100169:	89 50 04             	mov    %edx,0x4(%eax)
      b->blockno = blockno;
8010016c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010016f:	8b 55 0c             	mov    0xc(%ebp),%edx
80100172:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = B_BUSY;
80100175:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100178:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
      release(&bcache.lock);
8010017e:	83 ec 0c             	sub    $0xc,%esp
80100181:	68 60 c6 10 80       	push   $0x8010c660
80100186:	e8 23 4e 00 00       	call   80104fae <release>
8010018b:	83 c4 10             	add    $0x10,%esp
      return b;
8010018e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100191:	eb 1f                	jmp    801001b2 <bget+0x101>
  }

  // Not cached; recycle some non-busy and clean buffer.
  // "clean" because B_DIRTY and !B_BUSY means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100193:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100196:	8b 40 0c             	mov    0xc(%eax),%eax
80100199:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010019c:	81 7d f4 64 05 11 80 	cmpl   $0x80110564,-0xc(%ebp)
801001a3:	75 a6                	jne    8010014b <bget+0x9a>
      b->flags = B_BUSY;
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
801001a5:	83 ec 0c             	sub    $0xc,%esp
801001a8:	68 bf 83 10 80       	push   $0x801083bf
801001ad:	e8 9c 03 00 00       	call   8010054e <panic>
}
801001b2:	c9                   	leave  
801001b3:	c3                   	ret    

801001b4 <bread>:

// Return a B_BUSY buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801001b4:	55                   	push   %ebp
801001b5:	89 e5                	mov    %esp,%ebp
801001b7:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  b = bget(dev, blockno);
801001ba:	83 ec 08             	sub    $0x8,%esp
801001bd:	ff 75 0c             	pushl  0xc(%ebp)
801001c0:	ff 75 08             	pushl  0x8(%ebp)
801001c3:	e8 e9 fe ff ff       	call   801000b1 <bget>
801001c8:	83 c4 10             	add    $0x10,%esp
801001cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!(b->flags & B_VALID)) {
801001ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001d1:	8b 00                	mov    (%eax),%eax
801001d3:	83 e0 02             	and    $0x2,%eax
801001d6:	85 c0                	test   %eax,%eax
801001d8:	75 0e                	jne    801001e8 <bread+0x34>
    iderw(b);
801001da:	83 ec 0c             	sub    $0xc,%esp
801001dd:	ff 75 f4             	pushl  -0xc(%ebp)
801001e0:	e8 81 26 00 00       	call   80102866 <iderw>
801001e5:	83 c4 10             	add    $0x10,%esp
  }
  return b;
801001e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801001eb:	c9                   	leave  
801001ec:	c3                   	ret    

801001ed <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
801001ed:	55                   	push   %ebp
801001ee:	89 e5                	mov    %esp,%ebp
801001f0:	83 ec 08             	sub    $0x8,%esp
  if((b->flags & B_BUSY) == 0)
801001f3:	8b 45 08             	mov    0x8(%ebp),%eax
801001f6:	8b 00                	mov    (%eax),%eax
801001f8:	83 e0 01             	and    $0x1,%eax
801001fb:	85 c0                	test   %eax,%eax
801001fd:	75 0d                	jne    8010020c <bwrite+0x1f>
    panic("bwrite");
801001ff:	83 ec 0c             	sub    $0xc,%esp
80100202:	68 d0 83 10 80       	push   $0x801083d0
80100207:	e8 42 03 00 00       	call   8010054e <panic>
  b->flags |= B_DIRTY;
8010020c:	8b 45 08             	mov    0x8(%ebp),%eax
8010020f:	8b 00                	mov    (%eax),%eax
80100211:	83 c8 04             	or     $0x4,%eax
80100214:	89 c2                	mov    %eax,%edx
80100216:	8b 45 08             	mov    0x8(%ebp),%eax
80100219:	89 10                	mov    %edx,(%eax)
  iderw(b);
8010021b:	83 ec 0c             	sub    $0xc,%esp
8010021e:	ff 75 08             	pushl  0x8(%ebp)
80100221:	e8 40 26 00 00       	call   80102866 <iderw>
80100226:	83 c4 10             	add    $0x10,%esp
}
80100229:	c9                   	leave  
8010022a:	c3                   	ret    

8010022b <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
8010022b:	55                   	push   %ebp
8010022c:	89 e5                	mov    %esp,%ebp
8010022e:	83 ec 08             	sub    $0x8,%esp
  if((b->flags & B_BUSY) == 0)
80100231:	8b 45 08             	mov    0x8(%ebp),%eax
80100234:	8b 00                	mov    (%eax),%eax
80100236:	83 e0 01             	and    $0x1,%eax
80100239:	85 c0                	test   %eax,%eax
8010023b:	75 0d                	jne    8010024a <brelse+0x1f>
    panic("brelse");
8010023d:	83 ec 0c             	sub    $0xc,%esp
80100240:	68 d7 83 10 80       	push   $0x801083d7
80100245:	e8 04 03 00 00       	call   8010054e <panic>

  acquire(&bcache.lock);
8010024a:	83 ec 0c             	sub    $0xc,%esp
8010024d:	68 60 c6 10 80       	push   $0x8010c660
80100252:	e8 f1 4c 00 00       	call   80104f48 <acquire>
80100257:	83 c4 10             	add    $0x10,%esp

  b->next->prev = b->prev;
8010025a:	8b 45 08             	mov    0x8(%ebp),%eax
8010025d:	8b 40 10             	mov    0x10(%eax),%eax
80100260:	8b 55 08             	mov    0x8(%ebp),%edx
80100263:	8b 52 0c             	mov    0xc(%edx),%edx
80100266:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
80100269:	8b 45 08             	mov    0x8(%ebp),%eax
8010026c:	8b 40 0c             	mov    0xc(%eax),%eax
8010026f:	8b 55 08             	mov    0x8(%ebp),%edx
80100272:	8b 52 10             	mov    0x10(%edx),%edx
80100275:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
80100278:	8b 15 74 05 11 80    	mov    0x80110574,%edx
8010027e:	8b 45 08             	mov    0x8(%ebp),%eax
80100281:	89 50 10             	mov    %edx,0x10(%eax)
  b->prev = &bcache.head;
80100284:	8b 45 08             	mov    0x8(%ebp),%eax
80100287:	c7 40 0c 64 05 11 80 	movl   $0x80110564,0xc(%eax)
  bcache.head.next->prev = b;
8010028e:	a1 74 05 11 80       	mov    0x80110574,%eax
80100293:	8b 55 08             	mov    0x8(%ebp),%edx
80100296:	89 50 0c             	mov    %edx,0xc(%eax)
  bcache.head.next = b;
80100299:	8b 45 08             	mov    0x8(%ebp),%eax
8010029c:	a3 74 05 11 80       	mov    %eax,0x80110574

  b->flags &= ~B_BUSY;
801002a1:	8b 45 08             	mov    0x8(%ebp),%eax
801002a4:	8b 00                	mov    (%eax),%eax
801002a6:	83 e0 fe             	and    $0xfffffffe,%eax
801002a9:	89 c2                	mov    %eax,%edx
801002ab:	8b 45 08             	mov    0x8(%ebp),%eax
801002ae:	89 10                	mov    %edx,(%eax)
  wakeup(b);
801002b0:	83 ec 0c             	sub    $0xc,%esp
801002b3:	ff 75 08             	pushl  0x8(%ebp)
801002b6:	e8 89 4a 00 00       	call   80104d44 <wakeup>
801002bb:	83 c4 10             	add    $0x10,%esp

  release(&bcache.lock);
801002be:	83 ec 0c             	sub    $0xc,%esp
801002c1:	68 60 c6 10 80       	push   $0x8010c660
801002c6:	e8 e3 4c 00 00       	call   80104fae <release>
801002cb:	83 c4 10             	add    $0x10,%esp
}
801002ce:	c9                   	leave  
801002cf:	c3                   	ret    

801002d0 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801002d0:	55                   	push   %ebp
801002d1:	89 e5                	mov    %esp,%ebp
801002d3:	83 ec 14             	sub    $0x14,%esp
801002d6:	8b 45 08             	mov    0x8(%ebp),%eax
801002d9:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801002dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
801002e0:	89 c2                	mov    %eax,%edx
801002e2:	ec                   	in     (%dx),%al
801002e3:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801002e6:	8a 45 ff             	mov    -0x1(%ebp),%al
}
801002e9:	c9                   	leave  
801002ea:	c3                   	ret    

801002eb <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801002eb:	55                   	push   %ebp
801002ec:	89 e5                	mov    %esp,%ebp
801002ee:	83 ec 08             	sub    $0x8,%esp
801002f1:	8b 45 08             	mov    0x8(%ebp),%eax
801002f4:	8b 55 0c             	mov    0xc(%ebp),%edx
801002f7:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801002fb:	88 55 f8             	mov    %dl,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801002fe:	8a 45 f8             	mov    -0x8(%ebp),%al
80100301:	8b 55 fc             	mov    -0x4(%ebp),%edx
80100304:	ee                   	out    %al,(%dx)
}
80100305:	c9                   	leave  
80100306:	c3                   	ret    

80100307 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80100307:	55                   	push   %ebp
80100308:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
8010030a:	fa                   	cli    
}
8010030b:	5d                   	pop    %ebp
8010030c:	c3                   	ret    

8010030d <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
8010030d:	55                   	push   %ebp
8010030e:	89 e5                	mov    %esp,%ebp
80100310:	53                   	push   %ebx
80100311:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100314:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100318:	74 1c                	je     80100336 <printint+0x29>
8010031a:	8b 45 08             	mov    0x8(%ebp),%eax
8010031d:	c1 e8 1f             	shr    $0x1f,%eax
80100320:	0f b6 c0             	movzbl %al,%eax
80100323:	89 45 10             	mov    %eax,0x10(%ebp)
80100326:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010032a:	74 0a                	je     80100336 <printint+0x29>
    x = -xx;
8010032c:	8b 45 08             	mov    0x8(%ebp),%eax
8010032f:	f7 d8                	neg    %eax
80100331:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100334:	eb 06                	jmp    8010033c <printint+0x2f>
  else
    x = xx;
80100336:	8b 45 08             	mov    0x8(%ebp),%eax
80100339:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
8010033c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
80100343:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100346:	8d 41 01             	lea    0x1(%ecx),%eax
80100349:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010034c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010034f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100352:	ba 00 00 00 00       	mov    $0x0,%edx
80100357:	f7 f3                	div    %ebx
80100359:	89 d0                	mov    %edx,%eax
8010035b:	8a 80 04 90 10 80    	mov    -0x7fef6ffc(%eax),%al
80100361:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
  }while((x /= base) != 0);
80100365:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100368:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010036b:	ba 00 00 00 00       	mov    $0x0,%edx
80100370:	f7 f3                	div    %ebx
80100372:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100375:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100379:	75 c8                	jne    80100343 <printint+0x36>

  if(sign)
8010037b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010037f:	74 0e                	je     8010038f <printint+0x82>
    buf[i++] = '-';
80100381:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100384:	8d 50 01             	lea    0x1(%eax),%edx
80100387:	89 55 f4             	mov    %edx,-0xc(%ebp)
8010038a:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)

  while(--i >= 0)
8010038f:	eb 19                	jmp    801003aa <printint+0x9d>
    consputc(buf[i]);
80100391:	8d 55 e0             	lea    -0x20(%ebp),%edx
80100394:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100397:	01 d0                	add    %edx,%eax
80100399:	8a 00                	mov    (%eax),%al
8010039b:	0f be c0             	movsbl %al,%eax
8010039e:	83 ec 0c             	sub    $0xc,%esp
801003a1:	50                   	push   %eax
801003a2:	e8 bc 03 00 00       	call   80100763 <consputc>
801003a7:	83 c4 10             	add    $0x10,%esp
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801003aa:	ff 4d f4             	decl   -0xc(%ebp)
801003ad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801003b1:	79 de                	jns    80100391 <printint+0x84>
    consputc(buf[i]);
}
801003b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801003b6:	c9                   	leave  
801003b7:	c3                   	ret    

801003b8 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801003b8:	55                   	push   %ebp
801003b9:	89 e5                	mov    %esp,%ebp
801003bb:	83 ec 28             	sub    $0x28,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801003be:	a1 f4 b5 10 80       	mov    0x8010b5f4,%eax
801003c3:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
801003c6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801003ca:	74 10                	je     801003dc <cprintf+0x24>
    acquire(&cons.lock);
801003cc:	83 ec 0c             	sub    $0xc,%esp
801003cf:	68 c0 b5 10 80       	push   $0x8010b5c0
801003d4:	e8 6f 4b 00 00       	call   80104f48 <acquire>
801003d9:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
801003dc:	8b 45 08             	mov    0x8(%ebp),%eax
801003df:	85 c0                	test   %eax,%eax
801003e1:	75 0d                	jne    801003f0 <cprintf+0x38>
    panic("null fmt");
801003e3:	83 ec 0c             	sub    $0xc,%esp
801003e6:	68 de 83 10 80       	push   $0x801083de
801003eb:	e8 5e 01 00 00       	call   8010054e <panic>

  argp = (uint*)(void*)(&fmt + 1);
801003f0:	8d 45 0c             	lea    0xc(%ebp),%eax
801003f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801003f6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801003fd:	e9 15 01 00 00       	jmp    80100517 <cprintf+0x15f>
    if(c != '%'){
80100402:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
80100406:	74 13                	je     8010041b <cprintf+0x63>
      consputc(c);
80100408:	83 ec 0c             	sub    $0xc,%esp
8010040b:	ff 75 e4             	pushl  -0x1c(%ebp)
8010040e:	e8 50 03 00 00       	call   80100763 <consputc>
80100413:	83 c4 10             	add    $0x10,%esp
      continue;
80100416:	e9 f9 00 00 00       	jmp    80100514 <cprintf+0x15c>
    }
    c = fmt[++i] & 0xff;
8010041b:	8b 55 08             	mov    0x8(%ebp),%edx
8010041e:	ff 45 f4             	incl   -0xc(%ebp)
80100421:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100424:	01 d0                	add    %edx,%eax
80100426:	8a 00                	mov    (%eax),%al
80100428:	0f be c0             	movsbl %al,%eax
8010042b:	25 ff 00 00 00       	and    $0xff,%eax
80100430:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
80100433:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100437:	75 05                	jne    8010043e <cprintf+0x86>
      break;
80100439:	e9 f8 00 00 00       	jmp    80100536 <cprintf+0x17e>
    switch(c){
8010043e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100441:	83 f8 70             	cmp    $0x70,%eax
80100444:	74 47                	je     8010048d <cprintf+0xd5>
80100446:	83 f8 70             	cmp    $0x70,%eax
80100449:	7f 13                	jg     8010045e <cprintf+0xa6>
8010044b:	83 f8 25             	cmp    $0x25,%eax
8010044e:	0f 84 95 00 00 00    	je     801004e9 <cprintf+0x131>
80100454:	83 f8 64             	cmp    $0x64,%eax
80100457:	74 14                	je     8010046d <cprintf+0xb5>
80100459:	e9 9a 00 00 00       	jmp    801004f8 <cprintf+0x140>
8010045e:	83 f8 73             	cmp    $0x73,%eax
80100461:	74 47                	je     801004aa <cprintf+0xf2>
80100463:	83 f8 78             	cmp    $0x78,%eax
80100466:	74 25                	je     8010048d <cprintf+0xd5>
80100468:	e9 8b 00 00 00       	jmp    801004f8 <cprintf+0x140>
    case 'd':
      printint(*argp++, 10, 1);
8010046d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100470:	8d 50 04             	lea    0x4(%eax),%edx
80100473:	89 55 f0             	mov    %edx,-0x10(%ebp)
80100476:	8b 00                	mov    (%eax),%eax
80100478:	83 ec 04             	sub    $0x4,%esp
8010047b:	6a 01                	push   $0x1
8010047d:	6a 0a                	push   $0xa
8010047f:	50                   	push   %eax
80100480:	e8 88 fe ff ff       	call   8010030d <printint>
80100485:	83 c4 10             	add    $0x10,%esp
      break;
80100488:	e9 87 00 00 00       	jmp    80100514 <cprintf+0x15c>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010048d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100490:	8d 50 04             	lea    0x4(%eax),%edx
80100493:	89 55 f0             	mov    %edx,-0x10(%ebp)
80100496:	8b 00                	mov    (%eax),%eax
80100498:	83 ec 04             	sub    $0x4,%esp
8010049b:	6a 00                	push   $0x0
8010049d:	6a 10                	push   $0x10
8010049f:	50                   	push   %eax
801004a0:	e8 68 fe ff ff       	call   8010030d <printint>
801004a5:	83 c4 10             	add    $0x10,%esp
      break;
801004a8:	eb 6a                	jmp    80100514 <cprintf+0x15c>
    case 's':
      if((s = (char*)*argp++) == 0)
801004aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004ad:	8d 50 04             	lea    0x4(%eax),%edx
801004b0:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004b3:	8b 00                	mov    (%eax),%eax
801004b5:	89 45 ec             	mov    %eax,-0x14(%ebp)
801004b8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801004bc:	75 07                	jne    801004c5 <cprintf+0x10d>
        s = "(null)";
801004be:	c7 45 ec e7 83 10 80 	movl   $0x801083e7,-0x14(%ebp)
      for(; *s; s++)
801004c5:	eb 17                	jmp    801004de <cprintf+0x126>
        consputc(*s);
801004c7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004ca:	8a 00                	mov    (%eax),%al
801004cc:	0f be c0             	movsbl %al,%eax
801004cf:	83 ec 0c             	sub    $0xc,%esp
801004d2:	50                   	push   %eax
801004d3:	e8 8b 02 00 00       	call   80100763 <consputc>
801004d8:	83 c4 10             	add    $0x10,%esp
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801004db:	ff 45 ec             	incl   -0x14(%ebp)
801004de:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004e1:	8a 00                	mov    (%eax),%al
801004e3:	84 c0                	test   %al,%al
801004e5:	75 e0                	jne    801004c7 <cprintf+0x10f>
        consputc(*s);
      break;
801004e7:	eb 2b                	jmp    80100514 <cprintf+0x15c>
    case '%':
      consputc('%');
801004e9:	83 ec 0c             	sub    $0xc,%esp
801004ec:	6a 25                	push   $0x25
801004ee:	e8 70 02 00 00       	call   80100763 <consputc>
801004f3:	83 c4 10             	add    $0x10,%esp
      break;
801004f6:	eb 1c                	jmp    80100514 <cprintf+0x15c>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
801004f8:	83 ec 0c             	sub    $0xc,%esp
801004fb:	6a 25                	push   $0x25
801004fd:	e8 61 02 00 00       	call   80100763 <consputc>
80100502:	83 c4 10             	add    $0x10,%esp
      consputc(c);
80100505:	83 ec 0c             	sub    $0xc,%esp
80100508:	ff 75 e4             	pushl  -0x1c(%ebp)
8010050b:	e8 53 02 00 00       	call   80100763 <consputc>
80100510:	83 c4 10             	add    $0x10,%esp
      break;
80100513:	90                   	nop

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100514:	ff 45 f4             	incl   -0xc(%ebp)
80100517:	8b 55 08             	mov    0x8(%ebp),%edx
8010051a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010051d:	01 d0                	add    %edx,%eax
8010051f:	8a 00                	mov    (%eax),%al
80100521:	0f be c0             	movsbl %al,%eax
80100524:	25 ff 00 00 00       	and    $0xff,%eax
80100529:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010052c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100530:	0f 85 cc fe ff ff    	jne    80100402 <cprintf+0x4a>
      consputc(c);
      break;
    }
  }

  if(locking)
80100536:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010053a:	74 10                	je     8010054c <cprintf+0x194>
    release(&cons.lock);
8010053c:	83 ec 0c             	sub    $0xc,%esp
8010053f:	68 c0 b5 10 80       	push   $0x8010b5c0
80100544:	e8 65 4a 00 00       	call   80104fae <release>
80100549:	83 c4 10             	add    $0x10,%esp
}
8010054c:	c9                   	leave  
8010054d:	c3                   	ret    

8010054e <panic>:

void
panic(char *s)
{
8010054e:	55                   	push   %ebp
8010054f:	89 e5                	mov    %esp,%ebp
80100551:	83 ec 38             	sub    $0x38,%esp
  int i;
  uint pcs[10];
  
  cli();
80100554:	e8 ae fd ff ff       	call   80100307 <cli>
  cons.locking = 0;
80100559:	c7 05 f4 b5 10 80 00 	movl   $0x0,0x8010b5f4
80100560:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
80100563:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80100569:	8a 00                	mov    (%eax),%al
8010056b:	0f b6 c0             	movzbl %al,%eax
8010056e:	83 ec 08             	sub    $0x8,%esp
80100571:	50                   	push   %eax
80100572:	68 ee 83 10 80       	push   $0x801083ee
80100577:	e8 3c fe ff ff       	call   801003b8 <cprintf>
8010057c:	83 c4 10             	add    $0x10,%esp
  cprintf(s);
8010057f:	8b 45 08             	mov    0x8(%ebp),%eax
80100582:	83 ec 0c             	sub    $0xc,%esp
80100585:	50                   	push   %eax
80100586:	e8 2d fe ff ff       	call   801003b8 <cprintf>
8010058b:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
8010058e:	83 ec 0c             	sub    $0xc,%esp
80100591:	68 fd 83 10 80       	push   $0x801083fd
80100596:	e8 1d fe ff ff       	call   801003b8 <cprintf>
8010059b:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
8010059e:	83 ec 08             	sub    $0x8,%esp
801005a1:	8d 45 cc             	lea    -0x34(%ebp),%eax
801005a4:	50                   	push   %eax
801005a5:	8d 45 08             	lea    0x8(%ebp),%eax
801005a8:	50                   	push   %eax
801005a9:	e8 51 4a 00 00       	call   80104fff <getcallerpcs>
801005ae:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
801005b1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801005b8:	eb 1b                	jmp    801005d5 <panic+0x87>
    cprintf(" %p", pcs[i]);
801005ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005bd:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005c1:	83 ec 08             	sub    $0x8,%esp
801005c4:	50                   	push   %eax
801005c5:	68 ff 83 10 80       	push   $0x801083ff
801005ca:	e8 e9 fd ff ff       	call   801003b8 <cprintf>
801005cf:	83 c4 10             	add    $0x10,%esp
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801005d2:	ff 45 f4             	incl   -0xc(%ebp)
801005d5:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801005d9:	7e df                	jle    801005ba <panic+0x6c>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801005db:	c7 05 a0 b5 10 80 01 	movl   $0x1,0x8010b5a0
801005e2:	00 00 00 
  for(;;)
    ;
801005e5:	eb fe                	jmp    801005e5 <panic+0x97>

801005e7 <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
801005e7:	55                   	push   %ebp
801005e8:	89 e5                	mov    %esp,%ebp
801005ea:	83 ec 18             	sub    $0x18,%esp
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
801005ed:	6a 0e                	push   $0xe
801005ef:	68 d4 03 00 00       	push   $0x3d4
801005f4:	e8 f2 fc ff ff       	call   801002eb <outb>
801005f9:	83 c4 08             	add    $0x8,%esp
  pos = inb(CRTPORT+1) << 8;
801005fc:	68 d5 03 00 00       	push   $0x3d5
80100601:	e8 ca fc ff ff       	call   801002d0 <inb>
80100606:	83 c4 04             	add    $0x4,%esp
80100609:	0f b6 c0             	movzbl %al,%eax
8010060c:	c1 e0 08             	shl    $0x8,%eax
8010060f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
80100612:	6a 0f                	push   $0xf
80100614:	68 d4 03 00 00       	push   $0x3d4
80100619:	e8 cd fc ff ff       	call   801002eb <outb>
8010061e:	83 c4 08             	add    $0x8,%esp
  pos |= inb(CRTPORT+1);
80100621:	68 d5 03 00 00       	push   $0x3d5
80100626:	e8 a5 fc ff ff       	call   801002d0 <inb>
8010062b:	83 c4 04             	add    $0x4,%esp
8010062e:	0f b6 c0             	movzbl %al,%eax
80100631:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
80100634:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
80100638:	75 1b                	jne    80100655 <cgaputc+0x6e>
    pos += 80 - pos%80;
8010063a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010063d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100642:	99                   	cltd   
80100643:	f7 f9                	idiv   %ecx
80100645:	89 d0                	mov    %edx,%eax
80100647:	ba 50 00 00 00       	mov    $0x50,%edx
8010064c:	29 c2                	sub    %eax,%edx
8010064e:	89 d0                	mov    %edx,%eax
80100650:	01 45 f4             	add    %eax,-0xc(%ebp)
80100653:	eb 34                	jmp    80100689 <cgaputc+0xa2>
  else if(c == BACKSPACE){
80100655:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
8010065c:	75 0b                	jne    80100669 <cgaputc+0x82>
    if(pos > 0) --pos;
8010065e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100662:	7e 25                	jle    80100689 <cgaputc+0xa2>
80100664:	ff 4d f4             	decl   -0xc(%ebp)
80100667:	eb 20                	jmp    80100689 <cgaputc+0xa2>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100669:	8b 0d 00 90 10 80    	mov    0x80109000,%ecx
8010066f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100672:	8d 50 01             	lea    0x1(%eax),%edx
80100675:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100678:	01 c0                	add    %eax,%eax
8010067a:	8d 14 01             	lea    (%ecx,%eax,1),%edx
8010067d:	8b 45 08             	mov    0x8(%ebp),%eax
80100680:	0f b6 c0             	movzbl %al,%eax
80100683:	80 cc 07             	or     $0x7,%ah
80100686:	66 89 02             	mov    %ax,(%edx)

  if(pos < 0 || pos > 25*80)
80100689:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010068d:	78 09                	js     80100698 <cgaputc+0xb1>
8010068f:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
80100696:	7e 0d                	jle    801006a5 <cgaputc+0xbe>
    panic("pos under/overflow");
80100698:	83 ec 0c             	sub    $0xc,%esp
8010069b:	68 03 84 10 80       	push   $0x80108403
801006a0:	e8 a9 fe ff ff       	call   8010054e <panic>
  
  if((pos/80) >= 24){  // Scroll up.
801006a5:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
801006ac:	7e 4c                	jle    801006fa <cgaputc+0x113>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801006ae:	a1 00 90 10 80       	mov    0x80109000,%eax
801006b3:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
801006b9:	a1 00 90 10 80       	mov    0x80109000,%eax
801006be:	83 ec 04             	sub    $0x4,%esp
801006c1:	68 60 0e 00 00       	push   $0xe60
801006c6:	52                   	push   %edx
801006c7:	50                   	push   %eax
801006c8:	e8 8c 4b 00 00       	call   80105259 <memmove>
801006cd:	83 c4 10             	add    $0x10,%esp
    pos -= 80;
801006d0:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801006d4:	b8 80 07 00 00       	mov    $0x780,%eax
801006d9:	2b 45 f4             	sub    -0xc(%ebp),%eax
801006dc:	01 c0                	add    %eax,%eax
801006de:	8b 0d 00 90 10 80    	mov    0x80109000,%ecx
801006e4:	8b 55 f4             	mov    -0xc(%ebp),%edx
801006e7:	01 d2                	add    %edx,%edx
801006e9:	01 ca                	add    %ecx,%edx
801006eb:	83 ec 04             	sub    $0x4,%esp
801006ee:	50                   	push   %eax
801006ef:	6a 00                	push   $0x0
801006f1:	52                   	push   %edx
801006f2:	e8 a9 4a 00 00       	call   801051a0 <memset>
801006f7:	83 c4 10             	add    $0x10,%esp
  }
  
  outb(CRTPORT, 14);
801006fa:	83 ec 08             	sub    $0x8,%esp
801006fd:	6a 0e                	push   $0xe
801006ff:	68 d4 03 00 00       	push   $0x3d4
80100704:	e8 e2 fb ff ff       	call   801002eb <outb>
80100709:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos>>8);
8010070c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010070f:	c1 f8 08             	sar    $0x8,%eax
80100712:	0f b6 c0             	movzbl %al,%eax
80100715:	83 ec 08             	sub    $0x8,%esp
80100718:	50                   	push   %eax
80100719:	68 d5 03 00 00       	push   $0x3d5
8010071e:	e8 c8 fb ff ff       	call   801002eb <outb>
80100723:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT, 15);
80100726:	83 ec 08             	sub    $0x8,%esp
80100729:	6a 0f                	push   $0xf
8010072b:	68 d4 03 00 00       	push   $0x3d4
80100730:	e8 b6 fb ff ff       	call   801002eb <outb>
80100735:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos);
80100738:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010073b:	0f b6 c0             	movzbl %al,%eax
8010073e:	83 ec 08             	sub    $0x8,%esp
80100741:	50                   	push   %eax
80100742:	68 d5 03 00 00       	push   $0x3d5
80100747:	e8 9f fb ff ff       	call   801002eb <outb>
8010074c:	83 c4 10             	add    $0x10,%esp
  crt[pos] = ' ' | 0x0700;
8010074f:	8b 15 00 90 10 80    	mov    0x80109000,%edx
80100755:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100758:	01 c0                	add    %eax,%eax
8010075a:	01 d0                	add    %edx,%eax
8010075c:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
80100761:	c9                   	leave  
80100762:	c3                   	ret    

80100763 <consputc>:

void
consputc(int c)
{
80100763:	55                   	push   %ebp
80100764:	89 e5                	mov    %esp,%ebp
80100766:	83 ec 08             	sub    $0x8,%esp
  if(panicked){
80100769:	a1 a0 b5 10 80       	mov    0x8010b5a0,%eax
8010076e:	85 c0                	test   %eax,%eax
80100770:	74 07                	je     80100779 <consputc+0x16>
    cli();
80100772:	e8 90 fb ff ff       	call   80100307 <cli>
    for(;;)
      ;
80100777:	eb fe                	jmp    80100777 <consputc+0x14>
  }

  if(c == BACKSPACE){
80100779:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100780:	75 29                	jne    801007ab <consputc+0x48>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100782:	83 ec 0c             	sub    $0xc,%esp
80100785:	6a 08                	push   $0x8
80100787:	e8 f6 62 00 00       	call   80106a82 <uartputc>
8010078c:	83 c4 10             	add    $0x10,%esp
8010078f:	83 ec 0c             	sub    $0xc,%esp
80100792:	6a 20                	push   $0x20
80100794:	e8 e9 62 00 00       	call   80106a82 <uartputc>
80100799:	83 c4 10             	add    $0x10,%esp
8010079c:	83 ec 0c             	sub    $0xc,%esp
8010079f:	6a 08                	push   $0x8
801007a1:	e8 dc 62 00 00       	call   80106a82 <uartputc>
801007a6:	83 c4 10             	add    $0x10,%esp
801007a9:	eb 0e                	jmp    801007b9 <consputc+0x56>
  } else
    uartputc(c);
801007ab:	83 ec 0c             	sub    $0xc,%esp
801007ae:	ff 75 08             	pushl  0x8(%ebp)
801007b1:	e8 cc 62 00 00       	call   80106a82 <uartputc>
801007b6:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
801007b9:	83 ec 0c             	sub    $0xc,%esp
801007bc:	ff 75 08             	pushl  0x8(%ebp)
801007bf:	e8 23 fe ff ff       	call   801005e7 <cgaputc>
801007c4:	83 c4 10             	add    $0x10,%esp
}
801007c7:	c9                   	leave  
801007c8:	c3                   	ret    

801007c9 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007c9:	55                   	push   %ebp
801007ca:	89 e5                	mov    %esp,%ebp
801007cc:	83 ec 18             	sub    $0x18,%esp
  int c, doprocdump = 0;
801007cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&cons.lock);
801007d6:	83 ec 0c             	sub    $0xc,%esp
801007d9:	68 c0 b5 10 80       	push   $0x8010b5c0
801007de:	e8 65 47 00 00       	call   80104f48 <acquire>
801007e3:	83 c4 10             	add    $0x10,%esp
  while((c = getc()) >= 0){
801007e6:	e9 34 01 00 00       	jmp    8010091f <consoleintr+0x156>
    switch(c){
801007eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801007ee:	83 f8 10             	cmp    $0x10,%eax
801007f1:	74 1b                	je     8010080e <consoleintr+0x45>
801007f3:	83 f8 10             	cmp    $0x10,%eax
801007f6:	7f 0a                	jg     80100802 <consoleintr+0x39>
801007f8:	83 f8 08             	cmp    $0x8,%eax
801007fb:	74 5f                	je     8010085c <consoleintr+0x93>
801007fd:	e9 89 00 00 00       	jmp    8010088b <consoleintr+0xc2>
80100802:	83 f8 15             	cmp    $0x15,%eax
80100805:	74 2e                	je     80100835 <consoleintr+0x6c>
80100807:	83 f8 7f             	cmp    $0x7f,%eax
8010080a:	74 50                	je     8010085c <consoleintr+0x93>
8010080c:	eb 7d                	jmp    8010088b <consoleintr+0xc2>
    case C('P'):  // Process listing.
      doprocdump = 1;   // procdump() locks cons.lock indirectly; invoke later
8010080e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      break;
80100815:	e9 05 01 00 00       	jmp    8010091f <consoleintr+0x156>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
8010081a:	a1 08 08 11 80       	mov    0x80110808,%eax
8010081f:	48                   	dec    %eax
80100820:	a3 08 08 11 80       	mov    %eax,0x80110808
        consputc(BACKSPACE);
80100825:	83 ec 0c             	sub    $0xc,%esp
80100828:	68 00 01 00 00       	push   $0x100
8010082d:	e8 31 ff ff ff       	call   80100763 <consputc>
80100832:	83 c4 10             	add    $0x10,%esp
    switch(c){
    case C('P'):  // Process listing.
      doprocdump = 1;   // procdump() locks cons.lock indirectly; invoke later
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100835:	8b 15 08 08 11 80    	mov    0x80110808,%edx
8010083b:	a1 04 08 11 80       	mov    0x80110804,%eax
80100840:	39 c2                	cmp    %eax,%edx
80100842:	74 13                	je     80100857 <consoleintr+0x8e>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100844:	a1 08 08 11 80       	mov    0x80110808,%eax
80100849:	48                   	dec    %eax
8010084a:	83 e0 7f             	and    $0x7f,%eax
8010084d:	8a 80 80 07 11 80    	mov    -0x7feef880(%eax),%al
    switch(c){
    case C('P'):  // Process listing.
      doprocdump = 1;   // procdump() locks cons.lock indirectly; invoke later
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100853:	3c 0a                	cmp    $0xa,%al
80100855:	75 c3                	jne    8010081a <consoleintr+0x51>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
80100857:	e9 c3 00 00 00       	jmp    8010091f <consoleintr+0x156>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
8010085c:	8b 15 08 08 11 80    	mov    0x80110808,%edx
80100862:	a1 04 08 11 80       	mov    0x80110804,%eax
80100867:	39 c2                	cmp    %eax,%edx
80100869:	74 1b                	je     80100886 <consoleintr+0xbd>
        input.e--;
8010086b:	a1 08 08 11 80       	mov    0x80110808,%eax
80100870:	48                   	dec    %eax
80100871:	a3 08 08 11 80       	mov    %eax,0x80110808
        consputc(BACKSPACE);
80100876:	83 ec 0c             	sub    $0xc,%esp
80100879:	68 00 01 00 00       	push   $0x100
8010087e:	e8 e0 fe ff ff       	call   80100763 <consputc>
80100883:	83 c4 10             	add    $0x10,%esp
      }
      break;
80100886:	e9 94 00 00 00       	jmp    8010091f <consoleintr+0x156>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
8010088b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010088f:	0f 84 89 00 00 00    	je     8010091e <consoleintr+0x155>
80100895:	8b 15 08 08 11 80    	mov    0x80110808,%edx
8010089b:	a1 00 08 11 80       	mov    0x80110800,%eax
801008a0:	29 c2                	sub    %eax,%edx
801008a2:	89 d0                	mov    %edx,%eax
801008a4:	83 f8 7f             	cmp    $0x7f,%eax
801008a7:	77 75                	ja     8010091e <consoleintr+0x155>
        c = (c == '\r') ? '\n' : c;
801008a9:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
801008ad:	74 05                	je     801008b4 <consoleintr+0xeb>
801008af:	8b 45 f0             	mov    -0x10(%ebp),%eax
801008b2:	eb 05                	jmp    801008b9 <consoleintr+0xf0>
801008b4:	b8 0a 00 00 00       	mov    $0xa,%eax
801008b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
801008bc:	a1 08 08 11 80       	mov    0x80110808,%eax
801008c1:	8d 50 01             	lea    0x1(%eax),%edx
801008c4:	89 15 08 08 11 80    	mov    %edx,0x80110808
801008ca:	83 e0 7f             	and    $0x7f,%eax
801008cd:	89 c2                	mov    %eax,%edx
801008cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
801008d2:	88 82 80 07 11 80    	mov    %al,-0x7feef880(%edx)
        consputc(c);
801008d8:	83 ec 0c             	sub    $0xc,%esp
801008db:	ff 75 f0             	pushl  -0x10(%ebp)
801008de:	e8 80 fe ff ff       	call   80100763 <consputc>
801008e3:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e6:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
801008ea:	74 18                	je     80100904 <consoleintr+0x13b>
801008ec:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
801008f0:	74 12                	je     80100904 <consoleintr+0x13b>
801008f2:	a1 08 08 11 80       	mov    0x80110808,%eax
801008f7:	8b 15 00 08 11 80    	mov    0x80110800,%edx
801008fd:	83 ea 80             	sub    $0xffffff80,%edx
80100900:	39 d0                	cmp    %edx,%eax
80100902:	75 1a                	jne    8010091e <consoleintr+0x155>
          input.w = input.e;
80100904:	a1 08 08 11 80       	mov    0x80110808,%eax
80100909:	a3 04 08 11 80       	mov    %eax,0x80110804
          wakeup(&input.r);
8010090e:	83 ec 0c             	sub    $0xc,%esp
80100911:	68 00 08 11 80       	push   $0x80110800
80100916:	e8 29 44 00 00       	call   80104d44 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
        }
      }
      break;
8010091e:	90                   	nop
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
8010091f:	8b 45 08             	mov    0x8(%ebp),%eax
80100922:	ff d0                	call   *%eax
80100924:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100927:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010092b:	0f 89 ba fe ff ff    	jns    801007eb <consoleintr+0x22>
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100931:	83 ec 0c             	sub    $0xc,%esp
80100934:	68 c0 b5 10 80       	push   $0x8010b5c0
80100939:	e8 70 46 00 00       	call   80104fae <release>
8010093e:	83 c4 10             	add    $0x10,%esp
  if(doprocdump) {
80100941:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100945:	74 05                	je     8010094c <consoleintr+0x183>
    procdump();  // now call procdump() wo. cons.lock held
80100947:	e8 b2 44 00 00       	call   80104dfe <procdump>
  }
}
8010094c:	c9                   	leave  
8010094d:	c3                   	ret    

8010094e <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
8010094e:	55                   	push   %ebp
8010094f:	89 e5                	mov    %esp,%ebp
80100951:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
80100954:	83 ec 0c             	sub    $0xc,%esp
80100957:	ff 75 08             	pushl  0x8(%ebp)
8010095a:	e8 d6 10 00 00       	call   80101a35 <iunlock>
8010095f:	83 c4 10             	add    $0x10,%esp
  target = n;
80100962:	8b 45 10             	mov    0x10(%ebp),%eax
80100965:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&cons.lock);
80100968:	83 ec 0c             	sub    $0xc,%esp
8010096b:	68 c0 b5 10 80       	push   $0x8010b5c0
80100970:	e8 d3 45 00 00       	call   80104f48 <acquire>
80100975:	83 c4 10             	add    $0x10,%esp
  while(n > 0){
80100978:	e9 ae 00 00 00       	jmp    80100a2b <consoleread+0xdd>
    while(input.r == input.w){
8010097d:	eb 4a                	jmp    801009c9 <consoleread+0x7b>
      if(proc->killed){
8010097f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100985:	8b 40 24             	mov    0x24(%eax),%eax
80100988:	85 c0                	test   %eax,%eax
8010098a:	74 28                	je     801009b4 <consoleread+0x66>
        release(&cons.lock);
8010098c:	83 ec 0c             	sub    $0xc,%esp
8010098f:	68 c0 b5 10 80       	push   $0x8010b5c0
80100994:	e8 15 46 00 00       	call   80104fae <release>
80100999:	83 c4 10             	add    $0x10,%esp
        ilock(ip);
8010099c:	83 ec 0c             	sub    $0xc,%esp
8010099f:	ff 75 08             	pushl  0x8(%ebp)
801009a2:	e8 34 0f 00 00       	call   801018db <ilock>
801009a7:	83 c4 10             	add    $0x10,%esp
        return -1;
801009aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801009af:	e9 a9 00 00 00       	jmp    80100a5d <consoleread+0x10f>
      }
      sleep(&input.r, &cons.lock);
801009b4:	83 ec 08             	sub    $0x8,%esp
801009b7:	68 c0 b5 10 80       	push   $0x8010b5c0
801009bc:	68 00 08 11 80       	push   $0x80110800
801009c1:	e8 95 42 00 00       	call   80104c5b <sleep>
801009c6:	83 c4 10             	add    $0x10,%esp

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801009c9:	8b 15 00 08 11 80    	mov    0x80110800,%edx
801009cf:	a1 04 08 11 80       	mov    0x80110804,%eax
801009d4:	39 c2                	cmp    %eax,%edx
801009d6:	74 a7                	je     8010097f <consoleread+0x31>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
801009d8:	a1 00 08 11 80       	mov    0x80110800,%eax
801009dd:	8d 50 01             	lea    0x1(%eax),%edx
801009e0:	89 15 00 08 11 80    	mov    %edx,0x80110800
801009e6:	83 e0 7f             	and    $0x7f,%eax
801009e9:	8a 80 80 07 11 80    	mov    -0x7feef880(%eax),%al
801009ef:	0f be c0             	movsbl %al,%eax
801009f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
801009f5:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
801009f9:	75 17                	jne    80100a12 <consoleread+0xc4>
      if(n < target){
801009fb:	8b 45 10             	mov    0x10(%ebp),%eax
801009fe:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80100a01:	73 0d                	jae    80100a10 <consoleread+0xc2>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100a03:	a1 00 08 11 80       	mov    0x80110800,%eax
80100a08:	48                   	dec    %eax
80100a09:	a3 00 08 11 80       	mov    %eax,0x80110800
      }
      break;
80100a0e:	eb 25                	jmp    80100a35 <consoleread+0xe7>
80100a10:	eb 23                	jmp    80100a35 <consoleread+0xe7>
    }
    *dst++ = c;
80100a12:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a15:	8d 50 01             	lea    0x1(%eax),%edx
80100a18:	89 55 0c             	mov    %edx,0xc(%ebp)
80100a1b:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100a1e:	88 10                	mov    %dl,(%eax)
    --n;
80100a20:	ff 4d 10             	decl   0x10(%ebp)
    if(c == '\n')
80100a23:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100a27:	75 02                	jne    80100a2b <consoleread+0xdd>
      break;
80100a29:	eb 0a                	jmp    80100a35 <consoleread+0xe7>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100a2b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100a2f:	0f 8f 48 ff ff ff    	jg     8010097d <consoleread+0x2f>
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
80100a35:	83 ec 0c             	sub    $0xc,%esp
80100a38:	68 c0 b5 10 80       	push   $0x8010b5c0
80100a3d:	e8 6c 45 00 00       	call   80104fae <release>
80100a42:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100a45:	83 ec 0c             	sub    $0xc,%esp
80100a48:	ff 75 08             	pushl  0x8(%ebp)
80100a4b:	e8 8b 0e 00 00       	call   801018db <ilock>
80100a50:	83 c4 10             	add    $0x10,%esp

  return target - n;
80100a53:	8b 45 10             	mov    0x10(%ebp),%eax
80100a56:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a59:	29 c2                	sub    %eax,%edx
80100a5b:	89 d0                	mov    %edx,%eax
}
80100a5d:	c9                   	leave  
80100a5e:	c3                   	ret    

80100a5f <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100a5f:	55                   	push   %ebp
80100a60:	89 e5                	mov    %esp,%ebp
80100a62:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100a65:	83 ec 0c             	sub    $0xc,%esp
80100a68:	ff 75 08             	pushl  0x8(%ebp)
80100a6b:	e8 c5 0f 00 00       	call   80101a35 <iunlock>
80100a70:	83 c4 10             	add    $0x10,%esp
  acquire(&cons.lock);
80100a73:	83 ec 0c             	sub    $0xc,%esp
80100a76:	68 c0 b5 10 80       	push   $0x8010b5c0
80100a7b:	e8 c8 44 00 00       	call   80104f48 <acquire>
80100a80:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100a83:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100a8a:	eb 1f                	jmp    80100aab <consolewrite+0x4c>
    consputc(buf[i] & 0xff);
80100a8c:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a8f:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a92:	01 d0                	add    %edx,%eax
80100a94:	8a 00                	mov    (%eax),%al
80100a96:	0f be c0             	movsbl %al,%eax
80100a99:	0f b6 c0             	movzbl %al,%eax
80100a9c:	83 ec 0c             	sub    $0xc,%esp
80100a9f:	50                   	push   %eax
80100aa0:	e8 be fc ff ff       	call   80100763 <consputc>
80100aa5:	83 c4 10             	add    $0x10,%esp
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100aa8:	ff 45 f4             	incl   -0xc(%ebp)
80100aab:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100aae:	3b 45 10             	cmp    0x10(%ebp),%eax
80100ab1:	7c d9                	jl     80100a8c <consolewrite+0x2d>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
80100ab3:	83 ec 0c             	sub    $0xc,%esp
80100ab6:	68 c0 b5 10 80       	push   $0x8010b5c0
80100abb:	e8 ee 44 00 00       	call   80104fae <release>
80100ac0:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100ac3:	83 ec 0c             	sub    $0xc,%esp
80100ac6:	ff 75 08             	pushl  0x8(%ebp)
80100ac9:	e8 0d 0e 00 00       	call   801018db <ilock>
80100ace:	83 c4 10             	add    $0x10,%esp

  return n;
80100ad1:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100ad4:	c9                   	leave  
80100ad5:	c3                   	ret    

80100ad6 <consoleinit>:

void
consoleinit(void)
{
80100ad6:	55                   	push   %ebp
80100ad7:	89 e5                	mov    %esp,%ebp
80100ad9:	83 ec 08             	sub    $0x8,%esp
  initlock(&cons.lock, "console");
80100adc:	83 ec 08             	sub    $0x8,%esp
80100adf:	68 16 84 10 80       	push   $0x80108416
80100ae4:	68 c0 b5 10 80       	push   $0x8010b5c0
80100ae9:	e8 39 44 00 00       	call   80104f27 <initlock>
80100aee:	83 c4 10             	add    $0x10,%esp

  devsw[CONSOLE].write = consolewrite;
80100af1:	c7 05 cc 11 11 80 5f 	movl   $0x80100a5f,0x801111cc
80100af8:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100afb:	c7 05 c8 11 11 80 4e 	movl   $0x8010094e,0x801111c8
80100b02:	09 10 80 
  cons.locking = 1;
80100b05:	c7 05 f4 b5 10 80 01 	movl   $0x1,0x8010b5f4
80100b0c:	00 00 00 

  picenable(IRQ_KBD);
80100b0f:	83 ec 0c             	sub    $0xc,%esp
80100b12:	6a 01                	push   $0x1
80100b14:	e8 62 33 00 00       	call   80103e7b <picenable>
80100b19:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_KBD, 0);
80100b1c:	83 ec 08             	sub    $0x8,%esp
80100b1f:	6a 00                	push   $0x0
80100b21:	6a 01                	push   $0x1
80100b23:	e8 02 1f 00 00       	call   80102a2a <ioapicenable>
80100b28:	83 c4 10             	add    $0x10,%esp
}
80100b2b:	c9                   	leave  
80100b2c:	c3                   	ret    

80100b2d <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100b2d:	55                   	push   %ebp
80100b2e:	89 e5                	mov    %esp,%ebp
80100b30:	81 ec 18 01 00 00    	sub    $0x118,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
80100b36:	e8 1b 29 00 00       	call   80103456 <begin_op>
  if((ip = namei(path)) == 0){
80100b3b:	83 ec 0c             	sub    $0xc,%esp
80100b3e:	ff 75 08             	pushl  0x8(%ebp)
80100b41:	e8 47 19 00 00       	call   8010248d <namei>
80100b46:	83 c4 10             	add    $0x10,%esp
80100b49:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100b4c:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100b50:	75 0f                	jne    80100b61 <exec+0x34>
    end_op();
80100b52:	e8 8b 29 00 00       	call   801034e2 <end_op>
    return -1;
80100b57:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b5c:	e9 ab 03 00 00       	jmp    80100f0c <exec+0x3df>
  }
  ilock(ip);
80100b61:	83 ec 0c             	sub    $0xc,%esp
80100b64:	ff 75 d8             	pushl  -0x28(%ebp)
80100b67:	e8 6f 0d 00 00       	call   801018db <ilock>
80100b6c:	83 c4 10             	add    $0x10,%esp
  pgdir = 0;
80100b6f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100b76:	6a 34                	push   $0x34
80100b78:	6a 00                	push   $0x0
80100b7a:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
80100b80:	50                   	push   %eax
80100b81:	ff 75 d8             	pushl  -0x28(%ebp)
80100b84:	e8 b4 12 00 00       	call   80101e3d <readi>
80100b89:	83 c4 10             	add    $0x10,%esp
80100b8c:	83 f8 33             	cmp    $0x33,%eax
80100b8f:	77 05                	ja     80100b96 <exec+0x69>
    goto bad;
80100b91:	e9 44 03 00 00       	jmp    80100eda <exec+0x3ad>
  if(elf.magic != ELF_MAGIC)
80100b96:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b9c:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100ba1:	74 05                	je     80100ba8 <exec+0x7b>
    goto bad;
80100ba3:	e9 32 03 00 00       	jmp    80100eda <exec+0x3ad>

  if((pgdir = setupkvm()) == 0)
80100ba8:	e8 ff 6f 00 00       	call   80107bac <setupkvm>
80100bad:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100bb0:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100bb4:	75 05                	jne    80100bbb <exec+0x8e>
    goto bad;
80100bb6:	e9 1f 03 00 00       	jmp    80100eda <exec+0x3ad>

  // Load program into memory.
  sz = 0;
80100bbb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bc2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100bc9:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
80100bcf:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100bd2:	e9 ad 00 00 00       	jmp    80100c84 <exec+0x157>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bd7:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100bda:	6a 20                	push   $0x20
80100bdc:	50                   	push   %eax
80100bdd:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
80100be3:	50                   	push   %eax
80100be4:	ff 75 d8             	pushl  -0x28(%ebp)
80100be7:	e8 51 12 00 00       	call   80101e3d <readi>
80100bec:	83 c4 10             	add    $0x10,%esp
80100bef:	83 f8 20             	cmp    $0x20,%eax
80100bf2:	74 05                	je     80100bf9 <exec+0xcc>
      goto bad;
80100bf4:	e9 e1 02 00 00       	jmp    80100eda <exec+0x3ad>
    if(ph.type != ELF_PROG_LOAD)
80100bf9:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100bff:	83 f8 01             	cmp    $0x1,%eax
80100c02:	74 02                	je     80100c06 <exec+0xd9>
      continue;
80100c04:	eb 72                	jmp    80100c78 <exec+0x14b>
    if(ph.memsz < ph.filesz)
80100c06:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80100c0c:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100c12:	39 c2                	cmp    %eax,%edx
80100c14:	73 05                	jae    80100c1b <exec+0xee>
      goto bad;
80100c16:	e9 bf 02 00 00       	jmp    80100eda <exec+0x3ad>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100c1b:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100c21:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100c27:	01 d0                	add    %edx,%eax
80100c29:	83 ec 04             	sub    $0x4,%esp
80100c2c:	50                   	push   %eax
80100c2d:	ff 75 e0             	pushl  -0x20(%ebp)
80100c30:	ff 75 d4             	pushl  -0x2c(%ebp)
80100c33:	e8 09 73 00 00       	call   80107f41 <allocuvm>
80100c38:	83 c4 10             	add    $0x10,%esp
80100c3b:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100c3e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100c42:	75 05                	jne    80100c49 <exec+0x11c>
      goto bad;
80100c44:	e9 91 02 00 00       	jmp    80100eda <exec+0x3ad>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c49:	8b 8d fc fe ff ff    	mov    -0x104(%ebp),%ecx
80100c4f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
80100c55:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100c5b:	83 ec 0c             	sub    $0xc,%esp
80100c5e:	51                   	push   %ecx
80100c5f:	52                   	push   %edx
80100c60:	ff 75 d8             	pushl  -0x28(%ebp)
80100c63:	50                   	push   %eax
80100c64:	ff 75 d4             	pushl  -0x2c(%ebp)
80100c67:	e8 fe 71 00 00       	call   80107e6a <loaduvm>
80100c6c:	83 c4 20             	add    $0x20,%esp
80100c6f:	85 c0                	test   %eax,%eax
80100c71:	79 05                	jns    80100c78 <exec+0x14b>
      goto bad;
80100c73:	e9 62 02 00 00       	jmp    80100eda <exec+0x3ad>
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c78:	ff 45 ec             	incl   -0x14(%ebp)
80100c7b:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100c7e:	83 c0 20             	add    $0x20,%eax
80100c81:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100c84:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
80100c8a:	0f b7 c0             	movzwl %ax,%eax
80100c8d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80100c90:	0f 8f 41 ff ff ff    	jg     80100bd7 <exec+0xaa>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100c96:	83 ec 0c             	sub    $0xc,%esp
80100c99:	ff 75 d8             	pushl  -0x28(%ebp)
80100c9c:	e8 f4 0e 00 00       	call   80101b95 <iunlockput>
80100ca1:	83 c4 10             	add    $0x10,%esp
  end_op();
80100ca4:	e8 39 28 00 00       	call   801034e2 <end_op>
  ip = 0;
80100ca9:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100cb0:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cb3:	05 ff 0f 00 00       	add    $0xfff,%eax
80100cb8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100cbd:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100cc0:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cc3:	05 00 20 00 00       	add    $0x2000,%eax
80100cc8:	83 ec 04             	sub    $0x4,%esp
80100ccb:	50                   	push   %eax
80100ccc:	ff 75 e0             	pushl  -0x20(%ebp)
80100ccf:	ff 75 d4             	pushl  -0x2c(%ebp)
80100cd2:	e8 6a 72 00 00       	call   80107f41 <allocuvm>
80100cd7:	83 c4 10             	add    $0x10,%esp
80100cda:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100cdd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100ce1:	75 05                	jne    80100ce8 <exec+0x1bb>
    goto bad;
80100ce3:	e9 f2 01 00 00       	jmp    80100eda <exec+0x3ad>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100ce8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ceb:	2d 00 20 00 00       	sub    $0x2000,%eax
80100cf0:	83 ec 08             	sub    $0x8,%esp
80100cf3:	50                   	push   %eax
80100cf4:	ff 75 d4             	pushl  -0x2c(%ebp)
80100cf7:	e8 67 74 00 00       	call   80108163 <clearpteu>
80100cfc:	83 c4 10             	add    $0x10,%esp
  sp = sz;
80100cff:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d02:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d05:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100d0c:	e9 93 00 00 00       	jmp    80100da4 <exec+0x277>
    if(argc >= MAXARG)
80100d11:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80100d15:	76 05                	jbe    80100d1c <exec+0x1ef>
      goto bad;
80100d17:	e9 be 01 00 00       	jmp    80100eda <exec+0x3ad>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d1c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d1f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d26:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d29:	01 d0                	add    %edx,%eax
80100d2b:	8b 00                	mov    (%eax),%eax
80100d2d:	83 ec 0c             	sub    $0xc,%esp
80100d30:	50                   	push   %eax
80100d31:	e8 a2 46 00 00       	call   801053d8 <strlen>
80100d36:	83 c4 10             	add    $0x10,%esp
80100d39:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100d3c:	29 c2                	sub    %eax,%edx
80100d3e:	89 d0                	mov    %edx,%eax
80100d40:	48                   	dec    %eax
80100d41:	83 e0 fc             	and    $0xfffffffc,%eax
80100d44:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d47:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d4a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d51:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d54:	01 d0                	add    %edx,%eax
80100d56:	8b 00                	mov    (%eax),%eax
80100d58:	83 ec 0c             	sub    $0xc,%esp
80100d5b:	50                   	push   %eax
80100d5c:	e8 77 46 00 00       	call   801053d8 <strlen>
80100d61:	83 c4 10             	add    $0x10,%esp
80100d64:	40                   	inc    %eax
80100d65:	89 c2                	mov    %eax,%edx
80100d67:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d6a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
80100d71:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d74:	01 c8                	add    %ecx,%eax
80100d76:	8b 00                	mov    (%eax),%eax
80100d78:	52                   	push   %edx
80100d79:	50                   	push   %eax
80100d7a:	ff 75 dc             	pushl  -0x24(%ebp)
80100d7d:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d80:	e8 92 75 00 00       	call   80108317 <copyout>
80100d85:	83 c4 10             	add    $0x10,%esp
80100d88:	85 c0                	test   %eax,%eax
80100d8a:	79 05                	jns    80100d91 <exec+0x264>
      goto bad;
80100d8c:	e9 49 01 00 00       	jmp    80100eda <exec+0x3ad>
    ustack[3+argc] = sp;
80100d91:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d94:	8d 50 03             	lea    0x3(%eax),%edx
80100d97:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100d9a:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100da1:	ff 45 e4             	incl   -0x1c(%ebp)
80100da4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100da7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dae:	8b 45 0c             	mov    0xc(%ebp),%eax
80100db1:	01 d0                	add    %edx,%eax
80100db3:	8b 00                	mov    (%eax),%eax
80100db5:	85 c0                	test   %eax,%eax
80100db7:	0f 85 54 ff ff ff    	jne    80100d11 <exec+0x1e4>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100dbd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dc0:	83 c0 03             	add    $0x3,%eax
80100dc3:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80100dca:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100dce:	c7 85 40 ff ff ff ff 	movl   $0xffffffff,-0xc0(%ebp)
80100dd5:	ff ff ff 
  ustack[1] = argc;
80100dd8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100ddb:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100de1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100de4:	40                   	inc    %eax
80100de5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dec:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100def:	29 d0                	sub    %edx,%eax
80100df1:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)

  sp -= (3+argc+1) * 4;
80100df7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dfa:	83 c0 04             	add    $0x4,%eax
80100dfd:	c1 e0 02             	shl    $0x2,%eax
80100e00:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e03:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e06:	83 c0 04             	add    $0x4,%eax
80100e09:	c1 e0 02             	shl    $0x2,%eax
80100e0c:	50                   	push   %eax
80100e0d:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
80100e13:	50                   	push   %eax
80100e14:	ff 75 dc             	pushl  -0x24(%ebp)
80100e17:	ff 75 d4             	pushl  -0x2c(%ebp)
80100e1a:	e8 f8 74 00 00       	call   80108317 <copyout>
80100e1f:	83 c4 10             	add    $0x10,%esp
80100e22:	85 c0                	test   %eax,%eax
80100e24:	79 05                	jns    80100e2b <exec+0x2fe>
    goto bad;
80100e26:	e9 af 00 00 00       	jmp    80100eda <exec+0x3ad>

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e2b:	8b 45 08             	mov    0x8(%ebp),%eax
80100e2e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100e31:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e34:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100e37:	eb 13                	jmp    80100e4c <exec+0x31f>
    if(*s == '/')
80100e39:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e3c:	8a 00                	mov    (%eax),%al
80100e3e:	3c 2f                	cmp    $0x2f,%al
80100e40:	75 07                	jne    80100e49 <exec+0x31c>
      last = s+1;
80100e42:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e45:	40                   	inc    %eax
80100e46:	89 45 f0             	mov    %eax,-0x10(%ebp)
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e49:	ff 45 f4             	incl   -0xc(%ebp)
80100e4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e4f:	8a 00                	mov    (%eax),%al
80100e51:	84 c0                	test   %al,%al
80100e53:	75 e4                	jne    80100e39 <exec+0x30c>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100e55:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e5b:	83 c0 6c             	add    $0x6c,%eax
80100e5e:	83 ec 04             	sub    $0x4,%esp
80100e61:	6a 10                	push   $0x10
80100e63:	ff 75 f0             	pushl  -0x10(%ebp)
80100e66:	50                   	push   %eax
80100e67:	e8 25 45 00 00       	call   80105391 <safestrcpy>
80100e6c:	83 c4 10             	add    $0x10,%esp

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100e6f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e75:	8b 40 04             	mov    0x4(%eax),%eax
80100e78:	89 45 d0             	mov    %eax,-0x30(%ebp)
  proc->pgdir = pgdir;
80100e7b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e81:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100e84:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80100e87:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e8d:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100e90:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
80100e92:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e98:	8b 40 18             	mov    0x18(%eax),%eax
80100e9b:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80100ea1:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80100ea4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100eaa:	8b 40 18             	mov    0x18(%eax),%eax
80100ead:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100eb0:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(proc);
80100eb3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100eb9:	83 ec 0c             	sub    $0xc,%esp
80100ebc:	50                   	push   %eax
80100ebd:	e8 cf 6d 00 00       	call   80107c91 <switchuvm>
80100ec2:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80100ec5:	83 ec 0c             	sub    $0xc,%esp
80100ec8:	ff 75 d0             	pushl  -0x30(%ebp)
80100ecb:	e8 f5 71 00 00       	call   801080c5 <freevm>
80100ed0:	83 c4 10             	add    $0x10,%esp
  return 0;
80100ed3:	b8 00 00 00 00       	mov    $0x0,%eax
80100ed8:	eb 32                	jmp    80100f0c <exec+0x3df>

 bad:
  if(pgdir)
80100eda:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100ede:	74 0e                	je     80100eee <exec+0x3c1>
    freevm(pgdir);
80100ee0:	83 ec 0c             	sub    $0xc,%esp
80100ee3:	ff 75 d4             	pushl  -0x2c(%ebp)
80100ee6:	e8 da 71 00 00       	call   801080c5 <freevm>
80100eeb:	83 c4 10             	add    $0x10,%esp
  if(ip){
80100eee:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100ef2:	74 13                	je     80100f07 <exec+0x3da>
    iunlockput(ip);
80100ef4:	83 ec 0c             	sub    $0xc,%esp
80100ef7:	ff 75 d8             	pushl  -0x28(%ebp)
80100efa:	e8 96 0c 00 00       	call   80101b95 <iunlockput>
80100eff:	83 c4 10             	add    $0x10,%esp
    end_op();
80100f02:	e8 db 25 00 00       	call   801034e2 <end_op>
  }
  return -1;
80100f07:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f0c:	c9                   	leave  
80100f0d:	c3                   	ret    

80100f0e <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f0e:	55                   	push   %ebp
80100f0f:	89 e5                	mov    %esp,%ebp
80100f11:	83 ec 08             	sub    $0x8,%esp
  initlock(&ftable.lock, "ftable");
80100f14:	83 ec 08             	sub    $0x8,%esp
80100f17:	68 1e 84 10 80       	push   $0x8010841e
80100f1c:	68 20 08 11 80       	push   $0x80110820
80100f21:	e8 01 40 00 00       	call   80104f27 <initlock>
80100f26:	83 c4 10             	add    $0x10,%esp
}
80100f29:	c9                   	leave  
80100f2a:	c3                   	ret    

80100f2b <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f2b:	55                   	push   %ebp
80100f2c:	89 e5                	mov    %esp,%ebp
80100f2e:	83 ec 18             	sub    $0x18,%esp
  struct file *f;

  acquire(&ftable.lock);
80100f31:	83 ec 0c             	sub    $0xc,%esp
80100f34:	68 20 08 11 80       	push   $0x80110820
80100f39:	e8 0a 40 00 00       	call   80104f48 <acquire>
80100f3e:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f41:	c7 45 f4 54 08 11 80 	movl   $0x80110854,-0xc(%ebp)
80100f48:	eb 2d                	jmp    80100f77 <filealloc+0x4c>
    if(f->ref == 0){
80100f4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f4d:	8b 40 04             	mov    0x4(%eax),%eax
80100f50:	85 c0                	test   %eax,%eax
80100f52:	75 1f                	jne    80100f73 <filealloc+0x48>
      f->ref = 1;
80100f54:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f57:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
80100f5e:	83 ec 0c             	sub    $0xc,%esp
80100f61:	68 20 08 11 80       	push   $0x80110820
80100f66:	e8 43 40 00 00       	call   80104fae <release>
80100f6b:	83 c4 10             	add    $0x10,%esp
      return f;
80100f6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f71:	eb 22                	jmp    80100f95 <filealloc+0x6a>
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f73:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80100f77:	81 7d f4 b4 11 11 80 	cmpl   $0x801111b4,-0xc(%ebp)
80100f7e:	72 ca                	jb     80100f4a <filealloc+0x1f>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100f80:	83 ec 0c             	sub    $0xc,%esp
80100f83:	68 20 08 11 80       	push   $0x80110820
80100f88:	e8 21 40 00 00       	call   80104fae <release>
80100f8d:	83 c4 10             	add    $0x10,%esp
  return 0;
80100f90:	b8 00 00 00 00       	mov    $0x0,%eax
}
80100f95:	c9                   	leave  
80100f96:	c3                   	ret    

80100f97 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100f97:	55                   	push   %ebp
80100f98:	89 e5                	mov    %esp,%ebp
80100f9a:	83 ec 08             	sub    $0x8,%esp
  acquire(&ftable.lock);
80100f9d:	83 ec 0c             	sub    $0xc,%esp
80100fa0:	68 20 08 11 80       	push   $0x80110820
80100fa5:	e8 9e 3f 00 00       	call   80104f48 <acquire>
80100faa:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80100fad:	8b 45 08             	mov    0x8(%ebp),%eax
80100fb0:	8b 40 04             	mov    0x4(%eax),%eax
80100fb3:	85 c0                	test   %eax,%eax
80100fb5:	7f 0d                	jg     80100fc4 <filedup+0x2d>
    panic("filedup");
80100fb7:	83 ec 0c             	sub    $0xc,%esp
80100fba:	68 25 84 10 80       	push   $0x80108425
80100fbf:	e8 8a f5 ff ff       	call   8010054e <panic>
  f->ref++;
80100fc4:	8b 45 08             	mov    0x8(%ebp),%eax
80100fc7:	8b 40 04             	mov    0x4(%eax),%eax
80100fca:	8d 50 01             	lea    0x1(%eax),%edx
80100fcd:	8b 45 08             	mov    0x8(%ebp),%eax
80100fd0:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
80100fd3:	83 ec 0c             	sub    $0xc,%esp
80100fd6:	68 20 08 11 80       	push   $0x80110820
80100fdb:	e8 ce 3f 00 00       	call   80104fae <release>
80100fe0:	83 c4 10             	add    $0x10,%esp
  return f;
80100fe3:	8b 45 08             	mov    0x8(%ebp),%eax
}
80100fe6:	c9                   	leave  
80100fe7:	c3                   	ret    

80100fe8 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100fe8:	55                   	push   %ebp
80100fe9:	89 e5                	mov    %esp,%ebp
80100feb:	57                   	push   %edi
80100fec:	56                   	push   %esi
80100fed:	53                   	push   %ebx
80100fee:	83 ec 2c             	sub    $0x2c,%esp
  struct file ff;

  acquire(&ftable.lock);
80100ff1:	83 ec 0c             	sub    $0xc,%esp
80100ff4:	68 20 08 11 80       	push   $0x80110820
80100ff9:	e8 4a 3f 00 00       	call   80104f48 <acquire>
80100ffe:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80101001:	8b 45 08             	mov    0x8(%ebp),%eax
80101004:	8b 40 04             	mov    0x4(%eax),%eax
80101007:	85 c0                	test   %eax,%eax
80101009:	7f 0d                	jg     80101018 <fileclose+0x30>
    panic("fileclose");
8010100b:	83 ec 0c             	sub    $0xc,%esp
8010100e:	68 2d 84 10 80       	push   $0x8010842d
80101013:	e8 36 f5 ff ff       	call   8010054e <panic>
  if(--f->ref > 0){
80101018:	8b 45 08             	mov    0x8(%ebp),%eax
8010101b:	8b 40 04             	mov    0x4(%eax),%eax
8010101e:	8d 50 ff             	lea    -0x1(%eax),%edx
80101021:	8b 45 08             	mov    0x8(%ebp),%eax
80101024:	89 50 04             	mov    %edx,0x4(%eax)
80101027:	8b 45 08             	mov    0x8(%ebp),%eax
8010102a:	8b 40 04             	mov    0x4(%eax),%eax
8010102d:	85 c0                	test   %eax,%eax
8010102f:	7e 12                	jle    80101043 <fileclose+0x5b>
    release(&ftable.lock);
80101031:	83 ec 0c             	sub    $0xc,%esp
80101034:	68 20 08 11 80       	push   $0x80110820
80101039:	e8 70 3f 00 00       	call   80104fae <release>
8010103e:	83 c4 10             	add    $0x10,%esp
80101041:	eb 79                	jmp    801010bc <fileclose+0xd4>
    return;
  }
  ff = *f;
80101043:	8b 45 08             	mov    0x8(%ebp),%eax
80101046:	8d 55 d0             	lea    -0x30(%ebp),%edx
80101049:	89 c3                	mov    %eax,%ebx
8010104b:	b8 06 00 00 00       	mov    $0x6,%eax
80101050:	89 d7                	mov    %edx,%edi
80101052:	89 de                	mov    %ebx,%esi
80101054:	89 c1                	mov    %eax,%ecx
80101056:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  f->ref = 0;
80101058:	8b 45 08             	mov    0x8(%ebp),%eax
8010105b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
80101062:	8b 45 08             	mov    0x8(%ebp),%eax
80101065:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
8010106b:	83 ec 0c             	sub    $0xc,%esp
8010106e:	68 20 08 11 80       	push   $0x80110820
80101073:	e8 36 3f 00 00       	call   80104fae <release>
80101078:	83 c4 10             	add    $0x10,%esp
  
  if(ff.type == FD_PIPE)
8010107b:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010107e:	83 f8 01             	cmp    $0x1,%eax
80101081:	75 18                	jne    8010109b <fileclose+0xb3>
    pipeclose(ff.pipe, ff.writable);
80101083:	8a 45 d9             	mov    -0x27(%ebp),%al
80101086:	0f be d0             	movsbl %al,%edx
80101089:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010108c:	83 ec 08             	sub    $0x8,%esp
8010108f:	52                   	push   %edx
80101090:	50                   	push   %eax
80101091:	e8 45 30 00 00       	call   801040db <pipeclose>
80101096:	83 c4 10             	add    $0x10,%esp
80101099:	eb 21                	jmp    801010bc <fileclose+0xd4>
  else if(ff.type == FD_INODE){
8010109b:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010109e:	83 f8 02             	cmp    $0x2,%eax
801010a1:	75 19                	jne    801010bc <fileclose+0xd4>
    begin_op();
801010a3:	e8 ae 23 00 00       	call   80103456 <begin_op>
    iput(ff.ip);
801010a8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010ab:	83 ec 0c             	sub    $0xc,%esp
801010ae:	50                   	push   %eax
801010af:	e8 f2 09 00 00       	call   80101aa6 <iput>
801010b4:	83 c4 10             	add    $0x10,%esp
    end_op();
801010b7:	e8 26 24 00 00       	call   801034e2 <end_op>
  }
}
801010bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010bf:	5b                   	pop    %ebx
801010c0:	5e                   	pop    %esi
801010c1:	5f                   	pop    %edi
801010c2:	5d                   	pop    %ebp
801010c3:	c3                   	ret    

801010c4 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
801010c4:	55                   	push   %ebp
801010c5:	89 e5                	mov    %esp,%ebp
801010c7:	83 ec 08             	sub    $0x8,%esp
  if(f->type == FD_INODE){
801010ca:	8b 45 08             	mov    0x8(%ebp),%eax
801010cd:	8b 00                	mov    (%eax),%eax
801010cf:	83 f8 02             	cmp    $0x2,%eax
801010d2:	75 40                	jne    80101114 <filestat+0x50>
    ilock(f->ip);
801010d4:	8b 45 08             	mov    0x8(%ebp),%eax
801010d7:	8b 40 10             	mov    0x10(%eax),%eax
801010da:	83 ec 0c             	sub    $0xc,%esp
801010dd:	50                   	push   %eax
801010de:	e8 f8 07 00 00       	call   801018db <ilock>
801010e3:	83 c4 10             	add    $0x10,%esp
    stati(f->ip, st);
801010e6:	8b 45 08             	mov    0x8(%ebp),%eax
801010e9:	8b 40 10             	mov    0x10(%eax),%eax
801010ec:	83 ec 08             	sub    $0x8,%esp
801010ef:	ff 75 0c             	pushl  0xc(%ebp)
801010f2:	50                   	push   %eax
801010f3:	e8 01 0d 00 00       	call   80101df9 <stati>
801010f8:	83 c4 10             	add    $0x10,%esp
    iunlock(f->ip);
801010fb:	8b 45 08             	mov    0x8(%ebp),%eax
801010fe:	8b 40 10             	mov    0x10(%eax),%eax
80101101:	83 ec 0c             	sub    $0xc,%esp
80101104:	50                   	push   %eax
80101105:	e8 2b 09 00 00       	call   80101a35 <iunlock>
8010110a:	83 c4 10             	add    $0x10,%esp
    return 0;
8010110d:	b8 00 00 00 00       	mov    $0x0,%eax
80101112:	eb 05                	jmp    80101119 <filestat+0x55>
  }
  return -1;
80101114:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101119:	c9                   	leave  
8010111a:	c3                   	ret    

8010111b <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
8010111b:	55                   	push   %ebp
8010111c:	89 e5                	mov    %esp,%ebp
8010111e:	83 ec 18             	sub    $0x18,%esp
  int r;

  if(f->readable == 0)
80101121:	8b 45 08             	mov    0x8(%ebp),%eax
80101124:	8a 40 08             	mov    0x8(%eax),%al
80101127:	84 c0                	test   %al,%al
80101129:	75 0a                	jne    80101135 <fileread+0x1a>
    return -1;
8010112b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101130:	e9 9b 00 00 00       	jmp    801011d0 <fileread+0xb5>
  if(f->type == FD_PIPE)
80101135:	8b 45 08             	mov    0x8(%ebp),%eax
80101138:	8b 00                	mov    (%eax),%eax
8010113a:	83 f8 01             	cmp    $0x1,%eax
8010113d:	75 1a                	jne    80101159 <fileread+0x3e>
    return piperead(f->pipe, addr, n);
8010113f:	8b 45 08             	mov    0x8(%ebp),%eax
80101142:	8b 40 0c             	mov    0xc(%eax),%eax
80101145:	83 ec 04             	sub    $0x4,%esp
80101148:	ff 75 10             	pushl  0x10(%ebp)
8010114b:	ff 75 0c             	pushl  0xc(%ebp)
8010114e:	50                   	push   %eax
8010114f:	e8 32 31 00 00       	call   80104286 <piperead>
80101154:	83 c4 10             	add    $0x10,%esp
80101157:	eb 77                	jmp    801011d0 <fileread+0xb5>
  if(f->type == FD_INODE){
80101159:	8b 45 08             	mov    0x8(%ebp),%eax
8010115c:	8b 00                	mov    (%eax),%eax
8010115e:	83 f8 02             	cmp    $0x2,%eax
80101161:	75 60                	jne    801011c3 <fileread+0xa8>
    ilock(f->ip);
80101163:	8b 45 08             	mov    0x8(%ebp),%eax
80101166:	8b 40 10             	mov    0x10(%eax),%eax
80101169:	83 ec 0c             	sub    $0xc,%esp
8010116c:	50                   	push   %eax
8010116d:	e8 69 07 00 00       	call   801018db <ilock>
80101172:	83 c4 10             	add    $0x10,%esp
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101175:	8b 4d 10             	mov    0x10(%ebp),%ecx
80101178:	8b 45 08             	mov    0x8(%ebp),%eax
8010117b:	8b 50 14             	mov    0x14(%eax),%edx
8010117e:	8b 45 08             	mov    0x8(%ebp),%eax
80101181:	8b 40 10             	mov    0x10(%eax),%eax
80101184:	51                   	push   %ecx
80101185:	52                   	push   %edx
80101186:	ff 75 0c             	pushl  0xc(%ebp)
80101189:	50                   	push   %eax
8010118a:	e8 ae 0c 00 00       	call   80101e3d <readi>
8010118f:	83 c4 10             	add    $0x10,%esp
80101192:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101195:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101199:	7e 11                	jle    801011ac <fileread+0x91>
      f->off += r;
8010119b:	8b 45 08             	mov    0x8(%ebp),%eax
8010119e:	8b 50 14             	mov    0x14(%eax),%edx
801011a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011a4:	01 c2                	add    %eax,%edx
801011a6:	8b 45 08             	mov    0x8(%ebp),%eax
801011a9:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
801011ac:	8b 45 08             	mov    0x8(%ebp),%eax
801011af:	8b 40 10             	mov    0x10(%eax),%eax
801011b2:	83 ec 0c             	sub    $0xc,%esp
801011b5:	50                   	push   %eax
801011b6:	e8 7a 08 00 00       	call   80101a35 <iunlock>
801011bb:	83 c4 10             	add    $0x10,%esp
    return r;
801011be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011c1:	eb 0d                	jmp    801011d0 <fileread+0xb5>
  }
  panic("fileread");
801011c3:	83 ec 0c             	sub    $0xc,%esp
801011c6:	68 37 84 10 80       	push   $0x80108437
801011cb:	e8 7e f3 ff ff       	call   8010054e <panic>
}
801011d0:	c9                   	leave  
801011d1:	c3                   	ret    

801011d2 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801011d2:	55                   	push   %ebp
801011d3:	89 e5                	mov    %esp,%ebp
801011d5:	53                   	push   %ebx
801011d6:	83 ec 14             	sub    $0x14,%esp
  int r;

  if(f->writable == 0)
801011d9:	8b 45 08             	mov    0x8(%ebp),%eax
801011dc:	8a 40 09             	mov    0x9(%eax),%al
801011df:	84 c0                	test   %al,%al
801011e1:	75 0a                	jne    801011ed <filewrite+0x1b>
    return -1;
801011e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801011e8:	e9 1a 01 00 00       	jmp    80101307 <filewrite+0x135>
  if(f->type == FD_PIPE)
801011ed:	8b 45 08             	mov    0x8(%ebp),%eax
801011f0:	8b 00                	mov    (%eax),%eax
801011f2:	83 f8 01             	cmp    $0x1,%eax
801011f5:	75 1d                	jne    80101214 <filewrite+0x42>
    return pipewrite(f->pipe, addr, n);
801011f7:	8b 45 08             	mov    0x8(%ebp),%eax
801011fa:	8b 40 0c             	mov    0xc(%eax),%eax
801011fd:	83 ec 04             	sub    $0x4,%esp
80101200:	ff 75 10             	pushl  0x10(%ebp)
80101203:	ff 75 0c             	pushl  0xc(%ebp)
80101206:	50                   	push   %eax
80101207:	e8 78 2f 00 00       	call   80104184 <pipewrite>
8010120c:	83 c4 10             	add    $0x10,%esp
8010120f:	e9 f3 00 00 00       	jmp    80101307 <filewrite+0x135>
  if(f->type == FD_INODE){
80101214:	8b 45 08             	mov    0x8(%ebp),%eax
80101217:	8b 00                	mov    (%eax),%eax
80101219:	83 f8 02             	cmp    $0x2,%eax
8010121c:	0f 85 d8 00 00 00    	jne    801012fa <filewrite+0x128>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
80101222:	c7 45 ec 00 1a 00 00 	movl   $0x1a00,-0x14(%ebp)
    int i = 0;
80101229:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
80101230:	e9 a5 00 00 00       	jmp    801012da <filewrite+0x108>
      int n1 = n - i;
80101235:	8b 45 10             	mov    0x10(%ebp),%eax
80101238:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010123b:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
8010123e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101241:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80101244:	7e 06                	jle    8010124c <filewrite+0x7a>
        n1 = max;
80101246:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101249:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_op();
8010124c:	e8 05 22 00 00       	call   80103456 <begin_op>
      ilock(f->ip);
80101251:	8b 45 08             	mov    0x8(%ebp),%eax
80101254:	8b 40 10             	mov    0x10(%eax),%eax
80101257:	83 ec 0c             	sub    $0xc,%esp
8010125a:	50                   	push   %eax
8010125b:	e8 7b 06 00 00       	call   801018db <ilock>
80101260:	83 c4 10             	add    $0x10,%esp
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101263:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80101266:	8b 45 08             	mov    0x8(%ebp),%eax
80101269:	8b 50 14             	mov    0x14(%eax),%edx
8010126c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010126f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101272:	01 c3                	add    %eax,%ebx
80101274:	8b 45 08             	mov    0x8(%ebp),%eax
80101277:	8b 40 10             	mov    0x10(%eax),%eax
8010127a:	51                   	push   %ecx
8010127b:	52                   	push   %edx
8010127c:	53                   	push   %ebx
8010127d:	50                   	push   %eax
8010127e:	e8 1a 0d 00 00       	call   80101f9d <writei>
80101283:	83 c4 10             	add    $0x10,%esp
80101286:	89 45 e8             	mov    %eax,-0x18(%ebp)
80101289:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010128d:	7e 11                	jle    801012a0 <filewrite+0xce>
        f->off += r;
8010128f:	8b 45 08             	mov    0x8(%ebp),%eax
80101292:	8b 50 14             	mov    0x14(%eax),%edx
80101295:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101298:	01 c2                	add    %eax,%edx
8010129a:	8b 45 08             	mov    0x8(%ebp),%eax
8010129d:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
801012a0:	8b 45 08             	mov    0x8(%ebp),%eax
801012a3:	8b 40 10             	mov    0x10(%eax),%eax
801012a6:	83 ec 0c             	sub    $0xc,%esp
801012a9:	50                   	push   %eax
801012aa:	e8 86 07 00 00       	call   80101a35 <iunlock>
801012af:	83 c4 10             	add    $0x10,%esp
      end_op();
801012b2:	e8 2b 22 00 00       	call   801034e2 <end_op>

      if(r < 0)
801012b7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801012bb:	79 02                	jns    801012bf <filewrite+0xed>
        break;
801012bd:	eb 27                	jmp    801012e6 <filewrite+0x114>
      if(r != n1)
801012bf:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012c2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801012c5:	74 0d                	je     801012d4 <filewrite+0x102>
        panic("short filewrite");
801012c7:	83 ec 0c             	sub    $0xc,%esp
801012ca:	68 40 84 10 80       	push   $0x80108440
801012cf:	e8 7a f2 ff ff       	call   8010054e <panic>
      i += r;
801012d4:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012d7:	01 45 f4             	add    %eax,-0xc(%ebp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801012da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801012dd:	3b 45 10             	cmp    0x10(%ebp),%eax
801012e0:	0f 8c 4f ff ff ff    	jl     80101235 <filewrite+0x63>
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801012e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801012e9:	3b 45 10             	cmp    0x10(%ebp),%eax
801012ec:	75 05                	jne    801012f3 <filewrite+0x121>
801012ee:	8b 45 10             	mov    0x10(%ebp),%eax
801012f1:	eb 14                	jmp    80101307 <filewrite+0x135>
801012f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801012f8:	eb 0d                	jmp    80101307 <filewrite+0x135>
  }
  panic("filewrite");
801012fa:	83 ec 0c             	sub    $0xc,%esp
801012fd:	68 50 84 10 80       	push   $0x80108450
80101302:	e8 47 f2 ff ff       	call   8010054e <panic>
}
80101307:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010130a:	c9                   	leave  
8010130b:	c3                   	ret    

8010130c <readsb>:
struct superblock sb;   // there should be one per dev, but we run with one dev

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
8010130c:	55                   	push   %ebp
8010130d:	89 e5                	mov    %esp,%ebp
8010130f:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
80101312:	8b 45 08             	mov    0x8(%ebp),%eax
80101315:	83 ec 08             	sub    $0x8,%esp
80101318:	6a 01                	push   $0x1
8010131a:	50                   	push   %eax
8010131b:	e8 94 ee ff ff       	call   801001b4 <bread>
80101320:	83 c4 10             	add    $0x10,%esp
80101323:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
80101326:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101329:	83 c0 18             	add    $0x18,%eax
8010132c:	83 ec 04             	sub    $0x4,%esp
8010132f:	6a 1c                	push   $0x1c
80101331:	50                   	push   %eax
80101332:	ff 75 0c             	pushl  0xc(%ebp)
80101335:	e8 1f 3f 00 00       	call   80105259 <memmove>
8010133a:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
8010133d:	83 ec 0c             	sub    $0xc,%esp
80101340:	ff 75 f4             	pushl  -0xc(%ebp)
80101343:	e8 e3 ee ff ff       	call   8010022b <brelse>
80101348:	83 c4 10             	add    $0x10,%esp
}
8010134b:	c9                   	leave  
8010134c:	c3                   	ret    

8010134d <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
8010134d:	55                   	push   %ebp
8010134e:	89 e5                	mov    %esp,%ebp
80101350:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, bno);
80101353:	8b 55 0c             	mov    0xc(%ebp),%edx
80101356:	8b 45 08             	mov    0x8(%ebp),%eax
80101359:	83 ec 08             	sub    $0x8,%esp
8010135c:	52                   	push   %edx
8010135d:	50                   	push   %eax
8010135e:	e8 51 ee ff ff       	call   801001b4 <bread>
80101363:	83 c4 10             	add    $0x10,%esp
80101366:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
80101369:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010136c:	83 c0 18             	add    $0x18,%eax
8010136f:	83 ec 04             	sub    $0x4,%esp
80101372:	68 00 02 00 00       	push   $0x200
80101377:	6a 00                	push   $0x0
80101379:	50                   	push   %eax
8010137a:	e8 21 3e 00 00       	call   801051a0 <memset>
8010137f:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
80101382:	83 ec 0c             	sub    $0xc,%esp
80101385:	ff 75 f4             	pushl  -0xc(%ebp)
80101388:	e8 f9 22 00 00       	call   80103686 <log_write>
8010138d:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101390:	83 ec 0c             	sub    $0xc,%esp
80101393:	ff 75 f4             	pushl  -0xc(%ebp)
80101396:	e8 90 ee ff ff       	call   8010022b <brelse>
8010139b:	83 c4 10             	add    $0x10,%esp
}
8010139e:	c9                   	leave  
8010139f:	c3                   	ret    

801013a0 <balloc>:
// Blocks. 

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801013a0:	55                   	push   %ebp
801013a1:	89 e5                	mov    %esp,%ebp
801013a3:	83 ec 18             	sub    $0x18,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
801013a6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801013ad:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801013b4:	e9 0d 01 00 00       	jmp    801014c6 <balloc+0x126>
    bp = bread(dev, BBLOCK(b, sb));
801013b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013bc:	85 c0                	test   %eax,%eax
801013be:	79 05                	jns    801013c5 <balloc+0x25>
801013c0:	05 ff 0f 00 00       	add    $0xfff,%eax
801013c5:	c1 f8 0c             	sar    $0xc,%eax
801013c8:	89 c2                	mov    %eax,%edx
801013ca:	a1 38 12 11 80       	mov    0x80111238,%eax
801013cf:	01 d0                	add    %edx,%eax
801013d1:	83 ec 08             	sub    $0x8,%esp
801013d4:	50                   	push   %eax
801013d5:	ff 75 08             	pushl  0x8(%ebp)
801013d8:	e8 d7 ed ff ff       	call   801001b4 <bread>
801013dd:	83 c4 10             	add    $0x10,%esp
801013e0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801013e3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801013ea:	e9 a2 00 00 00       	jmp    80101491 <balloc+0xf1>
      m = 1 << (bi % 8);
801013ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
801013f2:	25 07 00 00 80       	and    $0x80000007,%eax
801013f7:	85 c0                	test   %eax,%eax
801013f9:	79 05                	jns    80101400 <balloc+0x60>
801013fb:	48                   	dec    %eax
801013fc:	83 c8 f8             	or     $0xfffffff8,%eax
801013ff:	40                   	inc    %eax
80101400:	ba 01 00 00 00       	mov    $0x1,%edx
80101405:	88 c1                	mov    %al,%cl
80101407:	d3 e2                	shl    %cl,%edx
80101409:	89 d0                	mov    %edx,%eax
8010140b:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010140e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101411:	85 c0                	test   %eax,%eax
80101413:	79 03                	jns    80101418 <balloc+0x78>
80101415:	83 c0 07             	add    $0x7,%eax
80101418:	c1 f8 03             	sar    $0x3,%eax
8010141b:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010141e:	8a 44 02 18          	mov    0x18(%edx,%eax,1),%al
80101422:	0f b6 c0             	movzbl %al,%eax
80101425:	23 45 e8             	and    -0x18(%ebp),%eax
80101428:	85 c0                	test   %eax,%eax
8010142a:	75 62                	jne    8010148e <balloc+0xee>
        bp->data[bi/8] |= m;  // Mark block in use.
8010142c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010142f:	85 c0                	test   %eax,%eax
80101431:	79 03                	jns    80101436 <balloc+0x96>
80101433:	83 c0 07             	add    $0x7,%eax
80101436:	c1 f8 03             	sar    $0x3,%eax
80101439:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010143c:	8a 54 02 18          	mov    0x18(%edx,%eax,1),%dl
80101440:	88 d1                	mov    %dl,%cl
80101442:	8b 55 e8             	mov    -0x18(%ebp),%edx
80101445:	09 ca                	or     %ecx,%edx
80101447:	88 d1                	mov    %dl,%cl
80101449:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010144c:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
        log_write(bp);
80101450:	83 ec 0c             	sub    $0xc,%esp
80101453:	ff 75 ec             	pushl  -0x14(%ebp)
80101456:	e8 2b 22 00 00       	call   80103686 <log_write>
8010145b:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
8010145e:	83 ec 0c             	sub    $0xc,%esp
80101461:	ff 75 ec             	pushl  -0x14(%ebp)
80101464:	e8 c2 ed ff ff       	call   8010022b <brelse>
80101469:	83 c4 10             	add    $0x10,%esp
        bzero(dev, b + bi);
8010146c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010146f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101472:	01 c2                	add    %eax,%edx
80101474:	8b 45 08             	mov    0x8(%ebp),%eax
80101477:	83 ec 08             	sub    $0x8,%esp
8010147a:	52                   	push   %edx
8010147b:	50                   	push   %eax
8010147c:	e8 cc fe ff ff       	call   8010134d <bzero>
80101481:	83 c4 10             	add    $0x10,%esp
        return b + bi;
80101484:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101487:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010148a:	01 d0                	add    %edx,%eax
8010148c:	eb 55                	jmp    801014e3 <balloc+0x143>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010148e:	ff 45 f0             	incl   -0x10(%ebp)
80101491:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
80101498:	7f 17                	jg     801014b1 <balloc+0x111>
8010149a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010149d:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014a0:	01 d0                	add    %edx,%eax
801014a2:	89 c2                	mov    %eax,%edx
801014a4:	a1 20 12 11 80       	mov    0x80111220,%eax
801014a9:	39 c2                	cmp    %eax,%edx
801014ab:	0f 82 3e ff ff ff    	jb     801013ef <balloc+0x4f>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801014b1:	83 ec 0c             	sub    $0xc,%esp
801014b4:	ff 75 ec             	pushl  -0x14(%ebp)
801014b7:	e8 6f ed ff ff       	call   8010022b <brelse>
801014bc:	83 c4 10             	add    $0x10,%esp
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801014bf:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801014c6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014c9:	a1 20 12 11 80       	mov    0x80111220,%eax
801014ce:	39 c2                	cmp    %eax,%edx
801014d0:	0f 82 e3 fe ff ff    	jb     801013b9 <balloc+0x19>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
801014d6:	83 ec 0c             	sub    $0xc,%esp
801014d9:	68 5c 84 10 80       	push   $0x8010845c
801014de:	e8 6b f0 ff ff       	call   8010054e <panic>
}
801014e3:	c9                   	leave  
801014e4:	c3                   	ret    

801014e5 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
801014e5:	55                   	push   %ebp
801014e6:	89 e5                	mov    %esp,%ebp
801014e8:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801014eb:	83 ec 08             	sub    $0x8,%esp
801014ee:	68 20 12 11 80       	push   $0x80111220
801014f3:	ff 75 08             	pushl  0x8(%ebp)
801014f6:	e8 11 fe ff ff       	call   8010130c <readsb>
801014fb:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
801014fe:	8b 45 0c             	mov    0xc(%ebp),%eax
80101501:	c1 e8 0c             	shr    $0xc,%eax
80101504:	89 c2                	mov    %eax,%edx
80101506:	a1 38 12 11 80       	mov    0x80111238,%eax
8010150b:	01 c2                	add    %eax,%edx
8010150d:	8b 45 08             	mov    0x8(%ebp),%eax
80101510:	83 ec 08             	sub    $0x8,%esp
80101513:	52                   	push   %edx
80101514:	50                   	push   %eax
80101515:	e8 9a ec ff ff       	call   801001b4 <bread>
8010151a:	83 c4 10             	add    $0x10,%esp
8010151d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
80101520:	8b 45 0c             	mov    0xc(%ebp),%eax
80101523:	25 ff 0f 00 00       	and    $0xfff,%eax
80101528:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
8010152b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010152e:	25 07 00 00 80       	and    $0x80000007,%eax
80101533:	85 c0                	test   %eax,%eax
80101535:	79 05                	jns    8010153c <bfree+0x57>
80101537:	48                   	dec    %eax
80101538:	83 c8 f8             	or     $0xfffffff8,%eax
8010153b:	40                   	inc    %eax
8010153c:	ba 01 00 00 00       	mov    $0x1,%edx
80101541:	88 c1                	mov    %al,%cl
80101543:	d3 e2                	shl    %cl,%edx
80101545:	89 d0                	mov    %edx,%eax
80101547:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
8010154a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010154d:	85 c0                	test   %eax,%eax
8010154f:	79 03                	jns    80101554 <bfree+0x6f>
80101551:	83 c0 07             	add    $0x7,%eax
80101554:	c1 f8 03             	sar    $0x3,%eax
80101557:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010155a:	8a 44 02 18          	mov    0x18(%edx,%eax,1),%al
8010155e:	0f b6 c0             	movzbl %al,%eax
80101561:	23 45 ec             	and    -0x14(%ebp),%eax
80101564:	85 c0                	test   %eax,%eax
80101566:	75 0d                	jne    80101575 <bfree+0x90>
    panic("freeing free block");
80101568:	83 ec 0c             	sub    $0xc,%esp
8010156b:	68 72 84 10 80       	push   $0x80108472
80101570:	e8 d9 ef ff ff       	call   8010054e <panic>
  bp->data[bi/8] &= ~m;
80101575:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101578:	85 c0                	test   %eax,%eax
8010157a:	79 03                	jns    8010157f <bfree+0x9a>
8010157c:	83 c0 07             	add    $0x7,%eax
8010157f:	c1 f8 03             	sar    $0x3,%eax
80101582:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101585:	8a 54 02 18          	mov    0x18(%edx,%eax,1),%dl
80101589:	8b 4d ec             	mov    -0x14(%ebp),%ecx
8010158c:	f7 d1                	not    %ecx
8010158e:	21 ca                	and    %ecx,%edx
80101590:	88 d1                	mov    %dl,%cl
80101592:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101595:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
  log_write(bp);
80101599:	83 ec 0c             	sub    $0xc,%esp
8010159c:	ff 75 f4             	pushl  -0xc(%ebp)
8010159f:	e8 e2 20 00 00       	call   80103686 <log_write>
801015a4:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801015a7:	83 ec 0c             	sub    $0xc,%esp
801015aa:	ff 75 f4             	pushl  -0xc(%ebp)
801015ad:	e8 79 ec ff ff       	call   8010022b <brelse>
801015b2:	83 c4 10             	add    $0x10,%esp
}
801015b5:	c9                   	leave  
801015b6:	c3                   	ret    

801015b7 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
801015b7:	55                   	push   %ebp
801015b8:	89 e5                	mov    %esp,%ebp
801015ba:	57                   	push   %edi
801015bb:	56                   	push   %esi
801015bc:	53                   	push   %ebx
801015bd:	83 ec 1c             	sub    $0x1c,%esp
  initlock(&icache.lock, "icache");
801015c0:	83 ec 08             	sub    $0x8,%esp
801015c3:	68 85 84 10 80       	push   $0x80108485
801015c8:	68 40 12 11 80       	push   $0x80111240
801015cd:	e8 55 39 00 00       	call   80104f27 <initlock>
801015d2:	83 c4 10             	add    $0x10,%esp
  readsb(dev, &sb);
801015d5:	83 ec 08             	sub    $0x8,%esp
801015d8:	68 20 12 11 80       	push   $0x80111220
801015dd:	ff 75 08             	pushl  0x8(%ebp)
801015e0:	e8 27 fd ff ff       	call   8010130c <readsb>
801015e5:	83 c4 10             	add    $0x10,%esp
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d inodestart %d bmap start %d\n", sb.size,
801015e8:	a1 38 12 11 80       	mov    0x80111238,%eax
801015ed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801015f0:	8b 3d 34 12 11 80    	mov    0x80111234,%edi
801015f6:	8b 35 30 12 11 80    	mov    0x80111230,%esi
801015fc:	8b 1d 2c 12 11 80    	mov    0x8011122c,%ebx
80101602:	8b 0d 28 12 11 80    	mov    0x80111228,%ecx
80101608:	8b 15 24 12 11 80    	mov    0x80111224,%edx
8010160e:	a1 20 12 11 80       	mov    0x80111220,%eax
80101613:	ff 75 e4             	pushl  -0x1c(%ebp)
80101616:	57                   	push   %edi
80101617:	56                   	push   %esi
80101618:	53                   	push   %ebx
80101619:	51                   	push   %ecx
8010161a:	52                   	push   %edx
8010161b:	50                   	push   %eax
8010161c:	68 8c 84 10 80       	push   $0x8010848c
80101621:	e8 92 ed ff ff       	call   801003b8 <cprintf>
80101626:	83 c4 20             	add    $0x20,%esp
          sb.nblocks, sb.ninodes, sb.nlog, sb.logstart, sb.inodestart, sb.bmapstart);
}
80101629:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010162c:	5b                   	pop    %ebx
8010162d:	5e                   	pop    %esi
8010162e:	5f                   	pop    %edi
8010162f:	5d                   	pop    %ebp
80101630:	c3                   	ret    

80101631 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101631:	55                   	push   %ebp
80101632:	89 e5                	mov    %esp,%ebp
80101634:	83 ec 28             	sub    $0x28,%esp
80101637:	8b 45 0c             	mov    0xc(%ebp),%eax
8010163a:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010163e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
80101645:	e9 9b 00 00 00       	jmp    801016e5 <ialloc+0xb4>
    bp = bread(dev, IBLOCK(inum, sb));
8010164a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010164d:	c1 e8 03             	shr    $0x3,%eax
80101650:	89 c2                	mov    %eax,%edx
80101652:	a1 34 12 11 80       	mov    0x80111234,%eax
80101657:	01 d0                	add    %edx,%eax
80101659:	83 ec 08             	sub    $0x8,%esp
8010165c:	50                   	push   %eax
8010165d:	ff 75 08             	pushl  0x8(%ebp)
80101660:	e8 4f eb ff ff       	call   801001b4 <bread>
80101665:	83 c4 10             	add    $0x10,%esp
80101668:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
8010166b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010166e:	8d 50 18             	lea    0x18(%eax),%edx
80101671:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101674:	83 e0 07             	and    $0x7,%eax
80101677:	c1 e0 06             	shl    $0x6,%eax
8010167a:	01 d0                	add    %edx,%eax
8010167c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
8010167f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101682:	8b 00                	mov    (%eax),%eax
80101684:	66 85 c0             	test   %ax,%ax
80101687:	75 4b                	jne    801016d4 <ialloc+0xa3>
      memset(dip, 0, sizeof(*dip));
80101689:	83 ec 04             	sub    $0x4,%esp
8010168c:	6a 40                	push   $0x40
8010168e:	6a 00                	push   $0x0
80101690:	ff 75 ec             	pushl  -0x14(%ebp)
80101693:	e8 08 3b 00 00       	call   801051a0 <memset>
80101698:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
8010169b:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010169e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801016a1:	66 89 02             	mov    %ax,(%edx)
      log_write(bp);   // mark it allocated on the disk
801016a4:	83 ec 0c             	sub    $0xc,%esp
801016a7:	ff 75 f0             	pushl  -0x10(%ebp)
801016aa:	e8 d7 1f 00 00       	call   80103686 <log_write>
801016af:	83 c4 10             	add    $0x10,%esp
      brelse(bp);
801016b2:	83 ec 0c             	sub    $0xc,%esp
801016b5:	ff 75 f0             	pushl  -0x10(%ebp)
801016b8:	e8 6e eb ff ff       	call   8010022b <brelse>
801016bd:	83 c4 10             	add    $0x10,%esp
      return iget(dev, inum);
801016c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016c3:	83 ec 08             	sub    $0x8,%esp
801016c6:	50                   	push   %eax
801016c7:	ff 75 08             	pushl  0x8(%ebp)
801016ca:	e8 f3 00 00 00       	call   801017c2 <iget>
801016cf:	83 c4 10             	add    $0x10,%esp
801016d2:	eb 2e                	jmp    80101702 <ialloc+0xd1>
    }
    brelse(bp);
801016d4:	83 ec 0c             	sub    $0xc,%esp
801016d7:	ff 75 f0             	pushl  -0x10(%ebp)
801016da:	e8 4c eb ff ff       	call   8010022b <brelse>
801016df:	83 c4 10             	add    $0x10,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801016e2:	ff 45 f4             	incl   -0xc(%ebp)
801016e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801016e8:	a1 28 12 11 80       	mov    0x80111228,%eax
801016ed:	39 c2                	cmp    %eax,%edx
801016ef:	0f 82 55 ff ff ff    	jb     8010164a <ialloc+0x19>
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
801016f5:	83 ec 0c             	sub    $0xc,%esp
801016f8:	68 df 84 10 80       	push   $0x801084df
801016fd:	e8 4c ee ff ff       	call   8010054e <panic>
}
80101702:	c9                   	leave  
80101703:	c3                   	ret    

80101704 <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
80101704:	55                   	push   %ebp
80101705:	89 e5                	mov    %esp,%ebp
80101707:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010170a:	8b 45 08             	mov    0x8(%ebp),%eax
8010170d:	8b 40 04             	mov    0x4(%eax),%eax
80101710:	c1 e8 03             	shr    $0x3,%eax
80101713:	89 c2                	mov    %eax,%edx
80101715:	a1 34 12 11 80       	mov    0x80111234,%eax
8010171a:	01 c2                	add    %eax,%edx
8010171c:	8b 45 08             	mov    0x8(%ebp),%eax
8010171f:	8b 00                	mov    (%eax),%eax
80101721:	83 ec 08             	sub    $0x8,%esp
80101724:	52                   	push   %edx
80101725:	50                   	push   %eax
80101726:	e8 89 ea ff ff       	call   801001b4 <bread>
8010172b:	83 c4 10             	add    $0x10,%esp
8010172e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101731:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101734:	8d 50 18             	lea    0x18(%eax),%edx
80101737:	8b 45 08             	mov    0x8(%ebp),%eax
8010173a:	8b 40 04             	mov    0x4(%eax),%eax
8010173d:	83 e0 07             	and    $0x7,%eax
80101740:	c1 e0 06             	shl    $0x6,%eax
80101743:	01 d0                	add    %edx,%eax
80101745:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
80101748:	8b 45 08             	mov    0x8(%ebp),%eax
8010174b:	8b 40 10             	mov    0x10(%eax),%eax
8010174e:	8b 55 f0             	mov    -0x10(%ebp),%edx
80101751:	66 89 02             	mov    %ax,(%edx)
  dip->major = ip->major;
80101754:	8b 45 08             	mov    0x8(%ebp),%eax
80101757:	66 8b 40 12          	mov    0x12(%eax),%ax
8010175b:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010175e:	66 89 42 02          	mov    %ax,0x2(%edx)
  dip->minor = ip->minor;
80101762:	8b 45 08             	mov    0x8(%ebp),%eax
80101765:	8b 40 14             	mov    0x14(%eax),%eax
80101768:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010176b:	66 89 42 04          	mov    %ax,0x4(%edx)
  dip->nlink = ip->nlink;
8010176f:	8b 45 08             	mov    0x8(%ebp),%eax
80101772:	66 8b 40 16          	mov    0x16(%eax),%ax
80101776:	8b 55 f0             	mov    -0x10(%ebp),%edx
80101779:	66 89 42 06          	mov    %ax,0x6(%edx)
  dip->size = ip->size;
8010177d:	8b 45 08             	mov    0x8(%ebp),%eax
80101780:	8b 50 18             	mov    0x18(%eax),%edx
80101783:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101786:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101789:	8b 45 08             	mov    0x8(%ebp),%eax
8010178c:	8d 50 1c             	lea    0x1c(%eax),%edx
8010178f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101792:	83 c0 0c             	add    $0xc,%eax
80101795:	83 ec 04             	sub    $0x4,%esp
80101798:	6a 34                	push   $0x34
8010179a:	52                   	push   %edx
8010179b:	50                   	push   %eax
8010179c:	e8 b8 3a 00 00       	call   80105259 <memmove>
801017a1:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801017a4:	83 ec 0c             	sub    $0xc,%esp
801017a7:	ff 75 f4             	pushl  -0xc(%ebp)
801017aa:	e8 d7 1e 00 00       	call   80103686 <log_write>
801017af:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801017b2:	83 ec 0c             	sub    $0xc,%esp
801017b5:	ff 75 f4             	pushl  -0xc(%ebp)
801017b8:	e8 6e ea ff ff       	call   8010022b <brelse>
801017bd:	83 c4 10             	add    $0x10,%esp
}
801017c0:	c9                   	leave  
801017c1:	c3                   	ret    

801017c2 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801017c2:	55                   	push   %ebp
801017c3:	89 e5                	mov    %esp,%ebp
801017c5:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
801017c8:	83 ec 0c             	sub    $0xc,%esp
801017cb:	68 40 12 11 80       	push   $0x80111240
801017d0:	e8 73 37 00 00       	call   80104f48 <acquire>
801017d5:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
801017d8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801017df:	c7 45 f4 74 12 11 80 	movl   $0x80111274,-0xc(%ebp)
801017e6:	eb 5d                	jmp    80101845 <iget+0x83>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801017e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017eb:	8b 40 08             	mov    0x8(%eax),%eax
801017ee:	85 c0                	test   %eax,%eax
801017f0:	7e 39                	jle    8010182b <iget+0x69>
801017f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017f5:	8b 00                	mov    (%eax),%eax
801017f7:	3b 45 08             	cmp    0x8(%ebp),%eax
801017fa:	75 2f                	jne    8010182b <iget+0x69>
801017fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017ff:	8b 40 04             	mov    0x4(%eax),%eax
80101802:	3b 45 0c             	cmp    0xc(%ebp),%eax
80101805:	75 24                	jne    8010182b <iget+0x69>
      ip->ref++;
80101807:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010180a:	8b 40 08             	mov    0x8(%eax),%eax
8010180d:	8d 50 01             	lea    0x1(%eax),%edx
80101810:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101813:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
80101816:	83 ec 0c             	sub    $0xc,%esp
80101819:	68 40 12 11 80       	push   $0x80111240
8010181e:	e8 8b 37 00 00       	call   80104fae <release>
80101823:	83 c4 10             	add    $0x10,%esp
      return ip;
80101826:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101829:	eb 74                	jmp    8010189f <iget+0xdd>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
8010182b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010182f:	75 10                	jne    80101841 <iget+0x7f>
80101831:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101834:	8b 40 08             	mov    0x8(%eax),%eax
80101837:	85 c0                	test   %eax,%eax
80101839:	75 06                	jne    80101841 <iget+0x7f>
      empty = ip;
8010183b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010183e:	89 45 f0             	mov    %eax,-0x10(%ebp)

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101841:	83 45 f4 50          	addl   $0x50,-0xc(%ebp)
80101845:	81 7d f4 14 22 11 80 	cmpl   $0x80112214,-0xc(%ebp)
8010184c:	72 9a                	jb     801017e8 <iget+0x26>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
8010184e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101852:	75 0d                	jne    80101861 <iget+0x9f>
    panic("iget: no inodes");
80101854:	83 ec 0c             	sub    $0xc,%esp
80101857:	68 f1 84 10 80       	push   $0x801084f1
8010185c:	e8 ed ec ff ff       	call   8010054e <panic>

  ip = empty;
80101861:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101864:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
80101867:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010186a:	8b 55 08             	mov    0x8(%ebp),%edx
8010186d:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
8010186f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101872:	8b 55 0c             	mov    0xc(%ebp),%edx
80101875:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
80101878:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010187b:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
80101882:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101885:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  release(&icache.lock);
8010188c:	83 ec 0c             	sub    $0xc,%esp
8010188f:	68 40 12 11 80       	push   $0x80111240
80101894:	e8 15 37 00 00       	call   80104fae <release>
80101899:	83 c4 10             	add    $0x10,%esp

  return ip;
8010189c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010189f:	c9                   	leave  
801018a0:	c3                   	ret    

801018a1 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
801018a1:	55                   	push   %ebp
801018a2:	89 e5                	mov    %esp,%ebp
801018a4:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
801018a7:	83 ec 0c             	sub    $0xc,%esp
801018aa:	68 40 12 11 80       	push   $0x80111240
801018af:	e8 94 36 00 00       	call   80104f48 <acquire>
801018b4:	83 c4 10             	add    $0x10,%esp
  ip->ref++;
801018b7:	8b 45 08             	mov    0x8(%ebp),%eax
801018ba:	8b 40 08             	mov    0x8(%eax),%eax
801018bd:	8d 50 01             	lea    0x1(%eax),%edx
801018c0:	8b 45 08             	mov    0x8(%ebp),%eax
801018c3:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
801018c6:	83 ec 0c             	sub    $0xc,%esp
801018c9:	68 40 12 11 80       	push   $0x80111240
801018ce:	e8 db 36 00 00       	call   80104fae <release>
801018d3:	83 c4 10             	add    $0x10,%esp
  return ip;
801018d6:	8b 45 08             	mov    0x8(%ebp),%eax
}
801018d9:	c9                   	leave  
801018da:	c3                   	ret    

801018db <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
801018db:	55                   	push   %ebp
801018dc:	89 e5                	mov    %esp,%ebp
801018de:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
801018e1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801018e5:	74 0a                	je     801018f1 <ilock+0x16>
801018e7:	8b 45 08             	mov    0x8(%ebp),%eax
801018ea:	8b 40 08             	mov    0x8(%eax),%eax
801018ed:	85 c0                	test   %eax,%eax
801018ef:	7f 0d                	jg     801018fe <ilock+0x23>
    panic("ilock");
801018f1:	83 ec 0c             	sub    $0xc,%esp
801018f4:	68 01 85 10 80       	push   $0x80108501
801018f9:	e8 50 ec ff ff       	call   8010054e <panic>

  acquire(&icache.lock);
801018fe:	83 ec 0c             	sub    $0xc,%esp
80101901:	68 40 12 11 80       	push   $0x80111240
80101906:	e8 3d 36 00 00       	call   80104f48 <acquire>
8010190b:	83 c4 10             	add    $0x10,%esp
  while(ip->flags & I_BUSY)
8010190e:	eb 13                	jmp    80101923 <ilock+0x48>
    sleep(ip, &icache.lock);
80101910:	83 ec 08             	sub    $0x8,%esp
80101913:	68 40 12 11 80       	push   $0x80111240
80101918:	ff 75 08             	pushl  0x8(%ebp)
8010191b:	e8 3b 33 00 00       	call   80104c5b <sleep>
80101920:	83 c4 10             	add    $0x10,%esp

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
80101923:	8b 45 08             	mov    0x8(%ebp),%eax
80101926:	8b 40 0c             	mov    0xc(%eax),%eax
80101929:	83 e0 01             	and    $0x1,%eax
8010192c:	85 c0                	test   %eax,%eax
8010192e:	75 e0                	jne    80101910 <ilock+0x35>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
80101930:	8b 45 08             	mov    0x8(%ebp),%eax
80101933:	8b 40 0c             	mov    0xc(%eax),%eax
80101936:	83 c8 01             	or     $0x1,%eax
80101939:	89 c2                	mov    %eax,%edx
8010193b:	8b 45 08             	mov    0x8(%ebp),%eax
8010193e:	89 50 0c             	mov    %edx,0xc(%eax)
  release(&icache.lock);
80101941:	83 ec 0c             	sub    $0xc,%esp
80101944:	68 40 12 11 80       	push   $0x80111240
80101949:	e8 60 36 00 00       	call   80104fae <release>
8010194e:	83 c4 10             	add    $0x10,%esp

  if(!(ip->flags & I_VALID)){
80101951:	8b 45 08             	mov    0x8(%ebp),%eax
80101954:	8b 40 0c             	mov    0xc(%eax),%eax
80101957:	83 e0 02             	and    $0x2,%eax
8010195a:	85 c0                	test   %eax,%eax
8010195c:	0f 85 d1 00 00 00    	jne    80101a33 <ilock+0x158>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101962:	8b 45 08             	mov    0x8(%ebp),%eax
80101965:	8b 40 04             	mov    0x4(%eax),%eax
80101968:	c1 e8 03             	shr    $0x3,%eax
8010196b:	89 c2                	mov    %eax,%edx
8010196d:	a1 34 12 11 80       	mov    0x80111234,%eax
80101972:	01 c2                	add    %eax,%edx
80101974:	8b 45 08             	mov    0x8(%ebp),%eax
80101977:	8b 00                	mov    (%eax),%eax
80101979:	83 ec 08             	sub    $0x8,%esp
8010197c:	52                   	push   %edx
8010197d:	50                   	push   %eax
8010197e:	e8 31 e8 ff ff       	call   801001b4 <bread>
80101983:	83 c4 10             	add    $0x10,%esp
80101986:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101989:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010198c:	8d 50 18             	lea    0x18(%eax),%edx
8010198f:	8b 45 08             	mov    0x8(%ebp),%eax
80101992:	8b 40 04             	mov    0x4(%eax),%eax
80101995:	83 e0 07             	and    $0x7,%eax
80101998:	c1 e0 06             	shl    $0x6,%eax
8010199b:	01 d0                	add    %edx,%eax
8010199d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
801019a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019a3:	8b 00                	mov    (%eax),%eax
801019a5:	8b 55 08             	mov    0x8(%ebp),%edx
801019a8:	66 89 42 10          	mov    %ax,0x10(%edx)
    ip->major = dip->major;
801019ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019af:	66 8b 40 02          	mov    0x2(%eax),%ax
801019b3:	8b 55 08             	mov    0x8(%ebp),%edx
801019b6:	66 89 42 12          	mov    %ax,0x12(%edx)
    ip->minor = dip->minor;
801019ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019bd:	8b 40 04             	mov    0x4(%eax),%eax
801019c0:	8b 55 08             	mov    0x8(%ebp),%edx
801019c3:	66 89 42 14          	mov    %ax,0x14(%edx)
    ip->nlink = dip->nlink;
801019c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019ca:	66 8b 40 06          	mov    0x6(%eax),%ax
801019ce:	8b 55 08             	mov    0x8(%ebp),%edx
801019d1:	66 89 42 16          	mov    %ax,0x16(%edx)
    ip->size = dip->size;
801019d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019d8:	8b 50 08             	mov    0x8(%eax),%edx
801019db:	8b 45 08             	mov    0x8(%ebp),%eax
801019de:	89 50 18             	mov    %edx,0x18(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801019e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019e4:	8d 50 0c             	lea    0xc(%eax),%edx
801019e7:	8b 45 08             	mov    0x8(%ebp),%eax
801019ea:	83 c0 1c             	add    $0x1c,%eax
801019ed:	83 ec 04             	sub    $0x4,%esp
801019f0:	6a 34                	push   $0x34
801019f2:	52                   	push   %edx
801019f3:	50                   	push   %eax
801019f4:	e8 60 38 00 00       	call   80105259 <memmove>
801019f9:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
801019fc:	83 ec 0c             	sub    $0xc,%esp
801019ff:	ff 75 f4             	pushl  -0xc(%ebp)
80101a02:	e8 24 e8 ff ff       	call   8010022b <brelse>
80101a07:	83 c4 10             	add    $0x10,%esp
    ip->flags |= I_VALID;
80101a0a:	8b 45 08             	mov    0x8(%ebp),%eax
80101a0d:	8b 40 0c             	mov    0xc(%eax),%eax
80101a10:	83 c8 02             	or     $0x2,%eax
80101a13:	89 c2                	mov    %eax,%edx
80101a15:	8b 45 08             	mov    0x8(%ebp),%eax
80101a18:	89 50 0c             	mov    %edx,0xc(%eax)
    if(ip->type == 0)
80101a1b:	8b 45 08             	mov    0x8(%ebp),%eax
80101a1e:	8b 40 10             	mov    0x10(%eax),%eax
80101a21:	66 85 c0             	test   %ax,%ax
80101a24:	75 0d                	jne    80101a33 <ilock+0x158>
      panic("ilock: no type");
80101a26:	83 ec 0c             	sub    $0xc,%esp
80101a29:	68 07 85 10 80       	push   $0x80108507
80101a2e:	e8 1b eb ff ff       	call   8010054e <panic>
  }
}
80101a33:	c9                   	leave  
80101a34:	c3                   	ret    

80101a35 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101a35:	55                   	push   %ebp
80101a36:	89 e5                	mov    %esp,%ebp
80101a38:	83 ec 08             	sub    $0x8,%esp
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
80101a3b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101a3f:	74 17                	je     80101a58 <iunlock+0x23>
80101a41:	8b 45 08             	mov    0x8(%ebp),%eax
80101a44:	8b 40 0c             	mov    0xc(%eax),%eax
80101a47:	83 e0 01             	and    $0x1,%eax
80101a4a:	85 c0                	test   %eax,%eax
80101a4c:	74 0a                	je     80101a58 <iunlock+0x23>
80101a4e:	8b 45 08             	mov    0x8(%ebp),%eax
80101a51:	8b 40 08             	mov    0x8(%eax),%eax
80101a54:	85 c0                	test   %eax,%eax
80101a56:	7f 0d                	jg     80101a65 <iunlock+0x30>
    panic("iunlock");
80101a58:	83 ec 0c             	sub    $0xc,%esp
80101a5b:	68 16 85 10 80       	push   $0x80108516
80101a60:	e8 e9 ea ff ff       	call   8010054e <panic>

  acquire(&icache.lock);
80101a65:	83 ec 0c             	sub    $0xc,%esp
80101a68:	68 40 12 11 80       	push   $0x80111240
80101a6d:	e8 d6 34 00 00       	call   80104f48 <acquire>
80101a72:	83 c4 10             	add    $0x10,%esp
  ip->flags &= ~I_BUSY;
80101a75:	8b 45 08             	mov    0x8(%ebp),%eax
80101a78:	8b 40 0c             	mov    0xc(%eax),%eax
80101a7b:	83 e0 fe             	and    $0xfffffffe,%eax
80101a7e:	89 c2                	mov    %eax,%edx
80101a80:	8b 45 08             	mov    0x8(%ebp),%eax
80101a83:	89 50 0c             	mov    %edx,0xc(%eax)
  wakeup(ip);
80101a86:	83 ec 0c             	sub    $0xc,%esp
80101a89:	ff 75 08             	pushl  0x8(%ebp)
80101a8c:	e8 b3 32 00 00       	call   80104d44 <wakeup>
80101a91:	83 c4 10             	add    $0x10,%esp
  release(&icache.lock);
80101a94:	83 ec 0c             	sub    $0xc,%esp
80101a97:	68 40 12 11 80       	push   $0x80111240
80101a9c:	e8 0d 35 00 00       	call   80104fae <release>
80101aa1:	83 c4 10             	add    $0x10,%esp
}
80101aa4:	c9                   	leave  
80101aa5:	c3                   	ret    

80101aa6 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101aa6:	55                   	push   %ebp
80101aa7:	89 e5                	mov    %esp,%ebp
80101aa9:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101aac:	83 ec 0c             	sub    $0xc,%esp
80101aaf:	68 40 12 11 80       	push   $0x80111240
80101ab4:	e8 8f 34 00 00       	call   80104f48 <acquire>
80101ab9:	83 c4 10             	add    $0x10,%esp
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101abc:	8b 45 08             	mov    0x8(%ebp),%eax
80101abf:	8b 40 08             	mov    0x8(%eax),%eax
80101ac2:	83 f8 01             	cmp    $0x1,%eax
80101ac5:	0f 85 a9 00 00 00    	jne    80101b74 <iput+0xce>
80101acb:	8b 45 08             	mov    0x8(%ebp),%eax
80101ace:	8b 40 0c             	mov    0xc(%eax),%eax
80101ad1:	83 e0 02             	and    $0x2,%eax
80101ad4:	85 c0                	test   %eax,%eax
80101ad6:	0f 84 98 00 00 00    	je     80101b74 <iput+0xce>
80101adc:	8b 45 08             	mov    0x8(%ebp),%eax
80101adf:	66 8b 40 16          	mov    0x16(%eax),%ax
80101ae3:	66 85 c0             	test   %ax,%ax
80101ae6:	0f 85 88 00 00 00    	jne    80101b74 <iput+0xce>
    // inode has no links and no other references: truncate and free.
    if(ip->flags & I_BUSY)
80101aec:	8b 45 08             	mov    0x8(%ebp),%eax
80101aef:	8b 40 0c             	mov    0xc(%eax),%eax
80101af2:	83 e0 01             	and    $0x1,%eax
80101af5:	85 c0                	test   %eax,%eax
80101af7:	74 0d                	je     80101b06 <iput+0x60>
      panic("iput busy");
80101af9:	83 ec 0c             	sub    $0xc,%esp
80101afc:	68 1e 85 10 80       	push   $0x8010851e
80101b01:	e8 48 ea ff ff       	call   8010054e <panic>
    ip->flags |= I_BUSY;
80101b06:	8b 45 08             	mov    0x8(%ebp),%eax
80101b09:	8b 40 0c             	mov    0xc(%eax),%eax
80101b0c:	83 c8 01             	or     $0x1,%eax
80101b0f:	89 c2                	mov    %eax,%edx
80101b11:	8b 45 08             	mov    0x8(%ebp),%eax
80101b14:	89 50 0c             	mov    %edx,0xc(%eax)
    release(&icache.lock);
80101b17:	83 ec 0c             	sub    $0xc,%esp
80101b1a:	68 40 12 11 80       	push   $0x80111240
80101b1f:	e8 8a 34 00 00       	call   80104fae <release>
80101b24:	83 c4 10             	add    $0x10,%esp
    itrunc(ip);
80101b27:	83 ec 0c             	sub    $0xc,%esp
80101b2a:	ff 75 08             	pushl  0x8(%ebp)
80101b2d:	e8 a6 01 00 00       	call   80101cd8 <itrunc>
80101b32:	83 c4 10             	add    $0x10,%esp
    ip->type = 0;
80101b35:	8b 45 08             	mov    0x8(%ebp),%eax
80101b38:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
    iupdate(ip);
80101b3e:	83 ec 0c             	sub    $0xc,%esp
80101b41:	ff 75 08             	pushl  0x8(%ebp)
80101b44:	e8 bb fb ff ff       	call   80101704 <iupdate>
80101b49:	83 c4 10             	add    $0x10,%esp
    acquire(&icache.lock);
80101b4c:	83 ec 0c             	sub    $0xc,%esp
80101b4f:	68 40 12 11 80       	push   $0x80111240
80101b54:	e8 ef 33 00 00       	call   80104f48 <acquire>
80101b59:	83 c4 10             	add    $0x10,%esp
    ip->flags = 0;
80101b5c:	8b 45 08             	mov    0x8(%ebp),%eax
80101b5f:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80101b66:	83 ec 0c             	sub    $0xc,%esp
80101b69:	ff 75 08             	pushl  0x8(%ebp)
80101b6c:	e8 d3 31 00 00       	call   80104d44 <wakeup>
80101b71:	83 c4 10             	add    $0x10,%esp
  }
  ip->ref--;
80101b74:	8b 45 08             	mov    0x8(%ebp),%eax
80101b77:	8b 40 08             	mov    0x8(%eax),%eax
80101b7a:	8d 50 ff             	lea    -0x1(%eax),%edx
80101b7d:	8b 45 08             	mov    0x8(%ebp),%eax
80101b80:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101b83:	83 ec 0c             	sub    $0xc,%esp
80101b86:	68 40 12 11 80       	push   $0x80111240
80101b8b:	e8 1e 34 00 00       	call   80104fae <release>
80101b90:	83 c4 10             	add    $0x10,%esp
}
80101b93:	c9                   	leave  
80101b94:	c3                   	ret    

80101b95 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101b95:	55                   	push   %ebp
80101b96:	89 e5                	mov    %esp,%ebp
80101b98:	83 ec 08             	sub    $0x8,%esp
  iunlock(ip);
80101b9b:	83 ec 0c             	sub    $0xc,%esp
80101b9e:	ff 75 08             	pushl  0x8(%ebp)
80101ba1:	e8 8f fe ff ff       	call   80101a35 <iunlock>
80101ba6:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80101ba9:	83 ec 0c             	sub    $0xc,%esp
80101bac:	ff 75 08             	pushl  0x8(%ebp)
80101baf:	e8 f2 fe ff ff       	call   80101aa6 <iput>
80101bb4:	83 c4 10             	add    $0x10,%esp
}
80101bb7:	c9                   	leave  
80101bb8:	c3                   	ret    

80101bb9 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101bb9:	55                   	push   %ebp
80101bba:	89 e5                	mov    %esp,%ebp
80101bbc:	53                   	push   %ebx
80101bbd:	83 ec 14             	sub    $0x14,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101bc0:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101bc4:	77 42                	ja     80101c08 <bmap+0x4f>
    if((addr = ip->addrs[bn]) == 0)
80101bc6:	8b 45 08             	mov    0x8(%ebp),%eax
80101bc9:	8b 55 0c             	mov    0xc(%ebp),%edx
80101bcc:	83 c2 04             	add    $0x4,%edx
80101bcf:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101bd3:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101bd6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101bda:	75 24                	jne    80101c00 <bmap+0x47>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101bdc:	8b 45 08             	mov    0x8(%ebp),%eax
80101bdf:	8b 00                	mov    (%eax),%eax
80101be1:	83 ec 0c             	sub    $0xc,%esp
80101be4:	50                   	push   %eax
80101be5:	e8 b6 f7 ff ff       	call   801013a0 <balloc>
80101bea:	83 c4 10             	add    $0x10,%esp
80101bed:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101bf0:	8b 45 08             	mov    0x8(%ebp),%eax
80101bf3:	8b 55 0c             	mov    0xc(%ebp),%edx
80101bf6:	8d 4a 04             	lea    0x4(%edx),%ecx
80101bf9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101bfc:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80101c00:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c03:	e9 cb 00 00 00       	jmp    80101cd3 <bmap+0x11a>
  }
  bn -= NDIRECT;
80101c08:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80101c0c:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101c10:	0f 87 b0 00 00 00    	ja     80101cc6 <bmap+0x10d>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101c16:	8b 45 08             	mov    0x8(%ebp),%eax
80101c19:	8b 40 4c             	mov    0x4c(%eax),%eax
80101c1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c1f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c23:	75 1d                	jne    80101c42 <bmap+0x89>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101c25:	8b 45 08             	mov    0x8(%ebp),%eax
80101c28:	8b 00                	mov    (%eax),%eax
80101c2a:	83 ec 0c             	sub    $0xc,%esp
80101c2d:	50                   	push   %eax
80101c2e:	e8 6d f7 ff ff       	call   801013a0 <balloc>
80101c33:	83 c4 10             	add    $0x10,%esp
80101c36:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c39:	8b 45 08             	mov    0x8(%ebp),%eax
80101c3c:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c3f:	89 50 4c             	mov    %edx,0x4c(%eax)
    bp = bread(ip->dev, addr);
80101c42:	8b 45 08             	mov    0x8(%ebp),%eax
80101c45:	8b 00                	mov    (%eax),%eax
80101c47:	83 ec 08             	sub    $0x8,%esp
80101c4a:	ff 75 f4             	pushl  -0xc(%ebp)
80101c4d:	50                   	push   %eax
80101c4e:	e8 61 e5 ff ff       	call   801001b4 <bread>
80101c53:	83 c4 10             	add    $0x10,%esp
80101c56:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101c59:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c5c:	83 c0 18             	add    $0x18,%eax
80101c5f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
80101c62:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c65:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101c6c:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101c6f:	01 d0                	add    %edx,%eax
80101c71:	8b 00                	mov    (%eax),%eax
80101c73:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c76:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c7a:	75 37                	jne    80101cb3 <bmap+0xfa>
      a[bn] = addr = balloc(ip->dev);
80101c7c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c7f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101c86:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101c89:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80101c8c:	8b 45 08             	mov    0x8(%ebp),%eax
80101c8f:	8b 00                	mov    (%eax),%eax
80101c91:	83 ec 0c             	sub    $0xc,%esp
80101c94:	50                   	push   %eax
80101c95:	e8 06 f7 ff ff       	call   801013a0 <balloc>
80101c9a:	83 c4 10             	add    $0x10,%esp
80101c9d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101ca0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101ca3:	89 03                	mov    %eax,(%ebx)
      log_write(bp);
80101ca5:	83 ec 0c             	sub    $0xc,%esp
80101ca8:	ff 75 f0             	pushl  -0x10(%ebp)
80101cab:	e8 d6 19 00 00       	call   80103686 <log_write>
80101cb0:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101cb3:	83 ec 0c             	sub    $0xc,%esp
80101cb6:	ff 75 f0             	pushl  -0x10(%ebp)
80101cb9:	e8 6d e5 ff ff       	call   8010022b <brelse>
80101cbe:	83 c4 10             	add    $0x10,%esp
    return addr;
80101cc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cc4:	eb 0d                	jmp    80101cd3 <bmap+0x11a>
  }

  panic("bmap: out of range");
80101cc6:	83 ec 0c             	sub    $0xc,%esp
80101cc9:	68 28 85 10 80       	push   $0x80108528
80101cce:	e8 7b e8 ff ff       	call   8010054e <panic>
}
80101cd3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101cd6:	c9                   	leave  
80101cd7:	c3                   	ret    

80101cd8 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101cd8:	55                   	push   %ebp
80101cd9:	89 e5                	mov    %esp,%ebp
80101cdb:	83 ec 18             	sub    $0x18,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101cde:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101ce5:	eb 44                	jmp    80101d2b <itrunc+0x53>
    if(ip->addrs[i]){
80101ce7:	8b 45 08             	mov    0x8(%ebp),%eax
80101cea:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101ced:	83 c2 04             	add    $0x4,%edx
80101cf0:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101cf4:	85 c0                	test   %eax,%eax
80101cf6:	74 30                	je     80101d28 <itrunc+0x50>
      bfree(ip->dev, ip->addrs[i]);
80101cf8:	8b 45 08             	mov    0x8(%ebp),%eax
80101cfb:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101cfe:	83 c2 04             	add    $0x4,%edx
80101d01:	8b 54 90 0c          	mov    0xc(%eax,%edx,4),%edx
80101d05:	8b 45 08             	mov    0x8(%ebp),%eax
80101d08:	8b 00                	mov    (%eax),%eax
80101d0a:	83 ec 08             	sub    $0x8,%esp
80101d0d:	52                   	push   %edx
80101d0e:	50                   	push   %eax
80101d0f:	e8 d1 f7 ff ff       	call   801014e5 <bfree>
80101d14:	83 c4 10             	add    $0x10,%esp
      ip->addrs[i] = 0;
80101d17:	8b 45 08             	mov    0x8(%ebp),%eax
80101d1a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d1d:	83 c2 04             	add    $0x4,%edx
80101d20:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101d27:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101d28:	ff 45 f4             	incl   -0xc(%ebp)
80101d2b:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80101d2f:	7e b6                	jle    80101ce7 <itrunc+0xf>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
80101d31:	8b 45 08             	mov    0x8(%ebp),%eax
80101d34:	8b 40 4c             	mov    0x4c(%eax),%eax
80101d37:	85 c0                	test   %eax,%eax
80101d39:	0f 84 a0 00 00 00    	je     80101ddf <itrunc+0x107>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101d3f:	8b 45 08             	mov    0x8(%ebp),%eax
80101d42:	8b 50 4c             	mov    0x4c(%eax),%edx
80101d45:	8b 45 08             	mov    0x8(%ebp),%eax
80101d48:	8b 00                	mov    (%eax),%eax
80101d4a:	83 ec 08             	sub    $0x8,%esp
80101d4d:	52                   	push   %edx
80101d4e:	50                   	push   %eax
80101d4f:	e8 60 e4 ff ff       	call   801001b4 <bread>
80101d54:	83 c4 10             	add    $0x10,%esp
80101d57:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
80101d5a:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d5d:	83 c0 18             	add    $0x18,%eax
80101d60:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101d63:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101d6a:	eb 3b                	jmp    80101da7 <itrunc+0xcf>
      if(a[j])
80101d6c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d6f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d76:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101d79:	01 d0                	add    %edx,%eax
80101d7b:	8b 00                	mov    (%eax),%eax
80101d7d:	85 c0                	test   %eax,%eax
80101d7f:	74 23                	je     80101da4 <itrunc+0xcc>
        bfree(ip->dev, a[j]);
80101d81:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d84:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d8b:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101d8e:	01 d0                	add    %edx,%eax
80101d90:	8b 10                	mov    (%eax),%edx
80101d92:	8b 45 08             	mov    0x8(%ebp),%eax
80101d95:	8b 00                	mov    (%eax),%eax
80101d97:	83 ec 08             	sub    $0x8,%esp
80101d9a:	52                   	push   %edx
80101d9b:	50                   	push   %eax
80101d9c:	e8 44 f7 ff ff       	call   801014e5 <bfree>
80101da1:	83 c4 10             	add    $0x10,%esp
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101da4:	ff 45 f0             	incl   -0x10(%ebp)
80101da7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101daa:	83 f8 7f             	cmp    $0x7f,%eax
80101dad:	76 bd                	jbe    80101d6c <itrunc+0x94>
      if(a[j])
        bfree(ip->dev, a[j]);
    }
    brelse(bp);
80101daf:	83 ec 0c             	sub    $0xc,%esp
80101db2:	ff 75 ec             	pushl  -0x14(%ebp)
80101db5:	e8 71 e4 ff ff       	call   8010022b <brelse>
80101dba:	83 c4 10             	add    $0x10,%esp
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101dbd:	8b 45 08             	mov    0x8(%ebp),%eax
80101dc0:	8b 50 4c             	mov    0x4c(%eax),%edx
80101dc3:	8b 45 08             	mov    0x8(%ebp),%eax
80101dc6:	8b 00                	mov    (%eax),%eax
80101dc8:	83 ec 08             	sub    $0x8,%esp
80101dcb:	52                   	push   %edx
80101dcc:	50                   	push   %eax
80101dcd:	e8 13 f7 ff ff       	call   801014e5 <bfree>
80101dd2:	83 c4 10             	add    $0x10,%esp
    ip->addrs[NDIRECT] = 0;
80101dd5:	8b 45 08             	mov    0x8(%ebp),%eax
80101dd8:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }

  ip->size = 0;
80101ddf:	8b 45 08             	mov    0x8(%ebp),%eax
80101de2:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  iupdate(ip);
80101de9:	83 ec 0c             	sub    $0xc,%esp
80101dec:	ff 75 08             	pushl  0x8(%ebp)
80101def:	e8 10 f9 ff ff       	call   80101704 <iupdate>
80101df4:	83 c4 10             	add    $0x10,%esp
}
80101df7:	c9                   	leave  
80101df8:	c3                   	ret    

80101df9 <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101df9:	55                   	push   %ebp
80101dfa:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80101dfc:	8b 45 08             	mov    0x8(%ebp),%eax
80101dff:	8b 00                	mov    (%eax),%eax
80101e01:	89 c2                	mov    %eax,%edx
80101e03:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e06:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80101e09:	8b 45 08             	mov    0x8(%ebp),%eax
80101e0c:	8b 50 04             	mov    0x4(%eax),%edx
80101e0f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e12:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80101e15:	8b 45 08             	mov    0x8(%ebp),%eax
80101e18:	8b 40 10             	mov    0x10(%eax),%eax
80101e1b:	8b 55 0c             	mov    0xc(%ebp),%edx
80101e1e:	66 89 02             	mov    %ax,(%edx)
  st->nlink = ip->nlink;
80101e21:	8b 45 08             	mov    0x8(%ebp),%eax
80101e24:	66 8b 40 16          	mov    0x16(%eax),%ax
80101e28:	8b 55 0c             	mov    0xc(%ebp),%edx
80101e2b:	66 89 42 0c          	mov    %ax,0xc(%edx)
  st->size = ip->size;
80101e2f:	8b 45 08             	mov    0x8(%ebp),%eax
80101e32:	8b 50 18             	mov    0x18(%eax),%edx
80101e35:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e38:	89 50 10             	mov    %edx,0x10(%eax)
}
80101e3b:	5d                   	pop    %ebp
80101e3c:	c3                   	ret    

80101e3d <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101e3d:	55                   	push   %ebp
80101e3e:	89 e5                	mov    %esp,%ebp
80101e40:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101e43:	8b 45 08             	mov    0x8(%ebp),%eax
80101e46:	8b 40 10             	mov    0x10(%eax),%eax
80101e49:	66 83 f8 03          	cmp    $0x3,%ax
80101e4d:	75 5c                	jne    80101eab <readi+0x6e>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101e4f:	8b 45 08             	mov    0x8(%ebp),%eax
80101e52:	66 8b 40 12          	mov    0x12(%eax),%ax
80101e56:	66 85 c0             	test   %ax,%ax
80101e59:	78 20                	js     80101e7b <readi+0x3e>
80101e5b:	8b 45 08             	mov    0x8(%ebp),%eax
80101e5e:	66 8b 40 12          	mov    0x12(%eax),%ax
80101e62:	66 83 f8 09          	cmp    $0x9,%ax
80101e66:	7f 13                	jg     80101e7b <readi+0x3e>
80101e68:	8b 45 08             	mov    0x8(%ebp),%eax
80101e6b:	66 8b 40 12          	mov    0x12(%eax),%ax
80101e6f:	98                   	cwtl   
80101e70:	8b 04 c5 c0 11 11 80 	mov    -0x7feeee40(,%eax,8),%eax
80101e77:	85 c0                	test   %eax,%eax
80101e79:	75 0a                	jne    80101e85 <readi+0x48>
      return -1;
80101e7b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e80:	e9 16 01 00 00       	jmp    80101f9b <readi+0x15e>
    return devsw[ip->major].read(ip, dst, n);
80101e85:	8b 45 08             	mov    0x8(%ebp),%eax
80101e88:	66 8b 40 12          	mov    0x12(%eax),%ax
80101e8c:	98                   	cwtl   
80101e8d:	8b 04 c5 c0 11 11 80 	mov    -0x7feeee40(,%eax,8),%eax
80101e94:	8b 55 14             	mov    0x14(%ebp),%edx
80101e97:	83 ec 04             	sub    $0x4,%esp
80101e9a:	52                   	push   %edx
80101e9b:	ff 75 0c             	pushl  0xc(%ebp)
80101e9e:	ff 75 08             	pushl  0x8(%ebp)
80101ea1:	ff d0                	call   *%eax
80101ea3:	83 c4 10             	add    $0x10,%esp
80101ea6:	e9 f0 00 00 00       	jmp    80101f9b <readi+0x15e>
  }

  if(off > ip->size || off + n < off)
80101eab:	8b 45 08             	mov    0x8(%ebp),%eax
80101eae:	8b 40 18             	mov    0x18(%eax),%eax
80101eb1:	3b 45 10             	cmp    0x10(%ebp),%eax
80101eb4:	72 0d                	jb     80101ec3 <readi+0x86>
80101eb6:	8b 55 10             	mov    0x10(%ebp),%edx
80101eb9:	8b 45 14             	mov    0x14(%ebp),%eax
80101ebc:	01 d0                	add    %edx,%eax
80101ebe:	3b 45 10             	cmp    0x10(%ebp),%eax
80101ec1:	73 0a                	jae    80101ecd <readi+0x90>
    return -1;
80101ec3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ec8:	e9 ce 00 00 00       	jmp    80101f9b <readi+0x15e>
  if(off + n > ip->size)
80101ecd:	8b 55 10             	mov    0x10(%ebp),%edx
80101ed0:	8b 45 14             	mov    0x14(%ebp),%eax
80101ed3:	01 c2                	add    %eax,%edx
80101ed5:	8b 45 08             	mov    0x8(%ebp),%eax
80101ed8:	8b 40 18             	mov    0x18(%eax),%eax
80101edb:	39 c2                	cmp    %eax,%edx
80101edd:	76 0c                	jbe    80101eeb <readi+0xae>
    n = ip->size - off;
80101edf:	8b 45 08             	mov    0x8(%ebp),%eax
80101ee2:	8b 40 18             	mov    0x18(%eax),%eax
80101ee5:	2b 45 10             	sub    0x10(%ebp),%eax
80101ee8:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101eeb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101ef2:	e9 95 00 00 00       	jmp    80101f8c <readi+0x14f>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ef7:	8b 45 10             	mov    0x10(%ebp),%eax
80101efa:	c1 e8 09             	shr    $0x9,%eax
80101efd:	83 ec 08             	sub    $0x8,%esp
80101f00:	50                   	push   %eax
80101f01:	ff 75 08             	pushl  0x8(%ebp)
80101f04:	e8 b0 fc ff ff       	call   80101bb9 <bmap>
80101f09:	83 c4 10             	add    $0x10,%esp
80101f0c:	8b 55 08             	mov    0x8(%ebp),%edx
80101f0f:	8b 12                	mov    (%edx),%edx
80101f11:	83 ec 08             	sub    $0x8,%esp
80101f14:	50                   	push   %eax
80101f15:	52                   	push   %edx
80101f16:	e8 99 e2 ff ff       	call   801001b4 <bread>
80101f1b:	83 c4 10             	add    $0x10,%esp
80101f1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101f21:	8b 45 10             	mov    0x10(%ebp),%eax
80101f24:	25 ff 01 00 00       	and    $0x1ff,%eax
80101f29:	89 c2                	mov    %eax,%edx
80101f2b:	b8 00 02 00 00       	mov    $0x200,%eax
80101f30:	29 d0                	sub    %edx,%eax
80101f32:	89 c1                	mov    %eax,%ecx
80101f34:	8b 45 14             	mov    0x14(%ebp),%eax
80101f37:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101f3a:	89 c2                	mov    %eax,%edx
80101f3c:	89 c8                	mov    %ecx,%eax
80101f3e:	39 d0                	cmp    %edx,%eax
80101f40:	76 02                	jbe    80101f44 <readi+0x107>
80101f42:	89 d0                	mov    %edx,%eax
80101f44:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
80101f47:	8b 45 10             	mov    0x10(%ebp),%eax
80101f4a:	25 ff 01 00 00       	and    $0x1ff,%eax
80101f4f:	8d 50 10             	lea    0x10(%eax),%edx
80101f52:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101f55:	01 d0                	add    %edx,%eax
80101f57:	83 c0 08             	add    $0x8,%eax
80101f5a:	83 ec 04             	sub    $0x4,%esp
80101f5d:	ff 75 ec             	pushl  -0x14(%ebp)
80101f60:	50                   	push   %eax
80101f61:	ff 75 0c             	pushl  0xc(%ebp)
80101f64:	e8 f0 32 00 00       	call   80105259 <memmove>
80101f69:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101f6c:	83 ec 0c             	sub    $0xc,%esp
80101f6f:	ff 75 f0             	pushl  -0x10(%ebp)
80101f72:	e8 b4 e2 ff ff       	call   8010022b <brelse>
80101f77:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101f7a:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101f7d:	01 45 f4             	add    %eax,-0xc(%ebp)
80101f80:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101f83:	01 45 10             	add    %eax,0x10(%ebp)
80101f86:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101f89:	01 45 0c             	add    %eax,0xc(%ebp)
80101f8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101f8f:	3b 45 14             	cmp    0x14(%ebp),%eax
80101f92:	0f 82 5f ff ff ff    	jb     80101ef7 <readi+0xba>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101f98:	8b 45 14             	mov    0x14(%ebp),%eax
}
80101f9b:	c9                   	leave  
80101f9c:	c3                   	ret    

80101f9d <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101f9d:	55                   	push   %ebp
80101f9e:	89 e5                	mov    %esp,%ebp
80101fa0:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101fa3:	8b 45 08             	mov    0x8(%ebp),%eax
80101fa6:	8b 40 10             	mov    0x10(%eax),%eax
80101fa9:	66 83 f8 03          	cmp    $0x3,%ax
80101fad:	75 5c                	jne    8010200b <writei+0x6e>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101faf:	8b 45 08             	mov    0x8(%ebp),%eax
80101fb2:	66 8b 40 12          	mov    0x12(%eax),%ax
80101fb6:	66 85 c0             	test   %ax,%ax
80101fb9:	78 20                	js     80101fdb <writei+0x3e>
80101fbb:	8b 45 08             	mov    0x8(%ebp),%eax
80101fbe:	66 8b 40 12          	mov    0x12(%eax),%ax
80101fc2:	66 83 f8 09          	cmp    $0x9,%ax
80101fc6:	7f 13                	jg     80101fdb <writei+0x3e>
80101fc8:	8b 45 08             	mov    0x8(%ebp),%eax
80101fcb:	66 8b 40 12          	mov    0x12(%eax),%ax
80101fcf:	98                   	cwtl   
80101fd0:	8b 04 c5 c4 11 11 80 	mov    -0x7feeee3c(,%eax,8),%eax
80101fd7:	85 c0                	test   %eax,%eax
80101fd9:	75 0a                	jne    80101fe5 <writei+0x48>
      return -1;
80101fdb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101fe0:	e9 47 01 00 00       	jmp    8010212c <writei+0x18f>
    return devsw[ip->major].write(ip, src, n);
80101fe5:	8b 45 08             	mov    0x8(%ebp),%eax
80101fe8:	66 8b 40 12          	mov    0x12(%eax),%ax
80101fec:	98                   	cwtl   
80101fed:	8b 04 c5 c4 11 11 80 	mov    -0x7feeee3c(,%eax,8),%eax
80101ff4:	8b 55 14             	mov    0x14(%ebp),%edx
80101ff7:	83 ec 04             	sub    $0x4,%esp
80101ffa:	52                   	push   %edx
80101ffb:	ff 75 0c             	pushl  0xc(%ebp)
80101ffe:	ff 75 08             	pushl  0x8(%ebp)
80102001:	ff d0                	call   *%eax
80102003:	83 c4 10             	add    $0x10,%esp
80102006:	e9 21 01 00 00       	jmp    8010212c <writei+0x18f>
  }

  if(off > ip->size || off + n < off)
8010200b:	8b 45 08             	mov    0x8(%ebp),%eax
8010200e:	8b 40 18             	mov    0x18(%eax),%eax
80102011:	3b 45 10             	cmp    0x10(%ebp),%eax
80102014:	72 0d                	jb     80102023 <writei+0x86>
80102016:	8b 55 10             	mov    0x10(%ebp),%edx
80102019:	8b 45 14             	mov    0x14(%ebp),%eax
8010201c:	01 d0                	add    %edx,%eax
8010201e:	3b 45 10             	cmp    0x10(%ebp),%eax
80102021:	73 0a                	jae    8010202d <writei+0x90>
    return -1;
80102023:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102028:	e9 ff 00 00 00       	jmp    8010212c <writei+0x18f>
  if(off + n > MAXFILE*BSIZE)
8010202d:	8b 55 10             	mov    0x10(%ebp),%edx
80102030:	8b 45 14             	mov    0x14(%ebp),%eax
80102033:	01 d0                	add    %edx,%eax
80102035:	3d 00 18 01 00       	cmp    $0x11800,%eax
8010203a:	76 0a                	jbe    80102046 <writei+0xa9>
    return -1;
8010203c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102041:	e9 e6 00 00 00       	jmp    8010212c <writei+0x18f>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102046:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010204d:	e9 a3 00 00 00       	jmp    801020f5 <writei+0x158>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102052:	8b 45 10             	mov    0x10(%ebp),%eax
80102055:	c1 e8 09             	shr    $0x9,%eax
80102058:	83 ec 08             	sub    $0x8,%esp
8010205b:	50                   	push   %eax
8010205c:	ff 75 08             	pushl  0x8(%ebp)
8010205f:	e8 55 fb ff ff       	call   80101bb9 <bmap>
80102064:	83 c4 10             	add    $0x10,%esp
80102067:	8b 55 08             	mov    0x8(%ebp),%edx
8010206a:	8b 12                	mov    (%edx),%edx
8010206c:	83 ec 08             	sub    $0x8,%esp
8010206f:	50                   	push   %eax
80102070:	52                   	push   %edx
80102071:	e8 3e e1 ff ff       	call   801001b4 <bread>
80102076:	83 c4 10             	add    $0x10,%esp
80102079:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
8010207c:	8b 45 10             	mov    0x10(%ebp),%eax
8010207f:	25 ff 01 00 00       	and    $0x1ff,%eax
80102084:	89 c2                	mov    %eax,%edx
80102086:	b8 00 02 00 00       	mov    $0x200,%eax
8010208b:	29 d0                	sub    %edx,%eax
8010208d:	89 c1                	mov    %eax,%ecx
8010208f:	8b 45 14             	mov    0x14(%ebp),%eax
80102092:	2b 45 f4             	sub    -0xc(%ebp),%eax
80102095:	89 c2                	mov    %eax,%edx
80102097:	89 c8                	mov    %ecx,%eax
80102099:	39 d0                	cmp    %edx,%eax
8010209b:	76 02                	jbe    8010209f <writei+0x102>
8010209d:	89 d0                	mov    %edx,%eax
8010209f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
801020a2:	8b 45 10             	mov    0x10(%ebp),%eax
801020a5:	25 ff 01 00 00       	and    $0x1ff,%eax
801020aa:	8d 50 10             	lea    0x10(%eax),%edx
801020ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
801020b0:	01 d0                	add    %edx,%eax
801020b2:	83 c0 08             	add    $0x8,%eax
801020b5:	83 ec 04             	sub    $0x4,%esp
801020b8:	ff 75 ec             	pushl  -0x14(%ebp)
801020bb:	ff 75 0c             	pushl  0xc(%ebp)
801020be:	50                   	push   %eax
801020bf:	e8 95 31 00 00       	call   80105259 <memmove>
801020c4:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
801020c7:	83 ec 0c             	sub    $0xc,%esp
801020ca:	ff 75 f0             	pushl  -0x10(%ebp)
801020cd:	e8 b4 15 00 00       	call   80103686 <log_write>
801020d2:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
801020d5:	83 ec 0c             	sub    $0xc,%esp
801020d8:	ff 75 f0             	pushl  -0x10(%ebp)
801020db:	e8 4b e1 ff ff       	call   8010022b <brelse>
801020e0:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801020e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020e6:	01 45 f4             	add    %eax,-0xc(%ebp)
801020e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020ec:	01 45 10             	add    %eax,0x10(%ebp)
801020ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020f2:	01 45 0c             	add    %eax,0xc(%ebp)
801020f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801020f8:	3b 45 14             	cmp    0x14(%ebp),%eax
801020fb:	0f 82 51 ff ff ff    	jb     80102052 <writei+0xb5>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80102101:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80102105:	74 22                	je     80102129 <writei+0x18c>
80102107:	8b 45 08             	mov    0x8(%ebp),%eax
8010210a:	8b 40 18             	mov    0x18(%eax),%eax
8010210d:	3b 45 10             	cmp    0x10(%ebp),%eax
80102110:	73 17                	jae    80102129 <writei+0x18c>
    ip->size = off;
80102112:	8b 45 08             	mov    0x8(%ebp),%eax
80102115:	8b 55 10             	mov    0x10(%ebp),%edx
80102118:	89 50 18             	mov    %edx,0x18(%eax)
    iupdate(ip);
8010211b:	83 ec 0c             	sub    $0xc,%esp
8010211e:	ff 75 08             	pushl  0x8(%ebp)
80102121:	e8 de f5 ff ff       	call   80101704 <iupdate>
80102126:	83 c4 10             	add    $0x10,%esp
  }
  return n;
80102129:	8b 45 14             	mov    0x14(%ebp),%eax
}
8010212c:	c9                   	leave  
8010212d:	c3                   	ret    

8010212e <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
8010212e:	55                   	push   %ebp
8010212f:	89 e5                	mov    %esp,%ebp
80102131:	83 ec 08             	sub    $0x8,%esp
  return strncmp(s, t, DIRSIZ);
80102134:	83 ec 04             	sub    $0x4,%esp
80102137:	6a 0e                	push   $0xe
80102139:	ff 75 0c             	pushl  0xc(%ebp)
8010213c:	ff 75 08             	pushl  0x8(%ebp)
8010213f:	e8 a9 31 00 00       	call   801052ed <strncmp>
80102144:	83 c4 10             	add    $0x10,%esp
}
80102147:	c9                   	leave  
80102148:	c3                   	ret    

80102149 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102149:	55                   	push   %ebp
8010214a:	89 e5                	mov    %esp,%ebp
8010214c:	83 ec 28             	sub    $0x28,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
8010214f:	8b 45 08             	mov    0x8(%ebp),%eax
80102152:	8b 40 10             	mov    0x10(%eax),%eax
80102155:	66 83 f8 01          	cmp    $0x1,%ax
80102159:	74 0d                	je     80102168 <dirlookup+0x1f>
    panic("dirlookup not DIR");
8010215b:	83 ec 0c             	sub    $0xc,%esp
8010215e:	68 3b 85 10 80       	push   $0x8010853b
80102163:	e8 e6 e3 ff ff       	call   8010054e <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
80102168:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010216f:	eb 7a                	jmp    801021eb <dirlookup+0xa2>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102171:	6a 10                	push   $0x10
80102173:	ff 75 f4             	pushl  -0xc(%ebp)
80102176:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102179:	50                   	push   %eax
8010217a:	ff 75 08             	pushl  0x8(%ebp)
8010217d:	e8 bb fc ff ff       	call   80101e3d <readi>
80102182:	83 c4 10             	add    $0x10,%esp
80102185:	83 f8 10             	cmp    $0x10,%eax
80102188:	74 0d                	je     80102197 <dirlookup+0x4e>
      panic("dirlink read");
8010218a:	83 ec 0c             	sub    $0xc,%esp
8010218d:	68 4d 85 10 80       	push   $0x8010854d
80102192:	e8 b7 e3 ff ff       	call   8010054e <panic>
    if(de.inum == 0)
80102197:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010219a:	66 85 c0             	test   %ax,%ax
8010219d:	75 02                	jne    801021a1 <dirlookup+0x58>
      continue;
8010219f:	eb 46                	jmp    801021e7 <dirlookup+0x9e>
    if(namecmp(name, de.name) == 0){
801021a1:	83 ec 08             	sub    $0x8,%esp
801021a4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801021a7:	83 c0 02             	add    $0x2,%eax
801021aa:	50                   	push   %eax
801021ab:	ff 75 0c             	pushl  0xc(%ebp)
801021ae:	e8 7b ff ff ff       	call   8010212e <namecmp>
801021b3:	83 c4 10             	add    $0x10,%esp
801021b6:	85 c0                	test   %eax,%eax
801021b8:	75 2d                	jne    801021e7 <dirlookup+0x9e>
      // entry matches path element
      if(poff)
801021ba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801021be:	74 08                	je     801021c8 <dirlookup+0x7f>
        *poff = off;
801021c0:	8b 45 10             	mov    0x10(%ebp),%eax
801021c3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801021c6:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
801021c8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801021cb:	0f b7 c0             	movzwl %ax,%eax
801021ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
801021d1:	8b 45 08             	mov    0x8(%ebp),%eax
801021d4:	8b 00                	mov    (%eax),%eax
801021d6:	83 ec 08             	sub    $0x8,%esp
801021d9:	ff 75 f0             	pushl  -0x10(%ebp)
801021dc:	50                   	push   %eax
801021dd:	e8 e0 f5 ff ff       	call   801017c2 <iget>
801021e2:	83 c4 10             	add    $0x10,%esp
801021e5:	eb 18                	jmp    801021ff <dirlookup+0xb6>
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
801021e7:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
801021eb:	8b 45 08             	mov    0x8(%ebp),%eax
801021ee:	8b 40 18             	mov    0x18(%eax),%eax
801021f1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801021f4:	0f 87 77 ff ff ff    	ja     80102171 <dirlookup+0x28>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
801021fa:	b8 00 00 00 00       	mov    $0x0,%eax
}
801021ff:	c9                   	leave  
80102200:	c3                   	ret    

80102201 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80102201:	55                   	push   %ebp
80102202:	89 e5                	mov    %esp,%ebp
80102204:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80102207:	83 ec 04             	sub    $0x4,%esp
8010220a:	6a 00                	push   $0x0
8010220c:	ff 75 0c             	pushl  0xc(%ebp)
8010220f:	ff 75 08             	pushl  0x8(%ebp)
80102212:	e8 32 ff ff ff       	call   80102149 <dirlookup>
80102217:	83 c4 10             	add    $0x10,%esp
8010221a:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010221d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102221:	74 18                	je     8010223b <dirlink+0x3a>
    iput(ip);
80102223:	83 ec 0c             	sub    $0xc,%esp
80102226:	ff 75 f0             	pushl  -0x10(%ebp)
80102229:	e8 78 f8 ff ff       	call   80101aa6 <iput>
8010222e:	83 c4 10             	add    $0x10,%esp
    return -1;
80102231:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102236:	e9 9a 00 00 00       	jmp    801022d5 <dirlink+0xd4>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
8010223b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102242:	eb 3a                	jmp    8010227e <dirlink+0x7d>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102244:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102247:	6a 10                	push   $0x10
80102249:	50                   	push   %eax
8010224a:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010224d:	50                   	push   %eax
8010224e:	ff 75 08             	pushl  0x8(%ebp)
80102251:	e8 e7 fb ff ff       	call   80101e3d <readi>
80102256:	83 c4 10             	add    $0x10,%esp
80102259:	83 f8 10             	cmp    $0x10,%eax
8010225c:	74 0d                	je     8010226b <dirlink+0x6a>
      panic("dirlink read");
8010225e:	83 ec 0c             	sub    $0xc,%esp
80102261:	68 4d 85 10 80       	push   $0x8010854d
80102266:	e8 e3 e2 ff ff       	call   8010054e <panic>
    if(de.inum == 0)
8010226b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010226e:	66 85 c0             	test   %ax,%ax
80102271:	75 02                	jne    80102275 <dirlink+0x74>
      break;
80102273:	eb 16                	jmp    8010228b <dirlink+0x8a>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80102275:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102278:	83 c0 10             	add    $0x10,%eax
8010227b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010227e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102281:	8b 45 08             	mov    0x8(%ebp),%eax
80102284:	8b 40 18             	mov    0x18(%eax),%eax
80102287:	39 c2                	cmp    %eax,%edx
80102289:	72 b9                	jb     80102244 <dirlink+0x43>
      panic("dirlink read");
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
8010228b:	83 ec 04             	sub    $0x4,%esp
8010228e:	6a 0e                	push   $0xe
80102290:	ff 75 0c             	pushl  0xc(%ebp)
80102293:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102296:	83 c0 02             	add    $0x2,%eax
80102299:	50                   	push   %eax
8010229a:	e8 9c 30 00 00       	call   8010533b <strncpy>
8010229f:	83 c4 10             	add    $0x10,%esp
  de.inum = inum;
801022a2:	8b 45 10             	mov    0x10(%ebp),%eax
801022a5:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801022a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022ac:	6a 10                	push   $0x10
801022ae:	50                   	push   %eax
801022af:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022b2:	50                   	push   %eax
801022b3:	ff 75 08             	pushl  0x8(%ebp)
801022b6:	e8 e2 fc ff ff       	call   80101f9d <writei>
801022bb:	83 c4 10             	add    $0x10,%esp
801022be:	83 f8 10             	cmp    $0x10,%eax
801022c1:	74 0d                	je     801022d0 <dirlink+0xcf>
    panic("dirlink");
801022c3:	83 ec 0c             	sub    $0xc,%esp
801022c6:	68 5a 85 10 80       	push   $0x8010855a
801022cb:	e8 7e e2 ff ff       	call   8010054e <panic>
  
  return 0;
801022d0:	b8 00 00 00 00       	mov    $0x0,%eax
}
801022d5:	c9                   	leave  
801022d6:	c3                   	ret    

801022d7 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
801022d7:	55                   	push   %ebp
801022d8:	89 e5                	mov    %esp,%ebp
801022da:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int len;

  while(*path == '/')
801022dd:	eb 03                	jmp    801022e2 <skipelem+0xb>
    path++;
801022df:	ff 45 08             	incl   0x8(%ebp)
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
801022e2:	8b 45 08             	mov    0x8(%ebp),%eax
801022e5:	8a 00                	mov    (%eax),%al
801022e7:	3c 2f                	cmp    $0x2f,%al
801022e9:	74 f4                	je     801022df <skipelem+0x8>
    path++;
  if(*path == 0)
801022eb:	8b 45 08             	mov    0x8(%ebp),%eax
801022ee:	8a 00                	mov    (%eax),%al
801022f0:	84 c0                	test   %al,%al
801022f2:	75 07                	jne    801022fb <skipelem+0x24>
    return 0;
801022f4:	b8 00 00 00 00       	mov    $0x0,%eax
801022f9:	eb 76                	jmp    80102371 <skipelem+0x9a>
  s = path;
801022fb:	8b 45 08             	mov    0x8(%ebp),%eax
801022fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
80102301:	eb 03                	jmp    80102306 <skipelem+0x2f>
    path++;
80102303:	ff 45 08             	incl   0x8(%ebp)
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80102306:	8b 45 08             	mov    0x8(%ebp),%eax
80102309:	8a 00                	mov    (%eax),%al
8010230b:	3c 2f                	cmp    $0x2f,%al
8010230d:	74 09                	je     80102318 <skipelem+0x41>
8010230f:	8b 45 08             	mov    0x8(%ebp),%eax
80102312:	8a 00                	mov    (%eax),%al
80102314:	84 c0                	test   %al,%al
80102316:	75 eb                	jne    80102303 <skipelem+0x2c>
    path++;
  len = path - s;
80102318:	8b 55 08             	mov    0x8(%ebp),%edx
8010231b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010231e:	29 c2                	sub    %eax,%edx
80102320:	89 d0                	mov    %edx,%eax
80102322:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
80102325:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
80102329:	7e 15                	jle    80102340 <skipelem+0x69>
    memmove(name, s, DIRSIZ);
8010232b:	83 ec 04             	sub    $0x4,%esp
8010232e:	6a 0e                	push   $0xe
80102330:	ff 75 f4             	pushl  -0xc(%ebp)
80102333:	ff 75 0c             	pushl  0xc(%ebp)
80102336:	e8 1e 2f 00 00       	call   80105259 <memmove>
8010233b:	83 c4 10             	add    $0x10,%esp
8010233e:	eb 20                	jmp    80102360 <skipelem+0x89>
  else {
    memmove(name, s, len);
80102340:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102343:	83 ec 04             	sub    $0x4,%esp
80102346:	50                   	push   %eax
80102347:	ff 75 f4             	pushl  -0xc(%ebp)
8010234a:	ff 75 0c             	pushl  0xc(%ebp)
8010234d:	e8 07 2f 00 00       	call   80105259 <memmove>
80102352:	83 c4 10             	add    $0x10,%esp
    name[len] = 0;
80102355:	8b 55 f0             	mov    -0x10(%ebp),%edx
80102358:	8b 45 0c             	mov    0xc(%ebp),%eax
8010235b:	01 d0                	add    %edx,%eax
8010235d:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
80102360:	eb 03                	jmp    80102365 <skipelem+0x8e>
    path++;
80102362:	ff 45 08             	incl   0x8(%ebp)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80102365:	8b 45 08             	mov    0x8(%ebp),%eax
80102368:	8a 00                	mov    (%eax),%al
8010236a:	3c 2f                	cmp    $0x2f,%al
8010236c:	74 f4                	je     80102362 <skipelem+0x8b>
    path++;
  return path;
8010236e:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102371:	c9                   	leave  
80102372:	c3                   	ret    

80102373 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102373:	55                   	push   %ebp
80102374:	89 e5                	mov    %esp,%ebp
80102376:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *next;

  if(*path == '/')
80102379:	8b 45 08             	mov    0x8(%ebp),%eax
8010237c:	8a 00                	mov    (%eax),%al
8010237e:	3c 2f                	cmp    $0x2f,%al
80102380:	75 14                	jne    80102396 <namex+0x23>
    ip = iget(ROOTDEV, ROOTINO);
80102382:	83 ec 08             	sub    $0x8,%esp
80102385:	6a 01                	push   $0x1
80102387:	6a 01                	push   $0x1
80102389:	e8 34 f4 ff ff       	call   801017c2 <iget>
8010238e:	83 c4 10             	add    $0x10,%esp
80102391:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102394:	eb 18                	jmp    801023ae <namex+0x3b>
  else
    ip = idup(proc->cwd);
80102396:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010239c:	8b 40 68             	mov    0x68(%eax),%eax
8010239f:	83 ec 0c             	sub    $0xc,%esp
801023a2:	50                   	push   %eax
801023a3:	e8 f9 f4 ff ff       	call   801018a1 <idup>
801023a8:	83 c4 10             	add    $0x10,%esp
801023ab:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
801023ae:	e9 9c 00 00 00       	jmp    8010244f <namex+0xdc>
    ilock(ip);
801023b3:	83 ec 0c             	sub    $0xc,%esp
801023b6:	ff 75 f4             	pushl  -0xc(%ebp)
801023b9:	e8 1d f5 ff ff       	call   801018db <ilock>
801023be:	83 c4 10             	add    $0x10,%esp
    if(ip->type != T_DIR){
801023c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023c4:	8b 40 10             	mov    0x10(%eax),%eax
801023c7:	66 83 f8 01          	cmp    $0x1,%ax
801023cb:	74 18                	je     801023e5 <namex+0x72>
      iunlockput(ip);
801023cd:	83 ec 0c             	sub    $0xc,%esp
801023d0:	ff 75 f4             	pushl  -0xc(%ebp)
801023d3:	e8 bd f7 ff ff       	call   80101b95 <iunlockput>
801023d8:	83 c4 10             	add    $0x10,%esp
      return 0;
801023db:	b8 00 00 00 00       	mov    $0x0,%eax
801023e0:	e9 a6 00 00 00       	jmp    8010248b <namex+0x118>
    }
    if(nameiparent && *path == '\0'){
801023e5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801023e9:	74 1f                	je     8010240a <namex+0x97>
801023eb:	8b 45 08             	mov    0x8(%ebp),%eax
801023ee:	8a 00                	mov    (%eax),%al
801023f0:	84 c0                	test   %al,%al
801023f2:	75 16                	jne    8010240a <namex+0x97>
      // Stop one level early.
      iunlock(ip);
801023f4:	83 ec 0c             	sub    $0xc,%esp
801023f7:	ff 75 f4             	pushl  -0xc(%ebp)
801023fa:	e8 36 f6 ff ff       	call   80101a35 <iunlock>
801023ff:	83 c4 10             	add    $0x10,%esp
      return ip;
80102402:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102405:	e9 81 00 00 00       	jmp    8010248b <namex+0x118>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
8010240a:	83 ec 04             	sub    $0x4,%esp
8010240d:	6a 00                	push   $0x0
8010240f:	ff 75 10             	pushl  0x10(%ebp)
80102412:	ff 75 f4             	pushl  -0xc(%ebp)
80102415:	e8 2f fd ff ff       	call   80102149 <dirlookup>
8010241a:	83 c4 10             	add    $0x10,%esp
8010241d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102420:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102424:	75 15                	jne    8010243b <namex+0xc8>
      iunlockput(ip);
80102426:	83 ec 0c             	sub    $0xc,%esp
80102429:	ff 75 f4             	pushl  -0xc(%ebp)
8010242c:	e8 64 f7 ff ff       	call   80101b95 <iunlockput>
80102431:	83 c4 10             	add    $0x10,%esp
      return 0;
80102434:	b8 00 00 00 00       	mov    $0x0,%eax
80102439:	eb 50                	jmp    8010248b <namex+0x118>
    }
    iunlockput(ip);
8010243b:	83 ec 0c             	sub    $0xc,%esp
8010243e:	ff 75 f4             	pushl  -0xc(%ebp)
80102441:	e8 4f f7 ff ff       	call   80101b95 <iunlockput>
80102446:	83 c4 10             	add    $0x10,%esp
    ip = next;
80102449:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010244c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
8010244f:	83 ec 08             	sub    $0x8,%esp
80102452:	ff 75 10             	pushl  0x10(%ebp)
80102455:	ff 75 08             	pushl  0x8(%ebp)
80102458:	e8 7a fe ff ff       	call   801022d7 <skipelem>
8010245d:	83 c4 10             	add    $0x10,%esp
80102460:	89 45 08             	mov    %eax,0x8(%ebp)
80102463:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102467:	0f 85 46 ff ff ff    	jne    801023b3 <namex+0x40>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
8010246d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102471:	74 15                	je     80102488 <namex+0x115>
    iput(ip);
80102473:	83 ec 0c             	sub    $0xc,%esp
80102476:	ff 75 f4             	pushl  -0xc(%ebp)
80102479:	e8 28 f6 ff ff       	call   80101aa6 <iput>
8010247e:	83 c4 10             	add    $0x10,%esp
    return 0;
80102481:	b8 00 00 00 00       	mov    $0x0,%eax
80102486:	eb 03                	jmp    8010248b <namex+0x118>
  }
  return ip;
80102488:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010248b:	c9                   	leave  
8010248c:	c3                   	ret    

8010248d <namei>:

struct inode*
namei(char *path)
{
8010248d:	55                   	push   %ebp
8010248e:	89 e5                	mov    %esp,%ebp
80102490:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102493:	83 ec 04             	sub    $0x4,%esp
80102496:	8d 45 ea             	lea    -0x16(%ebp),%eax
80102499:	50                   	push   %eax
8010249a:	6a 00                	push   $0x0
8010249c:	ff 75 08             	pushl  0x8(%ebp)
8010249f:	e8 cf fe ff ff       	call   80102373 <namex>
801024a4:	83 c4 10             	add    $0x10,%esp
}
801024a7:	c9                   	leave  
801024a8:	c3                   	ret    

801024a9 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801024a9:	55                   	push   %ebp
801024aa:	89 e5                	mov    %esp,%ebp
801024ac:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
801024af:	83 ec 04             	sub    $0x4,%esp
801024b2:	ff 75 0c             	pushl  0xc(%ebp)
801024b5:	6a 01                	push   $0x1
801024b7:	ff 75 08             	pushl  0x8(%ebp)
801024ba:	e8 b4 fe ff ff       	call   80102373 <namex>
801024bf:	83 c4 10             	add    $0x10,%esp
}
801024c2:	c9                   	leave  
801024c3:	c3                   	ret    

801024c4 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801024c4:	55                   	push   %ebp
801024c5:	89 e5                	mov    %esp,%ebp
801024c7:	83 ec 14             	sub    $0x14,%esp
801024ca:	8b 45 08             	mov    0x8(%ebp),%eax
801024cd:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801024d4:	89 c2                	mov    %eax,%edx
801024d6:	ec                   	in     (%dx),%al
801024d7:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801024da:	8a 45 ff             	mov    -0x1(%ebp),%al
}
801024dd:	c9                   	leave  
801024de:	c3                   	ret    

801024df <insl>:

static inline void
insl(int port, void *addr, int cnt)
{
801024df:	55                   	push   %ebp
801024e0:	89 e5                	mov    %esp,%ebp
801024e2:	57                   	push   %edi
801024e3:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
801024e4:	8b 55 08             	mov    0x8(%ebp),%edx
801024e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801024ea:	8b 45 10             	mov    0x10(%ebp),%eax
801024ed:	89 cb                	mov    %ecx,%ebx
801024ef:	89 df                	mov    %ebx,%edi
801024f1:	89 c1                	mov    %eax,%ecx
801024f3:	fc                   	cld    
801024f4:	f3 6d                	rep insl (%dx),%es:(%edi)
801024f6:	89 c8                	mov    %ecx,%eax
801024f8:	89 fb                	mov    %edi,%ebx
801024fa:	89 5d 0c             	mov    %ebx,0xc(%ebp)
801024fd:	89 45 10             	mov    %eax,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "memory", "cc");
}
80102500:	5b                   	pop    %ebx
80102501:	5f                   	pop    %edi
80102502:	5d                   	pop    %ebp
80102503:	c3                   	ret    

80102504 <outb>:

static inline void
outb(ushort port, uchar data)
{
80102504:	55                   	push   %ebp
80102505:	89 e5                	mov    %esp,%ebp
80102507:	83 ec 08             	sub    $0x8,%esp
8010250a:	8b 45 08             	mov    0x8(%ebp),%eax
8010250d:	8b 55 0c             	mov    0xc(%ebp),%edx
80102510:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80102514:	88 55 f8             	mov    %dl,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102517:	8a 45 f8             	mov    -0x8(%ebp),%al
8010251a:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010251d:	ee                   	out    %al,(%dx)
}
8010251e:	c9                   	leave  
8010251f:	c3                   	ret    

80102520 <outsl>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void
outsl(int port, const void *addr, int cnt)
{
80102520:	55                   	push   %ebp
80102521:	89 e5                	mov    %esp,%ebp
80102523:	56                   	push   %esi
80102524:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
80102525:	8b 55 08             	mov    0x8(%ebp),%edx
80102528:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010252b:	8b 45 10             	mov    0x10(%ebp),%eax
8010252e:	89 cb                	mov    %ecx,%ebx
80102530:	89 de                	mov    %ebx,%esi
80102532:	89 c1                	mov    %eax,%ecx
80102534:	fc                   	cld    
80102535:	f3 6f                	rep outsl %ds:(%esi),(%dx)
80102537:	89 c8                	mov    %ecx,%eax
80102539:	89 f3                	mov    %esi,%ebx
8010253b:	89 5d 0c             	mov    %ebx,0xc(%ebp)
8010253e:	89 45 10             	mov    %eax,0x10(%ebp)
               "=S" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "cc");
}
80102541:	5b                   	pop    %ebx
80102542:	5e                   	pop    %esi
80102543:	5d                   	pop    %ebp
80102544:	c3                   	ret    

80102545 <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
80102545:	55                   	push   %ebp
80102546:	89 e5                	mov    %esp,%ebp
80102548:	83 ec 10             	sub    $0x10,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
8010254b:	90                   	nop
8010254c:	68 f7 01 00 00       	push   $0x1f7
80102551:	e8 6e ff ff ff       	call   801024c4 <inb>
80102556:	83 c4 04             	add    $0x4,%esp
80102559:	0f b6 c0             	movzbl %al,%eax
8010255c:	89 45 fc             	mov    %eax,-0x4(%ebp)
8010255f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102562:	25 c0 00 00 00       	and    $0xc0,%eax
80102567:	83 f8 40             	cmp    $0x40,%eax
8010256a:	75 e0                	jne    8010254c <idewait+0x7>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010256c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102570:	74 11                	je     80102583 <idewait+0x3e>
80102572:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102575:	83 e0 21             	and    $0x21,%eax
80102578:	85 c0                	test   %eax,%eax
8010257a:	74 07                	je     80102583 <idewait+0x3e>
    return -1;
8010257c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102581:	eb 05                	jmp    80102588 <idewait+0x43>
  return 0;
80102583:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102588:	c9                   	leave  
80102589:	c3                   	ret    

8010258a <ideinit>:

void
ideinit(void)
{
8010258a:	55                   	push   %ebp
8010258b:	89 e5                	mov    %esp,%ebp
8010258d:	83 ec 18             	sub    $0x18,%esp
  int i;
  
  initlock(&idelock, "ide");
80102590:	83 ec 08             	sub    $0x8,%esp
80102593:	68 62 85 10 80       	push   $0x80108562
80102598:	68 00 b6 10 80       	push   $0x8010b600
8010259d:	e8 85 29 00 00       	call   80104f27 <initlock>
801025a2:	83 c4 10             	add    $0x10,%esp
  picenable(IRQ_IDE);
801025a5:	83 ec 0c             	sub    $0xc,%esp
801025a8:	6a 0e                	push   $0xe
801025aa:	e8 cc 18 00 00       	call   80103e7b <picenable>
801025af:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
801025b2:	a1 40 29 11 80       	mov    0x80112940,%eax
801025b7:	48                   	dec    %eax
801025b8:	83 ec 08             	sub    $0x8,%esp
801025bb:	50                   	push   %eax
801025bc:	6a 0e                	push   $0xe
801025be:	e8 67 04 00 00       	call   80102a2a <ioapicenable>
801025c3:	83 c4 10             	add    $0x10,%esp
  idewait(0);
801025c6:	83 ec 0c             	sub    $0xc,%esp
801025c9:	6a 00                	push   $0x0
801025cb:	e8 75 ff ff ff       	call   80102545 <idewait>
801025d0:	83 c4 10             	add    $0x10,%esp
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
801025d3:	83 ec 08             	sub    $0x8,%esp
801025d6:	68 f0 00 00 00       	push   $0xf0
801025db:	68 f6 01 00 00       	push   $0x1f6
801025e0:	e8 1f ff ff ff       	call   80102504 <outb>
801025e5:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<1000; i++){
801025e8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801025ef:	eb 23                	jmp    80102614 <ideinit+0x8a>
    if(inb(0x1f7) != 0){
801025f1:	83 ec 0c             	sub    $0xc,%esp
801025f4:	68 f7 01 00 00       	push   $0x1f7
801025f9:	e8 c6 fe ff ff       	call   801024c4 <inb>
801025fe:	83 c4 10             	add    $0x10,%esp
80102601:	84 c0                	test   %al,%al
80102603:	74 0c                	je     80102611 <ideinit+0x87>
      havedisk1 = 1;
80102605:	c7 05 38 b6 10 80 01 	movl   $0x1,0x8010b638
8010260c:	00 00 00 
      break;
8010260f:	eb 0c                	jmp    8010261d <ideinit+0x93>
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102611:	ff 45 f4             	incl   -0xc(%ebp)
80102614:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
8010261b:	7e d4                	jle    801025f1 <ideinit+0x67>
      break;
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
8010261d:	83 ec 08             	sub    $0x8,%esp
80102620:	68 e0 00 00 00       	push   $0xe0
80102625:	68 f6 01 00 00       	push   $0x1f6
8010262a:	e8 d5 fe ff ff       	call   80102504 <outb>
8010262f:	83 c4 10             	add    $0x10,%esp
}
80102632:	c9                   	leave  
80102633:	c3                   	ret    

80102634 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102634:	55                   	push   %ebp
80102635:	89 e5                	mov    %esp,%ebp
80102637:	83 ec 18             	sub    $0x18,%esp
  if(b == 0)
8010263a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010263e:	75 0d                	jne    8010264d <idestart+0x19>
    panic("idestart");
80102640:	83 ec 0c             	sub    $0xc,%esp
80102643:	68 66 85 10 80       	push   $0x80108566
80102648:	e8 01 df ff ff       	call   8010054e <panic>
  if(b->blockno >= FSSIZE)
8010264d:	8b 45 08             	mov    0x8(%ebp),%eax
80102650:	8b 40 08             	mov    0x8(%eax),%eax
80102653:	3d e7 03 00 00       	cmp    $0x3e7,%eax
80102658:	76 0d                	jbe    80102667 <idestart+0x33>
    panic("incorrect blockno");
8010265a:	83 ec 0c             	sub    $0xc,%esp
8010265d:	68 6f 85 10 80       	push   $0x8010856f
80102662:	e8 e7 de ff ff       	call   8010054e <panic>
  int sector_per_block =  BSIZE/SECTOR_SIZE;
80102667:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  int sector = b->blockno * sector_per_block;
8010266e:	8b 45 08             	mov    0x8(%ebp),%eax
80102671:	8b 50 08             	mov    0x8(%eax),%edx
80102674:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102677:	0f af c2             	imul   %edx,%eax
8010267a:	89 45 f0             	mov    %eax,-0x10(%ebp)

  if (sector_per_block > 7) panic("idestart");
8010267d:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
80102681:	7e 0d                	jle    80102690 <idestart+0x5c>
80102683:	83 ec 0c             	sub    $0xc,%esp
80102686:	68 66 85 10 80       	push   $0x80108566
8010268b:	e8 be de ff ff       	call   8010054e <panic>
  
  idewait(0);
80102690:	83 ec 0c             	sub    $0xc,%esp
80102693:	6a 00                	push   $0x0
80102695:	e8 ab fe ff ff       	call   80102545 <idewait>
8010269a:	83 c4 10             	add    $0x10,%esp
  outb(0x3f6, 0);  // generate interrupt
8010269d:	83 ec 08             	sub    $0x8,%esp
801026a0:	6a 00                	push   $0x0
801026a2:	68 f6 03 00 00       	push   $0x3f6
801026a7:	e8 58 fe ff ff       	call   80102504 <outb>
801026ac:	83 c4 10             	add    $0x10,%esp
  outb(0x1f2, sector_per_block);  // number of sectors
801026af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801026b2:	0f b6 c0             	movzbl %al,%eax
801026b5:	83 ec 08             	sub    $0x8,%esp
801026b8:	50                   	push   %eax
801026b9:	68 f2 01 00 00       	push   $0x1f2
801026be:	e8 41 fe ff ff       	call   80102504 <outb>
801026c3:	83 c4 10             	add    $0x10,%esp
  outb(0x1f3, sector & 0xff);
801026c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801026c9:	0f b6 c0             	movzbl %al,%eax
801026cc:	83 ec 08             	sub    $0x8,%esp
801026cf:	50                   	push   %eax
801026d0:	68 f3 01 00 00       	push   $0x1f3
801026d5:	e8 2a fe ff ff       	call   80102504 <outb>
801026da:	83 c4 10             	add    $0x10,%esp
  outb(0x1f4, (sector >> 8) & 0xff);
801026dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801026e0:	c1 f8 08             	sar    $0x8,%eax
801026e3:	0f b6 c0             	movzbl %al,%eax
801026e6:	83 ec 08             	sub    $0x8,%esp
801026e9:	50                   	push   %eax
801026ea:	68 f4 01 00 00       	push   $0x1f4
801026ef:	e8 10 fe ff ff       	call   80102504 <outb>
801026f4:	83 c4 10             	add    $0x10,%esp
  outb(0x1f5, (sector >> 16) & 0xff);
801026f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801026fa:	c1 f8 10             	sar    $0x10,%eax
801026fd:	0f b6 c0             	movzbl %al,%eax
80102700:	83 ec 08             	sub    $0x8,%esp
80102703:	50                   	push   %eax
80102704:	68 f5 01 00 00       	push   $0x1f5
80102709:	e8 f6 fd ff ff       	call   80102504 <outb>
8010270e:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102711:	8b 45 08             	mov    0x8(%ebp),%eax
80102714:	8b 40 04             	mov    0x4(%eax),%eax
80102717:	83 e0 01             	and    $0x1,%eax
8010271a:	c1 e0 04             	shl    $0x4,%eax
8010271d:	88 c2                	mov    %al,%dl
8010271f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102722:	c1 f8 18             	sar    $0x18,%eax
80102725:	83 e0 0f             	and    $0xf,%eax
80102728:	09 d0                	or     %edx,%eax
8010272a:	83 c8 e0             	or     $0xffffffe0,%eax
8010272d:	0f b6 c0             	movzbl %al,%eax
80102730:	83 ec 08             	sub    $0x8,%esp
80102733:	50                   	push   %eax
80102734:	68 f6 01 00 00       	push   $0x1f6
80102739:	e8 c6 fd ff ff       	call   80102504 <outb>
8010273e:	83 c4 10             	add    $0x10,%esp
  if(b->flags & B_DIRTY){
80102741:	8b 45 08             	mov    0x8(%ebp),%eax
80102744:	8b 00                	mov    (%eax),%eax
80102746:	83 e0 04             	and    $0x4,%eax
80102749:	85 c0                	test   %eax,%eax
8010274b:	74 30                	je     8010277d <idestart+0x149>
    outb(0x1f7, IDE_CMD_WRITE);
8010274d:	83 ec 08             	sub    $0x8,%esp
80102750:	6a 30                	push   $0x30
80102752:	68 f7 01 00 00       	push   $0x1f7
80102757:	e8 a8 fd ff ff       	call   80102504 <outb>
8010275c:	83 c4 10             	add    $0x10,%esp
    outsl(0x1f0, b->data, BSIZE/4);
8010275f:	8b 45 08             	mov    0x8(%ebp),%eax
80102762:	83 c0 18             	add    $0x18,%eax
80102765:	83 ec 04             	sub    $0x4,%esp
80102768:	68 80 00 00 00       	push   $0x80
8010276d:	50                   	push   %eax
8010276e:	68 f0 01 00 00       	push   $0x1f0
80102773:	e8 a8 fd ff ff       	call   80102520 <outsl>
80102778:	83 c4 10             	add    $0x10,%esp
8010277b:	eb 12                	jmp    8010278f <idestart+0x15b>
  } else {
    outb(0x1f7, IDE_CMD_READ);
8010277d:	83 ec 08             	sub    $0x8,%esp
80102780:	6a 20                	push   $0x20
80102782:	68 f7 01 00 00       	push   $0x1f7
80102787:	e8 78 fd ff ff       	call   80102504 <outb>
8010278c:	83 c4 10             	add    $0x10,%esp
  }
}
8010278f:	c9                   	leave  
80102790:	c3                   	ret    

80102791 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102791:	55                   	push   %ebp
80102792:	89 e5                	mov    %esp,%ebp
80102794:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102797:	83 ec 0c             	sub    $0xc,%esp
8010279a:	68 00 b6 10 80       	push   $0x8010b600
8010279f:	e8 a4 27 00 00       	call   80104f48 <acquire>
801027a4:	83 c4 10             	add    $0x10,%esp
  if((b = idequeue) == 0){
801027a7:	a1 34 b6 10 80       	mov    0x8010b634,%eax
801027ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
801027af:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801027b3:	75 15                	jne    801027ca <ideintr+0x39>
    release(&idelock);
801027b5:	83 ec 0c             	sub    $0xc,%esp
801027b8:	68 00 b6 10 80       	push   $0x8010b600
801027bd:	e8 ec 27 00 00       	call   80104fae <release>
801027c2:	83 c4 10             	add    $0x10,%esp
    // cprintf("spurious IDE interrupt\n");
    return;
801027c5:	e9 9a 00 00 00       	jmp    80102864 <ideintr+0xd3>
  }
  idequeue = b->qnext;
801027ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027cd:	8b 40 14             	mov    0x14(%eax),%eax
801027d0:	a3 34 b6 10 80       	mov    %eax,0x8010b634

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801027d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027d8:	8b 00                	mov    (%eax),%eax
801027da:	83 e0 04             	and    $0x4,%eax
801027dd:	85 c0                	test   %eax,%eax
801027df:	75 2d                	jne    8010280e <ideintr+0x7d>
801027e1:	83 ec 0c             	sub    $0xc,%esp
801027e4:	6a 01                	push   $0x1
801027e6:	e8 5a fd ff ff       	call   80102545 <idewait>
801027eb:	83 c4 10             	add    $0x10,%esp
801027ee:	85 c0                	test   %eax,%eax
801027f0:	78 1c                	js     8010280e <ideintr+0x7d>
    insl(0x1f0, b->data, BSIZE/4);
801027f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027f5:	83 c0 18             	add    $0x18,%eax
801027f8:	83 ec 04             	sub    $0x4,%esp
801027fb:	68 80 00 00 00       	push   $0x80
80102800:	50                   	push   %eax
80102801:	68 f0 01 00 00       	push   $0x1f0
80102806:	e8 d4 fc ff ff       	call   801024df <insl>
8010280b:	83 c4 10             	add    $0x10,%esp
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010280e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102811:	8b 00                	mov    (%eax),%eax
80102813:	83 c8 02             	or     $0x2,%eax
80102816:	89 c2                	mov    %eax,%edx
80102818:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010281b:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
8010281d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102820:	8b 00                	mov    (%eax),%eax
80102822:	83 e0 fb             	and    $0xfffffffb,%eax
80102825:	89 c2                	mov    %eax,%edx
80102827:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010282a:	89 10                	mov    %edx,(%eax)
  wakeup(b);
8010282c:	83 ec 0c             	sub    $0xc,%esp
8010282f:	ff 75 f4             	pushl  -0xc(%ebp)
80102832:	e8 0d 25 00 00       	call   80104d44 <wakeup>
80102837:	83 c4 10             	add    $0x10,%esp
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
8010283a:	a1 34 b6 10 80       	mov    0x8010b634,%eax
8010283f:	85 c0                	test   %eax,%eax
80102841:	74 11                	je     80102854 <ideintr+0xc3>
    idestart(idequeue);
80102843:	a1 34 b6 10 80       	mov    0x8010b634,%eax
80102848:	83 ec 0c             	sub    $0xc,%esp
8010284b:	50                   	push   %eax
8010284c:	e8 e3 fd ff ff       	call   80102634 <idestart>
80102851:	83 c4 10             	add    $0x10,%esp

  release(&idelock);
80102854:	83 ec 0c             	sub    $0xc,%esp
80102857:	68 00 b6 10 80       	push   $0x8010b600
8010285c:	e8 4d 27 00 00       	call   80104fae <release>
80102861:	83 c4 10             	add    $0x10,%esp
}
80102864:	c9                   	leave  
80102865:	c3                   	ret    

80102866 <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102866:	55                   	push   %ebp
80102867:	89 e5                	mov    %esp,%ebp
80102869:	83 ec 18             	sub    $0x18,%esp
  struct buf **pp;

  if(!(b->flags & B_BUSY))
8010286c:	8b 45 08             	mov    0x8(%ebp),%eax
8010286f:	8b 00                	mov    (%eax),%eax
80102871:	83 e0 01             	and    $0x1,%eax
80102874:	85 c0                	test   %eax,%eax
80102876:	75 0d                	jne    80102885 <iderw+0x1f>
    panic("iderw: buf not busy");
80102878:	83 ec 0c             	sub    $0xc,%esp
8010287b:	68 81 85 10 80       	push   $0x80108581
80102880:	e8 c9 dc ff ff       	call   8010054e <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102885:	8b 45 08             	mov    0x8(%ebp),%eax
80102888:	8b 00                	mov    (%eax),%eax
8010288a:	83 e0 06             	and    $0x6,%eax
8010288d:	83 f8 02             	cmp    $0x2,%eax
80102890:	75 0d                	jne    8010289f <iderw+0x39>
    panic("iderw: nothing to do");
80102892:	83 ec 0c             	sub    $0xc,%esp
80102895:	68 95 85 10 80       	push   $0x80108595
8010289a:	e8 af dc ff ff       	call   8010054e <panic>
  if(b->dev != 0 && !havedisk1)
8010289f:	8b 45 08             	mov    0x8(%ebp),%eax
801028a2:	8b 40 04             	mov    0x4(%eax),%eax
801028a5:	85 c0                	test   %eax,%eax
801028a7:	74 16                	je     801028bf <iderw+0x59>
801028a9:	a1 38 b6 10 80       	mov    0x8010b638,%eax
801028ae:	85 c0                	test   %eax,%eax
801028b0:	75 0d                	jne    801028bf <iderw+0x59>
    panic("iderw: ide disk 1 not present");
801028b2:	83 ec 0c             	sub    $0xc,%esp
801028b5:	68 aa 85 10 80       	push   $0x801085aa
801028ba:	e8 8f dc ff ff       	call   8010054e <panic>

  acquire(&idelock);  //DOC:acquire-lock
801028bf:	83 ec 0c             	sub    $0xc,%esp
801028c2:	68 00 b6 10 80       	push   $0x8010b600
801028c7:	e8 7c 26 00 00       	call   80104f48 <acquire>
801028cc:	83 c4 10             	add    $0x10,%esp

  // Append b to idequeue.
  b->qnext = 0;
801028cf:	8b 45 08             	mov    0x8(%ebp),%eax
801028d2:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801028d9:	c7 45 f4 34 b6 10 80 	movl   $0x8010b634,-0xc(%ebp)
801028e0:	eb 0b                	jmp    801028ed <iderw+0x87>
801028e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028e5:	8b 00                	mov    (%eax),%eax
801028e7:	83 c0 14             	add    $0x14,%eax
801028ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
801028ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028f0:	8b 00                	mov    (%eax),%eax
801028f2:	85 c0                	test   %eax,%eax
801028f4:	75 ec                	jne    801028e2 <iderw+0x7c>
    ;
  *pp = b;
801028f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028f9:	8b 55 08             	mov    0x8(%ebp),%edx
801028fc:	89 10                	mov    %edx,(%eax)
  
  // Start disk if necessary.
  if(idequeue == b)
801028fe:	a1 34 b6 10 80       	mov    0x8010b634,%eax
80102903:	3b 45 08             	cmp    0x8(%ebp),%eax
80102906:	75 0e                	jne    80102916 <iderw+0xb0>
    idestart(b);
80102908:	83 ec 0c             	sub    $0xc,%esp
8010290b:	ff 75 08             	pushl  0x8(%ebp)
8010290e:	e8 21 fd ff ff       	call   80102634 <idestart>
80102913:	83 c4 10             	add    $0x10,%esp
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102916:	eb 13                	jmp    8010292b <iderw+0xc5>
    sleep(b, &idelock);
80102918:	83 ec 08             	sub    $0x8,%esp
8010291b:	68 00 b6 10 80       	push   $0x8010b600
80102920:	ff 75 08             	pushl  0x8(%ebp)
80102923:	e8 33 23 00 00       	call   80104c5b <sleep>
80102928:	83 c4 10             	add    $0x10,%esp
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010292b:	8b 45 08             	mov    0x8(%ebp),%eax
8010292e:	8b 00                	mov    (%eax),%eax
80102930:	83 e0 06             	and    $0x6,%eax
80102933:	83 f8 02             	cmp    $0x2,%eax
80102936:	75 e0                	jne    80102918 <iderw+0xb2>
    sleep(b, &idelock);
  }

  release(&idelock);
80102938:	83 ec 0c             	sub    $0xc,%esp
8010293b:	68 00 b6 10 80       	push   $0x8010b600
80102940:	e8 69 26 00 00       	call   80104fae <release>
80102945:	83 c4 10             	add    $0x10,%esp
}
80102948:	c9                   	leave  
80102949:	c3                   	ret    

8010294a <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
8010294a:	55                   	push   %ebp
8010294b:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
8010294d:	a1 14 22 11 80       	mov    0x80112214,%eax
80102952:	8b 55 08             	mov    0x8(%ebp),%edx
80102955:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
80102957:	a1 14 22 11 80       	mov    0x80112214,%eax
8010295c:	8b 40 10             	mov    0x10(%eax),%eax
}
8010295f:	5d                   	pop    %ebp
80102960:	c3                   	ret    

80102961 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
80102961:	55                   	push   %ebp
80102962:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102964:	a1 14 22 11 80       	mov    0x80112214,%eax
80102969:	8b 55 08             	mov    0x8(%ebp),%edx
8010296c:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
8010296e:	a1 14 22 11 80       	mov    0x80112214,%eax
80102973:	8b 55 0c             	mov    0xc(%ebp),%edx
80102976:	89 50 10             	mov    %edx,0x10(%eax)
}
80102979:	5d                   	pop    %ebp
8010297a:	c3                   	ret    

8010297b <ioapicinit>:

void
ioapicinit(void)
{
8010297b:	55                   	push   %ebp
8010297c:	89 e5                	mov    %esp,%ebp
8010297e:	83 ec 18             	sub    $0x18,%esp
  int i, id, maxintr;

  if(!ismp)
80102981:	a1 44 23 11 80       	mov    0x80112344,%eax
80102986:	85 c0                	test   %eax,%eax
80102988:	75 05                	jne    8010298f <ioapicinit+0x14>
    return;
8010298a:	e9 99 00 00 00       	jmp    80102a28 <ioapicinit+0xad>

  ioapic = (volatile struct ioapic*)IOAPIC;
8010298f:	c7 05 14 22 11 80 00 	movl   $0xfec00000,0x80112214
80102996:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102999:	6a 01                	push   $0x1
8010299b:	e8 aa ff ff ff       	call   8010294a <ioapicread>
801029a0:	83 c4 04             	add    $0x4,%esp
801029a3:	c1 e8 10             	shr    $0x10,%eax
801029a6:	25 ff 00 00 00       	and    $0xff,%eax
801029ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
801029ae:	6a 00                	push   $0x0
801029b0:	e8 95 ff ff ff       	call   8010294a <ioapicread>
801029b5:	83 c4 04             	add    $0x4,%esp
801029b8:	c1 e8 18             	shr    $0x18,%eax
801029bb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
801029be:	a0 40 23 11 80       	mov    0x80112340,%al
801029c3:	0f b6 c0             	movzbl %al,%eax
801029c6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
801029c9:	74 10                	je     801029db <ioapicinit+0x60>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801029cb:	83 ec 0c             	sub    $0xc,%esp
801029ce:	68 c8 85 10 80       	push   $0x801085c8
801029d3:	e8 e0 d9 ff ff       	call   801003b8 <cprintf>
801029d8:	83 c4 10             	add    $0x10,%esp

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801029db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801029e2:	eb 3c                	jmp    80102a20 <ioapicinit+0xa5>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801029e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029e7:	83 c0 20             	add    $0x20,%eax
801029ea:	0d 00 00 01 00       	or     $0x10000,%eax
801029ef:	89 c2                	mov    %eax,%edx
801029f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029f4:	83 c0 08             	add    $0x8,%eax
801029f7:	01 c0                	add    %eax,%eax
801029f9:	83 ec 08             	sub    $0x8,%esp
801029fc:	52                   	push   %edx
801029fd:	50                   	push   %eax
801029fe:	e8 5e ff ff ff       	call   80102961 <ioapicwrite>
80102a03:	83 c4 10             	add    $0x10,%esp
    ioapicwrite(REG_TABLE+2*i+1, 0);
80102a06:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a09:	83 c0 08             	add    $0x8,%eax
80102a0c:	01 c0                	add    %eax,%eax
80102a0e:	40                   	inc    %eax
80102a0f:	83 ec 08             	sub    $0x8,%esp
80102a12:	6a 00                	push   $0x0
80102a14:	50                   	push   %eax
80102a15:	e8 47 ff ff ff       	call   80102961 <ioapicwrite>
80102a1a:	83 c4 10             	add    $0x10,%esp
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102a1d:	ff 45 f4             	incl   -0xc(%ebp)
80102a20:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a23:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102a26:	7e bc                	jle    801029e4 <ioapicinit+0x69>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102a28:	c9                   	leave  
80102a29:	c3                   	ret    

80102a2a <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102a2a:	55                   	push   %ebp
80102a2b:	89 e5                	mov    %esp,%ebp
  if(!ismp)
80102a2d:	a1 44 23 11 80       	mov    0x80112344,%eax
80102a32:	85 c0                	test   %eax,%eax
80102a34:	75 02                	jne    80102a38 <ioapicenable+0xe>
    return;
80102a36:	eb 33                	jmp    80102a6b <ioapicenable+0x41>

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102a38:	8b 45 08             	mov    0x8(%ebp),%eax
80102a3b:	83 c0 20             	add    $0x20,%eax
80102a3e:	89 c2                	mov    %eax,%edx
80102a40:	8b 45 08             	mov    0x8(%ebp),%eax
80102a43:	83 c0 08             	add    $0x8,%eax
80102a46:	01 c0                	add    %eax,%eax
80102a48:	52                   	push   %edx
80102a49:	50                   	push   %eax
80102a4a:	e8 12 ff ff ff       	call   80102961 <ioapicwrite>
80102a4f:	83 c4 08             	add    $0x8,%esp
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102a52:	8b 45 0c             	mov    0xc(%ebp),%eax
80102a55:	c1 e0 18             	shl    $0x18,%eax
80102a58:	8b 55 08             	mov    0x8(%ebp),%edx
80102a5b:	83 c2 08             	add    $0x8,%edx
80102a5e:	01 d2                	add    %edx,%edx
80102a60:	42                   	inc    %edx
80102a61:	50                   	push   %eax
80102a62:	52                   	push   %edx
80102a63:	e8 f9 fe ff ff       	call   80102961 <ioapicwrite>
80102a68:	83 c4 08             	add    $0x8,%esp
}
80102a6b:	c9                   	leave  
80102a6c:	c3                   	ret    

80102a6d <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80102a6d:	55                   	push   %ebp
80102a6e:	89 e5                	mov    %esp,%ebp
80102a70:	8b 45 08             	mov    0x8(%ebp),%eax
80102a73:	05 00 00 00 80       	add    $0x80000000,%eax
80102a78:	5d                   	pop    %ebp
80102a79:	c3                   	ret    

80102a7a <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102a7a:	55                   	push   %ebp
80102a7b:	89 e5                	mov    %esp,%ebp
80102a7d:	83 ec 08             	sub    $0x8,%esp
  initlock(&kmem.lock, "kmem");
80102a80:	83 ec 08             	sub    $0x8,%esp
80102a83:	68 fa 85 10 80       	push   $0x801085fa
80102a88:	68 20 22 11 80       	push   $0x80112220
80102a8d:	e8 95 24 00 00       	call   80104f27 <initlock>
80102a92:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102a95:	c7 05 54 22 11 80 00 	movl   $0x0,0x80112254
80102a9c:	00 00 00 
  freerange(vstart, vend);
80102a9f:	83 ec 08             	sub    $0x8,%esp
80102aa2:	ff 75 0c             	pushl  0xc(%ebp)
80102aa5:	ff 75 08             	pushl  0x8(%ebp)
80102aa8:	e8 28 00 00 00       	call   80102ad5 <freerange>
80102aad:	83 c4 10             	add    $0x10,%esp
}
80102ab0:	c9                   	leave  
80102ab1:	c3                   	ret    

80102ab2 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102ab2:	55                   	push   %ebp
80102ab3:	89 e5                	mov    %esp,%ebp
80102ab5:	83 ec 08             	sub    $0x8,%esp
  freerange(vstart, vend);
80102ab8:	83 ec 08             	sub    $0x8,%esp
80102abb:	ff 75 0c             	pushl  0xc(%ebp)
80102abe:	ff 75 08             	pushl  0x8(%ebp)
80102ac1:	e8 0f 00 00 00       	call   80102ad5 <freerange>
80102ac6:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 1;
80102ac9:	c7 05 54 22 11 80 01 	movl   $0x1,0x80112254
80102ad0:	00 00 00 
}
80102ad3:	c9                   	leave  
80102ad4:	c3                   	ret    

80102ad5 <freerange>:

void
freerange(void *vstart, void *vend)
{
80102ad5:	55                   	push   %ebp
80102ad6:	89 e5                	mov    %esp,%ebp
80102ad8:	83 ec 18             	sub    $0x18,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102adb:	8b 45 08             	mov    0x8(%ebp),%eax
80102ade:	05 ff 0f 00 00       	add    $0xfff,%eax
80102ae3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102ae8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102aeb:	eb 15                	jmp    80102b02 <freerange+0x2d>
    kfree(p);
80102aed:	83 ec 0c             	sub    $0xc,%esp
80102af0:	ff 75 f4             	pushl  -0xc(%ebp)
80102af3:	e8 19 00 00 00       	call   80102b11 <kfree>
80102af8:	83 c4 10             	add    $0x10,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102afb:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102b02:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b05:	05 00 10 00 00       	add    $0x1000,%eax
80102b0a:	3b 45 0c             	cmp    0xc(%ebp),%eax
80102b0d:	76 de                	jbe    80102aed <freerange+0x18>
    kfree(p);
}
80102b0f:	c9                   	leave  
80102b10:	c3                   	ret    

80102b11 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102b11:	55                   	push   %ebp
80102b12:	89 e5                	mov    %esp,%ebp
80102b14:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || v2p(v) >= PHYSTOP)
80102b17:	8b 45 08             	mov    0x8(%ebp),%eax
80102b1a:	25 ff 0f 00 00       	and    $0xfff,%eax
80102b1f:	85 c0                	test   %eax,%eax
80102b21:	75 1b                	jne    80102b3e <kfree+0x2d>
80102b23:	81 7d 08 3c 51 11 80 	cmpl   $0x8011513c,0x8(%ebp)
80102b2a:	72 12                	jb     80102b3e <kfree+0x2d>
80102b2c:	ff 75 08             	pushl  0x8(%ebp)
80102b2f:	e8 39 ff ff ff       	call   80102a6d <v2p>
80102b34:	83 c4 04             	add    $0x4,%esp
80102b37:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102b3c:	76 0d                	jbe    80102b4b <kfree+0x3a>
    panic("kfree");
80102b3e:	83 ec 0c             	sub    $0xc,%esp
80102b41:	68 ff 85 10 80       	push   $0x801085ff
80102b46:	e8 03 da ff ff       	call   8010054e <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102b4b:	83 ec 04             	sub    $0x4,%esp
80102b4e:	68 00 10 00 00       	push   $0x1000
80102b53:	6a 01                	push   $0x1
80102b55:	ff 75 08             	pushl  0x8(%ebp)
80102b58:	e8 43 26 00 00       	call   801051a0 <memset>
80102b5d:	83 c4 10             	add    $0x10,%esp

  if(kmem.use_lock)
80102b60:	a1 54 22 11 80       	mov    0x80112254,%eax
80102b65:	85 c0                	test   %eax,%eax
80102b67:	74 10                	je     80102b79 <kfree+0x68>
    acquire(&kmem.lock);
80102b69:	83 ec 0c             	sub    $0xc,%esp
80102b6c:	68 20 22 11 80       	push   $0x80112220
80102b71:	e8 d2 23 00 00       	call   80104f48 <acquire>
80102b76:	83 c4 10             	add    $0x10,%esp
  r = (struct run*)v;
80102b79:	8b 45 08             	mov    0x8(%ebp),%eax
80102b7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102b7f:	8b 15 58 22 11 80    	mov    0x80112258,%edx
80102b85:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b88:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102b8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b8d:	a3 58 22 11 80       	mov    %eax,0x80112258
  if(kmem.use_lock)
80102b92:	a1 54 22 11 80       	mov    0x80112254,%eax
80102b97:	85 c0                	test   %eax,%eax
80102b99:	74 10                	je     80102bab <kfree+0x9a>
    release(&kmem.lock);
80102b9b:	83 ec 0c             	sub    $0xc,%esp
80102b9e:	68 20 22 11 80       	push   $0x80112220
80102ba3:	e8 06 24 00 00       	call   80104fae <release>
80102ba8:	83 c4 10             	add    $0x10,%esp
}
80102bab:	c9                   	leave  
80102bac:	c3                   	ret    

80102bad <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102bad:	55                   	push   %ebp
80102bae:	89 e5                	mov    %esp,%ebp
80102bb0:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
80102bb3:	a1 54 22 11 80       	mov    0x80112254,%eax
80102bb8:	85 c0                	test   %eax,%eax
80102bba:	74 10                	je     80102bcc <kalloc+0x1f>
    acquire(&kmem.lock);
80102bbc:	83 ec 0c             	sub    $0xc,%esp
80102bbf:	68 20 22 11 80       	push   $0x80112220
80102bc4:	e8 7f 23 00 00       	call   80104f48 <acquire>
80102bc9:	83 c4 10             	add    $0x10,%esp
  r = kmem.freelist;
80102bcc:	a1 58 22 11 80       	mov    0x80112258,%eax
80102bd1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80102bd4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102bd8:	74 0a                	je     80102be4 <kalloc+0x37>
    kmem.freelist = r->next;
80102bda:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102bdd:	8b 00                	mov    (%eax),%eax
80102bdf:	a3 58 22 11 80       	mov    %eax,0x80112258
  if(kmem.use_lock)
80102be4:	a1 54 22 11 80       	mov    0x80112254,%eax
80102be9:	85 c0                	test   %eax,%eax
80102beb:	74 10                	je     80102bfd <kalloc+0x50>
    release(&kmem.lock);
80102bed:	83 ec 0c             	sub    $0xc,%esp
80102bf0:	68 20 22 11 80       	push   $0x80112220
80102bf5:	e8 b4 23 00 00       	call   80104fae <release>
80102bfa:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
80102bfd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102c00:	c9                   	leave  
80102c01:	c3                   	ret    

80102c02 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102c02:	55                   	push   %ebp
80102c03:	89 e5                	mov    %esp,%ebp
80102c05:	83 ec 14             	sub    $0x14,%esp
80102c08:	8b 45 08             	mov    0x8(%ebp),%eax
80102c0b:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c0f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102c12:	89 c2                	mov    %eax,%edx
80102c14:	ec                   	in     (%dx),%al
80102c15:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102c18:	8a 45 ff             	mov    -0x1(%ebp),%al
}
80102c1b:	c9                   	leave  
80102c1c:	c3                   	ret    

80102c1d <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102c1d:	55                   	push   %ebp
80102c1e:	89 e5                	mov    %esp,%ebp
80102c20:	83 ec 10             	sub    $0x10,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80102c23:	6a 64                	push   $0x64
80102c25:	e8 d8 ff ff ff       	call   80102c02 <inb>
80102c2a:	83 c4 04             	add    $0x4,%esp
80102c2d:	0f b6 c0             	movzbl %al,%eax
80102c30:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80102c33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c36:	83 e0 01             	and    $0x1,%eax
80102c39:	85 c0                	test   %eax,%eax
80102c3b:	75 0a                	jne    80102c47 <kbdgetc+0x2a>
    return -1;
80102c3d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102c42:	e9 1f 01 00 00       	jmp    80102d66 <kbdgetc+0x149>
  data = inb(KBDATAP);
80102c47:	6a 60                	push   $0x60
80102c49:	e8 b4 ff ff ff       	call   80102c02 <inb>
80102c4e:	83 c4 04             	add    $0x4,%esp
80102c51:	0f b6 c0             	movzbl %al,%eax
80102c54:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
80102c57:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102c5e:	75 17                	jne    80102c77 <kbdgetc+0x5a>
    shift |= E0ESC;
80102c60:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102c65:	83 c8 40             	or     $0x40,%eax
80102c68:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
    return 0;
80102c6d:	b8 00 00 00 00       	mov    $0x0,%eax
80102c72:	e9 ef 00 00 00       	jmp    80102d66 <kbdgetc+0x149>
  } else if(data & 0x80){
80102c77:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c7a:	25 80 00 00 00       	and    $0x80,%eax
80102c7f:	85 c0                	test   %eax,%eax
80102c81:	74 44                	je     80102cc7 <kbdgetc+0xaa>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102c83:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102c88:	83 e0 40             	and    $0x40,%eax
80102c8b:	85 c0                	test   %eax,%eax
80102c8d:	75 08                	jne    80102c97 <kbdgetc+0x7a>
80102c8f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c92:	83 e0 7f             	and    $0x7f,%eax
80102c95:	eb 03                	jmp    80102c9a <kbdgetc+0x7d>
80102c97:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c9a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102c9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102ca0:	05 20 90 10 80       	add    $0x80109020,%eax
80102ca5:	8a 00                	mov    (%eax),%al
80102ca7:	83 c8 40             	or     $0x40,%eax
80102caa:	0f b6 c0             	movzbl %al,%eax
80102cad:	f7 d0                	not    %eax
80102caf:	89 c2                	mov    %eax,%edx
80102cb1:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102cb6:	21 d0                	and    %edx,%eax
80102cb8:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
    return 0;
80102cbd:	b8 00 00 00 00       	mov    $0x0,%eax
80102cc2:	e9 9f 00 00 00       	jmp    80102d66 <kbdgetc+0x149>
  } else if(shift & E0ESC){
80102cc7:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102ccc:	83 e0 40             	and    $0x40,%eax
80102ccf:	85 c0                	test   %eax,%eax
80102cd1:	74 14                	je     80102ce7 <kbdgetc+0xca>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102cd3:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80102cda:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102cdf:	83 e0 bf             	and    $0xffffffbf,%eax
80102ce2:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  }

  shift |= shiftcode[data];
80102ce7:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102cea:	05 20 90 10 80       	add    $0x80109020,%eax
80102cef:	8a 00                	mov    (%eax),%al
80102cf1:	0f b6 d0             	movzbl %al,%edx
80102cf4:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102cf9:	09 d0                	or     %edx,%eax
80102cfb:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  shift ^= togglecode[data];
80102d00:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d03:	05 20 91 10 80       	add    $0x80109120,%eax
80102d08:	8a 00                	mov    (%eax),%al
80102d0a:	0f b6 d0             	movzbl %al,%edx
80102d0d:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d12:	31 d0                	xor    %edx,%eax
80102d14:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  c = charcode[shift & (CTL | SHIFT)][data];
80102d19:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d1e:	83 e0 03             	and    $0x3,%eax
80102d21:	8b 14 85 20 95 10 80 	mov    -0x7fef6ae0(,%eax,4),%edx
80102d28:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d2b:	01 d0                	add    %edx,%eax
80102d2d:	8a 00                	mov    (%eax),%al
80102d2f:	0f b6 c0             	movzbl %al,%eax
80102d32:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80102d35:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d3a:	83 e0 08             	and    $0x8,%eax
80102d3d:	85 c0                	test   %eax,%eax
80102d3f:	74 22                	je     80102d63 <kbdgetc+0x146>
    if('a' <= c && c <= 'z')
80102d41:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102d45:	76 0c                	jbe    80102d53 <kbdgetc+0x136>
80102d47:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102d4b:	77 06                	ja     80102d53 <kbdgetc+0x136>
      c += 'A' - 'a';
80102d4d:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80102d51:	eb 10                	jmp    80102d63 <kbdgetc+0x146>
    else if('A' <= c && c <= 'Z')
80102d53:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80102d57:	76 0a                	jbe    80102d63 <kbdgetc+0x146>
80102d59:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80102d5d:	77 04                	ja     80102d63 <kbdgetc+0x146>
      c += 'a' - 'A';
80102d5f:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  return c;
80102d63:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80102d66:	c9                   	leave  
80102d67:	c3                   	ret    

80102d68 <kbdintr>:

void
kbdintr(void)
{
80102d68:	55                   	push   %ebp
80102d69:	89 e5                	mov    %esp,%ebp
80102d6b:	83 ec 08             	sub    $0x8,%esp
  consoleintr(kbdgetc);
80102d6e:	83 ec 0c             	sub    $0xc,%esp
80102d71:	68 1d 2c 10 80       	push   $0x80102c1d
80102d76:	e8 4e da ff ff       	call   801007c9 <consoleintr>
80102d7b:	83 c4 10             	add    $0x10,%esp
}
80102d7e:	c9                   	leave  
80102d7f:	c3                   	ret    

80102d80 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102d80:	55                   	push   %ebp
80102d81:	89 e5                	mov    %esp,%ebp
80102d83:	83 ec 14             	sub    $0x14,%esp
80102d86:	8b 45 08             	mov    0x8(%ebp),%eax
80102d89:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d8d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102d90:	89 c2                	mov    %eax,%edx
80102d92:	ec                   	in     (%dx),%al
80102d93:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102d96:	8a 45 ff             	mov    -0x1(%ebp),%al
}
80102d99:	c9                   	leave  
80102d9a:	c3                   	ret    

80102d9b <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80102d9b:	55                   	push   %ebp
80102d9c:	89 e5                	mov    %esp,%ebp
80102d9e:	83 ec 08             	sub    $0x8,%esp
80102da1:	8b 45 08             	mov    0x8(%ebp),%eax
80102da4:	8b 55 0c             	mov    0xc(%ebp),%edx
80102da7:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80102dab:	88 55 f8             	mov    %dl,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102dae:	8a 45 f8             	mov    -0x8(%ebp),%al
80102db1:	8b 55 fc             	mov    -0x4(%ebp),%edx
80102db4:	ee                   	out    %al,(%dx)
}
80102db5:	c9                   	leave  
80102db6:	c3                   	ret    

80102db7 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80102db7:	55                   	push   %ebp
80102db8:	89 e5                	mov    %esp,%ebp
80102dba:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102dbd:	9c                   	pushf  
80102dbe:	58                   	pop    %eax
80102dbf:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80102dc2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80102dc5:	c9                   	leave  
80102dc6:	c3                   	ret    

80102dc7 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80102dc7:	55                   	push   %ebp
80102dc8:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80102dca:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102dcf:	8b 55 08             	mov    0x8(%ebp),%edx
80102dd2:	c1 e2 02             	shl    $0x2,%edx
80102dd5:	01 c2                	add    %eax,%edx
80102dd7:	8b 45 0c             	mov    0xc(%ebp),%eax
80102dda:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80102ddc:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102de1:	83 c0 20             	add    $0x20,%eax
80102de4:	8b 00                	mov    (%eax),%eax
}
80102de6:	5d                   	pop    %ebp
80102de7:	c3                   	ret    

80102de8 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
80102de8:	55                   	push   %ebp
80102de9:	89 e5                	mov    %esp,%ebp
  if(!lapic) 
80102deb:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102df0:	85 c0                	test   %eax,%eax
80102df2:	75 05                	jne    80102df9 <lapicinit+0x11>
    return;
80102df4:	e9 09 01 00 00       	jmp    80102f02 <lapicinit+0x11a>

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80102df9:	68 3f 01 00 00       	push   $0x13f
80102dfe:	6a 3c                	push   $0x3c
80102e00:	e8 c2 ff ff ff       	call   80102dc7 <lapicw>
80102e05:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80102e08:	6a 0b                	push   $0xb
80102e0a:	68 f8 00 00 00       	push   $0xf8
80102e0f:	e8 b3 ff ff ff       	call   80102dc7 <lapicw>
80102e14:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80102e17:	68 20 00 02 00       	push   $0x20020
80102e1c:	68 c8 00 00 00       	push   $0xc8
80102e21:	e8 a1 ff ff ff       	call   80102dc7 <lapicw>
80102e26:	83 c4 08             	add    $0x8,%esp
  lapicw(TICR, 10000000); 
80102e29:	68 80 96 98 00       	push   $0x989680
80102e2e:	68 e0 00 00 00       	push   $0xe0
80102e33:	e8 8f ff ff ff       	call   80102dc7 <lapicw>
80102e38:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80102e3b:	68 00 00 01 00       	push   $0x10000
80102e40:	68 d4 00 00 00       	push   $0xd4
80102e45:	e8 7d ff ff ff       	call   80102dc7 <lapicw>
80102e4a:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
80102e4d:	68 00 00 01 00       	push   $0x10000
80102e52:	68 d8 00 00 00       	push   $0xd8
80102e57:	e8 6b ff ff ff       	call   80102dc7 <lapicw>
80102e5c:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102e5f:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102e64:	83 c0 30             	add    $0x30,%eax
80102e67:	8b 00                	mov    (%eax),%eax
80102e69:	c1 e8 10             	shr    $0x10,%eax
80102e6c:	0f b6 c0             	movzbl %al,%eax
80102e6f:	83 f8 03             	cmp    $0x3,%eax
80102e72:	76 12                	jbe    80102e86 <lapicinit+0x9e>
    lapicw(PCINT, MASKED);
80102e74:	68 00 00 01 00       	push   $0x10000
80102e79:	68 d0 00 00 00       	push   $0xd0
80102e7e:	e8 44 ff ff ff       	call   80102dc7 <lapicw>
80102e83:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80102e86:	6a 33                	push   $0x33
80102e88:	68 dc 00 00 00       	push   $0xdc
80102e8d:	e8 35 ff ff ff       	call   80102dc7 <lapicw>
80102e92:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80102e95:	6a 00                	push   $0x0
80102e97:	68 a0 00 00 00       	push   $0xa0
80102e9c:	e8 26 ff ff ff       	call   80102dc7 <lapicw>
80102ea1:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
80102ea4:	6a 00                	push   $0x0
80102ea6:	68 a0 00 00 00       	push   $0xa0
80102eab:	e8 17 ff ff ff       	call   80102dc7 <lapicw>
80102eb0:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80102eb3:	6a 00                	push   $0x0
80102eb5:	6a 2c                	push   $0x2c
80102eb7:	e8 0b ff ff ff       	call   80102dc7 <lapicw>
80102ebc:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
80102ebf:	6a 00                	push   $0x0
80102ec1:	68 c4 00 00 00       	push   $0xc4
80102ec6:	e8 fc fe ff ff       	call   80102dc7 <lapicw>
80102ecb:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80102ece:	68 00 85 08 00       	push   $0x88500
80102ed3:	68 c0 00 00 00       	push   $0xc0
80102ed8:	e8 ea fe ff ff       	call   80102dc7 <lapicw>
80102edd:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
80102ee0:	90                   	nop
80102ee1:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102ee6:	05 00 03 00 00       	add    $0x300,%eax
80102eeb:	8b 00                	mov    (%eax),%eax
80102eed:	25 00 10 00 00       	and    $0x1000,%eax
80102ef2:	85 c0                	test   %eax,%eax
80102ef4:	75 eb                	jne    80102ee1 <lapicinit+0xf9>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
80102ef6:	6a 00                	push   $0x0
80102ef8:	6a 20                	push   $0x20
80102efa:	e8 c8 fe ff ff       	call   80102dc7 <lapicw>
80102eff:	83 c4 08             	add    $0x8,%esp
}
80102f02:	c9                   	leave  
80102f03:	c3                   	ret    

80102f04 <cpunum>:

int
cpunum(void)
{
80102f04:	55                   	push   %ebp
80102f05:	89 e5                	mov    %esp,%ebp
80102f07:	83 ec 08             	sub    $0x8,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80102f0a:	e8 a8 fe ff ff       	call   80102db7 <readeflags>
80102f0f:	25 00 02 00 00       	and    $0x200,%eax
80102f14:	85 c0                	test   %eax,%eax
80102f16:	74 26                	je     80102f3e <cpunum+0x3a>
    static int n;
    if(n++ == 0)
80102f18:	a1 40 b6 10 80       	mov    0x8010b640,%eax
80102f1d:	8d 50 01             	lea    0x1(%eax),%edx
80102f20:	89 15 40 b6 10 80    	mov    %edx,0x8010b640
80102f26:	85 c0                	test   %eax,%eax
80102f28:	75 14                	jne    80102f3e <cpunum+0x3a>
      cprintf("cpu called from %x with interrupts enabled\n",
80102f2a:	8b 45 04             	mov    0x4(%ebp),%eax
80102f2d:	83 ec 08             	sub    $0x8,%esp
80102f30:	50                   	push   %eax
80102f31:	68 08 86 10 80       	push   $0x80108608
80102f36:	e8 7d d4 ff ff       	call   801003b8 <cprintf>
80102f3b:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if(lapic)
80102f3e:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102f43:	85 c0                	test   %eax,%eax
80102f45:	74 0f                	je     80102f56 <cpunum+0x52>
    return lapic[ID]>>24;
80102f47:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102f4c:	83 c0 20             	add    $0x20,%eax
80102f4f:	8b 00                	mov    (%eax),%eax
80102f51:	c1 e8 18             	shr    $0x18,%eax
80102f54:	eb 05                	jmp    80102f5b <cpunum+0x57>
  return 0;
80102f56:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102f5b:	c9                   	leave  
80102f5c:	c3                   	ret    

80102f5d <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102f5d:	55                   	push   %ebp
80102f5e:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102f60:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102f65:	85 c0                	test   %eax,%eax
80102f67:	74 0c                	je     80102f75 <lapiceoi+0x18>
    lapicw(EOI, 0);
80102f69:	6a 00                	push   $0x0
80102f6b:	6a 2c                	push   $0x2c
80102f6d:	e8 55 fe ff ff       	call   80102dc7 <lapicw>
80102f72:	83 c4 08             	add    $0x8,%esp
}
80102f75:	c9                   	leave  
80102f76:	c3                   	ret    

80102f77 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102f77:	55                   	push   %ebp
80102f78:	89 e5                	mov    %esp,%ebp
}
80102f7a:	5d                   	pop    %ebp
80102f7b:	c3                   	ret    

80102f7c <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102f7c:	55                   	push   %ebp
80102f7d:	89 e5                	mov    %esp,%ebp
80102f7f:	83 ec 14             	sub    $0x14,%esp
80102f82:	8b 45 08             	mov    0x8(%ebp),%eax
80102f85:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
80102f88:	6a 0f                	push   $0xf
80102f8a:	6a 70                	push   $0x70
80102f8c:	e8 0a fe ff ff       	call   80102d9b <outb>
80102f91:	83 c4 08             	add    $0x8,%esp
  outb(CMOS_PORT+1, 0x0A);
80102f94:	6a 0a                	push   $0xa
80102f96:	6a 71                	push   $0x71
80102f98:	e8 fe fd ff ff       	call   80102d9b <outb>
80102f9d:	83 c4 08             	add    $0x8,%esp
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
80102fa0:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
80102fa7:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102faa:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
80102faf:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102fb2:	8d 50 02             	lea    0x2(%eax),%edx
80102fb5:	8b 45 0c             	mov    0xc(%ebp),%eax
80102fb8:	c1 e8 04             	shr    $0x4,%eax
80102fbb:	66 89 02             	mov    %ax,(%edx)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102fbe:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80102fc2:	c1 e0 18             	shl    $0x18,%eax
80102fc5:	50                   	push   %eax
80102fc6:	68 c4 00 00 00       	push   $0xc4
80102fcb:	e8 f7 fd ff ff       	call   80102dc7 <lapicw>
80102fd0:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
80102fd3:	68 00 c5 00 00       	push   $0xc500
80102fd8:	68 c0 00 00 00       	push   $0xc0
80102fdd:	e8 e5 fd ff ff       	call   80102dc7 <lapicw>
80102fe2:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
80102fe5:	68 c8 00 00 00       	push   $0xc8
80102fea:	e8 88 ff ff ff       	call   80102f77 <microdelay>
80102fef:	83 c4 04             	add    $0x4,%esp
  lapicw(ICRLO, INIT | LEVEL);
80102ff2:	68 00 85 00 00       	push   $0x8500
80102ff7:	68 c0 00 00 00       	push   $0xc0
80102ffc:	e8 c6 fd ff ff       	call   80102dc7 <lapicw>
80103001:	83 c4 08             	add    $0x8,%esp
  microdelay(100);    // should be 10ms, but too slow in Bochs!
80103004:	6a 64                	push   $0x64
80103006:	e8 6c ff ff ff       	call   80102f77 <microdelay>
8010300b:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
8010300e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103015:	eb 3c                	jmp    80103053 <lapicstartap+0xd7>
    lapicw(ICRHI, apicid<<24);
80103017:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
8010301b:	c1 e0 18             	shl    $0x18,%eax
8010301e:	50                   	push   %eax
8010301f:	68 c4 00 00 00       	push   $0xc4
80103024:	e8 9e fd ff ff       	call   80102dc7 <lapicw>
80103029:	83 c4 08             	add    $0x8,%esp
    lapicw(ICRLO, STARTUP | (addr>>12));
8010302c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010302f:	c1 e8 0c             	shr    $0xc,%eax
80103032:	80 cc 06             	or     $0x6,%ah
80103035:	50                   	push   %eax
80103036:	68 c0 00 00 00       	push   $0xc0
8010303b:	e8 87 fd ff ff       	call   80102dc7 <lapicw>
80103040:	83 c4 08             	add    $0x8,%esp
    microdelay(200);
80103043:	68 c8 00 00 00       	push   $0xc8
80103048:	e8 2a ff ff ff       	call   80102f77 <microdelay>
8010304d:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
80103050:	ff 45 fc             	incl   -0x4(%ebp)
80103053:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
80103057:	7e be                	jle    80103017 <lapicstartap+0x9b>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
80103059:	c9                   	leave  
8010305a:	c3                   	ret    

8010305b <cmos_read>:
#define DAY     0x07
#define MONTH   0x08
#define YEAR    0x09

static uint cmos_read(uint reg)
{
8010305b:	55                   	push   %ebp
8010305c:	89 e5                	mov    %esp,%ebp
  outb(CMOS_PORT,  reg);
8010305e:	8b 45 08             	mov    0x8(%ebp),%eax
80103061:	0f b6 c0             	movzbl %al,%eax
80103064:	50                   	push   %eax
80103065:	6a 70                	push   $0x70
80103067:	e8 2f fd ff ff       	call   80102d9b <outb>
8010306c:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
8010306f:	68 c8 00 00 00       	push   $0xc8
80103074:	e8 fe fe ff ff       	call   80102f77 <microdelay>
80103079:	83 c4 04             	add    $0x4,%esp

  return inb(CMOS_RETURN);
8010307c:	6a 71                	push   $0x71
8010307e:	e8 fd fc ff ff       	call   80102d80 <inb>
80103083:	83 c4 04             	add    $0x4,%esp
80103086:	0f b6 c0             	movzbl %al,%eax
}
80103089:	c9                   	leave  
8010308a:	c3                   	ret    

8010308b <fill_rtcdate>:

static void fill_rtcdate(struct rtcdate *r)
{
8010308b:	55                   	push   %ebp
8010308c:	89 e5                	mov    %esp,%ebp
  r->second = cmos_read(SECS);
8010308e:	6a 00                	push   $0x0
80103090:	e8 c6 ff ff ff       	call   8010305b <cmos_read>
80103095:	83 c4 04             	add    $0x4,%esp
80103098:	8b 55 08             	mov    0x8(%ebp),%edx
8010309b:	89 02                	mov    %eax,(%edx)
  r->minute = cmos_read(MINS);
8010309d:	6a 02                	push   $0x2
8010309f:	e8 b7 ff ff ff       	call   8010305b <cmos_read>
801030a4:	83 c4 04             	add    $0x4,%esp
801030a7:	8b 55 08             	mov    0x8(%ebp),%edx
801030aa:	89 42 04             	mov    %eax,0x4(%edx)
  r->hour   = cmos_read(HOURS);
801030ad:	6a 04                	push   $0x4
801030af:	e8 a7 ff ff ff       	call   8010305b <cmos_read>
801030b4:	83 c4 04             	add    $0x4,%esp
801030b7:	8b 55 08             	mov    0x8(%ebp),%edx
801030ba:	89 42 08             	mov    %eax,0x8(%edx)
  r->day    = cmos_read(DAY);
801030bd:	6a 07                	push   $0x7
801030bf:	e8 97 ff ff ff       	call   8010305b <cmos_read>
801030c4:	83 c4 04             	add    $0x4,%esp
801030c7:	8b 55 08             	mov    0x8(%ebp),%edx
801030ca:	89 42 0c             	mov    %eax,0xc(%edx)
  r->month  = cmos_read(MONTH);
801030cd:	6a 08                	push   $0x8
801030cf:	e8 87 ff ff ff       	call   8010305b <cmos_read>
801030d4:	83 c4 04             	add    $0x4,%esp
801030d7:	8b 55 08             	mov    0x8(%ebp),%edx
801030da:	89 42 10             	mov    %eax,0x10(%edx)
  r->year   = cmos_read(YEAR);
801030dd:	6a 09                	push   $0x9
801030df:	e8 77 ff ff ff       	call   8010305b <cmos_read>
801030e4:	83 c4 04             	add    $0x4,%esp
801030e7:	8b 55 08             	mov    0x8(%ebp),%edx
801030ea:	89 42 14             	mov    %eax,0x14(%edx)
}
801030ed:	c9                   	leave  
801030ee:	c3                   	ret    

801030ef <cmostime>:

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
801030ef:	55                   	push   %ebp
801030f0:	89 e5                	mov    %esp,%ebp
801030f2:	57                   	push   %edi
801030f3:	56                   	push   %esi
801030f4:	53                   	push   %ebx
801030f5:	83 ec 4c             	sub    $0x4c,%esp
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
801030f8:	6a 0b                	push   $0xb
801030fa:	e8 5c ff ff ff       	call   8010305b <cmos_read>
801030ff:	83 c4 04             	add    $0x4,%esp
80103102:	89 45 e4             	mov    %eax,-0x1c(%ebp)

  bcd = (sb & (1 << 2)) == 0;
80103105:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103108:	83 e0 04             	and    $0x4,%eax
8010310b:	85 c0                	test   %eax,%eax
8010310d:	0f 94 c0             	sete   %al
80103110:	0f b6 c0             	movzbl %al,%eax
80103113:	89 45 e0             	mov    %eax,-0x20(%ebp)

  // make sure CMOS doesn't modify time while we read it
  for (;;) {
    fill_rtcdate(&t1);
80103116:	8d 45 c8             	lea    -0x38(%ebp),%eax
80103119:	50                   	push   %eax
8010311a:	e8 6c ff ff ff       	call   8010308b <fill_rtcdate>
8010311f:	83 c4 04             	add    $0x4,%esp
    if (cmos_read(CMOS_STATA) & CMOS_UIP)
80103122:	6a 0a                	push   $0xa
80103124:	e8 32 ff ff ff       	call   8010305b <cmos_read>
80103129:	83 c4 04             	add    $0x4,%esp
8010312c:	25 80 00 00 00       	and    $0x80,%eax
80103131:	85 c0                	test   %eax,%eax
80103133:	74 02                	je     80103137 <cmostime+0x48>
        continue;
80103135:	eb 32                	jmp    80103169 <cmostime+0x7a>
    fill_rtcdate(&t2);
80103137:	8d 45 b0             	lea    -0x50(%ebp),%eax
8010313a:	50                   	push   %eax
8010313b:	e8 4b ff ff ff       	call   8010308b <fill_rtcdate>
80103140:	83 c4 04             	add    $0x4,%esp
    if (memcmp(&t1, &t2, sizeof(t1)) == 0)
80103143:	83 ec 04             	sub    $0x4,%esp
80103146:	6a 18                	push   $0x18
80103148:	8d 45 b0             	lea    -0x50(%ebp),%eax
8010314b:	50                   	push   %eax
8010314c:	8d 45 c8             	lea    -0x38(%ebp),%eax
8010314f:	50                   	push   %eax
80103150:	e8 b2 20 00 00       	call   80105207 <memcmp>
80103155:	83 c4 10             	add    $0x10,%esp
80103158:	85 c0                	test   %eax,%eax
8010315a:	75 0d                	jne    80103169 <cmostime+0x7a>
      break;
8010315c:	90                   	nop
  }

  // convert
  if (bcd) {
8010315d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80103161:	0f 84 ac 00 00 00    	je     80103213 <cmostime+0x124>
80103167:	eb 02                	jmp    8010316b <cmostime+0x7c>
    if (cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if (memcmp(&t1, &t2, sizeof(t1)) == 0)
      break;
  }
80103169:	eb ab                	jmp    80103116 <cmostime+0x27>

  // convert
  if (bcd) {
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010316b:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010316e:	c1 e8 04             	shr    $0x4,%eax
80103171:	89 c2                	mov    %eax,%edx
80103173:	89 d0                	mov    %edx,%eax
80103175:	c1 e0 02             	shl    $0x2,%eax
80103178:	01 d0                	add    %edx,%eax
8010317a:	01 c0                	add    %eax,%eax
8010317c:	8b 55 c8             	mov    -0x38(%ebp),%edx
8010317f:	83 e2 0f             	and    $0xf,%edx
80103182:	01 d0                	add    %edx,%eax
80103184:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(minute);
80103187:	8b 45 cc             	mov    -0x34(%ebp),%eax
8010318a:	c1 e8 04             	shr    $0x4,%eax
8010318d:	89 c2                	mov    %eax,%edx
8010318f:	89 d0                	mov    %edx,%eax
80103191:	c1 e0 02             	shl    $0x2,%eax
80103194:	01 d0                	add    %edx,%eax
80103196:	01 c0                	add    %eax,%eax
80103198:	8b 55 cc             	mov    -0x34(%ebp),%edx
8010319b:	83 e2 0f             	and    $0xf,%edx
8010319e:	01 d0                	add    %edx,%eax
801031a0:	89 45 cc             	mov    %eax,-0x34(%ebp)
    CONV(hour  );
801031a3:	8b 45 d0             	mov    -0x30(%ebp),%eax
801031a6:	c1 e8 04             	shr    $0x4,%eax
801031a9:	89 c2                	mov    %eax,%edx
801031ab:	89 d0                	mov    %edx,%eax
801031ad:	c1 e0 02             	shl    $0x2,%eax
801031b0:	01 d0                	add    %edx,%eax
801031b2:	01 c0                	add    %eax,%eax
801031b4:	8b 55 d0             	mov    -0x30(%ebp),%edx
801031b7:	83 e2 0f             	and    $0xf,%edx
801031ba:	01 d0                	add    %edx,%eax
801031bc:	89 45 d0             	mov    %eax,-0x30(%ebp)
    CONV(day   );
801031bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801031c2:	c1 e8 04             	shr    $0x4,%eax
801031c5:	89 c2                	mov    %eax,%edx
801031c7:	89 d0                	mov    %edx,%eax
801031c9:	c1 e0 02             	shl    $0x2,%eax
801031cc:	01 d0                	add    %edx,%eax
801031ce:	01 c0                	add    %eax,%eax
801031d0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
801031d3:	83 e2 0f             	and    $0xf,%edx
801031d6:	01 d0                	add    %edx,%eax
801031d8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    CONV(month );
801031db:	8b 45 d8             	mov    -0x28(%ebp),%eax
801031de:	c1 e8 04             	shr    $0x4,%eax
801031e1:	89 c2                	mov    %eax,%edx
801031e3:	89 d0                	mov    %edx,%eax
801031e5:	c1 e0 02             	shl    $0x2,%eax
801031e8:	01 d0                	add    %edx,%eax
801031ea:	01 c0                	add    %eax,%eax
801031ec:	8b 55 d8             	mov    -0x28(%ebp),%edx
801031ef:	83 e2 0f             	and    $0xf,%edx
801031f2:	01 d0                	add    %edx,%eax
801031f4:	89 45 d8             	mov    %eax,-0x28(%ebp)
    CONV(year  );
801031f7:	8b 45 dc             	mov    -0x24(%ebp),%eax
801031fa:	c1 e8 04             	shr    $0x4,%eax
801031fd:	89 c2                	mov    %eax,%edx
801031ff:	89 d0                	mov    %edx,%eax
80103201:	c1 e0 02             	shl    $0x2,%eax
80103204:	01 d0                	add    %edx,%eax
80103206:	01 c0                	add    %eax,%eax
80103208:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010320b:	83 e2 0f             	and    $0xf,%edx
8010320e:	01 d0                	add    %edx,%eax
80103210:	89 45 dc             	mov    %eax,-0x24(%ebp)
#undef     CONV
  }

  *r = t1;
80103213:	8b 45 08             	mov    0x8(%ebp),%eax
80103216:	89 c2                	mov    %eax,%edx
80103218:	8d 5d c8             	lea    -0x38(%ebp),%ebx
8010321b:	b8 06 00 00 00       	mov    $0x6,%eax
80103220:	89 d7                	mov    %edx,%edi
80103222:	89 de                	mov    %ebx,%esi
80103224:	89 c1                	mov    %eax,%ecx
80103226:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  r->year += 2000;
80103228:	8b 45 08             	mov    0x8(%ebp),%eax
8010322b:	8b 40 14             	mov    0x14(%eax),%eax
8010322e:	8d 90 d0 07 00 00    	lea    0x7d0(%eax),%edx
80103234:	8b 45 08             	mov    0x8(%ebp),%eax
80103237:	89 50 14             	mov    %edx,0x14(%eax)
}
8010323a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010323d:	5b                   	pop    %ebx
8010323e:	5e                   	pop    %esi
8010323f:	5f                   	pop    %edi
80103240:	5d                   	pop    %ebp
80103241:	c3                   	ret    

80103242 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80103242:	55                   	push   %ebp
80103243:	89 e5                	mov    %esp,%ebp
80103245:	83 ec 28             	sub    $0x28,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80103248:	83 ec 08             	sub    $0x8,%esp
8010324b:	68 34 86 10 80       	push   $0x80108634
80103250:	68 60 22 11 80       	push   $0x80112260
80103255:	e8 cd 1c 00 00       	call   80104f27 <initlock>
8010325a:	83 c4 10             	add    $0x10,%esp
  readsb(dev, &sb);
8010325d:	83 ec 08             	sub    $0x8,%esp
80103260:	8d 45 dc             	lea    -0x24(%ebp),%eax
80103263:	50                   	push   %eax
80103264:	ff 75 08             	pushl  0x8(%ebp)
80103267:	e8 a0 e0 ff ff       	call   8010130c <readsb>
8010326c:	83 c4 10             	add    $0x10,%esp
  log.start = sb.logstart;
8010326f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103272:	a3 94 22 11 80       	mov    %eax,0x80112294
  log.size = sb.nlog;
80103277:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010327a:	a3 98 22 11 80       	mov    %eax,0x80112298
  log.dev = dev;
8010327f:	8b 45 08             	mov    0x8(%ebp),%eax
80103282:	a3 a4 22 11 80       	mov    %eax,0x801122a4
  recover_from_log();
80103287:	e8 a9 01 00 00       	call   80103435 <recover_from_log>
}
8010328c:	c9                   	leave  
8010328d:	c3                   	ret    

8010328e <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
8010328e:	55                   	push   %ebp
8010328f:	89 e5                	mov    %esp,%ebp
80103291:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103294:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010329b:	e9 92 00 00 00       	jmp    80103332 <install_trans+0xa4>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801032a0:	8b 15 94 22 11 80    	mov    0x80112294,%edx
801032a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801032a9:	01 d0                	add    %edx,%eax
801032ab:	40                   	inc    %eax
801032ac:	89 c2                	mov    %eax,%edx
801032ae:	a1 a4 22 11 80       	mov    0x801122a4,%eax
801032b3:	83 ec 08             	sub    $0x8,%esp
801032b6:	52                   	push   %edx
801032b7:	50                   	push   %eax
801032b8:	e8 f7 ce ff ff       	call   801001b4 <bread>
801032bd:	83 c4 10             	add    $0x10,%esp
801032c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801032c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801032c6:	83 c0 10             	add    $0x10,%eax
801032c9:	8b 04 85 6c 22 11 80 	mov    -0x7feedd94(,%eax,4),%eax
801032d0:	89 c2                	mov    %eax,%edx
801032d2:	a1 a4 22 11 80       	mov    0x801122a4,%eax
801032d7:	83 ec 08             	sub    $0x8,%esp
801032da:	52                   	push   %edx
801032db:	50                   	push   %eax
801032dc:	e8 d3 ce ff ff       	call   801001b4 <bread>
801032e1:	83 c4 10             	add    $0x10,%esp
801032e4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801032e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801032ea:	8d 50 18             	lea    0x18(%eax),%edx
801032ed:	8b 45 ec             	mov    -0x14(%ebp),%eax
801032f0:	83 c0 18             	add    $0x18,%eax
801032f3:	83 ec 04             	sub    $0x4,%esp
801032f6:	68 00 02 00 00       	push   $0x200
801032fb:	52                   	push   %edx
801032fc:	50                   	push   %eax
801032fd:	e8 57 1f 00 00       	call   80105259 <memmove>
80103302:	83 c4 10             	add    $0x10,%esp
    bwrite(dbuf);  // write dst to disk
80103305:	83 ec 0c             	sub    $0xc,%esp
80103308:	ff 75 ec             	pushl  -0x14(%ebp)
8010330b:	e8 dd ce ff ff       	call   801001ed <bwrite>
80103310:	83 c4 10             	add    $0x10,%esp
    brelse(lbuf); 
80103313:	83 ec 0c             	sub    $0xc,%esp
80103316:	ff 75 f0             	pushl  -0x10(%ebp)
80103319:	e8 0d cf ff ff       	call   8010022b <brelse>
8010331e:	83 c4 10             	add    $0x10,%esp
    brelse(dbuf);
80103321:	83 ec 0c             	sub    $0xc,%esp
80103324:	ff 75 ec             	pushl  -0x14(%ebp)
80103327:	e8 ff ce ff ff       	call   8010022b <brelse>
8010332c:	83 c4 10             	add    $0x10,%esp
static void 
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
8010332f:	ff 45 f4             	incl   -0xc(%ebp)
80103332:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103337:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010333a:	0f 8f 60 ff ff ff    	jg     801032a0 <install_trans+0x12>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf); 
    brelse(dbuf);
  }
}
80103340:	c9                   	leave  
80103341:	c3                   	ret    

80103342 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
80103342:	55                   	push   %ebp
80103343:	89 e5                	mov    %esp,%ebp
80103345:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
80103348:	a1 94 22 11 80       	mov    0x80112294,%eax
8010334d:	89 c2                	mov    %eax,%edx
8010334f:	a1 a4 22 11 80       	mov    0x801122a4,%eax
80103354:	83 ec 08             	sub    $0x8,%esp
80103357:	52                   	push   %edx
80103358:	50                   	push   %eax
80103359:	e8 56 ce ff ff       	call   801001b4 <bread>
8010335e:	83 c4 10             	add    $0x10,%esp
80103361:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
80103364:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103367:	83 c0 18             	add    $0x18,%eax
8010336a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
8010336d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103370:	8b 00                	mov    (%eax),%eax
80103372:	a3 a8 22 11 80       	mov    %eax,0x801122a8
  for (i = 0; i < log.lh.n; i++) {
80103377:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010337e:	eb 1a                	jmp    8010339a <read_head+0x58>
    log.lh.block[i] = lh->block[i];
80103380:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103383:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103386:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
8010338a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010338d:	83 c2 10             	add    $0x10,%edx
80103390:	89 04 95 6c 22 11 80 	mov    %eax,-0x7feedd94(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80103397:	ff 45 f4             	incl   -0xc(%ebp)
8010339a:	a1 a8 22 11 80       	mov    0x801122a8,%eax
8010339f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801033a2:	7f dc                	jg     80103380 <read_head+0x3e>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
801033a4:	83 ec 0c             	sub    $0xc,%esp
801033a7:	ff 75 f0             	pushl  -0x10(%ebp)
801033aa:	e8 7c ce ff ff       	call   8010022b <brelse>
801033af:	83 c4 10             	add    $0x10,%esp
}
801033b2:	c9                   	leave  
801033b3:	c3                   	ret    

801033b4 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
801033b4:	55                   	push   %ebp
801033b5:	89 e5                	mov    %esp,%ebp
801033b7:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
801033ba:	a1 94 22 11 80       	mov    0x80112294,%eax
801033bf:	89 c2                	mov    %eax,%edx
801033c1:	a1 a4 22 11 80       	mov    0x801122a4,%eax
801033c6:	83 ec 08             	sub    $0x8,%esp
801033c9:	52                   	push   %edx
801033ca:	50                   	push   %eax
801033cb:	e8 e4 cd ff ff       	call   801001b4 <bread>
801033d0:	83 c4 10             	add    $0x10,%esp
801033d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
801033d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801033d9:	83 c0 18             	add    $0x18,%eax
801033dc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
801033df:	8b 15 a8 22 11 80    	mov    0x801122a8,%edx
801033e5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801033e8:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
801033ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801033f1:	eb 1a                	jmp    8010340d <write_head+0x59>
    hb->block[i] = log.lh.block[i];
801033f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801033f6:	83 c0 10             	add    $0x10,%eax
801033f9:	8b 0c 85 6c 22 11 80 	mov    -0x7feedd94(,%eax,4),%ecx
80103400:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103403:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103406:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
8010340a:	ff 45 f4             	incl   -0xc(%ebp)
8010340d:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103412:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103415:	7f dc                	jg     801033f3 <write_head+0x3f>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80103417:	83 ec 0c             	sub    $0xc,%esp
8010341a:	ff 75 f0             	pushl  -0x10(%ebp)
8010341d:	e8 cb cd ff ff       	call   801001ed <bwrite>
80103422:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
80103425:	83 ec 0c             	sub    $0xc,%esp
80103428:	ff 75 f0             	pushl  -0x10(%ebp)
8010342b:	e8 fb cd ff ff       	call   8010022b <brelse>
80103430:	83 c4 10             	add    $0x10,%esp
}
80103433:	c9                   	leave  
80103434:	c3                   	ret    

80103435 <recover_from_log>:

static void
recover_from_log(void)
{
80103435:	55                   	push   %ebp
80103436:	89 e5                	mov    %esp,%ebp
80103438:	83 ec 08             	sub    $0x8,%esp
  read_head();      
8010343b:	e8 02 ff ff ff       	call   80103342 <read_head>
  install_trans(); // if committed, copy from log to disk
80103440:	e8 49 fe ff ff       	call   8010328e <install_trans>
  log.lh.n = 0;
80103445:	c7 05 a8 22 11 80 00 	movl   $0x0,0x801122a8
8010344c:	00 00 00 
  write_head(); // clear the log
8010344f:	e8 60 ff ff ff       	call   801033b4 <write_head>
}
80103454:	c9                   	leave  
80103455:	c3                   	ret    

80103456 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
80103456:	55                   	push   %ebp
80103457:	89 e5                	mov    %esp,%ebp
80103459:	83 ec 08             	sub    $0x8,%esp
  acquire(&log.lock);
8010345c:	83 ec 0c             	sub    $0xc,%esp
8010345f:	68 60 22 11 80       	push   $0x80112260
80103464:	e8 df 1a 00 00       	call   80104f48 <acquire>
80103469:	83 c4 10             	add    $0x10,%esp
  while(1){
    if(log.committing){
8010346c:	a1 a0 22 11 80       	mov    0x801122a0,%eax
80103471:	85 c0                	test   %eax,%eax
80103473:	74 17                	je     8010348c <begin_op+0x36>
      sleep(&log, &log.lock);
80103475:	83 ec 08             	sub    $0x8,%esp
80103478:	68 60 22 11 80       	push   $0x80112260
8010347d:	68 60 22 11 80       	push   $0x80112260
80103482:	e8 d4 17 00 00       	call   80104c5b <sleep>
80103487:	83 c4 10             	add    $0x10,%esp
8010348a:	eb 52                	jmp    801034de <begin_op+0x88>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
8010348c:	8b 15 a8 22 11 80    	mov    0x801122a8,%edx
80103492:	a1 9c 22 11 80       	mov    0x8011229c,%eax
80103497:	8d 48 01             	lea    0x1(%eax),%ecx
8010349a:	89 c8                	mov    %ecx,%eax
8010349c:	c1 e0 02             	shl    $0x2,%eax
8010349f:	01 c8                	add    %ecx,%eax
801034a1:	01 c0                	add    %eax,%eax
801034a3:	01 d0                	add    %edx,%eax
801034a5:	83 f8 1e             	cmp    $0x1e,%eax
801034a8:	7e 17                	jle    801034c1 <begin_op+0x6b>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
801034aa:	83 ec 08             	sub    $0x8,%esp
801034ad:	68 60 22 11 80       	push   $0x80112260
801034b2:	68 60 22 11 80       	push   $0x80112260
801034b7:	e8 9f 17 00 00       	call   80104c5b <sleep>
801034bc:	83 c4 10             	add    $0x10,%esp
801034bf:	eb 1d                	jmp    801034de <begin_op+0x88>
    } else {
      log.outstanding += 1;
801034c1:	a1 9c 22 11 80       	mov    0x8011229c,%eax
801034c6:	40                   	inc    %eax
801034c7:	a3 9c 22 11 80       	mov    %eax,0x8011229c
      release(&log.lock);
801034cc:	83 ec 0c             	sub    $0xc,%esp
801034cf:	68 60 22 11 80       	push   $0x80112260
801034d4:	e8 d5 1a 00 00       	call   80104fae <release>
801034d9:	83 c4 10             	add    $0x10,%esp
      break;
801034dc:	eb 02                	jmp    801034e0 <begin_op+0x8a>
    }
  }
801034de:	eb 8c                	jmp    8010346c <begin_op+0x16>
}
801034e0:	c9                   	leave  
801034e1:	c3                   	ret    

801034e2 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
801034e2:	55                   	push   %ebp
801034e3:	89 e5                	mov    %esp,%ebp
801034e5:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;
801034e8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&log.lock);
801034ef:	83 ec 0c             	sub    $0xc,%esp
801034f2:	68 60 22 11 80       	push   $0x80112260
801034f7:	e8 4c 1a 00 00       	call   80104f48 <acquire>
801034fc:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
801034ff:	a1 9c 22 11 80       	mov    0x8011229c,%eax
80103504:	48                   	dec    %eax
80103505:	a3 9c 22 11 80       	mov    %eax,0x8011229c
  if(log.committing)
8010350a:	a1 a0 22 11 80       	mov    0x801122a0,%eax
8010350f:	85 c0                	test   %eax,%eax
80103511:	74 0d                	je     80103520 <end_op+0x3e>
    panic("log.committing");
80103513:	83 ec 0c             	sub    $0xc,%esp
80103516:	68 38 86 10 80       	push   $0x80108638
8010351b:	e8 2e d0 ff ff       	call   8010054e <panic>
  if(log.outstanding == 0){
80103520:	a1 9c 22 11 80       	mov    0x8011229c,%eax
80103525:	85 c0                	test   %eax,%eax
80103527:	75 13                	jne    8010353c <end_op+0x5a>
    do_commit = 1;
80103529:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    log.committing = 1;
80103530:	c7 05 a0 22 11 80 01 	movl   $0x1,0x801122a0
80103537:	00 00 00 
8010353a:	eb 10                	jmp    8010354c <end_op+0x6a>
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
8010353c:	83 ec 0c             	sub    $0xc,%esp
8010353f:	68 60 22 11 80       	push   $0x80112260
80103544:	e8 fb 17 00 00       	call   80104d44 <wakeup>
80103549:	83 c4 10             	add    $0x10,%esp
  }
  release(&log.lock);
8010354c:	83 ec 0c             	sub    $0xc,%esp
8010354f:	68 60 22 11 80       	push   $0x80112260
80103554:	e8 55 1a 00 00       	call   80104fae <release>
80103559:	83 c4 10             	add    $0x10,%esp

  if(do_commit){
8010355c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103560:	74 3f                	je     801035a1 <end_op+0xbf>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
80103562:	e8 f0 00 00 00       	call   80103657 <commit>
    acquire(&log.lock);
80103567:	83 ec 0c             	sub    $0xc,%esp
8010356a:	68 60 22 11 80       	push   $0x80112260
8010356f:	e8 d4 19 00 00       	call   80104f48 <acquire>
80103574:	83 c4 10             	add    $0x10,%esp
    log.committing = 0;
80103577:	c7 05 a0 22 11 80 00 	movl   $0x0,0x801122a0
8010357e:	00 00 00 
    wakeup(&log);
80103581:	83 ec 0c             	sub    $0xc,%esp
80103584:	68 60 22 11 80       	push   $0x80112260
80103589:	e8 b6 17 00 00       	call   80104d44 <wakeup>
8010358e:	83 c4 10             	add    $0x10,%esp
    release(&log.lock);
80103591:	83 ec 0c             	sub    $0xc,%esp
80103594:	68 60 22 11 80       	push   $0x80112260
80103599:	e8 10 1a 00 00       	call   80104fae <release>
8010359e:	83 c4 10             	add    $0x10,%esp
  }
}
801035a1:	c9                   	leave  
801035a2:	c3                   	ret    

801035a3 <write_log>:

// Copy modified blocks from cache to log.
static void 
write_log(void)
{
801035a3:	55                   	push   %ebp
801035a4:	89 e5                	mov    %esp,%ebp
801035a6:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801035a9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801035b0:	e9 92 00 00 00       	jmp    80103647 <write_log+0xa4>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
801035b5:	8b 15 94 22 11 80    	mov    0x80112294,%edx
801035bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801035be:	01 d0                	add    %edx,%eax
801035c0:	40                   	inc    %eax
801035c1:	89 c2                	mov    %eax,%edx
801035c3:	a1 a4 22 11 80       	mov    0x801122a4,%eax
801035c8:	83 ec 08             	sub    $0x8,%esp
801035cb:	52                   	push   %edx
801035cc:	50                   	push   %eax
801035cd:	e8 e2 cb ff ff       	call   801001b4 <bread>
801035d2:	83 c4 10             	add    $0x10,%esp
801035d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801035d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801035db:	83 c0 10             	add    $0x10,%eax
801035de:	8b 04 85 6c 22 11 80 	mov    -0x7feedd94(,%eax,4),%eax
801035e5:	89 c2                	mov    %eax,%edx
801035e7:	a1 a4 22 11 80       	mov    0x801122a4,%eax
801035ec:	83 ec 08             	sub    $0x8,%esp
801035ef:	52                   	push   %edx
801035f0:	50                   	push   %eax
801035f1:	e8 be cb ff ff       	call   801001b4 <bread>
801035f6:	83 c4 10             	add    $0x10,%esp
801035f9:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(to->data, from->data, BSIZE);
801035fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
801035ff:	8d 50 18             	lea    0x18(%eax),%edx
80103602:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103605:	83 c0 18             	add    $0x18,%eax
80103608:	83 ec 04             	sub    $0x4,%esp
8010360b:	68 00 02 00 00       	push   $0x200
80103610:	52                   	push   %edx
80103611:	50                   	push   %eax
80103612:	e8 42 1c 00 00       	call   80105259 <memmove>
80103617:	83 c4 10             	add    $0x10,%esp
    bwrite(to);  // write the log
8010361a:	83 ec 0c             	sub    $0xc,%esp
8010361d:	ff 75 f0             	pushl  -0x10(%ebp)
80103620:	e8 c8 cb ff ff       	call   801001ed <bwrite>
80103625:	83 c4 10             	add    $0x10,%esp
    brelse(from); 
80103628:	83 ec 0c             	sub    $0xc,%esp
8010362b:	ff 75 ec             	pushl  -0x14(%ebp)
8010362e:	e8 f8 cb ff ff       	call   8010022b <brelse>
80103633:	83 c4 10             	add    $0x10,%esp
    brelse(to);
80103636:	83 ec 0c             	sub    $0xc,%esp
80103639:	ff 75 f0             	pushl  -0x10(%ebp)
8010363c:	e8 ea cb ff ff       	call   8010022b <brelse>
80103641:	83 c4 10             	add    $0x10,%esp
static void 
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103644:	ff 45 f4             	incl   -0xc(%ebp)
80103647:	a1 a8 22 11 80       	mov    0x801122a8,%eax
8010364c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010364f:	0f 8f 60 ff ff ff    	jg     801035b5 <write_log+0x12>
    memmove(to->data, from->data, BSIZE);
    bwrite(to);  // write the log
    brelse(from); 
    brelse(to);
  }
}
80103655:	c9                   	leave  
80103656:	c3                   	ret    

80103657 <commit>:

static void
commit()
{
80103657:	55                   	push   %ebp
80103658:	89 e5                	mov    %esp,%ebp
8010365a:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
8010365d:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103662:	85 c0                	test   %eax,%eax
80103664:	7e 1e                	jle    80103684 <commit+0x2d>
    write_log();     // Write modified blocks from cache to log
80103666:	e8 38 ff ff ff       	call   801035a3 <write_log>
    write_head();    // Write header to disk -- the real commit
8010366b:	e8 44 fd ff ff       	call   801033b4 <write_head>
    install_trans(); // Now install writes to home locations
80103670:	e8 19 fc ff ff       	call   8010328e <install_trans>
    log.lh.n = 0; 
80103675:	c7 05 a8 22 11 80 00 	movl   $0x0,0x801122a8
8010367c:	00 00 00 
    write_head();    // Erase the transaction from the log
8010367f:	e8 30 fd ff ff       	call   801033b4 <write_head>
  }
}
80103684:	c9                   	leave  
80103685:	c3                   	ret    

80103686 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103686:	55                   	push   %ebp
80103687:	89 e5                	mov    %esp,%ebp
80103689:	83 ec 18             	sub    $0x18,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
8010368c:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103691:	83 f8 1d             	cmp    $0x1d,%eax
80103694:	7f 10                	jg     801036a6 <log_write+0x20>
80103696:	a1 a8 22 11 80       	mov    0x801122a8,%eax
8010369b:	8b 15 98 22 11 80    	mov    0x80112298,%edx
801036a1:	4a                   	dec    %edx
801036a2:	39 d0                	cmp    %edx,%eax
801036a4:	7c 0d                	jl     801036b3 <log_write+0x2d>
    panic("too big a transaction");
801036a6:	83 ec 0c             	sub    $0xc,%esp
801036a9:	68 47 86 10 80       	push   $0x80108647
801036ae:	e8 9b ce ff ff       	call   8010054e <panic>
  if (log.outstanding < 1)
801036b3:	a1 9c 22 11 80       	mov    0x8011229c,%eax
801036b8:	85 c0                	test   %eax,%eax
801036ba:	7f 0d                	jg     801036c9 <log_write+0x43>
    panic("log_write outside of trans");
801036bc:	83 ec 0c             	sub    $0xc,%esp
801036bf:	68 5d 86 10 80       	push   $0x8010865d
801036c4:	e8 85 ce ff ff       	call   8010054e <panic>

  acquire(&log.lock);
801036c9:	83 ec 0c             	sub    $0xc,%esp
801036cc:	68 60 22 11 80       	push   $0x80112260
801036d1:	e8 72 18 00 00       	call   80104f48 <acquire>
801036d6:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < log.lh.n; i++) {
801036d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801036e0:	eb 1e                	jmp    80103700 <log_write+0x7a>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801036e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036e5:	83 c0 10             	add    $0x10,%eax
801036e8:	8b 04 85 6c 22 11 80 	mov    -0x7feedd94(,%eax,4),%eax
801036ef:	89 c2                	mov    %eax,%edx
801036f1:	8b 45 08             	mov    0x8(%ebp),%eax
801036f4:	8b 40 08             	mov    0x8(%eax),%eax
801036f7:	39 c2                	cmp    %eax,%edx
801036f9:	75 02                	jne    801036fd <log_write+0x77>
      break;
801036fb:	eb 0d                	jmp    8010370a <log_write+0x84>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
801036fd:	ff 45 f4             	incl   -0xc(%ebp)
80103700:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103705:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103708:	7f d8                	jg     801036e2 <log_write+0x5c>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
8010370a:	8b 45 08             	mov    0x8(%ebp),%eax
8010370d:	8b 40 08             	mov    0x8(%eax),%eax
80103710:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103713:	83 c2 10             	add    $0x10,%edx
80103716:	89 04 95 6c 22 11 80 	mov    %eax,-0x7feedd94(,%edx,4)
  if (i == log.lh.n)
8010371d:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103722:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103725:	75 0b                	jne    80103732 <log_write+0xac>
    log.lh.n++;
80103727:	a1 a8 22 11 80       	mov    0x801122a8,%eax
8010372c:	40                   	inc    %eax
8010372d:	a3 a8 22 11 80       	mov    %eax,0x801122a8
  b->flags |= B_DIRTY; // prevent eviction
80103732:	8b 45 08             	mov    0x8(%ebp),%eax
80103735:	8b 00                	mov    (%eax),%eax
80103737:	83 c8 04             	or     $0x4,%eax
8010373a:	89 c2                	mov    %eax,%edx
8010373c:	8b 45 08             	mov    0x8(%ebp),%eax
8010373f:	89 10                	mov    %edx,(%eax)
  release(&log.lock);
80103741:	83 ec 0c             	sub    $0xc,%esp
80103744:	68 60 22 11 80       	push   $0x80112260
80103749:	e8 60 18 00 00       	call   80104fae <release>
8010374e:	83 c4 10             	add    $0x10,%esp
}
80103751:	c9                   	leave  
80103752:	c3                   	ret    

80103753 <v2p>:
80103753:	55                   	push   %ebp
80103754:	89 e5                	mov    %esp,%ebp
80103756:	8b 45 08             	mov    0x8(%ebp),%eax
80103759:	05 00 00 00 80       	add    $0x80000000,%eax
8010375e:	5d                   	pop    %ebp
8010375f:	c3                   	ret    

80103760 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80103760:	55                   	push   %ebp
80103761:	89 e5                	mov    %esp,%ebp
80103763:	8b 45 08             	mov    0x8(%ebp),%eax
80103766:	05 00 00 00 80       	add    $0x80000000,%eax
8010376b:	5d                   	pop    %ebp
8010376c:	c3                   	ret    

8010376d <xchg>:
  asm volatile("hlt");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
8010376d:	55                   	push   %ebp
8010376e:	89 e5                	mov    %esp,%ebp
80103770:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103773:	8b 55 08             	mov    0x8(%ebp),%edx
80103776:	8b 45 0c             	mov    0xc(%ebp),%eax
80103779:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010377c:	f0 87 02             	lock xchg %eax,(%edx)
8010377f:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80103782:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103785:	c9                   	leave  
80103786:	c3                   	ret    

80103787 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80103787:	8d 4c 24 04          	lea    0x4(%esp),%ecx
8010378b:	83 e4 f0             	and    $0xfffffff0,%esp
8010378e:	ff 71 fc             	pushl  -0x4(%ecx)
80103791:	55                   	push   %ebp
80103792:	89 e5                	mov    %esp,%ebp
80103794:	51                   	push   %ecx
80103795:	83 ec 04             	sub    $0x4,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103798:	83 ec 08             	sub    $0x8,%esp
8010379b:	68 00 00 40 80       	push   $0x80400000
801037a0:	68 3c 51 11 80       	push   $0x8011513c
801037a5:	e8 d0 f2 ff ff       	call   80102a7a <kinit1>
801037aa:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
801037ad:	e8 ac 44 00 00       	call   80107c5e <kvmalloc>
  mpinit();        // collect info about this machine
801037b2:	e8 8b 04 00 00       	call   80103c42 <mpinit>
  lapicinit();
801037b7:	e8 2c f6 ff ff       	call   80102de8 <lapicinit>
  seginit();       // set up segments
801037bc:	e8 66 3e 00 00       	call   80107627 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
801037c1:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801037c7:	8a 00                	mov    (%eax),%al
801037c9:	0f b6 c0             	movzbl %al,%eax
801037cc:	83 ec 08             	sub    $0x8,%esp
801037cf:	50                   	push   %eax
801037d0:	68 78 86 10 80       	push   $0x80108678
801037d5:	e8 de cb ff ff       	call   801003b8 <cprintf>
801037da:	83 c4 10             	add    $0x10,%esp
  picinit();       // interrupt controller
801037dd:	e8 c4 06 00 00       	call   80103ea6 <picinit>
  ioapicinit();    // another interrupt controller
801037e2:	e8 94 f1 ff ff       	call   8010297b <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
801037e7:	e8 ea d2 ff ff       	call   80100ad6 <consoleinit>
  uartinit();      // serial port
801037ec:	e8 a1 31 00 00       	call   80106992 <uartinit>
  pinit();         // process table
801037f1:	e8 ab 0b 00 00       	call   801043a1 <pinit>
  tvinit();        // trap vectors
801037f6:	e8 8a 2d 00 00       	call   80106585 <tvinit>
  binit();         // buffer cache
801037fb:	e8 34 c8 ff ff       	call   80100034 <binit>
  fileinit();      // file table
80103800:	e8 09 d7 ff ff       	call   80100f0e <fileinit>
  ideinit();       // disk
80103805:	e8 80 ed ff ff       	call   8010258a <ideinit>
  if(!ismp)
8010380a:	a1 44 23 11 80       	mov    0x80112344,%eax
8010380f:	85 c0                	test   %eax,%eax
80103811:	75 05                	jne    80103818 <main+0x91>
    timerinit();   // uniprocessor timer
80103813:	e8 ce 2c 00 00       	call   801064e6 <timerinit>
  startothers();   // start other processors
80103818:	e8 7e 00 00 00       	call   8010389b <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
8010381d:	83 ec 08             	sub    $0x8,%esp
80103820:	68 00 00 00 8e       	push   $0x8e000000
80103825:	68 00 00 40 80       	push   $0x80400000
8010382a:	e8 83 f2 ff ff       	call   80102ab2 <kinit2>
8010382f:	83 c4 10             	add    $0x10,%esp
  userinit();      // first user process
80103832:	e8 8a 0c 00 00       	call   801044c1 <userinit>
  // Finish setting up this processor in mpmain.
  mpmain();
80103837:	e8 1a 00 00 00       	call   80103856 <mpmain>

8010383c <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
8010383c:	55                   	push   %ebp
8010383d:	89 e5                	mov    %esp,%ebp
8010383f:	83 ec 08             	sub    $0x8,%esp
  switchkvm(); 
80103842:	e8 2e 44 00 00       	call   80107c75 <switchkvm>
  seginit();
80103847:	e8 db 3d 00 00       	call   80107627 <seginit>
  lapicinit();
8010384c:	e8 97 f5 ff ff       	call   80102de8 <lapicinit>
  mpmain();
80103851:	e8 00 00 00 00       	call   80103856 <mpmain>

80103856 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103856:	55                   	push   %ebp
80103857:	89 e5                	mov    %esp,%ebp
80103859:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpu->id);
8010385c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103862:	8a 00                	mov    (%eax),%al
80103864:	0f b6 c0             	movzbl %al,%eax
80103867:	83 ec 08             	sub    $0x8,%esp
8010386a:	50                   	push   %eax
8010386b:	68 8f 86 10 80       	push   $0x8010868f
80103870:	e8 43 cb ff ff       	call   801003b8 <cprintf>
80103875:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
80103878:	e8 66 2e 00 00       	call   801066e3 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
8010387d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103883:	05 a8 00 00 00       	add    $0xa8,%eax
80103888:	83 ec 08             	sub    $0x8,%esp
8010388b:	6a 01                	push   $0x1
8010388d:	50                   	push   %eax
8010388e:	e8 da fe ff ff       	call   8010376d <xchg>
80103893:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
80103896:	e8 c2 11 00 00       	call   80104a5d <scheduler>

8010389b <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
8010389b:	55                   	push   %ebp
8010389c:	89 e5                	mov    %esp,%ebp
8010389e:	53                   	push   %ebx
8010389f:	83 ec 14             	sub    $0x14,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
801038a2:	68 00 70 00 00       	push   $0x7000
801038a7:	e8 b4 fe ff ff       	call   80103760 <p2v>
801038ac:	83 c4 04             	add    $0x4,%esp
801038af:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801038b2:	b8 8a 00 00 00       	mov    $0x8a,%eax
801038b7:	83 ec 04             	sub    $0x4,%esp
801038ba:	50                   	push   %eax
801038bb:	68 0c b5 10 80       	push   $0x8010b50c
801038c0:	ff 75 f0             	pushl  -0x10(%ebp)
801038c3:	e8 91 19 00 00       	call   80105259 <memmove>
801038c8:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
801038cb:	c7 45 f4 60 23 11 80 	movl   $0x80112360,-0xc(%ebp)
801038d2:	e9 9c 00 00 00       	jmp    80103973 <startothers+0xd8>
    if(c == cpus+cpunum())  // We've started already.
801038d7:	e8 28 f6 ff ff       	call   80102f04 <cpunum>
801038dc:	89 c2                	mov    %eax,%edx
801038de:	89 d0                	mov    %edx,%eax
801038e0:	c1 e0 02             	shl    $0x2,%eax
801038e3:	01 d0                	add    %edx,%eax
801038e5:	01 c0                	add    %eax,%eax
801038e7:	01 d0                	add    %edx,%eax
801038e9:	89 c1                	mov    %eax,%ecx
801038eb:	c1 e1 04             	shl    $0x4,%ecx
801038ee:	01 c8                	add    %ecx,%eax
801038f0:	01 d0                	add    %edx,%eax
801038f2:	05 60 23 11 80       	add    $0x80112360,%eax
801038f7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801038fa:	75 02                	jne    801038fe <startothers+0x63>
      continue;
801038fc:	eb 6e                	jmp    8010396c <startothers+0xd1>

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801038fe:	e8 aa f2 ff ff       	call   80102bad <kalloc>
80103903:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
80103906:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103909:	83 e8 04             	sub    $0x4,%eax
8010390c:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010390f:	81 c2 00 10 00 00    	add    $0x1000,%edx
80103915:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
80103917:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010391a:	83 e8 08             	sub    $0x8,%eax
8010391d:	c7 00 3c 38 10 80    	movl   $0x8010383c,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
80103923:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103926:	8d 58 f4             	lea    -0xc(%eax),%ebx
80103929:	83 ec 0c             	sub    $0xc,%esp
8010392c:	68 00 a0 10 80       	push   $0x8010a000
80103931:	e8 1d fe ff ff       	call   80103753 <v2p>
80103936:	83 c4 10             	add    $0x10,%esp
80103939:	89 03                	mov    %eax,(%ebx)

    lapicstartap(c->id, v2p(code));
8010393b:	83 ec 0c             	sub    $0xc,%esp
8010393e:	ff 75 f0             	pushl  -0x10(%ebp)
80103941:	e8 0d fe ff ff       	call   80103753 <v2p>
80103946:	83 c4 10             	add    $0x10,%esp
80103949:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010394c:	8a 12                	mov    (%edx),%dl
8010394e:	0f b6 d2             	movzbl %dl,%edx
80103951:	83 ec 08             	sub    $0x8,%esp
80103954:	50                   	push   %eax
80103955:	52                   	push   %edx
80103956:	e8 21 f6 ff ff       	call   80102f7c <lapicstartap>
8010395b:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
8010395e:	90                   	nop
8010395f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103962:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103968:	85 c0                	test   %eax,%eax
8010396a:	74 f3                	je     8010395f <startothers+0xc4>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010396c:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
80103973:	a1 40 29 11 80       	mov    0x80112940,%eax
80103978:	89 c2                	mov    %eax,%edx
8010397a:	89 d0                	mov    %edx,%eax
8010397c:	c1 e0 02             	shl    $0x2,%eax
8010397f:	01 d0                	add    %edx,%eax
80103981:	01 c0                	add    %eax,%eax
80103983:	01 d0                	add    %edx,%eax
80103985:	89 c1                	mov    %eax,%ecx
80103987:	c1 e1 04             	shl    $0x4,%ecx
8010398a:	01 c8                	add    %ecx,%eax
8010398c:	01 d0                	add    %edx,%eax
8010398e:	05 60 23 11 80       	add    $0x80112360,%eax
80103993:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103996:	0f 87 3b ff ff ff    	ja     801038d7 <startothers+0x3c>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
8010399c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010399f:	c9                   	leave  
801039a0:	c3                   	ret    

801039a1 <p2v>:
801039a1:	55                   	push   %ebp
801039a2:	89 e5                	mov    %esp,%ebp
801039a4:	8b 45 08             	mov    0x8(%ebp),%eax
801039a7:	05 00 00 00 80       	add    $0x80000000,%eax
801039ac:	5d                   	pop    %ebp
801039ad:	c3                   	ret    

801039ae <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801039ae:	55                   	push   %ebp
801039af:	89 e5                	mov    %esp,%ebp
801039b1:	83 ec 14             	sub    $0x14,%esp
801039b4:	8b 45 08             	mov    0x8(%ebp),%eax
801039b7:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801039bb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801039be:	89 c2                	mov    %eax,%edx
801039c0:	ec                   	in     (%dx),%al
801039c1:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801039c4:	8a 45 ff             	mov    -0x1(%ebp),%al
}
801039c7:	c9                   	leave  
801039c8:	c3                   	ret    

801039c9 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801039c9:	55                   	push   %ebp
801039ca:	89 e5                	mov    %esp,%ebp
801039cc:	83 ec 08             	sub    $0x8,%esp
801039cf:	8b 45 08             	mov    0x8(%ebp),%eax
801039d2:	8b 55 0c             	mov    0xc(%ebp),%edx
801039d5:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801039d9:	88 55 f8             	mov    %dl,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801039dc:	8a 45 f8             	mov    -0x8(%ebp),%al
801039df:	8b 55 fc             	mov    -0x4(%ebp),%edx
801039e2:	ee                   	out    %al,(%dx)
}
801039e3:	c9                   	leave  
801039e4:	c3                   	ret    

801039e5 <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
801039e5:	55                   	push   %ebp
801039e6:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
801039e8:	a1 44 b6 10 80       	mov    0x8010b644,%eax
801039ed:	89 c2                	mov    %eax,%edx
801039ef:	b8 60 23 11 80       	mov    $0x80112360,%eax
801039f4:	29 c2                	sub    %eax,%edx
801039f6:	89 d0                	mov    %edx,%eax
801039f8:	c1 f8 02             	sar    $0x2,%eax
801039fb:	89 c2                	mov    %eax,%edx
801039fd:	89 d0                	mov    %edx,%eax
801039ff:	c1 e0 03             	shl    $0x3,%eax
80103a02:	01 d0                	add    %edx,%eax
80103a04:	c1 e0 03             	shl    $0x3,%eax
80103a07:	01 d0                	add    %edx,%eax
80103a09:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
80103a10:	01 c8                	add    %ecx,%eax
80103a12:	c1 e0 03             	shl    $0x3,%eax
80103a15:	01 d0                	add    %edx,%eax
80103a17:	01 c0                	add    %eax,%eax
80103a19:	01 d0                	add    %edx,%eax
80103a1b:	c1 e0 03             	shl    $0x3,%eax
80103a1e:	01 d0                	add    %edx,%eax
80103a20:	c1 e0 02             	shl    $0x2,%eax
80103a23:	01 d0                	add    %edx,%eax
80103a25:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
80103a2c:	01 c8                	add    %ecx,%eax
80103a2e:	01 c0                	add    %eax,%eax
80103a30:	01 d0                	add    %edx,%eax
80103a32:	01 c0                	add    %eax,%eax
80103a34:	01 d0                	add    %edx,%eax
80103a36:	89 c1                	mov    %eax,%ecx
80103a38:	c1 e1 07             	shl    $0x7,%ecx
80103a3b:	01 c8                	add    %ecx,%eax
80103a3d:	01 c0                	add    %eax,%eax
80103a3f:	01 d0                	add    %edx,%eax
}
80103a41:	5d                   	pop    %ebp
80103a42:	c3                   	ret    

80103a43 <sum>:

static uchar
sum(uchar *addr, int len)
{
80103a43:	55                   	push   %ebp
80103a44:	89 e5                	mov    %esp,%ebp
80103a46:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
80103a49:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
80103a50:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103a57:	eb 13                	jmp    80103a6c <sum+0x29>
    sum += addr[i];
80103a59:	8b 55 fc             	mov    -0x4(%ebp),%edx
80103a5c:	8b 45 08             	mov    0x8(%ebp),%eax
80103a5f:	01 d0                	add    %edx,%eax
80103a61:	8a 00                	mov    (%eax),%al
80103a63:	0f b6 c0             	movzbl %al,%eax
80103a66:	01 45 f8             	add    %eax,-0x8(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
80103a69:	ff 45 fc             	incl   -0x4(%ebp)
80103a6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103a6f:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103a72:	7c e5                	jl     80103a59 <sum+0x16>
    sum += addr[i];
  return sum;
80103a74:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103a77:	c9                   	leave  
80103a78:	c3                   	ret    

80103a79 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103a79:	55                   	push   %ebp
80103a7a:	89 e5                	mov    %esp,%ebp
80103a7c:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
80103a7f:	ff 75 08             	pushl  0x8(%ebp)
80103a82:	e8 1a ff ff ff       	call   801039a1 <p2v>
80103a87:	83 c4 04             	add    $0x4,%esp
80103a8a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
80103a8d:	8b 55 0c             	mov    0xc(%ebp),%edx
80103a90:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a93:	01 d0                	add    %edx,%eax
80103a95:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
80103a98:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a9b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103a9e:	eb 36                	jmp    80103ad6 <mpsearch1+0x5d>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103aa0:	83 ec 04             	sub    $0x4,%esp
80103aa3:	6a 04                	push   $0x4
80103aa5:	68 a0 86 10 80       	push   $0x801086a0
80103aaa:	ff 75 f4             	pushl  -0xc(%ebp)
80103aad:	e8 55 17 00 00       	call   80105207 <memcmp>
80103ab2:	83 c4 10             	add    $0x10,%esp
80103ab5:	85 c0                	test   %eax,%eax
80103ab7:	75 19                	jne    80103ad2 <mpsearch1+0x59>
80103ab9:	83 ec 08             	sub    $0x8,%esp
80103abc:	6a 10                	push   $0x10
80103abe:	ff 75 f4             	pushl  -0xc(%ebp)
80103ac1:	e8 7d ff ff ff       	call   80103a43 <sum>
80103ac6:	83 c4 10             	add    $0x10,%esp
80103ac9:	84 c0                	test   %al,%al
80103acb:	75 05                	jne    80103ad2 <mpsearch1+0x59>
      return (struct mp*)p;
80103acd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ad0:	eb 11                	jmp    80103ae3 <mpsearch1+0x6a>
{
  uchar *e, *p, *addr;

  addr = p2v(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103ad2:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103ad6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ad9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103adc:	72 c2                	jb     80103aa0 <mpsearch1+0x27>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103ade:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103ae3:	c9                   	leave  
80103ae4:	c3                   	ret    

80103ae5 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103ae5:	55                   	push   %ebp
80103ae6:	89 e5                	mov    %esp,%ebp
80103ae8:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103aeb:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103af2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103af5:	83 c0 0f             	add    $0xf,%eax
80103af8:	8a 00                	mov    (%eax),%al
80103afa:	0f b6 c0             	movzbl %al,%eax
80103afd:	c1 e0 08             	shl    $0x8,%eax
80103b00:	89 c2                	mov    %eax,%edx
80103b02:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b05:	83 c0 0e             	add    $0xe,%eax
80103b08:	8a 00                	mov    (%eax),%al
80103b0a:	0f b6 c0             	movzbl %al,%eax
80103b0d:	09 d0                	or     %edx,%eax
80103b0f:	c1 e0 04             	shl    $0x4,%eax
80103b12:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103b15:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103b19:	74 21                	je     80103b3c <mpsearch+0x57>
    if((mp = mpsearch1(p, 1024)))
80103b1b:	83 ec 08             	sub    $0x8,%esp
80103b1e:	68 00 04 00 00       	push   $0x400
80103b23:	ff 75 f0             	pushl  -0x10(%ebp)
80103b26:	e8 4e ff ff ff       	call   80103a79 <mpsearch1>
80103b2b:	83 c4 10             	add    $0x10,%esp
80103b2e:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103b31:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103b35:	74 4f                	je     80103b86 <mpsearch+0xa1>
      return mp;
80103b37:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103b3a:	eb 5f                	jmp    80103b9b <mpsearch+0xb6>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103b3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b3f:	83 c0 14             	add    $0x14,%eax
80103b42:	8a 00                	mov    (%eax),%al
80103b44:	0f b6 c0             	movzbl %al,%eax
80103b47:	c1 e0 08             	shl    $0x8,%eax
80103b4a:	89 c2                	mov    %eax,%edx
80103b4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b4f:	83 c0 13             	add    $0x13,%eax
80103b52:	8a 00                	mov    (%eax),%al
80103b54:	0f b6 c0             	movzbl %al,%eax
80103b57:	09 d0                	or     %edx,%eax
80103b59:	c1 e0 0a             	shl    $0xa,%eax
80103b5c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80103b5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b62:	2d 00 04 00 00       	sub    $0x400,%eax
80103b67:	83 ec 08             	sub    $0x8,%esp
80103b6a:	68 00 04 00 00       	push   $0x400
80103b6f:	50                   	push   %eax
80103b70:	e8 04 ff ff ff       	call   80103a79 <mpsearch1>
80103b75:	83 c4 10             	add    $0x10,%esp
80103b78:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103b7b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103b7f:	74 05                	je     80103b86 <mpsearch+0xa1>
      return mp;
80103b81:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103b84:	eb 15                	jmp    80103b9b <mpsearch+0xb6>
  }
  return mpsearch1(0xF0000, 0x10000);
80103b86:	83 ec 08             	sub    $0x8,%esp
80103b89:	68 00 00 01 00       	push   $0x10000
80103b8e:	68 00 00 0f 00       	push   $0xf0000
80103b93:	e8 e1 fe ff ff       	call   80103a79 <mpsearch1>
80103b98:	83 c4 10             	add    $0x10,%esp
}
80103b9b:	c9                   	leave  
80103b9c:	c3                   	ret    

80103b9d <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80103b9d:	55                   	push   %ebp
80103b9e:	89 e5                	mov    %esp,%ebp
80103ba0:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103ba3:	e8 3d ff ff ff       	call   80103ae5 <mpsearch>
80103ba8:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103bab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103baf:	74 0a                	je     80103bbb <mpconfig+0x1e>
80103bb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bb4:	8b 40 04             	mov    0x4(%eax),%eax
80103bb7:	85 c0                	test   %eax,%eax
80103bb9:	75 07                	jne    80103bc2 <mpconfig+0x25>
    return 0;
80103bbb:	b8 00 00 00 00       	mov    $0x0,%eax
80103bc0:	eb 7e                	jmp    80103c40 <mpconfig+0xa3>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
80103bc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bc5:	8b 40 04             	mov    0x4(%eax),%eax
80103bc8:	83 ec 0c             	sub    $0xc,%esp
80103bcb:	50                   	push   %eax
80103bcc:	e8 d0 fd ff ff       	call   801039a1 <p2v>
80103bd1:	83 c4 10             	add    $0x10,%esp
80103bd4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103bd7:	83 ec 04             	sub    $0x4,%esp
80103bda:	6a 04                	push   $0x4
80103bdc:	68 a5 86 10 80       	push   $0x801086a5
80103be1:	ff 75 f0             	pushl  -0x10(%ebp)
80103be4:	e8 1e 16 00 00       	call   80105207 <memcmp>
80103be9:	83 c4 10             	add    $0x10,%esp
80103bec:	85 c0                	test   %eax,%eax
80103bee:	74 07                	je     80103bf7 <mpconfig+0x5a>
    return 0;
80103bf0:	b8 00 00 00 00       	mov    $0x0,%eax
80103bf5:	eb 49                	jmp    80103c40 <mpconfig+0xa3>
  if(conf->version != 1 && conf->version != 4)
80103bf7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bfa:	8a 40 06             	mov    0x6(%eax),%al
80103bfd:	3c 01                	cmp    $0x1,%al
80103bff:	74 11                	je     80103c12 <mpconfig+0x75>
80103c01:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c04:	8a 40 06             	mov    0x6(%eax),%al
80103c07:	3c 04                	cmp    $0x4,%al
80103c09:	74 07                	je     80103c12 <mpconfig+0x75>
    return 0;
80103c0b:	b8 00 00 00 00       	mov    $0x0,%eax
80103c10:	eb 2e                	jmp    80103c40 <mpconfig+0xa3>
  if(sum((uchar*)conf, conf->length) != 0)
80103c12:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c15:	8b 40 04             	mov    0x4(%eax),%eax
80103c18:	0f b7 c0             	movzwl %ax,%eax
80103c1b:	83 ec 08             	sub    $0x8,%esp
80103c1e:	50                   	push   %eax
80103c1f:	ff 75 f0             	pushl  -0x10(%ebp)
80103c22:	e8 1c fe ff ff       	call   80103a43 <sum>
80103c27:	83 c4 10             	add    $0x10,%esp
80103c2a:	84 c0                	test   %al,%al
80103c2c:	74 07                	je     80103c35 <mpconfig+0x98>
    return 0;
80103c2e:	b8 00 00 00 00       	mov    $0x0,%eax
80103c33:	eb 0b                	jmp    80103c40 <mpconfig+0xa3>
  *pmp = mp;
80103c35:	8b 45 08             	mov    0x8(%ebp),%eax
80103c38:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103c3b:	89 10                	mov    %edx,(%eax)
  return conf;
80103c3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103c40:	c9                   	leave  
80103c41:	c3                   	ret    

80103c42 <mpinit>:

void
mpinit(void)
{
80103c42:	55                   	push   %ebp
80103c43:	89 e5                	mov    %esp,%ebp
80103c45:	53                   	push   %ebx
80103c46:	83 ec 24             	sub    $0x24,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
80103c49:	c7 05 44 b6 10 80 60 	movl   $0x80112360,0x8010b644
80103c50:	23 11 80 
  if((conf = mpconfig(&mp)) == 0)
80103c53:	83 ec 0c             	sub    $0xc,%esp
80103c56:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103c59:	50                   	push   %eax
80103c5a:	e8 3e ff ff ff       	call   80103b9d <mpconfig>
80103c5f:	83 c4 10             	add    $0x10,%esp
80103c62:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103c65:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103c69:	75 05                	jne    80103c70 <mpinit+0x2e>
    return;
80103c6b:	e9 a9 01 00 00       	jmp    80103e19 <mpinit+0x1d7>
  ismp = 1;
80103c70:	c7 05 44 23 11 80 01 	movl   $0x1,0x80112344
80103c77:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80103c7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c7d:	8b 40 24             	mov    0x24(%eax),%eax
80103c80:	a3 5c 22 11 80       	mov    %eax,0x8011225c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103c85:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c88:	83 c0 2c             	add    $0x2c,%eax
80103c8b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103c8e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c91:	8b 40 04             	mov    0x4(%eax),%eax
80103c94:	0f b7 d0             	movzwl %ax,%edx
80103c97:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c9a:	01 d0                	add    %edx,%eax
80103c9c:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103c9f:	e9 09 01 00 00       	jmp    80103dad <mpinit+0x16b>
    switch(*p){
80103ca4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ca7:	8a 00                	mov    (%eax),%al
80103ca9:	0f b6 c0             	movzbl %al,%eax
80103cac:	83 f8 04             	cmp    $0x4,%eax
80103caf:	0f 87 d5 00 00 00    	ja     80103d8a <mpinit+0x148>
80103cb5:	8b 04 85 e8 86 10 80 	mov    -0x7fef7918(,%eax,4),%eax
80103cbc:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
80103cbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103cc1:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(ncpu != proc->apicid){
80103cc4:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103cc7:	8a 40 01             	mov    0x1(%eax),%al
80103cca:	0f b6 d0             	movzbl %al,%edx
80103ccd:	a1 40 29 11 80       	mov    0x80112940,%eax
80103cd2:	39 c2                	cmp    %eax,%edx
80103cd4:	74 2a                	je     80103d00 <mpinit+0xbe>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
80103cd6:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103cd9:	8a 40 01             	mov    0x1(%eax),%al
80103cdc:	0f b6 d0             	movzbl %al,%edx
80103cdf:	a1 40 29 11 80       	mov    0x80112940,%eax
80103ce4:	83 ec 04             	sub    $0x4,%esp
80103ce7:	52                   	push   %edx
80103ce8:	50                   	push   %eax
80103ce9:	68 aa 86 10 80       	push   $0x801086aa
80103cee:	e8 c5 c6 ff ff       	call   801003b8 <cprintf>
80103cf3:	83 c4 10             	add    $0x10,%esp
        ismp = 0;
80103cf6:	c7 05 44 23 11 80 00 	movl   $0x0,0x80112344
80103cfd:	00 00 00 
      }
      if(proc->flags & MPBOOT)
80103d00:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103d03:	8a 40 03             	mov    0x3(%eax),%al
80103d06:	0f b6 c0             	movzbl %al,%eax
80103d09:	83 e0 02             	and    $0x2,%eax
80103d0c:	85 c0                	test   %eax,%eax
80103d0e:	74 24                	je     80103d34 <mpinit+0xf2>
        bcpu = &cpus[ncpu];
80103d10:	8b 15 40 29 11 80    	mov    0x80112940,%edx
80103d16:	89 d0                	mov    %edx,%eax
80103d18:	c1 e0 02             	shl    $0x2,%eax
80103d1b:	01 d0                	add    %edx,%eax
80103d1d:	01 c0                	add    %eax,%eax
80103d1f:	01 d0                	add    %edx,%eax
80103d21:	89 c1                	mov    %eax,%ecx
80103d23:	c1 e1 04             	shl    $0x4,%ecx
80103d26:	01 c8                	add    %ecx,%eax
80103d28:	01 d0                	add    %edx,%eax
80103d2a:	05 60 23 11 80       	add    $0x80112360,%eax
80103d2f:	a3 44 b6 10 80       	mov    %eax,0x8010b644
      cpus[ncpu].id = ncpu;
80103d34:	8b 15 40 29 11 80    	mov    0x80112940,%edx
80103d3a:	a1 40 29 11 80       	mov    0x80112940,%eax
80103d3f:	88 c1                	mov    %al,%cl
80103d41:	89 d0                	mov    %edx,%eax
80103d43:	c1 e0 02             	shl    $0x2,%eax
80103d46:	01 d0                	add    %edx,%eax
80103d48:	01 c0                	add    %eax,%eax
80103d4a:	01 d0                	add    %edx,%eax
80103d4c:	89 c3                	mov    %eax,%ebx
80103d4e:	c1 e3 04             	shl    $0x4,%ebx
80103d51:	01 d8                	add    %ebx,%eax
80103d53:	01 d0                	add    %edx,%eax
80103d55:	05 60 23 11 80       	add    $0x80112360,%eax
80103d5a:	88 08                	mov    %cl,(%eax)
      ncpu++;
80103d5c:	a1 40 29 11 80       	mov    0x80112940,%eax
80103d61:	40                   	inc    %eax
80103d62:	a3 40 29 11 80       	mov    %eax,0x80112940
      p += sizeof(struct mpproc);
80103d67:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103d6b:	eb 40                	jmp    80103dad <mpinit+0x16b>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103d6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d70:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
80103d73:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103d76:	8a 40 01             	mov    0x1(%eax),%al
80103d79:	a2 40 23 11 80       	mov    %al,0x80112340
      p += sizeof(struct mpioapic);
80103d7e:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103d82:	eb 29                	jmp    80103dad <mpinit+0x16b>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103d84:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103d88:	eb 23                	jmp    80103dad <mpinit+0x16b>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
80103d8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d8d:	8a 00                	mov    (%eax),%al
80103d8f:	0f b6 c0             	movzbl %al,%eax
80103d92:	83 ec 08             	sub    $0x8,%esp
80103d95:	50                   	push   %eax
80103d96:	68 c8 86 10 80       	push   $0x801086c8
80103d9b:	e8 18 c6 ff ff       	call   801003b8 <cprintf>
80103da0:	83 c4 10             	add    $0x10,%esp
      ismp = 0;
80103da3:	c7 05 44 23 11 80 00 	movl   $0x0,0x80112344
80103daa:	00 00 00 
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103dad:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103db0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103db3:	0f 82 eb fe ff ff    	jb     80103ca4 <mpinit+0x62>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      ismp = 0;
    }
  }
  if(!ismp){
80103db9:	a1 44 23 11 80       	mov    0x80112344,%eax
80103dbe:	85 c0                	test   %eax,%eax
80103dc0:	75 1d                	jne    80103ddf <mpinit+0x19d>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103dc2:	c7 05 40 29 11 80 01 	movl   $0x1,0x80112940
80103dc9:	00 00 00 
    lapic = 0;
80103dcc:	c7 05 5c 22 11 80 00 	movl   $0x0,0x8011225c
80103dd3:	00 00 00 
    ioapicid = 0;
80103dd6:	c6 05 40 23 11 80 00 	movb   $0x0,0x80112340
    return;
80103ddd:	eb 3a                	jmp    80103e19 <mpinit+0x1d7>
  }

  if(mp->imcrp){
80103ddf:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103de2:	8a 40 0c             	mov    0xc(%eax),%al
80103de5:	84 c0                	test   %al,%al
80103de7:	74 30                	je     80103e19 <mpinit+0x1d7>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103de9:	83 ec 08             	sub    $0x8,%esp
80103dec:	6a 70                	push   $0x70
80103dee:	6a 22                	push   $0x22
80103df0:	e8 d4 fb ff ff       	call   801039c9 <outb>
80103df5:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103df8:	83 ec 0c             	sub    $0xc,%esp
80103dfb:	6a 23                	push   $0x23
80103dfd:	e8 ac fb ff ff       	call   801039ae <inb>
80103e02:	83 c4 10             	add    $0x10,%esp
80103e05:	83 c8 01             	or     $0x1,%eax
80103e08:	0f b6 c0             	movzbl %al,%eax
80103e0b:	83 ec 08             	sub    $0x8,%esp
80103e0e:	50                   	push   %eax
80103e0f:	6a 23                	push   $0x23
80103e11:	e8 b3 fb ff ff       	call   801039c9 <outb>
80103e16:	83 c4 10             	add    $0x10,%esp
  }
}
80103e19:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e1c:	c9                   	leave  
80103e1d:	c3                   	ret    

80103e1e <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103e1e:	55                   	push   %ebp
80103e1f:	89 e5                	mov    %esp,%ebp
80103e21:	83 ec 08             	sub    $0x8,%esp
80103e24:	8b 45 08             	mov    0x8(%ebp),%eax
80103e27:	8b 55 0c             	mov    0xc(%ebp),%edx
80103e2a:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80103e2e:	88 55 f8             	mov    %dl,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103e31:	8a 45 f8             	mov    -0x8(%ebp),%al
80103e34:	8b 55 fc             	mov    -0x4(%ebp),%edx
80103e37:	ee                   	out    %al,(%dx)
}
80103e38:	c9                   	leave  
80103e39:	c3                   	ret    

80103e3a <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
80103e3a:	55                   	push   %ebp
80103e3b:	89 e5                	mov    %esp,%ebp
80103e3d:	83 ec 04             	sub    $0x4,%esp
80103e40:	8b 45 08             	mov    0x8(%ebp),%eax
80103e43:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
80103e47:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103e4a:	66 a3 00 b0 10 80    	mov    %ax,0x8010b000
  outb(IO_PIC1+1, mask);
80103e50:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103e53:	0f b6 c0             	movzbl %al,%eax
80103e56:	50                   	push   %eax
80103e57:	6a 21                	push   $0x21
80103e59:	e8 c0 ff ff ff       	call   80103e1e <outb>
80103e5e:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, mask >> 8);
80103e61:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103e64:	66 c1 e8 08          	shr    $0x8,%ax
80103e68:	0f b6 c0             	movzbl %al,%eax
80103e6b:	50                   	push   %eax
80103e6c:	68 a1 00 00 00       	push   $0xa1
80103e71:	e8 a8 ff ff ff       	call   80103e1e <outb>
80103e76:	83 c4 08             	add    $0x8,%esp
}
80103e79:	c9                   	leave  
80103e7a:	c3                   	ret    

80103e7b <picenable>:

void
picenable(int irq)
{
80103e7b:	55                   	push   %ebp
80103e7c:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
80103e7e:	8b 45 08             	mov    0x8(%ebp),%eax
80103e81:	ba 01 00 00 00       	mov    $0x1,%edx
80103e86:	88 c1                	mov    %al,%cl
80103e88:	d3 e2                	shl    %cl,%edx
80103e8a:	89 d0                	mov    %edx,%eax
80103e8c:	f7 d0                	not    %eax
80103e8e:	89 c2                	mov    %eax,%edx
80103e90:	66 a1 00 b0 10 80    	mov    0x8010b000,%ax
80103e96:	21 d0                	and    %edx,%eax
80103e98:	0f b7 c0             	movzwl %ax,%eax
80103e9b:	50                   	push   %eax
80103e9c:	e8 99 ff ff ff       	call   80103e3a <picsetmask>
80103ea1:	83 c4 04             	add    $0x4,%esp
}
80103ea4:	c9                   	leave  
80103ea5:	c3                   	ret    

80103ea6 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103ea6:	55                   	push   %ebp
80103ea7:	89 e5                	mov    %esp,%ebp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80103ea9:	68 ff 00 00 00       	push   $0xff
80103eae:	6a 21                	push   $0x21
80103eb0:	e8 69 ff ff ff       	call   80103e1e <outb>
80103eb5:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, 0xFF);
80103eb8:	68 ff 00 00 00       	push   $0xff
80103ebd:	68 a1 00 00 00       	push   $0xa1
80103ec2:	e8 57 ff ff ff       	call   80103e1e <outb>
80103ec7:	83 c4 08             	add    $0x8,%esp

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
80103eca:	6a 11                	push   $0x11
80103ecc:	6a 20                	push   $0x20
80103ece:	e8 4b ff ff ff       	call   80103e1e <outb>
80103ed3:	83 c4 08             	add    $0x8,%esp

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
80103ed6:	6a 20                	push   $0x20
80103ed8:	6a 21                	push   $0x21
80103eda:	e8 3f ff ff ff       	call   80103e1e <outb>
80103edf:	83 c4 08             	add    $0x8,%esp

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
80103ee2:	6a 04                	push   $0x4
80103ee4:	6a 21                	push   $0x21
80103ee6:	e8 33 ff ff ff       	call   80103e1e <outb>
80103eeb:	83 c4 08             	add    $0x8,%esp
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
80103eee:	6a 03                	push   $0x3
80103ef0:	6a 21                	push   $0x21
80103ef2:	e8 27 ff ff ff       	call   80103e1e <outb>
80103ef7:	83 c4 08             	add    $0x8,%esp

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
80103efa:	6a 11                	push   $0x11
80103efc:	68 a0 00 00 00       	push   $0xa0
80103f01:	e8 18 ff ff ff       	call   80103e1e <outb>
80103f06:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
80103f09:	6a 28                	push   $0x28
80103f0b:	68 a1 00 00 00       	push   $0xa1
80103f10:	e8 09 ff ff ff       	call   80103e1e <outb>
80103f15:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
80103f18:	6a 02                	push   $0x2
80103f1a:	68 a1 00 00 00       	push   $0xa1
80103f1f:	e8 fa fe ff ff       	call   80103e1e <outb>
80103f24:	83 c4 08             	add    $0x8,%esp
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
80103f27:	6a 03                	push   $0x3
80103f29:	68 a1 00 00 00       	push   $0xa1
80103f2e:	e8 eb fe ff ff       	call   80103e1e <outb>
80103f33:	83 c4 08             	add    $0x8,%esp

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
80103f36:	6a 68                	push   $0x68
80103f38:	6a 20                	push   $0x20
80103f3a:	e8 df fe ff ff       	call   80103e1e <outb>
80103f3f:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC1, 0x0a);             // read IRR by default
80103f42:	6a 0a                	push   $0xa
80103f44:	6a 20                	push   $0x20
80103f46:	e8 d3 fe ff ff       	call   80103e1e <outb>
80103f4b:	83 c4 08             	add    $0x8,%esp

  outb(IO_PIC2, 0x68);             // OCW3
80103f4e:	6a 68                	push   $0x68
80103f50:	68 a0 00 00 00       	push   $0xa0
80103f55:	e8 c4 fe ff ff       	call   80103e1e <outb>
80103f5a:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2, 0x0a);             // OCW3
80103f5d:	6a 0a                	push   $0xa
80103f5f:	68 a0 00 00 00       	push   $0xa0
80103f64:	e8 b5 fe ff ff       	call   80103e1e <outb>
80103f69:	83 c4 08             	add    $0x8,%esp

  if(irqmask != 0xFFFF)
80103f6c:	66 a1 00 b0 10 80    	mov    0x8010b000,%ax
80103f72:	66 83 f8 ff          	cmp    $0xffff,%ax
80103f76:	74 12                	je     80103f8a <picinit+0xe4>
    picsetmask(irqmask);
80103f78:	66 a1 00 b0 10 80    	mov    0x8010b000,%ax
80103f7e:	0f b7 c0             	movzwl %ax,%eax
80103f81:	50                   	push   %eax
80103f82:	e8 b3 fe ff ff       	call   80103e3a <picsetmask>
80103f87:	83 c4 04             	add    $0x4,%esp
}
80103f8a:	c9                   	leave  
80103f8b:	c3                   	ret    

80103f8c <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103f8c:	55                   	push   %ebp
80103f8d:	89 e5                	mov    %esp,%ebp
80103f8f:	83 ec 18             	sub    $0x18,%esp
  struct pipe *p;

  p = 0;
80103f92:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80103f99:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f9c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103fa2:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fa5:	8b 10                	mov    (%eax),%edx
80103fa7:	8b 45 08             	mov    0x8(%ebp),%eax
80103faa:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103fac:	e8 7a cf ff ff       	call   80100f2b <filealloc>
80103fb1:	8b 55 08             	mov    0x8(%ebp),%edx
80103fb4:	89 02                	mov    %eax,(%edx)
80103fb6:	8b 45 08             	mov    0x8(%ebp),%eax
80103fb9:	8b 00                	mov    (%eax),%eax
80103fbb:	85 c0                	test   %eax,%eax
80103fbd:	0f 84 c9 00 00 00    	je     8010408c <pipealloc+0x100>
80103fc3:	e8 63 cf ff ff       	call   80100f2b <filealloc>
80103fc8:	8b 55 0c             	mov    0xc(%ebp),%edx
80103fcb:	89 02                	mov    %eax,(%edx)
80103fcd:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fd0:	8b 00                	mov    (%eax),%eax
80103fd2:	85 c0                	test   %eax,%eax
80103fd4:	0f 84 b2 00 00 00    	je     8010408c <pipealloc+0x100>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103fda:	e8 ce eb ff ff       	call   80102bad <kalloc>
80103fdf:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103fe2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103fe6:	75 05                	jne    80103fed <pipealloc+0x61>
    goto bad;
80103fe8:	e9 9f 00 00 00       	jmp    8010408c <pipealloc+0x100>
  p->readopen = 1;
80103fed:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ff0:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103ff7:	00 00 00 
  p->writeopen = 1;
80103ffa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ffd:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80104004:	00 00 00 
  p->nwrite = 0;
80104007:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010400a:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80104011:	00 00 00 
  p->nread = 0;
80104014:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104017:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
8010401e:	00 00 00 
  initlock(&p->lock, "pipe");
80104021:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104024:	83 ec 08             	sub    $0x8,%esp
80104027:	68 fc 86 10 80       	push   $0x801086fc
8010402c:	50                   	push   %eax
8010402d:	e8 f5 0e 00 00       	call   80104f27 <initlock>
80104032:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80104035:	8b 45 08             	mov    0x8(%ebp),%eax
80104038:	8b 00                	mov    (%eax),%eax
8010403a:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80104040:	8b 45 08             	mov    0x8(%ebp),%eax
80104043:	8b 00                	mov    (%eax),%eax
80104045:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80104049:	8b 45 08             	mov    0x8(%ebp),%eax
8010404c:	8b 00                	mov    (%eax),%eax
8010404e:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80104052:	8b 45 08             	mov    0x8(%ebp),%eax
80104055:	8b 00                	mov    (%eax),%eax
80104057:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010405a:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010405d:	8b 45 0c             	mov    0xc(%ebp),%eax
80104060:	8b 00                	mov    (%eax),%eax
80104062:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80104068:	8b 45 0c             	mov    0xc(%ebp),%eax
8010406b:	8b 00                	mov    (%eax),%eax
8010406d:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80104071:	8b 45 0c             	mov    0xc(%ebp),%eax
80104074:	8b 00                	mov    (%eax),%eax
80104076:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010407a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010407d:	8b 00                	mov    (%eax),%eax
8010407f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104082:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
80104085:	b8 00 00 00 00       	mov    $0x0,%eax
8010408a:	eb 4d                	jmp    801040d9 <pipealloc+0x14d>

//PAGEBREAK: 20
 bad:
  if(p)
8010408c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104090:	74 0e                	je     801040a0 <pipealloc+0x114>
    kfree((char*)p);
80104092:	83 ec 0c             	sub    $0xc,%esp
80104095:	ff 75 f4             	pushl  -0xc(%ebp)
80104098:	e8 74 ea ff ff       	call   80102b11 <kfree>
8010409d:	83 c4 10             	add    $0x10,%esp
  if(*f0)
801040a0:	8b 45 08             	mov    0x8(%ebp),%eax
801040a3:	8b 00                	mov    (%eax),%eax
801040a5:	85 c0                	test   %eax,%eax
801040a7:	74 11                	je     801040ba <pipealloc+0x12e>
    fileclose(*f0);
801040a9:	8b 45 08             	mov    0x8(%ebp),%eax
801040ac:	8b 00                	mov    (%eax),%eax
801040ae:	83 ec 0c             	sub    $0xc,%esp
801040b1:	50                   	push   %eax
801040b2:	e8 31 cf ff ff       	call   80100fe8 <fileclose>
801040b7:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801040ba:	8b 45 0c             	mov    0xc(%ebp),%eax
801040bd:	8b 00                	mov    (%eax),%eax
801040bf:	85 c0                	test   %eax,%eax
801040c1:	74 11                	je     801040d4 <pipealloc+0x148>
    fileclose(*f1);
801040c3:	8b 45 0c             	mov    0xc(%ebp),%eax
801040c6:	8b 00                	mov    (%eax),%eax
801040c8:	83 ec 0c             	sub    $0xc,%esp
801040cb:	50                   	push   %eax
801040cc:	e8 17 cf ff ff       	call   80100fe8 <fileclose>
801040d1:	83 c4 10             	add    $0x10,%esp
  return -1;
801040d4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801040d9:	c9                   	leave  
801040da:	c3                   	ret    

801040db <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801040db:	55                   	push   %ebp
801040dc:	89 e5                	mov    %esp,%ebp
801040de:	83 ec 08             	sub    $0x8,%esp
  acquire(&p->lock);
801040e1:	8b 45 08             	mov    0x8(%ebp),%eax
801040e4:	83 ec 0c             	sub    $0xc,%esp
801040e7:	50                   	push   %eax
801040e8:	e8 5b 0e 00 00       	call   80104f48 <acquire>
801040ed:	83 c4 10             	add    $0x10,%esp
  if(writable){
801040f0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801040f4:	74 23                	je     80104119 <pipeclose+0x3e>
    p->writeopen = 0;
801040f6:	8b 45 08             	mov    0x8(%ebp),%eax
801040f9:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
80104100:	00 00 00 
    wakeup(&p->nread);
80104103:	8b 45 08             	mov    0x8(%ebp),%eax
80104106:	05 34 02 00 00       	add    $0x234,%eax
8010410b:	83 ec 0c             	sub    $0xc,%esp
8010410e:	50                   	push   %eax
8010410f:	e8 30 0c 00 00       	call   80104d44 <wakeup>
80104114:	83 c4 10             	add    $0x10,%esp
80104117:	eb 21                	jmp    8010413a <pipeclose+0x5f>
  } else {
    p->readopen = 0;
80104119:	8b 45 08             	mov    0x8(%ebp),%eax
8010411c:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
80104123:	00 00 00 
    wakeup(&p->nwrite);
80104126:	8b 45 08             	mov    0x8(%ebp),%eax
80104129:	05 38 02 00 00       	add    $0x238,%eax
8010412e:	83 ec 0c             	sub    $0xc,%esp
80104131:	50                   	push   %eax
80104132:	e8 0d 0c 00 00       	call   80104d44 <wakeup>
80104137:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
8010413a:	8b 45 08             	mov    0x8(%ebp),%eax
8010413d:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104143:	85 c0                	test   %eax,%eax
80104145:	75 2c                	jne    80104173 <pipeclose+0x98>
80104147:	8b 45 08             	mov    0x8(%ebp),%eax
8010414a:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80104150:	85 c0                	test   %eax,%eax
80104152:	75 1f                	jne    80104173 <pipeclose+0x98>
    release(&p->lock);
80104154:	8b 45 08             	mov    0x8(%ebp),%eax
80104157:	83 ec 0c             	sub    $0xc,%esp
8010415a:	50                   	push   %eax
8010415b:	e8 4e 0e 00 00       	call   80104fae <release>
80104160:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
80104163:	83 ec 0c             	sub    $0xc,%esp
80104166:	ff 75 08             	pushl  0x8(%ebp)
80104169:	e8 a3 e9 ff ff       	call   80102b11 <kfree>
8010416e:	83 c4 10             	add    $0x10,%esp
80104171:	eb 0f                	jmp    80104182 <pipeclose+0xa7>
  } else
    release(&p->lock);
80104173:	8b 45 08             	mov    0x8(%ebp),%eax
80104176:	83 ec 0c             	sub    $0xc,%esp
80104179:	50                   	push   %eax
8010417a:	e8 2f 0e 00 00       	call   80104fae <release>
8010417f:	83 c4 10             	add    $0x10,%esp
}
80104182:	c9                   	leave  
80104183:	c3                   	ret    

80104184 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80104184:	55                   	push   %ebp
80104185:	89 e5                	mov    %esp,%ebp
80104187:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&p->lock);
8010418a:	8b 45 08             	mov    0x8(%ebp),%eax
8010418d:	83 ec 0c             	sub    $0xc,%esp
80104190:	50                   	push   %eax
80104191:	e8 b2 0d 00 00       	call   80104f48 <acquire>
80104196:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
80104199:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801041a0:	e9 ad 00 00 00       	jmp    80104252 <pipewrite+0xce>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801041a5:	eb 60                	jmp    80104207 <pipewrite+0x83>
      if(p->readopen == 0 || proc->killed){
801041a7:	8b 45 08             	mov    0x8(%ebp),%eax
801041aa:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
801041b0:	85 c0                	test   %eax,%eax
801041b2:	74 0d                	je     801041c1 <pipewrite+0x3d>
801041b4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801041ba:	8b 40 24             	mov    0x24(%eax),%eax
801041bd:	85 c0                	test   %eax,%eax
801041bf:	74 19                	je     801041da <pipewrite+0x56>
        release(&p->lock);
801041c1:	8b 45 08             	mov    0x8(%ebp),%eax
801041c4:	83 ec 0c             	sub    $0xc,%esp
801041c7:	50                   	push   %eax
801041c8:	e8 e1 0d 00 00       	call   80104fae <release>
801041cd:	83 c4 10             	add    $0x10,%esp
        return -1;
801041d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801041d5:	e9 aa 00 00 00       	jmp    80104284 <pipewrite+0x100>
      }
      wakeup(&p->nread);
801041da:	8b 45 08             	mov    0x8(%ebp),%eax
801041dd:	05 34 02 00 00       	add    $0x234,%eax
801041e2:	83 ec 0c             	sub    $0xc,%esp
801041e5:	50                   	push   %eax
801041e6:	e8 59 0b 00 00       	call   80104d44 <wakeup>
801041eb:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801041ee:	8b 45 08             	mov    0x8(%ebp),%eax
801041f1:	8b 55 08             	mov    0x8(%ebp),%edx
801041f4:	81 c2 38 02 00 00    	add    $0x238,%edx
801041fa:	83 ec 08             	sub    $0x8,%esp
801041fd:	50                   	push   %eax
801041fe:	52                   	push   %edx
801041ff:	e8 57 0a 00 00       	call   80104c5b <sleep>
80104204:	83 c4 10             	add    $0x10,%esp
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104207:	8b 45 08             	mov    0x8(%ebp),%eax
8010420a:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
80104210:	8b 45 08             	mov    0x8(%ebp),%eax
80104213:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104219:	05 00 02 00 00       	add    $0x200,%eax
8010421e:	39 c2                	cmp    %eax,%edx
80104220:	74 85                	je     801041a7 <pipewrite+0x23>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104222:	8b 45 08             	mov    0x8(%ebp),%eax
80104225:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
8010422b:	8d 48 01             	lea    0x1(%eax),%ecx
8010422e:	8b 55 08             	mov    0x8(%ebp),%edx
80104231:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
80104237:	25 ff 01 00 00       	and    $0x1ff,%eax
8010423c:	89 c1                	mov    %eax,%ecx
8010423e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104241:	8b 45 0c             	mov    0xc(%ebp),%eax
80104244:	01 d0                	add    %edx,%eax
80104246:	8a 10                	mov    (%eax),%dl
80104248:	8b 45 08             	mov    0x8(%ebp),%eax
8010424b:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
8010424f:	ff 45 f4             	incl   -0xc(%ebp)
80104252:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104255:	3b 45 10             	cmp    0x10(%ebp),%eax
80104258:	0f 8c 47 ff ff ff    	jl     801041a5 <pipewrite+0x21>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
8010425e:	8b 45 08             	mov    0x8(%ebp),%eax
80104261:	05 34 02 00 00       	add    $0x234,%eax
80104266:	83 ec 0c             	sub    $0xc,%esp
80104269:	50                   	push   %eax
8010426a:	e8 d5 0a 00 00       	call   80104d44 <wakeup>
8010426f:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
80104272:	8b 45 08             	mov    0x8(%ebp),%eax
80104275:	83 ec 0c             	sub    $0xc,%esp
80104278:	50                   	push   %eax
80104279:	e8 30 0d 00 00       	call   80104fae <release>
8010427e:	83 c4 10             	add    $0x10,%esp
  return n;
80104281:	8b 45 10             	mov    0x10(%ebp),%eax
}
80104284:	c9                   	leave  
80104285:	c3                   	ret    

80104286 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80104286:	55                   	push   %ebp
80104287:	89 e5                	mov    %esp,%ebp
80104289:	53                   	push   %ebx
8010428a:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&p->lock);
8010428d:	8b 45 08             	mov    0x8(%ebp),%eax
80104290:	83 ec 0c             	sub    $0xc,%esp
80104293:	50                   	push   %eax
80104294:	e8 af 0c 00 00       	call   80104f48 <acquire>
80104299:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010429c:	eb 3f                	jmp    801042dd <piperead+0x57>
    if(proc->killed){
8010429e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801042a4:	8b 40 24             	mov    0x24(%eax),%eax
801042a7:	85 c0                	test   %eax,%eax
801042a9:	74 19                	je     801042c4 <piperead+0x3e>
      release(&p->lock);
801042ab:	8b 45 08             	mov    0x8(%ebp),%eax
801042ae:	83 ec 0c             	sub    $0xc,%esp
801042b1:	50                   	push   %eax
801042b2:	e8 f7 0c 00 00       	call   80104fae <release>
801042b7:	83 c4 10             	add    $0x10,%esp
      return -1;
801042ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042bf:	e9 bc 00 00 00       	jmp    80104380 <piperead+0xfa>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801042c4:	8b 45 08             	mov    0x8(%ebp),%eax
801042c7:	8b 55 08             	mov    0x8(%ebp),%edx
801042ca:	81 c2 34 02 00 00    	add    $0x234,%edx
801042d0:	83 ec 08             	sub    $0x8,%esp
801042d3:	50                   	push   %eax
801042d4:	52                   	push   %edx
801042d5:	e8 81 09 00 00       	call   80104c5b <sleep>
801042da:	83 c4 10             	add    $0x10,%esp
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801042dd:	8b 45 08             	mov    0x8(%ebp),%eax
801042e0:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
801042e6:	8b 45 08             	mov    0x8(%ebp),%eax
801042e9:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801042ef:	39 c2                	cmp    %eax,%edx
801042f1:	75 0d                	jne    80104300 <piperead+0x7a>
801042f3:	8b 45 08             	mov    0x8(%ebp),%eax
801042f6:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
801042fc:	85 c0                	test   %eax,%eax
801042fe:	75 9e                	jne    8010429e <piperead+0x18>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104300:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104307:	eb 49                	jmp    80104352 <piperead+0xcc>
    if(p->nread == p->nwrite)
80104309:	8b 45 08             	mov    0x8(%ebp),%eax
8010430c:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104312:	8b 45 08             	mov    0x8(%ebp),%eax
80104315:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
8010431b:	39 c2                	cmp    %eax,%edx
8010431d:	75 02                	jne    80104321 <piperead+0x9b>
      break;
8010431f:	eb 39                	jmp    8010435a <piperead+0xd4>
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104321:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104324:	8b 45 0c             	mov    0xc(%ebp),%eax
80104327:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
8010432a:	8b 45 08             	mov    0x8(%ebp),%eax
8010432d:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104333:	8d 48 01             	lea    0x1(%eax),%ecx
80104336:	8b 55 08             	mov    0x8(%ebp),%edx
80104339:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
8010433f:	25 ff 01 00 00       	and    $0x1ff,%eax
80104344:	89 c2                	mov    %eax,%edx
80104346:	8b 45 08             	mov    0x8(%ebp),%eax
80104349:	8a 44 10 34          	mov    0x34(%eax,%edx,1),%al
8010434d:	88 03                	mov    %al,(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010434f:	ff 45 f4             	incl   -0xc(%ebp)
80104352:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104355:	3b 45 10             	cmp    0x10(%ebp),%eax
80104358:	7c af                	jl     80104309 <piperead+0x83>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010435a:	8b 45 08             	mov    0x8(%ebp),%eax
8010435d:	05 38 02 00 00       	add    $0x238,%eax
80104362:	83 ec 0c             	sub    $0xc,%esp
80104365:	50                   	push   %eax
80104366:	e8 d9 09 00 00       	call   80104d44 <wakeup>
8010436b:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
8010436e:	8b 45 08             	mov    0x8(%ebp),%eax
80104371:	83 ec 0c             	sub    $0xc,%esp
80104374:	50                   	push   %eax
80104375:	e8 34 0c 00 00       	call   80104fae <release>
8010437a:	83 c4 10             	add    $0x10,%esp
  return i;
8010437d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104380:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104383:	c9                   	leave  
80104384:	c3                   	ret    

80104385 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80104385:	55                   	push   %ebp
80104386:	89 e5                	mov    %esp,%ebp
80104388:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
8010438b:	9c                   	pushf  
8010438c:	58                   	pop    %eax
8010438d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80104390:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104393:	c9                   	leave  
80104394:	c3                   	ret    

80104395 <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
80104395:	55                   	push   %ebp
80104396:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104398:	fb                   	sti    
}
80104399:	5d                   	pop    %ebp
8010439a:	c3                   	ret    

8010439b <hlt>:

static inline void
hlt(void)
{
8010439b:	55                   	push   %ebp
8010439c:	89 e5                	mov    %esp,%ebp
  asm volatile("hlt");
8010439e:	f4                   	hlt    
}
8010439f:	5d                   	pop    %ebp
801043a0:	c3                   	ret    

801043a1 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
801043a1:	55                   	push   %ebp
801043a2:	89 e5                	mov    %esp,%ebp
801043a4:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
801043a7:	83 ec 08             	sub    $0x8,%esp
801043aa:	68 01 87 10 80       	push   $0x80108701
801043af:	68 60 29 11 80       	push   $0x80112960
801043b4:	e8 6e 0b 00 00       	call   80104f27 <initlock>
801043b9:	83 c4 10             	add    $0x10,%esp
}
801043bc:	c9                   	leave  
801043bd:	c3                   	ret    

801043be <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801043be:	55                   	push   %ebp
801043bf:	89 e5                	mov    %esp,%ebp
801043c1:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801043c4:	83 ec 0c             	sub    $0xc,%esp
801043c7:	68 60 29 11 80       	push   $0x80112960
801043cc:	e8 77 0b 00 00       	call   80104f48 <acquire>
801043d1:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801043d4:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
801043db:	eb 54                	jmp    80104431 <allocproc+0x73>
    if(p->state == UNUSED)
801043dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043e0:	8b 40 0c             	mov    0xc(%eax),%eax
801043e3:	85 c0                	test   %eax,%eax
801043e5:	75 46                	jne    8010442d <allocproc+0x6f>
      goto found;
801043e7:	90                   	nop
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
801043e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043eb:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
801043f2:	a1 04 b0 10 80       	mov    0x8010b004,%eax
801043f7:	8d 50 01             	lea    0x1(%eax),%edx
801043fa:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
80104400:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104403:	89 42 10             	mov    %eax,0x10(%edx)
  release(&ptable.lock);
80104406:	83 ec 0c             	sub    $0xc,%esp
80104409:	68 60 29 11 80       	push   $0x80112960
8010440e:	e8 9b 0b 00 00       	call   80104fae <release>
80104413:	83 c4 10             	add    $0x10,%esp

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80104416:	e8 92 e7 ff ff       	call   80102bad <kalloc>
8010441b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010441e:	89 42 08             	mov    %eax,0x8(%edx)
80104421:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104424:	8b 40 08             	mov    0x8(%eax),%eax
80104427:	85 c0                	test   %eax,%eax
80104429:	75 37                	jne    80104462 <allocproc+0xa4>
8010442b:	eb 24                	jmp    80104451 <allocproc+0x93>
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010442d:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104431:	81 7d f4 94 48 11 80 	cmpl   $0x80114894,-0xc(%ebp)
80104438:	72 a3                	jb     801043dd <allocproc+0x1f>
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
8010443a:	83 ec 0c             	sub    $0xc,%esp
8010443d:	68 60 29 11 80       	push   $0x80112960
80104442:	e8 67 0b 00 00       	call   80104fae <release>
80104447:	83 c4 10             	add    $0x10,%esp
  return 0;
8010444a:	b8 00 00 00 00       	mov    $0x0,%eax
8010444f:	eb 6e                	jmp    801044bf <allocproc+0x101>
  p->pid = nextpid++;
  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80104451:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104454:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
8010445b:	b8 00 00 00 00       	mov    $0x0,%eax
80104460:	eb 5d                	jmp    801044bf <allocproc+0x101>
  }
  sp = p->kstack + KSTACKSIZE;
80104462:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104465:	8b 40 08             	mov    0x8(%eax),%eax
80104468:	05 00 10 00 00       	add    $0x1000,%eax
8010446d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80104470:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
80104474:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104477:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010447a:	89 50 18             	mov    %edx,0x18(%eax)
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
8010447d:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
80104481:	ba 42 65 10 80       	mov    $0x80106542,%edx
80104486:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104489:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
8010448b:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
8010448f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104492:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104495:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
80104498:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010449b:	8b 40 1c             	mov    0x1c(%eax),%eax
8010449e:	83 ec 04             	sub    $0x4,%esp
801044a1:	6a 14                	push   $0x14
801044a3:	6a 00                	push   $0x0
801044a5:	50                   	push   %eax
801044a6:	e8 f5 0c 00 00       	call   801051a0 <memset>
801044ab:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
801044ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044b1:	8b 40 1c             	mov    0x1c(%eax),%eax
801044b4:	ba 16 4c 10 80       	mov    $0x80104c16,%edx
801044b9:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
801044bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801044bf:	c9                   	leave  
801044c0:	c3                   	ret    

801044c1 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801044c1:	55                   	push   %ebp
801044c2:	89 e5                	mov    %esp,%ebp
801044c4:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
801044c7:	e8 f2 fe ff ff       	call   801043be <allocproc>
801044cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  initproc = p;
801044cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044d2:	a3 48 b6 10 80       	mov    %eax,0x8010b648
  if((p->pgdir = setupkvm()) == 0)
801044d7:	e8 d0 36 00 00       	call   80107bac <setupkvm>
801044dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
801044df:	89 42 04             	mov    %eax,0x4(%edx)
801044e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044e5:	8b 40 04             	mov    0x4(%eax),%eax
801044e8:	85 c0                	test   %eax,%eax
801044ea:	75 0d                	jne    801044f9 <userinit+0x38>
    panic("userinit: out of memory?");
801044ec:	83 ec 0c             	sub    $0xc,%esp
801044ef:	68 08 87 10 80       	push   $0x80108708
801044f4:	e8 55 c0 ff ff       	call   8010054e <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801044f9:	ba 2c 00 00 00       	mov    $0x2c,%edx
801044fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104501:	8b 40 04             	mov    0x4(%eax),%eax
80104504:	83 ec 04             	sub    $0x4,%esp
80104507:	52                   	push   %edx
80104508:	68 e0 b4 10 80       	push   $0x8010b4e0
8010450d:	50                   	push   %eax
8010450e:	e8 e2 38 00 00       	call   80107df5 <inituvm>
80104513:	83 c4 10             	add    $0x10,%esp
  p->sz = PGSIZE;
80104516:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104519:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
8010451f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104522:	8b 40 18             	mov    0x18(%eax),%eax
80104525:	83 ec 04             	sub    $0x4,%esp
80104528:	6a 4c                	push   $0x4c
8010452a:	6a 00                	push   $0x0
8010452c:	50                   	push   %eax
8010452d:	e8 6e 0c 00 00       	call   801051a0 <memset>
80104532:	83 c4 10             	add    $0x10,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80104535:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104538:	8b 40 18             	mov    0x18(%eax),%eax
8010453b:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104541:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104544:	8b 40 18             	mov    0x18(%eax),%eax
80104547:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
8010454d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104550:	8b 50 18             	mov    0x18(%eax),%edx
80104553:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104556:	8b 40 18             	mov    0x18(%eax),%eax
80104559:	8b 40 2c             	mov    0x2c(%eax),%eax
8010455c:	66 89 42 28          	mov    %ax,0x28(%edx)
  p->tf->ss = p->tf->ds;
80104560:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104563:	8b 50 18             	mov    0x18(%eax),%edx
80104566:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104569:	8b 40 18             	mov    0x18(%eax),%eax
8010456c:	8b 40 2c             	mov    0x2c(%eax),%eax
8010456f:	66 89 42 48          	mov    %ax,0x48(%edx)
  p->tf->eflags = FL_IF;
80104573:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104576:	8b 40 18             	mov    0x18(%eax),%eax
80104579:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104580:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104583:	8b 40 18             	mov    0x18(%eax),%eax
80104586:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
8010458d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104590:	8b 40 18             	mov    0x18(%eax),%eax
80104593:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
8010459a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010459d:	83 c0 6c             	add    $0x6c,%eax
801045a0:	83 ec 04             	sub    $0x4,%esp
801045a3:	6a 10                	push   $0x10
801045a5:	68 21 87 10 80       	push   $0x80108721
801045aa:	50                   	push   %eax
801045ab:	e8 e1 0d 00 00       	call   80105391 <safestrcpy>
801045b0:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
801045b3:	83 ec 0c             	sub    $0xc,%esp
801045b6:	68 2a 87 10 80       	push   $0x8010872a
801045bb:	e8 cd de ff ff       	call   8010248d <namei>
801045c0:	83 c4 10             	add    $0x10,%esp
801045c3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801045c6:	89 42 68             	mov    %eax,0x68(%edx)

  p->state = RUNNABLE;
801045c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045cc:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
}
801045d3:	c9                   	leave  
801045d4:	c3                   	ret    

801045d5 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
801045d5:	55                   	push   %ebp
801045d6:	89 e5                	mov    %esp,%ebp
801045d8:	83 ec 18             	sub    $0x18,%esp
  uint sz;
  
  sz = proc->sz;
801045db:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045e1:	8b 00                	mov    (%eax),%eax
801045e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
801045e6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801045ea:	7e 31                	jle    8010461d <growproc+0x48>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
801045ec:	8b 55 08             	mov    0x8(%ebp),%edx
801045ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045f2:	01 c2                	add    %eax,%edx
801045f4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045fa:	8b 40 04             	mov    0x4(%eax),%eax
801045fd:	83 ec 04             	sub    $0x4,%esp
80104600:	52                   	push   %edx
80104601:	ff 75 f4             	pushl  -0xc(%ebp)
80104604:	50                   	push   %eax
80104605:	e8 37 39 00 00       	call   80107f41 <allocuvm>
8010460a:	83 c4 10             	add    $0x10,%esp
8010460d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104610:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104614:	75 3e                	jne    80104654 <growproc+0x7f>
      return -1;
80104616:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010461b:	eb 59                	jmp    80104676 <growproc+0xa1>
  } else if(n < 0){
8010461d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104621:	79 31                	jns    80104654 <growproc+0x7f>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80104623:	8b 55 08             	mov    0x8(%ebp),%edx
80104626:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104629:	01 c2                	add    %eax,%edx
8010462b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104631:	8b 40 04             	mov    0x4(%eax),%eax
80104634:	83 ec 04             	sub    $0x4,%esp
80104637:	52                   	push   %edx
80104638:	ff 75 f4             	pushl  -0xc(%ebp)
8010463b:	50                   	push   %eax
8010463c:	e8 c7 39 00 00       	call   80108008 <deallocuvm>
80104641:	83 c4 10             	add    $0x10,%esp
80104644:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104647:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010464b:	75 07                	jne    80104654 <growproc+0x7f>
      return -1;
8010464d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104652:	eb 22                	jmp    80104676 <growproc+0xa1>
  }
  proc->sz = sz;
80104654:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010465a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010465d:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
8010465f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104665:	83 ec 0c             	sub    $0xc,%esp
80104668:	50                   	push   %eax
80104669:	e8 23 36 00 00       	call   80107c91 <switchuvm>
8010466e:	83 c4 10             	add    $0x10,%esp
  return 0;
80104671:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104676:	c9                   	leave  
80104677:	c3                   	ret    

80104678 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80104678:	55                   	push   %ebp
80104679:	89 e5                	mov    %esp,%ebp
8010467b:	57                   	push   %edi
8010467c:	56                   	push   %esi
8010467d:	53                   	push   %ebx
8010467e:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
80104681:	e8 38 fd ff ff       	call   801043be <allocproc>
80104686:	89 45 e0             	mov    %eax,-0x20(%ebp)
80104689:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
8010468d:	75 0a                	jne    80104699 <fork+0x21>
    return -1;
8010468f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104694:	e9 61 01 00 00       	jmp    801047fa <fork+0x182>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80104699:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010469f:	8b 10                	mov    (%eax),%edx
801046a1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046a7:	8b 40 04             	mov    0x4(%eax),%eax
801046aa:	83 ec 08             	sub    $0x8,%esp
801046ad:	52                   	push   %edx
801046ae:	50                   	push   %eax
801046af:	e8 ef 3a 00 00       	call   801081a3 <copyuvm>
801046b4:	83 c4 10             	add    $0x10,%esp
801046b7:	8b 55 e0             	mov    -0x20(%ebp),%edx
801046ba:	89 42 04             	mov    %eax,0x4(%edx)
801046bd:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046c0:	8b 40 04             	mov    0x4(%eax),%eax
801046c3:	85 c0                	test   %eax,%eax
801046c5:	75 30                	jne    801046f7 <fork+0x7f>
    kfree(np->kstack);
801046c7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046ca:	8b 40 08             	mov    0x8(%eax),%eax
801046cd:	83 ec 0c             	sub    $0xc,%esp
801046d0:	50                   	push   %eax
801046d1:	e8 3b e4 ff ff       	call   80102b11 <kfree>
801046d6:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
801046d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046dc:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
801046e3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046e6:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
801046ed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801046f2:	e9 03 01 00 00       	jmp    801047fa <fork+0x182>
  }
  np->sz = proc->sz;
801046f7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046fd:	8b 10                	mov    (%eax),%edx
801046ff:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104702:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
80104704:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010470b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010470e:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *proc->tf;
80104711:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104714:	8b 50 18             	mov    0x18(%eax),%edx
80104717:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010471d:	8b 40 18             	mov    0x18(%eax),%eax
80104720:	89 c3                	mov    %eax,%ebx
80104722:	b8 13 00 00 00       	mov    $0x13,%eax
80104727:	89 d7                	mov    %edx,%edi
80104729:	89 de                	mov    %ebx,%esi
8010472b:	89 c1                	mov    %eax,%ecx
8010472d:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
8010472f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104732:	8b 40 18             	mov    0x18(%eax),%eax
80104735:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
8010473c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80104743:	eb 40                	jmp    80104785 <fork+0x10d>
    if(proc->ofile[i])
80104745:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010474b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010474e:	83 c2 08             	add    $0x8,%edx
80104751:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104755:	85 c0                	test   %eax,%eax
80104757:	74 29                	je     80104782 <fork+0x10a>
      np->ofile[i] = filedup(proc->ofile[i]);
80104759:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010475f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104762:	83 c2 08             	add    $0x8,%edx
80104765:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104769:	83 ec 0c             	sub    $0xc,%esp
8010476c:	50                   	push   %eax
8010476d:	e8 25 c8 ff ff       	call   80100f97 <filedup>
80104772:	83 c4 10             	add    $0x10,%esp
80104775:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104778:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010477b:	83 c1 08             	add    $0x8,%ecx
8010477e:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80104782:	ff 45 e4             	incl   -0x1c(%ebp)
80104785:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
80104789:	7e ba                	jle    80104745 <fork+0xcd>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
8010478b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104791:	8b 40 68             	mov    0x68(%eax),%eax
80104794:	83 ec 0c             	sub    $0xc,%esp
80104797:	50                   	push   %eax
80104798:	e8 04 d1 ff ff       	call   801018a1 <idup>
8010479d:	83 c4 10             	add    $0x10,%esp
801047a0:	8b 55 e0             	mov    -0x20(%ebp),%edx
801047a3:	89 42 68             	mov    %eax,0x68(%edx)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
801047a6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047ac:	8d 50 6c             	lea    0x6c(%eax),%edx
801047af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047b2:	83 c0 6c             	add    $0x6c,%eax
801047b5:	83 ec 04             	sub    $0x4,%esp
801047b8:	6a 10                	push   $0x10
801047ba:	52                   	push   %edx
801047bb:	50                   	push   %eax
801047bc:	e8 d0 0b 00 00       	call   80105391 <safestrcpy>
801047c1:	83 c4 10             	add    $0x10,%esp
 
  pid = np->pid;
801047c4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047c7:	8b 40 10             	mov    0x10(%eax),%eax
801047ca:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // lock to force the compiler to emit the np->state write last.
  acquire(&ptable.lock);
801047cd:	83 ec 0c             	sub    $0xc,%esp
801047d0:	68 60 29 11 80       	push   $0x80112960
801047d5:	e8 6e 07 00 00       	call   80104f48 <acquire>
801047da:	83 c4 10             	add    $0x10,%esp
  np->state = RUNNABLE;
801047dd:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047e0:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  release(&ptable.lock);
801047e7:	83 ec 0c             	sub    $0xc,%esp
801047ea:	68 60 29 11 80       	push   $0x80112960
801047ef:	e8 ba 07 00 00       	call   80104fae <release>
801047f4:	83 c4 10             	add    $0x10,%esp
  
  return pid;
801047f7:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
801047fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801047fd:	5b                   	pop    %ebx
801047fe:	5e                   	pop    %esi
801047ff:	5f                   	pop    %edi
80104800:	5d                   	pop    %ebp
80104801:	c3                   	ret    

80104802 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80104802:	55                   	push   %ebp
80104803:	89 e5                	mov    %esp,%ebp
80104805:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
80104808:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010480f:	a1 48 b6 10 80       	mov    0x8010b648,%eax
80104814:	39 c2                	cmp    %eax,%edx
80104816:	75 0d                	jne    80104825 <exit+0x23>
    panic("init exiting");
80104818:	83 ec 0c             	sub    $0xc,%esp
8010481b:	68 2c 87 10 80       	push   $0x8010872c
80104820:	e8 29 bd ff ff       	call   8010054e <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104825:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010482c:	eb 47                	jmp    80104875 <exit+0x73>
    if(proc->ofile[fd]){
8010482e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104834:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104837:	83 c2 08             	add    $0x8,%edx
8010483a:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010483e:	85 c0                	test   %eax,%eax
80104840:	74 30                	je     80104872 <exit+0x70>
      fileclose(proc->ofile[fd]);
80104842:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104848:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010484b:	83 c2 08             	add    $0x8,%edx
8010484e:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104852:	83 ec 0c             	sub    $0xc,%esp
80104855:	50                   	push   %eax
80104856:	e8 8d c7 ff ff       	call   80100fe8 <fileclose>
8010485b:	83 c4 10             	add    $0x10,%esp
      proc->ofile[fd] = 0;
8010485e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104864:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104867:	83 c2 08             	add    $0x8,%edx
8010486a:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80104871:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104872:	ff 45 f0             	incl   -0x10(%ebp)
80104875:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
80104879:	7e b3                	jle    8010482e <exit+0x2c>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
8010487b:	e8 d6 eb ff ff       	call   80103456 <begin_op>
  iput(proc->cwd);
80104880:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104886:	8b 40 68             	mov    0x68(%eax),%eax
80104889:	83 ec 0c             	sub    $0xc,%esp
8010488c:	50                   	push   %eax
8010488d:	e8 14 d2 ff ff       	call   80101aa6 <iput>
80104892:	83 c4 10             	add    $0x10,%esp
  end_op();
80104895:	e8 48 ec ff ff       	call   801034e2 <end_op>
  proc->cwd = 0;
8010489a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048a0:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
801048a7:	83 ec 0c             	sub    $0xc,%esp
801048aa:	68 60 29 11 80       	push   $0x80112960
801048af:	e8 94 06 00 00       	call   80104f48 <acquire>
801048b4:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
801048b7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048bd:	8b 40 14             	mov    0x14(%eax),%eax
801048c0:	83 ec 0c             	sub    $0xc,%esp
801048c3:	50                   	push   %eax
801048c4:	e8 3d 04 00 00       	call   80104d06 <wakeup1>
801048c9:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048cc:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
801048d3:	eb 3c                	jmp    80104911 <exit+0x10f>
    if(p->parent == proc){
801048d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048d8:	8b 50 14             	mov    0x14(%eax),%edx
801048db:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048e1:	39 c2                	cmp    %eax,%edx
801048e3:	75 28                	jne    8010490d <exit+0x10b>
      p->parent = initproc;
801048e5:	8b 15 48 b6 10 80    	mov    0x8010b648,%edx
801048eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048ee:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
801048f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048f4:	8b 40 0c             	mov    0xc(%eax),%eax
801048f7:	83 f8 05             	cmp    $0x5,%eax
801048fa:	75 11                	jne    8010490d <exit+0x10b>
        wakeup1(initproc);
801048fc:	a1 48 b6 10 80       	mov    0x8010b648,%eax
80104901:	83 ec 0c             	sub    $0xc,%esp
80104904:	50                   	push   %eax
80104905:	e8 fc 03 00 00       	call   80104d06 <wakeup1>
8010490a:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010490d:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104911:	81 7d f4 94 48 11 80 	cmpl   $0x80114894,-0xc(%ebp)
80104918:	72 bb                	jb     801048d5 <exit+0xd3>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
8010491a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104920:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
80104927:	e8 f5 01 00 00       	call   80104b21 <sched>
  panic("zombie exit");
8010492c:	83 ec 0c             	sub    $0xc,%esp
8010492f:	68 39 87 10 80       	push   $0x80108739
80104934:	e8 15 bc ff ff       	call   8010054e <panic>

80104939 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80104939:	55                   	push   %ebp
8010493a:	89 e5                	mov    %esp,%ebp
8010493c:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
8010493f:	83 ec 0c             	sub    $0xc,%esp
80104942:	68 60 29 11 80       	push   $0x80112960
80104947:	e8 fc 05 00 00       	call   80104f48 <acquire>
8010494c:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
8010494f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104956:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
8010495d:	e9 a6 00 00 00       	jmp    80104a08 <wait+0xcf>
      if(p->parent != proc)
80104962:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104965:	8b 50 14             	mov    0x14(%eax),%edx
80104968:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010496e:	39 c2                	cmp    %eax,%edx
80104970:	74 05                	je     80104977 <wait+0x3e>
        continue;
80104972:	e9 8d 00 00 00       	jmp    80104a04 <wait+0xcb>
      havekids = 1;
80104977:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
8010497e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104981:	8b 40 0c             	mov    0xc(%eax),%eax
80104984:	83 f8 05             	cmp    $0x5,%eax
80104987:	75 7b                	jne    80104a04 <wait+0xcb>
        // Found one.
        pid = p->pid;
80104989:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010498c:	8b 40 10             	mov    0x10(%eax),%eax
8010498f:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
80104992:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104995:	8b 40 08             	mov    0x8(%eax),%eax
80104998:	83 ec 0c             	sub    $0xc,%esp
8010499b:	50                   	push   %eax
8010499c:	e8 70 e1 ff ff       	call   80102b11 <kfree>
801049a1:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
801049a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049a7:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
801049ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049b1:	8b 40 04             	mov    0x4(%eax),%eax
801049b4:	83 ec 0c             	sub    $0xc,%esp
801049b7:	50                   	push   %eax
801049b8:	e8 08 37 00 00       	call   801080c5 <freevm>
801049bd:	83 c4 10             	add    $0x10,%esp
        p->state = UNUSED;
801049c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049c3:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        p->pid = 0;
801049ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049cd:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
801049d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049d7:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
801049de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049e1:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
801049e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049e8:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        release(&ptable.lock);
801049ef:	83 ec 0c             	sub    $0xc,%esp
801049f2:	68 60 29 11 80       	push   $0x80112960
801049f7:	e8 b2 05 00 00       	call   80104fae <release>
801049fc:	83 c4 10             	add    $0x10,%esp
        return pid;
801049ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104a02:	eb 57                	jmp    80104a5b <wait+0x122>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a04:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104a08:	81 7d f4 94 48 11 80 	cmpl   $0x80114894,-0xc(%ebp)
80104a0f:	0f 82 4d ff ff ff    	jb     80104962 <wait+0x29>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80104a15:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104a19:	74 0d                	je     80104a28 <wait+0xef>
80104a1b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a21:	8b 40 24             	mov    0x24(%eax),%eax
80104a24:	85 c0                	test   %eax,%eax
80104a26:	74 17                	je     80104a3f <wait+0x106>
      release(&ptable.lock);
80104a28:	83 ec 0c             	sub    $0xc,%esp
80104a2b:	68 60 29 11 80       	push   $0x80112960
80104a30:	e8 79 05 00 00       	call   80104fae <release>
80104a35:	83 c4 10             	add    $0x10,%esp
      return -1;
80104a38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a3d:	eb 1c                	jmp    80104a5b <wait+0x122>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80104a3f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a45:	83 ec 08             	sub    $0x8,%esp
80104a48:	68 60 29 11 80       	push   $0x80112960
80104a4d:	50                   	push   %eax
80104a4e:	e8 08 02 00 00       	call   80104c5b <sleep>
80104a53:	83 c4 10             	add    $0x10,%esp
  }
80104a56:	e9 f4 fe ff ff       	jmp    8010494f <wait+0x16>
}
80104a5b:	c9                   	leave  
80104a5c:	c3                   	ret    

80104a5d <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80104a5d:	55                   	push   %ebp
80104a5e:	89 e5                	mov    %esp,%ebp
80104a60:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int foundproc = 1;
80104a63:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)

  for(;;){
    // Enable interrupts on this processor.
    sti();
80104a6a:	e8 26 f9 ff ff       	call   80104395 <sti>

    if (!foundproc) hlt();
80104a6f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104a73:	75 05                	jne    80104a7a <scheduler+0x1d>
80104a75:	e8 21 f9 ff ff       	call   8010439b <hlt>

    foundproc = 0;
80104a7a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80104a81:	83 ec 0c             	sub    $0xc,%esp
80104a84:	68 60 29 11 80       	push   $0x80112960
80104a89:	e8 ba 04 00 00       	call   80104f48 <acquire>
80104a8e:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a91:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
80104a98:	eb 69                	jmp    80104b03 <scheduler+0xa6>
      if(p->state != RUNNABLE)
80104a9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a9d:	8b 40 0c             	mov    0xc(%eax),%eax
80104aa0:	83 f8 03             	cmp    $0x3,%eax
80104aa3:	74 02                	je     80104aa7 <scheduler+0x4a>
        continue;
80104aa5:	eb 58                	jmp    80104aff <scheduler+0xa2>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      foundproc = 1;
80104aa7:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      proc = p;
80104aae:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ab1:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
      switchuvm(p);
80104ab7:	83 ec 0c             	sub    $0xc,%esp
80104aba:	ff 75 f4             	pushl  -0xc(%ebp)
80104abd:	e8 cf 31 00 00       	call   80107c91 <switchuvm>
80104ac2:	83 c4 10             	add    $0x10,%esp
      p->state = RUNNING;
80104ac5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ac8:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
      swtch(&cpu->scheduler, proc->context);
80104acf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ad5:	8b 40 1c             	mov    0x1c(%eax),%eax
80104ad8:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104adf:	83 c2 04             	add    $0x4,%edx
80104ae2:	83 ec 08             	sub    $0x8,%esp
80104ae5:	50                   	push   %eax
80104ae6:	52                   	push   %edx
80104ae7:	e8 11 09 00 00       	call   801053fd <swtch>
80104aec:	83 c4 10             	add    $0x10,%esp
      switchkvm();
80104aef:	e8 81 31 00 00       	call   80107c75 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80104af4:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80104afb:	00 00 00 00 

    foundproc = 0;

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104aff:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104b03:	81 7d f4 94 48 11 80 	cmpl   $0x80114894,-0xc(%ebp)
80104b0a:	72 8e                	jb     80104a9a <scheduler+0x3d>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
80104b0c:	83 ec 0c             	sub    $0xc,%esp
80104b0f:	68 60 29 11 80       	push   $0x80112960
80104b14:	e8 95 04 00 00       	call   80104fae <release>
80104b19:	83 c4 10             	add    $0x10,%esp

  }
80104b1c:	e9 49 ff ff ff       	jmp    80104a6a <scheduler+0xd>

80104b21 <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
80104b21:	55                   	push   %ebp
80104b22:	89 e5                	mov    %esp,%ebp
80104b24:	83 ec 18             	sub    $0x18,%esp
  int intena;

  if(!holding(&ptable.lock))
80104b27:	83 ec 0c             	sub    $0xc,%esp
80104b2a:	68 60 29 11 80       	push   $0x80112960
80104b2f:	e8 42 05 00 00       	call   80105076 <holding>
80104b34:	83 c4 10             	add    $0x10,%esp
80104b37:	85 c0                	test   %eax,%eax
80104b39:	75 0d                	jne    80104b48 <sched+0x27>
    panic("sched ptable.lock");
80104b3b:	83 ec 0c             	sub    $0xc,%esp
80104b3e:	68 45 87 10 80       	push   $0x80108745
80104b43:	e8 06 ba ff ff       	call   8010054e <panic>
  if(cpu->ncli != 1)
80104b48:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104b4e:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104b54:	83 f8 01             	cmp    $0x1,%eax
80104b57:	74 0d                	je     80104b66 <sched+0x45>
    panic("sched locks");
80104b59:	83 ec 0c             	sub    $0xc,%esp
80104b5c:	68 57 87 10 80       	push   $0x80108757
80104b61:	e8 e8 b9 ff ff       	call   8010054e <panic>
  if(proc->state == RUNNING)
80104b66:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b6c:	8b 40 0c             	mov    0xc(%eax),%eax
80104b6f:	83 f8 04             	cmp    $0x4,%eax
80104b72:	75 0d                	jne    80104b81 <sched+0x60>
    panic("sched running");
80104b74:	83 ec 0c             	sub    $0xc,%esp
80104b77:	68 63 87 10 80       	push   $0x80108763
80104b7c:	e8 cd b9 ff ff       	call   8010054e <panic>
  if(readeflags()&FL_IF)
80104b81:	e8 ff f7 ff ff       	call   80104385 <readeflags>
80104b86:	25 00 02 00 00       	and    $0x200,%eax
80104b8b:	85 c0                	test   %eax,%eax
80104b8d:	74 0d                	je     80104b9c <sched+0x7b>
    panic("sched interruptible");
80104b8f:	83 ec 0c             	sub    $0xc,%esp
80104b92:	68 71 87 10 80       	push   $0x80108771
80104b97:	e8 b2 b9 ff ff       	call   8010054e <panic>
  intena = cpu->intena;
80104b9c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104ba2:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104ba8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
80104bab:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104bb1:	8b 40 04             	mov    0x4(%eax),%eax
80104bb4:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104bbb:	83 c2 1c             	add    $0x1c,%edx
80104bbe:	83 ec 08             	sub    $0x8,%esp
80104bc1:	50                   	push   %eax
80104bc2:	52                   	push   %edx
80104bc3:	e8 35 08 00 00       	call   801053fd <swtch>
80104bc8:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80104bcb:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104bd1:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104bd4:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104bda:	c9                   	leave  
80104bdb:	c3                   	ret    

80104bdc <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104bdc:	55                   	push   %ebp
80104bdd:	89 e5                	mov    %esp,%ebp
80104bdf:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104be2:	83 ec 0c             	sub    $0xc,%esp
80104be5:	68 60 29 11 80       	push   $0x80112960
80104bea:	e8 59 03 00 00       	call   80104f48 <acquire>
80104bef:	83 c4 10             	add    $0x10,%esp
  proc->state = RUNNABLE;
80104bf2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bf8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80104bff:	e8 1d ff ff ff       	call   80104b21 <sched>
  release(&ptable.lock);
80104c04:	83 ec 0c             	sub    $0xc,%esp
80104c07:	68 60 29 11 80       	push   $0x80112960
80104c0c:	e8 9d 03 00 00       	call   80104fae <release>
80104c11:	83 c4 10             	add    $0x10,%esp
}
80104c14:	c9                   	leave  
80104c15:	c3                   	ret    

80104c16 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104c16:	55                   	push   %ebp
80104c17:	89 e5                	mov    %esp,%ebp
80104c19:	83 ec 08             	sub    $0x8,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104c1c:	83 ec 0c             	sub    $0xc,%esp
80104c1f:	68 60 29 11 80       	push   $0x80112960
80104c24:	e8 85 03 00 00       	call   80104fae <release>
80104c29:	83 c4 10             	add    $0x10,%esp

  if (first) {
80104c2c:	a1 08 b0 10 80       	mov    0x8010b008,%eax
80104c31:	85 c0                	test   %eax,%eax
80104c33:	74 24                	je     80104c59 <forkret+0x43>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
80104c35:	c7 05 08 b0 10 80 00 	movl   $0x0,0x8010b008
80104c3c:	00 00 00 
    iinit(ROOTDEV);
80104c3f:	83 ec 0c             	sub    $0xc,%esp
80104c42:	6a 01                	push   $0x1
80104c44:	e8 6e c9 ff ff       	call   801015b7 <iinit>
80104c49:	83 c4 10             	add    $0x10,%esp
    initlog(ROOTDEV);
80104c4c:	83 ec 0c             	sub    $0xc,%esp
80104c4f:	6a 01                	push   $0x1
80104c51:	e8 ec e5 ff ff       	call   80103242 <initlog>
80104c56:	83 c4 10             	add    $0x10,%esp
  }
  
  // Return to "caller", actually trapret (see allocproc).
}
80104c59:	c9                   	leave  
80104c5a:	c3                   	ret    

80104c5b <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104c5b:	55                   	push   %ebp
80104c5c:	89 e5                	mov    %esp,%ebp
80104c5e:	83 ec 08             	sub    $0x8,%esp
  if(proc == 0)
80104c61:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c67:	85 c0                	test   %eax,%eax
80104c69:	75 0d                	jne    80104c78 <sleep+0x1d>
    panic("sleep");
80104c6b:	83 ec 0c             	sub    $0xc,%esp
80104c6e:	68 85 87 10 80       	push   $0x80108785
80104c73:	e8 d6 b8 ff ff       	call   8010054e <panic>

  if(lk == 0)
80104c78:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104c7c:	75 0d                	jne    80104c8b <sleep+0x30>
    panic("sleep without lk");
80104c7e:	83 ec 0c             	sub    $0xc,%esp
80104c81:	68 8b 87 10 80       	push   $0x8010878b
80104c86:	e8 c3 b8 ff ff       	call   8010054e <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104c8b:	81 7d 0c 60 29 11 80 	cmpl   $0x80112960,0xc(%ebp)
80104c92:	74 1e                	je     80104cb2 <sleep+0x57>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104c94:	83 ec 0c             	sub    $0xc,%esp
80104c97:	68 60 29 11 80       	push   $0x80112960
80104c9c:	e8 a7 02 00 00       	call   80104f48 <acquire>
80104ca1:	83 c4 10             	add    $0x10,%esp
    release(lk);
80104ca4:	83 ec 0c             	sub    $0xc,%esp
80104ca7:	ff 75 0c             	pushl  0xc(%ebp)
80104caa:	e8 ff 02 00 00       	call   80104fae <release>
80104caf:	83 c4 10             	add    $0x10,%esp
  }

  // Go to sleep.
  proc->chan = chan;
80104cb2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cb8:	8b 55 08             	mov    0x8(%ebp),%edx
80104cbb:	89 50 20             	mov    %edx,0x20(%eax)
  proc->state = SLEEPING;
80104cbe:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cc4:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80104ccb:	e8 51 fe ff ff       	call   80104b21 <sched>

  // Tidy up.
  proc->chan = 0;
80104cd0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cd6:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
80104cdd:	81 7d 0c 60 29 11 80 	cmpl   $0x80112960,0xc(%ebp)
80104ce4:	74 1e                	je     80104d04 <sleep+0xa9>
    release(&ptable.lock);
80104ce6:	83 ec 0c             	sub    $0xc,%esp
80104ce9:	68 60 29 11 80       	push   $0x80112960
80104cee:	e8 bb 02 00 00       	call   80104fae <release>
80104cf3:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
80104cf6:	83 ec 0c             	sub    $0xc,%esp
80104cf9:	ff 75 0c             	pushl  0xc(%ebp)
80104cfc:	e8 47 02 00 00       	call   80104f48 <acquire>
80104d01:	83 c4 10             	add    $0x10,%esp
  }
}
80104d04:	c9                   	leave  
80104d05:	c3                   	ret    

80104d06 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80104d06:	55                   	push   %ebp
80104d07:	89 e5                	mov    %esp,%ebp
80104d09:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104d0c:	c7 45 fc 94 29 11 80 	movl   $0x80112994,-0x4(%ebp)
80104d13:	eb 24                	jmp    80104d39 <wakeup1+0x33>
    if(p->state == SLEEPING && p->chan == chan)
80104d15:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d18:	8b 40 0c             	mov    0xc(%eax),%eax
80104d1b:	83 f8 02             	cmp    $0x2,%eax
80104d1e:	75 15                	jne    80104d35 <wakeup1+0x2f>
80104d20:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d23:	8b 40 20             	mov    0x20(%eax),%eax
80104d26:	3b 45 08             	cmp    0x8(%ebp),%eax
80104d29:	75 0a                	jne    80104d35 <wakeup1+0x2f>
      p->state = RUNNABLE;
80104d2b:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d2e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104d35:	83 45 fc 7c          	addl   $0x7c,-0x4(%ebp)
80104d39:	81 7d fc 94 48 11 80 	cmpl   $0x80114894,-0x4(%ebp)
80104d40:	72 d3                	jb     80104d15 <wakeup1+0xf>
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
80104d42:	c9                   	leave  
80104d43:	c3                   	ret    

80104d44 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104d44:	55                   	push   %ebp
80104d45:	89 e5                	mov    %esp,%ebp
80104d47:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);
80104d4a:	83 ec 0c             	sub    $0xc,%esp
80104d4d:	68 60 29 11 80       	push   $0x80112960
80104d52:	e8 f1 01 00 00       	call   80104f48 <acquire>
80104d57:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
80104d5a:	83 ec 0c             	sub    $0xc,%esp
80104d5d:	ff 75 08             	pushl  0x8(%ebp)
80104d60:	e8 a1 ff ff ff       	call   80104d06 <wakeup1>
80104d65:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
80104d68:	83 ec 0c             	sub    $0xc,%esp
80104d6b:	68 60 29 11 80       	push   $0x80112960
80104d70:	e8 39 02 00 00       	call   80104fae <release>
80104d75:	83 c4 10             	add    $0x10,%esp
}
80104d78:	c9                   	leave  
80104d79:	c3                   	ret    

80104d7a <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104d7a:	55                   	push   %ebp
80104d7b:	89 e5                	mov    %esp,%ebp
80104d7d:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104d80:	83 ec 0c             	sub    $0xc,%esp
80104d83:	68 60 29 11 80       	push   $0x80112960
80104d88:	e8 bb 01 00 00       	call   80104f48 <acquire>
80104d8d:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d90:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
80104d97:	eb 45                	jmp    80104dde <kill+0x64>
    if(p->pid == pid){
80104d99:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d9c:	8b 40 10             	mov    0x10(%eax),%eax
80104d9f:	3b 45 08             	cmp    0x8(%ebp),%eax
80104da2:	75 36                	jne    80104dda <kill+0x60>
      p->killed = 1;
80104da4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104da7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104dae:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104db1:	8b 40 0c             	mov    0xc(%eax),%eax
80104db4:	83 f8 02             	cmp    $0x2,%eax
80104db7:	75 0a                	jne    80104dc3 <kill+0x49>
        p->state = RUNNABLE;
80104db9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104dbc:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104dc3:	83 ec 0c             	sub    $0xc,%esp
80104dc6:	68 60 29 11 80       	push   $0x80112960
80104dcb:	e8 de 01 00 00       	call   80104fae <release>
80104dd0:	83 c4 10             	add    $0x10,%esp
      return 0;
80104dd3:	b8 00 00 00 00       	mov    $0x0,%eax
80104dd8:	eb 22                	jmp    80104dfc <kill+0x82>
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104dda:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104dde:	81 7d f4 94 48 11 80 	cmpl   $0x80114894,-0xc(%ebp)
80104de5:	72 b2                	jb     80104d99 <kill+0x1f>
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104de7:	83 ec 0c             	sub    $0xc,%esp
80104dea:	68 60 29 11 80       	push   $0x80112960
80104def:	e8 ba 01 00 00       	call   80104fae <release>
80104df4:	83 c4 10             	add    $0x10,%esp
  return -1;
80104df7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104dfc:	c9                   	leave  
80104dfd:	c3                   	ret    

80104dfe <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104dfe:	55                   	push   %ebp
80104dff:	89 e5                	mov    %esp,%ebp
80104e01:	83 ec 48             	sub    $0x48,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e04:	c7 45 f0 94 29 11 80 	movl   $0x80112994,-0x10(%ebp)
80104e0b:	e9 d2 00 00 00       	jmp    80104ee2 <procdump+0xe4>
    if(p->state == UNUSED)
80104e10:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e13:	8b 40 0c             	mov    0xc(%eax),%eax
80104e16:	85 c0                	test   %eax,%eax
80104e18:	75 05                	jne    80104e1f <procdump+0x21>
      continue;
80104e1a:	e9 bf 00 00 00       	jmp    80104ede <procdump+0xe0>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104e1f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e22:	8b 40 0c             	mov    0xc(%eax),%eax
80104e25:	83 f8 05             	cmp    $0x5,%eax
80104e28:	77 23                	ja     80104e4d <procdump+0x4f>
80104e2a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e2d:	8b 40 0c             	mov    0xc(%eax),%eax
80104e30:	8b 04 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%eax
80104e37:	85 c0                	test   %eax,%eax
80104e39:	74 12                	je     80104e4d <procdump+0x4f>
      state = states[p->state];
80104e3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e3e:	8b 40 0c             	mov    0xc(%eax),%eax
80104e41:	8b 04 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%eax
80104e48:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104e4b:	eb 07                	jmp    80104e54 <procdump+0x56>
    else
      state = "???";
80104e4d:	c7 45 ec 9c 87 10 80 	movl   $0x8010879c,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
80104e54:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e57:	8d 50 6c             	lea    0x6c(%eax),%edx
80104e5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e5d:	8b 40 10             	mov    0x10(%eax),%eax
80104e60:	52                   	push   %edx
80104e61:	ff 75 ec             	pushl  -0x14(%ebp)
80104e64:	50                   	push   %eax
80104e65:	68 a0 87 10 80       	push   $0x801087a0
80104e6a:	e8 49 b5 ff ff       	call   801003b8 <cprintf>
80104e6f:	83 c4 10             	add    $0x10,%esp
    if(p->state == SLEEPING){
80104e72:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e75:	8b 40 0c             	mov    0xc(%eax),%eax
80104e78:	83 f8 02             	cmp    $0x2,%eax
80104e7b:	75 51                	jne    80104ece <procdump+0xd0>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104e7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e80:	8b 40 1c             	mov    0x1c(%eax),%eax
80104e83:	8b 40 0c             	mov    0xc(%eax),%eax
80104e86:	83 c0 08             	add    $0x8,%eax
80104e89:	83 ec 08             	sub    $0x8,%esp
80104e8c:	8d 55 c4             	lea    -0x3c(%ebp),%edx
80104e8f:	52                   	push   %edx
80104e90:	50                   	push   %eax
80104e91:	e8 69 01 00 00       	call   80104fff <getcallerpcs>
80104e96:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104e99:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104ea0:	eb 1b                	jmp    80104ebd <procdump+0xbf>
        cprintf(" %p", pc[i]);
80104ea2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ea5:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104ea9:	83 ec 08             	sub    $0x8,%esp
80104eac:	50                   	push   %eax
80104ead:	68 a9 87 10 80       	push   $0x801087a9
80104eb2:	e8 01 b5 ff ff       	call   801003b8 <cprintf>
80104eb7:	83 c4 10             	add    $0x10,%esp
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104eba:	ff 45 f4             	incl   -0xc(%ebp)
80104ebd:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80104ec1:	7f 0b                	jg     80104ece <procdump+0xd0>
80104ec3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ec6:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104eca:	85 c0                	test   %eax,%eax
80104ecc:	75 d4                	jne    80104ea2 <procdump+0xa4>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104ece:	83 ec 0c             	sub    $0xc,%esp
80104ed1:	68 ad 87 10 80       	push   $0x801087ad
80104ed6:	e8 dd b4 ff ff       	call   801003b8 <cprintf>
80104edb:	83 c4 10             	add    $0x10,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ede:	83 45 f0 7c          	addl   $0x7c,-0x10(%ebp)
80104ee2:	81 7d f0 94 48 11 80 	cmpl   $0x80114894,-0x10(%ebp)
80104ee9:	0f 82 21 ff ff ff    	jb     80104e10 <procdump+0x12>
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104eef:	c9                   	leave  
80104ef0:	c3                   	ret    

80104ef1 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80104ef1:	55                   	push   %ebp
80104ef2:	89 e5                	mov    %esp,%ebp
80104ef4:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104ef7:	9c                   	pushf  
80104ef8:	58                   	pop    %eax
80104ef9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80104efc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104eff:	c9                   	leave  
80104f00:	c3                   	ret    

80104f01 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80104f01:	55                   	push   %ebp
80104f02:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80104f04:	fa                   	cli    
}
80104f05:	5d                   	pop    %ebp
80104f06:	c3                   	ret    

80104f07 <sti>:

static inline void
sti(void)
{
80104f07:	55                   	push   %ebp
80104f08:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104f0a:	fb                   	sti    
}
80104f0b:	5d                   	pop    %ebp
80104f0c:	c3                   	ret    

80104f0d <xchg>:
  asm volatile("hlt");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
80104f0d:	55                   	push   %ebp
80104f0e:	89 e5                	mov    %esp,%ebp
80104f10:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104f13:	8b 55 08             	mov    0x8(%ebp),%edx
80104f16:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f19:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104f1c:	f0 87 02             	lock xchg %eax,(%edx)
80104f1f:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80104f22:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104f25:	c9                   	leave  
80104f26:	c3                   	ret    

80104f27 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104f27:	55                   	push   %ebp
80104f28:	89 e5                	mov    %esp,%ebp
  lk->name = name;
80104f2a:	8b 45 08             	mov    0x8(%ebp),%eax
80104f2d:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f30:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80104f33:	8b 45 08             	mov    0x8(%ebp),%eax
80104f36:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80104f3c:	8b 45 08             	mov    0x8(%ebp),%eax
80104f3f:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104f46:	5d                   	pop    %ebp
80104f47:	c3                   	ret    

80104f48 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104f48:	55                   	push   %ebp
80104f49:	89 e5                	mov    %esp,%ebp
80104f4b:	83 ec 08             	sub    $0x8,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104f4e:	e8 4d 01 00 00       	call   801050a0 <pushcli>
  if(holding(lk))
80104f53:	8b 45 08             	mov    0x8(%ebp),%eax
80104f56:	83 ec 0c             	sub    $0xc,%esp
80104f59:	50                   	push   %eax
80104f5a:	e8 17 01 00 00       	call   80105076 <holding>
80104f5f:	83 c4 10             	add    $0x10,%esp
80104f62:	85 c0                	test   %eax,%eax
80104f64:	74 0d                	je     80104f73 <acquire+0x2b>
    panic("acquire");
80104f66:	83 ec 0c             	sub    $0xc,%esp
80104f69:	68 d9 87 10 80       	push   $0x801087d9
80104f6e:	e8 db b5 ff ff       	call   8010054e <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
80104f73:	90                   	nop
80104f74:	8b 45 08             	mov    0x8(%ebp),%eax
80104f77:	83 ec 08             	sub    $0x8,%esp
80104f7a:	6a 01                	push   $0x1
80104f7c:	50                   	push   %eax
80104f7d:	e8 8b ff ff ff       	call   80104f0d <xchg>
80104f82:	83 c4 10             	add    $0x10,%esp
80104f85:	85 c0                	test   %eax,%eax
80104f87:	75 eb                	jne    80104f74 <acquire+0x2c>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80104f89:	8b 45 08             	mov    0x8(%ebp),%eax
80104f8c:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104f93:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80104f96:	8b 45 08             	mov    0x8(%ebp),%eax
80104f99:	83 c0 0c             	add    $0xc,%eax
80104f9c:	83 ec 08             	sub    $0x8,%esp
80104f9f:	50                   	push   %eax
80104fa0:	8d 45 08             	lea    0x8(%ebp),%eax
80104fa3:	50                   	push   %eax
80104fa4:	e8 56 00 00 00       	call   80104fff <getcallerpcs>
80104fa9:	83 c4 10             	add    $0x10,%esp
}
80104fac:	c9                   	leave  
80104fad:	c3                   	ret    

80104fae <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80104fae:	55                   	push   %ebp
80104faf:	89 e5                	mov    %esp,%ebp
80104fb1:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
80104fb4:	83 ec 0c             	sub    $0xc,%esp
80104fb7:	ff 75 08             	pushl  0x8(%ebp)
80104fba:	e8 b7 00 00 00       	call   80105076 <holding>
80104fbf:	83 c4 10             	add    $0x10,%esp
80104fc2:	85 c0                	test   %eax,%eax
80104fc4:	75 0d                	jne    80104fd3 <release+0x25>
    panic("release");
80104fc6:	83 ec 0c             	sub    $0xc,%esp
80104fc9:	68 e1 87 10 80       	push   $0x801087e1
80104fce:	e8 7b b5 ff ff       	call   8010054e <panic>

  lk->pcs[0] = 0;
80104fd3:	8b 45 08             	mov    0x8(%ebp),%eax
80104fd6:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104fdd:	8b 45 08             	mov    0x8(%ebp),%eax
80104fe0:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
80104fe7:	8b 45 08             	mov    0x8(%ebp),%eax
80104fea:	83 ec 08             	sub    $0x8,%esp
80104fed:	6a 00                	push   $0x0
80104fef:	50                   	push   %eax
80104ff0:	e8 18 ff ff ff       	call   80104f0d <xchg>
80104ff5:	83 c4 10             	add    $0x10,%esp

  popcli();
80104ff8:	e8 e7 00 00 00       	call   801050e4 <popcli>
}
80104ffd:	c9                   	leave  
80104ffe:	c3                   	ret    

80104fff <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104fff:	55                   	push   %ebp
80105000:	89 e5                	mov    %esp,%ebp
80105002:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
80105005:	8b 45 08             	mov    0x8(%ebp),%eax
80105008:	83 e8 08             	sub    $0x8,%eax
8010500b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
8010500e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80105015:	eb 37                	jmp    8010504e <getcallerpcs+0x4f>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105017:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
8010501b:	74 37                	je     80105054 <getcallerpcs+0x55>
8010501d:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
80105024:	76 2e                	jbe    80105054 <getcallerpcs+0x55>
80105026:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
8010502a:	74 28                	je     80105054 <getcallerpcs+0x55>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010502c:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010502f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80105036:	8b 45 0c             	mov    0xc(%ebp),%eax
80105039:	01 c2                	add    %eax,%edx
8010503b:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010503e:	8b 40 04             	mov    0x4(%eax),%eax
80105041:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
80105043:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105046:	8b 00                	mov    (%eax),%eax
80105048:	89 45 fc             	mov    %eax,-0x4(%ebp)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
8010504b:	ff 45 f8             	incl   -0x8(%ebp)
8010504e:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105052:	7e c3                	jle    80105017 <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105054:	eb 18                	jmp    8010506e <getcallerpcs+0x6f>
    pcs[i] = 0;
80105056:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105059:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80105060:	8b 45 0c             	mov    0xc(%ebp),%eax
80105063:	01 d0                	add    %edx,%eax
80105065:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010506b:	ff 45 f8             	incl   -0x8(%ebp)
8010506e:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105072:	7e e2                	jle    80105056 <getcallerpcs+0x57>
    pcs[i] = 0;
}
80105074:	c9                   	leave  
80105075:	c3                   	ret    

80105076 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80105076:	55                   	push   %ebp
80105077:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
80105079:	8b 45 08             	mov    0x8(%ebp),%eax
8010507c:	8b 00                	mov    (%eax),%eax
8010507e:	85 c0                	test   %eax,%eax
80105080:	74 17                	je     80105099 <holding+0x23>
80105082:	8b 45 08             	mov    0x8(%ebp),%eax
80105085:	8b 50 08             	mov    0x8(%eax),%edx
80105088:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010508e:	39 c2                	cmp    %eax,%edx
80105090:	75 07                	jne    80105099 <holding+0x23>
80105092:	b8 01 00 00 00       	mov    $0x1,%eax
80105097:	eb 05                	jmp    8010509e <holding+0x28>
80105099:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010509e:	5d                   	pop    %ebp
8010509f:	c3                   	ret    

801050a0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
801050a3:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
801050a6:	e8 46 fe ff ff       	call   80104ef1 <readeflags>
801050ab:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
801050ae:	e8 4e fe ff ff       	call   80104f01 <cli>
  if(cpu->ncli++ == 0)
801050b3:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801050ba:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
801050c0:	8d 48 01             	lea    0x1(%eax),%ecx
801050c3:	89 8a ac 00 00 00    	mov    %ecx,0xac(%edx)
801050c9:	85 c0                	test   %eax,%eax
801050cb:	75 15                	jne    801050e2 <pushcli+0x42>
    cpu->intena = eflags & FL_IF;
801050cd:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801050d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
801050d6:	81 e2 00 02 00 00    	and    $0x200,%edx
801050dc:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
801050e2:	c9                   	leave  
801050e3:	c3                   	ret    

801050e4 <popcli>:

void
popcli(void)
{
801050e4:	55                   	push   %ebp
801050e5:	89 e5                	mov    %esp,%ebp
801050e7:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
801050ea:	e8 02 fe ff ff       	call   80104ef1 <readeflags>
801050ef:	25 00 02 00 00       	and    $0x200,%eax
801050f4:	85 c0                	test   %eax,%eax
801050f6:	74 0d                	je     80105105 <popcli+0x21>
    panic("popcli - interruptible");
801050f8:	83 ec 0c             	sub    $0xc,%esp
801050fb:	68 e9 87 10 80       	push   $0x801087e9
80105100:	e8 49 b4 ff ff       	call   8010054e <panic>
  if(--cpu->ncli < 0)
80105105:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010510b:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80105111:	4a                   	dec    %edx
80105112:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80105118:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
8010511e:	85 c0                	test   %eax,%eax
80105120:	79 0d                	jns    8010512f <popcli+0x4b>
    panic("popcli");
80105122:	83 ec 0c             	sub    $0xc,%esp
80105125:	68 00 88 10 80       	push   $0x80108800
8010512a:	e8 1f b4 ff ff       	call   8010054e <panic>
  if(cpu->ncli == 0 && cpu->intena)
8010512f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105135:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
8010513b:	85 c0                	test   %eax,%eax
8010513d:	75 15                	jne    80105154 <popcli+0x70>
8010513f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105145:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
8010514b:	85 c0                	test   %eax,%eax
8010514d:	74 05                	je     80105154 <popcli+0x70>
    sti();
8010514f:	e8 b3 fd ff ff       	call   80104f07 <sti>
}
80105154:	c9                   	leave  
80105155:	c3                   	ret    

80105156 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
80105156:	55                   	push   %ebp
80105157:	89 e5                	mov    %esp,%ebp
80105159:	57                   	push   %edi
8010515a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
8010515b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010515e:	8b 55 10             	mov    0x10(%ebp),%edx
80105161:	8b 45 0c             	mov    0xc(%ebp),%eax
80105164:	89 cb                	mov    %ecx,%ebx
80105166:	89 df                	mov    %ebx,%edi
80105168:	89 d1                	mov    %edx,%ecx
8010516a:	fc                   	cld    
8010516b:	f3 aa                	rep stos %al,%es:(%edi)
8010516d:	89 ca                	mov    %ecx,%edx
8010516f:	89 fb                	mov    %edi,%ebx
80105171:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105174:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80105177:	5b                   	pop    %ebx
80105178:	5f                   	pop    %edi
80105179:	5d                   	pop    %ebp
8010517a:	c3                   	ret    

8010517b <stosl>:

static inline void
stosl(void *addr, int data, int cnt)
{
8010517b:	55                   	push   %ebp
8010517c:	89 e5                	mov    %esp,%ebp
8010517e:	57                   	push   %edi
8010517f:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
80105180:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105183:	8b 55 10             	mov    0x10(%ebp),%edx
80105186:	8b 45 0c             	mov    0xc(%ebp),%eax
80105189:	89 cb                	mov    %ecx,%ebx
8010518b:	89 df                	mov    %ebx,%edi
8010518d:	89 d1                	mov    %edx,%ecx
8010518f:	fc                   	cld    
80105190:	f3 ab                	rep stos %eax,%es:(%edi)
80105192:	89 ca                	mov    %ecx,%edx
80105194:	89 fb                	mov    %edi,%ebx
80105196:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105199:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
8010519c:	5b                   	pop    %ebx
8010519d:	5f                   	pop    %edi
8010519e:	5d                   	pop    %ebp
8010519f:	c3                   	ret    

801051a0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801051a0:	55                   	push   %ebp
801051a1:	89 e5                	mov    %esp,%ebp
  if ((int)dst%4 == 0 && n%4 == 0){
801051a3:	8b 45 08             	mov    0x8(%ebp),%eax
801051a6:	83 e0 03             	and    $0x3,%eax
801051a9:	85 c0                	test   %eax,%eax
801051ab:	75 43                	jne    801051f0 <memset+0x50>
801051ad:	8b 45 10             	mov    0x10(%ebp),%eax
801051b0:	83 e0 03             	and    $0x3,%eax
801051b3:	85 c0                	test   %eax,%eax
801051b5:	75 39                	jne    801051f0 <memset+0x50>
    c &= 0xFF;
801051b7:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801051be:	8b 45 10             	mov    0x10(%ebp),%eax
801051c1:	c1 e8 02             	shr    $0x2,%eax
801051c4:	89 c2                	mov    %eax,%edx
801051c6:	8b 45 0c             	mov    0xc(%ebp),%eax
801051c9:	c1 e0 18             	shl    $0x18,%eax
801051cc:	89 c1                	mov    %eax,%ecx
801051ce:	8b 45 0c             	mov    0xc(%ebp),%eax
801051d1:	c1 e0 10             	shl    $0x10,%eax
801051d4:	09 c1                	or     %eax,%ecx
801051d6:	8b 45 0c             	mov    0xc(%ebp),%eax
801051d9:	c1 e0 08             	shl    $0x8,%eax
801051dc:	09 c8                	or     %ecx,%eax
801051de:	0b 45 0c             	or     0xc(%ebp),%eax
801051e1:	52                   	push   %edx
801051e2:	50                   	push   %eax
801051e3:	ff 75 08             	pushl  0x8(%ebp)
801051e6:	e8 90 ff ff ff       	call   8010517b <stosl>
801051eb:	83 c4 0c             	add    $0xc,%esp
801051ee:	eb 12                	jmp    80105202 <memset+0x62>
  } else
    stosb(dst, c, n);
801051f0:	8b 45 10             	mov    0x10(%ebp),%eax
801051f3:	50                   	push   %eax
801051f4:	ff 75 0c             	pushl  0xc(%ebp)
801051f7:	ff 75 08             	pushl  0x8(%ebp)
801051fa:	e8 57 ff ff ff       	call   80105156 <stosb>
801051ff:	83 c4 0c             	add    $0xc,%esp
  return dst;
80105202:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105205:	c9                   	leave  
80105206:	c3                   	ret    

80105207 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105207:	55                   	push   %ebp
80105208:	89 e5                	mov    %esp,%ebp
8010520a:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
8010520d:	8b 45 08             	mov    0x8(%ebp),%eax
80105210:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
80105213:	8b 45 0c             	mov    0xc(%ebp),%eax
80105216:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
80105219:	eb 2a                	jmp    80105245 <memcmp+0x3e>
    if(*s1 != *s2)
8010521b:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010521e:	8a 10                	mov    (%eax),%dl
80105220:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105223:	8a 00                	mov    (%eax),%al
80105225:	38 c2                	cmp    %al,%dl
80105227:	74 16                	je     8010523f <memcmp+0x38>
      return *s1 - *s2;
80105229:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010522c:	8a 00                	mov    (%eax),%al
8010522e:	0f b6 d0             	movzbl %al,%edx
80105231:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105234:	8a 00                	mov    (%eax),%al
80105236:	0f b6 c0             	movzbl %al,%eax
80105239:	29 c2                	sub    %eax,%edx
8010523b:	89 d0                	mov    %edx,%eax
8010523d:	eb 18                	jmp    80105257 <memcmp+0x50>
    s1++, s2++;
8010523f:	ff 45 fc             	incl   -0x4(%ebp)
80105242:	ff 45 f8             	incl   -0x8(%ebp)
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105245:	8b 45 10             	mov    0x10(%ebp),%eax
80105248:	8d 50 ff             	lea    -0x1(%eax),%edx
8010524b:	89 55 10             	mov    %edx,0x10(%ebp)
8010524e:	85 c0                	test   %eax,%eax
80105250:	75 c9                	jne    8010521b <memcmp+0x14>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
80105252:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105257:	c9                   	leave  
80105258:	c3                   	ret    

80105259 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105259:	55                   	push   %ebp
8010525a:	89 e5                	mov    %esp,%ebp
8010525c:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
8010525f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105262:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
80105265:	8b 45 08             	mov    0x8(%ebp),%eax
80105268:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
8010526b:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010526e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105271:	73 3a                	jae    801052ad <memmove+0x54>
80105273:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105276:	8b 45 10             	mov    0x10(%ebp),%eax
80105279:	01 d0                	add    %edx,%eax
8010527b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
8010527e:	76 2d                	jbe    801052ad <memmove+0x54>
    s += n;
80105280:	8b 45 10             	mov    0x10(%ebp),%eax
80105283:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
80105286:	8b 45 10             	mov    0x10(%ebp),%eax
80105289:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
8010528c:	eb 10                	jmp    8010529e <memmove+0x45>
      *--d = *--s;
8010528e:	ff 4d f8             	decl   -0x8(%ebp)
80105291:	ff 4d fc             	decl   -0x4(%ebp)
80105294:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105297:	8a 10                	mov    (%eax),%dl
80105299:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010529c:	88 10                	mov    %dl,(%eax)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
8010529e:	8b 45 10             	mov    0x10(%ebp),%eax
801052a1:	8d 50 ff             	lea    -0x1(%eax),%edx
801052a4:	89 55 10             	mov    %edx,0x10(%ebp)
801052a7:	85 c0                	test   %eax,%eax
801052a9:	75 e3                	jne    8010528e <memmove+0x35>
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801052ab:	eb 25                	jmp    801052d2 <memmove+0x79>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801052ad:	eb 16                	jmp    801052c5 <memmove+0x6c>
      *d++ = *s++;
801052af:	8b 45 f8             	mov    -0x8(%ebp),%eax
801052b2:	8d 50 01             	lea    0x1(%eax),%edx
801052b5:	89 55 f8             	mov    %edx,-0x8(%ebp)
801052b8:	8b 55 fc             	mov    -0x4(%ebp),%edx
801052bb:	8d 4a 01             	lea    0x1(%edx),%ecx
801052be:	89 4d fc             	mov    %ecx,-0x4(%ebp)
801052c1:	8a 12                	mov    (%edx),%dl
801052c3:	88 10                	mov    %dl,(%eax)
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801052c5:	8b 45 10             	mov    0x10(%ebp),%eax
801052c8:	8d 50 ff             	lea    -0x1(%eax),%edx
801052cb:	89 55 10             	mov    %edx,0x10(%ebp)
801052ce:	85 c0                	test   %eax,%eax
801052d0:	75 dd                	jne    801052af <memmove+0x56>
      *d++ = *s++;

  return dst;
801052d2:	8b 45 08             	mov    0x8(%ebp),%eax
}
801052d5:	c9                   	leave  
801052d6:	c3                   	ret    

801052d7 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801052d7:	55                   	push   %ebp
801052d8:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
801052da:	ff 75 10             	pushl  0x10(%ebp)
801052dd:	ff 75 0c             	pushl  0xc(%ebp)
801052e0:	ff 75 08             	pushl  0x8(%ebp)
801052e3:	e8 71 ff ff ff       	call   80105259 <memmove>
801052e8:	83 c4 0c             	add    $0xc,%esp
}
801052eb:	c9                   	leave  
801052ec:	c3                   	ret    

801052ed <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
801052ed:	55                   	push   %ebp
801052ee:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
801052f0:	eb 09                	jmp    801052fb <strncmp+0xe>
    n--, p++, q++;
801052f2:	ff 4d 10             	decl   0x10(%ebp)
801052f5:	ff 45 08             	incl   0x8(%ebp)
801052f8:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
801052fb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801052ff:	74 17                	je     80105318 <strncmp+0x2b>
80105301:	8b 45 08             	mov    0x8(%ebp),%eax
80105304:	8a 00                	mov    (%eax),%al
80105306:	84 c0                	test   %al,%al
80105308:	74 0e                	je     80105318 <strncmp+0x2b>
8010530a:	8b 45 08             	mov    0x8(%ebp),%eax
8010530d:	8a 10                	mov    (%eax),%dl
8010530f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105312:	8a 00                	mov    (%eax),%al
80105314:	38 c2                	cmp    %al,%dl
80105316:	74 da                	je     801052f2 <strncmp+0x5>
    n--, p++, q++;
  if(n == 0)
80105318:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010531c:	75 07                	jne    80105325 <strncmp+0x38>
    return 0;
8010531e:	b8 00 00 00 00       	mov    $0x0,%eax
80105323:	eb 14                	jmp    80105339 <strncmp+0x4c>
  return (uchar)*p - (uchar)*q;
80105325:	8b 45 08             	mov    0x8(%ebp),%eax
80105328:	8a 00                	mov    (%eax),%al
8010532a:	0f b6 d0             	movzbl %al,%edx
8010532d:	8b 45 0c             	mov    0xc(%ebp),%eax
80105330:	8a 00                	mov    (%eax),%al
80105332:	0f b6 c0             	movzbl %al,%eax
80105335:	29 c2                	sub    %eax,%edx
80105337:	89 d0                	mov    %edx,%eax
}
80105339:	5d                   	pop    %ebp
8010533a:	c3                   	ret    

8010533b <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
8010533b:	55                   	push   %ebp
8010533c:	89 e5                	mov    %esp,%ebp
8010533e:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80105341:	8b 45 08             	mov    0x8(%ebp),%eax
80105344:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
80105347:	90                   	nop
80105348:	8b 45 10             	mov    0x10(%ebp),%eax
8010534b:	8d 50 ff             	lea    -0x1(%eax),%edx
8010534e:	89 55 10             	mov    %edx,0x10(%ebp)
80105351:	85 c0                	test   %eax,%eax
80105353:	7e 1c                	jle    80105371 <strncpy+0x36>
80105355:	8b 45 08             	mov    0x8(%ebp),%eax
80105358:	8d 50 01             	lea    0x1(%eax),%edx
8010535b:	89 55 08             	mov    %edx,0x8(%ebp)
8010535e:	8b 55 0c             	mov    0xc(%ebp),%edx
80105361:	8d 4a 01             	lea    0x1(%edx),%ecx
80105364:	89 4d 0c             	mov    %ecx,0xc(%ebp)
80105367:	8a 12                	mov    (%edx),%dl
80105369:	88 10                	mov    %dl,(%eax)
8010536b:	8a 00                	mov    (%eax),%al
8010536d:	84 c0                	test   %al,%al
8010536f:	75 d7                	jne    80105348 <strncpy+0xd>
    ;
  while(n-- > 0)
80105371:	eb 0c                	jmp    8010537f <strncpy+0x44>
    *s++ = 0;
80105373:	8b 45 08             	mov    0x8(%ebp),%eax
80105376:	8d 50 01             	lea    0x1(%eax),%edx
80105379:	89 55 08             	mov    %edx,0x8(%ebp)
8010537c:	c6 00 00             	movb   $0x0,(%eax)
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
8010537f:	8b 45 10             	mov    0x10(%ebp),%eax
80105382:	8d 50 ff             	lea    -0x1(%eax),%edx
80105385:	89 55 10             	mov    %edx,0x10(%ebp)
80105388:	85 c0                	test   %eax,%eax
8010538a:	7f e7                	jg     80105373 <strncpy+0x38>
    *s++ = 0;
  return os;
8010538c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010538f:	c9                   	leave  
80105390:	c3                   	ret    

80105391 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105391:	55                   	push   %ebp
80105392:	89 e5                	mov    %esp,%ebp
80105394:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80105397:	8b 45 08             	mov    0x8(%ebp),%eax
8010539a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
8010539d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801053a1:	7f 05                	jg     801053a8 <safestrcpy+0x17>
    return os;
801053a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053a6:	eb 2e                	jmp    801053d6 <safestrcpy+0x45>
  while(--n > 0 && (*s++ = *t++) != 0)
801053a8:	ff 4d 10             	decl   0x10(%ebp)
801053ab:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801053af:	7e 1c                	jle    801053cd <safestrcpy+0x3c>
801053b1:	8b 45 08             	mov    0x8(%ebp),%eax
801053b4:	8d 50 01             	lea    0x1(%eax),%edx
801053b7:	89 55 08             	mov    %edx,0x8(%ebp)
801053ba:	8b 55 0c             	mov    0xc(%ebp),%edx
801053bd:	8d 4a 01             	lea    0x1(%edx),%ecx
801053c0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
801053c3:	8a 12                	mov    (%edx),%dl
801053c5:	88 10                	mov    %dl,(%eax)
801053c7:	8a 00                	mov    (%eax),%al
801053c9:	84 c0                	test   %al,%al
801053cb:	75 db                	jne    801053a8 <safestrcpy+0x17>
    ;
  *s = 0;
801053cd:	8b 45 08             	mov    0x8(%ebp),%eax
801053d0:	c6 00 00             	movb   $0x0,(%eax)
  return os;
801053d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801053d6:	c9                   	leave  
801053d7:	c3                   	ret    

801053d8 <strlen>:

int
strlen(const char *s)
{
801053d8:	55                   	push   %ebp
801053d9:	89 e5                	mov    %esp,%ebp
801053db:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
801053de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801053e5:	eb 03                	jmp    801053ea <strlen+0x12>
801053e7:	ff 45 fc             	incl   -0x4(%ebp)
801053ea:	8b 55 fc             	mov    -0x4(%ebp),%edx
801053ed:	8b 45 08             	mov    0x8(%ebp),%eax
801053f0:	01 d0                	add    %edx,%eax
801053f2:	8a 00                	mov    (%eax),%al
801053f4:	84 c0                	test   %al,%al
801053f6:	75 ef                	jne    801053e7 <strlen+0xf>
    ;
  return n;
801053f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801053fb:	c9                   	leave  
801053fc:	c3                   	ret    

801053fd <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
801053fd:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80105401:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80105405:	55                   	push   %ebp
  pushl %ebx
80105406:	53                   	push   %ebx
  pushl %esi
80105407:	56                   	push   %esi
  pushl %edi
80105408:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105409:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
8010540b:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010540d:	5f                   	pop    %edi
  popl %esi
8010540e:	5e                   	pop    %esi
  popl %ebx
8010540f:	5b                   	pop    %ebx
  popl %ebp
80105410:	5d                   	pop    %ebp
  ret
80105411:	c3                   	ret    

80105412 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105412:	55                   	push   %ebp
80105413:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80105415:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010541b:	8b 00                	mov    (%eax),%eax
8010541d:	3b 45 08             	cmp    0x8(%ebp),%eax
80105420:	76 12                	jbe    80105434 <fetchint+0x22>
80105422:	8b 45 08             	mov    0x8(%ebp),%eax
80105425:	8d 50 04             	lea    0x4(%eax),%edx
80105428:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010542e:	8b 00                	mov    (%eax),%eax
80105430:	39 c2                	cmp    %eax,%edx
80105432:	76 07                	jbe    8010543b <fetchint+0x29>
    return -1;
80105434:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105439:	eb 0f                	jmp    8010544a <fetchint+0x38>
  *ip = *(int*)(addr);
8010543b:	8b 45 08             	mov    0x8(%ebp),%eax
8010543e:	8b 10                	mov    (%eax),%edx
80105440:	8b 45 0c             	mov    0xc(%ebp),%eax
80105443:	89 10                	mov    %edx,(%eax)
  return 0;
80105445:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010544a:	5d                   	pop    %ebp
8010544b:	c3                   	ret    

8010544c <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
8010544c:	55                   	push   %ebp
8010544d:	89 e5                	mov    %esp,%ebp
8010544f:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
80105452:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105458:	8b 00                	mov    (%eax),%eax
8010545a:	3b 45 08             	cmp    0x8(%ebp),%eax
8010545d:	77 07                	ja     80105466 <fetchstr+0x1a>
    return -1;
8010545f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105464:	eb 44                	jmp    801054aa <fetchstr+0x5e>
  *pp = (char*)addr;
80105466:	8b 55 08             	mov    0x8(%ebp),%edx
80105469:	8b 45 0c             	mov    0xc(%ebp),%eax
8010546c:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
8010546e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105474:	8b 00                	mov    (%eax),%eax
80105476:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
80105479:	8b 45 0c             	mov    0xc(%ebp),%eax
8010547c:	8b 00                	mov    (%eax),%eax
8010547e:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105481:	eb 1a                	jmp    8010549d <fetchstr+0x51>
    if(*s == 0)
80105483:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105486:	8a 00                	mov    (%eax),%al
80105488:	84 c0                	test   %al,%al
8010548a:	75 0e                	jne    8010549a <fetchstr+0x4e>
      return s - *pp;
8010548c:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010548f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105492:	8b 00                	mov    (%eax),%eax
80105494:	29 c2                	sub    %eax,%edx
80105496:	89 d0                	mov    %edx,%eax
80105498:	eb 10                	jmp    801054aa <fetchstr+0x5e>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
8010549a:	ff 45 fc             	incl   -0x4(%ebp)
8010549d:	8b 45 fc             	mov    -0x4(%ebp),%eax
801054a0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801054a3:	72 de                	jb     80105483 <fetchstr+0x37>
    if(*s == 0)
      return s - *pp;
  return -1;
801054a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054aa:	c9                   	leave  
801054ab:	c3                   	ret    

801054ac <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801054ac:	55                   	push   %ebp
801054ad:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801054af:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054b5:	8b 40 18             	mov    0x18(%eax),%eax
801054b8:	8b 50 44             	mov    0x44(%eax),%edx
801054bb:	8b 45 08             	mov    0x8(%ebp),%eax
801054be:	c1 e0 02             	shl    $0x2,%eax
801054c1:	01 d0                	add    %edx,%eax
801054c3:	83 c0 04             	add    $0x4,%eax
801054c6:	ff 75 0c             	pushl  0xc(%ebp)
801054c9:	50                   	push   %eax
801054ca:	e8 43 ff ff ff       	call   80105412 <fetchint>
801054cf:	83 c4 08             	add    $0x8,%esp
}
801054d2:	c9                   	leave  
801054d3:	c3                   	ret    

801054d4 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801054d4:	55                   	push   %ebp
801054d5:	89 e5                	mov    %esp,%ebp
801054d7:	83 ec 10             	sub    $0x10,%esp
  int i;
  
  if(argint(n, &i) < 0)
801054da:	8d 45 fc             	lea    -0x4(%ebp),%eax
801054dd:	50                   	push   %eax
801054de:	ff 75 08             	pushl  0x8(%ebp)
801054e1:	e8 c6 ff ff ff       	call   801054ac <argint>
801054e6:	83 c4 08             	add    $0x8,%esp
801054e9:	85 c0                	test   %eax,%eax
801054eb:	79 07                	jns    801054f4 <argptr+0x20>
    return -1;
801054ed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054f2:	eb 3d                	jmp    80105531 <argptr+0x5d>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
801054f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
801054f7:	89 c2                	mov    %eax,%edx
801054f9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054ff:	8b 00                	mov    (%eax),%eax
80105501:	39 c2                	cmp    %eax,%edx
80105503:	73 16                	jae    8010551b <argptr+0x47>
80105505:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105508:	89 c2                	mov    %eax,%edx
8010550a:	8b 45 10             	mov    0x10(%ebp),%eax
8010550d:	01 c2                	add    %eax,%edx
8010550f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105515:	8b 00                	mov    (%eax),%eax
80105517:	39 c2                	cmp    %eax,%edx
80105519:	76 07                	jbe    80105522 <argptr+0x4e>
    return -1;
8010551b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105520:	eb 0f                	jmp    80105531 <argptr+0x5d>
  *pp = (char*)i;
80105522:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105525:	89 c2                	mov    %eax,%edx
80105527:	8b 45 0c             	mov    0xc(%ebp),%eax
8010552a:	89 10                	mov    %edx,(%eax)
  return 0;
8010552c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105531:	c9                   	leave  
80105532:	c3                   	ret    

80105533 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105533:	55                   	push   %ebp
80105534:	89 e5                	mov    %esp,%ebp
80105536:	83 ec 10             	sub    $0x10,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105539:	8d 45 fc             	lea    -0x4(%ebp),%eax
8010553c:	50                   	push   %eax
8010553d:	ff 75 08             	pushl  0x8(%ebp)
80105540:	e8 67 ff ff ff       	call   801054ac <argint>
80105545:	83 c4 08             	add    $0x8,%esp
80105548:	85 c0                	test   %eax,%eax
8010554a:	79 07                	jns    80105553 <argstr+0x20>
    return -1;
8010554c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105551:	eb 0f                	jmp    80105562 <argstr+0x2f>
  return fetchstr(addr, pp);
80105553:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105556:	ff 75 0c             	pushl  0xc(%ebp)
80105559:	50                   	push   %eax
8010555a:	e8 ed fe ff ff       	call   8010544c <fetchstr>
8010555f:	83 c4 08             	add    $0x8,%esp
}
80105562:	c9                   	leave  
80105563:	c3                   	ret    

80105564 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80105564:	55                   	push   %ebp
80105565:	89 e5                	mov    %esp,%ebp
80105567:	53                   	push   %ebx
80105568:	83 ec 14             	sub    $0x14,%esp
  int num;

  num = proc->tf->eax;
8010556b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105571:	8b 40 18             	mov    0x18(%eax),%eax
80105574:	8b 40 1c             	mov    0x1c(%eax),%eax
80105577:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
8010557a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010557e:	7e 30                	jle    801055b0 <syscall+0x4c>
80105580:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105583:	83 f8 15             	cmp    $0x15,%eax
80105586:	77 28                	ja     801055b0 <syscall+0x4c>
80105588:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010558b:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
80105592:	85 c0                	test   %eax,%eax
80105594:	74 1a                	je     801055b0 <syscall+0x4c>
    proc->tf->eax = syscalls[num]();
80105596:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010559c:	8b 58 18             	mov    0x18(%eax),%ebx
8010559f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055a2:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
801055a9:	ff d0                	call   *%eax
801055ab:	89 43 1c             	mov    %eax,0x1c(%ebx)
801055ae:	eb 34                	jmp    801055e4 <syscall+0x80>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
801055b0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055b6:	8d 50 6c             	lea    0x6c(%eax),%edx
801055b9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801055bf:	8b 40 10             	mov    0x10(%eax),%eax
801055c2:	ff 75 f4             	pushl  -0xc(%ebp)
801055c5:	52                   	push   %edx
801055c6:	50                   	push   %eax
801055c7:	68 07 88 10 80       	push   $0x80108807
801055cc:	e8 e7 ad ff ff       	call   801003b8 <cprintf>
801055d1:	83 c4 10             	add    $0x10,%esp
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
801055d4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055da:	8b 40 18             	mov    0x18(%eax),%eax
801055dd:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
801055e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801055e7:	c9                   	leave  
801055e8:	c3                   	ret    

801055e9 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
801055e9:	55                   	push   %ebp
801055ea:	89 e5                	mov    %esp,%ebp
801055ec:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
801055ef:	83 ec 08             	sub    $0x8,%esp
801055f2:	8d 45 f0             	lea    -0x10(%ebp),%eax
801055f5:	50                   	push   %eax
801055f6:	ff 75 08             	pushl  0x8(%ebp)
801055f9:	e8 ae fe ff ff       	call   801054ac <argint>
801055fe:	83 c4 10             	add    $0x10,%esp
80105601:	85 c0                	test   %eax,%eax
80105603:	79 07                	jns    8010560c <argfd+0x23>
    return -1;
80105605:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010560a:	eb 50                	jmp    8010565c <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
8010560c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010560f:	85 c0                	test   %eax,%eax
80105611:	78 21                	js     80105634 <argfd+0x4b>
80105613:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105616:	83 f8 0f             	cmp    $0xf,%eax
80105619:	7f 19                	jg     80105634 <argfd+0x4b>
8010561b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105621:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105624:	83 c2 08             	add    $0x8,%edx
80105627:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010562b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010562e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105632:	75 07                	jne    8010563b <argfd+0x52>
    return -1;
80105634:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105639:	eb 21                	jmp    8010565c <argfd+0x73>
  if(pfd)
8010563b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010563f:	74 08                	je     80105649 <argfd+0x60>
    *pfd = fd;
80105641:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105644:	8b 45 0c             	mov    0xc(%ebp),%eax
80105647:	89 10                	mov    %edx,(%eax)
  if(pf)
80105649:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010564d:	74 08                	je     80105657 <argfd+0x6e>
    *pf = f;
8010564f:	8b 45 10             	mov    0x10(%ebp),%eax
80105652:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105655:	89 10                	mov    %edx,(%eax)
  return 0;
80105657:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010565c:	c9                   	leave  
8010565d:	c3                   	ret    

8010565e <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
8010565e:	55                   	push   %ebp
8010565f:	89 e5                	mov    %esp,%ebp
80105661:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105664:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
8010566b:	eb 2f                	jmp    8010569c <fdalloc+0x3e>
    if(proc->ofile[fd] == 0){
8010566d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105673:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105676:	83 c2 08             	add    $0x8,%edx
80105679:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010567d:	85 c0                	test   %eax,%eax
8010567f:	75 18                	jne    80105699 <fdalloc+0x3b>
      proc->ofile[fd] = f;
80105681:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105687:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010568a:	8d 4a 08             	lea    0x8(%edx),%ecx
8010568d:	8b 55 08             	mov    0x8(%ebp),%edx
80105690:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
80105694:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105697:	eb 0e                	jmp    801056a7 <fdalloc+0x49>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105699:	ff 45 fc             	incl   -0x4(%ebp)
8010569c:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
801056a0:	7e cb                	jle    8010566d <fdalloc+0xf>
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
801056a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056a7:	c9                   	leave  
801056a8:	c3                   	ret    

801056a9 <sys_dup>:

int
sys_dup(void)
{
801056a9:	55                   	push   %ebp
801056aa:	89 e5                	mov    %esp,%ebp
801056ac:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
801056af:	83 ec 04             	sub    $0x4,%esp
801056b2:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056b5:	50                   	push   %eax
801056b6:	6a 00                	push   $0x0
801056b8:	6a 00                	push   $0x0
801056ba:	e8 2a ff ff ff       	call   801055e9 <argfd>
801056bf:	83 c4 10             	add    $0x10,%esp
801056c2:	85 c0                	test   %eax,%eax
801056c4:	79 07                	jns    801056cd <sys_dup+0x24>
    return -1;
801056c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056cb:	eb 31                	jmp    801056fe <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
801056cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801056d0:	83 ec 0c             	sub    $0xc,%esp
801056d3:	50                   	push   %eax
801056d4:	e8 85 ff ff ff       	call   8010565e <fdalloc>
801056d9:	83 c4 10             	add    $0x10,%esp
801056dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
801056df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801056e3:	79 07                	jns    801056ec <sys_dup+0x43>
    return -1;
801056e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056ea:	eb 12                	jmp    801056fe <sys_dup+0x55>
  filedup(f);
801056ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
801056ef:	83 ec 0c             	sub    $0xc,%esp
801056f2:	50                   	push   %eax
801056f3:	e8 9f b8 ff ff       	call   80100f97 <filedup>
801056f8:	83 c4 10             	add    $0x10,%esp
  return fd;
801056fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801056fe:	c9                   	leave  
801056ff:	c3                   	ret    

80105700 <sys_read>:

int
sys_read(void)
{
80105700:	55                   	push   %ebp
80105701:	89 e5                	mov    %esp,%ebp
80105703:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105706:	83 ec 04             	sub    $0x4,%esp
80105709:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010570c:	50                   	push   %eax
8010570d:	6a 00                	push   $0x0
8010570f:	6a 00                	push   $0x0
80105711:	e8 d3 fe ff ff       	call   801055e9 <argfd>
80105716:	83 c4 10             	add    $0x10,%esp
80105719:	85 c0                	test   %eax,%eax
8010571b:	78 2e                	js     8010574b <sys_read+0x4b>
8010571d:	83 ec 08             	sub    $0x8,%esp
80105720:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105723:	50                   	push   %eax
80105724:	6a 02                	push   $0x2
80105726:	e8 81 fd ff ff       	call   801054ac <argint>
8010572b:	83 c4 10             	add    $0x10,%esp
8010572e:	85 c0                	test   %eax,%eax
80105730:	78 19                	js     8010574b <sys_read+0x4b>
80105732:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105735:	83 ec 04             	sub    $0x4,%esp
80105738:	50                   	push   %eax
80105739:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010573c:	50                   	push   %eax
8010573d:	6a 01                	push   $0x1
8010573f:	e8 90 fd ff ff       	call   801054d4 <argptr>
80105744:	83 c4 10             	add    $0x10,%esp
80105747:	85 c0                	test   %eax,%eax
80105749:	79 07                	jns    80105752 <sys_read+0x52>
    return -1;
8010574b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105750:	eb 17                	jmp    80105769 <sys_read+0x69>
  return fileread(f, p, n);
80105752:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105755:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105758:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010575b:	83 ec 04             	sub    $0x4,%esp
8010575e:	51                   	push   %ecx
8010575f:	52                   	push   %edx
80105760:	50                   	push   %eax
80105761:	e8 b5 b9 ff ff       	call   8010111b <fileread>
80105766:	83 c4 10             	add    $0x10,%esp
}
80105769:	c9                   	leave  
8010576a:	c3                   	ret    

8010576b <sys_write>:

int
sys_write(void)
{
8010576b:	55                   	push   %ebp
8010576c:	89 e5                	mov    %esp,%ebp
8010576e:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105771:	83 ec 04             	sub    $0x4,%esp
80105774:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105777:	50                   	push   %eax
80105778:	6a 00                	push   $0x0
8010577a:	6a 00                	push   $0x0
8010577c:	e8 68 fe ff ff       	call   801055e9 <argfd>
80105781:	83 c4 10             	add    $0x10,%esp
80105784:	85 c0                	test   %eax,%eax
80105786:	78 2e                	js     801057b6 <sys_write+0x4b>
80105788:	83 ec 08             	sub    $0x8,%esp
8010578b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010578e:	50                   	push   %eax
8010578f:	6a 02                	push   $0x2
80105791:	e8 16 fd ff ff       	call   801054ac <argint>
80105796:	83 c4 10             	add    $0x10,%esp
80105799:	85 c0                	test   %eax,%eax
8010579b:	78 19                	js     801057b6 <sys_write+0x4b>
8010579d:	8b 45 f0             	mov    -0x10(%ebp),%eax
801057a0:	83 ec 04             	sub    $0x4,%esp
801057a3:	50                   	push   %eax
801057a4:	8d 45 ec             	lea    -0x14(%ebp),%eax
801057a7:	50                   	push   %eax
801057a8:	6a 01                	push   $0x1
801057aa:	e8 25 fd ff ff       	call   801054d4 <argptr>
801057af:	83 c4 10             	add    $0x10,%esp
801057b2:	85 c0                	test   %eax,%eax
801057b4:	79 07                	jns    801057bd <sys_write+0x52>
    return -1;
801057b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057bb:	eb 17                	jmp    801057d4 <sys_write+0x69>
  return filewrite(f, p, n);
801057bd:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801057c0:	8b 55 ec             	mov    -0x14(%ebp),%edx
801057c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057c6:	83 ec 04             	sub    $0x4,%esp
801057c9:	51                   	push   %ecx
801057ca:	52                   	push   %edx
801057cb:	50                   	push   %eax
801057cc:	e8 01 ba ff ff       	call   801011d2 <filewrite>
801057d1:	83 c4 10             	add    $0x10,%esp
}
801057d4:	c9                   	leave  
801057d5:	c3                   	ret    

801057d6 <sys_close>:

int
sys_close(void)
{
801057d6:	55                   	push   %ebp
801057d7:	89 e5                	mov    %esp,%ebp
801057d9:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
801057dc:	83 ec 04             	sub    $0x4,%esp
801057df:	8d 45 f0             	lea    -0x10(%ebp),%eax
801057e2:	50                   	push   %eax
801057e3:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057e6:	50                   	push   %eax
801057e7:	6a 00                	push   $0x0
801057e9:	e8 fb fd ff ff       	call   801055e9 <argfd>
801057ee:	83 c4 10             	add    $0x10,%esp
801057f1:	85 c0                	test   %eax,%eax
801057f3:	79 07                	jns    801057fc <sys_close+0x26>
    return -1;
801057f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057fa:	eb 28                	jmp    80105824 <sys_close+0x4e>
  proc->ofile[fd] = 0;
801057fc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105802:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105805:	83 c2 08             	add    $0x8,%edx
80105808:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
8010580f:	00 
  fileclose(f);
80105810:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105813:	83 ec 0c             	sub    $0xc,%esp
80105816:	50                   	push   %eax
80105817:	e8 cc b7 ff ff       	call   80100fe8 <fileclose>
8010581c:	83 c4 10             	add    $0x10,%esp
  return 0;
8010581f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105824:	c9                   	leave  
80105825:	c3                   	ret    

80105826 <sys_fstat>:

int
sys_fstat(void)
{
80105826:	55                   	push   %ebp
80105827:	89 e5                	mov    %esp,%ebp
80105829:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
8010582c:	83 ec 04             	sub    $0x4,%esp
8010582f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105832:	50                   	push   %eax
80105833:	6a 00                	push   $0x0
80105835:	6a 00                	push   $0x0
80105837:	e8 ad fd ff ff       	call   801055e9 <argfd>
8010583c:	83 c4 10             	add    $0x10,%esp
8010583f:	85 c0                	test   %eax,%eax
80105841:	78 17                	js     8010585a <sys_fstat+0x34>
80105843:	83 ec 04             	sub    $0x4,%esp
80105846:	6a 14                	push   $0x14
80105848:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010584b:	50                   	push   %eax
8010584c:	6a 01                	push   $0x1
8010584e:	e8 81 fc ff ff       	call   801054d4 <argptr>
80105853:	83 c4 10             	add    $0x10,%esp
80105856:	85 c0                	test   %eax,%eax
80105858:	79 07                	jns    80105861 <sys_fstat+0x3b>
    return -1;
8010585a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010585f:	eb 13                	jmp    80105874 <sys_fstat+0x4e>
  return filestat(f, st);
80105861:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105864:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105867:	83 ec 08             	sub    $0x8,%esp
8010586a:	52                   	push   %edx
8010586b:	50                   	push   %eax
8010586c:	e8 53 b8 ff ff       	call   801010c4 <filestat>
80105871:	83 c4 10             	add    $0x10,%esp
}
80105874:	c9                   	leave  
80105875:	c3                   	ret    

80105876 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105876:	55                   	push   %ebp
80105877:	89 e5                	mov    %esp,%ebp
80105879:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010587c:	83 ec 08             	sub    $0x8,%esp
8010587f:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105882:	50                   	push   %eax
80105883:	6a 00                	push   $0x0
80105885:	e8 a9 fc ff ff       	call   80105533 <argstr>
8010588a:	83 c4 10             	add    $0x10,%esp
8010588d:	85 c0                	test   %eax,%eax
8010588f:	78 15                	js     801058a6 <sys_link+0x30>
80105891:	83 ec 08             	sub    $0x8,%esp
80105894:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105897:	50                   	push   %eax
80105898:	6a 01                	push   $0x1
8010589a:	e8 94 fc ff ff       	call   80105533 <argstr>
8010589f:	83 c4 10             	add    $0x10,%esp
801058a2:	85 c0                	test   %eax,%eax
801058a4:	79 0a                	jns    801058b0 <sys_link+0x3a>
    return -1;
801058a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058ab:	e9 60 01 00 00       	jmp    80105a10 <sys_link+0x19a>

  begin_op();
801058b0:	e8 a1 db ff ff       	call   80103456 <begin_op>
  if((ip = namei(old)) == 0){
801058b5:	8b 45 d8             	mov    -0x28(%ebp),%eax
801058b8:	83 ec 0c             	sub    $0xc,%esp
801058bb:	50                   	push   %eax
801058bc:	e8 cc cb ff ff       	call   8010248d <namei>
801058c1:	83 c4 10             	add    $0x10,%esp
801058c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
801058c7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801058cb:	75 0f                	jne    801058dc <sys_link+0x66>
    end_op();
801058cd:	e8 10 dc ff ff       	call   801034e2 <end_op>
    return -1;
801058d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058d7:	e9 34 01 00 00       	jmp    80105a10 <sys_link+0x19a>
  }

  ilock(ip);
801058dc:	83 ec 0c             	sub    $0xc,%esp
801058df:	ff 75 f4             	pushl  -0xc(%ebp)
801058e2:	e8 f4 bf ff ff       	call   801018db <ilock>
801058e7:	83 c4 10             	add    $0x10,%esp
  if(ip->type == T_DIR){
801058ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058ed:	8b 40 10             	mov    0x10(%eax),%eax
801058f0:	66 83 f8 01          	cmp    $0x1,%ax
801058f4:	75 1d                	jne    80105913 <sys_link+0x9d>
    iunlockput(ip);
801058f6:	83 ec 0c             	sub    $0xc,%esp
801058f9:	ff 75 f4             	pushl  -0xc(%ebp)
801058fc:	e8 94 c2 ff ff       	call   80101b95 <iunlockput>
80105901:	83 c4 10             	add    $0x10,%esp
    end_op();
80105904:	e8 d9 db ff ff       	call   801034e2 <end_op>
    return -1;
80105909:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010590e:	e9 fd 00 00 00       	jmp    80105a10 <sys_link+0x19a>
  }

  ip->nlink++;
80105913:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105916:	66 8b 40 16          	mov    0x16(%eax),%ax
8010591a:	40                   	inc    %eax
8010591b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010591e:	66 89 42 16          	mov    %ax,0x16(%edx)
  iupdate(ip);
80105922:	83 ec 0c             	sub    $0xc,%esp
80105925:	ff 75 f4             	pushl  -0xc(%ebp)
80105928:	e8 d7 bd ff ff       	call   80101704 <iupdate>
8010592d:	83 c4 10             	add    $0x10,%esp
  iunlock(ip);
80105930:	83 ec 0c             	sub    $0xc,%esp
80105933:	ff 75 f4             	pushl  -0xc(%ebp)
80105936:	e8 fa c0 ff ff       	call   80101a35 <iunlock>
8010593b:	83 c4 10             	add    $0x10,%esp

  if((dp = nameiparent(new, name)) == 0)
8010593e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105941:	83 ec 08             	sub    $0x8,%esp
80105944:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80105947:	52                   	push   %edx
80105948:	50                   	push   %eax
80105949:	e8 5b cb ff ff       	call   801024a9 <nameiparent>
8010594e:	83 c4 10             	add    $0x10,%esp
80105951:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105954:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105958:	75 02                	jne    8010595c <sys_link+0xe6>
    goto bad;
8010595a:	eb 71                	jmp    801059cd <sys_link+0x157>
  ilock(dp);
8010595c:	83 ec 0c             	sub    $0xc,%esp
8010595f:	ff 75 f0             	pushl  -0x10(%ebp)
80105962:	e8 74 bf ff ff       	call   801018db <ilock>
80105967:	83 c4 10             	add    $0x10,%esp
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
8010596a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010596d:	8b 10                	mov    (%eax),%edx
8010596f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105972:	8b 00                	mov    (%eax),%eax
80105974:	39 c2                	cmp    %eax,%edx
80105976:	75 1d                	jne    80105995 <sys_link+0x11f>
80105978:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010597b:	8b 40 04             	mov    0x4(%eax),%eax
8010597e:	83 ec 04             	sub    $0x4,%esp
80105981:	50                   	push   %eax
80105982:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80105985:	50                   	push   %eax
80105986:	ff 75 f0             	pushl  -0x10(%ebp)
80105989:	e8 73 c8 ff ff       	call   80102201 <dirlink>
8010598e:	83 c4 10             	add    $0x10,%esp
80105991:	85 c0                	test   %eax,%eax
80105993:	79 10                	jns    801059a5 <sys_link+0x12f>
    iunlockput(dp);
80105995:	83 ec 0c             	sub    $0xc,%esp
80105998:	ff 75 f0             	pushl  -0x10(%ebp)
8010599b:	e8 f5 c1 ff ff       	call   80101b95 <iunlockput>
801059a0:	83 c4 10             	add    $0x10,%esp
    goto bad;
801059a3:	eb 28                	jmp    801059cd <sys_link+0x157>
  }
  iunlockput(dp);
801059a5:	83 ec 0c             	sub    $0xc,%esp
801059a8:	ff 75 f0             	pushl  -0x10(%ebp)
801059ab:	e8 e5 c1 ff ff       	call   80101b95 <iunlockput>
801059b0:	83 c4 10             	add    $0x10,%esp
  iput(ip);
801059b3:	83 ec 0c             	sub    $0xc,%esp
801059b6:	ff 75 f4             	pushl  -0xc(%ebp)
801059b9:	e8 e8 c0 ff ff       	call   80101aa6 <iput>
801059be:	83 c4 10             	add    $0x10,%esp

  end_op();
801059c1:	e8 1c db ff ff       	call   801034e2 <end_op>

  return 0;
801059c6:	b8 00 00 00 00       	mov    $0x0,%eax
801059cb:	eb 43                	jmp    80105a10 <sys_link+0x19a>

bad:
  ilock(ip);
801059cd:	83 ec 0c             	sub    $0xc,%esp
801059d0:	ff 75 f4             	pushl  -0xc(%ebp)
801059d3:	e8 03 bf ff ff       	call   801018db <ilock>
801059d8:	83 c4 10             	add    $0x10,%esp
  ip->nlink--;
801059db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059de:	66 8b 40 16          	mov    0x16(%eax),%ax
801059e2:	48                   	dec    %eax
801059e3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801059e6:	66 89 42 16          	mov    %ax,0x16(%edx)
  iupdate(ip);
801059ea:	83 ec 0c             	sub    $0xc,%esp
801059ed:	ff 75 f4             	pushl  -0xc(%ebp)
801059f0:	e8 0f bd ff ff       	call   80101704 <iupdate>
801059f5:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
801059f8:	83 ec 0c             	sub    $0xc,%esp
801059fb:	ff 75 f4             	pushl  -0xc(%ebp)
801059fe:	e8 92 c1 ff ff       	call   80101b95 <iunlockput>
80105a03:	83 c4 10             	add    $0x10,%esp
  end_op();
80105a06:	e8 d7 da ff ff       	call   801034e2 <end_op>
  return -1;
80105a0b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a10:	c9                   	leave  
80105a11:	c3                   	ret    

80105a12 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80105a12:	55                   	push   %ebp
80105a13:	89 e5                	mov    %esp,%ebp
80105a15:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105a18:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
80105a1f:	eb 3f                	jmp    80105a60 <isdirempty+0x4e>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105a21:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a24:	6a 10                	push   $0x10
80105a26:	50                   	push   %eax
80105a27:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105a2a:	50                   	push   %eax
80105a2b:	ff 75 08             	pushl  0x8(%ebp)
80105a2e:	e8 0a c4 ff ff       	call   80101e3d <readi>
80105a33:	83 c4 10             	add    $0x10,%esp
80105a36:	83 f8 10             	cmp    $0x10,%eax
80105a39:	74 0d                	je     80105a48 <isdirempty+0x36>
      panic("isdirempty: readi");
80105a3b:	83 ec 0c             	sub    $0xc,%esp
80105a3e:	68 23 88 10 80       	push   $0x80108823
80105a43:	e8 06 ab ff ff       	call   8010054e <panic>
    if(de.inum != 0)
80105a48:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105a4b:	66 85 c0             	test   %ax,%ax
80105a4e:	74 07                	je     80105a57 <isdirempty+0x45>
      return 0;
80105a50:	b8 00 00 00 00       	mov    $0x0,%eax
80105a55:	eb 1b                	jmp    80105a72 <isdirempty+0x60>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105a57:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a5a:	83 c0 10             	add    $0x10,%eax
80105a5d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105a60:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105a63:	8b 45 08             	mov    0x8(%ebp),%eax
80105a66:	8b 40 18             	mov    0x18(%eax),%eax
80105a69:	39 c2                	cmp    %eax,%edx
80105a6b:	72 b4                	jb     80105a21 <isdirempty+0xf>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
80105a6d:	b8 01 00 00 00       	mov    $0x1,%eax
}
80105a72:	c9                   	leave  
80105a73:	c3                   	ret    

80105a74 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80105a74:	55                   	push   %ebp
80105a75:	89 e5                	mov    %esp,%ebp
80105a77:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105a7a:	83 ec 08             	sub    $0x8,%esp
80105a7d:	8d 45 cc             	lea    -0x34(%ebp),%eax
80105a80:	50                   	push   %eax
80105a81:	6a 00                	push   $0x0
80105a83:	e8 ab fa ff ff       	call   80105533 <argstr>
80105a88:	83 c4 10             	add    $0x10,%esp
80105a8b:	85 c0                	test   %eax,%eax
80105a8d:	79 0a                	jns    80105a99 <sys_unlink+0x25>
    return -1;
80105a8f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a94:	e9 b2 01 00 00       	jmp    80105c4b <sys_unlink+0x1d7>

  begin_op();
80105a99:	e8 b8 d9 ff ff       	call   80103456 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105a9e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105aa1:	83 ec 08             	sub    $0x8,%esp
80105aa4:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80105aa7:	52                   	push   %edx
80105aa8:	50                   	push   %eax
80105aa9:	e8 fb c9 ff ff       	call   801024a9 <nameiparent>
80105aae:	83 c4 10             	add    $0x10,%esp
80105ab1:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105ab4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105ab8:	75 0f                	jne    80105ac9 <sys_unlink+0x55>
    end_op();
80105aba:	e8 23 da ff ff       	call   801034e2 <end_op>
    return -1;
80105abf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ac4:	e9 82 01 00 00       	jmp    80105c4b <sys_unlink+0x1d7>
  }

  ilock(dp);
80105ac9:	83 ec 0c             	sub    $0xc,%esp
80105acc:	ff 75 f4             	pushl  -0xc(%ebp)
80105acf:	e8 07 be ff ff       	call   801018db <ilock>
80105ad4:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105ad7:	83 ec 08             	sub    $0x8,%esp
80105ada:	68 35 88 10 80       	push   $0x80108835
80105adf:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105ae2:	50                   	push   %eax
80105ae3:	e8 46 c6 ff ff       	call   8010212e <namecmp>
80105ae8:	83 c4 10             	add    $0x10,%esp
80105aeb:	85 c0                	test   %eax,%eax
80105aed:	0f 84 40 01 00 00    	je     80105c33 <sys_unlink+0x1bf>
80105af3:	83 ec 08             	sub    $0x8,%esp
80105af6:	68 37 88 10 80       	push   $0x80108837
80105afb:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105afe:	50                   	push   %eax
80105aff:	e8 2a c6 ff ff       	call   8010212e <namecmp>
80105b04:	83 c4 10             	add    $0x10,%esp
80105b07:	85 c0                	test   %eax,%eax
80105b09:	0f 84 24 01 00 00    	je     80105c33 <sys_unlink+0x1bf>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105b0f:	83 ec 04             	sub    $0x4,%esp
80105b12:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105b15:	50                   	push   %eax
80105b16:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105b19:	50                   	push   %eax
80105b1a:	ff 75 f4             	pushl  -0xc(%ebp)
80105b1d:	e8 27 c6 ff ff       	call   80102149 <dirlookup>
80105b22:	83 c4 10             	add    $0x10,%esp
80105b25:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105b28:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105b2c:	75 05                	jne    80105b33 <sys_unlink+0xbf>
    goto bad;
80105b2e:	e9 00 01 00 00       	jmp    80105c33 <sys_unlink+0x1bf>
  ilock(ip);
80105b33:	83 ec 0c             	sub    $0xc,%esp
80105b36:	ff 75 f0             	pushl  -0x10(%ebp)
80105b39:	e8 9d bd ff ff       	call   801018db <ilock>
80105b3e:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
80105b41:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b44:	66 8b 40 16          	mov    0x16(%eax),%ax
80105b48:	66 85 c0             	test   %ax,%ax
80105b4b:	7f 0d                	jg     80105b5a <sys_unlink+0xe6>
    panic("unlink: nlink < 1");
80105b4d:	83 ec 0c             	sub    $0xc,%esp
80105b50:	68 3a 88 10 80       	push   $0x8010883a
80105b55:	e8 f4 a9 ff ff       	call   8010054e <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105b5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b5d:	8b 40 10             	mov    0x10(%eax),%eax
80105b60:	66 83 f8 01          	cmp    $0x1,%ax
80105b64:	75 25                	jne    80105b8b <sys_unlink+0x117>
80105b66:	83 ec 0c             	sub    $0xc,%esp
80105b69:	ff 75 f0             	pushl  -0x10(%ebp)
80105b6c:	e8 a1 fe ff ff       	call   80105a12 <isdirempty>
80105b71:	83 c4 10             	add    $0x10,%esp
80105b74:	85 c0                	test   %eax,%eax
80105b76:	75 13                	jne    80105b8b <sys_unlink+0x117>
    iunlockput(ip);
80105b78:	83 ec 0c             	sub    $0xc,%esp
80105b7b:	ff 75 f0             	pushl  -0x10(%ebp)
80105b7e:	e8 12 c0 ff ff       	call   80101b95 <iunlockput>
80105b83:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105b86:	e9 a8 00 00 00       	jmp    80105c33 <sys_unlink+0x1bf>
  }

  memset(&de, 0, sizeof(de));
80105b8b:	83 ec 04             	sub    $0x4,%esp
80105b8e:	6a 10                	push   $0x10
80105b90:	6a 00                	push   $0x0
80105b92:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105b95:	50                   	push   %eax
80105b96:	e8 05 f6 ff ff       	call   801051a0 <memset>
80105b9b:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105b9e:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105ba1:	6a 10                	push   $0x10
80105ba3:	50                   	push   %eax
80105ba4:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105ba7:	50                   	push   %eax
80105ba8:	ff 75 f4             	pushl  -0xc(%ebp)
80105bab:	e8 ed c3 ff ff       	call   80101f9d <writei>
80105bb0:	83 c4 10             	add    $0x10,%esp
80105bb3:	83 f8 10             	cmp    $0x10,%eax
80105bb6:	74 0d                	je     80105bc5 <sys_unlink+0x151>
    panic("unlink: writei");
80105bb8:	83 ec 0c             	sub    $0xc,%esp
80105bbb:	68 4c 88 10 80       	push   $0x8010884c
80105bc0:	e8 89 a9 ff ff       	call   8010054e <panic>
  if(ip->type == T_DIR){
80105bc5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bc8:	8b 40 10             	mov    0x10(%eax),%eax
80105bcb:	66 83 f8 01          	cmp    $0x1,%ax
80105bcf:	75 1d                	jne    80105bee <sys_unlink+0x17a>
    dp->nlink--;
80105bd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bd4:	66 8b 40 16          	mov    0x16(%eax),%ax
80105bd8:	48                   	dec    %eax
80105bd9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105bdc:	66 89 42 16          	mov    %ax,0x16(%edx)
    iupdate(dp);
80105be0:	83 ec 0c             	sub    $0xc,%esp
80105be3:	ff 75 f4             	pushl  -0xc(%ebp)
80105be6:	e8 19 bb ff ff       	call   80101704 <iupdate>
80105beb:	83 c4 10             	add    $0x10,%esp
  }
  iunlockput(dp);
80105bee:	83 ec 0c             	sub    $0xc,%esp
80105bf1:	ff 75 f4             	pushl  -0xc(%ebp)
80105bf4:	e8 9c bf ff ff       	call   80101b95 <iunlockput>
80105bf9:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
80105bfc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bff:	66 8b 40 16          	mov    0x16(%eax),%ax
80105c03:	48                   	dec    %eax
80105c04:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105c07:	66 89 42 16          	mov    %ax,0x16(%edx)
  iupdate(ip);
80105c0b:	83 ec 0c             	sub    $0xc,%esp
80105c0e:	ff 75 f0             	pushl  -0x10(%ebp)
80105c11:	e8 ee ba ff ff       	call   80101704 <iupdate>
80105c16:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105c19:	83 ec 0c             	sub    $0xc,%esp
80105c1c:	ff 75 f0             	pushl  -0x10(%ebp)
80105c1f:	e8 71 bf ff ff       	call   80101b95 <iunlockput>
80105c24:	83 c4 10             	add    $0x10,%esp

  end_op();
80105c27:	e8 b6 d8 ff ff       	call   801034e2 <end_op>

  return 0;
80105c2c:	b8 00 00 00 00       	mov    $0x0,%eax
80105c31:	eb 18                	jmp    80105c4b <sys_unlink+0x1d7>

bad:
  iunlockput(dp);
80105c33:	83 ec 0c             	sub    $0xc,%esp
80105c36:	ff 75 f4             	pushl  -0xc(%ebp)
80105c39:	e8 57 bf ff ff       	call   80101b95 <iunlockput>
80105c3e:	83 c4 10             	add    $0x10,%esp
  end_op();
80105c41:	e8 9c d8 ff ff       	call   801034e2 <end_op>
  return -1;
80105c46:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c4b:	c9                   	leave  
80105c4c:	c3                   	ret    

80105c4d <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80105c4d:	55                   	push   %ebp
80105c4e:	89 e5                	mov    %esp,%ebp
80105c50:	83 ec 38             	sub    $0x38,%esp
80105c53:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105c56:	8b 55 10             	mov    0x10(%ebp),%edx
80105c59:	8b 45 14             	mov    0x14(%ebp),%eax
80105c5c:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80105c60:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105c64:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105c68:	83 ec 08             	sub    $0x8,%esp
80105c6b:	8d 45 de             	lea    -0x22(%ebp),%eax
80105c6e:	50                   	push   %eax
80105c6f:	ff 75 08             	pushl  0x8(%ebp)
80105c72:	e8 32 c8 ff ff       	call   801024a9 <nameiparent>
80105c77:	83 c4 10             	add    $0x10,%esp
80105c7a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105c7d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105c81:	75 0a                	jne    80105c8d <create+0x40>
    return 0;
80105c83:	b8 00 00 00 00       	mov    $0x0,%eax
80105c88:	e9 89 01 00 00       	jmp    80105e16 <create+0x1c9>
  ilock(dp);
80105c8d:	83 ec 0c             	sub    $0xc,%esp
80105c90:	ff 75 f4             	pushl  -0xc(%ebp)
80105c93:	e8 43 bc ff ff       	call   801018db <ilock>
80105c98:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, &off)) != 0){
80105c9b:	83 ec 04             	sub    $0x4,%esp
80105c9e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105ca1:	50                   	push   %eax
80105ca2:	8d 45 de             	lea    -0x22(%ebp),%eax
80105ca5:	50                   	push   %eax
80105ca6:	ff 75 f4             	pushl  -0xc(%ebp)
80105ca9:	e8 9b c4 ff ff       	call   80102149 <dirlookup>
80105cae:	83 c4 10             	add    $0x10,%esp
80105cb1:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105cb4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105cb8:	74 4f                	je     80105d09 <create+0xbc>
    iunlockput(dp);
80105cba:	83 ec 0c             	sub    $0xc,%esp
80105cbd:	ff 75 f4             	pushl  -0xc(%ebp)
80105cc0:	e8 d0 be ff ff       	call   80101b95 <iunlockput>
80105cc5:	83 c4 10             	add    $0x10,%esp
    ilock(ip);
80105cc8:	83 ec 0c             	sub    $0xc,%esp
80105ccb:	ff 75 f0             	pushl  -0x10(%ebp)
80105cce:	e8 08 bc ff ff       	call   801018db <ilock>
80105cd3:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
80105cd6:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105cdb:	75 14                	jne    80105cf1 <create+0xa4>
80105cdd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ce0:	8b 40 10             	mov    0x10(%eax),%eax
80105ce3:	66 83 f8 02          	cmp    $0x2,%ax
80105ce7:	75 08                	jne    80105cf1 <create+0xa4>
      return ip;
80105ce9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105cec:	e9 25 01 00 00       	jmp    80105e16 <create+0x1c9>
    iunlockput(ip);
80105cf1:	83 ec 0c             	sub    $0xc,%esp
80105cf4:	ff 75 f0             	pushl  -0x10(%ebp)
80105cf7:	e8 99 be ff ff       	call   80101b95 <iunlockput>
80105cfc:	83 c4 10             	add    $0x10,%esp
    return 0;
80105cff:	b8 00 00 00 00       	mov    $0x0,%eax
80105d04:	e9 0d 01 00 00       	jmp    80105e16 <create+0x1c9>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105d09:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80105d0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d10:	8b 00                	mov    (%eax),%eax
80105d12:	83 ec 08             	sub    $0x8,%esp
80105d15:	52                   	push   %edx
80105d16:	50                   	push   %eax
80105d17:	e8 15 b9 ff ff       	call   80101631 <ialloc>
80105d1c:	83 c4 10             	add    $0x10,%esp
80105d1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105d22:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105d26:	75 0d                	jne    80105d35 <create+0xe8>
    panic("create: ialloc");
80105d28:	83 ec 0c             	sub    $0xc,%esp
80105d2b:	68 5b 88 10 80       	push   $0x8010885b
80105d30:	e8 19 a8 ff ff       	call   8010054e <panic>

  ilock(ip);
80105d35:	83 ec 0c             	sub    $0xc,%esp
80105d38:	ff 75 f0             	pushl  -0x10(%ebp)
80105d3b:	e8 9b bb ff ff       	call   801018db <ilock>
80105d40:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
80105d43:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105d46:	8b 45 d0             	mov    -0x30(%ebp),%eax
80105d49:	66 89 42 12          	mov    %ax,0x12(%edx)
  ip->minor = minor;
80105d4d:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105d50:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105d53:	66 89 42 14          	mov    %ax,0x14(%edx)
  ip->nlink = 1;
80105d57:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d5a:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
80105d60:	83 ec 0c             	sub    $0xc,%esp
80105d63:	ff 75 f0             	pushl  -0x10(%ebp)
80105d66:	e8 99 b9 ff ff       	call   80101704 <iupdate>
80105d6b:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
80105d6e:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105d73:	75 66                	jne    80105ddb <create+0x18e>
    dp->nlink++;  // for ".."
80105d75:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d78:	66 8b 40 16          	mov    0x16(%eax),%ax
80105d7c:	40                   	inc    %eax
80105d7d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105d80:	66 89 42 16          	mov    %ax,0x16(%edx)
    iupdate(dp);
80105d84:	83 ec 0c             	sub    $0xc,%esp
80105d87:	ff 75 f4             	pushl  -0xc(%ebp)
80105d8a:	e8 75 b9 ff ff       	call   80101704 <iupdate>
80105d8f:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105d92:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d95:	8b 40 04             	mov    0x4(%eax),%eax
80105d98:	83 ec 04             	sub    $0x4,%esp
80105d9b:	50                   	push   %eax
80105d9c:	68 35 88 10 80       	push   $0x80108835
80105da1:	ff 75 f0             	pushl  -0x10(%ebp)
80105da4:	e8 58 c4 ff ff       	call   80102201 <dirlink>
80105da9:	83 c4 10             	add    $0x10,%esp
80105dac:	85 c0                	test   %eax,%eax
80105dae:	78 1e                	js     80105dce <create+0x181>
80105db0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105db3:	8b 40 04             	mov    0x4(%eax),%eax
80105db6:	83 ec 04             	sub    $0x4,%esp
80105db9:	50                   	push   %eax
80105dba:	68 37 88 10 80       	push   $0x80108837
80105dbf:	ff 75 f0             	pushl  -0x10(%ebp)
80105dc2:	e8 3a c4 ff ff       	call   80102201 <dirlink>
80105dc7:	83 c4 10             	add    $0x10,%esp
80105dca:	85 c0                	test   %eax,%eax
80105dcc:	79 0d                	jns    80105ddb <create+0x18e>
      panic("create dots");
80105dce:	83 ec 0c             	sub    $0xc,%esp
80105dd1:	68 6a 88 10 80       	push   $0x8010886a
80105dd6:	e8 73 a7 ff ff       	call   8010054e <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105ddb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105dde:	8b 40 04             	mov    0x4(%eax),%eax
80105de1:	83 ec 04             	sub    $0x4,%esp
80105de4:	50                   	push   %eax
80105de5:	8d 45 de             	lea    -0x22(%ebp),%eax
80105de8:	50                   	push   %eax
80105de9:	ff 75 f4             	pushl  -0xc(%ebp)
80105dec:	e8 10 c4 ff ff       	call   80102201 <dirlink>
80105df1:	83 c4 10             	add    $0x10,%esp
80105df4:	85 c0                	test   %eax,%eax
80105df6:	79 0d                	jns    80105e05 <create+0x1b8>
    panic("create: dirlink");
80105df8:	83 ec 0c             	sub    $0xc,%esp
80105dfb:	68 76 88 10 80       	push   $0x80108876
80105e00:	e8 49 a7 ff ff       	call   8010054e <panic>

  iunlockput(dp);
80105e05:	83 ec 0c             	sub    $0xc,%esp
80105e08:	ff 75 f4             	pushl  -0xc(%ebp)
80105e0b:	e8 85 bd ff ff       	call   80101b95 <iunlockput>
80105e10:	83 c4 10             	add    $0x10,%esp

  return ip;
80105e13:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80105e16:	c9                   	leave  
80105e17:	c3                   	ret    

80105e18 <sys_open>:

int
sys_open(void)
{
80105e18:	55                   	push   %ebp
80105e19:	89 e5                	mov    %esp,%ebp
80105e1b:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105e1e:	83 ec 08             	sub    $0x8,%esp
80105e21:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105e24:	50                   	push   %eax
80105e25:	6a 00                	push   $0x0
80105e27:	e8 07 f7 ff ff       	call   80105533 <argstr>
80105e2c:	83 c4 10             	add    $0x10,%esp
80105e2f:	85 c0                	test   %eax,%eax
80105e31:	78 15                	js     80105e48 <sys_open+0x30>
80105e33:	83 ec 08             	sub    $0x8,%esp
80105e36:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105e39:	50                   	push   %eax
80105e3a:	6a 01                	push   $0x1
80105e3c:	e8 6b f6 ff ff       	call   801054ac <argint>
80105e41:	83 c4 10             	add    $0x10,%esp
80105e44:	85 c0                	test   %eax,%eax
80105e46:	79 0a                	jns    80105e52 <sys_open+0x3a>
    return -1;
80105e48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e4d:	e9 60 01 00 00       	jmp    80105fb2 <sys_open+0x19a>

  begin_op();
80105e52:	e8 ff d5 ff ff       	call   80103456 <begin_op>

  if(omode & O_CREATE){
80105e57:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105e5a:	25 00 02 00 00       	and    $0x200,%eax
80105e5f:	85 c0                	test   %eax,%eax
80105e61:	74 2a                	je     80105e8d <sys_open+0x75>
    ip = create(path, T_FILE, 0, 0);
80105e63:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105e66:	6a 00                	push   $0x0
80105e68:	6a 00                	push   $0x0
80105e6a:	6a 02                	push   $0x2
80105e6c:	50                   	push   %eax
80105e6d:	e8 db fd ff ff       	call   80105c4d <create>
80105e72:	83 c4 10             	add    $0x10,%esp
80105e75:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ip == 0){
80105e78:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105e7c:	75 74                	jne    80105ef2 <sys_open+0xda>
      end_op();
80105e7e:	e8 5f d6 ff ff       	call   801034e2 <end_op>
      return -1;
80105e83:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e88:	e9 25 01 00 00       	jmp    80105fb2 <sys_open+0x19a>
    }
  } else {
    if((ip = namei(path)) == 0){
80105e8d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105e90:	83 ec 0c             	sub    $0xc,%esp
80105e93:	50                   	push   %eax
80105e94:	e8 f4 c5 ff ff       	call   8010248d <namei>
80105e99:	83 c4 10             	add    $0x10,%esp
80105e9c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105e9f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105ea3:	75 0f                	jne    80105eb4 <sys_open+0x9c>
      end_op();
80105ea5:	e8 38 d6 ff ff       	call   801034e2 <end_op>
      return -1;
80105eaa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105eaf:	e9 fe 00 00 00       	jmp    80105fb2 <sys_open+0x19a>
    }
    ilock(ip);
80105eb4:	83 ec 0c             	sub    $0xc,%esp
80105eb7:	ff 75 f4             	pushl  -0xc(%ebp)
80105eba:	e8 1c ba ff ff       	call   801018db <ilock>
80105ebf:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
80105ec2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ec5:	8b 40 10             	mov    0x10(%eax),%eax
80105ec8:	66 83 f8 01          	cmp    $0x1,%ax
80105ecc:	75 24                	jne    80105ef2 <sys_open+0xda>
80105ece:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105ed1:	85 c0                	test   %eax,%eax
80105ed3:	74 1d                	je     80105ef2 <sys_open+0xda>
      iunlockput(ip);
80105ed5:	83 ec 0c             	sub    $0xc,%esp
80105ed8:	ff 75 f4             	pushl  -0xc(%ebp)
80105edb:	e8 b5 bc ff ff       	call   80101b95 <iunlockput>
80105ee0:	83 c4 10             	add    $0x10,%esp
      end_op();
80105ee3:	e8 fa d5 ff ff       	call   801034e2 <end_op>
      return -1;
80105ee8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105eed:	e9 c0 00 00 00       	jmp    80105fb2 <sys_open+0x19a>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105ef2:	e8 34 b0 ff ff       	call   80100f2b <filealloc>
80105ef7:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105efa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105efe:	74 17                	je     80105f17 <sys_open+0xff>
80105f00:	83 ec 0c             	sub    $0xc,%esp
80105f03:	ff 75 f0             	pushl  -0x10(%ebp)
80105f06:	e8 53 f7 ff ff       	call   8010565e <fdalloc>
80105f0b:	83 c4 10             	add    $0x10,%esp
80105f0e:	89 45 ec             	mov    %eax,-0x14(%ebp)
80105f11:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80105f15:	79 2e                	jns    80105f45 <sys_open+0x12d>
    if(f)
80105f17:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105f1b:	74 0e                	je     80105f2b <sys_open+0x113>
      fileclose(f);
80105f1d:	83 ec 0c             	sub    $0xc,%esp
80105f20:	ff 75 f0             	pushl  -0x10(%ebp)
80105f23:	e8 c0 b0 ff ff       	call   80100fe8 <fileclose>
80105f28:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105f2b:	83 ec 0c             	sub    $0xc,%esp
80105f2e:	ff 75 f4             	pushl  -0xc(%ebp)
80105f31:	e8 5f bc ff ff       	call   80101b95 <iunlockput>
80105f36:	83 c4 10             	add    $0x10,%esp
    end_op();
80105f39:	e8 a4 d5 ff ff       	call   801034e2 <end_op>
    return -1;
80105f3e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f43:	eb 6d                	jmp    80105fb2 <sys_open+0x19a>
  }
  iunlock(ip);
80105f45:	83 ec 0c             	sub    $0xc,%esp
80105f48:	ff 75 f4             	pushl  -0xc(%ebp)
80105f4b:	e8 e5 ba ff ff       	call   80101a35 <iunlock>
80105f50:	83 c4 10             	add    $0x10,%esp
  end_op();
80105f53:	e8 8a d5 ff ff       	call   801034e2 <end_op>

  f->type = FD_INODE;
80105f58:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f5b:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
80105f61:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f64:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105f67:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
80105f6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f6d:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
80105f74:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105f77:	83 e0 01             	and    $0x1,%eax
80105f7a:	85 c0                	test   %eax,%eax
80105f7c:	0f 94 c0             	sete   %al
80105f7f:	88 c2                	mov    %al,%dl
80105f81:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f84:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105f87:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105f8a:	83 e0 01             	and    $0x1,%eax
80105f8d:	85 c0                	test   %eax,%eax
80105f8f:	75 0a                	jne    80105f9b <sys_open+0x183>
80105f91:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105f94:	83 e0 02             	and    $0x2,%eax
80105f97:	85 c0                	test   %eax,%eax
80105f99:	74 07                	je     80105fa2 <sys_open+0x18a>
80105f9b:	b8 01 00 00 00       	mov    $0x1,%eax
80105fa0:	eb 05                	jmp    80105fa7 <sys_open+0x18f>
80105fa2:	b8 00 00 00 00       	mov    $0x0,%eax
80105fa7:	88 c2                	mov    %al,%dl
80105fa9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fac:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
80105faf:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
80105fb2:	c9                   	leave  
80105fb3:	c3                   	ret    

80105fb4 <sys_mkdir>:

int
sys_mkdir(void)
{
80105fb4:	55                   	push   %ebp
80105fb5:	89 e5                	mov    %esp,%ebp
80105fb7:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105fba:	e8 97 d4 ff ff       	call   80103456 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105fbf:	83 ec 08             	sub    $0x8,%esp
80105fc2:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105fc5:	50                   	push   %eax
80105fc6:	6a 00                	push   $0x0
80105fc8:	e8 66 f5 ff ff       	call   80105533 <argstr>
80105fcd:	83 c4 10             	add    $0x10,%esp
80105fd0:	85 c0                	test   %eax,%eax
80105fd2:	78 1b                	js     80105fef <sys_mkdir+0x3b>
80105fd4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fd7:	6a 00                	push   $0x0
80105fd9:	6a 00                	push   $0x0
80105fdb:	6a 01                	push   $0x1
80105fdd:	50                   	push   %eax
80105fde:	e8 6a fc ff ff       	call   80105c4d <create>
80105fe3:	83 c4 10             	add    $0x10,%esp
80105fe6:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105fe9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105fed:	75 0c                	jne    80105ffb <sys_mkdir+0x47>
    end_op();
80105fef:	e8 ee d4 ff ff       	call   801034e2 <end_op>
    return -1;
80105ff4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ff9:	eb 18                	jmp    80106013 <sys_mkdir+0x5f>
  }
  iunlockput(ip);
80105ffb:	83 ec 0c             	sub    $0xc,%esp
80105ffe:	ff 75 f4             	pushl  -0xc(%ebp)
80106001:	e8 8f bb ff ff       	call   80101b95 <iunlockput>
80106006:	83 c4 10             	add    $0x10,%esp
  end_op();
80106009:	e8 d4 d4 ff ff       	call   801034e2 <end_op>
  return 0;
8010600e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106013:	c9                   	leave  
80106014:	c3                   	ret    

80106015 <sys_mknod>:

int
sys_mknod(void)
{
80106015:	55                   	push   %ebp
80106016:	89 e5                	mov    %esp,%ebp
80106018:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_op();
8010601b:	e8 36 d4 ff ff       	call   80103456 <begin_op>
  if((len=argstr(0, &path)) < 0 ||
80106020:	83 ec 08             	sub    $0x8,%esp
80106023:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106026:	50                   	push   %eax
80106027:	6a 00                	push   $0x0
80106029:	e8 05 f5 ff ff       	call   80105533 <argstr>
8010602e:	83 c4 10             	add    $0x10,%esp
80106031:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106034:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106038:	78 4f                	js     80106089 <sys_mknod+0x74>
     argint(1, &major) < 0 ||
8010603a:	83 ec 08             	sub    $0x8,%esp
8010603d:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106040:	50                   	push   %eax
80106041:	6a 01                	push   $0x1
80106043:	e8 64 f4 ff ff       	call   801054ac <argint>
80106048:	83 c4 10             	add    $0x10,%esp
  char *path;
  int len;
  int major, minor;
  
  begin_op();
  if((len=argstr(0, &path)) < 0 ||
8010604b:	85 c0                	test   %eax,%eax
8010604d:	78 3a                	js     80106089 <sys_mknod+0x74>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
8010604f:	83 ec 08             	sub    $0x8,%esp
80106052:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106055:	50                   	push   %eax
80106056:	6a 02                	push   $0x2
80106058:	e8 4f f4 ff ff       	call   801054ac <argint>
8010605d:	83 c4 10             	add    $0x10,%esp
  int len;
  int major, minor;
  
  begin_op();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80106060:	85 c0                	test   %eax,%eax
80106062:	78 25                	js     80106089 <sys_mknod+0x74>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
80106064:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106067:	0f bf c8             	movswl %ax,%ecx
8010606a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010606d:	0f bf d0             	movswl %ax,%edx
80106070:	8b 45 ec             	mov    -0x14(%ebp),%eax
  int major, minor;
  
  begin_op();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80106073:	51                   	push   %ecx
80106074:	52                   	push   %edx
80106075:	6a 03                	push   $0x3
80106077:	50                   	push   %eax
80106078:	e8 d0 fb ff ff       	call   80105c4d <create>
8010607d:	83 c4 10             	add    $0x10,%esp
80106080:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106083:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106087:	75 0c                	jne    80106095 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80106089:	e8 54 d4 ff ff       	call   801034e2 <end_op>
    return -1;
8010608e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106093:	eb 18                	jmp    801060ad <sys_mknod+0x98>
  }
  iunlockput(ip);
80106095:	83 ec 0c             	sub    $0xc,%esp
80106098:	ff 75 f0             	pushl  -0x10(%ebp)
8010609b:	e8 f5 ba ff ff       	call   80101b95 <iunlockput>
801060a0:	83 c4 10             	add    $0x10,%esp
  end_op();
801060a3:	e8 3a d4 ff ff       	call   801034e2 <end_op>
  return 0;
801060a8:	b8 00 00 00 00       	mov    $0x0,%eax
}
801060ad:	c9                   	leave  
801060ae:	c3                   	ret    

801060af <sys_chdir>:

int
sys_chdir(void)
{
801060af:	55                   	push   %ebp
801060b0:	89 e5                	mov    %esp,%ebp
801060b2:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801060b5:	e8 9c d3 ff ff       	call   80103456 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801060ba:	83 ec 08             	sub    $0x8,%esp
801060bd:	8d 45 f0             	lea    -0x10(%ebp),%eax
801060c0:	50                   	push   %eax
801060c1:	6a 00                	push   $0x0
801060c3:	e8 6b f4 ff ff       	call   80105533 <argstr>
801060c8:	83 c4 10             	add    $0x10,%esp
801060cb:	85 c0                	test   %eax,%eax
801060cd:	78 18                	js     801060e7 <sys_chdir+0x38>
801060cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
801060d2:	83 ec 0c             	sub    $0xc,%esp
801060d5:	50                   	push   %eax
801060d6:	e8 b2 c3 ff ff       	call   8010248d <namei>
801060db:	83 c4 10             	add    $0x10,%esp
801060de:	89 45 f4             	mov    %eax,-0xc(%ebp)
801060e1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801060e5:	75 0c                	jne    801060f3 <sys_chdir+0x44>
    end_op();
801060e7:	e8 f6 d3 ff ff       	call   801034e2 <end_op>
    return -1;
801060ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060f1:	eb 6d                	jmp    80106160 <sys_chdir+0xb1>
  }
  ilock(ip);
801060f3:	83 ec 0c             	sub    $0xc,%esp
801060f6:	ff 75 f4             	pushl  -0xc(%ebp)
801060f9:	e8 dd b7 ff ff       	call   801018db <ilock>
801060fe:	83 c4 10             	add    $0x10,%esp
  if(ip->type != T_DIR){
80106101:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106104:	8b 40 10             	mov    0x10(%eax),%eax
80106107:	66 83 f8 01          	cmp    $0x1,%ax
8010610b:	74 1a                	je     80106127 <sys_chdir+0x78>
    iunlockput(ip);
8010610d:	83 ec 0c             	sub    $0xc,%esp
80106110:	ff 75 f4             	pushl  -0xc(%ebp)
80106113:	e8 7d ba ff ff       	call   80101b95 <iunlockput>
80106118:	83 c4 10             	add    $0x10,%esp
    end_op();
8010611b:	e8 c2 d3 ff ff       	call   801034e2 <end_op>
    return -1;
80106120:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106125:	eb 39                	jmp    80106160 <sys_chdir+0xb1>
  }
  iunlock(ip);
80106127:	83 ec 0c             	sub    $0xc,%esp
8010612a:	ff 75 f4             	pushl  -0xc(%ebp)
8010612d:	e8 03 b9 ff ff       	call   80101a35 <iunlock>
80106132:	83 c4 10             	add    $0x10,%esp
  iput(proc->cwd);
80106135:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010613b:	8b 40 68             	mov    0x68(%eax),%eax
8010613e:	83 ec 0c             	sub    $0xc,%esp
80106141:	50                   	push   %eax
80106142:	e8 5f b9 ff ff       	call   80101aa6 <iput>
80106147:	83 c4 10             	add    $0x10,%esp
  end_op();
8010614a:	e8 93 d3 ff ff       	call   801034e2 <end_op>
  proc->cwd = ip;
8010614f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106155:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106158:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
8010615b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106160:	c9                   	leave  
80106161:	c3                   	ret    

80106162 <sys_exec>:

int
sys_exec(void)
{
80106162:	55                   	push   %ebp
80106163:	89 e5                	mov    %esp,%ebp
80106165:	81 ec 98 00 00 00    	sub    $0x98,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
8010616b:	83 ec 08             	sub    $0x8,%esp
8010616e:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106171:	50                   	push   %eax
80106172:	6a 00                	push   $0x0
80106174:	e8 ba f3 ff ff       	call   80105533 <argstr>
80106179:	83 c4 10             	add    $0x10,%esp
8010617c:	85 c0                	test   %eax,%eax
8010617e:	78 18                	js     80106198 <sys_exec+0x36>
80106180:	83 ec 08             	sub    $0x8,%esp
80106183:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
80106189:	50                   	push   %eax
8010618a:	6a 01                	push   $0x1
8010618c:	e8 1b f3 ff ff       	call   801054ac <argint>
80106191:	83 c4 10             	add    $0x10,%esp
80106194:	85 c0                	test   %eax,%eax
80106196:	79 0a                	jns    801061a2 <sys_exec+0x40>
    return -1;
80106198:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010619d:	e9 c5 00 00 00       	jmp    80106267 <sys_exec+0x105>
  }
  memset(argv, 0, sizeof(argv));
801061a2:	83 ec 04             	sub    $0x4,%esp
801061a5:	68 80 00 00 00       	push   $0x80
801061aa:	6a 00                	push   $0x0
801061ac:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
801061b2:	50                   	push   %eax
801061b3:	e8 e8 ef ff ff       	call   801051a0 <memset>
801061b8:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
801061bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
801061c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061c5:	83 f8 1f             	cmp    $0x1f,%eax
801061c8:	76 0a                	jbe    801061d4 <sys_exec+0x72>
      return -1;
801061ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061cf:	e9 93 00 00 00       	jmp    80106267 <sys_exec+0x105>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801061d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061d7:	c1 e0 02             	shl    $0x2,%eax
801061da:	89 c2                	mov    %eax,%edx
801061dc:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
801061e2:	01 c2                	add    %eax,%edx
801061e4:	83 ec 08             	sub    $0x8,%esp
801061e7:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801061ed:	50                   	push   %eax
801061ee:	52                   	push   %edx
801061ef:	e8 1e f2 ff ff       	call   80105412 <fetchint>
801061f4:	83 c4 10             	add    $0x10,%esp
801061f7:	85 c0                	test   %eax,%eax
801061f9:	79 07                	jns    80106202 <sys_exec+0xa0>
      return -1;
801061fb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106200:	eb 65                	jmp    80106267 <sys_exec+0x105>
    if(uarg == 0){
80106202:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80106208:	85 c0                	test   %eax,%eax
8010620a:	75 27                	jne    80106233 <sys_exec+0xd1>
      argv[i] = 0;
8010620c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010620f:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
80106216:	00 00 00 00 
      break;
8010621a:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
8010621b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010621e:	83 ec 08             	sub    $0x8,%esp
80106221:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
80106227:	52                   	push   %edx
80106228:	50                   	push   %eax
80106229:	e8 ff a8 ff ff       	call   80100b2d <exec>
8010622e:	83 c4 10             	add    $0x10,%esp
80106231:	eb 34                	jmp    80106267 <sys_exec+0x105>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106233:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80106239:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010623c:	c1 e2 02             	shl    $0x2,%edx
8010623f:	01 c2                	add    %eax,%edx
80106241:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80106247:	83 ec 08             	sub    $0x8,%esp
8010624a:	52                   	push   %edx
8010624b:	50                   	push   %eax
8010624c:	e8 fb f1 ff ff       	call   8010544c <fetchstr>
80106251:	83 c4 10             	add    $0x10,%esp
80106254:	85 c0                	test   %eax,%eax
80106256:	79 07                	jns    8010625f <sys_exec+0xfd>
      return -1;
80106258:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010625d:	eb 08                	jmp    80106267 <sys_exec+0x105>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
8010625f:	ff 45 f4             	incl   -0xc(%ebp)
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
80106262:	e9 5b ff ff ff       	jmp    801061c2 <sys_exec+0x60>
  return exec(path, argv);
}
80106267:	c9                   	leave  
80106268:	c3                   	ret    

80106269 <sys_pipe>:

int
sys_pipe(void)
{
80106269:	55                   	push   %ebp
8010626a:	89 e5                	mov    %esp,%ebp
8010626c:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010626f:	83 ec 04             	sub    $0x4,%esp
80106272:	6a 08                	push   $0x8
80106274:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106277:	50                   	push   %eax
80106278:	6a 00                	push   $0x0
8010627a:	e8 55 f2 ff ff       	call   801054d4 <argptr>
8010627f:	83 c4 10             	add    $0x10,%esp
80106282:	85 c0                	test   %eax,%eax
80106284:	79 0a                	jns    80106290 <sys_pipe+0x27>
    return -1;
80106286:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010628b:	e9 af 00 00 00       	jmp    8010633f <sys_pipe+0xd6>
  if(pipealloc(&rf, &wf) < 0)
80106290:	83 ec 08             	sub    $0x8,%esp
80106293:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106296:	50                   	push   %eax
80106297:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010629a:	50                   	push   %eax
8010629b:	e8 ec dc ff ff       	call   80103f8c <pipealloc>
801062a0:	83 c4 10             	add    $0x10,%esp
801062a3:	85 c0                	test   %eax,%eax
801062a5:	79 0a                	jns    801062b1 <sys_pipe+0x48>
    return -1;
801062a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062ac:	e9 8e 00 00 00       	jmp    8010633f <sys_pipe+0xd6>
  fd0 = -1;
801062b1:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801062b8:	8b 45 e8             	mov    -0x18(%ebp),%eax
801062bb:	83 ec 0c             	sub    $0xc,%esp
801062be:	50                   	push   %eax
801062bf:	e8 9a f3 ff ff       	call   8010565e <fdalloc>
801062c4:	83 c4 10             	add    $0x10,%esp
801062c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
801062ca:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801062ce:	78 18                	js     801062e8 <sys_pipe+0x7f>
801062d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801062d3:	83 ec 0c             	sub    $0xc,%esp
801062d6:	50                   	push   %eax
801062d7:	e8 82 f3 ff ff       	call   8010565e <fdalloc>
801062dc:	83 c4 10             	add    $0x10,%esp
801062df:	89 45 f0             	mov    %eax,-0x10(%ebp)
801062e2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801062e6:	79 3f                	jns    80106327 <sys_pipe+0xbe>
    if(fd0 >= 0)
801062e8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801062ec:	78 14                	js     80106302 <sys_pipe+0x99>
      proc->ofile[fd0] = 0;
801062ee:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801062f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
801062f7:	83 c2 08             	add    $0x8,%edx
801062fa:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80106301:	00 
    fileclose(rf);
80106302:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106305:	83 ec 0c             	sub    $0xc,%esp
80106308:	50                   	push   %eax
80106309:	e8 da ac ff ff       	call   80100fe8 <fileclose>
8010630e:	83 c4 10             	add    $0x10,%esp
    fileclose(wf);
80106311:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106314:	83 ec 0c             	sub    $0xc,%esp
80106317:	50                   	push   %eax
80106318:	e8 cb ac ff ff       	call   80100fe8 <fileclose>
8010631d:	83 c4 10             	add    $0x10,%esp
    return -1;
80106320:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106325:	eb 18                	jmp    8010633f <sys_pipe+0xd6>
  }
  fd[0] = fd0;
80106327:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010632a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010632d:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
8010632f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106332:	8d 50 04             	lea    0x4(%eax),%edx
80106335:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106338:	89 02                	mov    %eax,(%edx)
  return 0;
8010633a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010633f:	c9                   	leave  
80106340:	c3                   	ret    

80106341 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106341:	55                   	push   %ebp
80106342:	89 e5                	mov    %esp,%ebp
80106344:	83 ec 08             	sub    $0x8,%esp
  return fork();
80106347:	e8 2c e3 ff ff       	call   80104678 <fork>
}
8010634c:	c9                   	leave  
8010634d:	c3                   	ret    

8010634e <sys_exit>:

int
sys_exit(void)
{
8010634e:	55                   	push   %ebp
8010634f:	89 e5                	mov    %esp,%ebp
80106351:	83 ec 08             	sub    $0x8,%esp
  exit();
80106354:	e8 a9 e4 ff ff       	call   80104802 <exit>
  return 0;  // not reached
80106359:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010635e:	c9                   	leave  
8010635f:	c3                   	ret    

80106360 <sys_wait>:

int
sys_wait(void)
{
80106360:	55                   	push   %ebp
80106361:	89 e5                	mov    %esp,%ebp
80106363:	83 ec 08             	sub    $0x8,%esp
  return wait();
80106366:	e8 ce e5 ff ff       	call   80104939 <wait>
}
8010636b:	c9                   	leave  
8010636c:	c3                   	ret    

8010636d <sys_kill>:

int
sys_kill(void)
{
8010636d:	55                   	push   %ebp
8010636e:	89 e5                	mov    %esp,%ebp
80106370:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106373:	83 ec 08             	sub    $0x8,%esp
80106376:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106379:	50                   	push   %eax
8010637a:	6a 00                	push   $0x0
8010637c:	e8 2b f1 ff ff       	call   801054ac <argint>
80106381:	83 c4 10             	add    $0x10,%esp
80106384:	85 c0                	test   %eax,%eax
80106386:	79 07                	jns    8010638f <sys_kill+0x22>
    return -1;
80106388:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010638d:	eb 0f                	jmp    8010639e <sys_kill+0x31>
  return kill(pid);
8010638f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106392:	83 ec 0c             	sub    $0xc,%esp
80106395:	50                   	push   %eax
80106396:	e8 df e9 ff ff       	call   80104d7a <kill>
8010639b:	83 c4 10             	add    $0x10,%esp
}
8010639e:	c9                   	leave  
8010639f:	c3                   	ret    

801063a0 <sys_getpid>:

int
sys_getpid(void)
{
801063a0:	55                   	push   %ebp
801063a1:	89 e5                	mov    %esp,%ebp
  return proc->pid;
801063a3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801063a9:	8b 40 10             	mov    0x10(%eax),%eax
}
801063ac:	5d                   	pop    %ebp
801063ad:	c3                   	ret    

801063ae <sys_sbrk>:

int
sys_sbrk(void)
{
801063ae:	55                   	push   %ebp
801063af:	89 e5                	mov    %esp,%ebp
801063b1:	83 ec 18             	sub    $0x18,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801063b4:	83 ec 08             	sub    $0x8,%esp
801063b7:	8d 45 f0             	lea    -0x10(%ebp),%eax
801063ba:	50                   	push   %eax
801063bb:	6a 00                	push   $0x0
801063bd:	e8 ea f0 ff ff       	call   801054ac <argint>
801063c2:	83 c4 10             	add    $0x10,%esp
801063c5:	85 c0                	test   %eax,%eax
801063c7:	79 07                	jns    801063d0 <sys_sbrk+0x22>
    return -1;
801063c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063ce:	eb 28                	jmp    801063f8 <sys_sbrk+0x4a>
  addr = proc->sz;
801063d0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801063d6:	8b 00                	mov    (%eax),%eax
801063d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
801063db:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063de:	83 ec 0c             	sub    $0xc,%esp
801063e1:	50                   	push   %eax
801063e2:	e8 ee e1 ff ff       	call   801045d5 <growproc>
801063e7:	83 c4 10             	add    $0x10,%esp
801063ea:	85 c0                	test   %eax,%eax
801063ec:	79 07                	jns    801063f5 <sys_sbrk+0x47>
    return -1;
801063ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063f3:	eb 03                	jmp    801063f8 <sys_sbrk+0x4a>
  return addr;
801063f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801063f8:	c9                   	leave  
801063f9:	c3                   	ret    

801063fa <sys_sleep>:

int
sys_sleep(void)
{
801063fa:	55                   	push   %ebp
801063fb:	89 e5                	mov    %esp,%ebp
801063fd:	83 ec 18             	sub    $0x18,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
80106400:	83 ec 08             	sub    $0x8,%esp
80106403:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106406:	50                   	push   %eax
80106407:	6a 00                	push   $0x0
80106409:	e8 9e f0 ff ff       	call   801054ac <argint>
8010640e:	83 c4 10             	add    $0x10,%esp
80106411:	85 c0                	test   %eax,%eax
80106413:	79 07                	jns    8010641c <sys_sleep+0x22>
    return -1;
80106415:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010641a:	eb 79                	jmp    80106495 <sys_sleep+0x9b>
  acquire(&tickslock);
8010641c:	83 ec 0c             	sub    $0xc,%esp
8010641f:	68 a0 48 11 80       	push   $0x801148a0
80106424:	e8 1f eb ff ff       	call   80104f48 <acquire>
80106429:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
8010642c:	a1 e0 50 11 80       	mov    0x801150e0,%eax
80106431:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
80106434:	eb 39                	jmp    8010646f <sys_sleep+0x75>
    if(proc->killed){
80106436:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010643c:	8b 40 24             	mov    0x24(%eax),%eax
8010643f:	85 c0                	test   %eax,%eax
80106441:	74 17                	je     8010645a <sys_sleep+0x60>
      release(&tickslock);
80106443:	83 ec 0c             	sub    $0xc,%esp
80106446:	68 a0 48 11 80       	push   $0x801148a0
8010644b:	e8 5e eb ff ff       	call   80104fae <release>
80106450:	83 c4 10             	add    $0x10,%esp
      return -1;
80106453:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106458:	eb 3b                	jmp    80106495 <sys_sleep+0x9b>
    }
    sleep(&ticks, &tickslock);
8010645a:	83 ec 08             	sub    $0x8,%esp
8010645d:	68 a0 48 11 80       	push   $0x801148a0
80106462:	68 e0 50 11 80       	push   $0x801150e0
80106467:	e8 ef e7 ff ff       	call   80104c5b <sleep>
8010646c:	83 c4 10             	add    $0x10,%esp
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010646f:	a1 e0 50 11 80       	mov    0x801150e0,%eax
80106474:	2b 45 f4             	sub    -0xc(%ebp),%eax
80106477:	89 c2                	mov    %eax,%edx
80106479:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010647c:	39 c2                	cmp    %eax,%edx
8010647e:	72 b6                	jb     80106436 <sys_sleep+0x3c>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80106480:	83 ec 0c             	sub    $0xc,%esp
80106483:	68 a0 48 11 80       	push   $0x801148a0
80106488:	e8 21 eb ff ff       	call   80104fae <release>
8010648d:	83 c4 10             	add    $0x10,%esp
  return 0;
80106490:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106495:	c9                   	leave  
80106496:	c3                   	ret    

80106497 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106497:	55                   	push   %ebp
80106498:	89 e5                	mov    %esp,%ebp
8010649a:	83 ec 18             	sub    $0x18,%esp
  uint xticks;
  
  acquire(&tickslock);
8010649d:	83 ec 0c             	sub    $0xc,%esp
801064a0:	68 a0 48 11 80       	push   $0x801148a0
801064a5:	e8 9e ea ff ff       	call   80104f48 <acquire>
801064aa:	83 c4 10             	add    $0x10,%esp
  xticks = ticks;
801064ad:	a1 e0 50 11 80       	mov    0x801150e0,%eax
801064b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
801064b5:	83 ec 0c             	sub    $0xc,%esp
801064b8:	68 a0 48 11 80       	push   $0x801148a0
801064bd:	e8 ec ea ff ff       	call   80104fae <release>
801064c2:	83 c4 10             	add    $0x10,%esp
  return xticks;
801064c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801064c8:	c9                   	leave  
801064c9:	c3                   	ret    

801064ca <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801064ca:	55                   	push   %ebp
801064cb:	89 e5                	mov    %esp,%ebp
801064cd:	83 ec 08             	sub    $0x8,%esp
801064d0:	8b 45 08             	mov    0x8(%ebp),%eax
801064d3:	8b 55 0c             	mov    0xc(%ebp),%edx
801064d6:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801064da:	88 55 f8             	mov    %dl,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801064dd:	8a 45 f8             	mov    -0x8(%ebp),%al
801064e0:	8b 55 fc             	mov    -0x4(%ebp),%edx
801064e3:	ee                   	out    %al,(%dx)
}
801064e4:	c9                   	leave  
801064e5:	c3                   	ret    

801064e6 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
801064e6:	55                   	push   %ebp
801064e7:	89 e5                	mov    %esp,%ebp
801064e9:	83 ec 08             	sub    $0x8,%esp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
801064ec:	6a 34                	push   $0x34
801064ee:	6a 43                	push   $0x43
801064f0:	e8 d5 ff ff ff       	call   801064ca <outb>
801064f5:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
801064f8:	68 9c 00 00 00       	push   $0x9c
801064fd:	6a 40                	push   $0x40
801064ff:	e8 c6 ff ff ff       	call   801064ca <outb>
80106504:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
80106507:	6a 2e                	push   $0x2e
80106509:	6a 40                	push   $0x40
8010650b:	e8 ba ff ff ff       	call   801064ca <outb>
80106510:	83 c4 08             	add    $0x8,%esp
  picenable(IRQ_TIMER);
80106513:	83 ec 0c             	sub    $0xc,%esp
80106516:	6a 00                	push   $0x0
80106518:	e8 5e d9 ff ff       	call   80103e7b <picenable>
8010651d:	83 c4 10             	add    $0x10,%esp
}
80106520:	c9                   	leave  
80106521:	c3                   	ret    

80106522 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106522:	1e                   	push   %ds
  pushl %es
80106523:	06                   	push   %es
  pushl %fs
80106524:	0f a0                	push   %fs
  pushl %gs
80106526:	0f a8                	push   %gs
  pushal
80106528:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80106529:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
8010652d:	8e d8                	mov    %eax,%ds
  movw %ax, %es
8010652f:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
80106531:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
80106535:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80106537:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
80106539:	54                   	push   %esp
  call trap
8010653a:	e8 bb 01 00 00       	call   801066fa <trap>
  addl $4, %esp
8010653f:	83 c4 04             	add    $0x4,%esp

80106542 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106542:	61                   	popa   
  popl %gs
80106543:	0f a9                	pop    %gs
  popl %fs
80106545:	0f a1                	pop    %fs
  popl %es
80106547:	07                   	pop    %es
  popl %ds
80106548:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106549:	83 c4 08             	add    $0x8,%esp
  iret
8010654c:	cf                   	iret   

8010654d <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
8010654d:	55                   	push   %ebp
8010654e:	89 e5                	mov    %esp,%ebp
80106550:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
80106553:	8b 45 0c             	mov    0xc(%ebp),%eax
80106556:	48                   	dec    %eax
80106557:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010655b:	8b 45 08             	mov    0x8(%ebp),%eax
8010655e:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106562:	8b 45 08             	mov    0x8(%ebp),%eax
80106565:	c1 e8 10             	shr    $0x10,%eax
80106568:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
8010656c:	8d 45 fa             	lea    -0x6(%ebp),%eax
8010656f:	0f 01 18             	lidtl  (%eax)
}
80106572:	c9                   	leave  
80106573:	c3                   	ret    

80106574 <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
80106574:	55                   	push   %ebp
80106575:	89 e5                	mov    %esp,%ebp
80106577:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010657a:	0f 20 d0             	mov    %cr2,%eax
8010657d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
80106580:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80106583:	c9                   	leave  
80106584:	c3                   	ret    

80106585 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106585:	55                   	push   %ebp
80106586:	89 e5                	mov    %esp,%ebp
80106588:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
8010658b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106592:	e9 b8 00 00 00       	jmp    8010664f <tvinit+0xca>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106597:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010659a:	8b 04 85 98 b0 10 80 	mov    -0x7fef4f68(,%eax,4),%eax
801065a1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801065a4:	66 89 04 d5 e0 48 11 	mov    %ax,-0x7feeb720(,%edx,8)
801065ab:	80 
801065ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065af:	66 c7 04 c5 e2 48 11 	movw   $0x8,-0x7feeb71e(,%eax,8)
801065b6:	80 08 00 
801065b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065bc:	8a 14 c5 e4 48 11 80 	mov    -0x7feeb71c(,%eax,8),%dl
801065c3:	83 e2 e0             	and    $0xffffffe0,%edx
801065c6:	88 14 c5 e4 48 11 80 	mov    %dl,-0x7feeb71c(,%eax,8)
801065cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065d0:	8a 14 c5 e4 48 11 80 	mov    -0x7feeb71c(,%eax,8),%dl
801065d7:	83 e2 1f             	and    $0x1f,%edx
801065da:	88 14 c5 e4 48 11 80 	mov    %dl,-0x7feeb71c(,%eax,8)
801065e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065e4:	8a 14 c5 e5 48 11 80 	mov    -0x7feeb71b(,%eax,8),%dl
801065eb:	83 e2 f0             	and    $0xfffffff0,%edx
801065ee:	83 ca 0e             	or     $0xe,%edx
801065f1:	88 14 c5 e5 48 11 80 	mov    %dl,-0x7feeb71b(,%eax,8)
801065f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065fb:	8a 14 c5 e5 48 11 80 	mov    -0x7feeb71b(,%eax,8),%dl
80106602:	83 e2 ef             	and    $0xffffffef,%edx
80106605:	88 14 c5 e5 48 11 80 	mov    %dl,-0x7feeb71b(,%eax,8)
8010660c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010660f:	8a 14 c5 e5 48 11 80 	mov    -0x7feeb71b(,%eax,8),%dl
80106616:	83 e2 9f             	and    $0xffffff9f,%edx
80106619:	88 14 c5 e5 48 11 80 	mov    %dl,-0x7feeb71b(,%eax,8)
80106620:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106623:	8a 14 c5 e5 48 11 80 	mov    -0x7feeb71b(,%eax,8),%dl
8010662a:	83 ca 80             	or     $0xffffff80,%edx
8010662d:	88 14 c5 e5 48 11 80 	mov    %dl,-0x7feeb71b(,%eax,8)
80106634:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106637:	8b 04 85 98 b0 10 80 	mov    -0x7fef4f68(,%eax,4),%eax
8010663e:	c1 e8 10             	shr    $0x10,%eax
80106641:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106644:	66 89 04 d5 e6 48 11 	mov    %ax,-0x7feeb71a(,%edx,8)
8010664b:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
8010664c:	ff 45 f4             	incl   -0xc(%ebp)
8010664f:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
80106656:	0f 8e 3b ff ff ff    	jle    80106597 <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010665c:	a1 98 b1 10 80       	mov    0x8010b198,%eax
80106661:	66 a3 e0 4a 11 80    	mov    %ax,0x80114ae0
80106667:	66 c7 05 e2 4a 11 80 	movw   $0x8,0x80114ae2
8010666e:	08 00 
80106670:	a0 e4 4a 11 80       	mov    0x80114ae4,%al
80106675:	83 e0 e0             	and    $0xffffffe0,%eax
80106678:	a2 e4 4a 11 80       	mov    %al,0x80114ae4
8010667d:	a0 e4 4a 11 80       	mov    0x80114ae4,%al
80106682:	83 e0 1f             	and    $0x1f,%eax
80106685:	a2 e4 4a 11 80       	mov    %al,0x80114ae4
8010668a:	a0 e5 4a 11 80       	mov    0x80114ae5,%al
8010668f:	83 c8 0f             	or     $0xf,%eax
80106692:	a2 e5 4a 11 80       	mov    %al,0x80114ae5
80106697:	a0 e5 4a 11 80       	mov    0x80114ae5,%al
8010669c:	83 e0 ef             	and    $0xffffffef,%eax
8010669f:	a2 e5 4a 11 80       	mov    %al,0x80114ae5
801066a4:	a0 e5 4a 11 80       	mov    0x80114ae5,%al
801066a9:	83 c8 60             	or     $0x60,%eax
801066ac:	a2 e5 4a 11 80       	mov    %al,0x80114ae5
801066b1:	a0 e5 4a 11 80       	mov    0x80114ae5,%al
801066b6:	83 c8 80             	or     $0xffffff80,%eax
801066b9:	a2 e5 4a 11 80       	mov    %al,0x80114ae5
801066be:	a1 98 b1 10 80       	mov    0x8010b198,%eax
801066c3:	c1 e8 10             	shr    $0x10,%eax
801066c6:	66 a3 e6 4a 11 80    	mov    %ax,0x80114ae6
  
  initlock(&tickslock, "time");
801066cc:	83 ec 08             	sub    $0x8,%esp
801066cf:	68 88 88 10 80       	push   $0x80108888
801066d4:	68 a0 48 11 80       	push   $0x801148a0
801066d9:	e8 49 e8 ff ff       	call   80104f27 <initlock>
801066de:	83 c4 10             	add    $0x10,%esp
}
801066e1:	c9                   	leave  
801066e2:	c3                   	ret    

801066e3 <idtinit>:

void
idtinit(void)
{
801066e3:	55                   	push   %ebp
801066e4:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
801066e6:	68 00 08 00 00       	push   $0x800
801066eb:	68 e0 48 11 80       	push   $0x801148e0
801066f0:	e8 58 fe ff ff       	call   8010654d <lidt>
801066f5:	83 c4 08             	add    $0x8,%esp
}
801066f8:	c9                   	leave  
801066f9:	c3                   	ret    

801066fa <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801066fa:	55                   	push   %ebp
801066fb:	89 e5                	mov    %esp,%ebp
801066fd:	57                   	push   %edi
801066fe:	56                   	push   %esi
801066ff:	53                   	push   %ebx
80106700:	83 ec 1c             	sub    $0x1c,%esp
  if(tf->trapno == T_SYSCALL){
80106703:	8b 45 08             	mov    0x8(%ebp),%eax
80106706:	8b 40 30             	mov    0x30(%eax),%eax
80106709:	83 f8 40             	cmp    $0x40,%eax
8010670c:	75 3f                	jne    8010674d <trap+0x53>
    if(proc->killed)
8010670e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106714:	8b 40 24             	mov    0x24(%eax),%eax
80106717:	85 c0                	test   %eax,%eax
80106719:	74 05                	je     80106720 <trap+0x26>
      exit();
8010671b:	e8 e2 e0 ff ff       	call   80104802 <exit>
    proc->tf = tf;
80106720:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106726:	8b 55 08             	mov    0x8(%ebp),%edx
80106729:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
8010672c:	e8 33 ee ff ff       	call   80105564 <syscall>
    if(proc->killed)
80106731:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106737:	8b 40 24             	mov    0x24(%eax),%eax
8010673a:	85 c0                	test   %eax,%eax
8010673c:	74 0a                	je     80106748 <trap+0x4e>
      exit();
8010673e:	e8 bf e0 ff ff       	call   80104802 <exit>
    return;
80106743:	e9 0b 02 00 00       	jmp    80106953 <trap+0x259>
80106748:	e9 06 02 00 00       	jmp    80106953 <trap+0x259>
  }

  switch(tf->trapno){
8010674d:	8b 45 08             	mov    0x8(%ebp),%eax
80106750:	8b 40 30             	mov    0x30(%eax),%eax
80106753:	83 e8 20             	sub    $0x20,%eax
80106756:	83 f8 1f             	cmp    $0x1f,%eax
80106759:	0f 87 bb 00 00 00    	ja     8010681a <trap+0x120>
8010675f:	8b 04 85 30 89 10 80 	mov    -0x7fef76d0(,%eax,4),%eax
80106766:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
80106768:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010676e:	8a 00                	mov    (%eax),%al
80106770:	84 c0                	test   %al,%al
80106772:	75 3b                	jne    801067af <trap+0xb5>
      acquire(&tickslock);
80106774:	83 ec 0c             	sub    $0xc,%esp
80106777:	68 a0 48 11 80       	push   $0x801148a0
8010677c:	e8 c7 e7 ff ff       	call   80104f48 <acquire>
80106781:	83 c4 10             	add    $0x10,%esp
      ticks++;
80106784:	a1 e0 50 11 80       	mov    0x801150e0,%eax
80106789:	40                   	inc    %eax
8010678a:	a3 e0 50 11 80       	mov    %eax,0x801150e0
      wakeup(&ticks);
8010678f:	83 ec 0c             	sub    $0xc,%esp
80106792:	68 e0 50 11 80       	push   $0x801150e0
80106797:	e8 a8 e5 ff ff       	call   80104d44 <wakeup>
8010679c:	83 c4 10             	add    $0x10,%esp
      release(&tickslock);
8010679f:	83 ec 0c             	sub    $0xc,%esp
801067a2:	68 a0 48 11 80       	push   $0x801148a0
801067a7:	e8 02 e8 ff ff       	call   80104fae <release>
801067ac:	83 c4 10             	add    $0x10,%esp
    }
    lapiceoi();
801067af:	e8 a9 c7 ff ff       	call   80102f5d <lapiceoi>
    break;
801067b4:	e9 18 01 00 00       	jmp    801068d1 <trap+0x1d7>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
801067b9:	e8 d3 bf ff ff       	call   80102791 <ideintr>
    lapiceoi();
801067be:	e8 9a c7 ff ff       	call   80102f5d <lapiceoi>
    break;
801067c3:	e9 09 01 00 00       	jmp    801068d1 <trap+0x1d7>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
801067c8:	e8 9b c5 ff ff       	call   80102d68 <kbdintr>
    lapiceoi();
801067cd:	e8 8b c7 ff ff       	call   80102f5d <lapiceoi>
    break;
801067d2:	e9 fa 00 00 00       	jmp    801068d1 <trap+0x1d7>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
801067d7:	e8 4c 03 00 00       	call   80106b28 <uartintr>
    lapiceoi();
801067dc:	e8 7c c7 ff ff       	call   80102f5d <lapiceoi>
    break;
801067e1:	e9 eb 00 00 00       	jmp    801068d1 <trap+0x1d7>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801067e6:	8b 45 08             	mov    0x8(%ebp),%eax
801067e9:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
801067ec:	8b 45 08             	mov    0x8(%ebp),%eax
801067ef:	8b 40 3c             	mov    0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801067f2:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
801067f5:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801067fb:	8a 00                	mov    (%eax),%al
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801067fd:	0f b6 c0             	movzbl %al,%eax
80106800:	51                   	push   %ecx
80106801:	52                   	push   %edx
80106802:	50                   	push   %eax
80106803:	68 90 88 10 80       	push   $0x80108890
80106808:	e8 ab 9b ff ff       	call   801003b8 <cprintf>
8010680d:	83 c4 10             	add    $0x10,%esp
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
80106810:	e8 48 c7 ff ff       	call   80102f5d <lapiceoi>
    break;
80106815:	e9 b7 00 00 00       	jmp    801068d1 <trap+0x1d7>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
8010681a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106820:	85 c0                	test   %eax,%eax
80106822:	74 10                	je     80106834 <trap+0x13a>
80106824:	8b 45 08             	mov    0x8(%ebp),%eax
80106827:	8b 40 3c             	mov    0x3c(%eax),%eax
8010682a:	0f b7 c0             	movzwl %ax,%eax
8010682d:	83 e0 03             	and    $0x3,%eax
80106830:	85 c0                	test   %eax,%eax
80106832:	75 3e                	jne    80106872 <trap+0x178>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106834:	e8 3b fd ff ff       	call   80106574 <rcr2>
80106839:	8b 55 08             	mov    0x8(%ebp),%edx
8010683c:	8b 5a 38             	mov    0x38(%edx),%ebx
              tf->trapno, cpu->id, tf->eip, rcr2());
8010683f:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80106846:	8a 12                	mov    (%edx),%dl
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106848:	0f b6 ca             	movzbl %dl,%ecx
8010684b:	8b 55 08             	mov    0x8(%ebp),%edx
8010684e:	8b 52 30             	mov    0x30(%edx),%edx
80106851:	83 ec 0c             	sub    $0xc,%esp
80106854:	50                   	push   %eax
80106855:	53                   	push   %ebx
80106856:	51                   	push   %ecx
80106857:	52                   	push   %edx
80106858:	68 b4 88 10 80       	push   $0x801088b4
8010685d:	e8 56 9b ff ff       	call   801003b8 <cprintf>
80106862:	83 c4 20             	add    $0x20,%esp
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
80106865:	83 ec 0c             	sub    $0xc,%esp
80106868:	68 e6 88 10 80       	push   $0x801088e6
8010686d:	e8 dc 9c ff ff       	call   8010054e <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106872:	e8 fd fc ff ff       	call   80106574 <rcr2>
80106877:	89 c2                	mov    %eax,%edx
80106879:	8b 45 08             	mov    0x8(%ebp),%eax
8010687c:	8b 78 38             	mov    0x38(%eax),%edi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
8010687f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106885:	8a 00                	mov    (%eax),%al
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106887:	0f b6 f0             	movzbl %al,%esi
8010688a:	8b 45 08             	mov    0x8(%ebp),%eax
8010688d:	8b 58 34             	mov    0x34(%eax),%ebx
80106890:	8b 45 08             	mov    0x8(%ebp),%eax
80106893:	8b 48 30             	mov    0x30(%eax),%ecx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106896:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010689c:	83 c0 6c             	add    $0x6c,%eax
8010689f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801068a2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801068a8:	8b 40 10             	mov    0x10(%eax),%eax
801068ab:	52                   	push   %edx
801068ac:	57                   	push   %edi
801068ad:	56                   	push   %esi
801068ae:	53                   	push   %ebx
801068af:	51                   	push   %ecx
801068b0:	ff 75 e4             	pushl  -0x1c(%ebp)
801068b3:	50                   	push   %eax
801068b4:	68 ec 88 10 80       	push   $0x801088ec
801068b9:	e8 fa 9a ff ff       	call   801003b8 <cprintf>
801068be:	83 c4 20             	add    $0x20,%esp
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
801068c1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801068c7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
801068ce:	eb 01                	jmp    801068d1 <trap+0x1d7>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
801068d0:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
801068d1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801068d7:	85 c0                	test   %eax,%eax
801068d9:	74 23                	je     801068fe <trap+0x204>
801068db:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801068e1:	8b 40 24             	mov    0x24(%eax),%eax
801068e4:	85 c0                	test   %eax,%eax
801068e6:	74 16                	je     801068fe <trap+0x204>
801068e8:	8b 45 08             	mov    0x8(%ebp),%eax
801068eb:	8b 40 3c             	mov    0x3c(%eax),%eax
801068ee:	0f b7 c0             	movzwl %ax,%eax
801068f1:	83 e0 03             	and    $0x3,%eax
801068f4:	83 f8 03             	cmp    $0x3,%eax
801068f7:	75 05                	jne    801068fe <trap+0x204>
    exit();
801068f9:	e8 04 df ff ff       	call   80104802 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
801068fe:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106904:	85 c0                	test   %eax,%eax
80106906:	74 1e                	je     80106926 <trap+0x22c>
80106908:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010690e:	8b 40 0c             	mov    0xc(%eax),%eax
80106911:	83 f8 04             	cmp    $0x4,%eax
80106914:	75 10                	jne    80106926 <trap+0x22c>
80106916:	8b 45 08             	mov    0x8(%ebp),%eax
80106919:	8b 40 30             	mov    0x30(%eax),%eax
8010691c:	83 f8 20             	cmp    $0x20,%eax
8010691f:	75 05                	jne    80106926 <trap+0x22c>
    yield();
80106921:	e8 b6 e2 ff ff       	call   80104bdc <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106926:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010692c:	85 c0                	test   %eax,%eax
8010692e:	74 23                	je     80106953 <trap+0x259>
80106930:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106936:	8b 40 24             	mov    0x24(%eax),%eax
80106939:	85 c0                	test   %eax,%eax
8010693b:	74 16                	je     80106953 <trap+0x259>
8010693d:	8b 45 08             	mov    0x8(%ebp),%eax
80106940:	8b 40 3c             	mov    0x3c(%eax),%eax
80106943:	0f b7 c0             	movzwl %ax,%eax
80106946:	83 e0 03             	and    $0x3,%eax
80106949:	83 f8 03             	cmp    $0x3,%eax
8010694c:	75 05                	jne    80106953 <trap+0x259>
    exit();
8010694e:	e8 af de ff ff       	call   80104802 <exit>
}
80106953:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106956:	5b                   	pop    %ebx
80106957:	5e                   	pop    %esi
80106958:	5f                   	pop    %edi
80106959:	5d                   	pop    %ebp
8010695a:	c3                   	ret    

8010695b <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
8010695b:	55                   	push   %ebp
8010695c:	89 e5                	mov    %esp,%ebp
8010695e:	83 ec 14             	sub    $0x14,%esp
80106961:	8b 45 08             	mov    0x8(%ebp),%eax
80106964:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106968:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010696b:	89 c2                	mov    %eax,%edx
8010696d:	ec                   	in     (%dx),%al
8010696e:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80106971:	8a 45 ff             	mov    -0x1(%ebp),%al
}
80106974:	c9                   	leave  
80106975:	c3                   	ret    

80106976 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106976:	55                   	push   %ebp
80106977:	89 e5                	mov    %esp,%ebp
80106979:	83 ec 08             	sub    $0x8,%esp
8010697c:	8b 45 08             	mov    0x8(%ebp),%eax
8010697f:	8b 55 0c             	mov    0xc(%ebp),%edx
80106982:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80106986:	88 55 f8             	mov    %dl,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106989:	8a 45 f8             	mov    -0x8(%ebp),%al
8010698c:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010698f:	ee                   	out    %al,(%dx)
}
80106990:	c9                   	leave  
80106991:	c3                   	ret    

80106992 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80106992:	55                   	push   %ebp
80106993:	89 e5                	mov    %esp,%ebp
80106995:	83 ec 18             	sub    $0x18,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
80106998:	6a 00                	push   $0x0
8010699a:	68 fa 03 00 00       	push   $0x3fa
8010699f:	e8 d2 ff ff ff       	call   80106976 <outb>
801069a4:	83 c4 08             	add    $0x8,%esp
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
801069a7:	68 80 00 00 00       	push   $0x80
801069ac:	68 fb 03 00 00       	push   $0x3fb
801069b1:	e8 c0 ff ff ff       	call   80106976 <outb>
801069b6:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
801069b9:	6a 0c                	push   $0xc
801069bb:	68 f8 03 00 00       	push   $0x3f8
801069c0:	e8 b1 ff ff ff       	call   80106976 <outb>
801069c5:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
801069c8:	6a 00                	push   $0x0
801069ca:	68 f9 03 00 00       	push   $0x3f9
801069cf:	e8 a2 ff ff ff       	call   80106976 <outb>
801069d4:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
801069d7:	6a 03                	push   $0x3
801069d9:	68 fb 03 00 00       	push   $0x3fb
801069de:	e8 93 ff ff ff       	call   80106976 <outb>
801069e3:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
801069e6:	6a 00                	push   $0x0
801069e8:	68 fc 03 00 00       	push   $0x3fc
801069ed:	e8 84 ff ff ff       	call   80106976 <outb>
801069f2:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
801069f5:	6a 01                	push   $0x1
801069f7:	68 f9 03 00 00       	push   $0x3f9
801069fc:	e8 75 ff ff ff       	call   80106976 <outb>
80106a01:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106a04:	68 fd 03 00 00       	push   $0x3fd
80106a09:	e8 4d ff ff ff       	call   8010695b <inb>
80106a0e:	83 c4 04             	add    $0x4,%esp
80106a11:	3c ff                	cmp    $0xff,%al
80106a13:	75 02                	jne    80106a17 <uartinit+0x85>
    return;
80106a15:	eb 69                	jmp    80106a80 <uartinit+0xee>
  uart = 1;
80106a17:	c7 05 4c b6 10 80 01 	movl   $0x1,0x8010b64c
80106a1e:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80106a21:	68 fa 03 00 00       	push   $0x3fa
80106a26:	e8 30 ff ff ff       	call   8010695b <inb>
80106a2b:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
80106a2e:	68 f8 03 00 00       	push   $0x3f8
80106a33:	e8 23 ff ff ff       	call   8010695b <inb>
80106a38:	83 c4 04             	add    $0x4,%esp
  picenable(IRQ_COM1);
80106a3b:	83 ec 0c             	sub    $0xc,%esp
80106a3e:	6a 04                	push   $0x4
80106a40:	e8 36 d4 ff ff       	call   80103e7b <picenable>
80106a45:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_COM1, 0);
80106a48:	83 ec 08             	sub    $0x8,%esp
80106a4b:	6a 00                	push   $0x0
80106a4d:	6a 04                	push   $0x4
80106a4f:	e8 d6 bf ff ff       	call   80102a2a <ioapicenable>
80106a54:	83 c4 10             	add    $0x10,%esp
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106a57:	c7 45 f4 b0 89 10 80 	movl   $0x801089b0,-0xc(%ebp)
80106a5e:	eb 17                	jmp    80106a77 <uartinit+0xe5>
    uartputc(*p);
80106a60:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a63:	8a 00                	mov    (%eax),%al
80106a65:	0f be c0             	movsbl %al,%eax
80106a68:	83 ec 0c             	sub    $0xc,%esp
80106a6b:	50                   	push   %eax
80106a6c:	e8 11 00 00 00       	call   80106a82 <uartputc>
80106a71:	83 c4 10             	add    $0x10,%esp
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106a74:	ff 45 f4             	incl   -0xc(%ebp)
80106a77:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a7a:	8a 00                	mov    (%eax),%al
80106a7c:	84 c0                	test   %al,%al
80106a7e:	75 e0                	jne    80106a60 <uartinit+0xce>
    uartputc(*p);
}
80106a80:	c9                   	leave  
80106a81:	c3                   	ret    

80106a82 <uartputc>:

void
uartputc(int c)
{
80106a82:	55                   	push   %ebp
80106a83:	89 e5                	mov    %esp,%ebp
80106a85:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(!uart)
80106a88:	a1 4c b6 10 80       	mov    0x8010b64c,%eax
80106a8d:	85 c0                	test   %eax,%eax
80106a8f:	75 02                	jne    80106a93 <uartputc+0x11>
    return;
80106a91:	eb 50                	jmp    80106ae3 <uartputc+0x61>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106a93:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106a9a:	eb 10                	jmp    80106aac <uartputc+0x2a>
    microdelay(10);
80106a9c:	83 ec 0c             	sub    $0xc,%esp
80106a9f:	6a 0a                	push   $0xa
80106aa1:	e8 d1 c4 ff ff       	call   80102f77 <microdelay>
80106aa6:	83 c4 10             	add    $0x10,%esp
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106aa9:	ff 45 f4             	incl   -0xc(%ebp)
80106aac:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80106ab0:	7f 1a                	jg     80106acc <uartputc+0x4a>
80106ab2:	83 ec 0c             	sub    $0xc,%esp
80106ab5:	68 fd 03 00 00       	push   $0x3fd
80106aba:	e8 9c fe ff ff       	call   8010695b <inb>
80106abf:	83 c4 10             	add    $0x10,%esp
80106ac2:	0f b6 c0             	movzbl %al,%eax
80106ac5:	83 e0 20             	and    $0x20,%eax
80106ac8:	85 c0                	test   %eax,%eax
80106aca:	74 d0                	je     80106a9c <uartputc+0x1a>
    microdelay(10);
  outb(COM1+0, c);
80106acc:	8b 45 08             	mov    0x8(%ebp),%eax
80106acf:	0f b6 c0             	movzbl %al,%eax
80106ad2:	83 ec 08             	sub    $0x8,%esp
80106ad5:	50                   	push   %eax
80106ad6:	68 f8 03 00 00       	push   $0x3f8
80106adb:	e8 96 fe ff ff       	call   80106976 <outb>
80106ae0:	83 c4 10             	add    $0x10,%esp
}
80106ae3:	c9                   	leave  
80106ae4:	c3                   	ret    

80106ae5 <uartgetc>:

static int
uartgetc(void)
{
80106ae5:	55                   	push   %ebp
80106ae6:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106ae8:	a1 4c b6 10 80       	mov    0x8010b64c,%eax
80106aed:	85 c0                	test   %eax,%eax
80106aef:	75 07                	jne    80106af8 <uartgetc+0x13>
    return -1;
80106af1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106af6:	eb 2e                	jmp    80106b26 <uartgetc+0x41>
  if(!(inb(COM1+5) & 0x01))
80106af8:	68 fd 03 00 00       	push   $0x3fd
80106afd:	e8 59 fe ff ff       	call   8010695b <inb>
80106b02:	83 c4 04             	add    $0x4,%esp
80106b05:	0f b6 c0             	movzbl %al,%eax
80106b08:	83 e0 01             	and    $0x1,%eax
80106b0b:	85 c0                	test   %eax,%eax
80106b0d:	75 07                	jne    80106b16 <uartgetc+0x31>
    return -1;
80106b0f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b14:	eb 10                	jmp    80106b26 <uartgetc+0x41>
  return inb(COM1+0);
80106b16:	68 f8 03 00 00       	push   $0x3f8
80106b1b:	e8 3b fe ff ff       	call   8010695b <inb>
80106b20:	83 c4 04             	add    $0x4,%esp
80106b23:	0f b6 c0             	movzbl %al,%eax
}
80106b26:	c9                   	leave  
80106b27:	c3                   	ret    

80106b28 <uartintr>:

void
uartintr(void)
{
80106b28:	55                   	push   %ebp
80106b29:	89 e5                	mov    %esp,%ebp
80106b2b:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
80106b2e:	83 ec 0c             	sub    $0xc,%esp
80106b31:	68 e5 6a 10 80       	push   $0x80106ae5
80106b36:	e8 8e 9c ff ff       	call   801007c9 <consoleintr>
80106b3b:	83 c4 10             	add    $0x10,%esp
}
80106b3e:	c9                   	leave  
80106b3f:	c3                   	ret    

80106b40 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106b40:	6a 00                	push   $0x0
  pushl $0
80106b42:	6a 00                	push   $0x0
  jmp alltraps
80106b44:	e9 d9 f9 ff ff       	jmp    80106522 <alltraps>

80106b49 <vector1>:
.globl vector1
vector1:
  pushl $0
80106b49:	6a 00                	push   $0x0
  pushl $1
80106b4b:	6a 01                	push   $0x1
  jmp alltraps
80106b4d:	e9 d0 f9 ff ff       	jmp    80106522 <alltraps>

80106b52 <vector2>:
.globl vector2
vector2:
  pushl $0
80106b52:	6a 00                	push   $0x0
  pushl $2
80106b54:	6a 02                	push   $0x2
  jmp alltraps
80106b56:	e9 c7 f9 ff ff       	jmp    80106522 <alltraps>

80106b5b <vector3>:
.globl vector3
vector3:
  pushl $0
80106b5b:	6a 00                	push   $0x0
  pushl $3
80106b5d:	6a 03                	push   $0x3
  jmp alltraps
80106b5f:	e9 be f9 ff ff       	jmp    80106522 <alltraps>

80106b64 <vector4>:
.globl vector4
vector4:
  pushl $0
80106b64:	6a 00                	push   $0x0
  pushl $4
80106b66:	6a 04                	push   $0x4
  jmp alltraps
80106b68:	e9 b5 f9 ff ff       	jmp    80106522 <alltraps>

80106b6d <vector5>:
.globl vector5
vector5:
  pushl $0
80106b6d:	6a 00                	push   $0x0
  pushl $5
80106b6f:	6a 05                	push   $0x5
  jmp alltraps
80106b71:	e9 ac f9 ff ff       	jmp    80106522 <alltraps>

80106b76 <vector6>:
.globl vector6
vector6:
  pushl $0
80106b76:	6a 00                	push   $0x0
  pushl $6
80106b78:	6a 06                	push   $0x6
  jmp alltraps
80106b7a:	e9 a3 f9 ff ff       	jmp    80106522 <alltraps>

80106b7f <vector7>:
.globl vector7
vector7:
  pushl $0
80106b7f:	6a 00                	push   $0x0
  pushl $7
80106b81:	6a 07                	push   $0x7
  jmp alltraps
80106b83:	e9 9a f9 ff ff       	jmp    80106522 <alltraps>

80106b88 <vector8>:
.globl vector8
vector8:
  pushl $8
80106b88:	6a 08                	push   $0x8
  jmp alltraps
80106b8a:	e9 93 f9 ff ff       	jmp    80106522 <alltraps>

80106b8f <vector9>:
.globl vector9
vector9:
  pushl $0
80106b8f:	6a 00                	push   $0x0
  pushl $9
80106b91:	6a 09                	push   $0x9
  jmp alltraps
80106b93:	e9 8a f9 ff ff       	jmp    80106522 <alltraps>

80106b98 <vector10>:
.globl vector10
vector10:
  pushl $10
80106b98:	6a 0a                	push   $0xa
  jmp alltraps
80106b9a:	e9 83 f9 ff ff       	jmp    80106522 <alltraps>

80106b9f <vector11>:
.globl vector11
vector11:
  pushl $11
80106b9f:	6a 0b                	push   $0xb
  jmp alltraps
80106ba1:	e9 7c f9 ff ff       	jmp    80106522 <alltraps>

80106ba6 <vector12>:
.globl vector12
vector12:
  pushl $12
80106ba6:	6a 0c                	push   $0xc
  jmp alltraps
80106ba8:	e9 75 f9 ff ff       	jmp    80106522 <alltraps>

80106bad <vector13>:
.globl vector13
vector13:
  pushl $13
80106bad:	6a 0d                	push   $0xd
  jmp alltraps
80106baf:	e9 6e f9 ff ff       	jmp    80106522 <alltraps>

80106bb4 <vector14>:
.globl vector14
vector14:
  pushl $14
80106bb4:	6a 0e                	push   $0xe
  jmp alltraps
80106bb6:	e9 67 f9 ff ff       	jmp    80106522 <alltraps>

80106bbb <vector15>:
.globl vector15
vector15:
  pushl $0
80106bbb:	6a 00                	push   $0x0
  pushl $15
80106bbd:	6a 0f                	push   $0xf
  jmp alltraps
80106bbf:	e9 5e f9 ff ff       	jmp    80106522 <alltraps>

80106bc4 <vector16>:
.globl vector16
vector16:
  pushl $0
80106bc4:	6a 00                	push   $0x0
  pushl $16
80106bc6:	6a 10                	push   $0x10
  jmp alltraps
80106bc8:	e9 55 f9 ff ff       	jmp    80106522 <alltraps>

80106bcd <vector17>:
.globl vector17
vector17:
  pushl $17
80106bcd:	6a 11                	push   $0x11
  jmp alltraps
80106bcf:	e9 4e f9 ff ff       	jmp    80106522 <alltraps>

80106bd4 <vector18>:
.globl vector18
vector18:
  pushl $0
80106bd4:	6a 00                	push   $0x0
  pushl $18
80106bd6:	6a 12                	push   $0x12
  jmp alltraps
80106bd8:	e9 45 f9 ff ff       	jmp    80106522 <alltraps>

80106bdd <vector19>:
.globl vector19
vector19:
  pushl $0
80106bdd:	6a 00                	push   $0x0
  pushl $19
80106bdf:	6a 13                	push   $0x13
  jmp alltraps
80106be1:	e9 3c f9 ff ff       	jmp    80106522 <alltraps>

80106be6 <vector20>:
.globl vector20
vector20:
  pushl $0
80106be6:	6a 00                	push   $0x0
  pushl $20
80106be8:	6a 14                	push   $0x14
  jmp alltraps
80106bea:	e9 33 f9 ff ff       	jmp    80106522 <alltraps>

80106bef <vector21>:
.globl vector21
vector21:
  pushl $0
80106bef:	6a 00                	push   $0x0
  pushl $21
80106bf1:	6a 15                	push   $0x15
  jmp alltraps
80106bf3:	e9 2a f9 ff ff       	jmp    80106522 <alltraps>

80106bf8 <vector22>:
.globl vector22
vector22:
  pushl $0
80106bf8:	6a 00                	push   $0x0
  pushl $22
80106bfa:	6a 16                	push   $0x16
  jmp alltraps
80106bfc:	e9 21 f9 ff ff       	jmp    80106522 <alltraps>

80106c01 <vector23>:
.globl vector23
vector23:
  pushl $0
80106c01:	6a 00                	push   $0x0
  pushl $23
80106c03:	6a 17                	push   $0x17
  jmp alltraps
80106c05:	e9 18 f9 ff ff       	jmp    80106522 <alltraps>

80106c0a <vector24>:
.globl vector24
vector24:
  pushl $0
80106c0a:	6a 00                	push   $0x0
  pushl $24
80106c0c:	6a 18                	push   $0x18
  jmp alltraps
80106c0e:	e9 0f f9 ff ff       	jmp    80106522 <alltraps>

80106c13 <vector25>:
.globl vector25
vector25:
  pushl $0
80106c13:	6a 00                	push   $0x0
  pushl $25
80106c15:	6a 19                	push   $0x19
  jmp alltraps
80106c17:	e9 06 f9 ff ff       	jmp    80106522 <alltraps>

80106c1c <vector26>:
.globl vector26
vector26:
  pushl $0
80106c1c:	6a 00                	push   $0x0
  pushl $26
80106c1e:	6a 1a                	push   $0x1a
  jmp alltraps
80106c20:	e9 fd f8 ff ff       	jmp    80106522 <alltraps>

80106c25 <vector27>:
.globl vector27
vector27:
  pushl $0
80106c25:	6a 00                	push   $0x0
  pushl $27
80106c27:	6a 1b                	push   $0x1b
  jmp alltraps
80106c29:	e9 f4 f8 ff ff       	jmp    80106522 <alltraps>

80106c2e <vector28>:
.globl vector28
vector28:
  pushl $0
80106c2e:	6a 00                	push   $0x0
  pushl $28
80106c30:	6a 1c                	push   $0x1c
  jmp alltraps
80106c32:	e9 eb f8 ff ff       	jmp    80106522 <alltraps>

80106c37 <vector29>:
.globl vector29
vector29:
  pushl $0
80106c37:	6a 00                	push   $0x0
  pushl $29
80106c39:	6a 1d                	push   $0x1d
  jmp alltraps
80106c3b:	e9 e2 f8 ff ff       	jmp    80106522 <alltraps>

80106c40 <vector30>:
.globl vector30
vector30:
  pushl $0
80106c40:	6a 00                	push   $0x0
  pushl $30
80106c42:	6a 1e                	push   $0x1e
  jmp alltraps
80106c44:	e9 d9 f8 ff ff       	jmp    80106522 <alltraps>

80106c49 <vector31>:
.globl vector31
vector31:
  pushl $0
80106c49:	6a 00                	push   $0x0
  pushl $31
80106c4b:	6a 1f                	push   $0x1f
  jmp alltraps
80106c4d:	e9 d0 f8 ff ff       	jmp    80106522 <alltraps>

80106c52 <vector32>:
.globl vector32
vector32:
  pushl $0
80106c52:	6a 00                	push   $0x0
  pushl $32
80106c54:	6a 20                	push   $0x20
  jmp alltraps
80106c56:	e9 c7 f8 ff ff       	jmp    80106522 <alltraps>

80106c5b <vector33>:
.globl vector33
vector33:
  pushl $0
80106c5b:	6a 00                	push   $0x0
  pushl $33
80106c5d:	6a 21                	push   $0x21
  jmp alltraps
80106c5f:	e9 be f8 ff ff       	jmp    80106522 <alltraps>

80106c64 <vector34>:
.globl vector34
vector34:
  pushl $0
80106c64:	6a 00                	push   $0x0
  pushl $34
80106c66:	6a 22                	push   $0x22
  jmp alltraps
80106c68:	e9 b5 f8 ff ff       	jmp    80106522 <alltraps>

80106c6d <vector35>:
.globl vector35
vector35:
  pushl $0
80106c6d:	6a 00                	push   $0x0
  pushl $35
80106c6f:	6a 23                	push   $0x23
  jmp alltraps
80106c71:	e9 ac f8 ff ff       	jmp    80106522 <alltraps>

80106c76 <vector36>:
.globl vector36
vector36:
  pushl $0
80106c76:	6a 00                	push   $0x0
  pushl $36
80106c78:	6a 24                	push   $0x24
  jmp alltraps
80106c7a:	e9 a3 f8 ff ff       	jmp    80106522 <alltraps>

80106c7f <vector37>:
.globl vector37
vector37:
  pushl $0
80106c7f:	6a 00                	push   $0x0
  pushl $37
80106c81:	6a 25                	push   $0x25
  jmp alltraps
80106c83:	e9 9a f8 ff ff       	jmp    80106522 <alltraps>

80106c88 <vector38>:
.globl vector38
vector38:
  pushl $0
80106c88:	6a 00                	push   $0x0
  pushl $38
80106c8a:	6a 26                	push   $0x26
  jmp alltraps
80106c8c:	e9 91 f8 ff ff       	jmp    80106522 <alltraps>

80106c91 <vector39>:
.globl vector39
vector39:
  pushl $0
80106c91:	6a 00                	push   $0x0
  pushl $39
80106c93:	6a 27                	push   $0x27
  jmp alltraps
80106c95:	e9 88 f8 ff ff       	jmp    80106522 <alltraps>

80106c9a <vector40>:
.globl vector40
vector40:
  pushl $0
80106c9a:	6a 00                	push   $0x0
  pushl $40
80106c9c:	6a 28                	push   $0x28
  jmp alltraps
80106c9e:	e9 7f f8 ff ff       	jmp    80106522 <alltraps>

80106ca3 <vector41>:
.globl vector41
vector41:
  pushl $0
80106ca3:	6a 00                	push   $0x0
  pushl $41
80106ca5:	6a 29                	push   $0x29
  jmp alltraps
80106ca7:	e9 76 f8 ff ff       	jmp    80106522 <alltraps>

80106cac <vector42>:
.globl vector42
vector42:
  pushl $0
80106cac:	6a 00                	push   $0x0
  pushl $42
80106cae:	6a 2a                	push   $0x2a
  jmp alltraps
80106cb0:	e9 6d f8 ff ff       	jmp    80106522 <alltraps>

80106cb5 <vector43>:
.globl vector43
vector43:
  pushl $0
80106cb5:	6a 00                	push   $0x0
  pushl $43
80106cb7:	6a 2b                	push   $0x2b
  jmp alltraps
80106cb9:	e9 64 f8 ff ff       	jmp    80106522 <alltraps>

80106cbe <vector44>:
.globl vector44
vector44:
  pushl $0
80106cbe:	6a 00                	push   $0x0
  pushl $44
80106cc0:	6a 2c                	push   $0x2c
  jmp alltraps
80106cc2:	e9 5b f8 ff ff       	jmp    80106522 <alltraps>

80106cc7 <vector45>:
.globl vector45
vector45:
  pushl $0
80106cc7:	6a 00                	push   $0x0
  pushl $45
80106cc9:	6a 2d                	push   $0x2d
  jmp alltraps
80106ccb:	e9 52 f8 ff ff       	jmp    80106522 <alltraps>

80106cd0 <vector46>:
.globl vector46
vector46:
  pushl $0
80106cd0:	6a 00                	push   $0x0
  pushl $46
80106cd2:	6a 2e                	push   $0x2e
  jmp alltraps
80106cd4:	e9 49 f8 ff ff       	jmp    80106522 <alltraps>

80106cd9 <vector47>:
.globl vector47
vector47:
  pushl $0
80106cd9:	6a 00                	push   $0x0
  pushl $47
80106cdb:	6a 2f                	push   $0x2f
  jmp alltraps
80106cdd:	e9 40 f8 ff ff       	jmp    80106522 <alltraps>

80106ce2 <vector48>:
.globl vector48
vector48:
  pushl $0
80106ce2:	6a 00                	push   $0x0
  pushl $48
80106ce4:	6a 30                	push   $0x30
  jmp alltraps
80106ce6:	e9 37 f8 ff ff       	jmp    80106522 <alltraps>

80106ceb <vector49>:
.globl vector49
vector49:
  pushl $0
80106ceb:	6a 00                	push   $0x0
  pushl $49
80106ced:	6a 31                	push   $0x31
  jmp alltraps
80106cef:	e9 2e f8 ff ff       	jmp    80106522 <alltraps>

80106cf4 <vector50>:
.globl vector50
vector50:
  pushl $0
80106cf4:	6a 00                	push   $0x0
  pushl $50
80106cf6:	6a 32                	push   $0x32
  jmp alltraps
80106cf8:	e9 25 f8 ff ff       	jmp    80106522 <alltraps>

80106cfd <vector51>:
.globl vector51
vector51:
  pushl $0
80106cfd:	6a 00                	push   $0x0
  pushl $51
80106cff:	6a 33                	push   $0x33
  jmp alltraps
80106d01:	e9 1c f8 ff ff       	jmp    80106522 <alltraps>

80106d06 <vector52>:
.globl vector52
vector52:
  pushl $0
80106d06:	6a 00                	push   $0x0
  pushl $52
80106d08:	6a 34                	push   $0x34
  jmp alltraps
80106d0a:	e9 13 f8 ff ff       	jmp    80106522 <alltraps>

80106d0f <vector53>:
.globl vector53
vector53:
  pushl $0
80106d0f:	6a 00                	push   $0x0
  pushl $53
80106d11:	6a 35                	push   $0x35
  jmp alltraps
80106d13:	e9 0a f8 ff ff       	jmp    80106522 <alltraps>

80106d18 <vector54>:
.globl vector54
vector54:
  pushl $0
80106d18:	6a 00                	push   $0x0
  pushl $54
80106d1a:	6a 36                	push   $0x36
  jmp alltraps
80106d1c:	e9 01 f8 ff ff       	jmp    80106522 <alltraps>

80106d21 <vector55>:
.globl vector55
vector55:
  pushl $0
80106d21:	6a 00                	push   $0x0
  pushl $55
80106d23:	6a 37                	push   $0x37
  jmp alltraps
80106d25:	e9 f8 f7 ff ff       	jmp    80106522 <alltraps>

80106d2a <vector56>:
.globl vector56
vector56:
  pushl $0
80106d2a:	6a 00                	push   $0x0
  pushl $56
80106d2c:	6a 38                	push   $0x38
  jmp alltraps
80106d2e:	e9 ef f7 ff ff       	jmp    80106522 <alltraps>

80106d33 <vector57>:
.globl vector57
vector57:
  pushl $0
80106d33:	6a 00                	push   $0x0
  pushl $57
80106d35:	6a 39                	push   $0x39
  jmp alltraps
80106d37:	e9 e6 f7 ff ff       	jmp    80106522 <alltraps>

80106d3c <vector58>:
.globl vector58
vector58:
  pushl $0
80106d3c:	6a 00                	push   $0x0
  pushl $58
80106d3e:	6a 3a                	push   $0x3a
  jmp alltraps
80106d40:	e9 dd f7 ff ff       	jmp    80106522 <alltraps>

80106d45 <vector59>:
.globl vector59
vector59:
  pushl $0
80106d45:	6a 00                	push   $0x0
  pushl $59
80106d47:	6a 3b                	push   $0x3b
  jmp alltraps
80106d49:	e9 d4 f7 ff ff       	jmp    80106522 <alltraps>

80106d4e <vector60>:
.globl vector60
vector60:
  pushl $0
80106d4e:	6a 00                	push   $0x0
  pushl $60
80106d50:	6a 3c                	push   $0x3c
  jmp alltraps
80106d52:	e9 cb f7 ff ff       	jmp    80106522 <alltraps>

80106d57 <vector61>:
.globl vector61
vector61:
  pushl $0
80106d57:	6a 00                	push   $0x0
  pushl $61
80106d59:	6a 3d                	push   $0x3d
  jmp alltraps
80106d5b:	e9 c2 f7 ff ff       	jmp    80106522 <alltraps>

80106d60 <vector62>:
.globl vector62
vector62:
  pushl $0
80106d60:	6a 00                	push   $0x0
  pushl $62
80106d62:	6a 3e                	push   $0x3e
  jmp alltraps
80106d64:	e9 b9 f7 ff ff       	jmp    80106522 <alltraps>

80106d69 <vector63>:
.globl vector63
vector63:
  pushl $0
80106d69:	6a 00                	push   $0x0
  pushl $63
80106d6b:	6a 3f                	push   $0x3f
  jmp alltraps
80106d6d:	e9 b0 f7 ff ff       	jmp    80106522 <alltraps>

80106d72 <vector64>:
.globl vector64
vector64:
  pushl $0
80106d72:	6a 00                	push   $0x0
  pushl $64
80106d74:	6a 40                	push   $0x40
  jmp alltraps
80106d76:	e9 a7 f7 ff ff       	jmp    80106522 <alltraps>

80106d7b <vector65>:
.globl vector65
vector65:
  pushl $0
80106d7b:	6a 00                	push   $0x0
  pushl $65
80106d7d:	6a 41                	push   $0x41
  jmp alltraps
80106d7f:	e9 9e f7 ff ff       	jmp    80106522 <alltraps>

80106d84 <vector66>:
.globl vector66
vector66:
  pushl $0
80106d84:	6a 00                	push   $0x0
  pushl $66
80106d86:	6a 42                	push   $0x42
  jmp alltraps
80106d88:	e9 95 f7 ff ff       	jmp    80106522 <alltraps>

80106d8d <vector67>:
.globl vector67
vector67:
  pushl $0
80106d8d:	6a 00                	push   $0x0
  pushl $67
80106d8f:	6a 43                	push   $0x43
  jmp alltraps
80106d91:	e9 8c f7 ff ff       	jmp    80106522 <alltraps>

80106d96 <vector68>:
.globl vector68
vector68:
  pushl $0
80106d96:	6a 00                	push   $0x0
  pushl $68
80106d98:	6a 44                	push   $0x44
  jmp alltraps
80106d9a:	e9 83 f7 ff ff       	jmp    80106522 <alltraps>

80106d9f <vector69>:
.globl vector69
vector69:
  pushl $0
80106d9f:	6a 00                	push   $0x0
  pushl $69
80106da1:	6a 45                	push   $0x45
  jmp alltraps
80106da3:	e9 7a f7 ff ff       	jmp    80106522 <alltraps>

80106da8 <vector70>:
.globl vector70
vector70:
  pushl $0
80106da8:	6a 00                	push   $0x0
  pushl $70
80106daa:	6a 46                	push   $0x46
  jmp alltraps
80106dac:	e9 71 f7 ff ff       	jmp    80106522 <alltraps>

80106db1 <vector71>:
.globl vector71
vector71:
  pushl $0
80106db1:	6a 00                	push   $0x0
  pushl $71
80106db3:	6a 47                	push   $0x47
  jmp alltraps
80106db5:	e9 68 f7 ff ff       	jmp    80106522 <alltraps>

80106dba <vector72>:
.globl vector72
vector72:
  pushl $0
80106dba:	6a 00                	push   $0x0
  pushl $72
80106dbc:	6a 48                	push   $0x48
  jmp alltraps
80106dbe:	e9 5f f7 ff ff       	jmp    80106522 <alltraps>

80106dc3 <vector73>:
.globl vector73
vector73:
  pushl $0
80106dc3:	6a 00                	push   $0x0
  pushl $73
80106dc5:	6a 49                	push   $0x49
  jmp alltraps
80106dc7:	e9 56 f7 ff ff       	jmp    80106522 <alltraps>

80106dcc <vector74>:
.globl vector74
vector74:
  pushl $0
80106dcc:	6a 00                	push   $0x0
  pushl $74
80106dce:	6a 4a                	push   $0x4a
  jmp alltraps
80106dd0:	e9 4d f7 ff ff       	jmp    80106522 <alltraps>

80106dd5 <vector75>:
.globl vector75
vector75:
  pushl $0
80106dd5:	6a 00                	push   $0x0
  pushl $75
80106dd7:	6a 4b                	push   $0x4b
  jmp alltraps
80106dd9:	e9 44 f7 ff ff       	jmp    80106522 <alltraps>

80106dde <vector76>:
.globl vector76
vector76:
  pushl $0
80106dde:	6a 00                	push   $0x0
  pushl $76
80106de0:	6a 4c                	push   $0x4c
  jmp alltraps
80106de2:	e9 3b f7 ff ff       	jmp    80106522 <alltraps>

80106de7 <vector77>:
.globl vector77
vector77:
  pushl $0
80106de7:	6a 00                	push   $0x0
  pushl $77
80106de9:	6a 4d                	push   $0x4d
  jmp alltraps
80106deb:	e9 32 f7 ff ff       	jmp    80106522 <alltraps>

80106df0 <vector78>:
.globl vector78
vector78:
  pushl $0
80106df0:	6a 00                	push   $0x0
  pushl $78
80106df2:	6a 4e                	push   $0x4e
  jmp alltraps
80106df4:	e9 29 f7 ff ff       	jmp    80106522 <alltraps>

80106df9 <vector79>:
.globl vector79
vector79:
  pushl $0
80106df9:	6a 00                	push   $0x0
  pushl $79
80106dfb:	6a 4f                	push   $0x4f
  jmp alltraps
80106dfd:	e9 20 f7 ff ff       	jmp    80106522 <alltraps>

80106e02 <vector80>:
.globl vector80
vector80:
  pushl $0
80106e02:	6a 00                	push   $0x0
  pushl $80
80106e04:	6a 50                	push   $0x50
  jmp alltraps
80106e06:	e9 17 f7 ff ff       	jmp    80106522 <alltraps>

80106e0b <vector81>:
.globl vector81
vector81:
  pushl $0
80106e0b:	6a 00                	push   $0x0
  pushl $81
80106e0d:	6a 51                	push   $0x51
  jmp alltraps
80106e0f:	e9 0e f7 ff ff       	jmp    80106522 <alltraps>

80106e14 <vector82>:
.globl vector82
vector82:
  pushl $0
80106e14:	6a 00                	push   $0x0
  pushl $82
80106e16:	6a 52                	push   $0x52
  jmp alltraps
80106e18:	e9 05 f7 ff ff       	jmp    80106522 <alltraps>

80106e1d <vector83>:
.globl vector83
vector83:
  pushl $0
80106e1d:	6a 00                	push   $0x0
  pushl $83
80106e1f:	6a 53                	push   $0x53
  jmp alltraps
80106e21:	e9 fc f6 ff ff       	jmp    80106522 <alltraps>

80106e26 <vector84>:
.globl vector84
vector84:
  pushl $0
80106e26:	6a 00                	push   $0x0
  pushl $84
80106e28:	6a 54                	push   $0x54
  jmp alltraps
80106e2a:	e9 f3 f6 ff ff       	jmp    80106522 <alltraps>

80106e2f <vector85>:
.globl vector85
vector85:
  pushl $0
80106e2f:	6a 00                	push   $0x0
  pushl $85
80106e31:	6a 55                	push   $0x55
  jmp alltraps
80106e33:	e9 ea f6 ff ff       	jmp    80106522 <alltraps>

80106e38 <vector86>:
.globl vector86
vector86:
  pushl $0
80106e38:	6a 00                	push   $0x0
  pushl $86
80106e3a:	6a 56                	push   $0x56
  jmp alltraps
80106e3c:	e9 e1 f6 ff ff       	jmp    80106522 <alltraps>

80106e41 <vector87>:
.globl vector87
vector87:
  pushl $0
80106e41:	6a 00                	push   $0x0
  pushl $87
80106e43:	6a 57                	push   $0x57
  jmp alltraps
80106e45:	e9 d8 f6 ff ff       	jmp    80106522 <alltraps>

80106e4a <vector88>:
.globl vector88
vector88:
  pushl $0
80106e4a:	6a 00                	push   $0x0
  pushl $88
80106e4c:	6a 58                	push   $0x58
  jmp alltraps
80106e4e:	e9 cf f6 ff ff       	jmp    80106522 <alltraps>

80106e53 <vector89>:
.globl vector89
vector89:
  pushl $0
80106e53:	6a 00                	push   $0x0
  pushl $89
80106e55:	6a 59                	push   $0x59
  jmp alltraps
80106e57:	e9 c6 f6 ff ff       	jmp    80106522 <alltraps>

80106e5c <vector90>:
.globl vector90
vector90:
  pushl $0
80106e5c:	6a 00                	push   $0x0
  pushl $90
80106e5e:	6a 5a                	push   $0x5a
  jmp alltraps
80106e60:	e9 bd f6 ff ff       	jmp    80106522 <alltraps>

80106e65 <vector91>:
.globl vector91
vector91:
  pushl $0
80106e65:	6a 00                	push   $0x0
  pushl $91
80106e67:	6a 5b                	push   $0x5b
  jmp alltraps
80106e69:	e9 b4 f6 ff ff       	jmp    80106522 <alltraps>

80106e6e <vector92>:
.globl vector92
vector92:
  pushl $0
80106e6e:	6a 00                	push   $0x0
  pushl $92
80106e70:	6a 5c                	push   $0x5c
  jmp alltraps
80106e72:	e9 ab f6 ff ff       	jmp    80106522 <alltraps>

80106e77 <vector93>:
.globl vector93
vector93:
  pushl $0
80106e77:	6a 00                	push   $0x0
  pushl $93
80106e79:	6a 5d                	push   $0x5d
  jmp alltraps
80106e7b:	e9 a2 f6 ff ff       	jmp    80106522 <alltraps>

80106e80 <vector94>:
.globl vector94
vector94:
  pushl $0
80106e80:	6a 00                	push   $0x0
  pushl $94
80106e82:	6a 5e                	push   $0x5e
  jmp alltraps
80106e84:	e9 99 f6 ff ff       	jmp    80106522 <alltraps>

80106e89 <vector95>:
.globl vector95
vector95:
  pushl $0
80106e89:	6a 00                	push   $0x0
  pushl $95
80106e8b:	6a 5f                	push   $0x5f
  jmp alltraps
80106e8d:	e9 90 f6 ff ff       	jmp    80106522 <alltraps>

80106e92 <vector96>:
.globl vector96
vector96:
  pushl $0
80106e92:	6a 00                	push   $0x0
  pushl $96
80106e94:	6a 60                	push   $0x60
  jmp alltraps
80106e96:	e9 87 f6 ff ff       	jmp    80106522 <alltraps>

80106e9b <vector97>:
.globl vector97
vector97:
  pushl $0
80106e9b:	6a 00                	push   $0x0
  pushl $97
80106e9d:	6a 61                	push   $0x61
  jmp alltraps
80106e9f:	e9 7e f6 ff ff       	jmp    80106522 <alltraps>

80106ea4 <vector98>:
.globl vector98
vector98:
  pushl $0
80106ea4:	6a 00                	push   $0x0
  pushl $98
80106ea6:	6a 62                	push   $0x62
  jmp alltraps
80106ea8:	e9 75 f6 ff ff       	jmp    80106522 <alltraps>

80106ead <vector99>:
.globl vector99
vector99:
  pushl $0
80106ead:	6a 00                	push   $0x0
  pushl $99
80106eaf:	6a 63                	push   $0x63
  jmp alltraps
80106eb1:	e9 6c f6 ff ff       	jmp    80106522 <alltraps>

80106eb6 <vector100>:
.globl vector100
vector100:
  pushl $0
80106eb6:	6a 00                	push   $0x0
  pushl $100
80106eb8:	6a 64                	push   $0x64
  jmp alltraps
80106eba:	e9 63 f6 ff ff       	jmp    80106522 <alltraps>

80106ebf <vector101>:
.globl vector101
vector101:
  pushl $0
80106ebf:	6a 00                	push   $0x0
  pushl $101
80106ec1:	6a 65                	push   $0x65
  jmp alltraps
80106ec3:	e9 5a f6 ff ff       	jmp    80106522 <alltraps>

80106ec8 <vector102>:
.globl vector102
vector102:
  pushl $0
80106ec8:	6a 00                	push   $0x0
  pushl $102
80106eca:	6a 66                	push   $0x66
  jmp alltraps
80106ecc:	e9 51 f6 ff ff       	jmp    80106522 <alltraps>

80106ed1 <vector103>:
.globl vector103
vector103:
  pushl $0
80106ed1:	6a 00                	push   $0x0
  pushl $103
80106ed3:	6a 67                	push   $0x67
  jmp alltraps
80106ed5:	e9 48 f6 ff ff       	jmp    80106522 <alltraps>

80106eda <vector104>:
.globl vector104
vector104:
  pushl $0
80106eda:	6a 00                	push   $0x0
  pushl $104
80106edc:	6a 68                	push   $0x68
  jmp alltraps
80106ede:	e9 3f f6 ff ff       	jmp    80106522 <alltraps>

80106ee3 <vector105>:
.globl vector105
vector105:
  pushl $0
80106ee3:	6a 00                	push   $0x0
  pushl $105
80106ee5:	6a 69                	push   $0x69
  jmp alltraps
80106ee7:	e9 36 f6 ff ff       	jmp    80106522 <alltraps>

80106eec <vector106>:
.globl vector106
vector106:
  pushl $0
80106eec:	6a 00                	push   $0x0
  pushl $106
80106eee:	6a 6a                	push   $0x6a
  jmp alltraps
80106ef0:	e9 2d f6 ff ff       	jmp    80106522 <alltraps>

80106ef5 <vector107>:
.globl vector107
vector107:
  pushl $0
80106ef5:	6a 00                	push   $0x0
  pushl $107
80106ef7:	6a 6b                	push   $0x6b
  jmp alltraps
80106ef9:	e9 24 f6 ff ff       	jmp    80106522 <alltraps>

80106efe <vector108>:
.globl vector108
vector108:
  pushl $0
80106efe:	6a 00                	push   $0x0
  pushl $108
80106f00:	6a 6c                	push   $0x6c
  jmp alltraps
80106f02:	e9 1b f6 ff ff       	jmp    80106522 <alltraps>

80106f07 <vector109>:
.globl vector109
vector109:
  pushl $0
80106f07:	6a 00                	push   $0x0
  pushl $109
80106f09:	6a 6d                	push   $0x6d
  jmp alltraps
80106f0b:	e9 12 f6 ff ff       	jmp    80106522 <alltraps>

80106f10 <vector110>:
.globl vector110
vector110:
  pushl $0
80106f10:	6a 00                	push   $0x0
  pushl $110
80106f12:	6a 6e                	push   $0x6e
  jmp alltraps
80106f14:	e9 09 f6 ff ff       	jmp    80106522 <alltraps>

80106f19 <vector111>:
.globl vector111
vector111:
  pushl $0
80106f19:	6a 00                	push   $0x0
  pushl $111
80106f1b:	6a 6f                	push   $0x6f
  jmp alltraps
80106f1d:	e9 00 f6 ff ff       	jmp    80106522 <alltraps>

80106f22 <vector112>:
.globl vector112
vector112:
  pushl $0
80106f22:	6a 00                	push   $0x0
  pushl $112
80106f24:	6a 70                	push   $0x70
  jmp alltraps
80106f26:	e9 f7 f5 ff ff       	jmp    80106522 <alltraps>

80106f2b <vector113>:
.globl vector113
vector113:
  pushl $0
80106f2b:	6a 00                	push   $0x0
  pushl $113
80106f2d:	6a 71                	push   $0x71
  jmp alltraps
80106f2f:	e9 ee f5 ff ff       	jmp    80106522 <alltraps>

80106f34 <vector114>:
.globl vector114
vector114:
  pushl $0
80106f34:	6a 00                	push   $0x0
  pushl $114
80106f36:	6a 72                	push   $0x72
  jmp alltraps
80106f38:	e9 e5 f5 ff ff       	jmp    80106522 <alltraps>

80106f3d <vector115>:
.globl vector115
vector115:
  pushl $0
80106f3d:	6a 00                	push   $0x0
  pushl $115
80106f3f:	6a 73                	push   $0x73
  jmp alltraps
80106f41:	e9 dc f5 ff ff       	jmp    80106522 <alltraps>

80106f46 <vector116>:
.globl vector116
vector116:
  pushl $0
80106f46:	6a 00                	push   $0x0
  pushl $116
80106f48:	6a 74                	push   $0x74
  jmp alltraps
80106f4a:	e9 d3 f5 ff ff       	jmp    80106522 <alltraps>

80106f4f <vector117>:
.globl vector117
vector117:
  pushl $0
80106f4f:	6a 00                	push   $0x0
  pushl $117
80106f51:	6a 75                	push   $0x75
  jmp alltraps
80106f53:	e9 ca f5 ff ff       	jmp    80106522 <alltraps>

80106f58 <vector118>:
.globl vector118
vector118:
  pushl $0
80106f58:	6a 00                	push   $0x0
  pushl $118
80106f5a:	6a 76                	push   $0x76
  jmp alltraps
80106f5c:	e9 c1 f5 ff ff       	jmp    80106522 <alltraps>

80106f61 <vector119>:
.globl vector119
vector119:
  pushl $0
80106f61:	6a 00                	push   $0x0
  pushl $119
80106f63:	6a 77                	push   $0x77
  jmp alltraps
80106f65:	e9 b8 f5 ff ff       	jmp    80106522 <alltraps>

80106f6a <vector120>:
.globl vector120
vector120:
  pushl $0
80106f6a:	6a 00                	push   $0x0
  pushl $120
80106f6c:	6a 78                	push   $0x78
  jmp alltraps
80106f6e:	e9 af f5 ff ff       	jmp    80106522 <alltraps>

80106f73 <vector121>:
.globl vector121
vector121:
  pushl $0
80106f73:	6a 00                	push   $0x0
  pushl $121
80106f75:	6a 79                	push   $0x79
  jmp alltraps
80106f77:	e9 a6 f5 ff ff       	jmp    80106522 <alltraps>

80106f7c <vector122>:
.globl vector122
vector122:
  pushl $0
80106f7c:	6a 00                	push   $0x0
  pushl $122
80106f7e:	6a 7a                	push   $0x7a
  jmp alltraps
80106f80:	e9 9d f5 ff ff       	jmp    80106522 <alltraps>

80106f85 <vector123>:
.globl vector123
vector123:
  pushl $0
80106f85:	6a 00                	push   $0x0
  pushl $123
80106f87:	6a 7b                	push   $0x7b
  jmp alltraps
80106f89:	e9 94 f5 ff ff       	jmp    80106522 <alltraps>

80106f8e <vector124>:
.globl vector124
vector124:
  pushl $0
80106f8e:	6a 00                	push   $0x0
  pushl $124
80106f90:	6a 7c                	push   $0x7c
  jmp alltraps
80106f92:	e9 8b f5 ff ff       	jmp    80106522 <alltraps>

80106f97 <vector125>:
.globl vector125
vector125:
  pushl $0
80106f97:	6a 00                	push   $0x0
  pushl $125
80106f99:	6a 7d                	push   $0x7d
  jmp alltraps
80106f9b:	e9 82 f5 ff ff       	jmp    80106522 <alltraps>

80106fa0 <vector126>:
.globl vector126
vector126:
  pushl $0
80106fa0:	6a 00                	push   $0x0
  pushl $126
80106fa2:	6a 7e                	push   $0x7e
  jmp alltraps
80106fa4:	e9 79 f5 ff ff       	jmp    80106522 <alltraps>

80106fa9 <vector127>:
.globl vector127
vector127:
  pushl $0
80106fa9:	6a 00                	push   $0x0
  pushl $127
80106fab:	6a 7f                	push   $0x7f
  jmp alltraps
80106fad:	e9 70 f5 ff ff       	jmp    80106522 <alltraps>

80106fb2 <vector128>:
.globl vector128
vector128:
  pushl $0
80106fb2:	6a 00                	push   $0x0
  pushl $128
80106fb4:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106fb9:	e9 64 f5 ff ff       	jmp    80106522 <alltraps>

80106fbe <vector129>:
.globl vector129
vector129:
  pushl $0
80106fbe:	6a 00                	push   $0x0
  pushl $129
80106fc0:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106fc5:	e9 58 f5 ff ff       	jmp    80106522 <alltraps>

80106fca <vector130>:
.globl vector130
vector130:
  pushl $0
80106fca:	6a 00                	push   $0x0
  pushl $130
80106fcc:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106fd1:	e9 4c f5 ff ff       	jmp    80106522 <alltraps>

80106fd6 <vector131>:
.globl vector131
vector131:
  pushl $0
80106fd6:	6a 00                	push   $0x0
  pushl $131
80106fd8:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106fdd:	e9 40 f5 ff ff       	jmp    80106522 <alltraps>

80106fe2 <vector132>:
.globl vector132
vector132:
  pushl $0
80106fe2:	6a 00                	push   $0x0
  pushl $132
80106fe4:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106fe9:	e9 34 f5 ff ff       	jmp    80106522 <alltraps>

80106fee <vector133>:
.globl vector133
vector133:
  pushl $0
80106fee:	6a 00                	push   $0x0
  pushl $133
80106ff0:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106ff5:	e9 28 f5 ff ff       	jmp    80106522 <alltraps>

80106ffa <vector134>:
.globl vector134
vector134:
  pushl $0
80106ffa:	6a 00                	push   $0x0
  pushl $134
80106ffc:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107001:	e9 1c f5 ff ff       	jmp    80106522 <alltraps>

80107006 <vector135>:
.globl vector135
vector135:
  pushl $0
80107006:	6a 00                	push   $0x0
  pushl $135
80107008:	68 87 00 00 00       	push   $0x87
  jmp alltraps
8010700d:	e9 10 f5 ff ff       	jmp    80106522 <alltraps>

80107012 <vector136>:
.globl vector136
vector136:
  pushl $0
80107012:	6a 00                	push   $0x0
  pushl $136
80107014:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80107019:	e9 04 f5 ff ff       	jmp    80106522 <alltraps>

8010701e <vector137>:
.globl vector137
vector137:
  pushl $0
8010701e:	6a 00                	push   $0x0
  pushl $137
80107020:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80107025:	e9 f8 f4 ff ff       	jmp    80106522 <alltraps>

8010702a <vector138>:
.globl vector138
vector138:
  pushl $0
8010702a:	6a 00                	push   $0x0
  pushl $138
8010702c:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107031:	e9 ec f4 ff ff       	jmp    80106522 <alltraps>

80107036 <vector139>:
.globl vector139
vector139:
  pushl $0
80107036:	6a 00                	push   $0x0
  pushl $139
80107038:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
8010703d:	e9 e0 f4 ff ff       	jmp    80106522 <alltraps>

80107042 <vector140>:
.globl vector140
vector140:
  pushl $0
80107042:	6a 00                	push   $0x0
  pushl $140
80107044:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80107049:	e9 d4 f4 ff ff       	jmp    80106522 <alltraps>

8010704e <vector141>:
.globl vector141
vector141:
  pushl $0
8010704e:	6a 00                	push   $0x0
  pushl $141
80107050:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80107055:	e9 c8 f4 ff ff       	jmp    80106522 <alltraps>

8010705a <vector142>:
.globl vector142
vector142:
  pushl $0
8010705a:	6a 00                	push   $0x0
  pushl $142
8010705c:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107061:	e9 bc f4 ff ff       	jmp    80106522 <alltraps>

80107066 <vector143>:
.globl vector143
vector143:
  pushl $0
80107066:	6a 00                	push   $0x0
  pushl $143
80107068:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
8010706d:	e9 b0 f4 ff ff       	jmp    80106522 <alltraps>

80107072 <vector144>:
.globl vector144
vector144:
  pushl $0
80107072:	6a 00                	push   $0x0
  pushl $144
80107074:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80107079:	e9 a4 f4 ff ff       	jmp    80106522 <alltraps>

8010707e <vector145>:
.globl vector145
vector145:
  pushl $0
8010707e:	6a 00                	push   $0x0
  pushl $145
80107080:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80107085:	e9 98 f4 ff ff       	jmp    80106522 <alltraps>

8010708a <vector146>:
.globl vector146
vector146:
  pushl $0
8010708a:	6a 00                	push   $0x0
  pushl $146
8010708c:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107091:	e9 8c f4 ff ff       	jmp    80106522 <alltraps>

80107096 <vector147>:
.globl vector147
vector147:
  pushl $0
80107096:	6a 00                	push   $0x0
  pushl $147
80107098:	68 93 00 00 00       	push   $0x93
  jmp alltraps
8010709d:	e9 80 f4 ff ff       	jmp    80106522 <alltraps>

801070a2 <vector148>:
.globl vector148
vector148:
  pushl $0
801070a2:	6a 00                	push   $0x0
  pushl $148
801070a4:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801070a9:	e9 74 f4 ff ff       	jmp    80106522 <alltraps>

801070ae <vector149>:
.globl vector149
vector149:
  pushl $0
801070ae:	6a 00                	push   $0x0
  pushl $149
801070b0:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801070b5:	e9 68 f4 ff ff       	jmp    80106522 <alltraps>

801070ba <vector150>:
.globl vector150
vector150:
  pushl $0
801070ba:	6a 00                	push   $0x0
  pushl $150
801070bc:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801070c1:	e9 5c f4 ff ff       	jmp    80106522 <alltraps>

801070c6 <vector151>:
.globl vector151
vector151:
  pushl $0
801070c6:	6a 00                	push   $0x0
  pushl $151
801070c8:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801070cd:	e9 50 f4 ff ff       	jmp    80106522 <alltraps>

801070d2 <vector152>:
.globl vector152
vector152:
  pushl $0
801070d2:	6a 00                	push   $0x0
  pushl $152
801070d4:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801070d9:	e9 44 f4 ff ff       	jmp    80106522 <alltraps>

801070de <vector153>:
.globl vector153
vector153:
  pushl $0
801070de:	6a 00                	push   $0x0
  pushl $153
801070e0:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801070e5:	e9 38 f4 ff ff       	jmp    80106522 <alltraps>

801070ea <vector154>:
.globl vector154
vector154:
  pushl $0
801070ea:	6a 00                	push   $0x0
  pushl $154
801070ec:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801070f1:	e9 2c f4 ff ff       	jmp    80106522 <alltraps>

801070f6 <vector155>:
.globl vector155
vector155:
  pushl $0
801070f6:	6a 00                	push   $0x0
  pushl $155
801070f8:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801070fd:	e9 20 f4 ff ff       	jmp    80106522 <alltraps>

80107102 <vector156>:
.globl vector156
vector156:
  pushl $0
80107102:	6a 00                	push   $0x0
  pushl $156
80107104:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80107109:	e9 14 f4 ff ff       	jmp    80106522 <alltraps>

8010710e <vector157>:
.globl vector157
vector157:
  pushl $0
8010710e:	6a 00                	push   $0x0
  pushl $157
80107110:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80107115:	e9 08 f4 ff ff       	jmp    80106522 <alltraps>

8010711a <vector158>:
.globl vector158
vector158:
  pushl $0
8010711a:	6a 00                	push   $0x0
  pushl $158
8010711c:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107121:	e9 fc f3 ff ff       	jmp    80106522 <alltraps>

80107126 <vector159>:
.globl vector159
vector159:
  pushl $0
80107126:	6a 00                	push   $0x0
  pushl $159
80107128:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
8010712d:	e9 f0 f3 ff ff       	jmp    80106522 <alltraps>

80107132 <vector160>:
.globl vector160
vector160:
  pushl $0
80107132:	6a 00                	push   $0x0
  pushl $160
80107134:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80107139:	e9 e4 f3 ff ff       	jmp    80106522 <alltraps>

8010713e <vector161>:
.globl vector161
vector161:
  pushl $0
8010713e:	6a 00                	push   $0x0
  pushl $161
80107140:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80107145:	e9 d8 f3 ff ff       	jmp    80106522 <alltraps>

8010714a <vector162>:
.globl vector162
vector162:
  pushl $0
8010714a:	6a 00                	push   $0x0
  pushl $162
8010714c:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107151:	e9 cc f3 ff ff       	jmp    80106522 <alltraps>

80107156 <vector163>:
.globl vector163
vector163:
  pushl $0
80107156:	6a 00                	push   $0x0
  pushl $163
80107158:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
8010715d:	e9 c0 f3 ff ff       	jmp    80106522 <alltraps>

80107162 <vector164>:
.globl vector164
vector164:
  pushl $0
80107162:	6a 00                	push   $0x0
  pushl $164
80107164:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80107169:	e9 b4 f3 ff ff       	jmp    80106522 <alltraps>

8010716e <vector165>:
.globl vector165
vector165:
  pushl $0
8010716e:	6a 00                	push   $0x0
  pushl $165
80107170:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80107175:	e9 a8 f3 ff ff       	jmp    80106522 <alltraps>

8010717a <vector166>:
.globl vector166
vector166:
  pushl $0
8010717a:	6a 00                	push   $0x0
  pushl $166
8010717c:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107181:	e9 9c f3 ff ff       	jmp    80106522 <alltraps>

80107186 <vector167>:
.globl vector167
vector167:
  pushl $0
80107186:	6a 00                	push   $0x0
  pushl $167
80107188:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
8010718d:	e9 90 f3 ff ff       	jmp    80106522 <alltraps>

80107192 <vector168>:
.globl vector168
vector168:
  pushl $0
80107192:	6a 00                	push   $0x0
  pushl $168
80107194:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80107199:	e9 84 f3 ff ff       	jmp    80106522 <alltraps>

8010719e <vector169>:
.globl vector169
vector169:
  pushl $0
8010719e:	6a 00                	push   $0x0
  pushl $169
801071a0:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801071a5:	e9 78 f3 ff ff       	jmp    80106522 <alltraps>

801071aa <vector170>:
.globl vector170
vector170:
  pushl $0
801071aa:	6a 00                	push   $0x0
  pushl $170
801071ac:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801071b1:	e9 6c f3 ff ff       	jmp    80106522 <alltraps>

801071b6 <vector171>:
.globl vector171
vector171:
  pushl $0
801071b6:	6a 00                	push   $0x0
  pushl $171
801071b8:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801071bd:	e9 60 f3 ff ff       	jmp    80106522 <alltraps>

801071c2 <vector172>:
.globl vector172
vector172:
  pushl $0
801071c2:	6a 00                	push   $0x0
  pushl $172
801071c4:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801071c9:	e9 54 f3 ff ff       	jmp    80106522 <alltraps>

801071ce <vector173>:
.globl vector173
vector173:
  pushl $0
801071ce:	6a 00                	push   $0x0
  pushl $173
801071d0:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801071d5:	e9 48 f3 ff ff       	jmp    80106522 <alltraps>

801071da <vector174>:
.globl vector174
vector174:
  pushl $0
801071da:	6a 00                	push   $0x0
  pushl $174
801071dc:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801071e1:	e9 3c f3 ff ff       	jmp    80106522 <alltraps>

801071e6 <vector175>:
.globl vector175
vector175:
  pushl $0
801071e6:	6a 00                	push   $0x0
  pushl $175
801071e8:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801071ed:	e9 30 f3 ff ff       	jmp    80106522 <alltraps>

801071f2 <vector176>:
.globl vector176
vector176:
  pushl $0
801071f2:	6a 00                	push   $0x0
  pushl $176
801071f4:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801071f9:	e9 24 f3 ff ff       	jmp    80106522 <alltraps>

801071fe <vector177>:
.globl vector177
vector177:
  pushl $0
801071fe:	6a 00                	push   $0x0
  pushl $177
80107200:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80107205:	e9 18 f3 ff ff       	jmp    80106522 <alltraps>

8010720a <vector178>:
.globl vector178
vector178:
  pushl $0
8010720a:	6a 00                	push   $0x0
  pushl $178
8010720c:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107211:	e9 0c f3 ff ff       	jmp    80106522 <alltraps>

80107216 <vector179>:
.globl vector179
vector179:
  pushl $0
80107216:	6a 00                	push   $0x0
  pushl $179
80107218:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
8010721d:	e9 00 f3 ff ff       	jmp    80106522 <alltraps>

80107222 <vector180>:
.globl vector180
vector180:
  pushl $0
80107222:	6a 00                	push   $0x0
  pushl $180
80107224:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80107229:	e9 f4 f2 ff ff       	jmp    80106522 <alltraps>

8010722e <vector181>:
.globl vector181
vector181:
  pushl $0
8010722e:	6a 00                	push   $0x0
  pushl $181
80107230:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80107235:	e9 e8 f2 ff ff       	jmp    80106522 <alltraps>

8010723a <vector182>:
.globl vector182
vector182:
  pushl $0
8010723a:	6a 00                	push   $0x0
  pushl $182
8010723c:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107241:	e9 dc f2 ff ff       	jmp    80106522 <alltraps>

80107246 <vector183>:
.globl vector183
vector183:
  pushl $0
80107246:	6a 00                	push   $0x0
  pushl $183
80107248:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
8010724d:	e9 d0 f2 ff ff       	jmp    80106522 <alltraps>

80107252 <vector184>:
.globl vector184
vector184:
  pushl $0
80107252:	6a 00                	push   $0x0
  pushl $184
80107254:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80107259:	e9 c4 f2 ff ff       	jmp    80106522 <alltraps>

8010725e <vector185>:
.globl vector185
vector185:
  pushl $0
8010725e:	6a 00                	push   $0x0
  pushl $185
80107260:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80107265:	e9 b8 f2 ff ff       	jmp    80106522 <alltraps>

8010726a <vector186>:
.globl vector186
vector186:
  pushl $0
8010726a:	6a 00                	push   $0x0
  pushl $186
8010726c:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107271:	e9 ac f2 ff ff       	jmp    80106522 <alltraps>

80107276 <vector187>:
.globl vector187
vector187:
  pushl $0
80107276:	6a 00                	push   $0x0
  pushl $187
80107278:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
8010727d:	e9 a0 f2 ff ff       	jmp    80106522 <alltraps>

80107282 <vector188>:
.globl vector188
vector188:
  pushl $0
80107282:	6a 00                	push   $0x0
  pushl $188
80107284:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80107289:	e9 94 f2 ff ff       	jmp    80106522 <alltraps>

8010728e <vector189>:
.globl vector189
vector189:
  pushl $0
8010728e:	6a 00                	push   $0x0
  pushl $189
80107290:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107295:	e9 88 f2 ff ff       	jmp    80106522 <alltraps>

8010729a <vector190>:
.globl vector190
vector190:
  pushl $0
8010729a:	6a 00                	push   $0x0
  pushl $190
8010729c:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801072a1:	e9 7c f2 ff ff       	jmp    80106522 <alltraps>

801072a6 <vector191>:
.globl vector191
vector191:
  pushl $0
801072a6:	6a 00                	push   $0x0
  pushl $191
801072a8:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801072ad:	e9 70 f2 ff ff       	jmp    80106522 <alltraps>

801072b2 <vector192>:
.globl vector192
vector192:
  pushl $0
801072b2:	6a 00                	push   $0x0
  pushl $192
801072b4:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801072b9:	e9 64 f2 ff ff       	jmp    80106522 <alltraps>

801072be <vector193>:
.globl vector193
vector193:
  pushl $0
801072be:	6a 00                	push   $0x0
  pushl $193
801072c0:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801072c5:	e9 58 f2 ff ff       	jmp    80106522 <alltraps>

801072ca <vector194>:
.globl vector194
vector194:
  pushl $0
801072ca:	6a 00                	push   $0x0
  pushl $194
801072cc:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801072d1:	e9 4c f2 ff ff       	jmp    80106522 <alltraps>

801072d6 <vector195>:
.globl vector195
vector195:
  pushl $0
801072d6:	6a 00                	push   $0x0
  pushl $195
801072d8:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801072dd:	e9 40 f2 ff ff       	jmp    80106522 <alltraps>

801072e2 <vector196>:
.globl vector196
vector196:
  pushl $0
801072e2:	6a 00                	push   $0x0
  pushl $196
801072e4:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801072e9:	e9 34 f2 ff ff       	jmp    80106522 <alltraps>

801072ee <vector197>:
.globl vector197
vector197:
  pushl $0
801072ee:	6a 00                	push   $0x0
  pushl $197
801072f0:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801072f5:	e9 28 f2 ff ff       	jmp    80106522 <alltraps>

801072fa <vector198>:
.globl vector198
vector198:
  pushl $0
801072fa:	6a 00                	push   $0x0
  pushl $198
801072fc:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107301:	e9 1c f2 ff ff       	jmp    80106522 <alltraps>

80107306 <vector199>:
.globl vector199
vector199:
  pushl $0
80107306:	6a 00                	push   $0x0
  pushl $199
80107308:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
8010730d:	e9 10 f2 ff ff       	jmp    80106522 <alltraps>

80107312 <vector200>:
.globl vector200
vector200:
  pushl $0
80107312:	6a 00                	push   $0x0
  pushl $200
80107314:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80107319:	e9 04 f2 ff ff       	jmp    80106522 <alltraps>

8010731e <vector201>:
.globl vector201
vector201:
  pushl $0
8010731e:	6a 00                	push   $0x0
  pushl $201
80107320:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107325:	e9 f8 f1 ff ff       	jmp    80106522 <alltraps>

8010732a <vector202>:
.globl vector202
vector202:
  pushl $0
8010732a:	6a 00                	push   $0x0
  pushl $202
8010732c:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107331:	e9 ec f1 ff ff       	jmp    80106522 <alltraps>

80107336 <vector203>:
.globl vector203
vector203:
  pushl $0
80107336:	6a 00                	push   $0x0
  pushl $203
80107338:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
8010733d:	e9 e0 f1 ff ff       	jmp    80106522 <alltraps>

80107342 <vector204>:
.globl vector204
vector204:
  pushl $0
80107342:	6a 00                	push   $0x0
  pushl $204
80107344:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80107349:	e9 d4 f1 ff ff       	jmp    80106522 <alltraps>

8010734e <vector205>:
.globl vector205
vector205:
  pushl $0
8010734e:	6a 00                	push   $0x0
  pushl $205
80107350:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107355:	e9 c8 f1 ff ff       	jmp    80106522 <alltraps>

8010735a <vector206>:
.globl vector206
vector206:
  pushl $0
8010735a:	6a 00                	push   $0x0
  pushl $206
8010735c:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107361:	e9 bc f1 ff ff       	jmp    80106522 <alltraps>

80107366 <vector207>:
.globl vector207
vector207:
  pushl $0
80107366:	6a 00                	push   $0x0
  pushl $207
80107368:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
8010736d:	e9 b0 f1 ff ff       	jmp    80106522 <alltraps>

80107372 <vector208>:
.globl vector208
vector208:
  pushl $0
80107372:	6a 00                	push   $0x0
  pushl $208
80107374:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107379:	e9 a4 f1 ff ff       	jmp    80106522 <alltraps>

8010737e <vector209>:
.globl vector209
vector209:
  pushl $0
8010737e:	6a 00                	push   $0x0
  pushl $209
80107380:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107385:	e9 98 f1 ff ff       	jmp    80106522 <alltraps>

8010738a <vector210>:
.globl vector210
vector210:
  pushl $0
8010738a:	6a 00                	push   $0x0
  pushl $210
8010738c:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107391:	e9 8c f1 ff ff       	jmp    80106522 <alltraps>

80107396 <vector211>:
.globl vector211
vector211:
  pushl $0
80107396:	6a 00                	push   $0x0
  pushl $211
80107398:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
8010739d:	e9 80 f1 ff ff       	jmp    80106522 <alltraps>

801073a2 <vector212>:
.globl vector212
vector212:
  pushl $0
801073a2:	6a 00                	push   $0x0
  pushl $212
801073a4:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801073a9:	e9 74 f1 ff ff       	jmp    80106522 <alltraps>

801073ae <vector213>:
.globl vector213
vector213:
  pushl $0
801073ae:	6a 00                	push   $0x0
  pushl $213
801073b0:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801073b5:	e9 68 f1 ff ff       	jmp    80106522 <alltraps>

801073ba <vector214>:
.globl vector214
vector214:
  pushl $0
801073ba:	6a 00                	push   $0x0
  pushl $214
801073bc:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801073c1:	e9 5c f1 ff ff       	jmp    80106522 <alltraps>

801073c6 <vector215>:
.globl vector215
vector215:
  pushl $0
801073c6:	6a 00                	push   $0x0
  pushl $215
801073c8:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801073cd:	e9 50 f1 ff ff       	jmp    80106522 <alltraps>

801073d2 <vector216>:
.globl vector216
vector216:
  pushl $0
801073d2:	6a 00                	push   $0x0
  pushl $216
801073d4:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801073d9:	e9 44 f1 ff ff       	jmp    80106522 <alltraps>

801073de <vector217>:
.globl vector217
vector217:
  pushl $0
801073de:	6a 00                	push   $0x0
  pushl $217
801073e0:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801073e5:	e9 38 f1 ff ff       	jmp    80106522 <alltraps>

801073ea <vector218>:
.globl vector218
vector218:
  pushl $0
801073ea:	6a 00                	push   $0x0
  pushl $218
801073ec:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801073f1:	e9 2c f1 ff ff       	jmp    80106522 <alltraps>

801073f6 <vector219>:
.globl vector219
vector219:
  pushl $0
801073f6:	6a 00                	push   $0x0
  pushl $219
801073f8:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801073fd:	e9 20 f1 ff ff       	jmp    80106522 <alltraps>

80107402 <vector220>:
.globl vector220
vector220:
  pushl $0
80107402:	6a 00                	push   $0x0
  pushl $220
80107404:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107409:	e9 14 f1 ff ff       	jmp    80106522 <alltraps>

8010740e <vector221>:
.globl vector221
vector221:
  pushl $0
8010740e:	6a 00                	push   $0x0
  pushl $221
80107410:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107415:	e9 08 f1 ff ff       	jmp    80106522 <alltraps>

8010741a <vector222>:
.globl vector222
vector222:
  pushl $0
8010741a:	6a 00                	push   $0x0
  pushl $222
8010741c:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107421:	e9 fc f0 ff ff       	jmp    80106522 <alltraps>

80107426 <vector223>:
.globl vector223
vector223:
  pushl $0
80107426:	6a 00                	push   $0x0
  pushl $223
80107428:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
8010742d:	e9 f0 f0 ff ff       	jmp    80106522 <alltraps>

80107432 <vector224>:
.globl vector224
vector224:
  pushl $0
80107432:	6a 00                	push   $0x0
  pushl $224
80107434:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80107439:	e9 e4 f0 ff ff       	jmp    80106522 <alltraps>

8010743e <vector225>:
.globl vector225
vector225:
  pushl $0
8010743e:	6a 00                	push   $0x0
  pushl $225
80107440:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107445:	e9 d8 f0 ff ff       	jmp    80106522 <alltraps>

8010744a <vector226>:
.globl vector226
vector226:
  pushl $0
8010744a:	6a 00                	push   $0x0
  pushl $226
8010744c:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107451:	e9 cc f0 ff ff       	jmp    80106522 <alltraps>

80107456 <vector227>:
.globl vector227
vector227:
  pushl $0
80107456:	6a 00                	push   $0x0
  pushl $227
80107458:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
8010745d:	e9 c0 f0 ff ff       	jmp    80106522 <alltraps>

80107462 <vector228>:
.globl vector228
vector228:
  pushl $0
80107462:	6a 00                	push   $0x0
  pushl $228
80107464:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107469:	e9 b4 f0 ff ff       	jmp    80106522 <alltraps>

8010746e <vector229>:
.globl vector229
vector229:
  pushl $0
8010746e:	6a 00                	push   $0x0
  pushl $229
80107470:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107475:	e9 a8 f0 ff ff       	jmp    80106522 <alltraps>

8010747a <vector230>:
.globl vector230
vector230:
  pushl $0
8010747a:	6a 00                	push   $0x0
  pushl $230
8010747c:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107481:	e9 9c f0 ff ff       	jmp    80106522 <alltraps>

80107486 <vector231>:
.globl vector231
vector231:
  pushl $0
80107486:	6a 00                	push   $0x0
  pushl $231
80107488:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
8010748d:	e9 90 f0 ff ff       	jmp    80106522 <alltraps>

80107492 <vector232>:
.globl vector232
vector232:
  pushl $0
80107492:	6a 00                	push   $0x0
  pushl $232
80107494:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107499:	e9 84 f0 ff ff       	jmp    80106522 <alltraps>

8010749e <vector233>:
.globl vector233
vector233:
  pushl $0
8010749e:	6a 00                	push   $0x0
  pushl $233
801074a0:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801074a5:	e9 78 f0 ff ff       	jmp    80106522 <alltraps>

801074aa <vector234>:
.globl vector234
vector234:
  pushl $0
801074aa:	6a 00                	push   $0x0
  pushl $234
801074ac:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801074b1:	e9 6c f0 ff ff       	jmp    80106522 <alltraps>

801074b6 <vector235>:
.globl vector235
vector235:
  pushl $0
801074b6:	6a 00                	push   $0x0
  pushl $235
801074b8:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801074bd:	e9 60 f0 ff ff       	jmp    80106522 <alltraps>

801074c2 <vector236>:
.globl vector236
vector236:
  pushl $0
801074c2:	6a 00                	push   $0x0
  pushl $236
801074c4:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801074c9:	e9 54 f0 ff ff       	jmp    80106522 <alltraps>

801074ce <vector237>:
.globl vector237
vector237:
  pushl $0
801074ce:	6a 00                	push   $0x0
  pushl $237
801074d0:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801074d5:	e9 48 f0 ff ff       	jmp    80106522 <alltraps>

801074da <vector238>:
.globl vector238
vector238:
  pushl $0
801074da:	6a 00                	push   $0x0
  pushl $238
801074dc:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801074e1:	e9 3c f0 ff ff       	jmp    80106522 <alltraps>

801074e6 <vector239>:
.globl vector239
vector239:
  pushl $0
801074e6:	6a 00                	push   $0x0
  pushl $239
801074e8:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801074ed:	e9 30 f0 ff ff       	jmp    80106522 <alltraps>

801074f2 <vector240>:
.globl vector240
vector240:
  pushl $0
801074f2:	6a 00                	push   $0x0
  pushl $240
801074f4:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801074f9:	e9 24 f0 ff ff       	jmp    80106522 <alltraps>

801074fe <vector241>:
.globl vector241
vector241:
  pushl $0
801074fe:	6a 00                	push   $0x0
  pushl $241
80107500:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107505:	e9 18 f0 ff ff       	jmp    80106522 <alltraps>

8010750a <vector242>:
.globl vector242
vector242:
  pushl $0
8010750a:	6a 00                	push   $0x0
  pushl $242
8010750c:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107511:	e9 0c f0 ff ff       	jmp    80106522 <alltraps>

80107516 <vector243>:
.globl vector243
vector243:
  pushl $0
80107516:	6a 00                	push   $0x0
  pushl $243
80107518:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
8010751d:	e9 00 f0 ff ff       	jmp    80106522 <alltraps>

80107522 <vector244>:
.globl vector244
vector244:
  pushl $0
80107522:	6a 00                	push   $0x0
  pushl $244
80107524:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107529:	e9 f4 ef ff ff       	jmp    80106522 <alltraps>

8010752e <vector245>:
.globl vector245
vector245:
  pushl $0
8010752e:	6a 00                	push   $0x0
  pushl $245
80107530:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107535:	e9 e8 ef ff ff       	jmp    80106522 <alltraps>

8010753a <vector246>:
.globl vector246
vector246:
  pushl $0
8010753a:	6a 00                	push   $0x0
  pushl $246
8010753c:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107541:	e9 dc ef ff ff       	jmp    80106522 <alltraps>

80107546 <vector247>:
.globl vector247
vector247:
  pushl $0
80107546:	6a 00                	push   $0x0
  pushl $247
80107548:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
8010754d:	e9 d0 ef ff ff       	jmp    80106522 <alltraps>

80107552 <vector248>:
.globl vector248
vector248:
  pushl $0
80107552:	6a 00                	push   $0x0
  pushl $248
80107554:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107559:	e9 c4 ef ff ff       	jmp    80106522 <alltraps>

8010755e <vector249>:
.globl vector249
vector249:
  pushl $0
8010755e:	6a 00                	push   $0x0
  pushl $249
80107560:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107565:	e9 b8 ef ff ff       	jmp    80106522 <alltraps>

8010756a <vector250>:
.globl vector250
vector250:
  pushl $0
8010756a:	6a 00                	push   $0x0
  pushl $250
8010756c:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107571:	e9 ac ef ff ff       	jmp    80106522 <alltraps>

80107576 <vector251>:
.globl vector251
vector251:
  pushl $0
80107576:	6a 00                	push   $0x0
  pushl $251
80107578:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
8010757d:	e9 a0 ef ff ff       	jmp    80106522 <alltraps>

80107582 <vector252>:
.globl vector252
vector252:
  pushl $0
80107582:	6a 00                	push   $0x0
  pushl $252
80107584:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107589:	e9 94 ef ff ff       	jmp    80106522 <alltraps>

8010758e <vector253>:
.globl vector253
vector253:
  pushl $0
8010758e:	6a 00                	push   $0x0
  pushl $253
80107590:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107595:	e9 88 ef ff ff       	jmp    80106522 <alltraps>

8010759a <vector254>:
.globl vector254
vector254:
  pushl $0
8010759a:	6a 00                	push   $0x0
  pushl $254
8010759c:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801075a1:	e9 7c ef ff ff       	jmp    80106522 <alltraps>

801075a6 <vector255>:
.globl vector255
vector255:
  pushl $0
801075a6:	6a 00                	push   $0x0
  pushl $255
801075a8:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801075ad:	e9 70 ef ff ff       	jmp    80106522 <alltraps>

801075b2 <lgdt>:

struct segdesc;

static inline void
lgdt(struct segdesc *p, int size)
{
801075b2:	55                   	push   %ebp
801075b3:	89 e5                	mov    %esp,%ebp
801075b5:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
801075b8:	8b 45 0c             	mov    0xc(%ebp),%eax
801075bb:	48                   	dec    %eax
801075bc:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801075c0:	8b 45 08             	mov    0x8(%ebp),%eax
801075c3:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801075c7:	8b 45 08             	mov    0x8(%ebp),%eax
801075ca:	c1 e8 10             	shr    $0x10,%eax
801075cd:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
801075d1:	8d 45 fa             	lea    -0x6(%ebp),%eax
801075d4:	0f 01 10             	lgdtl  (%eax)
}
801075d7:	c9                   	leave  
801075d8:	c3                   	ret    

801075d9 <ltr>:
  asm volatile("lidt (%0)" : : "r" (pd));
}

static inline void
ltr(ushort sel)
{
801075d9:	55                   	push   %ebp
801075da:	89 e5                	mov    %esp,%ebp
801075dc:	83 ec 04             	sub    $0x4,%esp
801075df:	8b 45 08             	mov    0x8(%ebp),%eax
801075e2:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
801075e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
801075e9:	0f 00 d8             	ltr    %ax
}
801075ec:	c9                   	leave  
801075ed:	c3                   	ret    

801075ee <loadgs>:
  return eflags;
}

static inline void
loadgs(ushort v)
{
801075ee:	55                   	push   %ebp
801075ef:	89 e5                	mov    %esp,%ebp
801075f1:	83 ec 04             	sub    $0x4,%esp
801075f4:	8b 45 08             	mov    0x8(%ebp),%eax
801075f7:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
801075fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
801075fe:	8e e8                	mov    %eax,%gs
}
80107600:	c9                   	leave  
80107601:	c3                   	ret    

80107602 <lcr3>:
  return val;
}

static inline void
lcr3(uint val) 
{
80107602:	55                   	push   %ebp
80107603:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107605:	8b 45 08             	mov    0x8(%ebp),%eax
80107608:	0f 22 d8             	mov    %eax,%cr3
}
8010760b:	5d                   	pop    %ebp
8010760c:	c3                   	ret    

8010760d <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
8010760d:	55                   	push   %ebp
8010760e:	89 e5                	mov    %esp,%ebp
80107610:	8b 45 08             	mov    0x8(%ebp),%eax
80107613:	05 00 00 00 80       	add    $0x80000000,%eax
80107618:	5d                   	pop    %ebp
80107619:	c3                   	ret    

8010761a <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
8010761a:	55                   	push   %ebp
8010761b:	89 e5                	mov    %esp,%ebp
8010761d:	8b 45 08             	mov    0x8(%ebp),%eax
80107620:	05 00 00 00 80       	add    $0x80000000,%eax
80107625:	5d                   	pop    %ebp
80107626:	c3                   	ret    

80107627 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80107627:	55                   	push   %ebp
80107628:	89 e5                	mov    %esp,%ebp
8010762a:	53                   	push   %ebx
8010762b:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
8010762e:	e8 d1 b8 ff ff       	call   80102f04 <cpunum>
80107633:	89 c2                	mov    %eax,%edx
80107635:	89 d0                	mov    %edx,%eax
80107637:	c1 e0 02             	shl    $0x2,%eax
8010763a:	01 d0                	add    %edx,%eax
8010763c:	01 c0                	add    %eax,%eax
8010763e:	01 d0                	add    %edx,%eax
80107640:	89 c1                	mov    %eax,%ecx
80107642:	c1 e1 04             	shl    $0x4,%ecx
80107645:	01 c8                	add    %ecx,%eax
80107647:	01 d0                	add    %edx,%eax
80107649:	05 60 23 11 80       	add    $0x80112360,%eax
8010764e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107651:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107654:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
8010765a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010765d:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
80107663:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107666:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
8010766a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010766d:	8a 50 7d             	mov    0x7d(%eax),%dl
80107670:	83 e2 f0             	and    $0xfffffff0,%edx
80107673:	83 ca 0a             	or     $0xa,%edx
80107676:	88 50 7d             	mov    %dl,0x7d(%eax)
80107679:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010767c:	8a 50 7d             	mov    0x7d(%eax),%dl
8010767f:	83 ca 10             	or     $0x10,%edx
80107682:	88 50 7d             	mov    %dl,0x7d(%eax)
80107685:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107688:	8a 50 7d             	mov    0x7d(%eax),%dl
8010768b:	83 e2 9f             	and    $0xffffff9f,%edx
8010768e:	88 50 7d             	mov    %dl,0x7d(%eax)
80107691:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107694:	8a 50 7d             	mov    0x7d(%eax),%dl
80107697:	83 ca 80             	or     $0xffffff80,%edx
8010769a:	88 50 7d             	mov    %dl,0x7d(%eax)
8010769d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076a0:	8a 50 7e             	mov    0x7e(%eax),%dl
801076a3:	83 ca 0f             	or     $0xf,%edx
801076a6:	88 50 7e             	mov    %dl,0x7e(%eax)
801076a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076ac:	8a 50 7e             	mov    0x7e(%eax),%dl
801076af:	83 e2 ef             	and    $0xffffffef,%edx
801076b2:	88 50 7e             	mov    %dl,0x7e(%eax)
801076b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076b8:	8a 50 7e             	mov    0x7e(%eax),%dl
801076bb:	83 e2 df             	and    $0xffffffdf,%edx
801076be:	88 50 7e             	mov    %dl,0x7e(%eax)
801076c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076c4:	8a 50 7e             	mov    0x7e(%eax),%dl
801076c7:	83 ca 40             	or     $0x40,%edx
801076ca:	88 50 7e             	mov    %dl,0x7e(%eax)
801076cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076d0:	8a 50 7e             	mov    0x7e(%eax),%dl
801076d3:	83 ca 80             	or     $0xffffff80,%edx
801076d6:	88 50 7e             	mov    %dl,0x7e(%eax)
801076d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076dc:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801076e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076e3:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
801076ea:	ff ff 
801076ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076ef:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
801076f6:	00 00 
801076f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076fb:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80107702:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107705:	8a 90 85 00 00 00    	mov    0x85(%eax),%dl
8010770b:	83 e2 f0             	and    $0xfffffff0,%edx
8010770e:	83 ca 02             	or     $0x2,%edx
80107711:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107717:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010771a:	8a 90 85 00 00 00    	mov    0x85(%eax),%dl
80107720:	83 ca 10             	or     $0x10,%edx
80107723:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107729:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010772c:	8a 90 85 00 00 00    	mov    0x85(%eax),%dl
80107732:	83 e2 9f             	and    $0xffffff9f,%edx
80107735:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010773b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010773e:	8a 90 85 00 00 00    	mov    0x85(%eax),%dl
80107744:	83 ca 80             	or     $0xffffff80,%edx
80107747:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010774d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107750:	8a 90 86 00 00 00    	mov    0x86(%eax),%dl
80107756:	83 ca 0f             	or     $0xf,%edx
80107759:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010775f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107762:	8a 90 86 00 00 00    	mov    0x86(%eax),%dl
80107768:	83 e2 ef             	and    $0xffffffef,%edx
8010776b:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107771:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107774:	8a 90 86 00 00 00    	mov    0x86(%eax),%dl
8010777a:	83 e2 df             	and    $0xffffffdf,%edx
8010777d:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107783:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107786:	8a 90 86 00 00 00    	mov    0x86(%eax),%dl
8010778c:	83 ca 40             	or     $0x40,%edx
8010778f:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107795:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107798:	8a 90 86 00 00 00    	mov    0x86(%eax),%dl
8010779e:	83 ca 80             	or     $0xffffff80,%edx
801077a1:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801077a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077aa:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801077b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077b4:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
801077bb:	ff ff 
801077bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077c0:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
801077c7:	00 00 
801077c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077cc:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
801077d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077d6:	8a 90 95 00 00 00    	mov    0x95(%eax),%dl
801077dc:	83 e2 f0             	and    $0xfffffff0,%edx
801077df:	83 ca 0a             	or     $0xa,%edx
801077e2:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801077e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077eb:	8a 90 95 00 00 00    	mov    0x95(%eax),%dl
801077f1:	83 ca 10             	or     $0x10,%edx
801077f4:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801077fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077fd:	8a 90 95 00 00 00    	mov    0x95(%eax),%dl
80107803:	83 ca 60             	or     $0x60,%edx
80107806:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010780c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010780f:	8a 90 95 00 00 00    	mov    0x95(%eax),%dl
80107815:	83 ca 80             	or     $0xffffff80,%edx
80107818:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010781e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107821:	8a 90 96 00 00 00    	mov    0x96(%eax),%dl
80107827:	83 ca 0f             	or     $0xf,%edx
8010782a:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107830:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107833:	8a 90 96 00 00 00    	mov    0x96(%eax),%dl
80107839:	83 e2 ef             	and    $0xffffffef,%edx
8010783c:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107842:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107845:	8a 90 96 00 00 00    	mov    0x96(%eax),%dl
8010784b:	83 e2 df             	and    $0xffffffdf,%edx
8010784e:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107854:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107857:	8a 90 96 00 00 00    	mov    0x96(%eax),%dl
8010785d:	83 ca 40             	or     $0x40,%edx
80107860:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107866:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107869:	8a 90 96 00 00 00    	mov    0x96(%eax),%dl
8010786f:	83 ca 80             	or     $0xffffff80,%edx
80107872:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107878:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010787b:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107882:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107885:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
8010788c:	ff ff 
8010788e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107891:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
80107898:	00 00 
8010789a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010789d:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
801078a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078a7:	8a 90 9d 00 00 00    	mov    0x9d(%eax),%dl
801078ad:	83 e2 f0             	and    $0xfffffff0,%edx
801078b0:	83 ca 02             	or     $0x2,%edx
801078b3:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
801078b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078bc:	8a 90 9d 00 00 00    	mov    0x9d(%eax),%dl
801078c2:	83 ca 10             	or     $0x10,%edx
801078c5:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
801078cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078ce:	8a 90 9d 00 00 00    	mov    0x9d(%eax),%dl
801078d4:	83 ca 60             	or     $0x60,%edx
801078d7:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
801078dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078e0:	8a 90 9d 00 00 00    	mov    0x9d(%eax),%dl
801078e6:	83 ca 80             	or     $0xffffff80,%edx
801078e9:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
801078ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078f2:	8a 90 9e 00 00 00    	mov    0x9e(%eax),%dl
801078f8:	83 ca 0f             	or     $0xf,%edx
801078fb:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107901:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107904:	8a 90 9e 00 00 00    	mov    0x9e(%eax),%dl
8010790a:	83 e2 ef             	and    $0xffffffef,%edx
8010790d:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107913:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107916:	8a 90 9e 00 00 00    	mov    0x9e(%eax),%dl
8010791c:	83 e2 df             	and    $0xffffffdf,%edx
8010791f:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107925:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107928:	8a 90 9e 00 00 00    	mov    0x9e(%eax),%dl
8010792e:	83 ca 40             	or     $0x40,%edx
80107931:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107937:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010793a:	8a 90 9e 00 00 00    	mov    0x9e(%eax),%dl
80107940:	83 ca 80             	or     $0xffffff80,%edx
80107943:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107949:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010794c:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80107953:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107956:	05 b4 00 00 00       	add    $0xb4,%eax
8010795b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010795e:	81 c2 b4 00 00 00    	add    $0xb4,%edx
80107964:	c1 ea 10             	shr    $0x10,%edx
80107967:	88 d1                	mov    %dl,%cl
80107969:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010796c:	81 c2 b4 00 00 00    	add    $0xb4,%edx
80107972:	c1 ea 18             	shr    $0x18,%edx
80107975:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107978:	66 c7 83 88 00 00 00 	movw   $0x0,0x88(%ebx)
8010797f:	00 00 
80107981:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107984:	66 89 83 8a 00 00 00 	mov    %ax,0x8a(%ebx)
8010798b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010798e:	88 88 8c 00 00 00    	mov    %cl,0x8c(%eax)
80107994:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107997:	8a 88 8d 00 00 00    	mov    0x8d(%eax),%cl
8010799d:	83 e1 f0             	and    $0xfffffff0,%ecx
801079a0:	83 c9 02             	or     $0x2,%ecx
801079a3:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
801079a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079ac:	8a 88 8d 00 00 00    	mov    0x8d(%eax),%cl
801079b2:	83 c9 10             	or     $0x10,%ecx
801079b5:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
801079bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079be:	8a 88 8d 00 00 00    	mov    0x8d(%eax),%cl
801079c4:	83 e1 9f             	and    $0xffffff9f,%ecx
801079c7:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
801079cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079d0:	8a 88 8d 00 00 00    	mov    0x8d(%eax),%cl
801079d6:	83 c9 80             	or     $0xffffff80,%ecx
801079d9:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
801079df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079e2:	8a 88 8e 00 00 00    	mov    0x8e(%eax),%cl
801079e8:	83 e1 f0             	and    $0xfffffff0,%ecx
801079eb:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
801079f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079f4:	8a 88 8e 00 00 00    	mov    0x8e(%eax),%cl
801079fa:	83 e1 ef             	and    $0xffffffef,%ecx
801079fd:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107a03:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a06:	8a 88 8e 00 00 00    	mov    0x8e(%eax),%cl
80107a0c:	83 e1 df             	and    $0xffffffdf,%ecx
80107a0f:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107a15:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a18:	8a 88 8e 00 00 00    	mov    0x8e(%eax),%cl
80107a1e:	83 c9 40             	or     $0x40,%ecx
80107a21:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107a27:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a2a:	8a 88 8e 00 00 00    	mov    0x8e(%eax),%cl
80107a30:	83 c9 80             	or     $0xffffff80,%ecx
80107a33:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107a39:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a3c:	88 90 8f 00 00 00    	mov    %dl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
80107a42:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a45:	83 c0 70             	add    $0x70,%eax
80107a48:	83 ec 08             	sub    $0x8,%esp
80107a4b:	6a 38                	push   $0x38
80107a4d:	50                   	push   %eax
80107a4e:	e8 5f fb ff ff       	call   801075b2 <lgdt>
80107a53:	83 c4 10             	add    $0x10,%esp
  loadgs(SEG_KCPU << 3);
80107a56:	83 ec 0c             	sub    $0xc,%esp
80107a59:	6a 18                	push   $0x18
80107a5b:	e8 8e fb ff ff       	call   801075ee <loadgs>
80107a60:	83 c4 10             	add    $0x10,%esp
  
  // Initialize cpu-local storage.
  cpu = c;
80107a63:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a66:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
80107a6c:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80107a73:	00 00 00 00 
}
80107a77:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107a7a:	c9                   	leave  
80107a7b:	c3                   	ret    

80107a7c <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107a7c:	55                   	push   %ebp
80107a7d:	89 e5                	mov    %esp,%ebp
80107a7f:	83 ec 18             	sub    $0x18,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107a82:	8b 45 0c             	mov    0xc(%ebp),%eax
80107a85:	c1 e8 16             	shr    $0x16,%eax
80107a88:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107a8f:	8b 45 08             	mov    0x8(%ebp),%eax
80107a92:	01 d0                	add    %edx,%eax
80107a94:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80107a97:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107a9a:	8b 00                	mov    (%eax),%eax
80107a9c:	83 e0 01             	and    $0x1,%eax
80107a9f:	85 c0                	test   %eax,%eax
80107aa1:	74 18                	je     80107abb <walkpgdir+0x3f>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
80107aa3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107aa6:	8b 00                	mov    (%eax),%eax
80107aa8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107aad:	50                   	push   %eax
80107aae:	e8 67 fb ff ff       	call   8010761a <p2v>
80107ab3:	83 c4 04             	add    $0x4,%esp
80107ab6:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107ab9:	eb 48                	jmp    80107b03 <walkpgdir+0x87>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107abb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107abf:	74 0e                	je     80107acf <walkpgdir+0x53>
80107ac1:	e8 e7 b0 ff ff       	call   80102bad <kalloc>
80107ac6:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107ac9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107acd:	75 07                	jne    80107ad6 <walkpgdir+0x5a>
      return 0;
80107acf:	b8 00 00 00 00       	mov    $0x0,%eax
80107ad4:	eb 44                	jmp    80107b1a <walkpgdir+0x9e>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107ad6:	83 ec 04             	sub    $0x4,%esp
80107ad9:	68 00 10 00 00       	push   $0x1000
80107ade:	6a 00                	push   $0x0
80107ae0:	ff 75 f4             	pushl  -0xc(%ebp)
80107ae3:	e8 b8 d6 ff ff       	call   801051a0 <memset>
80107ae8:	83 c4 10             	add    $0x10,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
80107aeb:	83 ec 0c             	sub    $0xc,%esp
80107aee:	ff 75 f4             	pushl  -0xc(%ebp)
80107af1:	e8 17 fb ff ff       	call   8010760d <v2p>
80107af6:	83 c4 10             	add    $0x10,%esp
80107af9:	83 c8 07             	or     $0x7,%eax
80107afc:	89 c2                	mov    %eax,%edx
80107afe:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107b01:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80107b03:	8b 45 0c             	mov    0xc(%ebp),%eax
80107b06:	c1 e8 0c             	shr    $0xc,%eax
80107b09:	25 ff 03 00 00       	and    $0x3ff,%eax
80107b0e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107b15:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b18:	01 d0                	add    %edx,%eax
}
80107b1a:	c9                   	leave  
80107b1b:	c3                   	ret    

80107b1c <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107b1c:	55                   	push   %ebp
80107b1d:	89 e5                	mov    %esp,%ebp
80107b1f:	83 ec 18             	sub    $0x18,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
80107b22:	8b 45 0c             	mov    0xc(%ebp),%eax
80107b25:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107b2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107b2d:	8b 55 0c             	mov    0xc(%ebp),%edx
80107b30:	8b 45 10             	mov    0x10(%ebp),%eax
80107b33:	01 d0                	add    %edx,%eax
80107b35:	48                   	dec    %eax
80107b36:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107b3b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107b3e:	83 ec 04             	sub    $0x4,%esp
80107b41:	6a 01                	push   $0x1
80107b43:	ff 75 f4             	pushl  -0xc(%ebp)
80107b46:	ff 75 08             	pushl  0x8(%ebp)
80107b49:	e8 2e ff ff ff       	call   80107a7c <walkpgdir>
80107b4e:	83 c4 10             	add    $0x10,%esp
80107b51:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107b54:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107b58:	75 07                	jne    80107b61 <mappages+0x45>
      return -1;
80107b5a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107b5f:	eb 49                	jmp    80107baa <mappages+0x8e>
    if(*pte & PTE_P)
80107b61:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107b64:	8b 00                	mov    (%eax),%eax
80107b66:	83 e0 01             	and    $0x1,%eax
80107b69:	85 c0                	test   %eax,%eax
80107b6b:	74 0d                	je     80107b7a <mappages+0x5e>
      panic("remap");
80107b6d:	83 ec 0c             	sub    $0xc,%esp
80107b70:	68 b8 89 10 80       	push   $0x801089b8
80107b75:	e8 d4 89 ff ff       	call   8010054e <panic>
    *pte = pa | perm | PTE_P;
80107b7a:	8b 45 18             	mov    0x18(%ebp),%eax
80107b7d:	0b 45 14             	or     0x14(%ebp),%eax
80107b80:	83 c8 01             	or     $0x1,%eax
80107b83:	89 c2                	mov    %eax,%edx
80107b85:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107b88:	89 10                	mov    %edx,(%eax)
    if(a == last)
80107b8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b8d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107b90:	75 08                	jne    80107b9a <mappages+0x7e>
      break;
80107b92:	90                   	nop
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80107b93:	b8 00 00 00 00       	mov    $0x0,%eax
80107b98:	eb 10                	jmp    80107baa <mappages+0x8e>
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
    a += PGSIZE;
80107b9a:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
80107ba1:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  }
80107ba8:	eb 94                	jmp    80107b3e <mappages+0x22>
  return 0;
}
80107baa:	c9                   	leave  
80107bab:	c3                   	ret    

80107bac <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80107bac:	55                   	push   %ebp
80107bad:	89 e5                	mov    %esp,%ebp
80107baf:	53                   	push   %ebx
80107bb0:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107bb3:	e8 f5 af ff ff       	call   80102bad <kalloc>
80107bb8:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107bbb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107bbf:	75 0a                	jne    80107bcb <setupkvm+0x1f>
    return 0;
80107bc1:	b8 00 00 00 00       	mov    $0x0,%eax
80107bc6:	e9 8e 00 00 00       	jmp    80107c59 <setupkvm+0xad>
  memset(pgdir, 0, PGSIZE);
80107bcb:	83 ec 04             	sub    $0x4,%esp
80107bce:	68 00 10 00 00       	push   $0x1000
80107bd3:	6a 00                	push   $0x0
80107bd5:	ff 75 f0             	pushl  -0x10(%ebp)
80107bd8:	e8 c3 d5 ff ff       	call   801051a0 <memset>
80107bdd:	83 c4 10             	add    $0x10,%esp
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
80107be0:	83 ec 0c             	sub    $0xc,%esp
80107be3:	68 00 00 00 0e       	push   $0xe000000
80107be8:	e8 2d fa ff ff       	call   8010761a <p2v>
80107bed:	83 c4 10             	add    $0x10,%esp
80107bf0:	3d 00 00 00 fe       	cmp    $0xfe000000,%eax
80107bf5:	76 0d                	jbe    80107c04 <setupkvm+0x58>
    panic("PHYSTOP too high");
80107bf7:	83 ec 0c             	sub    $0xc,%esp
80107bfa:	68 be 89 10 80       	push   $0x801089be
80107bff:	e8 4a 89 ff ff       	call   8010054e <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107c04:	c7 45 f4 a0 b4 10 80 	movl   $0x8010b4a0,-0xc(%ebp)
80107c0b:	eb 40                	jmp    80107c4d <setupkvm+0xa1>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107c0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c10:	8b 48 0c             	mov    0xc(%eax),%ecx
80107c13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c16:	8b 50 04             	mov    0x4(%eax),%edx
80107c19:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c1c:	8b 58 08             	mov    0x8(%eax),%ebx
80107c1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c22:	8b 40 04             	mov    0x4(%eax),%eax
80107c25:	29 c3                	sub    %eax,%ebx
80107c27:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c2a:	8b 00                	mov    (%eax),%eax
80107c2c:	83 ec 0c             	sub    $0xc,%esp
80107c2f:	51                   	push   %ecx
80107c30:	52                   	push   %edx
80107c31:	53                   	push   %ebx
80107c32:	50                   	push   %eax
80107c33:	ff 75 f0             	pushl  -0x10(%ebp)
80107c36:	e8 e1 fe ff ff       	call   80107b1c <mappages>
80107c3b:	83 c4 20             	add    $0x20,%esp
80107c3e:	85 c0                	test   %eax,%eax
80107c40:	79 07                	jns    80107c49 <setupkvm+0x9d>
                (uint)k->phys_start, k->perm) < 0)
      return 0;
80107c42:	b8 00 00 00 00       	mov    $0x0,%eax
80107c47:	eb 10                	jmp    80107c59 <setupkvm+0xad>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107c49:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80107c4d:	81 7d f4 e0 b4 10 80 	cmpl   $0x8010b4e0,-0xc(%ebp)
80107c54:	72 b7                	jb     80107c0d <setupkvm+0x61>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
80107c56:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80107c59:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107c5c:	c9                   	leave  
80107c5d:	c3                   	ret    

80107c5e <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107c5e:	55                   	push   %ebp
80107c5f:	89 e5                	mov    %esp,%ebp
80107c61:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107c64:	e8 43 ff ff ff       	call   80107bac <setupkvm>
80107c69:	a3 38 51 11 80       	mov    %eax,0x80115138
  switchkvm();
80107c6e:	e8 02 00 00 00       	call   80107c75 <switchkvm>
}
80107c73:	c9                   	leave  
80107c74:	c3                   	ret    

80107c75 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107c75:	55                   	push   %ebp
80107c76:	89 e5                	mov    %esp,%ebp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
80107c78:	a1 38 51 11 80       	mov    0x80115138,%eax
80107c7d:	50                   	push   %eax
80107c7e:	e8 8a f9 ff ff       	call   8010760d <v2p>
80107c83:	83 c4 04             	add    $0x4,%esp
80107c86:	50                   	push   %eax
80107c87:	e8 76 f9 ff ff       	call   80107602 <lcr3>
80107c8c:	83 c4 04             	add    $0x4,%esp
}
80107c8f:	c9                   	leave  
80107c90:	c3                   	ret    

80107c91 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107c91:	55                   	push   %ebp
80107c92:	89 e5                	mov    %esp,%ebp
80107c94:	53                   	push   %ebx
80107c95:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80107c98:	e8 03 d4 ff ff       	call   801050a0 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80107c9d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107ca3:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107caa:	83 c2 08             	add    $0x8,%edx
80107cad:	65 8b 0d 00 00 00 00 	mov    %gs:0x0,%ecx
80107cb4:	83 c1 08             	add    $0x8,%ecx
80107cb7:	c1 e9 10             	shr    $0x10,%ecx
80107cba:	88 cb                	mov    %cl,%bl
80107cbc:	65 8b 0d 00 00 00 00 	mov    %gs:0x0,%ecx
80107cc3:	83 c1 08             	add    $0x8,%ecx
80107cc6:	c1 e9 18             	shr    $0x18,%ecx
80107cc9:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80107cd0:	67 00 
80107cd2:	66 89 90 a2 00 00 00 	mov    %dx,0xa2(%eax)
80107cd9:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
80107cdf:	8a 90 a5 00 00 00    	mov    0xa5(%eax),%dl
80107ce5:	83 e2 f0             	and    $0xfffffff0,%edx
80107ce8:	83 ca 09             	or     $0x9,%edx
80107ceb:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107cf1:	8a 90 a5 00 00 00    	mov    0xa5(%eax),%dl
80107cf7:	83 ca 10             	or     $0x10,%edx
80107cfa:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107d00:	8a 90 a5 00 00 00    	mov    0xa5(%eax),%dl
80107d06:	83 e2 9f             	and    $0xffffff9f,%edx
80107d09:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107d0f:	8a 90 a5 00 00 00    	mov    0xa5(%eax),%dl
80107d15:	83 ca 80             	or     $0xffffff80,%edx
80107d18:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107d1e:	8a 90 a6 00 00 00    	mov    0xa6(%eax),%dl
80107d24:	83 e2 f0             	and    $0xfffffff0,%edx
80107d27:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107d2d:	8a 90 a6 00 00 00    	mov    0xa6(%eax),%dl
80107d33:	83 e2 ef             	and    $0xffffffef,%edx
80107d36:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107d3c:	8a 90 a6 00 00 00    	mov    0xa6(%eax),%dl
80107d42:	83 e2 df             	and    $0xffffffdf,%edx
80107d45:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107d4b:	8a 90 a6 00 00 00    	mov    0xa6(%eax),%dl
80107d51:	83 ca 40             	or     $0x40,%edx
80107d54:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107d5a:	8a 90 a6 00 00 00    	mov    0xa6(%eax),%dl
80107d60:	83 e2 7f             	and    $0x7f,%edx
80107d63:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107d69:	88 88 a7 00 00 00    	mov    %cl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80107d6f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107d75:	8a 90 a5 00 00 00    	mov    0xa5(%eax),%dl
80107d7b:	83 e2 ef             	and    $0xffffffef,%edx
80107d7e:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80107d84:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107d8a:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80107d90:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107d96:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80107d9d:	8b 52 08             	mov    0x8(%edx),%edx
80107da0:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107da6:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
80107da9:	83 ec 0c             	sub    $0xc,%esp
80107dac:	6a 30                	push   $0x30
80107dae:	e8 26 f8 ff ff       	call   801075d9 <ltr>
80107db3:	83 c4 10             	add    $0x10,%esp
  if(p->pgdir == 0)
80107db6:	8b 45 08             	mov    0x8(%ebp),%eax
80107db9:	8b 40 04             	mov    0x4(%eax),%eax
80107dbc:	85 c0                	test   %eax,%eax
80107dbe:	75 0d                	jne    80107dcd <switchuvm+0x13c>
    panic("switchuvm: no pgdir");
80107dc0:	83 ec 0c             	sub    $0xc,%esp
80107dc3:	68 cf 89 10 80       	push   $0x801089cf
80107dc8:	e8 81 87 ff ff       	call   8010054e <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
80107dcd:	8b 45 08             	mov    0x8(%ebp),%eax
80107dd0:	8b 40 04             	mov    0x4(%eax),%eax
80107dd3:	83 ec 0c             	sub    $0xc,%esp
80107dd6:	50                   	push   %eax
80107dd7:	e8 31 f8 ff ff       	call   8010760d <v2p>
80107ddc:	83 c4 10             	add    $0x10,%esp
80107ddf:	83 ec 0c             	sub    $0xc,%esp
80107de2:	50                   	push   %eax
80107de3:	e8 1a f8 ff ff       	call   80107602 <lcr3>
80107de8:	83 c4 10             	add    $0x10,%esp
  popcli();
80107deb:	e8 f4 d2 ff ff       	call   801050e4 <popcli>
}
80107df0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107df3:	c9                   	leave  
80107df4:	c3                   	ret    

80107df5 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107df5:	55                   	push   %ebp
80107df6:	89 e5                	mov    %esp,%ebp
80107df8:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  
  if(sz >= PGSIZE)
80107dfb:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80107e02:	76 0d                	jbe    80107e11 <inituvm+0x1c>
    panic("inituvm: more than a page");
80107e04:	83 ec 0c             	sub    $0xc,%esp
80107e07:	68 e3 89 10 80       	push   $0x801089e3
80107e0c:	e8 3d 87 ff ff       	call   8010054e <panic>
  mem = kalloc();
80107e11:	e8 97 ad ff ff       	call   80102bad <kalloc>
80107e16:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
80107e19:	83 ec 04             	sub    $0x4,%esp
80107e1c:	68 00 10 00 00       	push   $0x1000
80107e21:	6a 00                	push   $0x0
80107e23:	ff 75 f4             	pushl  -0xc(%ebp)
80107e26:	e8 75 d3 ff ff       	call   801051a0 <memset>
80107e2b:	83 c4 10             	add    $0x10,%esp
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
80107e2e:	83 ec 0c             	sub    $0xc,%esp
80107e31:	ff 75 f4             	pushl  -0xc(%ebp)
80107e34:	e8 d4 f7 ff ff       	call   8010760d <v2p>
80107e39:	83 c4 10             	add    $0x10,%esp
80107e3c:	83 ec 0c             	sub    $0xc,%esp
80107e3f:	6a 06                	push   $0x6
80107e41:	50                   	push   %eax
80107e42:	68 00 10 00 00       	push   $0x1000
80107e47:	6a 00                	push   $0x0
80107e49:	ff 75 08             	pushl  0x8(%ebp)
80107e4c:	e8 cb fc ff ff       	call   80107b1c <mappages>
80107e51:	83 c4 20             	add    $0x20,%esp
  memmove(mem, init, sz);
80107e54:	83 ec 04             	sub    $0x4,%esp
80107e57:	ff 75 10             	pushl  0x10(%ebp)
80107e5a:	ff 75 0c             	pushl  0xc(%ebp)
80107e5d:	ff 75 f4             	pushl  -0xc(%ebp)
80107e60:	e8 f4 d3 ff ff       	call   80105259 <memmove>
80107e65:	83 c4 10             	add    $0x10,%esp
}
80107e68:	c9                   	leave  
80107e69:	c3                   	ret    

80107e6a <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80107e6a:	55                   	push   %ebp
80107e6b:	89 e5                	mov    %esp,%ebp
80107e6d:	53                   	push   %ebx
80107e6e:	83 ec 14             	sub    $0x14,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80107e71:	8b 45 0c             	mov    0xc(%ebp),%eax
80107e74:	25 ff 0f 00 00       	and    $0xfff,%eax
80107e79:	85 c0                	test   %eax,%eax
80107e7b:	74 0d                	je     80107e8a <loaduvm+0x20>
    panic("loaduvm: addr must be page aligned");
80107e7d:	83 ec 0c             	sub    $0xc,%esp
80107e80:	68 00 8a 10 80       	push   $0x80108a00
80107e85:	e8 c4 86 ff ff       	call   8010054e <panic>
  for(i = 0; i < sz; i += PGSIZE){
80107e8a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107e91:	e9 95 00 00 00       	jmp    80107f2b <loaduvm+0xc1>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107e96:	8b 55 0c             	mov    0xc(%ebp),%edx
80107e99:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e9c:	01 d0                	add    %edx,%eax
80107e9e:	83 ec 04             	sub    $0x4,%esp
80107ea1:	6a 00                	push   $0x0
80107ea3:	50                   	push   %eax
80107ea4:	ff 75 08             	pushl  0x8(%ebp)
80107ea7:	e8 d0 fb ff ff       	call   80107a7c <walkpgdir>
80107eac:	83 c4 10             	add    $0x10,%esp
80107eaf:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107eb2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107eb6:	75 0d                	jne    80107ec5 <loaduvm+0x5b>
      panic("loaduvm: address should exist");
80107eb8:	83 ec 0c             	sub    $0xc,%esp
80107ebb:	68 23 8a 10 80       	push   $0x80108a23
80107ec0:	e8 89 86 ff ff       	call   8010054e <panic>
    pa = PTE_ADDR(*pte);
80107ec5:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107ec8:	8b 00                	mov    (%eax),%eax
80107eca:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ecf:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
80107ed2:	8b 45 18             	mov    0x18(%ebp),%eax
80107ed5:	2b 45 f4             	sub    -0xc(%ebp),%eax
80107ed8:	3d ff 0f 00 00       	cmp    $0xfff,%eax
80107edd:	77 0b                	ja     80107eea <loaduvm+0x80>
      n = sz - i;
80107edf:	8b 45 18             	mov    0x18(%ebp),%eax
80107ee2:	2b 45 f4             	sub    -0xc(%ebp),%eax
80107ee5:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107ee8:	eb 07                	jmp    80107ef1 <loaduvm+0x87>
    else
      n = PGSIZE;
80107eea:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
80107ef1:	8b 55 14             	mov    0x14(%ebp),%edx
80107ef4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ef7:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80107efa:	83 ec 0c             	sub    $0xc,%esp
80107efd:	ff 75 e8             	pushl  -0x18(%ebp)
80107f00:	e8 15 f7 ff ff       	call   8010761a <p2v>
80107f05:	83 c4 10             	add    $0x10,%esp
80107f08:	ff 75 f0             	pushl  -0x10(%ebp)
80107f0b:	53                   	push   %ebx
80107f0c:	50                   	push   %eax
80107f0d:	ff 75 10             	pushl  0x10(%ebp)
80107f10:	e8 28 9f ff ff       	call   80101e3d <readi>
80107f15:	83 c4 10             	add    $0x10,%esp
80107f18:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107f1b:	74 07                	je     80107f24 <loaduvm+0xba>
      return -1;
80107f1d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107f22:	eb 18                	jmp    80107f3c <loaduvm+0xd2>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80107f24:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107f2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f2e:	3b 45 18             	cmp    0x18(%ebp),%eax
80107f31:	0f 82 5f ff ff ff    	jb     80107e96 <loaduvm+0x2c>
    else
      n = PGSIZE;
    if(readi(ip, p2v(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80107f37:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107f3c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107f3f:	c9                   	leave  
80107f40:	c3                   	ret    

80107f41 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107f41:	55                   	push   %ebp
80107f42:	89 e5                	mov    %esp,%ebp
80107f44:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80107f47:	8b 45 10             	mov    0x10(%ebp),%eax
80107f4a:	85 c0                	test   %eax,%eax
80107f4c:	79 0a                	jns    80107f58 <allocuvm+0x17>
    return 0;
80107f4e:	b8 00 00 00 00       	mov    $0x0,%eax
80107f53:	e9 ae 00 00 00       	jmp    80108006 <allocuvm+0xc5>
  if(newsz < oldsz)
80107f58:	8b 45 10             	mov    0x10(%ebp),%eax
80107f5b:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107f5e:	73 08                	jae    80107f68 <allocuvm+0x27>
    return oldsz;
80107f60:	8b 45 0c             	mov    0xc(%ebp),%eax
80107f63:	e9 9e 00 00 00       	jmp    80108006 <allocuvm+0xc5>

  a = PGROUNDUP(oldsz);
80107f68:	8b 45 0c             	mov    0xc(%ebp),%eax
80107f6b:	05 ff 0f 00 00       	add    $0xfff,%eax
80107f70:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107f75:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
80107f78:	eb 7d                	jmp    80107ff7 <allocuvm+0xb6>
    mem = kalloc();
80107f7a:	e8 2e ac ff ff       	call   80102bad <kalloc>
80107f7f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
80107f82:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107f86:	75 2b                	jne    80107fb3 <allocuvm+0x72>
      cprintf("allocuvm out of memory\n");
80107f88:	83 ec 0c             	sub    $0xc,%esp
80107f8b:	68 41 8a 10 80       	push   $0x80108a41
80107f90:	e8 23 84 ff ff       	call   801003b8 <cprintf>
80107f95:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
80107f98:	83 ec 04             	sub    $0x4,%esp
80107f9b:	ff 75 0c             	pushl  0xc(%ebp)
80107f9e:	ff 75 10             	pushl  0x10(%ebp)
80107fa1:	ff 75 08             	pushl  0x8(%ebp)
80107fa4:	e8 5f 00 00 00       	call   80108008 <deallocuvm>
80107fa9:	83 c4 10             	add    $0x10,%esp
      return 0;
80107fac:	b8 00 00 00 00       	mov    $0x0,%eax
80107fb1:	eb 53                	jmp    80108006 <allocuvm+0xc5>
    }
    memset(mem, 0, PGSIZE);
80107fb3:	83 ec 04             	sub    $0x4,%esp
80107fb6:	68 00 10 00 00       	push   $0x1000
80107fbb:	6a 00                	push   $0x0
80107fbd:	ff 75 f0             	pushl  -0x10(%ebp)
80107fc0:	e8 db d1 ff ff       	call   801051a0 <memset>
80107fc5:	83 c4 10             	add    $0x10,%esp
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
80107fc8:	83 ec 0c             	sub    $0xc,%esp
80107fcb:	ff 75 f0             	pushl  -0x10(%ebp)
80107fce:	e8 3a f6 ff ff       	call   8010760d <v2p>
80107fd3:	83 c4 10             	add    $0x10,%esp
80107fd6:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107fd9:	83 ec 0c             	sub    $0xc,%esp
80107fdc:	6a 06                	push   $0x6
80107fde:	50                   	push   %eax
80107fdf:	68 00 10 00 00       	push   $0x1000
80107fe4:	52                   	push   %edx
80107fe5:	ff 75 08             	pushl  0x8(%ebp)
80107fe8:	e8 2f fb ff ff       	call   80107b1c <mappages>
80107fed:	83 c4 20             	add    $0x20,%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80107ff0:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107ff7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ffa:	3b 45 10             	cmp    0x10(%ebp),%eax
80107ffd:	0f 82 77 ff ff ff    	jb     80107f7a <allocuvm+0x39>
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
  }
  return newsz;
80108003:	8b 45 10             	mov    0x10(%ebp),%eax
}
80108006:	c9                   	leave  
80108007:	c3                   	ret    

80108008 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80108008:	55                   	push   %ebp
80108009:	89 e5                	mov    %esp,%ebp
8010800b:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
8010800e:	8b 45 10             	mov    0x10(%ebp),%eax
80108011:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108014:	72 08                	jb     8010801e <deallocuvm+0x16>
    return oldsz;
80108016:	8b 45 0c             	mov    0xc(%ebp),%eax
80108019:	e9 a5 00 00 00       	jmp    801080c3 <deallocuvm+0xbb>

  a = PGROUNDUP(newsz);
8010801e:	8b 45 10             	mov    0x10(%ebp),%eax
80108021:	05 ff 0f 00 00       	add    $0xfff,%eax
80108026:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010802b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010802e:	e9 81 00 00 00       	jmp    801080b4 <deallocuvm+0xac>
    pte = walkpgdir(pgdir, (char*)a, 0);
80108033:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108036:	83 ec 04             	sub    $0x4,%esp
80108039:	6a 00                	push   $0x0
8010803b:	50                   	push   %eax
8010803c:	ff 75 08             	pushl  0x8(%ebp)
8010803f:	e8 38 fa ff ff       	call   80107a7c <walkpgdir>
80108044:	83 c4 10             	add    $0x10,%esp
80108047:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
8010804a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010804e:	75 09                	jne    80108059 <deallocuvm+0x51>
      a += (NPTENTRIES - 1) * PGSIZE;
80108050:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
80108057:	eb 54                	jmp    801080ad <deallocuvm+0xa5>
    else if((*pte & PTE_P) != 0){
80108059:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010805c:	8b 00                	mov    (%eax),%eax
8010805e:	83 e0 01             	and    $0x1,%eax
80108061:	85 c0                	test   %eax,%eax
80108063:	74 48                	je     801080ad <deallocuvm+0xa5>
      pa = PTE_ADDR(*pte);
80108065:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108068:	8b 00                	mov    (%eax),%eax
8010806a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010806f:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
80108072:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108076:	75 0d                	jne    80108085 <deallocuvm+0x7d>
        panic("kfree");
80108078:	83 ec 0c             	sub    $0xc,%esp
8010807b:	68 59 8a 10 80       	push   $0x80108a59
80108080:	e8 c9 84 ff ff       	call   8010054e <panic>
      char *v = p2v(pa);
80108085:	83 ec 0c             	sub    $0xc,%esp
80108088:	ff 75 ec             	pushl  -0x14(%ebp)
8010808b:	e8 8a f5 ff ff       	call   8010761a <p2v>
80108090:	83 c4 10             	add    $0x10,%esp
80108093:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
80108096:	83 ec 0c             	sub    $0xc,%esp
80108099:	ff 75 e8             	pushl  -0x18(%ebp)
8010809c:	e8 70 aa ff ff       	call   80102b11 <kfree>
801080a1:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
801080a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801080a7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801080ad:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801080b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080b7:	3b 45 0c             	cmp    0xc(%ebp),%eax
801080ba:	0f 82 73 ff ff ff    	jb     80108033 <deallocuvm+0x2b>
      char *v = p2v(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
801080c0:	8b 45 10             	mov    0x10(%ebp),%eax
}
801080c3:	c9                   	leave  
801080c4:	c3                   	ret    

801080c5 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801080c5:	55                   	push   %ebp
801080c6:	89 e5                	mov    %esp,%ebp
801080c8:	83 ec 18             	sub    $0x18,%esp
  uint i;

  if(pgdir == 0)
801080cb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801080cf:	75 0d                	jne    801080de <freevm+0x19>
    panic("freevm: no pgdir");
801080d1:	83 ec 0c             	sub    $0xc,%esp
801080d4:	68 5f 8a 10 80       	push   $0x80108a5f
801080d9:	e8 70 84 ff ff       	call   8010054e <panic>
  deallocuvm(pgdir, KERNBASE, 0);
801080de:	83 ec 04             	sub    $0x4,%esp
801080e1:	6a 00                	push   $0x0
801080e3:	68 00 00 00 80       	push   $0x80000000
801080e8:	ff 75 08             	pushl  0x8(%ebp)
801080eb:	e8 18 ff ff ff       	call   80108008 <deallocuvm>
801080f0:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801080f3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801080fa:	eb 4e                	jmp    8010814a <freevm+0x85>
    if(pgdir[i] & PTE_P){
801080fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080ff:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108106:	8b 45 08             	mov    0x8(%ebp),%eax
80108109:	01 d0                	add    %edx,%eax
8010810b:	8b 00                	mov    (%eax),%eax
8010810d:	83 e0 01             	and    $0x1,%eax
80108110:	85 c0                	test   %eax,%eax
80108112:	74 33                	je     80108147 <freevm+0x82>
      char * v = p2v(PTE_ADDR(pgdir[i]));
80108114:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108117:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010811e:	8b 45 08             	mov    0x8(%ebp),%eax
80108121:	01 d0                	add    %edx,%eax
80108123:	8b 00                	mov    (%eax),%eax
80108125:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010812a:	83 ec 0c             	sub    $0xc,%esp
8010812d:	50                   	push   %eax
8010812e:	e8 e7 f4 ff ff       	call   8010761a <p2v>
80108133:	83 c4 10             	add    $0x10,%esp
80108136:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
80108139:	83 ec 0c             	sub    $0xc,%esp
8010813c:	ff 75 f0             	pushl  -0x10(%ebp)
8010813f:	e8 cd a9 ff ff       	call   80102b11 <kfree>
80108144:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108147:	ff 45 f4             	incl   -0xc(%ebp)
8010814a:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
80108151:	76 a9                	jbe    801080fc <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = p2v(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80108153:	83 ec 0c             	sub    $0xc,%esp
80108156:	ff 75 08             	pushl  0x8(%ebp)
80108159:	e8 b3 a9 ff ff       	call   80102b11 <kfree>
8010815e:	83 c4 10             	add    $0x10,%esp
}
80108161:	c9                   	leave  
80108162:	c3                   	ret    

80108163 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108163:	55                   	push   %ebp
80108164:	89 e5                	mov    %esp,%ebp
80108166:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108169:	83 ec 04             	sub    $0x4,%esp
8010816c:	6a 00                	push   $0x0
8010816e:	ff 75 0c             	pushl  0xc(%ebp)
80108171:	ff 75 08             	pushl  0x8(%ebp)
80108174:	e8 03 f9 ff ff       	call   80107a7c <walkpgdir>
80108179:	83 c4 10             	add    $0x10,%esp
8010817c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
8010817f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80108183:	75 0d                	jne    80108192 <clearpteu+0x2f>
    panic("clearpteu");
80108185:	83 ec 0c             	sub    $0xc,%esp
80108188:	68 70 8a 10 80       	push   $0x80108a70
8010818d:	e8 bc 83 ff ff       	call   8010054e <panic>
  *pte &= ~PTE_U;
80108192:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108195:	8b 00                	mov    (%eax),%eax
80108197:	83 e0 fb             	and    $0xfffffffb,%eax
8010819a:	89 c2                	mov    %eax,%edx
8010819c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010819f:	89 10                	mov    %edx,(%eax)
}
801081a1:	c9                   	leave  
801081a2:	c3                   	ret    

801081a3 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801081a3:	55                   	push   %ebp
801081a4:	89 e5                	mov    %esp,%ebp
801081a6:	53                   	push   %ebx
801081a7:	83 ec 24             	sub    $0x24,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801081aa:	e8 fd f9 ff ff       	call   80107bac <setupkvm>
801081af:	89 45 f0             	mov    %eax,-0x10(%ebp)
801081b2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801081b6:	75 0a                	jne    801081c2 <copyuvm+0x1f>
    return 0;
801081b8:	b8 00 00 00 00       	mov    $0x0,%eax
801081bd:	e9 f6 00 00 00       	jmp    801082b8 <copyuvm+0x115>
  for(i = 0; i < sz; i += PGSIZE){
801081c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801081c9:	e9 c6 00 00 00       	jmp    80108294 <copyuvm+0xf1>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801081ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081d1:	83 ec 04             	sub    $0x4,%esp
801081d4:	6a 00                	push   $0x0
801081d6:	50                   	push   %eax
801081d7:	ff 75 08             	pushl  0x8(%ebp)
801081da:	e8 9d f8 ff ff       	call   80107a7c <walkpgdir>
801081df:	83 c4 10             	add    $0x10,%esp
801081e2:	89 45 ec             	mov    %eax,-0x14(%ebp)
801081e5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801081e9:	75 0d                	jne    801081f8 <copyuvm+0x55>
      panic("copyuvm: pte should exist");
801081eb:	83 ec 0c             	sub    $0xc,%esp
801081ee:	68 7a 8a 10 80       	push   $0x80108a7a
801081f3:	e8 56 83 ff ff       	call   8010054e <panic>
    if(!(*pte & PTE_P))
801081f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801081fb:	8b 00                	mov    (%eax),%eax
801081fd:	83 e0 01             	and    $0x1,%eax
80108200:	85 c0                	test   %eax,%eax
80108202:	75 0d                	jne    80108211 <copyuvm+0x6e>
      panic("copyuvm: page not present");
80108204:	83 ec 0c             	sub    $0xc,%esp
80108207:	68 94 8a 10 80       	push   $0x80108a94
8010820c:	e8 3d 83 ff ff       	call   8010054e <panic>
    pa = PTE_ADDR(*pte);
80108211:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108214:	8b 00                	mov    (%eax),%eax
80108216:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010821b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    flags = PTE_FLAGS(*pte);
8010821e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108221:	8b 00                	mov    (%eax),%eax
80108223:	25 ff 0f 00 00       	and    $0xfff,%eax
80108228:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
8010822b:	e8 7d a9 ff ff       	call   80102bad <kalloc>
80108230:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108233:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80108237:	75 02                	jne    8010823b <copyuvm+0x98>
      goto bad;
80108239:	eb 6a                	jmp    801082a5 <copyuvm+0x102>
    memmove(mem, (char*)p2v(pa), PGSIZE);
8010823b:	83 ec 0c             	sub    $0xc,%esp
8010823e:	ff 75 e8             	pushl  -0x18(%ebp)
80108241:	e8 d4 f3 ff ff       	call   8010761a <p2v>
80108246:	83 c4 10             	add    $0x10,%esp
80108249:	83 ec 04             	sub    $0x4,%esp
8010824c:	68 00 10 00 00       	push   $0x1000
80108251:	50                   	push   %eax
80108252:	ff 75 e0             	pushl  -0x20(%ebp)
80108255:	e8 ff cf ff ff       	call   80105259 <memmove>
8010825a:	83 c4 10             	add    $0x10,%esp
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
8010825d:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80108260:	83 ec 0c             	sub    $0xc,%esp
80108263:	ff 75 e0             	pushl  -0x20(%ebp)
80108266:	e8 a2 f3 ff ff       	call   8010760d <v2p>
8010826b:	83 c4 10             	add    $0x10,%esp
8010826e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108271:	83 ec 0c             	sub    $0xc,%esp
80108274:	53                   	push   %ebx
80108275:	50                   	push   %eax
80108276:	68 00 10 00 00       	push   $0x1000
8010827b:	52                   	push   %edx
8010827c:	ff 75 f0             	pushl  -0x10(%ebp)
8010827f:	e8 98 f8 ff ff       	call   80107b1c <mappages>
80108284:	83 c4 20             	add    $0x20,%esp
80108287:	85 c0                	test   %eax,%eax
80108289:	79 02                	jns    8010828d <copyuvm+0xea>
      goto bad;
8010828b:	eb 18                	jmp    801082a5 <copyuvm+0x102>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010828d:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108294:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108297:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010829a:	0f 82 2e ff ff ff    	jb     801081ce <copyuvm+0x2b>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
      goto bad;
  }
  return d;
801082a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801082a3:	eb 13                	jmp    801082b8 <copyuvm+0x115>

bad:
  freevm(d);
801082a5:	83 ec 0c             	sub    $0xc,%esp
801082a8:	ff 75 f0             	pushl  -0x10(%ebp)
801082ab:	e8 15 fe ff ff       	call   801080c5 <freevm>
801082b0:	83 c4 10             	add    $0x10,%esp
  return 0;
801082b3:	b8 00 00 00 00       	mov    $0x0,%eax
}
801082b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801082bb:	c9                   	leave  
801082bc:	c3                   	ret    

801082bd <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801082bd:	55                   	push   %ebp
801082be:	89 e5                	mov    %esp,%ebp
801082c0:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801082c3:	83 ec 04             	sub    $0x4,%esp
801082c6:	6a 00                	push   $0x0
801082c8:	ff 75 0c             	pushl  0xc(%ebp)
801082cb:	ff 75 08             	pushl  0x8(%ebp)
801082ce:	e8 a9 f7 ff ff       	call   80107a7c <walkpgdir>
801082d3:	83 c4 10             	add    $0x10,%esp
801082d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
801082d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082dc:	8b 00                	mov    (%eax),%eax
801082de:	83 e0 01             	and    $0x1,%eax
801082e1:	85 c0                	test   %eax,%eax
801082e3:	75 07                	jne    801082ec <uva2ka+0x2f>
    return 0;
801082e5:	b8 00 00 00 00       	mov    $0x0,%eax
801082ea:	eb 29                	jmp    80108315 <uva2ka+0x58>
  if((*pte & PTE_U) == 0)
801082ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082ef:	8b 00                	mov    (%eax),%eax
801082f1:	83 e0 04             	and    $0x4,%eax
801082f4:	85 c0                	test   %eax,%eax
801082f6:	75 07                	jne    801082ff <uva2ka+0x42>
    return 0;
801082f8:	b8 00 00 00 00       	mov    $0x0,%eax
801082fd:	eb 16                	jmp    80108315 <uva2ka+0x58>
  return (char*)p2v(PTE_ADDR(*pte));
801082ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108302:	8b 00                	mov    (%eax),%eax
80108304:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108309:	83 ec 0c             	sub    $0xc,%esp
8010830c:	50                   	push   %eax
8010830d:	e8 08 f3 ff ff       	call   8010761a <p2v>
80108312:	83 c4 10             	add    $0x10,%esp
}
80108315:	c9                   	leave  
80108316:	c3                   	ret    

80108317 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108317:	55                   	push   %ebp
80108318:	89 e5                	mov    %esp,%ebp
8010831a:	83 ec 18             	sub    $0x18,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
8010831d:	8b 45 10             	mov    0x10(%ebp),%eax
80108320:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
80108323:	eb 7f                	jmp    801083a4 <copyout+0x8d>
    va0 = (uint)PGROUNDDOWN(va);
80108325:	8b 45 0c             	mov    0xc(%ebp),%eax
80108328:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010832d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80108330:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108333:	83 ec 08             	sub    $0x8,%esp
80108336:	50                   	push   %eax
80108337:	ff 75 08             	pushl  0x8(%ebp)
8010833a:	e8 7e ff ff ff       	call   801082bd <uva2ka>
8010833f:	83 c4 10             	add    $0x10,%esp
80108342:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
80108345:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80108349:	75 07                	jne    80108352 <copyout+0x3b>
      return -1;
8010834b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108350:	eb 61                	jmp    801083b3 <copyout+0x9c>
    n = PGSIZE - (va - va0);
80108352:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108355:	2b 45 0c             	sub    0xc(%ebp),%eax
80108358:	05 00 10 00 00       	add    $0x1000,%eax
8010835d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
80108360:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108363:	3b 45 14             	cmp    0x14(%ebp),%eax
80108366:	76 06                	jbe    8010836e <copyout+0x57>
      n = len;
80108368:	8b 45 14             	mov    0x14(%ebp),%eax
8010836b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
8010836e:	8b 45 0c             	mov    0xc(%ebp),%eax
80108371:	2b 45 ec             	sub    -0x14(%ebp),%eax
80108374:	89 c2                	mov    %eax,%edx
80108376:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108379:	01 d0                	add    %edx,%eax
8010837b:	83 ec 04             	sub    $0x4,%esp
8010837e:	ff 75 f0             	pushl  -0x10(%ebp)
80108381:	ff 75 f4             	pushl  -0xc(%ebp)
80108384:	50                   	push   %eax
80108385:	e8 cf ce ff ff       	call   80105259 <memmove>
8010838a:	83 c4 10             	add    $0x10,%esp
    len -= n;
8010838d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108390:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
80108393:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108396:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
80108399:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010839c:	05 00 10 00 00       	add    $0x1000,%eax
801083a1:	89 45 0c             	mov    %eax,0xc(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801083a4:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
801083a8:	0f 85 77 ff ff ff    	jne    80108325 <copyout+0xe>
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
801083ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
801083b3:	c9                   	leave  
801083b4:	c3                   	ret    
