#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include<arpa/inet.h>
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<errno.h>

#define CREATE 1
#define USED 2
#define UNUSED 3
typedef struct _sockinfo{
    int sock;
    unsigned int flag;
}sockinfo;

typedef struct _connect_pool{
    sockinfo sockt[5];
}connect_pool;

int close_pool(connect_pool ptr[]);
int main(void){
    struct sockaddr_in peer;
    connect_pool pool;
    int s;
    int rc;
    char buf[2];
    int i = 0;

    peer.sin_family = AF_INET;
    peer.sin_port = htons(7500);
    peer.sin_addr.s_addr = inet_addr("127.0.0.1");
    while(i++ < 5){
        s = socket(AF_INET, SOCK_STREAM, 0);

        if(s < 0)
        {
            printf("[E] socket call failed\n");
            exit(-1);
        }

        rc = connect(s, (struct sockaddr*) &peer, sizeof(peer));
        if(rc)
        {

            printf("[E] connect call failed:%d\n", errno);
            exit(-1);
        }
        pool.sockt[i].sock = s;
        pool.sockt[i].flag= CREATE;
    }
    while(1)
    {
        sleep(5);
    }
    close_pool(&pool);

    return 0;
}

int close_pool(connect_pool* ptr_pool){
    int i = 0;

    while(i++ < 5)
    {
        if(ptr_pool->sockt[i].flag == CREATE)
            close(ptr_pool->sockt[i].sock);
    }
    return 0;
}
