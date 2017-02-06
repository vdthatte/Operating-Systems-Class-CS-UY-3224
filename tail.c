#include "types.h"
#include "stat.h"
#include "user.h"

char buf[512];

int
wc(int fd, char *name)
{
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
        inword = 0;
      else if(!inword){
        w++;
        inword = 1;
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
pc(int fd, char *name, int numberOfLines)
{
  int i, n;
  int l;


  l = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      if(buf[i] == '\n'){
      	if(l > (numberOfLines - 10)){
      		printf(1, "\n", buf[i]);
      	}
   		l++;
      }
      else{
      	if(l > (numberOfLines - 10)){
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
  int fd1, fd, i;

  if(argc <= 1){
  	wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    if((fd1 = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    int numOfL = wc(fd, argv[i]);
    printf(1, "%d\n",pc(fd1, argv[i], numOfL));
    close(fd1);
    close(fd);
  }
  exit();
}