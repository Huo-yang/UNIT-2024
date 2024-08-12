#include <Inc/main.h>

int get_localip(const char * eth_name, char *local_ip_addr){
    int ret = -1;
    register int fd;
    struct ifreq ifr;

    if(local_ip_addr == NULL || eth_name == NULL){
        return ret;
    }
    if ((fd=socket(AF_INET, SOCK_DGRAM, 0)) > 0){
        strcpy(ifr.ifr_name, eth_name);
        if (!(ioctl(fd, SIOCGIFADDR, &ifr))){
            ret = 0;
            strcpy(local_ip_addr, inet_ntoa(((struct sockaddr_in *)&ifr.ifr_addr)->sin_addr));
        }
    }
    if (fd > 0){
        close(fd);
    }
    return ret;
}

int main ( int argc, char* argv[])
{
    struct tms timeSample;
    clock_t startTime = times(&timeSample);
    int ret;
    char local_ip[20] = {0};
    ret = get_localip("eth0", local_ip);
    if (ret == 0){
        printf("[main] local ip:%s\n", local_ip);
    }
    else{
        printf("[main] get local ip failure\n");
    }
    const char* found = strstr(local_ip, "192.168");
    if (found != nullptr) ip_status = 1;
    else ip_status = 0;
    // 线程id
	pthread_t tids[NUM_THREADS];
	// 显示线程
	pthread_create(&tids[0], NULL, ui_display, NULL);
	// 键值线程
	pthread_create(&tids[1], NULL, UartKeyBoard, NULL);
	// 触屏线程
	pthread_create(&tids[2], NULL, touch_screen_read, NULL);
	while(1){
	    clock_t endTime = times(&timeSample);
        elapsedTime = (endTime - startTime) / sysconf(_SC_CLK_TCK);

        ret = get_localip("eth0", local_ip);
        if (ret == 1){
            printf("[main] get local ip failure\n");
        }
        found = strstr(local_ip, "192.168");
        if (found != nullptr) ip_status = 1;
            else ip_status = 0;
        sleep(1);
	}
	// 终止主线程
	pthread_exit(NULL);
	return (0);
}
