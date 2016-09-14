#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include<stdio.h>

#include<errno.h>
#include<stdlib.h>

int main(void)
{
    struct sockaddr_in local;
    int s;
    int sl;
    int rc;
    char buff[2];

    local.sin_family = AF_INET;
    local.sin_port = htons(7500);
    local.sin_addr.s_addr = htonl(INADDR_ANY);
    s = socket(AF_INET, SOCK_STREAM, 0);
    if(s<0)
    {
        printf("[E] socket create faile %d\n", errno);
        exit(-1);
    }
    rc = bind(s, (struct sockaddr*) &local, sizeof(local));
    if(rc < 0)
    {
        printf("[E] bind failed %d\n", errno);
        exit(-1);
    }

    rc = listen(s, 5);
    if(rc)
    {
        printf("[E] listen failed %d\n", errno);
        exit(-1);
    }

    while(1){
    sl = accept(s, NULL, NULL);
    if(sl < 0)
    {
        printf("[E] accept failed %d\n", errno);
        exit(-1);
    }
    
    rc = recv(sl, buff, 1, 0);
    if(rc < 0)
    {
        printf("[E] recv failed %d\n", errno);
        exit(-1);
    }
    rc = send(sl, "2", 1, 0);
    if(rc <= 0)
    {
        printf("[E] send failed %d\n", errno);
        exit(-1);
    }

    }

    return 0;

    
    

}

    
