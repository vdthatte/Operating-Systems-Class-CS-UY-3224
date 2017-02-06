#include "types.h"
#include "stat.h"
#include "user.h"

char buf[512];

int
countlines(int fd, char *name)
{
  int i, n;
  int l, c;

  l = c = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n'){
        l++;
      }
    }
  }
  if(n < 0){
    printf(1, "tail: read error\n");
    exit();
  }
  return l;
}

int
pc(int fd, char *name, int numberOfLines, int num)
{
  int i, n;
  int l;


  l = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      if(buf[i] == '\n'){
        if(l > (numberOfLines - num)){
          printf(1, "\n", buf[i]);
        }
      l++;
      }
      else{
        if(l > (numberOfLines - num)){
          printf(1, "%c", buf[i]);
        }
      }
      
    }
  }
  if(n < 0){
    printf(1, "wc: read error\n");
    exit();
  }
  return l;
}

int
main(int argc, char *argv[])
{
  int fd1, fd;
  char num = atoi("10");
  int filePos = 1;

  if(argc <= 1){
    countlines(0, "");
    exit();
  }
  
  if(argc == 3){
    if(argv[2][0] == '-'){
      num = atoi(&(argv[2][1]));
      filePos = 1;
    }
    if(argv[1][0] == '-'){
      num = atoi(&(argv[1][1]));
      filePos = 2;
    }
  }

  if((fd = open(argv[filePos], 0)) < 0){
    printf(1, "tail: cannot open %s\n", argv[filePos]);
    exit();
  }
  if((fd1 = open(argv[filePos], 0)) < 0){
    printf(1, "tail: cannot open %s\n", argv[filePos]);
    exit();
  }
  int numOfL = countlines(fd, argv[filePos]);
  printf(1, "%d\n",pc(fd1, argv[filePos], numOfL, num));
  close(fd1);
  close(fd);
      
     
  
  exit();
}